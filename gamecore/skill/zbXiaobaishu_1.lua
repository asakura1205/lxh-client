require("gamecore.skill.zbBaseNormalAttackSuperSkill")

zbXiaobaishu_1 = class("zbXiaobaishu_1", zbBaseNormalAttackSuperSkill)
zbXiaobaishu_1.__index = zbXiaobaishu_1

function zbXiaobaishu_1.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbXiaobaishu_1.new()

	var_1_0:init(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbXiaobaishu_1.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Default
	arg_2_0.subTargetType = ESubTargetType.Column
	arg_2_0.hitFrame = 1.0666666666666667
end

function zbXiaobaishu_1.getDamageRatio(arg_3_0, arg_3_1)
	return 1.5
end
