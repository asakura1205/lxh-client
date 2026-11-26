require("gamecore.buff.zbBaseBuff")

zbAddHit = class("zbAddHit", zbBaseBuff)
zbAddHit.__index = zbAddHit

function zbAddHit.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	local var_1_0 = zbAddHit.new()

	var_1_0:initBase(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	var_1_0:initMy()

	return var_1_0
end

function zbAddHit.initMy(arg_2_0)
	arg_2_0.hero:addHit(arg_2_0.param1)
end

function zbAddHit.free(arg_3_0)
	arg_3_0.hero:addHit(-arg_3_0.param1)
end

function zbAddHit.newRound(arg_4_0)
	return
end

function zbAddHit.update(arg_5_0, arg_5_1)
	return
end

function zbAddHit.isDebuff(arg_6_0)
	return arg_6_0.param1 < 0
end
