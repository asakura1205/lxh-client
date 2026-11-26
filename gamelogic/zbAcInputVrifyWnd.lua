local var_0_0 = class("zbAcInputVrifyWnd")

var_0_0.__index = var_0_0

function createInputVeryWnd(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	local function var_2_0()
		arg_2_0.parentWnd = arg_2_1
		arg_2_0.cdCount = 0
	end

	local function var_2_1()
		arg_2_0.layer = arg_2_2

		local var_4_0 = tolua.cast(arg_2_0.layer:getChildByTag(3), "CCNode")
		local var_4_1 = tolua.cast(var_4_0:getChildByTag(1), "CCLayer")

		arg_2_0.inputVery = zbUtil:createEditBox(var_4_1, a2u("\xC7\xEB\xCA\xE4\xC8\xEB\xD1\xE9֤\xC2\xEB"), 24, "image/common/button_transparent.png")

		var_4_1:addChild(arg_2_0.inputVery)
		arg_2_0.inputVery:setInputMode(kEditBoxInputModePhoneNumber)

		arg_2_0.btngetvrify = tolua.cast(var_4_0:getChildByTag(2), "CCControlButton")

		arg_2_0.btngetvrify:addHandleOfControlEvent(function()
			arg_2_0:onGetVrify()
		end, CCControlEventTouchUpInside)
		zbUtil:setButtonTitle(arg_2_0.btngetvrify, a2u("\xBB\xF1ȡ\xD1\xE9֤\xC2\xEB"))

		arg_2_0.btnNext = tolua.cast(arg_2_0.layer:getChildByTag(4), "CCControlButton")

		arg_2_0.btnNext:addHandleOfControlEvent(function()
			arg_2_0:onNext()
		end, CCControlEventTouchUpInside)

		arg_2_0.btnback = tolua.cast(arg_2_0.layer:getChildByTag(1), "CCControlButton")

		arg_2_0.btnback:addHandleOfControlEvent(function()
			arg_2_0:onBack()
		end, CCControlEventTouchUpInside)
	end

	var_2_0()
	var_2_1()
end

function var_0_0.update(arg_8_0)
	if g_GameStateMachine:isOneSecondPassed() == false then
		return
	end

	if arg_8_0.cdCount == 0 then
		local var_8_0 = a2u("\xBB\xF1ȡ\xD1\xE9֤\xC2\xEB")

		zbUtil:setButtonTitle(arg_8_0.btngetvrify, a2u(var_8_0))
		arg_8_0.btngetvrify:setGray(false)
		arg_8_0.btngetvrify:setEnabled(true)

		return
	end

	local var_8_1 = string.format("\xD6\xD8\xD0»\xF1ȡ(%d)", arg_8_0.cdCount)

	zbUtil:setButtonTitle(arg_8_0.btngetvrify, a2u(var_8_1))

	arg_8_0.cdCount = arg_8_0.cdCount - 1
end

function var_0_0.onGetVrify(arg_9_0)
	if g_Login.phoneregAc == "" then
		return
	end

	arg_9_0.btngetvrify:setGray(true)
	arg_9_0.btngetvrify:setEnabled(false)

	arg_9_0.cdCount = 60

	zbGlobalUtil:GameCallSDKFunction("getVrify", g_Login.phoneregAc, "")
end

function var_0_0.onNext(arg_10_0)
	local var_10_0 = string.trim(arg_10_0.inputVery:getText())

	if var_10_0 == "" then
		g_Bubble:bubbleInfo(a2u("\xC7\xEB\xCA\xE4\xC8\xEB\xD1\xE9֤\xC2\xEB"))

		return
	end

	g_Login.check_code = var_10_0

	local var_10_1 = {
		zone = "86",
		appid = g_Login.appid,
		phone = g_Login.phoneregAc,
		sms_key = g_Login.sms_appkey,
		check_code = var_10_0
	}
	local var_10_2 = g_Login:getPostData(var_10_1)
	local var_10_3 = verifyPost_url

	if zbGlobalUtil:getTargetPlatform() == "ios" then
		var_10_3 = verifyPost_url_IOS
	end

	g_HttpMsgHandler:sendPostMsg(var_10_3, var_10_2, E_ZB_MSG_VERIFY)
end

function var_0_0.onBack(arg_11_0)
	if arg_11_0.parentWnd then
		if g_Login.accountCheckType == E_AccountCheckType.E_NORMAL_BIND then
			arg_11_0.parentWnd:showBindMobile()
		elseif g_Login.accountCheckType == E_AccountCheckType.E_FINDBACK_PWD then
			arg_11_0.parentWnd:showFindbackPwd()
		elseif g_Login.accountCheckType == E_AccountCheckType.E_MOBILE_REG then
			arg_11_0.parentWnd:showMobileReg()
		elseif g_Login.accountCheckType == E_AccountCheckType.E_MOBILE_UP then
			arg_11_0.parentWnd:showFindbackPwd()
		end
	end
end

function var_0_0.setVerifyText(arg_12_0)
	arg_12_0.inputVery:setText("")
end

function var_0_0.setNextButtonTile(arg_13_0, arg_13_1)
	zbUtil:setButtonTitle(arg_13_0.btnNext, a2u(arg_13_1))
end
