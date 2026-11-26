require("gamecore.buff.zbBaseBuff")

zbAddDodge = class("zbAddDodge", zbBaseBuff)
zbAddDodge.__index = zbAddDodge

function zbAddDodge.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	local var_1_0 = zbAddDodge.new()

	var_1_0:initBase(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	var_1_0:initMy()

	return var_1_0
end

function zbAddDodge.initMy(arg_2_0)
	arg_2_0.hero:addDodge(arg_2_0.param1)
end

function zbAddDodge.free(arg_3_0)
	arg_3_0.hero:addDodge(-arg_3_0.param1)
end

function zbAddDodge.newRound(arg_4_0)
	return
end

function zbAddDodge.update(arg_5_0, arg_5_1)
	return
end

function zbAddDodge.isDebuff(arg_6_0)
	return arg_6_0.param1 < 0
end
