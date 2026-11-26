require("gamelogic.zbTechItem")

local var_0_0 = class("zbTechWnd_Hero")

var_0_0.__index = var_0_0

function createTechWnd_Hero(arg_1_0, arg_1_1)
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

		arg_2_0.effect:refresh("effect/spine/ui_keji_01/ui_keji_01.json", "effect/spine/ui_keji_01/ui_keji_01.atlas")
		arg_2_0.effect:setPosition(0, 0)
		arg_2_0.effect:setAnchorPoint(ccp(0.5, 0.5))
		arg_2_0.effect:setAnimation("animation", true)
		var_4_0:addChild(arg_2_0.effect)

		for iter_4_0, iter_4_1 in pairs(zbTechTable.records) do
			if iter_4_1.type == ETechType.Hero then
				local var_4_1 = zbTableViewHelper:create()

				var_4_1:loadCCBFile("ccbi/tb_techItem.ccbi")

				local var_4_2 = tolua.cast(arg_2_2:getChildByTag(iter_4_1.id), "CCNode")
				local var_4_3 = ccp(var_4_2:getPosition())
				local var_4_4 = createTechItem(translateAndStrokeHelper(var_4_1:readCCBNode()), iter_4_1.id, arg_2_0, arg_2_2, var_4_3)

				var_4_4:setPosition(var_4_3)
				arg_2_2:addChild(var_4_4)
				var_4_2:removeFromParentAndCleanup(true)
				table.insert(arg_2_0.items, var_4_4)
				var_4_1:releaseSelf()
			end
		end

		arg_2_0.lbBlood = tolua.cast(arg_2_2:getChildByTag(13), "CCLabelTTF")
		arg_2_0.lbPOff = tolua.cast(arg_2_2:getChildByTag(11), "CCLabelTTF")
		arg_2_0.lbSOff = tolua.cast(arg_2_2:getChildByTag(12), "CCLabelTTF")
		arg_2_0.lbPDef = tolua.cast(arg_2_2:getChildByTag(14), "CCLabelTTF")
		arg_2_0.lbSDef = tolua.cast(arg_2_2:getChildByTag(15), "CCLabelTTF")
		arg_2_0.lbDesc = tolua.cast(arg_2_2:getChildByTag(16), "CCLabelTTF")
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

		local var_5_1 = zbTechTable:getRecord(iter_5_1.id)

		if var_5_1 ~= nil and var_5_1.attrType1 ~= 0 then
			local var_5_2 = g_Self.kTechHandler:getStudyedTech(iter_5_1.id)
			local var_5_3 = 0

			if var_5_2 then
				var_5_3 = var_5_2.Level * var_5_1.attrGrowth1 + var_5_1.attrBase1
			end

			local var_5_4 = getItemPropStr(var_5_1.attrType1) .. " +" .. var_5_3

			if var_5_1.id == 1001 then
				arg_5_0.lbPOff:setString(a2u(var_5_4))
			elseif var_5_1.id == 1002 then
				arg_5_0.lbSOff:setString(a2u(var_5_4))
			elseif var_5_1.id == 1003 then
				arg_5_0.lbBlood:setString(a2u(var_5_4))
			elseif var_5_1.id == 1004 then
				arg_5_0.lbPDef:setString(a2u(var_5_4))
			elseif var_5_1.id == 1005 then
				arg_5_0.lbSDef:setString(a2u(var_5_4))
			elseif var_5_1.id == 1006 then
				arg_5_0.lbDesc:setString(a2u(var_5_4))
			end
		end
	end

	return var_5_0
end
