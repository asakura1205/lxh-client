require("gamecore.skill.zbBaseMissileAttack")

zbKali_3 = class("zbKali_3", zbBaseSkill)
zbKali_3.__index = zbKali_3

function zbKali_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbKali_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbKali_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hero.targetDebuffDamageAddSkill = arg_2_0

	arg_2_0.hero:addTargetDebuffDamageAddRatio(0.2)
	arg_2_0.hero:addTargetDebuffDamageAddAbs(arg_2_0:getDamageAbs())
end
