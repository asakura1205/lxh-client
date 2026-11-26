local var_0_0 = class("zbAcLoginNormal")

var_0_0.__index = var_0_0

function createLoginNormalWnd(arg_1_0, arg_1_1)
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

		local var_4_0 = tolua.cast(arg_2_0.layer:getChildByTag(1), "CCNode")
		local var_4_1 = tolua.cast(var_4_0:getChildByTag(1), "CCLayer")

		arg_2_0.inputName = zbUtil:createEditBox(var_4_1, a2u("\xC7\xEB\xCA\xE4\xC8\xEB\xD5˺\xC5/\xCAֻ\xFA\xBA\xC5"), 24, "image/common/button_transparent.png")

		var_4_1:addChild(arg_2_0.inputName)

		local var_4_2 = tolua.cast(arg_2_0.layer:getChildByTag(2), "CCNode")
		local var_4_3 = tolua.cast(var_4_2:getChildByTag(1), "CCLayer")

		arg_2_0.inputPwd = zbUtil:createEditBox(var_4_3, a2u("\xC7\xEB\xCA\xE4\xC8\xEB\xC3\xDC\xC2\xEB(6-20λ)"), 24, "image/common/button_transparent.png")

		var_4_3:addChild(arg_2_0.inputPwd)
		arg_2_0.inputPwd:setInputFlag(kEditBoxInputFlagPassword)
		arg_2_0.inputPwd:setInputMode(kEditBoxInputModeSingleLine)

		arg_2_0.btnfastLogin = tolua.cast(arg_2_0.layer:getChildByTag(5), "CCControlButton")

		arg_2_0.btnfastLogin:addHandleOfControlEvent(function()
			arg_2_0:onFastlogin()
		end, CCControlEventTouchUpInside)

		arg_2_0.btnReg = tolua.cast(arg_2_0.layer:getChildByTag(3), "CCControlButton")

		arg_2_0.btnReg:addHandleOfControlEvent(function()
			arg_2_0:onReg()
		end, CCControlEventTouchUpInside)

		arg_2_0.btnLogin = tolua.cast(arg_2_0.layer:getChildByTag(4), "CCControlButton")

		arg_2_0.btnLogin:addHandleOfControlEvent(function()
			arg_2_0:onLogin()
		end, CCControlEventTouchUpInside)

		arg_2_0.btnfindbackpwd = tolua.cast(arg_2_0.layer:getChildByTag(6), "CCControlButton")

		arg_2_0.btnfindbackpwd:addHandleOfControlEvent(function()
			arg_2_0:onFindBackPwd()
		end, CCControlEventTouchUpInside)
	end

	var_2_0()
	var_2_1()
end

function var_0_0.onFastlogin(arg_9_0)
	local var_9_0 = {
		appid = g_Login.appid,
		check_code = g_Login.check_code,
		source = g_Login.source,
		device = g_Login.device,
		device_uuid = g_Login.device_uuid,
		os = g_Login.os,
		os_vers = g_Login.os_vers
	}
	local var_9_1 = g_Login:getPostData(var_9_0)

	g_HttpMsgHandler:sendPostMsg(visitorPost_url, var_9_1, E_ZB_MSG_VISITOR)
end

function var_0_0.onReg(arg_10_0)
	if arg_10_0.parentWnd then
		arg_10_0.parentWnd:showNormalReg()
	end
end

function var_0_0.onLogin(arg_11_0)
	local var_11_0 = string.trim(string.trim(arg_11_0.inputName:getText()))

	echoInfo("account: " .. tostring(var_11_0))

	if var_11_0 == "" then
		g_Bubble:bubbleInfo(a2u("\xC7\xEB\xCA\xE4\xC8\xEB\xD5˺\xC5"))

		return
	end

	local var_11_1 = string.trim(arg_11_0.inputPwd:getText())

	if var_11_1 == "" then
		g_Bubble:bubbleInfo(a2u("\xC7\xEB\xCA\xE4\xC8\xEB\xC3\xDC\xC2\xEB"))

		return
	end

	g_Login.account = var_11_0
	g_Login.pwd = var_11_1

	g_Login:login()
end

function var_0_0.onFindBackPwd(arg_12_0)
	if arg_12_0.parentWnd then
		g_Login.accountCheckType = E_AccountCheckType.E_FINDBACK_PWD

		arg_12_0.parentWnd:showFindbackPwd()
	end
end

function var_0_0.setLoginAccountInfo(arg_13_0)
	arg_13_0.inputName:setText(g_Login.username)
end
