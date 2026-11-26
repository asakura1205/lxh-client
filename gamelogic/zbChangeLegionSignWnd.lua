require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbChangeLegionSignWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createChangeLegionSignWnd()
	local var_1_0 = var_0_0.extend(zbBaseWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create()))))

	var_1_0:initBase()
	var_1_0:init()

	return var_1_0
end

function var_0_0.extend(arg_2_0)
	local var_2_0 = tolua.getpeer(arg_2_0)

	if not var_2_0 then
		var_2_0 = {}

		tolua.setpeer(arg_2_0, var_2_0)
	end

	setmetatable(var_2_0, var_0_0)

	return arg_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		return
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/legionsignchange.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")

		arg_3_0.signlayer = tolua.cast(var_5_1:getChildByTag(1), "CCLayerColor")
		arg_3_0.btnSure_sign = tolua.cast(arg_3_0.signlayer:getChildByTag(4), "CCControlButton")

		arg_3_0.btnSure_sign:addHandleOfControlEvent(function()
			arg_3_0:onSure()
		end, CCControlEventTouchUpInside)

		arg_3_0.btnClose = tolua.cast(arg_3_0.signlayer:getChildByTag(2), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)

		local var_5_2 = tolua.cast(arg_3_0.signlayer:getChildByTag(3), "CCLayer")
		local var_5_3 = 50
		local var_5_4 = ccc3(184, 167, 144)

		arg_3_0.inputBox_sign = zbUtil:createEditBox(var_5_2, "", var_5_3, "image/common/button_transparent.png", 22, var_5_4)

		local var_5_5 = var_5_2:getContentSize()

		arg_3_0.inputBox_sign:setpLabelDimensions(CCSizeMake(var_5_5.width - 10, var_5_5.height - 10))
		var_5_2:addChild(arg_3_0.inputBox_sign)

		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:hide()
	end, zbGameEvent.Event_LegionTickOutAck)
end

function var_0_0.refresh(arg_10_0)
	local var_10_0 = ""

	if g_Self.kLegionHandler.legionDetail then
		var_10_0 = g_Self.kLegionHandler.legionDetail.LegionBaseInfo.Signature
	end

	arg_10_0.inputBox_sign:setText(a2u(var_10_0))
end

function var_0_0.onTouchTest(arg_11_0)
	local var_11_0 = arg_11_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_11_0.signlayer, var_11_0.x, var_11_0.y) == false then
		arg_11_0:hide()
	end
end

function var_0_0.onSure(arg_12_0)
	local var_12_0 = string.trim(arg_12_0.inputBox_sign:getText())

	if var_12_0 == "" then
		g_Bubble:bubbleInfo(a2u("\xBB\xE1\xB9ݹ\xAB\xB8治\xC4\xDCΪ\xBF\xD5"))

		return
	end

	if zbUtil:isValidText(var_12_0) == false then
		g_Bubble:bubbleInfo(a2u("\xBA\xAC\xD3зǷ\xA8\xD7ַ\xFB"))

		return
	end

	g_WsMsgHandler:WS_LegionManage_Signature_Req(var_12_0)
	arg_12_0:hide()
end
