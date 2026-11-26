require("gamecore.buff.zbBaseBuff")

zbAddViolent = class("zbAddViolent", zbBaseBuff)
zbAddViolent.__index = zbAddViolent

function zbAddViolent.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	local var_1_0 = zbAddViolent.new()

	var_1_0:initBase(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	var_1_0:initMy()

	return var_1_0
end

function zbAddViolent.initMy(arg_2_0)
	arg_2_0.hero:addViolent(arg_2_0.param1)
end

function zbAddViolent.free(arg_3_0)
	arg_3_0.hero:addViolent(-arg_3_0.param1)
end

function zbAddViolent.newRound(arg_4_0)
	return
end

function zbAddViolent.update(arg_5_0, arg_5_1)
	return
end

function zbAddViolent.isDebuff(arg_6_0)
	return arg_6_0.param1 < 0
end
