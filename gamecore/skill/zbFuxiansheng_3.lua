require("gamecore.skill.zbBaseSkill")

zbFuxiansheng_3 = class("zbFuxiansheng_3", zbBaseSkill)
zbFuxiansheng_3.__index = zbFuxiansheng_3

function zbFuxiansheng_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbFuxiansheng_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbFuxiansheng_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.passiveTriggerType = EPassiveTriggerType.InitShow
	arg_2_0.hero.fxsSkill3 = arg_2_0
	arg_2_0.hero.zhongshangTargetReduceRate = 1
	arg_2_0.hero.zhongshangTargetReduceRatio = 0.4
	arg_2_0.hero.zhongshangTargetReduceAbs = arg_2_0:getDamageAbs()
end

function zbFuxiansheng_3.action(arg_3_0)
	return
end
