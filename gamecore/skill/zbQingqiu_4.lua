require("gamecore.skill.zbBaseSkill")

zbQingqiu_4 = class("zbQingqiu_4", zbBaseSkill)
zbQingqiu_4.__index = zbQingqiu_4

function zbQingqiu_4.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbQingqiu_4.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbQingqiu_4.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Random_5
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hero.zhongshangTargetDamageAddPercent = arg_2_0:getDamageRatio()
	arg_2_0.hero.zhongshangTargetDamageAddAbs = arg_2_0:getDamageAbs()
end

function zbQingqiu_4.action(arg_3_0)
	return
end

function zbQingqiu_4.getDamageRatio(arg_4_0, arg_4_1)
	return 0.2
end
