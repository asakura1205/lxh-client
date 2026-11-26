require("gamecore.buff.zbBaseBuff")

zbAddPierceDamage = class("zbAddPierceDamage", zbBaseBuff)
zbAddPierceDamage.__index = zbAddPierceDamage

function zbAddPierceDamage.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	local var_1_0 = zbAddPierceDamage.new()

	var_1_0:initBase(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	var_1_0:initMy()

	return var_1_0
end

function zbAddPierceDamage.initMy(arg_2_0)
	arg_2_0.hero:addPierceDamage(arg_2_0.param1)
end

function zbAddPierceDamage.free(arg_3_0)
	arg_3_0.hero:addPierceDamage(-arg_3_0.param1)
end

function zbAddPierceDamage.newRound(arg_4_0)
	return
end

function zbAddPierceDamage.update(arg_5_0, arg_5_1)
	return
end

function zbAddPierceDamage.isDebuff(arg_6_0)
	return arg_6_0.param1 < 0
end
