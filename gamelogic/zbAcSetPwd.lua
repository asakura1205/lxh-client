local var_0_0 = class("zbAcSetPwd")

var_0_0.__index = var_0_0

function createSetpwdWnd(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	local function var_2_0()
		arg_2_0.parentWnd = arg_2_1
	end

	local function var_2_1()
		arg_2_0.layer = arg_2_2

		local var_4_0 = tolua.cast(arg_2_0.layer:getChildByTag(2), "CCNode")
		local var_4_1 = tolua.cast(var_4_0:getChildByTag(1), "CCLayer")

		arg_2_0.inputPwd = zbUtil:createEditBox(var_4_1, a2u("\xC7\xEB\xCA\xE4\xC8\xEB\xC3\xDC\xC2\xEB"), 24, "image/common/button_transparent.png")

		var_4_1:addChild(arg_2_0.inputPwd)

		arg_2_0.btnback = tolua.cast(arg_2_0.layer:getChildByTag(1), "CCControlButton")

		arg_2_0.btnback:addHandleOfControlEvent(function()
			arg_2_0:onBack()
		end, CCControlEventTouchUpInside)

		arg_2_0.btnComplete = tolua.cast(arg_2_0.layer:getChildByTag(4), "CCControlButton")

		arg_2_0.btnComplete:addHandleOfControlEvent(function()
			arg_2_0:complete()
		end, CCControlEventTouchUpInside)
	end

	var_2_0()
	var_2_1()
end

function var_0_0.onBack(arg_7_0)
	if arg_7_0.parentWnd then
		if g_Login.accountCheckType == E_AccountCheckType.E_MOBILE_REG then
			arg_7_0.parentWnd:showMobileReg()
		elseif g_Login.accountCheckType == E_AccountCheckType.E_FINDBACK_PWD then
			arg_7_0.parentWnd:showInputVrify()
		elseif g_Login.accountCheckType == E_AccountCheckType.E_MOBILE_UP then
			arg_7_0.parentWnd:showInputVrify()
		end
	end
end

function var_0_0.setCompleteButtonTile(arg_8_0, arg_8_1)
	zbUtil:setButtonTitle(arg_8_0.btnComplete, a2u(arg_8_1))
end

function var_0_0.complete(arg_9_0)
	if g_Login.accountCheckType == E_AccountCheckType.E_MOBILE_REG then
		arg_9_0:completeReg()
	elseif g_Login.accountCheckType == E_AccountCheckType.E_FINDBACK_PWD then
		arg_9_0:completeFindbackPwd()
	elseif g_Login.accountCheckType == E_AccountCheckType.E_MOBILE_UP then
		arg_9_0:completeAcUp()
	end
end

function var_0_0.completeAcUp(arg_10_0)
	local var_10_0 = string.trim(arg_10_0.inputPwd:getText())

	if var_10_0 == "" then
		g_Bubble:bubbleInfo(a2u("\xC7\xEB\xCA\xE4\xC8\xEB\xC3\xDC\xC2\xEB"))

		return
	end

	local var_10_1 = zbGlobalUtil:getUserToken()
	local var_10_2 = zbGlobalUtil:getUserId()
	local var_10_3 = {
		bind_type = 1,
		appid = g_Login.appid,
		userid = var_10_2,
		token = var_10_1,
		account = g_Login.phoneregAc,
		password = var_10_0,
		account_type = E_AccountType.E_PHONE,
		check_code = g_Login.check_code,
		source = g_Login.source,
		device = g_Login.device,
		device_uuid = g_Login.device_uuid,
		os = g_Login.os,
		os_vers = g_Login.os_vers
	}
	local var_10_4 = g_Login:getPostData(var_10_3)

	g_HttpMsgHandler:sendPostMsg(visitorBindPost_url, var_10_4, E_ZB_MSG_AC_UP)
end

function var_0_0.completeFindbackPwd(arg_11_0)
	local var_11_0 = string.trim(arg_11_0.inputPwd:getText())

	if var_11_0 == "" then
		g_Bubble:bubbleInfo(a2u("\xC7\xEB\xCA\xE4\xC8\xEB\xC3\xDC\xC2\xEB"))

		return
	end

	g_Login.account = g_Login.phoneregAc
	g_Login.pwd = var_11_0
	g_Login.account_type = E_AccountType.E_PHONE

	local var_11_1 = {
		appid = g_Login.appid,
		account = g_Login.account,
		password = g_Login.pwd,
		account_type = g_Login.account_type,
		check_code = g_Login.check_code
	}
	local var_11_2 = g_Login:getPostData(var_11_1)

	g_HttpMsgHandler:sendPostMsg(findpwdBackPost_url, var_11_2, E_ZB_MSG_FINDBACKPWD)
end

function var_0_0.completeReg(arg_12_0)
	local var_12_0 = arg_12_0.inputPwd:getText()

	if var_12_0 == "" then
		g_Bubble:bubbleInfo(a2u("\xC7\xEB\xCA\xE4\xC8\xEB\xC3\xDC\xC2\xEB"))

		return
	end

	g_Login.account = g_Login.phoneregAc
	g_Login.pwd = var_12_0
	g_Login.account_type = E_AccountType.E_PHONE

	local var_12_1 = {
		appid = g_Login.appid,
		account = g_Login.account,
		password = g_Login.pwd,
		account_type = g_Login.account_type,
		check_code = g_Login.check_code,
		source = g_Login.source,
		device = g_Login.device,
		device_uuid = g_Login.device_uuid,
		os = g_Login.os,
		os_vers = g_Login.os_vers
	}
	local var_12_2 = g_Login:getPostData(var_12_1)

	g_HttpMsgHandler:sendPostMsg(registerPost_url, var_12_2, E_ZB_MSG_REG)
end
