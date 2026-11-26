zbCombatState_Ready = class("zbCombatState_Ready")
zbCombatState_Ready.__index = zbCombatState_Ready

function zbCombatState_Ready.create(arg_1_0, arg_1_1)
	local var_1_0 = zbCombatState_Ready.new()

	var_1_0:init(arg_1_1)

	return var_1_0
end

function zbCombatState_Ready.init(arg_2_0, arg_2_1)
	arg_2_0.stateId = arg_2_1
end

function zbCombatState_Ready.free(arg_3_0)
	return
end

function zbCombatState_Ready.enter(arg_4_0)
	g_CombatRound:reset()

	local var_4_0 = g_CombatSystem:getHeros(ForceType.Left)
	local var_4_1 = g_CombatSystem:getHeros(ForceType.Right)

	for iter_4_0, iter_4_1 in pairs(var_4_0) do
		iter_4_1.stateMachine:setCurrState(HeroState_Enter)
	end

	for iter_4_2, iter_4_3 in pairs(var_4_1) do
		iter_4_3.stateMachine:setCurrState(HeroState_Enter)
	end

	g_CombatSystem.combatData:execInitPassiveSkill(var_4_0)
	g_CombatSystem.combatData:execInitPassiveSkill(var_4_1)
	g_CombatPreload:start()
	g_Audio:playSound("audio/sound/move.mp3")
end

function zbCombatState_Ready.exit(arg_5_0)
	return
end

function zbCombatState_Ready.update(arg_6_0, arg_6_1)
	if arg_6_0:isAllReadyFight() then
		g_CombatStateMachine:setCurrState(CombatState_Fight)
	end
end

function zbCombatState_Ready.isAllReadyFight(arg_7_0)
	local var_7_0 = g_CombatSystem:getHeros(ForceType.Left)
	local var_7_1 = g_CombatSystem:getHeros(ForceType.Right)

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		if iter_7_1.isReadyFight == false then
			return false
		end
	end

	for iter_7_2, iter_7_3 in pairs(var_7_1) do
		if iter_7_3.isReadyFight == false then
			return false
		end
	end

	return true
end
