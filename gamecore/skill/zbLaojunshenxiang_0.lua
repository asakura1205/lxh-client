require("gamecore.skill.zbBaseSkill")

zbLaojunshenxiang_0 = class("zbLaojunshenxiang_0", zbBaseSkill)
zbLaojunshenxiang_0.__index = zbLaojunshenxiang_0

function zbLaojunshenxiang_0.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbLaojunshenxiang_0.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbLaojunshenxiang_0.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
end

function zbLaojunshenxiang_0.action(arg_3_0)
	return
end
