require("gamecore.buff.zbBaseBuff")

zbMiscSuolian = class("zbMiscSuolian", zbBaseBuff)
zbMiscSuolian.__index = zbMiscSuolian

function zbMiscSuolian.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	local var_1_0 = zbMiscSuolian.new()

	var_1_0:initBase(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	var_1_0:initMy()

	return var_1_0
end

function zbMiscSuolian.initMy(arg_2_0)
	return
end

function zbMiscSuolian.free(arg_3_0)
	return
end

function zbMiscSuolian.newRound(arg_4_0)
	return
end

function zbMiscSuolian.update(arg_5_0, arg_5_1)
	return
end

function zbMiscSuolian.isDebuff(arg_6_0)
	return true
end
