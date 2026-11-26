local var_0_0 = class("zbTimeHandler")

var_0_0.__index = var_0_0

function createTimeHandler()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	arg_2_0:setServerTime(g_GameData.GameEnvInfo.ServTime)
end

function var_0_0.setServerTime(arg_3_0, arg_3_1)
	arg_3_0.qwServerTime = arg_3_1
	arg_3_0.qwServerTimeDiff = os_timenow()
end

function var_0_0.getServerTime(arg_4_0)
	return arg_4_0.qwServerTime + os_timenow() - arg_4_0.qwServerTimeDiff
end

function var_0_0.getTimeZoneDelt(arg_5_0)
	local var_5_0 = 0

	if g_GameData.GameEnvInfo then
		var_5_0 = g_GameData.GameEnvInfo.TimeZone * 3600
	end

	return var_5_0
end
