require("gamecore.buff.zbBaseBuff")

zbMiscZhongzi = class("zbMiscZhongzi", zbBaseBuff)
zbMiscZhongzi.__index = zbMiscZhongzi

function zbMiscZhongzi.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	local var_1_0 = zbMiscZhongzi.new()

	var_1_0:initBase(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	var_1_0:initMy()

	return var_1_0
end

function zbMiscZhongzi.initMy(arg_2_0)
	arg_2_0.removeWhenDied = true

	arg_2_0.hero:addExtraPhysicDamageDefendRatio(arg_2_0.param1)
	arg_2_0.hero:addExtraPhysicDamageDefendAbs(arg_2_0.param2)
	arg_2_0.hero:addExtraMagicDamageDefendRatio(arg_2_0.param1)
	arg_2_0.hero:addExtraMagicDamageDefendAbs(arg_2_0.param2)
	g_CombatBubble:showBubble(arg_2_0.hero, ECombatBubble.PhysicMagicDefendDown, 0, 0, 1)
end

function zbMiscZhongzi.free(arg_3_0)
	arg_3_0.hero:removeExtraPhysicDamageDefendRatio(-arg_3_0.param1)
	arg_3_0.hero:addExtraPhysicDamageDefendAbs(-arg_3_0.param2)
	arg_3_0.hero:removeExtraMagicDamageDefendRatio(-arg_3_0.param1)
	arg_3_0.hero:addExtraMagicDamageDefendAbs(-arg_3_0.param2)
end

function zbMiscZhongzi.newRound(arg_4_0)
	return
end

function zbMiscZhongzi.update(arg_5_0, arg_5_1)
	return
end

function zbMiscZhongzi.isDebuff(arg_6_0)
	return true
end
