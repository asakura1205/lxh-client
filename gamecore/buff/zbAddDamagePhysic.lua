require("gamecore.buff.zbBaseBuff")

zbAddDamagePhysic = class("zbAddDamagePhysic", zbBaseBuff)
zbAddDamagePhysic.__index = zbAddDamagePhysic

function zbAddDamagePhysic.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	local var_1_0 = zbAddDamagePhysic.new()

	var_1_0:initBase(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	var_1_0:initMy()

	return var_1_0
end

function zbAddDamagePhysic.initMy(arg_2_0)
	arg_2_0.hero:addExtraPhysicDamageRatio(arg_2_0.param1)
	arg_2_0.hero:addExtraPhysicDamageAbs(arg_2_0.param2)

	if math.abs(arg_2_0.param1) > 10 then
		echo("------------------- warning: mage param ----------------------")
	end
end

function zbAddDamagePhysic.free(arg_3_0)
	arg_3_0.hero:addExtraPhysicDamageRatio(-arg_3_0.param1)
	arg_3_0.hero:addExtraPhysicDamageAbs(-arg_3_0.param2)
end

function zbAddDamagePhysic.newRound(arg_4_0)
	return
end

function zbAddDamagePhysic.update(arg_5_0, arg_5_1)
	return
end

function zbAddDamagePhysic.isDebuff(arg_6_0)
	return arg_6_0.param1 < 0
end
