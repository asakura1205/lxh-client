require("gamecore.skill.zbBaseSkill")

zbBaozoubidiu_3 = class("zbBaozoubidiu_3", zbBaseSkill)
zbBaozoubidiu_3.__index = zbBaozoubidiu_3

function zbBaozoubidiu_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbBaozoubidiu_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbBaozoubidiu_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
end

function zbBaozoubidiu_3.action(arg_3_0)
	return
end
