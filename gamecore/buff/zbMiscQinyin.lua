require("gamecore.buff.zbBaseBuff")

zbMiscQinyin = class("zbMiscQinyin", zbBaseBuff)
zbMiscQinyin.__index = zbMiscQinyin

function zbMiscQinyin.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	local var_1_0 = zbMiscQinyin.new()

	var_1_0:initBase(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	var_1_0:initMy()

	return var_1_0
end

function zbMiscQinyin.initMy(arg_2_0)
	arg_2_0.hero:setQinyin(true, arg_2_0.param1)
end

function zbMiscQinyin.free(arg_3_0)
	arg_3_0.hero:setQinyin(false, 0)
end

function zbMiscQinyin.newRound(arg_4_0)
	return
end

function zbMiscQinyin.update(arg_5_0, arg_5_1)
	return
end

function zbMiscQinyin.isDebuff(arg_6_0)
	return false
end
