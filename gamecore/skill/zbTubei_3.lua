require("gamecore.skill.zbBaseNormalAttack")

zbTubei_3 = class("zbTubei_3", zbBaseSkill)
zbTubei_3.__index = zbTubei_3

function zbTubei_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbTubei_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbTubei_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.passiveTriggerType = EPassiveTriggerType.Beattacked

	arg_2_0.hero:addPMReduceRate(0.3)
	arg_2_0.hero:addPMReduceRatio(0.5)
	arg_2_0.hero:addPMReduce(arg_2_0:getDamageAbs())

	arg_2_0.hero.pmReduceSkill = arg_2_0
end

function zbTubei_3.action(arg_3_0)
	arg_3_0.actioning = false

	if arg_3_0.hero.lastAttacker == nil or zbCombatFormula:isSucceedRate(300) == false then
		return
	end

	arg_3_0:popupSkillBubble()
	arg_3_0.hero.lastAttacker:addMp(-10)
	g_CombatBubble:showBubble(arg_3_0.hero.lastAttacker, ECombatBubble.MpDown, 0, 0, 1)
end
