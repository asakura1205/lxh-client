require("gamecore.zbCombatState_Ready")
require("gamecore.zbCombatState_Fight")
require("gamecore.zbCombatState_Finish")
require("gamecore.zbCombatState_FirstCombatFinish")

CombatState_Invalid = 0
CombatState_Ready = 1
CombatState_Fight = 2
CombatState_Finish = 3
CombatState_FirstCombatFinish = 4
zbCombatStateMachine = class("zbCombatStateMachine")
zbCombatStateMachine.__index = zbCombatStateMachine

function zbCombatStateMachine.create(arg_1_0)
	local var_1_0 = zbCombatStateMachine.new()

	var_1_0:init()

	return var_1_0
end

function zbCombatStateMachine.init(arg_2_0)
	arg_2_0.states = {}
	arg_2_0.states[CombatState_Ready] = zbCombatState_Ready:create(CombatState_Ready)
	arg_2_0.states[CombatState_Fight] = zbCombatState_Fight:create(CombatState_Fight)
	arg_2_0.states[CombatState_Finish] = zbCombatState_Finish:create(CombatState_Finish)
	arg_2_0.states[CombatState_FirstCombatFinish] = zbCombatState_FirstCombatFinish:create(CombatState_FirstCombatFinish)
	arg_2_0.currStateId = nil

	arg_2_0:setCurrState(CombatState_Invalid)
end

function zbCombatStateMachine.free(arg_3_0)
	for iter_3_0, iter_3_1 in pairs(arg_3_0.states) do
		iter_3_1:free()
	end
end

function zbCombatStateMachine.update(arg_4_0, arg_4_1)
	if arg_4_0:getCurrState() ~= nil then
		arg_4_0:getCurrState():update(arg_4_1)
	end
end

function zbCombatStateMachine.setCurrState(arg_5_0, arg_5_1)
	if arg_5_0.currStateId == arg_5_1 then
		return
	end

	if arg_5_0.states[arg_5_1] == nil then
		return
	end

	if arg_5_0:getCurrState() then
		arg_5_0:getCurrState():exit()
	end

	arg_5_0.currStateId = arg_5_1

	arg_5_0.states[arg_5_1]:enter()
end

function zbCombatStateMachine.getCurrState(arg_6_0)
	return arg_6_0.states[arg_6_0.currStateId]
end

function zbCombatStateMachine.getCurrStateId(arg_7_0)
	return arg_7_0.currStateId
end
