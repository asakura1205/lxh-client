zbChannelUtil = {}

-- [本地私服] 强制视为自建渠道，跳过小米等 SDK 登录
function zbChannelUtil.isZBChannel(arg_1_0, arg_1_1)
	return true
end

function zbChannelUtil.isOfficialChannel(arg_2_0, arg_2_1)
	if arg_2_1 == EChannelType.manya then
		return true
	end

	return false
end

function zbChannelUtil.isYijieSdkChannel(arg_3_0, arg_3_1)
	return false
end

-- [本地私服] 无论原生渠道是什么，一律置为 zb
function zbChannelUtil.onSetChannelTypeByChanelType(arg_4_0, arg_4_1)
	g_Login.channel = EChannelType.zb
end

function zbChannelUtil.setQihooUrl(arg_5_0)
	zbGlobalUtil:GameCallSDKFunction("setGetUerInfoUrl", g_qihooGetUserInfo_url, "")
end
