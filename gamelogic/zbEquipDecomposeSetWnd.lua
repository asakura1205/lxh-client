require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbEquipDecomposeSetWnd", zbBaseWnd)

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

function createEquipDecomposeSetWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		return
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/equipdecomposeset.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayerColor")

		arg_3_0.layerTouchTest = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)

		arg_3_0.spCheck = {}
		arg_3_0.btnSet = {}

		for iter_5_0 = EItemQuality.Blue, EItemQuality.Black do
			local var_5_3 = tolua.cast(var_5_2:getChildByTag(iter_5_0 - 2), "CCNode")

			arg_3_0.spCheck[iter_5_0] = tolua.cast(var_5_3:getChildByTag(3), "CCSprite")
			arg_3_0.btnSet[iter_5_0] = tolua.cast(var_5_3:getChildByTag(2), "CCControlButton")

			arg_3_0.btnSet[iter_5_0]:addHandleOfControlEvent(function()
				arg_3_0:onCheck(iter_5_0)
			end, CCControlEventTouchUpInside)
		end

		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(g_Self.kSetHandler.decomposeSets) do
		arg_9_0.spCheck[iter_9_0]:setVisible(iter_9_1 == 1)
	end
end

function var_0_0.onCheck(arg_10_0, arg_10_1)
	arg_10_0.spCheck[arg_10_1]:setVisible(not arg_10_0.spCheck[arg_10_1]:isVisible())

	local var_10_0 = 0

	if arg_10_0.spCheck[arg_10_1]:isVisible() then
		var_10_0 = 1
	end

	g_Self.kSetHandler:setDecomposeQuality(arg_10_1, var_10_0)
	arg_10_0:refresh()
end

function var_0_0.onTouchTest(arg_11_0)
	local var_11_0 = arg_11_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_11_0.layerTouchTest, var_11_0.x, var_11_0.y) == false and zbUtil:PointInCtrl(arg_11_0.tonumber, var_11_0.x, var_11_0.y) == false then
		arg_11_0:hide()
	end
end
