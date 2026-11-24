# client —— 本地私服专用 APK

把游戏里的服务器地址全部改到本机局域网 IP，重新打包并签名，**装上就能连本地私服，无需 iptables、无需 root**。

---

## 产物

| 文件 | 说明 |
|---|---|
| `luoxiaohei-local.apk` | **成品**：地址已改到 `192.168.101.21` 并重新签名 |
| `patch_neturl.py` | 改 LuaJIT 字节码里的地址（长度自适应，自动修正 proto size 字段）|
| `build_apk.py` | 重新打包 + JAR v1 签名（纯 Python，无需 Java）|
| `signing_key.pem` | 生成的签名私钥（首次运行 `build_apk.py` 时创建）|

---

## 改了什么

客户端地址在 `assets/script/gamelogic/zbNetUrl.lua`（LuaJIT 字节码）。原值全部替换为 `192.168.101.21`：

| 原来 | 说明 |
|---|---|
| `47.93.115.92` | Android 默认（账号/区服/登录服/上报）|
| `lxh-global.bjmanya.com` | iOS 分支 |
| `192.168.2.150` | Alpha/内测分支 |

共 **29 处**字符串，全部 → `192.168.101.21`。

另外同步更新了资源清单 `assets/plist.txt` 里该文件的 **MD5 与大小**（否则可能校验失败）。

签名：剔除原 `APPSTORE` 签名，用自签名证书做 **JAR v1 签名**。

---

## 安装

```bat
adb uninstall com.sgcraft.Activity.zbMainActivity   :: 原签名不同，需先卸载原版
adb install -r H:\LXH\client\luoxiaohei-local.apk
```

---

## 配套要求

1. **服务端**要在同一台机器上跑，且通告的 WS 地址一致：
   ```bat
   cd H:\LXH\gameserver
   lxhserver.exe
   ```
   默认 WSIP 已是 `192.168.101.21`（与 APK 匹配）；如本机 IP 变了，用 `set LXH_WSIP=<新IP>` 覆盖。

2. **Windows 防火墙**放行入站端口 `9001 9002 9006 9009 9100`。

3. 模拟器需能访问 `192.168.101.21`（同机模拟器一般可以）。

---

## 如果本机 IP 变了，怎么重新生成 APK

```bat
:: 1. 改地址（把 <新IP> 换成你的局域网 IP）
python H:\LXH\client\patch_neturl.py ^
  H:\LXH\apk_extract\assets\script\gamelogic\zbNetUrl.lua ^
  H:\LXH\client\zbNetUrl.patched.lua ^
  "47.93.115.92,lxh-global.bjmanya.com,192.168.2.150" ^
  <新IP>

:: 2. 重新打包签名
python H:\LXH\client\build_apk.py ^
  H:\LXH\luoxiaoheizhanjiyaolingbu.apk ^
  H:\LXH\client\zbNetUrl.patched.lua ^
  H:\LXH\client\luoxiaohei-local.apk
```

（第 1 步的输入用**原始** apk 里解包出的 `zbNetUrl.lua`；第 2 步的输入是**原始 apk**。）

---

## 已知限制

- 只做了 **JAR v1 签名**（无 v2/v3）。对这款老 targetSdk 的游戏在绝大多数模拟器上可装；若某新系统拒绝安装，需要补 v2 签名。
- 未做 zipalign（不影响安装）。
