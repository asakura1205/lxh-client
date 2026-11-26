function zbWsMsgHandler.WS_Chat_SendReq(arg_1_0, arg_1_1)
	g_WsMsgHandler:wsPackMsg(arg_1_1, MSG_ID.WS_Chat_Send_Req)
	zbGlobalUtil:GameCallSDKFunction("hideNavigation", "", "")
end

function zbWsMsgHandler.WS_Chat_Send_Ack(arg_2_0, arg_2_1)
	echoInfo("WS_Chat_SendAck")
	g_Self.kDataChange:update(arg_2_1)
	g_Self.kChatHandler:setCdInfo(arg_2_1.RetData.CDInfo)
end

function zbWsMsgHandler.WS_Chat_Ntf(arg_3_0, arg_3_1)
	echoInfo("WS_Chat_Ntf")
	g_Self.kChatHandler:onNewChatNtf(arg_3_1.RetData)
end

function zbWsMsgHandler.WS_ChatRecord_Ntf(arg_4_0, arg_4_1)
	echoInfo("WS_ChatRecord_Ntf")
	g_Self.kChatHandler:onLoginChatNtf(arg_4_1.RetData)
end

function zbWsMsgHandler.WS_Scroll_Ntf(arg_5_0, arg_5_1)
	echoInfo("WS_Scroll_Ntf")
	g_Broadcast:refresh(arg_5_1.RetData)
end

function zbWsMsgHandler.WS_Common_BuyHorn_Req(arg_6_0, arg_6_1)
	local var_6_0 = {
		Count = arg_6_1
	}

	g_WsMsgHandler:wsPackMsg(var_6_0, MSG_ID.WS_Common_BuyHorn_Req)
end

function zbWsMsgHandler.WS_Common_BuyHorn_Ack(arg_7_0, arg_7_1)
	echoInfo("WS_Common_BuyHorn_Ack")
	g_Self.kDataChange:update(arg_7_1)
end

function zbWsMsgHandler.WS_Common_FightStart_Req(arg_8_0, arg_8_1)
	local var_8_0 = {
		PlayerId = arg_8_1
	}

	g_WsMsgHandler:wsPackMsg(var_8_0, MSG_ID.WS_Common_FightStart_Req)
end

function zbWsMsgHandler.WS_Common_FightStart_Ack(arg_9_0, arg_9_1)
	echoInfo("WS_Common_FightStart_Ack")

	if g_CombatSystem:isFighting() then
		return
	end

	if arg_9_1.RetData.BattleInfo and zbUtil:fightReqAckSign(arg_9_1.RetData.BattleInfo) ~= arg_9_1.RetData.BattleInfo.Sign then
		g_Bubble:bubbleInfo(a2u("ս\xB6\xB7\xCA\xFD\xBE\xDDУ\xD1\xE9ʧ\xB0\xDC"))

		return
	end

	g_CombatSystem:startChatBattle(arg_9_1.RetData)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_ChatFight_Ack)
end

function zbWsMsgHandler.WS_Common_FightResult_Req(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = {
		PlayerId = arg_10_1,
		RandomSeed = arg_10_2,
		Result = arg_10_3,
		Energy = g_CombatSystem:getLegendEnergy()
	}

	var_10_0.Sign = zbUtil:fightResultReqSign(var_10_0)

	g_WsMsgHandler:wsPackMsg(var_10_0, MSG_ID.WS_Common_FightResult_Req)
end

function zbWsMsgHandler.WS_Common_FightResult_Ack(arg_11_0, arg_11_1)
	echoInfo("WS_Common_FightResult_Ack")
	g_Self.kDataChange:update(arg_11_1)
	g_CombatSystem.combatData:setBalanceAwards(arg_11_1.RetData, arg_11_1.RetData.Result, arg_11_1.RetData.AwardList)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_ChatFightResultSyn_Ack)
end
