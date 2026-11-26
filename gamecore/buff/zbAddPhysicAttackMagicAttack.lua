require("gamecore.buff.zbBaseBuff")

zbAddPhysicAttackMagicAttack = class("zbAddPhysicAttackMagicAttack", zbBaseBuff)
zbAddPhysicAttackMagicAttack.__index = zbAddPhysicAttackMagicAttack

function zbAddPhysicAttackMagicAttack.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	local var_1_0 = zbAddPhysicAttackMagicAttack.new()

	var_1_0:initBase(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	var_1_0:initMy()

	return var_1_0
end

function zbAddPhysicAttackMagicAttack.initMy(arg_2_0)
	arg_2_0.hero:addPhysicAttack(arg_2_0.param1)
	arg_2_0.hero:addMagicAttack(arg_2_0.param1)
	arg_2_0.hero:addPhysicAttack(arg_2_0.param2 * arg_2_0.hero.basePhysicAttack)
	arg_2_0.hero:addMagicAttack(arg_2_0.param2 * arg_2_0.hero.baseMagicAttack)
end

function zbAddPhysicAttackMagicAttack.free(arg_3_0)
	arg_3_0.hero:addPhysicAttack(-arg_3_0.param1)
	arg_3_0.hero:addMagicAttack(-arg_3_0.param1)
	arg_3_0.hero:addPhysicAttack(arg_3_0.param2 * arg_3_0.hero.basePhysicAttack)
	arg_3_0.hero:addMagicAttack(arg_3_0.param2 * arg_3_0.hero.baseMagicAttack)
end

function zbAddPhysicAttackMagicAttack.newRound(arg_4_0)
	return
end

function zbAddPhysicAttackMagicAttack.update(arg_5_0, arg_5_1)
	return
end

function zbAddPhysicAttackMagicAttack.isDebuff(arg_6_0)
	return arg_6_0.param1 < 0 and arg_6_0.param2 < 0
end
