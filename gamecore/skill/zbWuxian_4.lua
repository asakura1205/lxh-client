require("gamecore.skill.zbBaseSkill")

zbWuxian_4 = class("zbWuxian_4", zbBaseSkill)
zbWuxian_4.__index = zbWuxian_4

function zbWuxian_4.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbWuxian_4.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbWuxian_4.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.passiveTriggerType = EPassiveTriggerType.InitShow
	arg_2_0.hero.wuxianSkill4 = arg_2_0
end

function zbWuxian_4.action(arg_3_0)
	arg_3_0:popupSkillBubble()
end

function zbWuxian_4.getDamageRatio(arg_4_0, arg_4_1)
	return 0.2
end
