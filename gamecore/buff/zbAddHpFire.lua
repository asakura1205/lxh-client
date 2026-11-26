require("gamecore.buff.zbBaseBuff")

zbAddHpFire = class("zbAddHpFire", zbBaseBuff)
zbAddHpFire.__index = zbAddHpFire

function zbAddHpFire.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	local var_1_0 = zbAddHpFire.new()

	var_1_0:initBase(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	var_1_0:initMy()

	return var_1_0
end

function zbAddHpFire.initMy(arg_2_0)
	arg_2_0.hero:addBuffRoundHp(arg_2_0.param1)
end

function zbAddHpFire.free(arg_3_0)
	arg_3_0.hero:addBuffRoundHp(-arg_3_0.param1)
end

function zbAddHpFire.newRound(arg_4_0)
	return
end

function zbAddHpFire.update(arg_5_0, arg_5_1)
	return
end

function zbAddHpFire.isDebuff(arg_6_0)
	return arg_6_0.param1 < 0
end
