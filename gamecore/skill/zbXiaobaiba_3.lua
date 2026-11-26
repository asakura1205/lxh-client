require("gamecore.skill.zbBaseNormalAttack")

zbXiaobaiba_3 = class("zbXiaobaiba_3", zbBaseSkill)
zbXiaobaiba_3.__index = zbXiaobaiba_3

function zbXiaobaiba_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbXiaobaiba_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbXiaobaiba_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Random_5
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.passiveTriggerType = EPassiveTriggerType.EnemyDied
	arg_2_0.hitFrame = 0.5333333333333333
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbXiaobaiba_3.action(arg_3_0)
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.maxn(arg_3_0.targetList) == 0 then
		return
	end

	arg_3_0:popupSkillBubble()

	for iter_3_0, iter_3_1 in pairs(arg_3_0.targetList) do
		g_CombatFormulaCure:calcCure(arg_3_0.hero, iter_3_1, arg_3_0)
		g_EffectSystem:createInstantEffect(iter_3_1, 2001)
		g_EffectSystem:createInstantEffect(iter_3_1, 2002)
	end
end

function zbXiaobaiba_3.getDamageRatio(arg_4_0, arg_4_1)
	return 0.1
end
