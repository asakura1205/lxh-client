require("gamecore.skill.zbBaseSkill")

zbMuluoxianren_3 = class("zbMuluoxianren_3", zbBaseSkill)
zbMuluoxianren_3.__index = zbMuluoxianren_3

function zbMuluoxianren_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbMuluoxianren_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbMuluoxianren_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.passiveTriggerType = EPassiveTriggerType.InitShow
	arg_2_0.hero.muluoSkill3 = arg_2_0
end

function zbMuluoxianren_3.action(arg_3_0)
	arg_3_0:popupSkillBubble()
end

function zbMuluoxianren_3.getDamageRatio(arg_4_0, arg_4_1)
	return 0.2
end
