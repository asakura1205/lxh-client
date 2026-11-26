function zbWsMsgHandler.WS_Bgz_GetInfo_Req(arg_1_0)
	local var_1_0 = {}

	g_WsMsgHandler:wsPackMsg(var_1_0, MSG_ID.WS_Bgz_GetInfo_Req)
end

function zbWsMsgHandler.WS_Bgz_GetInfo_Ack(arg_2_0, arg_2_1)
	echoInfo("WS_Bgz_GetInfo_Ack")
	g_Self.kYuanzhengHandler:updateYuanzhengInfo(arg_2_1.RetData.BgzInfo)
	g_MainScene:showYuanZhengWnd()
end

function zbWsMsgHandler.WS_Bgz_GetBossInfo_Req(arg_3_0, arg_3_1)
	local var_3_0 = {
		Index = arg_3_1
	}

	g_WsMsgHandler:wsPackMsg(var_3_0, MSG_ID.WS_Bgz_GetBossInfo_Req)
end

function zbWsMsgHandler.WS_Bgz_GetBossInfo_Ack(arg_4_0, arg_4_1)
	echoInfo("WS_Bgz_GetBossInfo_Ack")
	g_Self.kYuanzhengHandler:updateFormationInfo(arg_4_1.RetData.PlayerTipsInfo)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_Bgz_GetBossInfo_Ack)
end

function zbWsMsgHandler.WS_Bgz_GetAward_Req(arg_5_0)
	local var_5_0 = {}

	g_WsMsgHandler:wsPackMsg(var_5_0, MSG_ID.WS_Bgz_GetAward_Req)
end

function zbWsMsgHandler.WS_Bgz_GetAward_Ack(arg_6_0, arg_6_1)
	echoInfo("WS_Bgz_GetAward_Ack")
	g_Self.kDataChange:update(arg_6_1)
	g_Self.kYuanzhengHandler:updateYuanzhengInfo(arg_6_1.RetData.BgzInfo)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_Bgz_RefreshInfo_Ack)
end

function zbWsMsgHandler.WS_Bgz_FightStart_Req(arg_7_0, arg_7_1)
	local var_7_0 = {
		Index = arg_7_1
	}

	g_WsMsgHandler:wsPackMsg(var_7_0, MSG_ID.WS_Bgz_FightStart_Req)
end

function zbWsMsgHandler.WS_Bgz_FightStart_Ack(arg_8_0, arg_8_1)
	echoInfo("WS_Bgz_FightStart_Ack")

	if g_CombatSystem:isFighting() then
		return
	end

	if arg_8_1.RetData.BattleInfo and zbUtil:fightReqAckSign(arg_8_1.RetData.BattleInfo) ~= arg_8_1.RetData.BattleInfo.Sign then
		g_Bubble:bubbleInfo(a2u("ս\xB6\xB7\xCA\xFD\xBE\xDDУ\xD1\xE9ʧ\xB0\xDC"))

		return
	end

	g_CombatSystem:startYuanzhengBattle(arg_8_1.RetData)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_YuanzhengFight_Ack)
end

function zbWsMsgHandler.WS_Bgz_FightResult_Req(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = {
		RandomSeed = arg_9_1,
		Result = arg_9_2,
		Energy = g_CombatSystem:getLegendEnergy(),
		Index = g_Self.kYuanzhengHandler.currBtnIndex
	}

	var_9_0.Sign = zbUtil:fightResultReqSign(var_9_0)

	g_WsMsgHandler:wsPackMsg(var_9_0, MSG_ID.WS_Bgz_FightResult_Req)
end

function zbWsMsgHandler.WS_Bgz_FightResult_Ack(arg_10_0, arg_10_1)
	echoInfo("WS_Bgz_FightResult_Ack")
	g_Self.kYuanzhengHandler:updateYuanzhengInfo(arg_10_1.RetData.BgzInfo)
	g_Self.kDataChange:update(arg_10_1)
	g_Self.kGodHandler:updateGodInfo(arg_10_1.RetData.GodInfo)
	g_CombatSystem.combatData:setBalanceAwards(arg_10_1.RetData, arg_10_1.RetData.Result, arg_10_1.RetData.AwardList)
	g_Self:updateBaseInfo(arg_10_1.RetData.BaseInfo)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_Yuanzheng_FightResult_Ack)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_Bgz_RefreshInfo_Ack)
end

function zbWsMsgHandler.WS_Bgz_GetScoreAward_Req(arg_11_0, arg_11_1)
	local var_11_0 = {
		Score = arg_11_1
	}

	g_WsMsgHandler:wsPackMsg(var_11_0, MSG_ID.WS_Bgz_GetScoreAward_Req)
end

function zbWsMsgHandler.WS_Bgz_GetScoreAward_Ack(arg_12_0, arg_12_1)
	echoInfo("WS_Bgz_GetScoreAward_Ack")
	g_Self.kDataChange:update(arg_12_1)
	g_Self.kYuanzhengHandler:updateYuanzhengInfo(arg_12_1.RetData.BgzInfo)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_Bgz_RefreshInfo_Ack)
end

function zbWsMsgHandler.WS_Bgz_Reset_Req(arg_13_0)
	local var_13_0 = {}

	g_WsMsgHandler:wsPackMsg(var_13_0, MSG_ID.WS_Bgz_Reset_Req)
end

function zbWsMsgHandler.WS_Bgz_Reset_Ack(arg_14_0, arg_14_1)
	echoInfo("WS_Bgz_Reset_Ack")
	g_Self.kDataChange:update(arg_14_1)
	g_Self.kYuanzhengHandler:updateYuanzhengInfo(arg_14_1.RetData.BgzInfo)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_Bgz_RefreshInfo_Ack)
end
