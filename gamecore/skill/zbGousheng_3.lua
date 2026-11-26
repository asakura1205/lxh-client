require("gamecore.skill.zbBaseNormalAttack")

zbGousheng_3 = class("zbGousheng_3", zbBaseSkill)
zbGousheng_3.__index = zbGousheng_3

function zbGousheng_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbGousheng_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbGousheng_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.passiveTriggerType = EPassiveTriggerType.InitShow
	arg_2_0.hero.goushengSkill3 = arg_2_0
end

function zbGousheng_3.action(arg_3_0)
	arg_3_0:popupSkillBubble()
end

function zbGousheng_3.actionEx(arg_4_0, arg_4_1)
	local var_4_0 = BUFF_TYPE_PROPERTY_TOUGH
	local var_4_1 = -arg_4_1.baseTough * 0.2 - arg_4_0:getDamageAbs() * 10
	local var_4_2 = 0
	local var_4_3 = 2

	g_BuffSystem:createBuff(arg_4_0.hero, arg_4_1, var_4_0, var_4_1, var_4_2, var_4_3)
end
