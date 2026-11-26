require("gamecore.skill.zbBaseSkill")

zbBaoxiannan_3 = class("zbBaoxiannan_3", zbBaseSkill)
zbBaoxiannan_3.__index = zbBaoxiannan_3

function zbBaoxiannan_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbBaoxiannan_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbBaoxiannan_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hero.damage2CureRate = 0.5
	arg_2_0.hero.damage2CureSkill = arg_2_0
end

function zbBaoxiannan_3.action(arg_3_0)
	return
end

function zbBaoxiannan_3.getCureValue(arg_4_0, arg_4_1)
	return arg_4_0.hero.magicAttack * 0.2 + arg_4_0:getDamageAbs()
end
