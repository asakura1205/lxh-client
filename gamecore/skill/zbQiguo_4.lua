require("gamecore.skill.zbBaseSkill")

zbQiguo_4 = class("zbQiguo_4", zbBaseSkill)
zbQiguo_4.__index = zbQiguo_4

function zbQiguo_4.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbQiguo_4.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbQiguo_4.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.passiveTriggerType = EPassiveTriggerType.InitShow
end

function zbQiguo_4.action(arg_3_0)
	arg_3_0:popupSkillBubble()
end

function zbQiguo_4.getDamageRatio(arg_4_0, arg_4_1)
	return 0.2
end
