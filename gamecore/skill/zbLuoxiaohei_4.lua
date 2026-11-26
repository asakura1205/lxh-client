require("gamecore.skill.zbBaseSkill")

zbLuoxiaohei_4 = class("zbLuoxiaohei_4", zbBaseSkill)
zbLuoxiaohei_4.__index = zbLuoxiaohei_4

function zbLuoxiaohei_4.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbLuoxiaohei_4.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbLuoxiaohei_4.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Default
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hero.lxhSkill4 = arg_2_0
	arg_2_0.hero.lxhSkill4Rate = 0.3
end

function zbLuoxiaohei_4.action(arg_3_0)
	return
end

function zbLuoxiaohei_4.getDamageRatio(arg_4_0, arg_4_1)
	return 1
end
