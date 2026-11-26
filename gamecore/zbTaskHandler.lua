local var_0_0 = class("zbTaskHandler")

var_0_0.__index = var_0_0

function createTaskHandler()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	return
end

function var_0_0.updateMainTask(arg_3_0, arg_3_1)
	if zbUtil:isValidTable(arg_3_1) == false then
		echo("warning: invalid mainTask")

		return
	end

	local function var_3_0(arg_4_0, arg_4_1)
		local var_4_0 = arg_4_0.State ~= 2
		local var_4_1 = arg_4_1.State ~= 2

		if var_4_0 and var_4_1 then
			return arg_4_0.State > arg_4_1.State
		elseif var_4_0 == true and var_4_1 == false then
			return true
		elseif var_4_0 == false and var_4_1 == true then
			return false
		else
			return arg_4_0.State > arg_4_1.State
		end
	end

	table.sort(arg_3_1, var_3_0)

	g_GameData.MainTask = arg_3_1

	g_GameEventMgr:sendEvent(zbGameEvent.Event_Task_Ack)
	g_Self.kRedPointHandler:refreshTask()
end

function var_0_0.hasFinishTask(arg_5_0)
	if zbFunHelper:isLockNoTip(EFuncType.MainTask) == true then
		return false
	end

	for iter_5_0, iter_5_1 in pairs(g_GameData.MainTask) do
		if iter_5_1.State == 1 then
			return true
		end
	end

	return false
end
