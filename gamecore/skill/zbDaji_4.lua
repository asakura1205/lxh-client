require("gamecore.skill.zbBaseSkill")

zbDaji_4 = class("zbDaji_4", zbBaseSkill)
zbDaji_4.__index = zbDaji_4

function zbDaji_4.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbDaji_4.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbDaji_4.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Random_5
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.passiveTriggerType = EPassiveTriggerType.Died_Begin
	arg_2_0.triggered = false
end

function zbDaji_4.action(arg_3_0)
	if arg_3_0.triggered then
		return
	end

	arg_3_0.triggered = true
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.getn(arg_3_0.targetList) == 0 then
		return
	end

	arg_3_0:popupSkillBubble()

	for iter_3_0, iter_3_1 in pairs(arg_3_0.targetList) do
		local var_3_0, var_3_1, var_3_2 = g_CombatFormula:calcDamage(arg_3_0.hero, iter_3_1, arg_3_0)

		if var_3_1 > 0 then
			iter_3_1:playBehitAnimation(arg_3_0.skillRecord.hitEffectId, arg_3_0)
		end
	end
end

function zbDaji_4.getDamageRatio(arg_4_0, arg_4_1)
	return 0.3
end
