require("gamecore.skill.zbBaseSkill")

zbSatan_3 = class("zbSatan_3", zbBaseSkill)
zbSatan_3.__index = zbSatan_3

function zbSatan_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbSatan_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbSatan_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.passiveTriggerType = EPassiveTriggerType.InitShow
end

function zbSatan_3.action(arg_3_0)
	arg_3_0.actioning = false

	arg_3_0:popupSkillBubble()
	arg_3_0.hero:addPMReduceRate(0.3)
	arg_3_0.hero:addPMReduceRatio(0.5)
	arg_3_0.hero:addPMReduce(arg_3_0:getDamageAbs())

	arg_3_0.hero.pmReduceSkill = arg_3_0
end

function zbSatan_3.getDamageRatio(arg_4_0, arg_4_1)
	return 1
end
