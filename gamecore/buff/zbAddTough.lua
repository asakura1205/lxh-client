require("gamecore.buff.zbBaseBuff")

zbAddTough = class("zbAddTough", zbBaseBuff)
zbAddTough.__index = zbAddTough

function zbAddTough.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	local var_1_0 = zbAddTough.new()

	var_1_0:initBase(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	var_1_0:initMy()

	return var_1_0
end

function zbAddTough.initMy(arg_2_0)
	arg_2_0.hero:addTough(arg_2_0.param1)
end

function zbAddTough.free(arg_3_0)
	arg_3_0.hero:addTough(-arg_3_0.param1)
end

function zbAddTough.newRound(arg_4_0)
	return
end

function zbAddTough.update(arg_5_0, arg_5_1)
	return
end

function zbAddTough.isDebuff(arg_6_0)
	return arg_6_0.param1 < 0
end
