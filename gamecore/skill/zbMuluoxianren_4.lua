require("gamecore.skill.zbBaseSkill")

zbMuluoxianren_4 = class("zbMuluoxianren_4", zbBaseSkill)
zbMuluoxianren_4.__index = zbMuluoxianren_4

function zbMuluoxianren_4.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbMuluoxianren_4.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbMuluoxianren_4.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hero.muluoSkill4 = arg_2_0
end

function zbMuluoxianren_4.action(arg_3_0)
	return
end

function zbMuluoxianren_4.getDamageRatio(arg_4_0, arg_4_1)
	return 0.2
end
