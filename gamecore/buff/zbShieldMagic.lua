require("gamecore.buff.zbBaseBuff")

zbShieldMagic = class("zbShieldMagic", zbBaseBuff)
zbShieldMagic.__index = zbShieldMagic

function zbShieldMagic.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	local var_1_0 = zbShieldMagic.new()

	var_1_0:initBase(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	var_1_0:initMy()

	return var_1_0
end

function zbShieldMagic.initMy(arg_2_0)
	arg_2_0.removeWhenDied = true

	arg_2_0.hero:setMagicShield(arg_2_0.param1)
end

function zbShieldMagic.free(arg_3_0)
	return
end

function zbShieldMagic.newRound(arg_4_0)
	return
end

function zbShieldMagic.update(arg_5_0, arg_5_1)
	return
end

function zbShieldMagic.isEnd(arg_6_0)
	if arg_6_0.hero:isDie() then
		return true
	end

	if arg_6_0.hero:getMagicShield() <= 0 then
		return true
	end

	if g_CombatStateMachine:getCurrStateId() == CombatState_Finish then
		return true
	end

	return false
end

function zbShieldMagic.isDebuff(arg_7_0)
	return false
end
