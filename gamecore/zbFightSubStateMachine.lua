require("gamecore.zbFightSubState_Fight")
require("gamecore.zbFightSubState_NextSection")

FightSubState_Fight = 1
FightSubState_NextSection = 2
zbFightSubStateMachine = class("zbFightSubStateMachine")
zbFightSubStateMachine.__index = zbFightSubStateMachine

function zbFightSubStateMachine.create(arg_1_0)
	local var_1_0 = zbFightSubStateMachine.new()

	var_1_0:init()

	return var_1_0
end

function zbFightSubStateMachine.init(arg_2_0)
	arg_2_0.states = {}
	arg_2_0.states[FightSubState_Fight] = zbFightSubState_Fight:create(arg_2_0, FightSubState_Fight)
	arg_2_0.states[FightSubState_NextSection] = zbFightSubState_NextSection:create(arg_2_0, FightSubState_NextSection)
	arg_2_0.currStateId = nil

	arg_2_0:setCurrState(FightSubState_Fight)
end

function zbFightSubStateMachine.free(arg_3_0)
	for iter_3_0, iter_3_1 in pairs(arg_3_0.states) do
		iter_3_1:free()
	end
end

function zbFightSubStateMachine.update(arg_4_0, arg_4_1)
	if arg_4_0:getCurrState() ~= nil then
		arg_4_0:getCurrState():update(arg_4_1)
	end
end

function zbFightSubStateMachine.setCurrState(arg_5_0, arg_5_1)
	if arg_5_0.currStateId == arg_5_1 then
		return
	end

	if arg_5_0.states[arg_5_1] == nil then
		return
	end

	if arg_5_0:getCurrState() then
		arg_5_0:getCurrState():exit()
	end

	arg_5_0.states[arg_5_1]:enter()

	arg_5_0.currStateId = arg_5_1
end

function zbFightSubStateMachine.getCurrState(arg_6_0)
	return arg_6_0.states[arg_6_0.currStateId]
end

function zbFightSubStateMachine.getCurrStateId(arg_7_0)
	return arg_7_0.currStateId
end
