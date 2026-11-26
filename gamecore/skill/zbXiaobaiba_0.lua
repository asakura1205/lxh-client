require("gamecore.skill.zbBaseNormalAttack")

zbXiaobaiba_0 = class("zbXiaobaiba_0", zbBaseNormalAttack)
zbXiaobaiba_0.__index = zbXiaobaiba_0

function zbXiaobaiba_0.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbXiaobaiba_0.new()

	var_1_0:init(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbXiaobaiba_0.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Default
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 0.6
end

function zbXiaobaiba_0.getDamageRatio(arg_3_0, arg_3_1)
	return 1
end
