require("gamecore.skill.zbBaseNormalAttack")

zbYandi_3 = class("zbYandi_3", zbBaseSkill)
zbYandi_3.__index = zbYandi_3

function zbYandi_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbYandi_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbYandi_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.passiveTriggerType = EPassiveTriggerType.InitShow
end

function zbYandi_3.action(arg_3_0)
	arg_3_0:popupSkillBubble()

	arg_3_0.hero.targetDebuffDamageAddSkill = arg_3_0

	arg_3_0.hero:addTargetDebuffDamageAddRatio(0.2)
	arg_3_0.hero:addTargetDebuffDamageAddAbs(arg_3_0:getDamageAbs())
end
