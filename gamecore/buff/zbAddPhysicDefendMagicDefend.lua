require("gamecore.buff.zbBaseBuff")

zbAddPhysicDefendMagicDefend = class("zbAddPhysicDefendMagicDefend", zbBaseBuff)
zbAddPhysicDefendMagicDefend.__index = zbAddPhysicDefendMagicDefend

function zbAddPhysicDefendMagicDefend.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	local var_1_0 = zbAddPhysicDefendMagicDefend.new()

	var_1_0:initBase(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	var_1_0:initMy()

	return var_1_0
end

function zbAddPhysicDefendMagicDefend.initMy(arg_2_0)
	arg_2_0.hero:addPhysicDefend(arg_2_0.param1)
	arg_2_0.hero:addMagicDefend(arg_2_0.param1)
	arg_2_0.hero:addPhysicDefend(arg_2_0.param2 * arg_2_0.hero.basePhysicDefend)
	arg_2_0.hero:addMagicDefend(arg_2_0.param2 * arg_2_0.hero.baseMagicDefend)
end

function zbAddPhysicDefendMagicDefend.free(arg_3_0)
	arg_3_0.hero:addPhysicDefend(-arg_3_0.param1)
	arg_3_0.hero:addMagicDefend(-arg_3_0.param1)
	arg_3_0.hero:addPhysicDefend(-arg_3_0.param2 * arg_3_0.hero.basePhysicDefend)
	arg_3_0.hero:addMagicDefend(-arg_3_0.param2 * arg_3_0.hero.baseMagicDefend)
end

function zbAddPhysicDefendMagicDefend.newRound(arg_4_0)
	return
end

function zbAddPhysicDefendMagicDefend.update(arg_5_0, arg_5_1)
	return
end

function zbAddPhysicDefendMagicDefend.isDebuff(arg_6_0)
	return arg_6_0.param1 < 0 and arg_6_0.param1 < 0
end
