require("gamecore.buff.zbBaseBuff")

zbAddDamageMagic = class("zbAddDamageMagic", zbBaseBuff)
zbAddDamageMagic.__index = zbAddDamageMagic

function zbAddDamageMagic.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	local var_1_0 = zbAddDamageMagic.new()

	var_1_0:initBase(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	var_1_0:initMy()

	return var_1_0
end

function zbAddDamageMagic.initMy(arg_2_0)
	arg_2_0.hero:addExtraMagicDamageRatio(arg_2_0.param1)
	arg_2_0.hero:addExtraMagicDamageAbs(arg_2_0.param2)

	if math.abs(arg_2_0.param1) > 10 then
		echo("------------------- warning: mage param ----------------------")
	end
end

function zbAddDamageMagic.free(arg_3_0)
	arg_3_0.hero:addExtraMagicDamageRatio(-arg_3_0.param1)
	arg_3_0.hero:addExtraMagicDamageAbs(-arg_3_0.param2)
end

function zbAddDamageMagic.newRound(arg_4_0)
	return
end

function zbAddDamageMagic.update(arg_5_0, arg_5_1)
	return
end

function zbAddDamageMagic.isDebuff(arg_6_0)
	return arg_6_0.param1 < 0
end
