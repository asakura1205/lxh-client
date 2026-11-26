local var_0_0 = class("zbAcInputAccodeWnd")

var_0_0.__index = var_0_0

function createInputAccodeWnd(arg_1_0, arg_1_1)
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

		arg_2_0.inputVery = zbUtil:createEditBox(var_4_1, a2u("\xC7\xEB\xCA\xE4\xC8\xEB\xD1\xE9֤\xC2\xEB"), 24, "image/common/button_transparent.png")

		var_4_1:addChild(arg_2_0.inputVery)

		arg_2_0.btnActive = tolua.cast(arg_2_0.layer:getChildByTag(4), "CCControlButton")

		arg_2_0.btnActive:addHandleOfControlEvent(function()
			arg_2_0:onActive()
		end, CCControlEventTouchUpInside)

		arg_2_0.btnback = tolua.cast(arg_2_0.layer:getChildByTag(1), "CCControlButton")

		arg_2_0.btnback:addHandleOfControlEvent(function()
			arg_2_0:onBack()
		end, CCControlEventTouchUpInside)
	end

	var_2_0()
	var_2_1()
end

function var_0_0.onActive(arg_7_0)
	local var_7_0 = string.trim(arg_7_0.inputVery:getText())

	if var_7_0 == "" then
		g_Bubble:bubbleInfo(a2u("\xC7\xEB\xCA\xE4\xC8\xEB\xD1\xFB\xC7\xEB\xC2\xEB"))

		return
	end

	g_HttpMsgHandler:AS_AccountActivate_Req(var_7_0)
	arg_7_0:onBack()
end

function var_0_0.onBack(arg_8_0)
	if arg_8_0.parentWnd then
		arg_8_0.parentWnd:hide()
	end
end
