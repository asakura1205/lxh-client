require("gamecore.skill.zbBaseNormalAttack")

zbBaozoubidiu_2 = class("zbBaozoubidiu_2", zbBaseNormalAttack)
zbBaozoubidiu_2.__index = zbBaozoubidiu_2

function zbBaozoubidiu_2.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbBaozoubidiu_2.new()

	var_1_0:init(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbBaozoubidiu_2.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Default
	arg_2_0.subTargetType = ESubTargetType.Column
	arg_2_0.hitFrame = 1.1666666666666667
end

function zbBaozoubidiu_2.getDamageRatio(arg_3_0, arg_3_1)
	return 1
end
