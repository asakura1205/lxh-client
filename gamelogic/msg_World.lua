function zbWsMsgHandler.WS_World_GetInfo_Req(arg_1_0)
	local var_1_0 = {}

	g_WsMsgHandler:wsPackMsg(var_1_0, MSG_ID.WS_World_GetInfo_Req)
end

function zbWsMsgHandler.WS_World_GetInfo_Ack(arg_2_0, arg_2_1)
	echoInfo("WS_World_GetInfo_Ack")
	g_Self.kWorldHandler:updateWorldInfo(arg_2_1.RetData.WorldInfo)
end

function zbWsMsgHandler.WS_World_Unlock_Req(arg_3_0, arg_3_1)
	local var_3_0 = {
		NodeId = arg_3_1
	}

	g_WsMsgHandler:wsPackMsg(var_3_0, MSG_ID.WS_World_Unlock_Req)
end

function zbWsMsgHandler.WS_World_Unlock_Ack(arg_4_0, arg_4_1)
	echoInfo("WS_World_Unlock_Ack")
	g_Self.kDataChange:update(arg_4_1)

	WorldUnlockAckData = arg_4_1.RetData

	g_Self.kWorldHandler:updateUnlockInfo(arg_4_1.RetData)
end

function zbWsMsgHandler.WS_WorldRes_GetInfo_Req(arg_5_0)
	local var_5_0 = {}

	g_WsMsgHandler:wsPackMsg(var_5_0, MSG_ID.WS_WorldRes_GetInfo_Req)
end

function zbWsMsgHandler.WS_WorldRes_GetInfo_Ack(arg_6_0, arg_6_1)
	echoInfo("WS_WorldRes_GetInfo_Ack")
	g_Self.kWorldHandler:updateWorldViewNodeList(arg_6_1.RetData.ViewNodeList)
	g_Self.kWorldHandler:updateWorldHoldNodeList(arg_6_1.RetData.HoldNodeList)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_UpdateNodeInfo)
end

function zbWsMsgHandler.WS_WorldRes_Change_Req(arg_7_0)
	local var_7_0 = {}

	g_WsMsgHandler:wsPackMsg(var_7_0, MSG_ID.WS_WorldRes_Change_Req)
end

function zbWsMsgHandler.WS_WorldRes_Change_Ack(arg_8_0, arg_8_1)
	echoInfo("WS_WorldRes_Change_Ack")

	g_Self.kWorldHandler.changeNodeId = arg_8_1.RetData
end

function zbWsMsgHandler.WS_WorldRes_Taunt_Req(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = {
		NodeId = arg_9_1,
		Content = arg_9_2
	}

	g_WsMsgHandler:wsPackMsg(var_9_0, MSG_ID.WS_WorldRes_Taunt_Req)
	zbGlobalUtil:GameCallSDKFunction("hideNavigation", "", "")
end

function zbWsMsgHandler.WS_WorldRes_Taunt_Ack(arg_10_0, arg_10_1)
	echoInfo("WS_WorldRes_Taunt_Ack")
end

function zbWsMsgHandler.WS_WorldRes_FightStart_Req(arg_11_0, arg_11_1)
	local var_11_0 = {
		NodeId = arg_11_1
	}

	g_WsMsgHandler:wsPackMsg(var_11_0, MSG_ID.WS_WorldRes_FightStart_Req)
end

function zbWsMsgHandler.WS_WorldRes_FightStart_Ack(arg_12_0, arg_12_1)
	echoInfo("WS_WorldRes_FightStart_Ack")

	if g_CombatSystem:isFighting() then
		return
	end

	if arg_12_1.RetData.BattleInfo and zbUtil:fightReqAckSign(arg_12_1.RetData.BattleInfo) ~= arg_12_1.RetData.BattleInfo.Sign then
		g_Bubble:bubbleInfo(a2u("ս\xB6\xB7\xCA\xFD\xBE\xDDУ\xD1\xE9ʧ\xB0\xDC"))

		return
	end

	g_Self.kDataChange:update(arg_12_1)
	g_CombatSystem:startWorldResInfoBattle(arg_12_1.RetData)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_WorldResFight_Ack)
end

function zbWsMsgHandler.WS_WorldRes_FightResult_Req(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = {
		NodeId = arg_13_1,
		RandomSeed = arg_13_2,
		Result = arg_13_3,
		Energy = g_CombatSystem:getLegendEnergy()
	}

	var_13_0.Sign = zbUtil:fightResultReqSign(var_13_0)

	g_WsMsgHandler:wsPackMsg(var_13_0, MSG_ID.WS_WorldRes_FightResult_Req)
end

function zbWsMsgHandler.WS_WorldRes_FightResult_Ack(arg_14_0, arg_14_1)
	echoInfo("WS_WorldRes_FightResult_Ack")

	local var_14_0 = arg_14_1.RetData.NodeId

	if arg_14_1.RetData.WorldHoldNode and arg_14_1.RetData.Result >= EBattleResult.Win1 then
		g_Self.kWorldHandler:delNodeFromViewNodeList(var_14_0)
		g_Self.kWorldHandler:updateWorldHoldNode(arg_14_1.RetData.WorldHoldNode)
		g_GameEventMgr:sendEvent(zbGameEvent.Event_UpdateNodeInfo)
	end

	g_Self.kGodHandler:updateGodInfo(arg_14_1.RetData.GodInfo)
	g_CombatSystem.combatData:setBalanceAwards(arg_14_1.RetData, arg_14_1.RetData.Result, arg_14_1.RetData.AwardList)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_WorldRes_FightResult_Ack)
end

function zbWsMsgHandler.WS_WorldRes_Gain_Req(arg_15_0, arg_15_1)
	local var_15_0 = {
		NodeId = arg_15_1
	}

	g_WsMsgHandler:wsPackMsg(var_15_0, MSG_ID.WS_WorldRes_Gain_Req)
end

function zbWsMsgHandler.WS_WorldRes_Gain_Ack(arg_16_0, arg_16_1)
	echoInfo("WS_WorldRes_Gain_Ack")

	WorldResGainAckData = arg_16_1.RetData

	g_Self.kDataChange:update(arg_16_1)
	g_Self.kWorldHandler:updateWorldHoldNode(arg_16_1.RetData.WorldHoldNode)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_UpdateNodeInfo)
end

function zbWsMsgHandler.WS_WorldRes_Refresh_Req(arg_17_0, arg_17_1)
	local var_17_0 = {
		NodeId = arg_17_1
	}

	g_WsMsgHandler:wsPackMsg(var_17_0, MSG_ID.WS_WorldRes_Refresh_Req)
end

function zbWsMsgHandler.WS_WorldRes_Refresh_Ack(arg_18_0, arg_18_1)
	echoInfo("WS_WorldRes_Refresh_Ack")
	g_Self.kWorldHandler:updateWorldViewNode(arg_18_1.RetData.WorldViewNode)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_UpdateNodeInfo)
end

function zbWsMsgHandler.WS_WorldRes_ClearCD_Req(arg_19_0, arg_19_1)
	local var_19_0 = {
		NodeId = arg_19_1
	}

	g_WsMsgHandler:wsPackMsg(var_19_0, MSG_ID.WS_WorldRes_ClearCD_Req)
end

function zbWsMsgHandler.WS_WorldRes_ClearCD_Ack(arg_20_0, arg_20_1)
	echoInfo("WS_WorldRes_ClearCD_Ack")
	g_Self.kWorldHandler:updateWorldViewNode(arg_20_1.RetData.WorldViewNode)
	g_Self.kDataChange:update(arg_20_1)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_UpdateNodeInfo)
end

function zbWsMsgHandler.WS_WorldSpe_Open_Req(arg_21_0, arg_21_1)
	local var_21_0 = {}

	WorldSpeOpenAckData = nil
	var_21_0.NodeId = arg_21_1

	g_WsMsgHandler:wsPackMsg(var_21_0, MSG_ID.WS_WorldSpe_Open_Req)
end

function zbWsMsgHandler.WS_WorldSpe_Open_Ack(arg_22_0, arg_22_1)
	echoInfo("WS_WorldSpe_Open_Ack")

	WorldSpeOpenAckData = arg_22_1.RetData

	g_Self.kDataChange:update(arg_22_1)
	g_Self.kWorldHandler:updateWorldSpecialInfo(arg_22_1.RetData)
	g_Self.kWorldHandler:openSpecialAck(arg_22_1.RetData)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_UpdateSpecialInfo)
end

function zbWsMsgHandler.WS_WorldSpe_GetInfo_Req(arg_23_0)
	local var_23_0 = {}

	g_WsMsgHandler:wsPackMsg(var_23_0, MSG_ID.WS_WorldSpe_GetInfo_Req)
end

function zbWsMsgHandler.WS_WorldSpe_GetInfo_Ack(arg_24_0, arg_24_1)
	echoInfo("WS_WorldSpe_GetInfo_Ack")
	g_Self.kWorldHandler:updateWorldSpecialInfo(arg_24_1.RetData)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_UpdateSpecialInfo)
end

function zbWsMsgHandler.WS_WorldTask_Start_Req(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = {
		NodeId = arg_25_1,
		Count = arg_25_2,
		HeroList = arg_25_3
	}

	g_WsMsgHandler:wsPackMsg(var_25_0, MSG_ID.WS_WorldTask_Start_Req)
end

function zbWsMsgHandler.WS_WorldTask_Start_Ack(arg_26_0, arg_26_1)
	echoInfo("WS_WorldTask_Start_Ack")
	g_Self.kDataChange:update(arg_26_1)
	g_Self.kWorldHandler:updateWorldTaskInfoById(arg_26_1.RetData.WorldTaskNode)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_UpdateWorldTaskNode)
end

function zbWsMsgHandler.WS_WorldTask_Gain_Req(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = {
		NodeId = arg_27_1,
		Index = arg_27_2
	}

	g_WsMsgHandler:wsPackMsg(var_27_0, MSG_ID.WS_WorldTask_Gain_Req)
end

function zbWsMsgHandler.WS_WorldTask_Gain_Ack(arg_28_0, arg_28_1)
	echoInfo("WS_WorldTask_Gain_Ack")
	g_Self.kDataChange:update(arg_28_1)
	g_Self.kWorldHandler:updateWorldTaskInfoById(arg_28_1.RetData.WorldTaskNode)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_UpdateWorldTaskNode)
end

function zbWsMsgHandler.WS_WorldSpe_BgzBribe_Req(arg_29_0, arg_29_1)
	local var_29_0 = {
		NodeId = arg_29_1
	}

	g_WsMsgHandler:wsPackMsg(var_29_0, MSG_ID.WS_WorldSpe_BgzBribe_Req)
end

function zbWsMsgHandler.WS_WorldSpe_BgzBribe_Ack(arg_30_0, arg_30_1)
	echoInfo("WS_WorldSpe_BgzBribe_Ack")
	g_Self.kDataChange:update(arg_30_1)
	g_Self.kWorldHandler:updateWorldBgzInfo(arg_30_1.RetData.BgzInfo)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_UpdateBgzInfo)
end

function zbWsMsgHandler.WS_WorldSpe_FaceStart_Req(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = {
		NodeId = arg_31_1,
		Face = arg_31_2
	}

	g_WsMsgHandler:wsPackMsg(var_31_0, MSG_ID.WS_WorldSpe_FaceStart_Req)
end

function zbWsMsgHandler.WS_WorldSpe_FaceStart_Ack(arg_32_0, arg_32_1)
	echoInfo("WS_WorldSpe_FaceStart_Ack")
	g_Self.kWorldHandler:updateWorldFaceInfo(arg_32_1.RetData.FaceList)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_UpdateFaceInfo)
end

function zbWsMsgHandler.WS_WorldSpe_FaceEnd_Req(arg_33_0, arg_33_1)
	local var_33_0 = {
		NodeId = arg_33_1
	}

	g_WsMsgHandler:wsPackMsg(var_33_0, MSG_ID.WS_WorldSpe_FaceEnd_Req)
end

function zbWsMsgHandler.WS_WorldSpe_FaceEnd_Ack(arg_34_0, arg_34_1)
	echoInfo("WS_WorldSpe_FaceEnd_Ack")
	g_Self.kDataChange:update(arg_34_1)
	g_Self.kWorldHandler:updateWorldFaceInfo(arg_34_1.RetData.FaceList)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_UpdateSpecialInfo)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_FaceEndAck)
end

function zbWsMsgHandler.WS_WorldSpe_AwardBox_Req(arg_35_0, arg_35_1)
	local var_35_0 = {
		NodeId = arg_35_1
	}

	g_WsMsgHandler:wsPackMsg(var_35_0, MSG_ID.WS_WorldSpe_AwardBox_Req)
end

function zbWsMsgHandler.WS_WorldSpe_AwardBox_Ack(arg_36_0, arg_36_1)
	echoInfo("WS_WorldSpe_AwardBox_Ack")
	g_Self.kDataChange:update(arg_36_1)
	g_Self.kWorldHandler:updateWorldAwardBoxInfo(arg_36_1.RetData.AwardBoxList)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_UpdateSpecialInfo)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_AwardBoxAck)
end

function zbWsMsgHandler.WS_WorldSpe_HCGiveUp_Req(arg_37_0, arg_37_1)
	local var_37_0 = {
		NodeId = arg_37_1
	}

	g_WsMsgHandler:wsPackMsg(var_37_0, MSG_ID.WS_WorldSpe_HCGiveUp_Req)
end

function zbWsMsgHandler.WS_WorldSpe_HCGiveUp_Ack(arg_38_0, arg_38_1)
	echoInfo("WS_WorldSpe_HCGiveUp_Ack")
	g_Self.kWorldHandler:updateWorldHorseCarInfo(arg_38_1.RetData.HorseCarList)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_UpdateSpecialInfo)
end

local var_0_0 = 0

function zbWsMsgHandler.WS_WorldSpe_HCFightStart_Req(arg_39_0, arg_39_1)
	local var_39_0 = {
		NodeId = arg_39_1
	}

	var_0_0 = arg_39_1

	g_WsMsgHandler:wsPackMsg(var_39_0, MSG_ID.WS_WorldSpe_HCFightStart_Req)
end

function zbWsMsgHandler.WS_WorldSpe_HCFightStart_Ack(arg_40_0, arg_40_1)
	echoInfo("WS_WorldSpe_HCFightStart_Ack")

	if g_CombatSystem:isFighting() then
		return
	end

	if arg_40_1.RetData.BattleInfo and zbUtil:fightReqAckSign(arg_40_1.RetData.BattleInfo) ~= arg_40_1.RetData.BattleInfo.Sign then
		g_Bubble:bubbleInfo(a2u("ս\xB6\xB7\xCA\xFD\xBE\xDDУ\xD1\xE9ʧ\xB0\xDC"))

		return
	end

	g_CombatSystem:startHorseBattle(arg_40_1.RetData)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_WorldHorseFight_Ack)
end

function zbWsMsgHandler.WS_WorldSpe_HCFightResult_Req(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = {
		NodeId = var_0_0,
		RandomSeed = arg_41_1,
		Result = arg_41_2,
		Energy = g_CombatSystem:getLegendEnergy()
	}

	var_41_0.Sign = zbUtil:fightResultReqSign(var_41_0)

	g_WsMsgHandler:wsPackMsg(var_41_0, MSG_ID.WS_WorldSpe_HCFightResult_Req)
end

function zbWsMsgHandler.WS_WorldSpe_HCFightResult_Ack(arg_42_0, arg_42_1)
	echoInfo("WS_WorldSpe_HCFightResult_Ack")
	g_Self.kDataChange:update(arg_42_1)
	g_Self.kGodHandler:updateGodInfo(arg_42_1.RetData.GodInfo)
	g_Self.kWorldHandler:updateWorldHorseCarInfo(arg_42_1.RetData.HorseCarList)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_UpdateSpecialInfo)
	g_CombatSystem.combatData:setBalanceAwards(arg_42_1.RetData, arg_42_1.RetData.Result, arg_42_1.RetData.AwardList)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_WorldHorse_FightResult_Ack)
end

function zbWsMsgHandler.WS_WorldRes_Settle_Req(arg_43_0)
	local var_43_0 = {}

	g_WsMsgHandler:wsPackMsg(var_43_0, MSG_ID.WS_WorldRes_Settle_Req)
end

function zbWsMsgHandler.WS_WorldRes_Settle_Ack(arg_44_0, arg_44_1)
	echoInfo("WS_WorldRes_Settle_Ack")
	g_Self.kDataChange:update(arg_44_1)
	g_Self.kWorldHandler:updateWorldSettleList(arg_44_1.RetData.SettleList)
end

function zbWsMsgHandler.WS_World_GetLog_Req(arg_45_0)
	local var_45_0 = {}

	g_WsMsgHandler:wsPackMsg(var_45_0, MSG_ID.WS_World_GetLog_Req)
end

function zbWsMsgHandler.WS_World_GetLog_Ack(arg_46_0, arg_46_1)
	echoInfo("WS_World_GetLog_Ack")

	g_Self.kWorldHandler.worldLogList = arg_46_1.RetData.LogList

	g_GameEventMgr:sendEvent(zbGameEvent.Event_WorldLog_Ack)
end

function zbWsMsgHandler.WS_WorldBoss_StartFight_Req(arg_47_0)
	local var_47_0 = {}

	g_WsMsgHandler:wsPackMsg(var_47_0, MSG_ID.WS_WorldBoss_StartFight_Req)
end

function zbWsMsgHandler.WS_WorldBoss_StartFight_Ack(arg_48_0, arg_48_1)
	echoInfo("WS_WorldBoss_StartFight_Ack")

	if g_CombatSystem:isFighting() then
		return
	end

	if arg_48_1.RetData.BattleInfo and zbUtil:fightReqAckSign(arg_48_1.RetData.BattleInfo) ~= arg_48_1.RetData.BattleInfo.Sign then
		g_Bubble:bubbleInfo(a2u("ս\xB6\xB7\xCA\xFD\xBE\xDDУ\xD1\xE9ʧ\xB0\xDC"))

		return
	end

	g_Self.kDataChange:update(arg_48_1)
	g_CombatSystem:startWorldBossBattle(arg_48_1.RetData)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_WorldResFight_Ack)
end

function zbWsMsgHandler.WS_WorldBoss_FightResult_Req(arg_49_0, arg_49_1, arg_49_2, arg_49_3, arg_49_4)
	local var_49_0 = {
		HpPercent = arg_49_1,
		HurtHp = arg_49_2,
		RandomSeed = arg_49_3,
		FightCount = arg_49_4
	}

	g_Self.kWorldHandler.worldbossHit = arg_49_2
	var_49_0.Sign = zbUtil:fightResultReqSign(var_49_0)

	g_WsMsgHandler:wsPackMsg(var_49_0, MSG_ID.WS_WorldBoss_FightResult_Req)
end

function zbWsMsgHandler.WS_WorldBoss_FightResult_Ack(arg_50_0, arg_50_1)
	echoInfo("WS_WorldBoss_FightResult_Ack")
	g_Self.kDataChange:update(arg_50_1)
	g_CombatSystem.combatData:setBalanceAwards(arg_50_1.RetData, EBattleResult.Win1, arg_50_1.RetData.AwardList)
	g_Self.kWorldHandler:updateWorldBossInfo(arg_50_1.RetData.BossInfo)
	g_Self.kWorldHandler:updateWorldBossSelfInfo(arg_50_1.RetData.SelfInfo)
	g_Self.kWorldHandler:updateWorldBossBuffList(arg_50_1.RetData.BuffList)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_WorldBossFightResult_Ack)
end

function zbWsMsgHandler.WS_WorldBoss_ClearCD_Req(arg_51_0)
	local var_51_0 = {}

	g_WsMsgHandler:wsPackMsg(var_51_0, MSG_ID.WS_WorldBoss_ClearCD_Req)
end

function zbWsMsgHandler.WS_WorldBoss_ClearCD_Ack(arg_52_0, arg_52_1)
	echoInfo("WS_WorldBoss_ClearCD_Ack")
	g_Self.kDataChange:update(arg_52_1)
	g_Self.kWorldHandler:updateWorldBossSelfInfo(arg_52_1.RetData.SelfInfo)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_WorldBoss_GetInfo_Ack)
end

function zbWsMsgHandler.WS_WorldBoss_Inspire_Req(arg_53_0)
	local var_53_0 = {}

	g_WsMsgHandler:wsPackMsg(var_53_0, MSG_ID.WS_WorldBoss_Inspire_Req)
end

function zbWsMsgHandler.WS_WorldBoss_Inspire_Ack(arg_54_0, arg_54_1)
	echoInfo("WS_WorldBoss_Inspire_Ack")
	g_Self.kDataChange:update(arg_54_1)
	g_Self.kWorldHandler:updateWorldBossBuffList(arg_54_1.RetData.BuffList)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_WorldBoss_Inspire_Ack)
end

function zbWsMsgHandler.WS_WorldBoss_DamageRank_Req(arg_55_0)
	local var_55_0 = {}

	g_WsMsgHandler:wsPackMsg(var_55_0, MSG_ID.WS_WorldBoss_DamageRank_Req)
end

function zbWsMsgHandler.WS_WorldBoss_DamageRank_Ack(arg_56_0, arg_56_1)
	echoInfo("WS_WorldBoss_DamageRank_Ack")

	if zbUtil:isValidTable(arg_56_1.RetData) then
		g_MainScene:showWorldBossRank(arg_56_1.RetData)
	end
end

function zbWsMsgHandler.WS_WorldBoss_GetInfo_Req(arg_57_0)
	local var_57_0 = {}

	g_WsMsgHandler:wsPackMsg(var_57_0, MSG_ID.WS_WorldBoss_GetInfo_Req)
end

function zbWsMsgHandler.WS_WorldBoss_GetInfo_Ack(arg_58_0, arg_58_1)
	echoInfo("WS_WorldBoss_GetInfo_Ack")
	g_Self.kWorldHandler:updateWorldBossInfo(arg_58_1.RetData.BossInfo)
	g_Self.kWorldHandler:updateWorldBossSelfInfo(arg_58_1.RetData.SelfInfo)
	g_Self.kWorldHandler:updateWorldBossBuffList(arg_58_1.RetData.BuffList)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_WorldBoss_GetInfo_Ack)
end

function zbWsMsgHandler.WS_WorldBoss_GetAward_Req(arg_59_0)
	local var_59_0 = {}

	g_WsMsgHandler:wsPackMsg(var_59_0, MSG_ID.WS_WorldBoss_GetAward_Req)
end

function zbWsMsgHandler.WS_WorldBoss_GetAward_Ack(arg_60_0, arg_60_1)
	echoInfo("WS_WorldBoss_GetAward_Ack")
	g_Self.kDataChange:update(arg_60_1)
	g_Self.kWorldHandler:updateWorldBossSelfInfo(arg_60_1.RetData.SelfInfo)

	if g_MainScene.wndWorldBossAward ~= nil then
		g_MainScene.wndWorldBossAward:hide()
	end

	g_GameEventMgr:sendEvent(zbGameEvent.Event_WorldBoss_GetInfo_Ack)
end
