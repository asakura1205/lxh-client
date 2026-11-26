require("gamecore.buff.zbBaseBuff")

zbAddPhysicDefend = class("zbAddPhysicDefend", zbBaseBuff)
zbAddPhysicDefend.__index = zbAddPhysicDefend

function zbAddPhysicDefend.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	local var_1_0 = zbAddPhysicDefend.new()

	var_1_0:initBase(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	var_1_0:initMy()

	return var_1_0
end

function zbAddPhysicDefend.initMy(arg_2_0)
	arg_2_0.hero:addPhysicDefend(arg_2_0.param1)
end

function zbAddPhysicDefend.free(arg_3_0)
	arg_3_0.hero:addPhysicDefend(-arg_3_0.param1)
end

function zbAddPhysicDefend.newRound(arg_4_0)
	return
end

function zbAddPhysicDefend.update(arg_5_0, arg_5_1)
	return
end

function zbAddPhysicDefend.isDebuff(arg_6_0)
	return arg_6_0.param1 < 0
end
