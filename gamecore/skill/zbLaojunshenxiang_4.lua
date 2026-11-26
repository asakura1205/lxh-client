require("gamecore.skill.zbBaseSkill")

zbLaojunshenxiang_4 = class("zbLaojunshenxiang_4", zbBaseSkill)
zbLaojunshenxiang_4.__index = zbLaojunshenxiang_4

function zbLaojunshenxiang_4.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbLaojunshenxiang_4.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbLaojunshenxiang_4.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
end

function zbLaojunshenxiang_4.action(arg_3_0)
	return
end
