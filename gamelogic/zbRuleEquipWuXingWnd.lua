require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbRuleEquipWuXingWnd", zbBaseWnd)

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

function createRuleEquipWuXingWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.items = {}
		arg_3_0.itemsMoney = {}
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/rule_equipwuxing.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")

		arg_3_0.touchLayer = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")
		arg_3_0.lbRule1 = tolua.cast(arg_3_0.touchLayer:getChildByTag(1001), "CCLabelTTF")
		arg_3_0.lbRule2 = tolua.cast(arg_3_0.touchLayer:getChildByTag(1002), "CCLabelTTF")
		arg_3_0.lbRule3 = tolua.cast(arg_3_0.touchLayer:getChildByTag(1003), "CCLabelTTF")
		arg_3_0.btnClose = tolua.cast(arg_3_0.touchLayer:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)

		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_8_0)
	return
end

function var_0_0.onTouchTest(arg_9_0)
	local var_9_0 = arg_9_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_9_0.touchLayer, var_9_0.x, var_9_0.y) == false and zbUtil:PointInCtrl(arg_9_0.btnClose, var_9_0.x, var_9_0.y) == false then
		arg_9_0:hide()
	end
end
