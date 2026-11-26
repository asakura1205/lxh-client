require("gamecore.buff.zbBaseBuff")

zbAddMagicDefend = class("zbAddMagicDefend", zbBaseBuff)
zbAddMagicDefend.__index = zbAddMagicDefend

function zbAddMagicDefend.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	local var_1_0 = zbAddMagicDefend.new()

	var_1_0:initBase(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	var_1_0:initMy()

	return var_1_0
end

function zbAddMagicDefend.initMy(arg_2_0)
	arg_2_0.hero:addMagicDefend(arg_2_0.param1)
end

function zbAddMagicDefend.free(arg_3_0)
	arg_3_0.hero:addMagicDefend(-arg_3_0.param1)
end

function zbAddMagicDefend.newRound(arg_4_0)
	return
end

function zbAddMagicDefend.update(arg_5_0, arg_5_1)
	return
end

function zbAddMagicDefend.isDebuff(arg_6_0)
	return arg_6_0.param1 < 0
end
