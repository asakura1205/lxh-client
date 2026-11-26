require("gamecore.skill.zbBaseSkill")

zbQianzhen_3 = class("zbQianzhen_3", zbBaseSkill)
zbQianzhen_3.__index = zbQianzhen_3

function zbQianzhen_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbQianzhen_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbQianzhen_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Random_5
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.passiveTriggerType = EPassiveTriggerType.InitShow
	arg_2_0.hero.qianzhenSkill3 = arg_2_0
end

function zbQianzhen_3.action(arg_3_0)
	arg_3_0.hero.doubleAttackRate = 0.2
end

function zbQianzhen_3.actionEx(arg_4_0, arg_4_1)
	arg_4_0.hero:addHp(arg_4_1 * 0.1 + arg_4_0:getDamageAbs(), false, 1)
	g_EffectSystem:createInstantEffect(arg_4_0.hero, 2001)
	g_EffectSystem:createInstantEffect(arg_4_0.hero, 2002)
end

function zbQianzhen_3.getDamageRatio(arg_5_0, arg_5_1)
	return 0.1
end
