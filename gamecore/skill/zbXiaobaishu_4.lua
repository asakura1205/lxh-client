require("gamecore.skill.zbBaseSkill")

zbXiaobaishu_4 = class("zbXiaobaishu_4", zbBaseSkill)
zbXiaobaishu_4.__index = zbXiaobaishu_4

function zbXiaobaishu_4.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbXiaobaishu_4.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbXiaobaishu_4.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.passiveTriggerType = EPassiveTriggerType.InitShow
end

function zbXiaobaishu_4.action(arg_3_0)
	arg_3_0.actioning = false

	arg_3_0.hero:addPMReduceRate(0.3)
	arg_3_0.hero:addPMReduceRatio(0.5)
	arg_3_0.hero:addPMReduce(arg_3_0:getDamageAbs())

	arg_3_0.hero.pmReduceSkill = arg_3_0

	arg_3_0:popupSkillBubble()
end

function zbXiaobaishu_4.getDamageRatio(arg_4_0, arg_4_1)
	return 1
end
