require("gamelogic.zbBaseWnd")
require("gamelogic.zbBalanceDataItem")

local var_0_0 = class("zbBalanceDataWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createBalanceDataWnd()
	local var_1_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

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
		arg_3_0.dataItemsLeft = {}
		arg_3_0.dataItemsRight = {}
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/balance_data.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.layer = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		for iter_5_0 = 1, 5 do
			local var_5_3 = zbTableViewHelper:create()

			var_5_3:loadCCBFile("ccbi/tb_damage_left.ccbi")

			local var_5_4 = tolua.cast(var_5_2:getChildByTag(10 + iter_5_0), "CCLayerColor")
			local var_5_5 = zbDamageStatItem:create(var_5_3:readCCBNode(), ForceType.Left, iter_5_0)

			arg_3_0.dataItemsLeft[iter_5_0] = var_5_5

			var_5_5:setPosition(var_5_4:getPosition())
			var_5_5:setAnchorPoint(var_5_4:getAnchorPoint())
			var_5_2:addChild(var_5_5)
			var_5_4:removeFromParentAndCleanup(true)
			var_5_3:releaseSelf()
		end

		for iter_5_1 = 1, 5 do
			local var_5_6 = zbTableViewHelper:create()

			var_5_6:loadCCBFile("ccbi/tb_damage_right.ccbi")

			local var_5_7 = tolua.cast(var_5_2:getChildByTag(20 + iter_5_1), "CCLayerColor")
			local var_5_8 = zbDamageStatItem:create(var_5_6:readCCBNode(), ForceType.Right, iter_5_1)

			arg_3_0.dataItemsRight[iter_5_1] = var_5_8

			var_5_8:setPosition(var_5_7:getPosition())
			var_5_8:setAnchorPoint(var_5_7:getAnchorPoint())
			var_5_2:addChild(var_5_8)
			var_5_7:removeFromParentAndCleanup(true)
			var_5_6:releaseSelf()
		end

		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.dataItemsLeft) do
		iter_8_1:refresh()
	end

	for iter_8_2, iter_8_3 in pairs(arg_8_0.dataItemsRight) do
		iter_8_3:refresh()
	end
end

function var_0_0.onTouchTest(arg_9_0)
	local var_9_0 = arg_9_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_9_0.layer, var_9_0.x, var_9_0.y) == false and zbUtil:PointInCtrl(arg_9_0.btnClose, var_9_0.x, var_9_0.y) == false then
		arg_9_0:hide()
	end
end
