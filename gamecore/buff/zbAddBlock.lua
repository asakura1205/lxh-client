require("gamecore.buff.zbBaseBuff")

zbAddBlock = class("zbAddBlock", zbBaseBuff)
zbAddBlock.__index = zbAddBlock

function zbAddBlock.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	local var_1_0 = zbAddBlock.new()

	var_1_0:initBase(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	var_1_0:initMy()

	return var_1_0
end

function zbAddBlock.initMy(arg_2_0)
	arg_2_0.hero:addBlock(arg_2_0.param1)
end

function zbAddBlock.free(arg_3_0)
	arg_3_0.hero:addBlock(-arg_3_0.param1)
end

function zbAddBlock.newRound(arg_4_0)
	return
end

function zbAddBlock.update(arg_5_0, arg_5_1)
	return
end

function zbAddBlock.isDebuff(arg_6_0)
	return arg_6_0.param1 < 0
end
