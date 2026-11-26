require("gamebase.zbFunctions")
require("gamelogic.zbEquipDecomposeSlot")

local var_0_0 = class("zbEquipDecomposeItem", CCNodeExtend)

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

function createEquipDecomposeItem(arg_2_0, arg_2_1)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0, arg_2_1)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2)
	function initMember()
		arg_3_0.data = nil
		arg_3_0.equipNode = nil
		arg_3_0.index = arg_3_2
	end

	function initCCB()
		arg_3_0.btnAdd = tolua.cast(arg_3_1:getChildByTag(1), "CCControlButton")
		arg_3_0.ccNode = arg_3_1

		local var_5_0 = zbTableViewHelper:create()

		var_5_0:loadCCBFile("ccbi/tb_decomposeitem.ccbi")

		local var_5_1 = tolua.cast(arg_3_1:getChildByTag(2), "CCNode")

		var_5_1:setVisible(false)

		arg_3_0.equipNode = createEquipDecomposeSlot(translateAndStrokeHelper(var_5_0:readCCBNode()), arg_3_0.index)

		arg_3_0.equipNode:setPosition(var_5_1:getPosition())
		arg_3_1:addChild(arg_3_0.equipNode)
		arg_3_0.btnAdd:addHandleOfControlEvent(function()
			arg_3_0:btnMatCallback()
		end, CCControlEventTouchUpInside)
		var_5_0:releaseSelf()
	end

	initMember()
	initCCB()
	arg_3_0:refresh(nil, 1)
end

function var_0_0.refresh(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_2 < 1 then
		arg_7_2 = 1
	end

	if arg_7_0.data == nil and arg_7_1 ~= nil then
		local var_7_0 = CCArray:create()

		var_7_0:addObject(CCDelayTime:create(0.2 * (arg_7_2 - 1)))
		var_7_0:addObject(CCCallFuncN:create(function()
			arg_7_0:showItem()
		end))
		var_7_0:addObject(CCScaleTo:create(0.1, 1.05))
		var_7_0:addObject(CCScaleTo:create(0.1, 1))

		local var_7_1 = CCSequence:create(var_7_0)

		arg_7_0.equipNode:stopAllActions()
		arg_7_0.equipNode:runAction(var_7_1)
	end

	if arg_7_1 == nil then
		zbUIEffect:runFadeToAction(arg_7_0.btnAdd)
	end

	arg_7_0.data = arg_7_1

	if arg_7_0.data == nil then
		arg_7_0.btnAdd:setVisible(true)
		arg_7_0.equipNode:setVisible(false)

		return
	end
end

function var_0_0.showItem(arg_9_0)
	arg_9_0.ccNode:setVisible(true)

	if arg_9_0.data ~= nil then
		arg_9_0.btnAdd:setVisible(false)
		arg_9_0.equipNode:setVisible(true)
		arg_9_0.equipNode:refresh(arg_9_0.data)
	end
end

function var_0_0.btnMatCallback(arg_10_0)
	local var_10_0 = g_MainScene.wndEquipDecompose.selectedList

	echo("...................", table.getn(var_10_0))
	g_MainScene:showEquipDecomposeSelect(var_10_0, arg_10_0.index)
end
