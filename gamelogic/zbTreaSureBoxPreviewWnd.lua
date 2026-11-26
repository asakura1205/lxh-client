require("gamelogic.zbBaseWnd")
require("gamelogic.zbItem")

local var_0_0 = class("zbTreaSureBoxPreviewWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createTreaSureBoxPreviewWnd()
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
		arg_3_0.awardItems = {}
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/treasureboxview.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		for iter_5_0 = 1, 3 do
			local var_5_3 = tolua.cast(var_5_2:getChildByTag(iter_5_0), "CCLayerColor")
			local var_5_4 = createItem()

			var_5_4:setPosition(var_5_3:getPosition())
			var_5_2:addChild(var_5_4)
			var_5_3:removeFromParentAndCleanup(true)

			arg_3_0.awardItems[iter_5_0] = var_5_4
		end

		arg_3_0.centerPositionX = arg_3_0.awardItems[2]:getPositionX()
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")
		arg_3_0.spriteTitle = tolua.cast(var_5_2:getChildByTag(4), "CCSprite")
		arg_3_0.btnGetAward = tolua.cast(var_5_2:getChildByTag(5), "CCControlButton")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")
		arg_3_0.layerTouchTest = var_5_2

		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.awardItems) do
		iter_8_1:setVisible(false)
	end

	local var_8_0 = 1

	for iter_8_2, iter_8_3 in pairs(arg_8_1) do
		local var_8_1 = arg_8_0.awardItems[var_8_0]

		if var_8_1 ~= nil then
			var_8_1:refreshAward(iter_8_3.Type, iter_8_3.Id, iter_8_3.Count)
			var_8_1:setVisible(true)
		end

		var_8_0 = var_8_0 + 1
	end

	zbUIEffect:centerStar(arg_8_0.awardItems, arg_8_0.centerPositionX)
end

function var_0_0.onTouchTest(arg_9_0)
	local var_9_0 = arg_9_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_9_0.layerTouchTest, var_9_0.x, var_9_0.y) == false then
		arg_9_0:hide()
	end
end
