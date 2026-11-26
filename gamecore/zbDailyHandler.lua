local var_0_0 = class("zbDailyHandler")

var_0_0.__index = var_0_0

function createDailyHandler()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	return
end

function var_0_0.updateDailyTask(arg_3_0, arg_3_1)
	if zbUtil:isValidTable(arg_3_1) == false then
		echo("warning: invalid dailyTask")

		return
	end

	g_GameData.DailyTask = arg_3_1

	g_GameEventMgr:sendEvent(zbGameEvent.Event_Daily_Ack)
	g_Self.kRedPointHandler:refreshTask()
end

function var_0_0.hasFinishDaily(arg_4_0)
	if zbFunHelper:isLockNoTip(EFuncType.DailyTask) == true then
		return false
	end

	for iter_4_0, iter_4_1 in pairs(g_GameData.DailyTask.TaskList) do
		if iter_4_1.State == 1 then
			return true
		end
	end

	for iter_4_2, iter_4_3 in pairs(g_GameData.DailyTask.AwardList) do
		if iter_4_3.State == 1 then
			return true
		end
	end

	return false
end
