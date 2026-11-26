require("gamecore.skill.zbBaseSkill")

zbLaojunshenxiang_1 = class("zbLaojunshenxiang_1", zbBaseSkill)
zbLaojunshenxiang_1.__index = zbLaojunshenxiang_1

function zbLaojunshenxiang_1.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbLaojunshenxiang_1.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbLaojunshenxiang_1.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
end

function zbLaojunshenxiang_1.action(arg_3_0)
	return
end
