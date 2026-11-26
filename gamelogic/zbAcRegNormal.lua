local var_0_0 = class("zbAcRegNormal")

var_0_0.__index = var_0_0

function createRegNormalWnd(arg_1_0, arg_1_1)
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

		arg_2_0.inputName = zbUtil:createEditBox(var_4_1, a2u("\xC7\xEB\xCA\xE4\xC8\xEB\xD5˺\xC5(4-20λ\xD7\xD6ĸ\xBA\xCD\xCA\xFD\xD7\xD6\xD7\xE9\xB3\xC9)"), 24, "image/common/button_transparent.png")

		var_4_1:addChild(arg_2_0.inputName)

		local var_4_2 = tolua.cast(arg_2_0.layer:getChildByTag(3), "CCNode")
		local var_4_3 = tolua.cast(var_4_2:getChildByTag(1), "CCLayer")

		arg_2_0.inputPwd = zbUtil:createEditBox(var_4_3, a2u("\xC7\xEB\xCA\xE4\xC8\xEB\xC3\xDC\xC2\xEB(6-20λ)"), 24, "image/common/button_transparent.png")

		var_4_3:addChild(arg_2_0.inputPwd)
		arg_2_0.inputPwd:setInputFlag(kEditBoxInputFlagPassword)
		arg_2_0.inputPwd:setInputMode(kEditBoxInputModeSingleLine)

		arg_2_0.btnReg = tolua.cast(arg_2_0.layer:getChildByTag(4), "CCControlButton")

		arg_2_0.btnReg:addHandleOfControlEvent(function()
			arg_2_0:onReg()
		end, CCControlEventTouchUpInside)

		arg_2_0.btnMobileReg = tolua.cast(arg_2_0.layer:getChildByTag(5), "CCControlButton")

		arg_2_0.btnMobileReg:addHandleOfControlEvent(function()
			arg_2_0:onMobileReg()
		end, CCControlEventTouchUpInside)

		arg_2_0.btnback = tolua.cast(arg_2_0.layer:getChildByTag(1), "CCControlButton")

		arg_2_0.btnback:addHandleOfControlEvent(function()
			arg_2_0:onBack()
		end, CCControlEventTouchUpInside)
	end

	var_2_0()
	var_2_1()
end

function var_0_0.onReg(arg_8_0)
	local var_8_0 = string.trim(string.trim(arg_8_0.inputName:getText()))
	local var_8_1 = arg_8_0.inputPwd:getText()

	if var_8_0 == "" then
		g_Bubble:bubbleInfo(a2u("\xC7\xEB\xCA\xE4\xC8\xEB\xD5˺\xC5"))

		return
	end

	if var_8_1 == "" then
		g_Bubble:bubbleInfo(a2u("\xC7\xEB\xCA\xE4\xC8\xEB\xC3\xDC\xC2\xEB"))

		return
	end

	g_Login.account = var_8_0
	g_Login.pwd = a2u(var_8_1)
	g_Login.account_type = E_AccountType.E_USER_NAME

	local var_8_2 = {
		appid = g_Login.appid,
		account = g_Login.account,
		password = g_Login.pwd,
		account_type = g_Login.account_type,
		check_code = g_Login.check_code,
		source = g_Login.source,
		device = a2u(g_Login.device),
		device_uuid = g_Login.device_uuid,
		os = g_Login.os,
		os_vers = g_Login.os_vers
	}
	local var_8_3 = g_Login:getPostData(var_8_2)

	g_HttpMsgHandler:sendPostMsg(registerPost_url, var_8_3, E_ZB_MSG_REG)
end

function var_0_0.onMobileReg(arg_9_0)
	if arg_9_0.parentWnd then
		arg_9_0.parentWnd:showMobileReg()
	end
end

function var_0_0.onBack(arg_10_0)
	if arg_10_0.parentWnd then
		arg_10_0.parentWnd:showNormalLogin()
	end
end
