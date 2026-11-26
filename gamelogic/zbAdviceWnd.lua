require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbAdviceWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function var_0_0.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, var_0_0)

	return arg_1_0
end

function createAdviceWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNodeRGBA:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.record = nil
		arg_3_0.cdTm = 0
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/advice.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner", false, false)
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.layer = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.lbDesc = tolua.cast(var_5_2:getChildByTag(1001), "CCLabelTTF")

		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCLayerColor")

		arg_3_0.inputBox = zbUtil:createEditBox(var_5_3, "", 200, "image/common/button_transparent.png", 22, FONT_COLOR_GRAY)

		local var_5_4 = var_5_3:getContentSize()

		arg_3_0.inputBox:setpLabelDimensions(CCSizeMake(var_5_4.width, var_5_4.height))
		var_5_3:addChild(arg_3_0.inputBox)

		arg_3_0.btnCommit = tolua.cast(var_5_2:getChildByTag(2), "CCControlButton")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnCommit:addHandleOfControlEvent(function()
			arg_3_0:onCommitReq()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_9_0, arg_9_1)
	return
end

function var_0_0.onCommitReq(arg_10_0)
	local var_10_0 = string.trim(arg_10_0.inputBox:getText())

	if arg_10_0.cdTm ~= 0 and os.time() - arg_10_0.cdTm <= 15 then
		g_Bubble:bubbleInfo(a2u("\xB7\xB4\xC0\xA1Ƶ\xB7\xB1"))

		return
	end

	if var_10_0 == "" then
		g_Bubble:bubbleInfo(a2u("\xC7\xEB\xCA\xE4\xC8뷴\xC0\xA1\xC4\xDA\xC8\xDD"))

		return
	end

	zbChannelUtil_Report:reportAdvice(var_10_0)

	arg_10_0.cdTm = os.time()

	g_Bubble:bubbleInfo(a2u("лл\xC4\xFA\xB5ķ\xB4\xC0\xA1,\xCE\xD2\xC3ǻ\xE1\xBC\xCC\xD0\xF8Ŭ\xC1\xA6!"))
	arg_10_0.inputBox:setText("")
end

function var_0_0.onTouchTest(arg_11_0)
	local var_11_0 = arg_11_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_11_0.layer, var_11_0.x, var_11_0.y) == false then
		arg_11_0:hide()
	end
end
