zbLogin = class("zbLogin")
zbLogin.__index = zbLogin

function createLogin()
	local var_1_0 = zbLogin.new()

	var_1_0:init()

	return var_1_0
end

function zbLogin.init(arg_2_0)
	arg_2_0.loginServerUrl = g_loginServer_url
	arg_2_0.areaReqUrl = g_areaReq_url
	arg_2_0.bSendLoginServer = false
	arg_2_0.sms_appkey = zbGlobalUtil:getStringValueByKey("SMS_APPKEY")
	arg_2_0.accountCheckType = 1
	arg_2_0.phoneregAc = ""
	arg_2_0.check_code = ""
	arg_2_0.account_active = 0
	arg_2_0.bind_name = 0
	arg_2_0.bind_email = 0
	arg_2_0.bind_phone = 0
	arg_2_0.tokenRefresh_ret = 0
	arg_2_0.accountUp_type = E_AccountUpPhone.E_NAME
	arg_2_0.noticeData = nil
	arg_2_0.areaInfo = nil
	arg_2_0.areaRoleInfo = nil
	arg_2_0.username = zbGameCore:Instance():getConfigValue(CONFIG_KEY_USERNAME) or ""
	arg_2_0.lastServerId = zbGameCore:Instance():getConfigValue(CONFIG_KEY_LAST_SERVERID) or -1
	arg_2_0.lastServerId = tonumber(arg_2_0.lastServerId)
	arg_2_0.selectServerId = arg_2_0.lastServerId
	arg_2_0.account = zbGameCore:Instance():getConfigValue(CONFIG_KEY_ACCOUNT) or ""
	arg_2_0.ticket = ""
	arg_2_0.token = ""
	arg_2_0.expire = ""
	arg_2_0.userId = ""
	arg_2_0.resVersion = "1.1"
	arg_2_0.platform = 1
	arg_2_0.channel = EChannelType.zb
	arg_2_0.appid = "100000"
	arg_2_0.appsecret = "f01fbef4ed9b1061cb4aaebd60f54657"
	arg_2_0.accountId = zbGameCore:Instance():getConfigValue(CONFIG_KEY_USERID) or ""
	arg_2_0.pwd = zbGameCore:Instance():getConfigValue(CONFIG_KEY_PWD) or "123456"
	arg_2_0.account_type = E_AccountType.E_USER_NAME
	arg_2_0.check_code = ""
	arg_2_0.source = ""
	arg_2_0.device = ""
	arg_2_0.device_uuid = ""
	arg_2_0.os = "Win32"
	arg_2_0.os_vers = ""
	arg_2_0.sign = ""

	if zbGlobalUtil:getTargetPlatform() == "android" then
		arg_2_0.os = "Android"
	elseif zbGlobalUtil:getTargetPlatform() == "ios" then
		arg_2_0.os = "IOS"
	end

	local var_2_0 = zbGlobalUtil:getPhoneIMEI()

	if var_2_0 ~= "" and var_2_0 ~= nil then
		local var_2_1 = zbUtil:Split(var_2_0, "|")

		if var_2_1 ~= nil and type(var_2_1) == "table" then
			arg_2_0.device_uuid = var_2_1[1]
			arg_2_0.device = var_2_1[2]
			arg_2_0.os_vers = var_2_1[3]
		end
	end

	if zbGlobalUtil:getTargetPlatform() == "win32" then
		local var_2_2 = os.time() * 1000

		math.randomseed(var_2_2)

		local var_2_3 = math.random()

		arg_2_0.device_uuid = var_2_2 .. var_2_3
		arg_2_0.device = ""
		arg_2_0.os = "Win32"

		zbGameCore:Instance():setConfigValue(CONFIG_KEY_WIN32_UUID, arg_2_0.device_uuid)
	end
end

function zbLogin.free(arg_3_0)
	return
end

function zbLogin.getServerById(arg_4_0, arg_4_1)
	if arg_4_0.areaInfo ~= nil and arg_4_0.areaInfo.ServerList ~= nil then
		for iter_4_0, iter_4_1 in pairs(arg_4_0.areaInfo.ServerList) do
			if iter_4_1.ServerId == arg_4_1 then
				return iter_4_1
			end
		end
	end

	return nil
end

function zbLogin.getCurServer(arg_5_0)
	return (arg_5_0:getServerById(arg_5_0.selectServerId))
end

function zbLogin.reqAreaList(arg_6_0)
	arg_6_0.areaInfo = nil

	local var_6_0 = {
		Account = arg_6_0.account,
		AccountId = arg_6_0.accountId,
		Platform = arg_6_0.platform,
		Channel = arg_6_0.channel,
		Version = arg_6_0.resVersion
	}

	g_HttpMsgHandler:AS_AreaList_Req(var_6_0, arg_6_0.areaReqUrl)
end

function zbLogin.reqAreaRoleInfo(arg_7_0)
	arg_7_0.areaRoleInfo = nil
	AS_RoleInfoReq.Channel = arg_7_0.channel
	AS_RoleInfoReq.AccountId = arg_7_0.accountId
	AS_RoleInfoReq.Platform = arg_7_0.platform

	g_HttpMsgHandler:AS_RoleInfoReq(AS_RoleInfoReq, arg_7_0.areaReqUrl)
end

function zbLogin.loginGame(arg_8_0)
	g_WsMsgHandler.needLoginReq = true

	g_WsMsgHandler:wsConnect()
end

function zbLogin.setBindInfo(arg_9_0, arg_9_1)
	if arg_9_1 then
		arg_9_0.bind_name = arg_9_1.bind_name
		arg_9_0.bind_email = arg_9_1.bind_email
		arg_9_0.bind_phone = arg_9_1.bind_phone

		local var_9_0 = ""

		if arg_9_0.bind_name ~= "" then
			var_9_0 = arg_9_0.bind_name
		elseif arg_9_0.bind_phone ~= "" then
			var_9_0 = arg_9_0.bind_phone
		elseif arg_9_0.bind_email ~= "" then
			var_9_0 = arg_9_0.bind_email
		end

		if var_9_0 == "" then
			var_9_0 = zbGlobalUtil:getUserId()
		end

		arg_9_0.username = var_9_0

		zbGameCore:Instance():setConfigValue(CONFIG_KEY_USERNAME, arg_9_0.username)
	end
end

function zbLogin.saveAccountInfo(arg_10_0)
	local var_10_0 = zbGlobalUtil:getUserToken()
	local var_10_1 = zbGlobalUtil:getUserId()

	zbGameCore:Instance():setConfigValue(CONFIG_KEY_USERID, var_10_1)
	zbGameCore:Instance():setConfigValue(CONFIG_KEY_ACCOUNT, arg_10_0.account)
	zbGameCore:Instance():setConfigValue(CONFIG_KEY_LAST_SERVERID, arg_10_0.lastServerId)
	zbGameCore:Instance():setConfigValue(CONFIG_KEY_TOKEN, var_10_0)
end

function zbLogin.isLocalLogin(arg_11_0)
	local var_11_0 = zbGameCore:Instance():getConfigValue(CONFIG_KEY_TOKEN)

	if var_11_0 == "" then
		return false
	end

	local var_11_1 = zbGameCore:Instance():getConfigValue(CONFIG_KEY_USERID)

	if var_11_1 == "" then
		return false
	end

	arg_11_0:refreshtoken(var_11_0, var_11_1)
end

function zbLogin.refreshtoken(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = {
		appid = arg_12_0.appid,
		userid = arg_12_2,
		token = arg_12_1,
		device = arg_12_0.device,
		device_uuid = arg_12_0.device_uuid,
		os = arg_12_0.os,
		os_vers = arg_12_0.os_vers
	}
	local var_12_1 = arg_12_0:getPostData(var_12_0)

	g_HttpMsgHandler:sendPostMsg(refreshTokenPost_url, var_12_1, E_ZB_MSG_REFRESH_TOKEN)
end

function zbLogin.fastLogin(arg_13_0)
	local var_13_0 = {
		appid = arg_13_0.appid,
		check_code = arg_13_0.check_code,
		source = arg_13_0.source,
		device = arg_13_0.device,
		device_uuid = arg_13_0.device_uuid,
		os = arg_13_0.os,
		os_vers = arg_13_0.os_vers
	}
	local var_13_1 = arg_13_0:getPostData(var_13_0)

	g_HttpMsgHandler:sendPostMsg(visitorPost_url, var_13_1, E_ZB_MSG_VISITOR)
end

function zbLogin.login(arg_14_0)
	local var_14_0 = {
		appid = arg_14_0.appid,
		account = arg_14_0.account,
		password = arg_14_0.pwd,
		check_code = arg_14_0.check_code,
		source = arg_14_0.source,
		device = arg_14_0.device,
		device_uuid = arg_14_0.device_uuid,
		os = arg_14_0.os,
		os_vers = arg_14_0.os_vers
	}
	local var_14_1 = arg_14_0:getPostData(var_14_0)
	local var_14_2 = require("cjson").encode(var_14_0)

	g_HttpMsgHandler:sendPostMsg(loginPost_url, var_14_1, E_ZB_MSG_LOGIN)
end

function zbLogin.getPostData(arg_15_0, arg_15_1)
	if type(arg_15_1) ~= "table" then
		return ""
	end

	local var_15_0 = {}

	for iter_15_0, iter_15_1 in pairs(arg_15_1) do
		table.insert(var_15_0, iter_15_0)
	end

	table.sort(var_15_0)

	local var_15_1 = ""
	local var_15_2 = 1
	local var_15_3 = ""

	for iter_15_2, iter_15_3 in pairs(var_15_0) do
		local var_15_4 = var_15_2 == 1 and "" or "#"
		local var_15_5 = arg_15_1[iter_15_3]
		local var_15_6 = string.urlencode(var_15_5)

		var_15_1 = var_15_1 .. var_15_4 .. iter_15_3 .. "=" .. var_15_6
		var_15_2 = var_15_2 + 1
	end

	local var_15_7 = var_15_1 .. "#" .. arg_15_0.appsecret
	local var_15_8 = zbGlobalUtil:getMd5(var_15_7, true)
	local var_15_9 = ""
	local var_15_10 = 1
	local var_15_11 = ""

	for iter_15_4, iter_15_5 in pairs(var_15_0) do
		local var_15_12 = var_15_10 == 1 and "" or "&"
		local var_15_13 = arg_15_1[iter_15_5]
		local var_15_14 = string.urlencode(var_15_13)

		var_15_9 = var_15_9 .. var_15_12 .. iter_15_5 .. "=" .. var_15_14
		var_15_10 = var_15_10 + 1
	end

	return var_15_9 .. "&sign=" .. var_15_8
end
