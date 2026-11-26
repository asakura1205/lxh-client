require("gamelogic.zbFormationSlot")

local var_0_0 = class("zbFormationSlotPanel")

var_0_0.__index = var_0_0

function createFormationSlotPanel(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	local function var_2_0()
		arg_2_0.wndParent = arg_2_1
		arg_2_0.slots = {}
		arg_2_0.tableview = nil
		arg_2_0.tableviewHelper = nil
	end

	local function var_2_1()
		arg_2_0.nodeSlots = tolua.cast(arg_2_2:getChildByTag(2), "CCNode")
		arg_2_0.layerGarbages = {}
		arg_2_0.layerGarbages[1] = tolua.cast(arg_2_2:getChildByTag(101), "CCNode")
		arg_2_0.layerGarbages[2] = tolua.cast(arg_2_2:getChildByTag(102), "CCNode")
		arg_2_0.layerGarbages[3] = tolua.cast(arg_2_2:getChildByTag(103), "CCNode")
		arg_2_0.layerGarbages[4] = tolua.cast(arg_2_2:getChildByTag(104), "CCNode")

		local var_4_0 = tolua.cast(arg_2_0.nodeSlots:getChildByTag(1), "CCNode")
		local var_4_1 = {}

		var_4_1[1] = 1
		var_4_1[2] = 4
		var_4_1[3] = 7
		var_4_1[4] = 2
		var_4_1[5] = 5
		var_4_1[6] = 8
		var_4_1[7] = 3
		var_4_1[8] = 6
		var_4_1[9] = 9
		var_4_1[10] = 10
		var_4_1[11] = 11
		var_4_1[12] = 12

		for iter_4_0 = 1, 12 do
			local var_4_2 = zbTableViewHelper:create()

			var_4_2:loadCCBFile("ccbi/tb_formation_slot.ccbi")

			local var_4_3 = var_4_1[iter_4_0]
			local var_4_4 = tolua.cast(var_4_0:getChildByTag(var_4_3), "CCLayerColor")
			local var_4_5 = zbFormationSlot:create(translateAndStrokeHelper(var_4_2:readCCBNode()), var_4_3, arg_2_0.layerGarbages, arg_2_1)

			var_4_5:setContentSize(var_4_4:getContentSize())
			var_4_5:setAnchorPoint(var_4_4:getAnchorPoint())
			var_4_5:setPosition(var_4_4:getPosition())
			var_4_0:addChild(var_4_5)
			var_4_4:removeFromParentAndCleanup(true)

			arg_2_0.slots[var_4_3] = var_4_5

			var_4_2:releaseSelf()
		end
	end

	var_2_0()
	var_2_1()
end

function var_0_0.free(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.slots) do
		iter_5_1:free()
	end
end

function var_0_0.refresh(arg_6_0, arg_6_1)
	arg_6_0:refreshSlots(arg_6_1)
end

function var_0_0.refreshSlots(arg_7_0, arg_7_1)
	local var_7_0 = 0.1

	local function var_7_1(arg_8_0, arg_8_1)
		local function var_8_0()
			arg_8_0:refresh()
		end

		local var_8_1 = CCArray:create()

		var_8_1:addObject(CCDelayTime:create(var_7_0))
		var_8_1:addObject(CCCallFuncN:create(var_8_0))
		arg_8_0:clear()
		arg_8_0:stopAllActions()
		arg_8_0:runAction(CCSequence:create(var_8_1))

		var_7_0 = var_7_0 + arg_8_1
	end

	for iter_7_0, iter_7_1 in pairs(arg_7_0.slots) do
		if g_Self.kFormation.slots[iter_7_1.slotIndex] ~= 0 and arg_7_1 == true then
			var_7_1(iter_7_1, 0.15)
		else
			iter_7_1:refresh()
		end
	end
end

function var_0_0.showSlotFormationTip(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.slots) do
		iter_10_1:showSlotFormationTip(arg_10_1)
	end
end

function var_0_0.hideSlotFormationTip(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.slots) do
		iter_11_1:hideSlotFormationTip()
	end
end

function var_0_0.onTouchDown(arg_12_0)
	local var_12_0 = zbTechTable:getRecord(g_Self.kFormation.techId)

	g_MainScene:showFormationTip(var_12_0)
end

function var_0_0.onTouchEnd(arg_13_0)
	g_MainScene:hideFormationTip()
end
