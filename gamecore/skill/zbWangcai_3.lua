require("gamecore.skill.zbBaseSkill")

zbWangcai_3 = class("zbWangcai_3", zbBaseSkill)
zbWangcai_3.__index = zbWangcai_3

function zbWangcai_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbWangcai_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbWangcai_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.passiveTriggerType = EPassiveTriggerType.InitShow
end

function zbWangcai_3.action(arg_3_0)
	arg_3_0.actioning = false

	arg_3_0.hero:addPMReduceRate(0.3)
	arg_3_0.hero:addPMReduceRatio(0.5)
	arg_3_0.hero:addPMReduce(arg_3_0:getDamageAbs())

	arg_3_0.hero.pmReduceSkill = arg_3_0

	arg_3_0:popupSkillBubble()
end
