require("gamecore.zbSceneObject")

local var_0_0 = class("zbCityBuilding", zbSceneObject)

var_0_0.__index = var_0_0

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.buidlingId = arg_1_1
end

function var_0_0.free(arg_2_0)
	return
end

function var_0_0.update(arg_3_0, arg_3_1)
	return
end

function var_0_0.appear(arg_4_0)
	return
end

function var_0_0.disappear(arg_5_0)
	return
end

function var_0_0.create(arg_6_0, arg_6_1)
	local var_6_0 = var_0_0.new()

	var_6_0:init(arg_6_1)

	return var_6_0
end
