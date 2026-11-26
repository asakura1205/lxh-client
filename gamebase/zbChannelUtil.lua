zbChannelUtil = {}

function zbChannelUtil.isZBChannel(arg_1_0, arg_1_1)
	if arg_1_1 == EChannelType.zb or arg_1_1 == EChannelType.appstore then
		return true
	end

	return false
end

function zbChannelUtil.isOfficialChannel(arg_2_0, arg_2_1)
	if arg_2_1 == EChannelType.manya then
		return true
	end

	return false
end

function zbChannelUtil.isYijieSdkChannel(arg_3_0, arg_3_1)
	if arg_3_1 == EChannelType.manya or arg_3_1 == EChannelType.nox or arg_3_1 == EChannelType.migu or arg_3_1 == EChannelType.dl or arg_3_1 == EChannelType.samsung or arg_3_1 == EChannelType.boluofan or arg_3_1 == EChannelType.u17 then
		return true
	end

	return false
end

function zbChannelUtil.onSetChannelTypeByChanelType(arg_4_0, arg_4_1)
	if arg_4_1 == "zb" then
		g_Login.channel = EChannelType.zb
	elseif arg_4_1 == "appstore" then
		g_Login.channel = EChannelType.appstore
	elseif arg_4_1 == "manya" then
		g_Login.channel = EChannelType.manya
	elseif arg_4_1 == "boluofan" then
		g_Login.channel = EChannelType.boluofan
	elseif arg_4_1 == "u17" then
		g_Login.channel = EChannelType.u17
	elseif arg_4_1 == "bilibili" then
		g_Login.channel = EChannelType.bilibili
	elseif arg_4_1 == "kuaikan" then
		g_Login.channel = EChannelType.kuaikan
	elseif arg_4_1 == "qihoo" then
		g_Login.channel = EChannelType.qihoo

		zbChannelUtil:setQihooUrl()
	elseif arg_4_1 == "uc" then
		g_Login.channel = EChannelType.uc
	elseif arg_4_1 == "xiaomi" then
		g_Login.channel = EChannelType.xiaomi
	elseif arg_4_1 == "meizu" then
		g_Login.channel = EChannelType.meizu
	elseif arg_4_1 == "kaopu" then
		g_Login.channel = EChannelType.kaopu
	elseif arg_4_1 == "kpsuper" then
		g_Login.channel = EChannelType.kpsuper
	elseif arg_4_1 == "samsung" then
		g_Login.channel = EChannelType.samsung
	elseif arg_4_1 == "m4399" then
		g_Login.channel = EChannelType.m4399
	elseif arg_4_1 == "nox" then
		g_Login.channel = EChannelType.nox
	elseif arg_4_1 == "migu" then
		g_Login.channel = EChannelType.migu
	elseif arg_4_1 == "dl" then
		g_Login.channel = EChannelType.dl
	end
end

function zbChannelUtil.setQihooUrl(arg_5_0)
	zbGlobalUtil:GameCallSDKFunction("setGetUerInfoUrl", g_qihooGetUserInfo_url, "")
end
