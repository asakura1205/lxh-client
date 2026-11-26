require("gamecore.buff.zbBaseBuff")

zbControlChaofeng = class("zbControlChaofeng", zbBaseBuff)
zbControlChaofeng.__index = zbControlChaofeng

function zbControlChaofeng.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	local var_1_0 = zbControlChaofeng.new()

	var_1_0:initBase(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	var_1_0:initMy()

	return var_1_0
end

function zbControlChaofeng.initMy(arg_2_0)
	arg_2_0.removeWhenDied = true

	arg_2_0.hero:setChaofengSrc(arg_2_0.attacker)
end

function zbControlChaofeng.free(arg_3_0)
	arg_3_0.hero:setChaofengSrc(nil)
end

function zbControlChaofeng.newRound(arg_4_0)
	return
end

function zbControlChaofeng.update(arg_5_0, arg_5_1)
	return
end

function zbControlChaofeng.isDebuff(arg_6_0)
	return true
end
