require("gamecore.skill.zbBaseSkill")

zbHeixiu1301_4 = class("zbHeixiu1301_4", zbBaseSkill)
zbHeixiu1301_4.__index = zbHeixiu1301_4

function zbHeixiu1301_4.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbHeixiu1301_4.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbHeixiu1301_4.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.passiveTriggerType = EPassiveTriggerType.Beattacked
	arg_2_0.hitFrame = 0.2
	arg_2_0.sequenceName = ANIMATION_SEQUENCE_SHOW
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbHeixiu1301_4.action(arg_3_0)
	arg_3_0.actioning = false

	if zbCombatFormula:isSucceedRate(300) then
		arg_3_0:popupSkillBubble()
		arg_3_0.hero:addHp(arg_3_0.hero.maxHp * 0.05 + arg_3_0:getDamageAbs(), false, 1)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, 2001)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, 2002)
	end
end
