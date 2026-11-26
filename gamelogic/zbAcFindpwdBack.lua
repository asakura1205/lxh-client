local var_0_0 = class("zbAcFindpwdBack")

var_0_0.__index = var_0_0

function createAcFindpwdBackWnd(arg_1_0, arg_1_1)
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
		arg_2_0.btnback = tolua.cast(arg_2_0.layer:getChildByTag(1), "CCControlButton")

		arg_2_0.btnback:addHandleOfControlEvent(function()
			arg_2_0:onBack()
		end, CCControlEventTouchUpInside)

		arg_2_0.btnnext = tolua.cast(arg_2_0.layer:getChildByTag(4), "CCControlButton")

		arg_2_0.btnnext:addHandleOfControlEvent(function()
			arg_2_0:onNext()
		end, CCControlEventTouchUpInside)

		arg_2_0.lbltitle = tolua.cast(arg_2_0.layer:getChildByTag(3), "CCLabelTTF")

		local var_4_0 = tolua.cast(arg_2_0.layer:getChildByTag(2), "CCNode")
		local var_4_1 = tolua.cast(var_4_0:getChildByTag(1), "CCLayer")

		arg_2_0.inputName = zbUtil:createEditBox(var_4_1, a2u("\xC7\xEB\xCA\xE4\xC8\xEB\xCAֻ\xFA\xBA\xC5"), 24, "image/common/button_transparent.png")

		var_4_1:addChild(arg_2_0.inputName)
	end

	var_2_0()
	var_2_1()
end

function var_0_0.onBack(arg_7_0)
	if arg_7_0.parentWnd == nil then
		return
	end

	if g_Login.accountCheckType == E_AccountCheckType.E_MOBILE_REG then
		g_Login.accountCheckType = E_AccountCheckType.E_NONE

		arg_7_0.parentWnd:showNormalReg()
	elseif g_Login.accountCheckType == E_AccountCheckType.E_FINDBACK_PWD then
		g_Login.accountCheckType = E_AccountCheckType.E_NONE

		arg_7_0.parentWnd:showNormalLogin()
	elseif g_Login.accountCheckType == E_AccountCheckType.E_MOBILE_UP then
		arg_7_0.parentWnd:hide()
	end
end

function var_0_0.onNext(arg_8_0)
	local var_8_0 = string.trim(arg_8_0.inputName:getText())

	if var_8_0 == "" then
		g_Bubble:bubbleInfo(a2u("\xD5˺Ų\xBB\xC4\xDCΪ\xBF\xD5"))

		return
	end

	if tonumber(var_8_0) == 0 then
		g_Bubble:bubbleInfo(a2u("\xC7\xEB\xCA\xE4\xC8\xEB\xCAֻ\xFA\xBA\xC5"))

		return
	end

	g_Login.phoneregAc = var_8_0

	if g_Login.accountCheckType == E_AccountCheckType.E_MOBILE_REG or g_Login.accountCheckType == E_AccountCheckType.E_MOBILE_UP then
		arg_8_0:checkAccount(var_8_0)
	elseif g_Login.accountCheckType == E_AccountCheckType.E_FINDBACK_PWD and arg_8_0.parentWnd then
		arg_8_0.parentWnd:showInputVrify()
	end
end

function var_0_0.checkAccount(arg_9_0, arg_9_1)
	local var_9_0 = {
		check_code = "",
		appid = g_Login.appid,
		account = arg_9_1,
		account_type = E_AccountType.E_PHONE
	}
	local var_9_1 = g_Login:getPostData(var_9_0)

	g_HttpMsgHandler:sendPostMsg(checkAccountPost_url, var_9_1, E_ZB_MSG_AC_CHECK)
end

function var_0_0.setTitle(arg_10_0, arg_10_1)
	arg_10_0.lbltitle:setString(a2u(arg_10_1))
end
