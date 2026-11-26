require("gamecore.skill.zbBaseSkill")

zbBidiu_4 = class("zbBidiu_4", zbBaseSkill)
zbBidiu_4.__index = zbBidiu_4

function zbBidiu_4.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbBidiu_4.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbBidiu_4.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hero.damage2CureRate = 0.3
	arg_2_0.hero.damage2CureSkill = arg_2_0
end

function zbBidiu_4.action(arg_3_0)
	return
end

function zbBidiu_4.getCureValue(arg_4_0, arg_4_1)
	return arg_4_0.hero.maxHp * 0.05 + arg_4_0:getDamageAbs()
end
