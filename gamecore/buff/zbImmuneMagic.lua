require("gamecore.buff.zbBaseBuff")

zbImmuneMagic = class("zbImmuneMagic", zbBaseBuff)
zbImmuneMagic.__index = zbImmuneMagic

function zbImmuneMagic.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	local var_1_0 = zbImmuneMagic.new()

	var_1_0:initBase(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	var_1_0:initMy()

	return var_1_0
end

function zbImmuneMagic.initMy(arg_2_0)
	arg_2_0.hero:setImmuneMagic(true)
end

function zbImmuneMagic.free(arg_3_0)
	arg_3_0.hero:setImmuneMagic(false)
end

function zbImmuneMagic.newRound(arg_4_0)
	arg_4_0.hero:setImmuneMagic(true)
end

function zbImmuneMagic.update(arg_5_0, arg_5_1)
	return
end

function zbImmuneMagic.isDebuff(arg_6_0)
	return false
end
