require("gamecore.zbGameEvent")

local var_0_0 = class("zbGameEventMgr")

var_0_0.__index = var_0_0

function var_0_0.registerEvent(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if arg_1_3 == nil then
		return
	end

	arg_1_0.NotifyCenter:registerScriptObserver(arg_1_1, arg_1_2, arg_1_3)
end

function var_0_0.unregisterEvent(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_2 == nil then
		return
	end

	arg_2_0.NotifyCenter:unregisterScriptObserver(arg_2_1, arg_2_2)
end

function var_0_0.sendEvent(arg_3_0, arg_3_1)
	if arg_3_1 == nil then
		return
	end

	arg_3_0.NotifyCenter:postNotification(arg_3_1)

	if g_Guide then
		g_Guide:checkEvent(arg_3_1)
	end
end

function var_0_0.sendEvent(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == nil then
		return
	end

	arg_4_0.NotifyCenter:postNotification(arg_4_1, arg_4_2)

	if g_Guide then
		g_Guide:checkEvent(arg_4_1)
	end
end

function var_0_0.init(arg_5_0)
	arg_5_0.NotifyCenter = CCNotificationCenter:sharedNotificationCenter()
end

function var_0_0.free(arg_6_0)
	return
end

function createGameEventMgr()
	local var_7_0 = var_0_0.new()

	var_7_0:init()

	return var_7_0
end
