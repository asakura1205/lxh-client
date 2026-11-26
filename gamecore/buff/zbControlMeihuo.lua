require("gamecore.buff.zbBaseBuff")

zbControlMeihuo = class("zbControlMeihuo", zbBaseBuff)
zbControlMeihuo.__index = zbControlMeihuo

function zbControlMeihuo.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	local var_1_0 = zbControlMeihuo.new()

	var_1_0:initBase(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	var_1_0:initMy()

	return var_1_0
end

function zbControlMeihuo.initMy(arg_2_0)
	arg_2_0.removeWhenDied = true

	arg_2_0.hero:setMeihuo(true)
end

function zbControlMeihuo.free(arg_3_0)
	arg_3_0.hero:setMeihuo(false)
end

function zbControlMeihuo.newRound(arg_4_0)
	arg_4_0.hero:setMeihuo(true)
end

function zbControlMeihuo.update(arg_5_0, arg_5_1)
	arg_5_0.hero:setMeihuo(true)
end

function zbControlMeihuo.isDebuff(arg_6_0)
	return true
end
