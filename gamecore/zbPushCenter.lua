local var_0_0 = class("zbPushCenter")

var_0_0.__index = var_0_0

local var_0_1 = "pushmsg_type_"
local var_0_2 = "pushmsg_set_state_"
local var_0_3 = "pushmsg_state_"
local var_0_4 = "pushmsg_content_"
local var_0_5 = "pushmsg_time_"
local var_0_6 = "pushmsg_voice_"
local var_0_7 = "pushmsg_repeatpush_"

function createPushCenter()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	arg_2_0.dataList = {}

	for iter_2_0 = 1, EPushType.E_MAX do
		local var_2_0 = {
			type = iter_2_0
		}

		var_2_0.state = "1"
		var_2_0.set_state = "1"
		var_2_0.content = ""
		var_2_0.time = ""
		var_2_0.voice = ""
		var_2_0.repeatpush = "0"

		table.insert(arg_2_0.dataList, var_2_0)
	end

	;(function()
		for iter_3_0, iter_3_1 in pairs(arg_2_0.dataList) do
			iter_3_1.type = iter_3_0

			if zbGameCore:Instance():getConfigValue(var_0_2 .. iter_3_0) == "" then
				iter_3_1.set_state = "1"
			else
				iter_3_1.set_state = zbGameCore:Instance():getConfigValue(var_0_2 .. iter_3_0)
			end

			iter_3_1.content = zbGameCore:Instance():getConfigValue(var_0_4 .. iter_3_0)
			iter_3_1.time = zbGameCore:Instance():getConfigValue(var_0_5 .. iter_3_0)
			iter_3_1.voice = zbGameCore:Instance():getConfigValue(var_0_6 .. iter_3_0)
			iter_3_1.repeatpush = zbGameCore:Instance():getConfigValue(var_0_7 .. iter_3_0)

			if iter_3_1.set_state == "1" then
				arg_2_0:setSettingPushOn(iter_3_0)
			else
				arg_2_0:setSettingPushOff(iter_3_0)
			end
		end
	end)()
	zbGlobalUtil:GameCallSDKFunction("initPushType", EPushType.E_MAX, "")
end

function var_0_0.free(arg_4_0)
	arg_4_0.dataList = {}
end

function var_0_0.pushFixMessage(arg_5_0)
	if g_GameData.ActivityAct and zbUtil:isValidTable(g_GameData.ActivityAct.Tili) then
		local var_5_0 = 1

		for iter_5_0, iter_5_1 in pairs(g_GameData.ActivityAct.Tili) do
			if var_5_0 <= 3 then
				arg_5_0:pushRepeatMessage(var_5_0, iter_5_1.StartHour .. ":00", a2u(E_DESC[var_5_0]), "")
			end

			var_5_0 = var_5_0 + 1
		end
	end
end

function var_0_0.setSettingPushOn(arg_6_0, arg_6_1)
	if arg_6_0.dataList[arg_6_1] then
		arg_6_0.dataList[arg_6_1].set_state = 1

		zbGameCore:Instance():setConfigValue(var_0_2 .. arg_6_1, 1)
	end
end

function var_0_0.setSettingPushOff(arg_7_0, arg_7_1)
	if arg_7_0.dataList[arg_7_1] then
		arg_7_0.dataList[arg_7_1].set_state = 0

		zbGameCore:Instance():setConfigValue(var_0_2 .. arg_7_1, 0)
	end
end

function var_0_0.setPushOn(arg_8_0, arg_8_1)
	if arg_8_0.dataList[arg_8_1] then
		arg_8_0.dataList[arg_8_1].state = 1

		zbGameCore:Instance():setConfigValue(var_0_3 .. arg_8_1, 1)
	end
end

function var_0_0.setPushOff(arg_9_0, arg_9_1)
	if arg_9_0.dataList[arg_9_1] then
		arg_9_0.dataList[arg_9_1].state = 0

		zbGameCore:Instance():setConfigValue(var_0_3 .. arg_9_1, 0)
	end
end

function var_0_0.pushOnceMessage(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if arg_10_0:isSilentTime() then
		return
	end

	arg_10_0:saveMessage(arg_10_1, arg_10_2, arg_10_3, arg_10_4, 0)
end

function var_0_0.pushRepeatMessage(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if arg_11_0:isSilentTime() then
		return
	end

	arg_11_0:saveMessage(arg_11_1, arg_11_2, arg_11_3, arg_11_4, 1)
end

function var_0_0.clearMessage(arg_12_0, arg_12_1)
	arg_12_0:saveMessage(arg_12_1, "", "", "", 0)
end

function var_0_0.getPushMessage(arg_13_0, arg_13_1)
	return arg_13_0.dataList[arg_13_1]
end

function var_0_0.clearAllMessages(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0.dataList) do
		arg_14_0:clearMessage(iter_14_0)
	end
end

function var_0_0.saveMessage(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	local var_15_0 = arg_15_0.dataList[arg_15_1]

	if var_15_0 == nil then
		echo("warning: invalid push message type")

		return
	end

	var_15_0.time = arg_15_2
	var_15_0.content = arg_15_3
	var_15_0.voice = arg_15_4
	var_15_0.repeatpush = arg_15_5
	var_15_0.state = 1

	zbGameCore:Instance():setConfigValue(var_0_3 .. arg_15_1, 1)
	zbGameCore:Instance():setConfigValue(var_0_5 .. arg_15_1, arg_15_2)
	zbGameCore:Instance():setConfigValue(var_0_4 .. arg_15_1, arg_15_3)
	zbGameCore:Instance():setConfigValue(var_0_6 .. arg_15_1, arg_15_4)
	zbGameCore:Instance():setConfigValue(var_0_7 .. arg_15_1, arg_15_5)
end

function var_0_0.isSilentTime(arg_16_0)
	local var_16_0 = zbUtil:SprintfHHMMSS(g_Self.kTimeHandler:getServerTime() + g_Self.kTimeHandler:getTimeZoneDelt())

	if var_16_0 >= "21:00:00" and var_16_0 <= "07:00:00" then
		return true
	end

	return false
end
