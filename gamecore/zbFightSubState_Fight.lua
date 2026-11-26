zbFightSubState_Fight = class("zbFightSubState_Fight")
zbFightSubState_Fight.__index = zbFightSubState_Fight

function zbFightSubState_Fight.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbFightSubState_Fight.new()

	var_1_0:init(arg_1_1, arg_1_2)

	return var_1_0
end

function zbFightSubState_Fight.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.fsm = arg_2_1
	arg_2_0.stateId = arg_2_2
end

function zbFightSubState_Fight.free(arg_3_0)
	return
end

function zbFightSubState_Fight.enter(arg_4_0)
	return
end

function zbFightSubState_Fight.exit(arg_5_0)
	return
end

function zbFightSubState_Fight.update(arg_6_0, arg_6_1)
	g_CombatRound:update(arg_6_1)
end
