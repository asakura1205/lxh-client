require("gamecore.buff.zbBaseBuff")

zbAddHpZhongdu = class("zbAddHpZhongdu", zbBaseBuff)
zbAddHpZhongdu.__index = zbAddHpZhongdu

function zbAddHpZhongdu.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	local var_1_0 = zbAddHpZhongdu.new()

	var_1_0:initBase(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	var_1_0:initMy()

	return var_1_0
end

function zbAddHpZhongdu.initMy(arg_2_0)
	arg_2_0.hero:addBuffRoundHp(arg_2_0.param1)

	if arg_2_0.param1 < 0 then
		arg_2_0.hero:setZhongdu(true)
	end
end

function zbAddHpZhongdu.free(arg_3_0)
	arg_3_0.hero:addBuffRoundHp(-arg_3_0.param1)

	if arg_3_0.param1 < 0 then
		arg_3_0.hero:setZhongdu(false)
	end
end

function zbAddHpZhongdu.newRound(arg_4_0)
	return
end

function zbAddHpZhongdu.update(arg_5_0, arg_5_1)
	return
end

function zbAddHpZhongdu.isDebuff(arg_6_0)
	return arg_6_0.param1 < 0
end
