require("gamecore.skill.zbBaseSkill")

zbChouchou_3 = class("zbChouchou_3", zbBaseSkill)
zbChouchou_3.__index = zbChouchou_3

function zbChouchou_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbChouchou_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbChouchou_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hero.targetDebuffDamageAddSkill = arg_2_0

	arg_2_0.hero:addTargetDebuffDamageAddRatio(0.4)
	arg_2_0.hero:addTargetDebuffDamageAddAbs(arg_2_0:getDamageAbs())
end
