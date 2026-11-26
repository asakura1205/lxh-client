local var_0_0 = class("zbArenaHandler")

var_0_0.__index = var_0_0

function createArenaHandler()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	arg_2_0.ArenaBaseInfo = nil
	arg_2_0.ArenaCombatInfo = nil
	arg_2_0.PlayerList = nil
	arg_2_0.BattleInfo = nil
	arg_2_0.IsBestRank = 0
	arg_2_0.AwardList = nil
	arg_2_0.RecordList = nil
	arg_2_0.oldRank = 0
end

function var_0_0.updateArenaInfoData(arg_3_0, arg_3_1)
	if zbUtil:isValidTable(arg_3_1) == false then
		echo("warning: invalid arenaInfo")

		return
	end

	arg_3_0:updateArenaBaseInfoData(arg_3_1.ArenaBaseInfo)
	arg_3_0:updateArenaCombatInfoData(arg_3_1.ArenaCombatInfo)
	arg_3_0:updatePlayerListData(arg_3_1.PlayerList)
end

function var_0_0.updateArenaBaseInfoData(arg_4_0, arg_4_1)
	if zbUtil:isValidTable(arg_4_1) == false then
		echo("warning: invalid arenaBaseInfo")

		return
	end

	if arg_4_0.ArenaBaseInfo ~= nil then
		arg_4_0.oldRank = arg_4_0.ArenaBaseInfo.Rank
	end

	arg_4_0.ArenaBaseInfo = arg_4_1

	if zbUtil:isValidTable(g_GameData.SelfArenaInfo) then
		g_GameData.SelfArenaInfo.ArenaBaseInfo = arg_4_1
	end
end

function var_0_0.updateArenaCombatInfoData(arg_5_0, arg_5_1)
	if zbUtil:isValidTable(arg_5_1) == false then
		echo("warning: invalid arenaCombatInfo")

		return
	end

	arg_5_0.ArenaCombatInfo = arg_5_1

	if zbUtil:isValidTable(g_GameData.SelfArenaInfo) then
		g_GameData.SelfArenaInfo.ArenaCombatInfo = arg_5_1

		g_Self.kRedPointHandler:refreshArena()
	end
end

function var_0_0.updatePlayerListData(arg_6_0, arg_6_1)
	if zbUtil:isValidTable(arg_6_1) == false then
		echo("warning: invalid playerList")

		return
	end

	arg_6_0.PlayerList = arg_6_1
end

function var_0_0.updateBattleInfoData(arg_7_0, arg_7_1)
	if zbUtil:isValidTable(arg_7_1) == false then
		echo("warning: invalid battleInfo")

		return
	end

	arg_7_0.BattleInfo = arg_7_1
end

function var_0_0.updateIsBestRankData(arg_8_0, arg_8_1)
	arg_8_0.IsBestRank = arg_8_1
end

function var_0_0.updateAwardListData(arg_9_0, arg_9_1)
	if zbUtil:isValidTable(arg_9_1) == false then
		echo("warning: invalid awardList")

		return
	end

	arg_9_0.AwardList = arg_9_1
end

function var_0_0.updateRecordListData(arg_10_0, arg_10_1)
	if zbUtil:isValidTable(arg_10_1) == false then
		echo("warning: invalid recordList")

		return
	end

	arg_10_0.RecordList = arg_10_1
end

function var_0_0.hasArenaCanFight(arg_11_0)
	if zbUtil:isValidTable(g_GameData.SelfArenaInfo) and g_GameData.SelfArenaInfo.ArenaCombatInfo.CombatCount < g_GameData.SelfArenaInfo.ArenaCombatInfo.MaxCombatCount then
		return true
	end

	return false
end
