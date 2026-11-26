require("gamecore.skill.zbBaseSkill")

zbJiuxian_4 = class("zbJiuxian_4", zbBaseSkill)
zbJiuxian_4.__index = zbJiuxian_4

function zbJiuxian_4.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbJiuxian_4.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbJiuxian_4.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.passiveTriggerType = EPassiveTriggerType.InitShow
end

function zbJiuxian_4.action(arg_3_0)
	arg_3_0:popupSkillBubble()

	arg_3_0.hero.jiuxianPutongDamageAddRatio = 0.07
	arg_3_0.hero.jiuxianPutongDamageAddAbs = arg_3_0:getDamageAbs()
end
