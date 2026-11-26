function zbWsMsgHandler.WS_Trial_GetInfo_Req(arg_1_0)
	local var_1_0 = {}

	g_WsMsgHandler:wsPackMsg(var_1_0, MSG_ID.WS_Trial_GetInfo_Req)
end

function zbWsMsgHandler.WS_Trial_GetInfo_Ack(arg_2_0, arg_2_1)
	echoInfo("WS_Trial_GetInfo_Ack")
	g_Self.kHeroTrialHandler:updateAllTrialInfo(arg_2_1.RetData.AllTrialInfo)
	g_MainScene:showHeroTrialWnd()
end

function zbWsMsgHandler.WS_Trial_FightStart_Req(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = {
		TrialType = arg_3_1,
		Level = arg_3_2
	}

	g_WsMsgHandler:wsPackMsg(var_3_0, MSG_ID.WS_Trial_FightStart_Req)
end

function zbWsMsgHandler.WS_Trial_FightStart_Ack(arg_4_0, arg_4_1)
	echoInfo("WS_Trial_FightStart_Ack")

	if g_CombatSystem:isFighting() then
		return
	end

	if arg_4_1.RetData.BattleInfo and zbUtil:fightReqAckSign(arg_4_1.RetData.BattleInfo) ~= arg_4_1.RetData.BattleInfo.Sign then
		g_Bubble:bubbleInfo(a2u("ս\xB6\xB7\xCA\xFD\xBE\xDDУ\xD1\xE9ʧ\xB0\xDC"))

		return
	end

	g_Self.kHeroTrialHandler:updateTrialInfo(arg_4_1.RetData.TrialInfo)
	g_CombatSystem:startTrial(arg_4_1.RetData)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_Trial_FightStart_Ack)
end

function zbWsMsgHandler.WS_Trial_FightResult_Req(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	local var_5_0 = {
		TrialType = arg_5_1,
		Level = arg_5_2,
		HpPercent = arg_5_3,
		Result = arg_5_4,
		Energy = g_CombatSystem:getLegendEnergy(),
		RandomSeed = arg_5_5
	}

	var_5_0.Sign = zbUtil:fightResultReqSign(var_5_0)

	g_WsMsgHandler:wsPackMsg(var_5_0, MSG_ID.WS_Trial_FightResult_Req)
end

function zbWsMsgHandler.WS_Trial_FightResult_Ack(arg_6_0, arg_6_1)
	echoInfo("WS_Trial_FightResult_Ack")
	g_Self.kHeroTrialHandler:updateTrialInfo(arg_6_1.RetData.TrialInfo)
	g_Self.kDataChange:update(arg_6_1)
	g_Self.kGodHandler:updateGodInfo(arg_6_1.RetData.GodInfo)
	g_CombatSystem.combatData:setBalanceAwards(arg_6_1.RetData, arg_6_1.RetData.Result, arg_6_1.RetData.AwardList)
	g_Self:updateBaseInfo(arg_6_1.RetData.BaseInfo)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_Trial_FightResultAck)
end

local var_0_0 = 0
local var_0_1 = 0

function zbWsMsgHandler.WS_Trial_SaoDang_Req(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = {
		TrialType = arg_7_1,
		Level = arg_7_2
	}

	g_WsMsgHandler:wsPackMsg(var_7_0, MSG_ID.WS_Trial_SaoDang_Req)

	var_0_0 = g_GameData.BaseInfo.Level
	var_0_1 = g_GameData.BaseInfo.Exp
end

function zbWsMsgHandler.WS_Trial_SaoDang_Ack(arg_8_0, arg_8_1)
	echoInfo("WS_Trial_SaoDang_Ack")
	g_Self.kHeroTrialHandler:updateTrialInfo(arg_8_1.RetData.TrialInfo)
	g_Self.kDataChange:update(arg_8_1)
	g_MainScene:showHeroTrialSweepWnd(arg_8_1.RetData)
end

function zbWsMsgHandler.WS_Dolls_PutCoin_Req(arg_9_0)
	local var_9_0 = {}

	g_WsMsgHandler:wsPackMsg(var_9_0, MSG_ID.WS_Dolls_PutCoin_Req)
end

function zbWsMsgHandler.WS_Dolls_PutCoin_Ack(arg_10_0, arg_10_1)
	echoInfo("WS_Dolls_PutCoin_Ack")
	g_Self.kHeroTrialHandler:updateDollsInfo(arg_10_1.RetData.DollsInfo)
	g_Self.kDataChange:update(arg_10_1)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_Dolls_PutCoinAck)
end

function zbWsMsgHandler.WS_Dolls_Grab_Req(arg_11_0, arg_11_1)
	local var_11_0 = {
		Index = arg_11_1
	}

	g_WsMsgHandler:wsPackMsg(var_11_0, MSG_ID.WS_Dolls_Grab_Req)
end

function zbWsMsgHandler.WS_Dolls_Grab_Ack(arg_12_0, arg_12_1)
	echoInfo("WS_Dolls_Grab_Ack")
	g_Self.kHeroTrialHandler:updateDollsInfo(arg_12_1.RetData.DollsInfo)

	g_Self.kHeroTrialHandler.DollsGrabResult = arg_12_1.RetData.Result
	g_Self.kHeroTrialHandler.dataChange = arg_12_1

	g_GameEventMgr:sendEvent(zbGameEvent.Event_Dolls_GrabAck)
end

function zbWsMsgHandler.WS_Dolls_GetInfo_Req(arg_13_0)
	local var_13_0 = {}

	g_WsMsgHandler:wsPackMsg(var_13_0, MSG_ID.WS_Dolls_GetInfo_Req)
end

function zbWsMsgHandler.WS_Dolls_GetInfo_Ack(arg_14_0, arg_14_1)
	echoInfo("WS_Dolls_GetInfo_Ack")
	g_Self.kHeroTrialHandler:updateDollsInfo(arg_14_1.RetData.DollsInfo)
	g_MainScene:showWawajiWnd()
end
