require("gamecore.skill.zbBaseSkill")

zbLaojunshenxiang_3 = class("zbLaojunshenxiang_3", zbBaseSkill)
zbLaojunshenxiang_3.__index = zbLaojunshenxiang_3

function zbLaojunshenxiang_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbLaojunshenxiang_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbLaojunshenxiang_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
end

function zbLaojunshenxiang_3.action(arg_3_0)
	return
end
