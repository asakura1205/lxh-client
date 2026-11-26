require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbWorldBoxWnd", zbBaseWnd)

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

function createWorldBoxWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNodeRGBA:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.record = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/world_box.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner", false, false)
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.layer = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.lbDesc = tolua.cast(var_5_2:getChildByTag(1001), "CCLabelTTF")
		arg_3_0.nodeClose = tolua.cast(var_5_2:getChildByTag(2), "CCNode")
		arg_3_0.btnOpen = tolua.cast(arg_3_0.nodeClose:getChildByTag(1), "CCControlButton")
		arg_3_0.lbOpen = tolua.cast(arg_3_0.nodeClose:getChildByTag(2), "CCLabelTTF")
		arg_3_0.nodeOpen = tolua.cast(var_5_2:getChildByTag(3), "CCNode")
		arg_3_0.btnClose = tolua.cast(arg_3_0.nodeOpen:getChildByTag(31), "CCControlButton")

		arg_3_0.btnOpen:addHandleOfControlEvent(function()
			arg_3_0:onOpen()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(handler(arg_3_0, arg_3_0.doShow))
	arg_3_0:setHideCallback(handler(arg_3_0, arg_3_0.doHide))
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onOpenAck()
	end, zbGameEvent.Event_AwardBoxAck)
end

function var_0_0.doShow(arg_10_0)
	if g_MainScene.wndWorld then
		g_MainScene.wndWorld.wordMap:setLayerTouchEnabled(false)
	end
end

function var_0_0.doHide(arg_11_0)
	if g_MainScene.wndWorld then
		g_MainScene.wndWorld.wordMap:setLayerTouchEnabled(true)
	end
end

function var_0_0.refresh(arg_12_0, arg_12_1)
	arg_12_0.nodeClose:setVisible(true)
	arg_12_0.nodeOpen:setVisible(false)

	arg_12_0.record = arg_12_1
end

function var_0_0.onOpen(arg_13_0)
	if arg_13_0.record then
		g_WsMsgHandler:WS_WorldSpe_AwardBox_Req(arg_13_0.record.id)
	end
end

function var_0_0.onOpenAck(arg_14_0)
	arg_14_0.nodeClose:setVisible(false)
	arg_14_0.nodeOpen:setVisible(true)
end

function var_0_0.onTouchTest(arg_15_0)
	local var_15_0 = arg_15_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_15_0.layer, var_15_0.x, var_15_0.y) == false then
		arg_15_0:hide()
	end
end
