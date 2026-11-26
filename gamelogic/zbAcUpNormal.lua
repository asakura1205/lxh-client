local var_0_0 = class("zbAcUpNormal")

var_0_0.__index = var_0_0

function createAcUpNormalWnd(arg_1_0, arg_1_1)
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

		arg_2_0.inputName = zbUtil:createEditBox(var_4_1, a2u("\xC7\xEB\xCA\xE4\xC8\xEB\xD5˺\xC5"), 24, "image/common/button_transparent.png")

		var_4_1:addChild(arg_2_0.inputName)

		local var_4_2 = tolua.cast(arg_2_0.layer:getChildByTag(3), "CCNode")
		local var_4_3 = tolua.cast(var_4_2:getChildByTag(1), "CCLayer")

		arg_2_0.inputPwd = zbUtil:createEditBox(var_4_3, a2u("\xC7\xEB\xCA\xE4\xC8\xEB\xC3\xDC\xC2\xEB(6-20λ)"), 24, "image/common/button_transparent.png")

		var_4_3:addChild(arg_2_0.inputPwd)
		arg_2_0.inputPwd:setInputFlag(kEditBoxInputFlagPassword)
		arg_2_0.inputPwd:setInputMode(kEditBoxInputModeSingleLine)

		arg_2_0.btnReg = tolua.cast(arg_2_0.layer:getChildByTag(4), "CCControlButton")

		arg_2_0.btnReg:addHandleOfControlEvent(function()
			arg_2_0:onCompleteUp()
		end, CCControlEventTouchUpInside)

		arg_2_0.btnMobileReg = tolua.cast(arg_2_0.layer:getChildByTag(5), "CCControlButton")

		arg_2_0.btnMobileReg:addHandleOfControlEvent(function()
			arg_2_0:onMobileUp()
		end, CCControlEventTouchUpInside)

		arg_2_0.btnback = tolua.cast(arg_2_0.layer:getChildByTag(1), "CCControlButton")

		arg_2_0.btnback:addHandleOfControlEvent(function()
			arg_2_0:onBack()
		end, CCControlEventTouchUpInside)
	end

	var_2_0()
	var_2_1()
end

function var_0_0.onBack(arg_8_0)
	if arg_8_0.parentWnd then
		arg_8_0.parentWnd:hide()
	end
end

function var_0_0.onMobileUp(arg_9_0)
	if arg_9_0.parentWnd then
		g_Login.accountCheckType = E_AccountCheckType.E_MOBILE_UP
		g_Login.accountUp_type = E_AccountUpPhone.E_Visitor

		arg_9_0.parentWnd:showFindbackPwd()
	end
end

function var_0_0.onCompleteUp(arg_10_0)
	local var_10_0 = string.trim(arg_10_0.inputName:getText())
	local var_10_1 = string.trim(arg_10_0.inputPwd:getText())

	if var_10_0 == "" then
		g_Bubble:bubbleInfo(a2u("\xC7\xEB\xCA\xE4\xC8\xEB\xD5˺\xC5"))

		return
	end

	if var_10_1 == "" then
		g_Bubble:bubbleInfo(a2u("\xC7\xEB\xCA\xE4\xC8\xEB\xC3\xDC\xC2\xEB"))

		return
	end

	local var_10_2 = zbGlobalUtil:getUserToken()
	local var_10_3 = zbGlobalUtil:getUserId()
	local var_10_4 = {
		bind_type = 1,
		check_code = "",
		appid = g_Login.appid,
		userid = var_10_3,
		token = var_10_2,
		account = var_10_0,
		password = var_10_1,
		account_type = E_AccountType.E_USER_NAME,
		source = g_Login.source,
		device = g_Login.device,
		device_uuid = g_Login.device_uuid,
		os = g_Login.os,
		os_vers = g_Login.os_vers
	}
	local var_10_5 = g_Login:getPostData(var_10_4)

	g_HttpMsgHandler:sendPostMsg(visitorBindPost_url, var_10_5, E_ZB_MSG_AC_UP)
end
