"""
重新打包并签名 APK（本地私服）。

- 遍历 <replace_dir> 下的文件，按其相对路径替换 APK 内的同名条目
- 同步更新 assets/plist.txt 中被替换文件的 MD5 与大小
- 剔除旧签名，做 JAR v1 签名（SHA1 摘要 + 无 SMIMECapabilities 属性）

用法: python build_apk.py <原始apk> <replace_dir> <输出apk> [--reuse-cert]
"""
import argparse
import os, zipfile, hashlib, base64, datetime
from pathlib import Path

from cryptography import x509
from cryptography.x509.oid import NameOID
from cryptography.hazmat.primitives import hashes, serialization
from cryptography.hazmat.primitives.asymmetric import rsa
from cryptography.hazmat.primitives.serialization import pkcs7

PLIST = "assets/plist.txt"
KEYSTORE = Path(__file__).resolve().with_name("signing_key.pem")


def md5_upper(b):
    return hashlib.md5(b).hexdigest().upper()


def wrap_line(b):
    if len(b) <= 70:
        return b
    out = b[:70]
    rest = b[70:]
    while rest:
        out += b"\r\n " + rest[:69]
        rest = rest[69:]
    return out


def main_attrs():
    return b"Manifest-Version: 1.0\r\nCreated-By: 1.0 (LXH-local)\r\n"


def build_manifest(entries):
    buf = main_attrs() + b"\r\n"
    for name, data in entries:
        digest = base64.b64encode(hashlib.sha1(data).digest())
        buf += wrap_line(b"Name: " + name.encode("utf-8")) + b"\r\n"
        buf += wrap_line(b"SHA1-Digest: " + digest) + b"\r\n\r\n"
    return buf


def _section_bytes(name, file_digest_b64):
    return (wrap_line(b"Name: " + name.encode("utf-8")) + b"\r\n"
            + wrap_line(b"SHA1-Digest: " + file_digest_b64) + b"\r\n\r\n")


def build_sf(manifest_bytes, entries):
    idx = manifest_bytes.find(b"\r\n\r\n")
    main_sec = manifest_bytes[:idx + 4]
    out = b"Signature-Version: 1.0\r\n"
    out += b"SHA1-Digest-Manifest-Main-Attributes: " + base64.b64encode(hashlib.sha1(main_sec).digest()) + b"\r\n"
    out += b"SHA1-Digest-Manifest: " + base64.b64encode(hashlib.sha1(manifest_bytes).digest()) + b"\r\n"
    out += b"Created-By: 1.0 (LXH-local)\r\n\r\n"
    for name, data in entries:
        file_digest = base64.b64encode(hashlib.sha1(data).digest())
        section = _section_bytes(name, file_digest)
        out += wrap_line(b"Name: " + name.encode("utf-8")) + b"\r\n"
        out += wrap_line(b"SHA1-Digest: " + base64.b64encode(hashlib.sha1(section).digest())) + b"\r\n\r\n"
    return out


def load_or_make_key():
    if os.path.exists(KEYSTORE):
        key = serialization.load_pem_private_key(open(KEYSTORE, "rb").read(), None)
    else:
        key = rsa.generate_private_key(public_exponent=65537, key_size=2048)
        open(KEYSTORE, "wb").write(key.private_bytes(
            serialization.Encoding.PEM,
            serialization.PrivateFormat.PKCS8,
            serialization.NoEncryption()))
    name = x509.Name([x509.NameAttribute(NameOID.COMMON_NAME, "LXH Local")])
    now = datetime.datetime.now(datetime.timezone.utc)
    cert = (x509.CertificateBuilder()
            .subject_name(name).issuer_name(name)
            .public_key(key.public_key())
            .serial_number(x509.random_serial_number())
            .not_valid_before(now - datetime.timedelta(days=1))
            .not_valid_after(now + datetime.timedelta(days=3650))
            .sign(key, hashes.SHA256()))
    return key, cert


def main(src, replace_dir, out, *, reuse_cert=False, certificate=None):
    # 1. 收集替换文件（路径相对 replace_dir，如 assets/script/...）
    repl = {}
    for root, _, files in os.walk(replace_dir):
        for f in files:
            full = os.path.join(root, f)
            rel = os.path.relpath(full, replace_dir).replace("\\", "/")
            repl[rel] = open(full, "rb").read()
    print("replacing:", {k: len(v) for k, v in repl.items()})

    src_zip = zipfile.ZipFile(src)
    names = src_zip.namelist()
    infos = {i.filename: i for i in src_zip.infolist()}

    # 2. 更新 plist.txt
    newmap = {}
    for rel, data in repl.items():
        if rel.startswith("assets/"):
            newmap[rel[len("assets/"):].replace("/", "\\")] = (md5_upper(data), len(data))
    plist = src_zip.read(PLIST).decode("utf-8", "replace")
    out_lines, hit = [], set()
    for ln in plist.split("\n"):
        k = ln.split("\t")[0]
        if k in newmap:
            m, s = newmap[k]
            out_lines.append(f"{k}\t{m}\t{s}")
            hit.add(k)
        else:
            out_lines.append(ln)
    missing = set(newmap) - hit
    if missing:
        print(f"  (注：以下文件不在 plist.txt 中，跳过清单更新: {sorted(missing)})")
    plist_bytes = "\n".join(out_lines).encode("utf-8")
    for k, (m, s) in newmap.items():
        print(f"  plist: {k} -> {m} {s}")

    # 3. 收集条目（跳过旧签名），保留压缩方式
    entries = []
    for n in names:
        up = n.upper()
        if up.startswith("META-INF/") and (
                up.endswith(".SF") or up.endswith(".RSA") or up.endswith(".DSA")
                or up.endswith(".EC") or up == "META-INF/MANIFEST.MF"):
            continue
        if n == PLIST:
            data = plist_bytes
        elif n in repl:
            data = repl[n]
        else:
            data = src_zip.read(n)
        entries.append((n, data, infos[n].compress_type))

    # 4. 生成签名
    manifest = build_manifest([(n, d) for n, d, _ in entries])
    sf = build_sf(manifest, [(n, d) for n, d, _ in entries])
    key, cert = load_or_make_key()
    if reuse_cert or certificate:
        if certificate:
            certificates = [x509.load_der_x509_certificate(Path(certificate).read_bytes())]
        else:
            certificates = pkcs7.load_der_pkcs7_certificates(src_zip.read("META-INF/CERT.RSA"))
        if len(certificates) != 1 or certificates[0].public_key() != key.public_key():
            raise ValueError("Signing certificate does not match the local signing key")
        cert = certificates[0]
    rsa_sig = (pkcs7.PKCS7SignatureBuilder()
               .set_data(sf)
               .add_signer(cert, key, hashes.SHA256())
               .sign(serialization.Encoding.DER,
                     [pkcs7.PKCS7Options.DetachedSignature,
                      pkcs7.PKCS7Options.Binary,
                      pkcs7.PKCS7Options.NoCapabilities]))

    # 5. 写出
    with zipfile.ZipFile(out, "w") as z:
        for n, data, ctype in entries:
            z.writestr(n, data, compress_type=ctype)
        z.writestr("META-INF/MANIFEST.MF", manifest)
        z.writestr("META-INF/CERT.SF", sf)
        z.writestr("META-INF/CERT.RSA", rsa_sig)
    print(f"wrote {out} ({os.path.getsize(out)} bytes), entries={len(entries)}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("source")
    parser.add_argument("replace_dir")
    parser.add_argument("output")
    signing = parser.add_mutually_exclusive_group()
    signing.add_argument("--reuse-cert", action="store_true",
                        help="Use the base APK's certificate with the local signing key")
    signing.add_argument("--certificate", help="Use an existing DER certificate with the local signing key")
    args = parser.parse_args()
    main(args.source, args.replace_dir, args.output, reuse_cert=args.reuse_cert, certificate=args.certificate)
