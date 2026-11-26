require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbCDClearWnd", zbBaseWnd)

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

function createCDClearWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNodeRGBA:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.nodeId = 1
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/cd_clear.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner", false, false)
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.layer = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.spriteMoney = tolua.cast(var_5_2:getChildByTag(1), "CCSprite")

		local var_5_3 = tolua.cast(var_5_2:getChildByTag(2), "CCLabelTTF")

		arg_3_0.btnConfirm = tolua.cast(var_5_2:getChildByTag(3), "CCControlButton")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnConfirm:addHandleOfControlEvent(function()
			arg_3_0:onConfirm()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)

		arg_3_0.lbMoney = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_3, arg_3_0.lbMoney)
		arg_3_0.lbMoney:setScale(0.55)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:hide()
	end, zbGameEvent.Event_UpdateNodeInfo)
end

function var_0_0.refresh(arg_10_0, arg_10_1)
	arg_10_0.nodeId = arg_10_1

	arg_10_0.lbMoney:setString(g_DataConfig.kWorldBaseTable.res.clearCDCost)
end

function var_0_0.onConfirm(arg_11_0)
	local var_11_0 = g_DataConfig.kWorldBaseTable.res.clearCDCost

	if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Diamond, var_11_0) == false then
		g_Bubble:bubbleInfo(a2u("\xD7\xEAʯ\xB2\xBB\xD7\xE3"))

		return
	end

	g_WsMsgHandler:WS_WorldRes_ClearCD_Req(arg_11_0.nodeId)
end

function var_0_0.onTouchTest(arg_12_0)
	local var_12_0 = arg_12_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_12_0.layer, var_12_0.x, var_12_0.y) == false then
		arg_12_0:hide()
	end
end
