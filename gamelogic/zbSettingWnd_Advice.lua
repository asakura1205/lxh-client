local var_0_0 = class("zbSettingWnd_Advice")

var_0_0.__index = var_0_0

function createSettingAdvicePanel(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	local function var_2_0()
		arg_2_0.parentWnd = arg_2_1
		arg_2_0.cdTm = 0
	end

	local function var_2_1()
		local var_4_0 = tolua.cast(arg_2_2:getChildByTag(2), "CCLayerColor")

		arg_2_0.inputBox = zbUtil:createEditBox(var_4_0, "", 200, "image/common/button_transparent.png", 22, FONT_COLOR_GRAY)

		local var_4_1 = var_4_0:getContentSize()

		arg_2_0.inputBox:setpLabelDimensions(CCSizeMake(var_4_1.width, var_4_1.height))
		var_4_0:addChild(arg_2_0.inputBox)

		arg_2_0.btnCommit = tolua.cast(arg_2_2:getChildByTag(4), "CCControlButton")

		arg_2_0.btnCommit:addHandleOfControlEvent(function()
			arg_2_0:onCommitReq()
		end, CCControlEventTouchUpInside)
	end

	var_2_0()
	var_2_1()
end

function var_0_0.refresh(arg_6_0)
	return
end

function var_0_0.onCommitReq(arg_7_0)
	local var_7_0 = string.trim(arg_7_0.inputBox:getText())

	if arg_7_0.cdTm ~= 0 and g_Self.kTimeHandler:getServerTime() - arg_7_0.cdTm <= 15 then
		g_Bubble:bubbleInfo(a2u("\xB7\xB4\xC0\xA1Ƶ\xB7\xB1"))

		return
	end

	if var_7_0 == "" then
		g_Bubble:bubbleInfo(a2u("\xC7\xEB\xCA\xE4\xC8뷴\xC0\xA1\xC4\xDA\xC8\xDD"))

		return
	end

	zbChannelUtil_Report:reportAdvice(var_7_0)

	arg_7_0.cdTm = g_Self.kTimeHandler:getServerTime()

	g_Bubble:bubbleInfo(a2u("лл\xC4\xFA\xB5ķ\xB4\xC0\xA1,\xCE\xD2\xC3ǻ\xE1\xBC\xCC\xD0\xF8Ŭ\xC1\xA6!"))
end
