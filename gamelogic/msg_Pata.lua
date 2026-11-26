function zbWsMsgHandler.WS_Pata_GetInfo_Req(arg_1_0)
	local var_1_0 = {}

	g_WsMsgHandler:wsPackMsg(var_1_0, MSG_ID.WS_Pata_GetInfo_Req)
end

function zbWsMsgHandler.WS_Pata_GetInfo_Ack(arg_2_0, arg_2_1)
	echoInfo("WS_Pata_GetInfo_Ack")
	g_Self.kPataHandler:updatePataInfo(arg_2_1.RetData.PataInfo)
end

function zbWsMsgHandler.WS_Pata_FightStart_Req(arg_3_0)
	local var_3_0 = {
		Layer = g_GameData.PataInfo.BaseInfo.Layer
	}

	g_WsMsgHandler:wsPackMsg(var_3_0, MSG_ID.WS_Pata_FightStart_Req)
end

function zbWsMsgHandler.WS_Pata_FightStart_Ack(arg_4_0, arg_4_1)
	echoInfo("WS_Pata_FightStart_Ack")

	if g_CombatSystem:isFighting() then
		return
	end

	if arg_4_1.RetData.BattleInfo and zbUtil:fightReqAckSign(arg_4_1.RetData.BattleInfo) ~= arg_4_1.RetData.BattleInfo.Sign then
		g_Bubble:bubbleInfo(a2u("ս\xB6\xB7\xCA\xFD\xBE\xDDУ\xD1\xE9ʧ\xB0\xDC"))

		return
	end

	g_CombatSystem:startPataBattle(arg_4_1.RetData)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_PataFight_Ack)
end

function zbWsMsgHandler.WS_Pata_FightResult_Req(arg_5_0, arg_5_1, arg_5_2)
	echoInfo("WS_Pata_FightResult_Req")

	local var_5_0 = {
		RandomSeed = arg_5_1,
		Result = arg_5_2,
		Energy = g_CombatSystem:getLegendEnergy(),
		Layer = g_GameData.PataInfo.BaseInfo.Layer
	}

	var_5_0.Sign = zbUtil:fightResultReqSign(var_5_0)

	g_WsMsgHandler:wsPackMsg(var_5_0, MSG_ID.WS_Pata_FightResult_Req)
end

function zbWsMsgHandler.WS_Pata_FightResult_Ack(arg_6_0, arg_6_1)
	echoInfo("WS_Pata_FightResult_Ack")
	g_Self.kPataHandler:updateBaseInfo(arg_6_1.RetData.BaseInfo)
	g_Self.kPataHandler:updateFightLayerInfo(arg_6_1.RetData.FightLayerInfo)
	g_Self.kDataChange:update(arg_6_1)
	g_Self.kGodHandler:updateGodInfo(arg_6_1.RetData.GodInfo)
	g_CombatSystem.combatData:setBalanceAwards(arg_6_1.RetData, arg_6_1.RetData.Result, arg_6_1.RetData.AwardList)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_Pata_FightResult_Ack)
end

function zbWsMsgHandler.WS_Pata_BuyBuff_Req(arg_7_0, arg_7_1)
	local var_7_0 = {
		BuffId = arg_7_1
	}

	g_WsMsgHandler:wsPackMsg(var_7_0, MSG_ID.WS_Pata_BuyBuff_Req)
end

function zbWsMsgHandler.WS_Pata_BuyBuff_Ack(arg_8_0, arg_8_1)
	echoInfo("WS_Pata_BuyBuff_Ack")
	g_Self.kDataChange:update(arg_8_1)
	g_Self.kPataHandler:updateBaseInfo(arg_8_1.RetData.BaseInfo)
	g_Self.kPataHandler:updateBuffLayerInfo(arg_8_1.RetData.BuffLayerInfo)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_PataRefreshAck)
end

function zbWsMsgHandler.WS_Pata_GetAward_Req(arg_9_0, arg_9_1)
	local var_9_0 = {
		BrandIndex = arg_9_1
	}

	g_WsMsgHandler:wsPackMsg(var_9_0, MSG_ID.WS_Pata_GetAward_Req)
end

function zbWsMsgHandler.WS_Pata_GetAward_Ack(arg_10_0, arg_10_1)
	echoInfo("WS_Pata_GetAward_Ack")
	g_Self.kDataChange:update(arg_10_1)
	g_Self.kPataHandler:updateAwardLayerInfo(arg_10_1.RetData.AwardLayerInfo)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_PataRefreshAck)
end

function zbWsMsgHandler.WS_Pata_NextLayer_Req(arg_11_0)
	local var_11_0 = {
		Layer = g_GameData.PataInfo.BaseInfo.Layer
	}

	g_WsMsgHandler:wsPackMsg(var_11_0, MSG_ID.WS_Pata_NextLayer_Req)
end

function zbWsMsgHandler.WS_Pata_NextLayer_Ack(arg_12_0, arg_12_1)
	echoInfo("WS_Pata_NextLayer_Ack")
	g_Self.kPataHandler:updatePataInfo(arg_12_1.RetData.PataInfo)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_Pata_NextLayerAck)
end

function zbWsMsgHandler.WS_Pata_StartSaoDang_Req(arg_13_0)
	local var_13_0 = {}

	g_WsMsgHandler:wsPackMsg(var_13_0, MSG_ID.WS_Pata_StartSaoDang_Req)
end

function zbWsMsgHandler.WS_Pata_StartSaoDang_Ack(arg_14_0, arg_14_1)
	echoInfo("WS_Pata_StartSaoDang_Ack")
	g_Self.kDataChange:update(arg_14_1)
	g_Self.kPataHandler:updatePataInfo(arg_14_1.RetData.PataInfo)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_PataRefreshAck)
end

function zbWsMsgHandler.WS_Pata_SaoDangNext_Req(arg_15_0)
	local var_15_0 = {}

	g_WsMsgHandler:wsPackMsg(var_15_0, MSG_ID.WS_Pata_SaoDangNext_Req)
end

function zbWsMsgHandler.WS_Pata_SaoDangNext_Ack(arg_16_0, arg_16_1)
	echoInfo("WS_Pata_SaoDangNext_Ack")
	g_Self.kDataChange:update(arg_16_1)
	g_Self.kPataHandler:updatePataInfo(arg_16_1.RetData.PataInfo)

	if g_MainScene.wndPataSaoDangAward then
		g_MainScene.wndPataSaoDangAward:hide()
	end

	if g_MainScene.wndPataSaoDangBuy then
		g_MainScene.wndPataSaoDangBuy:hide()
	end

	g_GameEventMgr:sendEvent(zbGameEvent.Event_PataRefreshAck)
end

function zbWsMsgHandler.WS_Pata_SaoDangBuyBuff_Req(arg_17_0, arg_17_1)
	local var_17_0 = {
		BuffId = arg_17_1
	}

	g_WsMsgHandler:wsPackMsg(var_17_0, MSG_ID.WS_Pata_SaoDangBuyBuff_Req)
end

function zbWsMsgHandler.WS_Pata_SaoDangBuyBuff_Ack(arg_18_0, arg_18_1)
	echoInfo("WS_Pata_SaoDangBuyBuff_Ack")
	g_Self.kDataChange:update(arg_18_1)
	g_Self.kPataHandler:updateBaseInfo(arg_18_1.RetData.BaseInfo)
	g_Self.kPataHandler:updateSaoDangInfo(arg_18_1.RetData.SaoDangInfo)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_PataRefreshAck)
end

function zbWsMsgHandler.WS_Pata_SaoDangBuyBuffNext_Req(arg_19_0)
	local var_19_0 = {}

	g_WsMsgHandler:wsPackMsg(var_19_0, MSG_ID.WS_Pata_SaoDangBuyBuffNext_Req)
end

function zbWsMsgHandler.WS_Pata_SaoDangBuyBuffNext_Ack(arg_20_0, arg_20_1)
	echoInfo("WS_Pata_SaoDangBuyBuffNext_Ack")
	g_Self.kDataChange:update(arg_20_1)
	g_Self.kPataHandler:updateBaseInfo(arg_20_1.RetData.BaseInfo)
	g_Self.kPataHandler:updateSaoDangInfo(arg_20_1.RetData.SaoDangInfo)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_PataRefreshAck)
end

function zbWsMsgHandler.WS_Pata_SaoDangTurnBrandNext_Req(arg_21_0)
	local var_21_0 = {}

	g_WsMsgHandler:wsPackMsg(var_21_0, MSG_ID.WS_Pata_SaoDangTurnBrandNext_Req)
end

function zbWsMsgHandler.WS_Pata_SaoDangTurnBrandNext_Ack(arg_22_0, arg_22_1)
	echoInfo("WS_Pata_SaoDangTurnBrandNext_Ack")
	g_Self.kDataChange:update(arg_22_1)
	g_Self.kPataHandler:updatePataInfo(arg_22_1.RetData.PataInfo)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_PataRefreshAck)
end

function zbWsMsgHandler.WS_Pata_SaoDangTurnBrand_Req(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = {
		Layer = arg_23_1,
		Index = arg_23_2
	}

	g_WsMsgHandler:wsPackMsg(var_23_0, MSG_ID.WS_Pata_SaoDangTurnBrand_Req)
end

function zbWsMsgHandler.WS_Pata_SaoDangTurnBrand_Ack(arg_24_0, arg_24_1)
	echoInfo("WS_Pata_SaoDangTurnBrand_Ack")
	g_Self.kDataChange:update(arg_24_1)
	g_Self.kPataHandler:updateBaseInfo(arg_24_1.RetData.BaseInfo)
	g_Self.kPataHandler:updateSaoDangInfo(arg_24_1.RetData.SaoDangInfo)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_PataRefreshAck)
end

function zbWsMsgHandler.WS_Pata_RankData_Req(arg_25_0)
	local var_25_0 = {}

	g_WsMsgHandler:wsPackMsg(var_25_0, MSG_ID.WS_Pata_RankData_Req)
end

function zbWsMsgHandler.WS_Pata_RankData_Req(arg_26_0, arg_26_1)
	echoInfo("WS_Pata_RankData_Req")
end

function zbWsMsgHandler.WS_Pata_GetScoreAward_Req(arg_27_0, arg_27_1)
	local var_27_0 = {
		AwardScore = arg_27_1
	}

	g_WsMsgHandler:wsPackMsg(var_27_0, MSG_ID.WS_Pata_GetScoreAward_Req)
end

function zbWsMsgHandler.WS_Pata_GetScoreAward_Ack(arg_28_0, arg_28_1)
	echoInfo("WS_Pata_GetScoreAward_Ack")
	g_Self.kDataChange:update(arg_28_1)
	g_Self.kPataHandler:updateBaseInfo(arg_28_1.RetData.BaseInfo)
	g_Self.kPataHandler:updateScoreAwardInfo(arg_28_1.RetData.ScoreAwardInfo)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_PataRefreshAck)
end
