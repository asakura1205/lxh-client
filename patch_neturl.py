import sys

sys.path.insert(0, r'H:/LXH/ljd_src/ljd-main')
import ljd, ljd.rawdump.code
from ljd.rawdump.opcode.v20 import _OPCODES

ljd.rawdump.code.init(_OPCODES)
from ljd.rawdump import parser as P


def uleb(n):
    out = bytearray()
    while True:
        b = n & 0x7F
        n >>= 7
        if n:
            out.append(b | 0x80)
        else:
            out.append(b)
            break
    return bytes(out)


def read_uleb(data, i):
    v = 0
    sh = 0
    while True:
        b = data[i]
        i += 1
        v |= (b & 0x7F) << sh
        if not (b & 0x80):
            return v, i
        sh += 7


def collect_strings(proto, acc):
    for obj in proto.constants.complex_constants:
        if isinstance(obj, str):
            acc.add(obj)
        elif hasattr(obj, 'dictionary'):
            for k, v in obj.dictionary:
                if isinstance(k, str):
                    acc.add(k)
                if isinstance(v, str):
                    acc.add(v)
            for a in obj.array:
                if isinstance(a, str):
                    acc.add(a)
    for ch in (getattr(proto, 'sub_prototypes', None) or []):
        collect_strings(ch, acc)


def patch(in_path, out_path, olds, new):
    olds = [o for o in olds.split(',') if o]
    data = open(in_path, 'rb').read()

    # 文件 = magic(3)+version(1)+flags(uleb) + proto_size(uleb) + proto_body + tail
    i = 4
    _, i = read_uleb(data, i)          # flags
    size_start = i
    old_size, body_start = read_uleb(data, i)
    body = data[body_start:body_start + old_size]   # 单个 proto
    tail = data[body_start + old_size:]             # 结尾的 proto 终止标记

    _, proto = P.parse(in_path)
    strings = set()
    collect_strings(proto, strings)

    replaced = 0
    for s in sorted(strings):
        ns = s
        for old in olds:
            if old in ns:
                ns = ns.replace(old, new)
        if ns == s:
            continue
        old_pat = uleb(len(s) + 5) + s.encode('utf-8')
        new_pat = uleb(len(ns) + 5) + ns.encode('utf-8')
        cnt = body.count(old_pat)
        print(f"  [{cnt}x] {s}  ->  {ns}")
        body = body.replace(old_pat, new_pat)
        replaced += cnt

    header = data[:size_start]
    out = header + uleb(len(body)) + body + tail
    open(out_path, 'wb').write(out)
    print(f"replaced {replaced}; size {len(data)} -> {len(out)}; proto size {old_size} -> {len(body)}")


if __name__ == '__main__':
    patch(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4])
