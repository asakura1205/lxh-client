require("gamecore.buff.zbBaseBuff")

zbAddMp = class("zbAddMp", zbBaseBuff)
zbAddMp.__index = zbAddMp

function zbAddMp.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	local var_1_0 = zbAddMp.new()

	var_1_0:initBase(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	var_1_0:initMy()

	return var_1_0
end

function zbAddMp.initMy(arg_2_0)
	arg_2_0.hero:addBuffRoundMp(arg_2_0.param1)
end

function zbAddMp.free(arg_3_0)
	arg_3_0.hero:addBuffRoundMp(-arg_3_0.param1)
end

function zbAddMp.newRound(arg_4_0)
	return
end

function zbAddMp.update(arg_5_0, arg_5_1)
	return
end

function zbAddMp.isDebuff(arg_6_0)
	return arg_6_0.param1 < 0
end
