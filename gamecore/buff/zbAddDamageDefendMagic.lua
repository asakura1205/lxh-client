require("gamecore.buff.zbBaseBuff")

zbAddDamageDefendMagic = class("zbAddDamageDefendMagic", zbBaseBuff)
zbAddDamageDefendMagic.__index = zbAddDamageDefendMagic

function zbAddDamageDefendMagic.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	local var_1_0 = zbAddDamageDefendMagic.new()

	var_1_0:initBase(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	var_1_0:initMy()

	return var_1_0
end

function zbAddDamageDefendMagic.initMy(arg_2_0)
	arg_2_0.hero:addExtraMagicDamageDefendRatio(arg_2_0.param1)
	arg_2_0.hero:addExtraMagicDamageDefendAbs(arg_2_0.param2)

	if math.abs(arg_2_0.param1) > 10 then
		echo("------------------- warning: mage param ----------------------")
	end
end

function zbAddDamageDefendMagic.free(arg_3_0)
	arg_3_0.hero:removeExtraMagicDamageDefendRatio(-arg_3_0.param1)
	arg_3_0.hero:addExtraMagicDamageDefendAbs(-arg_3_0.param2)
end

function zbAddDamageDefendMagic.newRound(arg_4_0)
	return
end

function zbAddDamageDefendMagic.update(arg_5_0, arg_5_1)
	return
end

function zbAddDamageDefendMagic.isDebuff(arg_6_0)
	return arg_6_0.param1 < 0
end
