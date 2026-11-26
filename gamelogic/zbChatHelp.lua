zbChatHelp = {}

local var_0_0 = CCFileUtils:sharedFileUtils():getWritablePath()
local var_0_1 = require("cjson")

function zbChatHelp.saveChatInfoTofile(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_1.encode(arg_1_1)
	local var_1_1 = 0

	if g_GameData and g_GameData.BaseInfo then
		var_1_1 = g_GameData.BaseInfo.PlayerId
	end

	local var_1_2 = var_0_0 .. "/" .. var_1_1 .. "_" .. arg_1_2 .. ".txt"
	local var_1_3 = io.open(var_1_2, "w")

	if var_1_3 then
		var_1_3:write(var_1_0)
		var_1_3:close()
	end
end

function zbChatHelp.getPlayerChatInfo(arg_2_0, arg_2_1)
	local var_2_0
	local var_2_1 = 0

	if g_GameData and g_GameData.BaseInfo then
		var_2_1 = g_GameData.BaseInfo.PlayerId
	end

	local var_2_2 = var_0_0 .. "/" .. var_2_1 .. "_" .. arg_2_1 .. ".txt"
	local var_2_3 = io.open(var_2_2, "r")

	if var_2_3 then
		local var_2_4 = var_2_3:read()

		var_2_0 = var_0_1.decode(var_2_4)

		var_2_3:close()
	end

	return var_2_0
end

function zbChatHelp.saveChatPlayerList(arg_3_0, arg_3_1)
	local var_3_0 = var_0_1.encode(arg_3_1)
	local var_3_1 = 0

	if g_GameData and g_GameData.BaseInfo then
		var_3_1 = g_GameData.BaseInfo.PlayerId
	end

	local var_3_2 = var_0_0 .. "/" .. var_3_1 .. "_chatobjlist.txt"
	local var_3_3 = io.open(var_3_2, "w")

	if var_3_3 then
		var_3_3:write(var_3_0)
		var_3_3:close()
	end
end

function zbChatHelp.getChatPlayerList(arg_4_0)
	local var_4_0
	local var_4_1 = 0

	if g_GameData and g_GameData.BaseInfo then
		var_4_1 = g_GameData.BaseInfo.PlayerId
	end

	local var_4_2 = var_0_0 .. "/" .. var_4_1 .. "_chatobjlist.txt"
	local var_4_3 = io.open(var_4_2, "r")

	if var_4_3 then
		local var_4_4 = var_4_3:read()

		var_4_0 = var_0_1.decode(var_4_4)

		var_4_3:close()
	end

	return var_4_0
end
