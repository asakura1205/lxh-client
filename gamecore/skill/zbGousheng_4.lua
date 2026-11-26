require("gamecore.skill.zbBaseNormalAttack")

zbGousheng_4 = class("zbGousheng_4", zbBaseSkill)
zbGousheng_4.__index = zbGousheng_4

function zbGousheng_4.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbGousheng_4.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbGousheng_4.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.passiveTriggerType = EPassiveTriggerType.InitShow
end

function zbGousheng_4.action(arg_3_0)
	arg_3_0:popupSkillBubble()
end

function zbGousheng_4.getDamageRatio(arg_4_0, arg_4_1)
	return 0.5
end
