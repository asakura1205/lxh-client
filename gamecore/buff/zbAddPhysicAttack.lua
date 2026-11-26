require("gamecore.buff.zbBaseBuff")

zbAddPhysicAttack = class("zbAddPhysicAttack", zbBaseBuff)
zbAddPhysicAttack.__index = zbAddPhysicAttack

function zbAddPhysicAttack.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	local var_1_0 = zbAddPhysicAttack.new()

	var_1_0:initBase(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	var_1_0:initMy()

	return var_1_0
end

function zbAddPhysicAttack.initMy(arg_2_0)
	arg_2_0.hero:addPhysicAttack(arg_2_0.param1)
end

function zbAddPhysicAttack.free(arg_3_0)
	arg_3_0.hero:addPhysicAttack(-arg_3_0.param1)
end

function zbAddPhysicAttack.newRound(arg_4_0)
	return
end

function zbAddPhysicAttack.update(arg_5_0, arg_5_1)
	return
end

function zbAddPhysicAttack.isDebuff(arg_6_0)
	return arg_6_0.param1 < 0
end
