require("gamecore.skill.zbBaseSkill")

zbXiaoji_3 = class("zbXiaoji_3", zbBaseSkill)
zbXiaoji_3.__index = zbXiaoji_3

function zbXiaoji_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbXiaoji_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbXiaoji_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.passiveTriggerType = EPassiveTriggerType.InitShow
end

function zbXiaoji_3.action(arg_3_0)
	arg_3_0:popupSkillBubble()
	arg_3_0.hero:addExtraPhysicDamageDefendRatio(0.2)
	arg_3_0.hero:addExtraMagicDamageDefendRatio(0.2)
	arg_3_0.hero:addExtraPhysicDamageDefendAbs(arg_3_0:getDamageAbs())
	arg_3_0.hero:addExtraMagicDamageDefendAbs(arg_3_0:getDamageAbs())
	g_CombatBubble:showBubble(arg_3_0.hero, ECombatBubble.PhysicMagicDefendUp, 0, 0, 1)

	arg_3_0.hero.maxDamageHpPercentEnable = true
	arg_3_0.hero.maxDamageHpPercent = 0.3
end
