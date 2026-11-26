require("gamecore.buff.zbBaseBuff")

zbControlChenmo = class("zbControlChenmo", zbBaseBuff)
zbControlChenmo.__index = zbControlChenmo

function zbControlChenmo.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	local var_1_0 = zbControlChenmo.new()

	var_1_0:initBase(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	var_1_0:initMy()

	return var_1_0
end

function zbControlChenmo.initMy(arg_2_0)
	arg_2_0.removeWhenDied = true

	arg_2_0.hero:setChenmo(true)
end

function zbControlChenmo.free(arg_3_0)
	arg_3_0.hero:setChenmo(false)
end

function zbControlChenmo.newRound(arg_4_0)
	arg_4_0.hero:setChenmo(true)
end

function zbControlChenmo.update(arg_5_0, arg_5_1)
	arg_5_0.hero:setChenmo(true)
end

function zbControlChenmo.isDebuff(arg_6_0)
	return true
end
