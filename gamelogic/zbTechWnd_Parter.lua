require("gamelogic.zbTechItem")

local var_0_0 = class("zbTechWnd_Parter")

var_0_0.__index = var_0_0

function createTechWnd_Parter(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	local function var_2_0()
		arg_2_0.parentWnd = arg_2_1
		arg_2_0.node = arg_2_2
		arg_2_0.items = {}
	end

	local function var_2_1()
		local var_4_0 = tolua.cast(arg_2_2:getChildByTag(99), "CCNode")

		arg_2_0.effect = createUIAnimation()

		arg_2_0.effect:refresh("effect/spine/ui_keji_04/ui_keji_04.json", "effect/spine/ui_keji_04/ui_keji_04.atlas")
		arg_2_0.effect:setPosition(0, 0)
		arg_2_0.effect:setAnchorPoint(ccp(0.5, 0.5))
		arg_2_0.effect:setAnimation("animation", true)
		var_4_0:addChild(arg_2_0.effect)

		for iter_4_0, iter_4_1 in pairs(zbTechTable.records) do
			if iter_4_1.type == ETechType.Parter then
				local var_4_1 = tolua.cast(arg_2_2:getChildByTag(iter_4_1.id), "CCNode")
				local var_4_2 = zbTableViewHelper:create()

				var_4_2:loadCCBFile("ccbi/tb_techItem.ccbi")

				local var_4_3 = ccp(var_4_1:getPosition())
				local var_4_4 = createTechItem(translateAndStrokeHelper(var_4_2:readCCBNode()), iter_4_1.id, arg_2_0, arg_2_2, var_4_3)

				var_4_4:setPosition(var_4_3)
				arg_2_2:addChild(var_4_4)
				var_4_1:removeFromParentAndCleanup(true)
				table.insert(arg_2_0.items, var_4_4)
				var_4_2:releaseSelf()
			end
		end
	end

	var_2_0()
	var_2_1()
end

function var_0_0.refresh(arg_5_0)
	local var_5_0 = false

	for iter_5_0, iter_5_1 in pairs(arg_5_0.items) do
		if iter_5_1:refresh() == true then
			var_5_0 = true
		end
	end

	return var_5_0
end
