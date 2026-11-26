require("gamecore.skill.zbBaseNormalAttack")

zbXiaobaiba_4 = class("zbXiaobaiba_4", zbBaseSkill)
zbXiaobaiba_4.__index = zbXiaobaiba_4

function zbXiaobaiba_4.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbXiaobaiba_4.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbXiaobaiba_4.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hero.zhongduTargetDamageAddPercent = arg_2_0:getDamageRatio()
	arg_2_0.hero.zhongduTargetDamageAddAbs = arg_2_0:getDamageAbs()
end

function zbXiaobaiba_4.action(arg_3_0)
	return
end

function zbXiaobaiba_4.getDamageRatio(arg_4_0, arg_4_1)
	return 0.4
end
