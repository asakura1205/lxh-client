function zbWsMsgHandler.WS_Arena_GetData_Req(arg_1_0)
	local var_1_0 = {}

	g_WsMsgHandler:wsPackMsg(var_1_0, MSG_ID.WS_Arena_GetData_Req)
end

function zbWsMsgHandler.WS_Arena_GetData_Ack(arg_2_0, arg_2_1)
	echoInfo("WS_Arena_GetData_Ack")
	g_Self.kArenaHandler:updateArenaInfoData(arg_2_1.RetData)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_Arena)
end

function zbWsMsgHandler.WS_Arena_FightStart_Req(arg_3_0, arg_3_1)
	local var_3_0 = {
		PlayerId = arg_3_1
	}

	g_WsMsgHandler:wsPackMsg(var_3_0, MSG_ID.WS_Arena_FightStart_Req)
end

function zbWsMsgHandler.WS_Arena_FightStart_Ack(arg_4_0, arg_4_1)
	echoInfo("WS_Arena_FightStart_Ack")

	if g_CombatSystem:isFighting() then
		return
	end

	if arg_4_1.RetData.BattleInfo and zbUtil:fightReqAckSign(arg_4_1.RetData.BattleInfo) ~= arg_4_1.RetData.BattleInfo.Sign then
		g_Bubble:bubbleInfo(a2u("ս\xB6\xB7\xCA\xFD\xBE\xDDУ\xD1\xE9ʧ\xB0\xDC"))

		return
	end

	g_Self.kArenaHandler:updateArenaBaseInfoData(arg_4_1.RetData.ArenaBaseInfo)
	g_Self.kArenaHandler:updateArenaCombatInfoData(arg_4_1.RetData.ArenaCombatInfo)
	g_Self.kArenaHandler:updateBattleInfoData(arg_4_1.RetData.BattleInfo)
	g_CombatSystem:startArenaBattle(arg_4_1.RetData)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_Arena)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_ArenaFight_Ack)
end

function zbWsMsgHandler.WS_Arena_FightResult_Req(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = {
		PlayerId = arg_5_1,
		RandomSeed = arg_5_2,
		Result = arg_5_3,
		Energy = g_CombatSystem:getLegendEnergy()
	}

	var_5_0.Sign = zbUtil:fightResultReqSign(var_5_0)

	g_WsMsgHandler:wsPackMsg(var_5_0, MSG_ID.WS_Arena_FightResult_Req)
end

function zbWsMsgHandler.WS_Arena_FightResult_Ack(arg_6_0, arg_6_1)
	echoInfo("WS_Arena_FightResult_Ack")
	g_Self.kArenaHandler:updateIsBestRankData(arg_6_1.RetData.IsBestRank)
	g_Self.kArenaHandler:updateAwardListData(arg_6_1.RetData.AwardList)
	g_Self.kArenaHandler:updateArenaInfoData(arg_6_1.RetData.ArenaInfo)
	g_Self.kDataChange:update(arg_6_1)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_Arena)

	local var_6_0 = 0

	if zbUtil:isValidTable(arg_6_1.RetData.Wealth) then
		var_6_0 = math.max(arg_6_1.RetData.Wealth.Arena - g_GameData.Wealth.Arena, 0)
	end

	g_CombatSystem.combatData:setBalanceAwards(arg_6_1.RetData, arg_6_1.RetData.Result, arg_6_1.RetData.AwardList, var_6_0)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_ArenaFightResultSyn_Ack)
end

function zbWsMsgHandler.WS_Arena_RecordList_Req(arg_7_0)
	local var_7_0 = {}

	g_WsMsgHandler:wsPackMsg(var_7_0, MSG_ID.WS_Arena_RecordList_Req)
end

function zbWsMsgHandler.WS_Arena_RecordList_Ack(arg_8_0, arg_8_1)
	echoInfo("WS_Arena_RecordList_Ack")
	g_Self.kArenaHandler:updateRecordListData(arg_8_1.RetData.RecordList)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_ArenaRecord_Ack)
end

function zbWsMsgHandler.WS_Arena_Reset_Req(arg_9_0)
	local var_9_0 = {}

	g_WsMsgHandler:wsPackMsg(var_9_0, MSG_ID.WS_Arena_Reset_Req)
end

function zbWsMsgHandler.WS_Arena_Reset_Ack(arg_10_0, arg_10_1)
	echoInfo("WS_Arena_Reset_Ack")
	g_Self.kArenaHandler:updateArenaCombatInfoData(arg_10_1.RetData.ArenaCombatInfo)
	g_Self.kDataChange:update(arg_10_1)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_Arena)
end

function zbWsMsgHandler.WS_Common_BattleRecord_Req(arg_11_0, arg_11_1)
	local var_11_0 = {
		UUID = arg_11_1
	}

	g_WsMsgHandler:wsPackMsg(var_11_0, MSG_ID.WS_Common_BattleRecord_Req)
end

function zbWsMsgHandler.WS_Common_BattleRecord_Ack(arg_12_0, arg_12_1)
	echoInfo("WS_Common_BattleRecord_Ack")

	if g_CombatSystem:isFighting() then
		return
	end

	local var_12_0 = arg_12_1.RetData

	zbCombatFormula:setRandomSeed(var_12_0.BattleInfo.RandomSeed)
	g_CombatSystem:startCombatRecord(var_12_0)
	g_CombatSystem.combatData:setBalanceAwards(arg_12_1.RetData, arg_12_1.RetData.Result, arg_12_1.RetData.AwardList)
end

function zbWsMsgHandler.WS_Arena_Signature_Req(arg_13_0, arg_13_1)
	local var_13_0 = {
		Content = arg_13_1
	}

	g_WsMsgHandler:wsPackMsg(var_13_0, MSG_ID.WS_Arena_Signature_Req)
	zbGlobalUtil:GameCallSDKFunction("hideNavigation", "", "")
end

function zbWsMsgHandler.WS_Arena_Signature_Ack(arg_14_0, arg_14_1)
	echoInfo("WS_Arena_Signature_Ack")
	g_Self.kArenaHandler:updateArenaBaseInfoData(arg_14_1.RetData.ArenaBaseInfo)
end
