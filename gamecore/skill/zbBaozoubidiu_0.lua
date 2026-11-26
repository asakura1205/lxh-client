require("gamecore.skill.zbBaseNormalAttack")

zbBaozoubidiu_0 = class("zbBaozoubidiu_0", zbBaseNormalAttack)
zbBaozoubidiu_0.__index = zbBaozoubidiu_0

function zbBaozoubidiu_0.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbBaozoubidiu_0.new()

	var_1_0:init(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbBaozoubidiu_0.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Default
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 1.1333333333333333
end

function zbBaozoubidiu_0.getDamageRatio(arg_3_0, arg_3_1)
	return 1
end
