require("gamecore.buff.zbBaseBuff")

zbShieldReduce = class("zbShieldReduce", zbBaseBuff)
zbShieldReduce.__index = zbShieldReduce

function zbShieldReduce.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	local var_1_0 = zbShieldReduce.new()

	var_1_0:initBase(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	var_1_0:initMy()

	return var_1_0
end

function zbShieldReduce.initMy(arg_2_0)
	arg_2_0.removeWhenDied = true
	arg_2_0.hero.roundReduceEnable = true
	arg_2_0.hero.roundReduceRatio = arg_2_0.param1
	arg_2_0.hero.roundReduceAbs = arg_2_0.param2
end

function zbShieldReduce.free(arg_3_0)
	arg_3_0.hero.roundReduceEnable = false
	arg_3_0.hero.roundReduceRatio = 0
	arg_3_0.hero.roundReduceAbs = 0
end

function zbShieldReduce.newRound(arg_4_0)
	return
end

function zbShieldReduce.update(arg_5_0, arg_5_1)
	return
end

function zbShieldReduce.isDebuff(arg_6_0)
	return false
end
