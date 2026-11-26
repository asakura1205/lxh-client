zbChannelPostUtil = {}

function zbChannelPostUtil.IOS_PostLoginData()
	zbChannelPostUtil.IOS_PostData("activition")
end

function zbChannelPostUtil.IOS_PostResUpdateData()
	zbChannelPostUtil.IOS_PostData("updateres")
end

function zbChannelPostUtil.IOS_PostEnterGameData()
	local var_3_0 = tonumber(g_Login.selectServerId)
	local var_3_1 = string.format("%04d", var_3_0)
	local var_3_2 = var_3_1

	if g_Login.areaInfo then
		var_3_2 = g_Login.areaInfo.AreaID .. var_3_1
	end

	zbChannelPostUtil.IOS_PostData("enterGame", var_3_2)
end

function zbChannelPostUtil.IOS_PostData(arg_4_0, arg_4_1)
	local var_4_0 = 0

	if arg_4_1 then
		var_4_0 = arg_4_1
	end

	local var_4_1 = g_Login.strAppId
	local var_4_2 = var_4_0
	local var_4_3 = g_Login.deviceName
	local var_4_4 = g_Login.iMEI
	local var_4_5 = arg_4_0
	local var_4_6 = "1"
	local var_4_7 = "0"
	local var_4_8 = "200002"
	local var_4_9 = "PostData"
	local var_4_10 = g_Login.osType
	local var_4_11 = g_Login.osVersion
	local var_4_12 = os.time()
	local var_4_13 = math.ceil(var_4_12)
	local var_4_14 = g_Login.strTsecret
	local var_4_15 = var_4_1 .. var_4_2 .. var_4_3 .. var_4_4 .. var_4_5 .. var_4_6 .. var_4_7 .. var_4_8 .. var_4_9 .. var_4_10 .. var_4_11 .. var_4_13 .. var_4_14
	local var_4_16 = zbGlobalUtil:getMd5(var_4_15, true)
	local var_4_17 = "appid=" .. var_4_1 .. "&area=" .. var_4_2 .. "&device=" .. var_4_3 .. "&deviceUUID=" .. var_4_4 .. "&dkey=" .. var_4_5 .. "&dtype=" .. var_4_6 .. "&dvalue=" .. var_4_7 .. "&from=" .. var_4_8 .. "&fun=" .. var_4_9 .. "&os=" .. var_4_10 .. "&osvers=" .. var_4_11 .. "&time=" .. var_4_13 .. "&appsecret=" .. var_4_14 .. "&sign=" .. var_4_16

	g_NetMsgHandler:SendPostMsg("http://oapi.lezhuogame.com/OAuth1/Game/PostData", var_4_17, 0)
end
