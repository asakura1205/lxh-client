function zbWsMsgHandler.WS_LegionWar_GetData_Req(arg_1_0)
	local var_1_0 = {}

	g_WsMsgHandler:wsPackMsg(var_1_0, MSG_ID.WS_LegionWar_GetData_Req)
end

function zbWsMsgHandler.WS_LegionWar_GetData_Ack(arg_2_0, arg_2_1)
	echo("WS_LegionWar_GetData_Ack")
	g_Self.kLegionHandler:updateLegionWarBase(arg_2_1.RetData)
	g_Self.kLegionHandler:updateLegionWarNode(arg_2_1.RetData)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_LegionWarNodeInfo)
end

function zbWsMsgHandler.WS_LegionWar_GetDailyNode_Req(arg_3_0, arg_3_1)
	local var_3_0 = {
		NodeId = arg_3_1
	}

	g_WsMsgHandler:wsPackMsg(var_3_0, MSG_ID.WS_LegionWar_GetDailyNode_Req)
end

function zbWsMsgHandler.WS_LegionWar_GetDailyNode_Ack(arg_4_0, arg_4_1)
	echo("WS_LegionWar_GetDailyNode_Ack")
	g_Self.kWorldHandler:updateGodDomainNode(arg_4_1.RetData.WorldGodDomainNode)
	g_Self.kLegionHandler:updateLegionWarNodeInfo(arg_4_1.RetData.LegionWarNodeInfo)
	g_Self.kLegionHandler:updateLegionWarBase(arg_4_1.RetData)

	g_Self.kLegionHandler.DefendFormation = arg_4_1.RetData.DefendFormation
	g_Self.kLegionHandler.NpcId = arg_4_1.RetData.NpcId

	g_MainScene:showLegionWarDailyWnd(arg_4_1.RetData.NodeId)
end

function zbWsMsgHandler.WS_LegionWar_GetFightNode_Req(arg_5_0, arg_5_1)
	local var_5_0 = {
		NodeId = arg_5_1
	}

	g_WsMsgHandler:wsPackMsg(var_5_0, MSG_ID.WS_LegionWar_GetFightNode_Req)
end

function zbWsMsgHandler.WS_LegionWar_GetFightNode_Ack(arg_6_0, arg_6_1)
	echo("WS_LegionWar_GetFightNode_Ack")
	g_Self.kWorldHandler:updateGodDomainNode(arg_6_1.RetData.WorldGodDomainNode)
	g_Self.kLegionHandler:updateLegionWarNodeInfo(arg_6_1.RetData.LegionWarNodeInfo)
	g_Self.kLegionHandler:updateLegionWarBase(arg_6_1.RetData)

	g_Self.kLegionHandler.legionWarPlayerList = arg_6_1.RetData.PlayerList

	g_MainScene:showLegionWarPositionWnd(arg_6_1.RetData.NodeId)
end

function zbWsMsgHandler.WS_LegionWar_DailyRepair_Req(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = {
		NodeId = arg_7_1,
		RepairType = arg_7_2
	}

	g_WsMsgHandler:wsPackMsg(var_7_0, MSG_ID.WS_LegionWar_DailyRepair_Req)
end

function zbWsMsgHandler.WS_LegionWar_DailyRepair_Ack(arg_8_0, arg_8_1)
	echo("WS_LegionWar_DailyRepair_Ack")
	g_Self.kDataChange:update(arg_8_1)
	g_Self.kLegionHandler:updateLegionWarNodeInfo(arg_8_1.RetData.LegionWarNodeInfo)
	g_Self.kLegionHandler:updateLegionWarBase(arg_8_1.RetData)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionWarDailyRepair)
end

function zbWsMsgHandler.WS_LegionWar_DailyFightStart_Req(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = {
		NodeId = arg_9_1.NodeId,
		PlayerId = arg_9_2.PlayerId,
		NpcId = arg_9_2.NpcId
	}

	g_WsMsgHandler:wsPackMsg(var_9_0, MSG_ID.WS_LegionWar_DailyFightStart_Req)
end

function zbWsMsgHandler.WS_LegionWar_DailyFightStart_Ack(arg_10_0, arg_10_1)
	echo("WS_LegionWar_DailyFightStart_Ack")

	if g_CombatSystem:isFighting() then
		return
	end

	if arg_10_1.RetData.BattleInfo and zbUtil:fightReqAckSign(arg_10_1.RetData.BattleInfo) ~= arg_10_1.RetData.BattleInfo.Sign then
		g_Bubble:bubbleInfo(a2u("ս\xB6\xB7\xCA\xFD\xBE\xDDУ\xD1\xE9ʧ\xB0\xDC"))

		return
	end

	g_CombatSystem:startLegionWarBattle(arg_10_1.RetData)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionWarFight_Ack)
end

function zbWsMsgHandler.WS_LegionWar_DailyFightResult_Req(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = {
		RandomSeed = arg_11_1.BattleInfo.RandomSeed,
		Energy = g_CombatSystem:getLegendEnergy(),
		NodeId = arg_11_1.NodeId,
		PlayerId = arg_11_1.PlayerId,
		NpcId = arg_11_1.NpcId,
		Result = arg_11_2
	}

	var_11_0.Sign = zbUtil:fightResultReqSign(var_11_0)

	g_WsMsgHandler:wsPackMsg(var_11_0, MSG_ID.WS_LegionWar_DailyFightResult_Req)
end

function zbWsMsgHandler.WS_LegionWar_DailyFightResult_Ack(arg_12_0, arg_12_1)
	echoInfo("WS_LegionWar_DailyFightResult_Ack")
	g_Self.kDataChange:update(arg_12_1)
	g_Self.kLegionHandler:updateLegionWarNodeInfo(arg_12_1.RetData.LegionWarNodeInfo)
	g_Self.kLegionHandler:updateLegionWarBase(arg_12_1.RetData)
	g_Self.kGodHandler:updateGodInfo(arg_12_1.RetData.GodInfo)
	g_CombatSystem.combatData:setBalanceAwards(arg_12_1.RetData, arg_12_1.RetData.Result, arg_12_1.RetData.AwardList)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionWarDailyResult_Ack)
end

function zbWsMsgHandler.WS_LegionWar_Apply_Req(arg_13_0, arg_13_1)
	local var_13_0 = {
		NodeId = arg_13_1
	}

	g_WsMsgHandler:wsPackMsg(var_13_0, MSG_ID.WS_LegionWar_Apply_Req)
end

function zbWsMsgHandler.WS_LegionWar_Apply_Ack(arg_14_0, arg_14_1)
	echo("WS_LegionWar_Apply_Ack")
	g_Self.kLegionHandler:updateLegionWarBase(arg_14_1.RetData)
	g_Self.kLegionHandler:updateLegionWarNodeInfo(arg_14_1.RetData.LegionWarNodeInfo)
end

function zbWsMsgHandler.WS_LegionWar_EliteSet_Req(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = {
		NodeId = arg_15_1,
		PlayerList = arg_15_2
	}

	g_WsMsgHandler:wsPackMsg(var_15_0, MSG_ID.WS_LegionWar_EliteSet_Req)
end

function zbWsMsgHandler.WS_LegionWar_EliteSet_Ack(arg_16_0, arg_16_1)
	echo("WS_LegionWar_EliteSet_Ack")
	g_Self.kLegionHandler:updateLegionWarBase(arg_16_1.RetData)
	g_Self.kLegionHandler:updateLegionWarNodeInfo(arg_16_1.RetData.LegionWarNodeInfo)
end

function zbWsMsgHandler.WS_LegionWar_Log_Req(arg_17_0, arg_17_1)
	local var_17_0 = {
		NodeId = arg_17_1
	}

	g_WsMsgHandler:wsPackMsg(var_17_0, MSG_ID.WS_LegionWar_Log_Req)
end

function zbWsMsgHandler.WS_LegionWar_Log_Ack(arg_18_0, arg_18_1)
	echo("WS_LegionWar_Log_Ack")
	g_MainScene:showLegionLog(arg_18_1.RetData.LogList, ELegionPartLogType.LegionWar)
end

function zbWsMsgHandler.WS_LegionWar_Report_Req(arg_19_0, arg_19_1)
	local var_19_0 = {
		NodeId = arg_19_1
	}

	g_WsMsgHandler:wsPackMsg(var_19_0, MSG_ID.WS_LegionWar_Report_Req)
end

function zbWsMsgHandler.WS_LegionWar_Report_Ack(arg_20_0, arg_20_1)
	echo("WS_LegionWar_Report_Ack")

	g_Self.kLegionHandler.legionWarReport = arg_20_1.RetData

	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionWarReport)
end

function zbWsMsgHandler.WS_LegionWar_DefendSet_Req(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = {
		NodeId = arg_21_1,
		PlayerList = arg_21_2
	}

	g_WsMsgHandler:wsPackMsg(var_21_0, MSG_ID.WS_LegionWar_DefendSet_Req)
end

function zbWsMsgHandler.WS_LegionWar_DefendSet_Ack(arg_22_0, arg_22_1)
	echo("WS_LegionWar_DefendSet_Ack")
	g_Self.kLegionHandler:updateLegionWarNodeInfo(arg_22_1.RetData.LegionWarNodeInfo)
	g_Self.kLegionHandler:updateLegionWarBase(arg_22_1.RetData)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionWarDefendSet)
end

function zbWsMsgHandler.WS_LegionWar_BuildFightStart_Req(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = {
		NodeId = arg_23_1.NodeId,
		BuildId = arg_23_2
	}

	g_WsMsgHandler:wsPackMsg(var_23_0, MSG_ID.WS_LegionWar_BuildFightStart_Req)
end

function zbWsMsgHandler.WS_LegionWar_BuildFightStart_Ack(arg_24_0, arg_24_1)
	echo("WS_LegionWar_BuildFightStart_Ack")

	if g_CombatSystem:isFighting() then
		return
	end

	if arg_24_1.RetData.BattleInfo and zbUtil:fightReqAckSign(arg_24_1.RetData.BattleInfo) ~= arg_24_1.RetData.BattleInfo.Sign then
		g_Bubble:bubbleInfo(a2u("ս\xB6\xB7\xCA\xFD\xBE\xDDУ\xD1\xE9ʧ\xB0\xDC"))

		return
	end

	g_CombatSystem:startLegionWarBuildBattle(arg_24_1.RetData)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionWarFight_Ack)
end

function zbWsMsgHandler.WS_LegionWar_BuildFightResult_Req(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = {
		RandomSeed = arg_25_1.BattleInfo.RandomSeed,
		Energy = g_CombatSystem:getLegendEnergy(),
		NodeId = arg_25_1.NodeId,
		BuildId = arg_25_1.BuildId,
		Result = arg_25_2
	}

	var_25_0.Sign = zbUtil:fightResultReqSign(var_25_0)

	g_WsMsgHandler:wsPackMsg(var_25_0, MSG_ID.WS_LegionWar_BuildFightResult_Req)
end

function zbWsMsgHandler.WS_LegionWar_BuildFightResult_Ack(arg_26_0, arg_26_1)
	echoInfo("WS_LegionWar_BuildFightResult_Ack")
	g_Self.kDataChange:update(arg_26_1)
	g_Self.kLegionHandler:updateLegionWarNodeInfo(arg_26_1.RetData.LegionWarNodeInfo)
	g_Self.kLegionHandler:updateLegionWarBase(arg_26_1.RetData)
	g_Self.kGodHandler:updateGodInfo(arg_26_1.RetData.GodInfo)
	g_CombatSystem.combatData:setBalanceAwards(arg_26_1.RetData, arg_26_1.RetData.Result, arg_26_1.RetData.AwardList)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionWarBuildResult_Ack)
end

function zbWsMsgHandler.WS_LegionWar_PlayerFightStart_Req(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = {
		NodeId = arg_27_1.NodeId,
		PlayerId = arg_27_2
	}

	g_WsMsgHandler:wsPackMsg(var_27_0, MSG_ID.WS_LegionWar_PlayerFightStart_Req)
end

function zbWsMsgHandler.WS_LegionWar_PlayerFightStart_Ack(arg_28_0, arg_28_1)
	echo("WS_LegionWar_PlayerFightStart_Ack")

	if g_CombatSystem:isFighting() then
		return
	end

	if arg_28_1.RetData.BattleInfo and zbUtil:fightReqAckSign(arg_28_1.RetData.BattleInfo) ~= arg_28_1.RetData.BattleInfo.Sign then
		g_Bubble:bubbleInfo(a2u("ս\xB6\xB7\xCA\xFD\xBE\xDDУ\xD1\xE9ʧ\xB0\xDC"))

		return
	end

	g_CombatSystem:startLegionWarPlayBattle(arg_28_1.RetData)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionWarFight_Ack)
end

function zbWsMsgHandler.WS_LegionWar_PlayerFightResult_Req(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = {
		RandomSeed = arg_29_1.BattleInfo.RandomSeed,
		Energy = g_CombatSystem:getLegendEnergy(),
		NodeId = arg_29_1.NodeId,
		PlayerId = arg_29_1.PlayerId,
		Result = arg_29_2
	}

	var_29_0.Sign = zbUtil:fightResultReqSign(var_29_0)

	g_WsMsgHandler:wsPackMsg(var_29_0, MSG_ID.WS_LegionWar_PlayerFightResult_Req)
end

function zbWsMsgHandler.WS_LegionWar_PlayerFightResult_Ack(arg_30_0, arg_30_1)
	echoInfo("WS_LegionWar_PlayerFightResult_Ack")
	g_Self.kDataChange:update(arg_30_1)
	g_Self.kLegionHandler:updateLegionWarNodeInfo(arg_30_1.RetData.LegionWarNodeInfo)
	g_Self.kLegionHandler:updateLegionWarBase(arg_30_1.RetData)
	g_Self.kGodHandler:updateGodInfo(arg_30_1.RetData.GodInfo)
	g_CombatSystem.combatData:setBalanceAwards(arg_30_1.RetData, arg_30_1.RetData.Result, arg_30_1.RetData.AwardList)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionWarPlayResult_Ack)
end

function zbWsMsgHandler.WS_LegionWar_BuildDefendInfo_Req(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = {
		NodeId = arg_31_1,
		BuildId = arg_31_2
	}

	g_WsMsgHandler:wsPackMsg(var_31_0, MSG_ID.WS_LegionWar_BuildDefendInfo_Req)
end

function zbWsMsgHandler.WS_LegionWar_BuildDefendInfo_Ack(arg_32_0, arg_32_1)
	echo("WS_LegionWar_BuildDefendInfo_Ack")
	g_Self.kLegionHandler:updateLegionWarNodeInfo(arg_32_1.RetData.LegionWarNodeInfo)
	g_Self.kLegionHandler:updateLegionWarBase(arg_32_1.RetData)

	g_Self.kLegionHandler.DefendList = arg_32_1.RetData.DefendList
	g_Self.kLegionHandler.NpcId = arg_32_1.RetData.NpcId

	g_MainScene:showLegionWarFightWnd(arg_32_1.RetData.LegionWarNodeInfo, arg_32_1.RetData.BuildId, ELgionWarFight.E_NodePlay)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_LegionWarNodeInfo)
end

function zbWsMsgHandler.WS_LegionWar_DailyAward_Req(arg_33_0, arg_33_1)
	local var_33_0 = {
		NodeId = arg_33_1
	}

	g_WsMsgHandler:wsPackMsg(var_33_0, MSG_ID.WS_LegionWar_DailyAward_Req)
end

function zbWsMsgHandler.WS_LegionWar_DailyAward_Ack(arg_34_0, arg_34_1)
	echo("WS_LegionWar_DailyAward_Ack")
	g_Self.kWorldHandler:updateGodDomainNode(arg_34_1.RetData.WorldGodDomainNode)
	g_Self.kDataChange:update(arg_34_1)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_UpdateNodeInfo)
end
