require("gamecore.zbEffectDefine")
require("gamecore.effect.zbSpineBombEffect")
require("gamecore.effect.zbSpineInstantEffect")
require("gamecore.effect.zbSpineMissileEffect")
require("gamecore.effect.zbSpineMissileEffectPos")
require("gamecore.effect.zbSpineMissileEffectPos2")
require("gamecore.effect.zbSpineDazhaoScreenEffect")
require("gamecore.effect.zbCameraShake")

zbEffectSystem = class("zbEffectSystem")
zbEffectSystem.__index = zbEffectSystem

function zbEffectSystem.create(arg_1_0)
	local var_1_0 = zbEffectSystem.new()

	var_1_0:init()

	return var_1_0
end

function zbEffectSystem.init(arg_2_0)
	arg_2_0.effectList = {}
	arg_2_0.cameraShake = zbCameraShake:create()
end

function zbEffectSystem.free(arg_3_0)
	for iter_3_0, iter_3_1 in pairs(arg_3_0.effectList) do
		iter_3_1:free()
	end

	arg_3_0.effectList = {}
end

function zbEffectSystem.clear(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.effectList) do
		iter_4_1:free()
	end

	arg_4_0.effectList = {}
end

function zbEffectSystem.removeByHero(arg_5_0, arg_5_1)
	for iter_5_0 = #arg_5_0.effectList, 1, -1 do
		local var_5_0 = arg_5_0.effectList[iter_5_0]

		if var_5_0.hero ~= nil and var_5_0.hero:isSame(arg_5_1) then
			var_5_0:free()
			table.remove(arg_5_0.effectList, iter_5_0)
		end
	end
end

function zbEffectSystem.update(arg_6_0, arg_6_1)
	for iter_6_0 = #arg_6_0.effectList, 1, -1 do
		local var_6_0 = arg_6_0.effectList[iter_6_0]

		var_6_0:update(arg_6_1)

		if var_6_0:isEnd() == true then
			var_6_0:free()
			table.remove(arg_6_0.effectList, iter_6_0)
		end
	end

	arg_6_0.cameraShake:update(arg_6_1)
end

function zbEffectSystem.createBombEffect(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6, arg_7_7)
	local var_7_0 = zbEffectTable:getRecord(arg_7_4)

	if var_7_0 == nil then
		echo("warning: invalid createBombEffect, can not find effectId=" .. arg_7_4)

		return nil
	end

	if var_7_0.ccbi == "" then
		echo("warning: invalid createBombEffect: empty json")

		return nil
	end

	local var_7_1 = var_7_0.ccbi .. ".json"
	local var_7_2 = var_7_0.ccbi .. ".atlas"
	local var_7_3 = zbSpineBombEffect:create(arg_7_1, arg_7_2, arg_7_3, var_7_1, var_7_2, var_7_0, arg_7_5, arg_7_6, arg_7_7)

	table.insert(arg_7_0.effectList, var_7_3)

	return var_7_3
end

function zbEffectSystem.createInstantEffect(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = zbEffectTable:getRecord(arg_8_2)

	if var_8_0 == nil then
		echo("warning: invalid createInstantEffect, can not find effectId=" .. arg_8_2)

		return nil
	end

	if var_8_0.ccbi == "" then
		echo("warning: invalid createInstantEffect: empty json")

		return nil
	end

	local var_8_1 = var_8_0.ccbi .. ".json"
	local var_8_2 = var_8_0.ccbi .. ".atlas"
	local var_8_3 = zbSpineInstantEffect:create(arg_8_1, var_8_1, var_8_2, var_8_0, arg_8_3)

	table.insert(arg_8_0.effectList, var_8_3)

	return var_8_3
end

function zbEffectSystem.createMissileEffect(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = zbEffectTable:getRecord(arg_9_3.skillRecord.flyEffectId)

	if var_9_0 == nil then
		echo("warning: invalid createMissileEffect, can not find effectId=" .. arg_9_3.skillRecord.flyEffectId)

		return nil
	end

	if var_9_0.ccbi == "" then
		echo("warning: invalid createMissileEffect: empty json")

		return nil
	end

	local var_9_1 = var_9_0.ccbi .. ".json"
	local var_9_2 = var_9_0.ccbi .. ".atlas"
	local var_9_3 = zbSpineMissileEffect:create(arg_9_1, arg_9_2, arg_9_3, var_9_0, var_9_1, var_9_2)

	table.insert(arg_9_0.effectList, var_9_3)

	return var_9_3
end

function zbEffectSystem.createMissileEffectPos(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6, arg_10_7, arg_10_8)
	local var_10_0 = zbEffectTable:getRecord(arg_10_7)

	if var_10_0 == nil then
		echo("warning: invalid createMissileEffectPos, can not find effectId=" .. arg_10_7)

		return nil
	end

	if var_10_0.ccbi == "" then
		echo("warning: invalid createMissileEffectPos: empty json")

		return nil
	end

	local var_10_1 = var_10_0.ccbi .. ".json"
	local var_10_2 = var_10_0.ccbi .. ".atlas"
	local var_10_3 = zbSpineMissileEffectPos:create(arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6, var_10_0, var_10_1, var_10_2, arg_10_8)

	table.insert(arg_10_0.effectList, var_10_3)

	return var_10_3
end

function zbEffectSystem.createMissileEffectPos2(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6)
	local var_11_0 = zbEffectTable:getRecord(arg_11_6)

	if var_11_0 == nil then
		echo("warning: invalid createMissileEffectPos2, can not find effectId=" .. arg_11_6)

		return nil
	end

	if var_11_0.ccbi == "" then
		echo("warning: invalid createMissileEffectPos2: empty json")

		return nil
	end

	local var_11_1 = var_11_0.ccbi .. ".json"
	local var_11_2 = var_11_0.ccbi .. ".atlas"
	local var_11_3 = zbSpineMissileEffectPos2:create(arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, var_11_0, var_11_1, var_11_2)

	table.insert(arg_11_0.effectList, var_11_3)

	return var_11_3
end

function zbEffectSystem.createDazhaoScreenEffect(arg_12_0, arg_12_1)
	local var_12_0 = zbSpineDazhaoScreenEffect:create(arg_12_1)

	table.insert(arg_12_0.effectList, var_12_0)

	return var_12_0
end

function zbEffectSystem.createCommonCureEffect(arg_13_0, arg_13_1)
	g_EffectSystem:createInstantEffect(arg_13_1, 2001)
	g_EffectSystem:createInstantEffect(arg_13_1, 2002)
end

function zbEffectSystem.creatScrollEffect(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = createUIAnimation()

	if arg_14_2 == ECommonAwardType.HeroFrag then
		var_14_0:refresh("effect/spine/ui_wupinkuang5/ui_wupinkuang5.json", "effect/spine/ui_wupinkuang5/ui_wupinkuang5.atlas")
	elseif arg_14_2 == ECommonAwardType.EquipFrag then
		var_14_0:refresh("effect/spine/ui_wupinkuang2/ui_wupinkuang2.json", "effect/spine/ui_wupinkuang2/ui_wupinkuang2.atlas")
	else
		var_14_0:refresh("effect/spine/ui_wupinkuang1/ui_wupinkuang1.json", "effect/spine/ui_wupinkuang1/ui_wupinkuang1.atlas")
	end

	var_14_0:setAnchorPoint(ccp(0, 0))
	var_14_0:setPosition(arg_14_1:getContentSize().width / 2, arg_14_1:getContentSize().height / 2)
	var_14_0:setZOrder(ZORDER_BOTTOM)
	var_14_0:setScale(1.08)
	arg_14_1:addChild(var_14_0, 0)

	return var_14_0
end

function zbEffectSystem.creatGemEffect(arg_15_0, arg_15_1)
	local var_15_0 = createUIAnimation()

	var_15_0:refresh("effect/spine/zhuangbeikuang5/zhuangbeikuang5.json", "effect/spine/zhuangbeikuang5/zhuangbeikuang5.atlas")
	var_15_0:setAnchorPoint(ccp(0, 0))
	var_15_0:setPosition(arg_15_1:getContentSize().width / 2, arg_15_1:getContentSize().height / 2)
	var_15_0:setZOrder(ZORDER_BOTTOM)
	var_15_0:setScale(1.08)
	arg_15_1:addChild(var_15_0, 0)

	return var_15_0
end

function zbEffectSystem.removeByEffectId(arg_16_0, arg_16_1, arg_16_2)
	for iter_16_0 = #arg_16_0.effectList, 1, -1 do
		local var_16_0 = arg_16_0.effectList[iter_16_0]

		if var_16_0.effectRecord ~= nil and var_16_0.effectRecord.id == arg_16_2 and var_16_0.hero:isSame(arg_16_1) then
			var_16_0:free()
			table.remove(arg_16_0.effectList, iter_16_0)
		end
	end
end

function zbEffectSystem.shake(arg_17_0)
	arg_17_0.cameraShake:shake()
end
