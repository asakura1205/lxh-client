require("gamecore.buff.zbBaseBuff")

zbImmuneAll = class("zbImmuneAll", zbBaseBuff)
zbImmuneAll.__index = zbImmuneAll

function zbImmuneAll.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	local var_1_0 = zbImmuneAll.new()

	var_1_0:initBase(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	var_1_0:initMy()

	return var_1_0
end

function zbImmuneAll.initMy(arg_2_0)
	arg_2_0.hero:setImmunePhysic(true)
	arg_2_0.hero:setImmuneMagic(true)
end

function zbImmuneAll.free(arg_3_0)
	arg_3_0.hero:setImmunePhysic(false)
	arg_3_0.hero:setImmuneMagic(false)
end

function zbImmuneAll.newRound(arg_4_0)
	arg_4_0.hero:setImmunePhysic(true)
	arg_4_0.hero:setImmuneMagic(true)
end

function zbImmuneAll.update(arg_5_0, arg_5_1)
	return
end

function zbImmuneAll.isDebuff(arg_6_0)
	return false
end
