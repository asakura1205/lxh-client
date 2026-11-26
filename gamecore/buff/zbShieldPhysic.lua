require("gamecore.buff.zbBaseBuff")

zbShieldPhysic = class("zbShieldPhysic", zbBaseBuff)
zbShieldPhysic.__index = zbShieldPhysic

function zbShieldPhysic.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	local var_1_0 = zbShieldPhysic.new()

	var_1_0:initBase(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	var_1_0:initMy()

	return var_1_0
end

function zbShieldPhysic.initMy(arg_2_0)
	arg_2_0.removeWhenDied = true

	arg_2_0.hero:setPhysicShield(arg_2_0.param1)
end

function zbShieldPhysic.free(arg_3_0)
	return
end

function zbShieldPhysic.newRound(arg_4_0)
	return
end

function zbShieldPhysic.update(arg_5_0, arg_5_1)
	return
end

function zbShieldPhysic.isEnd(arg_6_0)
	if arg_6_0.hero:isDie() then
		return true
	end

	if arg_6_0.hero:getPhysicShield() <= 0 then
		return true
	end

	if g_CombatStateMachine:getCurrStateId() == CombatState_Finish then
		return true
	end

	return false
end

function zbShieldPhysic.isDebuff(arg_7_0)
	return false
end
