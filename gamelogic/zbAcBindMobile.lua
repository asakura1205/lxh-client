local var_0_0 = class("zbAcBindMobile")

var_0_0.__index = var_0_0

function createBindMobileWnd(arg_1_0, arg_1_1)
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

		arg_2_0.inputName = zbUtil:createEditBox(var_4_1, a2u("\xC7\xEB\xCA\xE4\xC8\xEB\xCAֻ\xFA\xBA\xC5"), 24, "image/common/button_transparent.png")

		var_4_1:addChild(arg_2_0.inputName)

		arg_2_0.btnNobind = tolua.cast(arg_2_0.layer:getChildByTag(3), "CCControlButton")

		arg_2_0.btnNobind:addHandleOfControlEvent(function()
			arg_2_0:notBind()
		end, CCControlEventTouchUpInside)

		arg_2_0.btnBind = tolua.cast(arg_2_0.layer:getChildByTag(4), "CCControlButton")

		arg_2_0.btnBind:addHandleOfControlEvent(function()
			arg_2_0:bindNow()
		end, CCControlEventTouchUpInside)
	end

	var_2_0()
	var_2_1()
end

function var_0_0.bindNow(arg_7_0)
	local var_7_0 = string.trim(arg_7_0.inputName:getText())

	if var_7_0 == "" then
		g_Bubble:bubbleInfo(a2u("\xC7\xEB\xCA\xE4\xC8\xEB\xCAֻ\xFA\xBA\xC5"))

		return
	end

	g_Login.accountCheckType = E_AccountCheckType.E_NORMAL_BIND
	g_Login.phoneregAc = var_7_0
	g_Login.check_code = ""

	local var_7_1 = {
		appid = g_Login.appid,
		account = var_7_0,
		account_type = E_AccountType.E_PHONE,
		check_code = g_Login.check_code
	}
	local var_7_2 = g_Login:getPostData(var_7_1)

	g_HttpMsgHandler:sendPostMsg(checkAccountPost_url, var_7_2, E_ZB_MSG_AC_CHECK)
end

function var_0_0.notBind(arg_8_0)
	g_Login:login()
end
