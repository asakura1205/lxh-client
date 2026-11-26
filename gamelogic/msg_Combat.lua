function zbWsMsgHandler.WS_GameLevel_FightStart_Req(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	local var_1_0 = {
		ForceId = arg_1_1,
		LevelId = arg_1_2,
		LevelType = arg_1_3,
		TeamList = arg_1_4
	}

	g_WsMsgHandler:wsPackMsg(var_1_0, MSG_ID.WS_GameLevel_FightStart_Req)
end

function zbWsMsgHandler.WS_GameLevel_FightStart_Ack(arg_2_0, arg_2_1)
	echoInfo("WS_GameLevel_FightStart_Ack")
	g_MainScene:hideGuideWnd()

	if g_CombatSystem:isFighting() then
		return
	end

	if arg_2_1.RetData.BattleInfo and zbUtil:fightReqAckSign(arg_2_1.RetData.BattleInfo) ~= arg_2_1.RetData.BattleInfo.Sign then
		g_Bubble:bubbleInfo(a2u("ս\xB6\xB7\xCA\xFD\xBE\xDDУ\xD1\xE9ʧ\xB0\xDC"))

		return
	end

	g_Self.kDataChange:update(arg_2_1)

	local var_2_0 = arg_2_1.RetData

	g_CombatSystem:startLevelBattle(var_2_0)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_LevelBattleReady_Ack)
end

function zbWsMsgHandler.WS_GameLevel_FightResult_Req(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = {
		ForceId = arg_3_1,
		LevelId = arg_3_2,
		LevelType = arg_3_3,
		Result = arg_3_4,
		RandomSeed = zbCombatFormula:getRandomSeed(),
		Energy = g_CombatSystem:getLegendEnergy(),
		TeamList = g_MainScene.wndEmbattle.teamList
	}

	var_3_0.Sign = zbUtil:fightResultReqSign(var_3_0)

	g_WsMsgHandler:wsPackMsg(var_3_0, MSG_ID.WS_GameLevel_FightResult_Req)
end

function zbWsMsgHandler.WS_GameLevel_FightResult_Ack(arg_4_0, arg_4_1)
	echoInfo("WS_GameLevel_FightResult_Ack")
	g_Self.kDataChange:update(arg_4_1)
	g_Self.kWarPathHandler:updateForceDetail(arg_4_1.RetData.ForceId, arg_4_1.RetData.ForceDetail)
	g_Self.kGodHandler:updateGodInfo(arg_4_1.RetData.GodInfo, true)
	g_CombatSystem.combatData:setBalanceAwards(arg_4_1.RetData, arg_4_1.RetData.Result, arg_4_1.RetData.AwardList)
	g_Self:updateBaseInfo(arg_4_1.RetData.BaseInfo)

	g_GameData.TeamHire = arg_4_1.RetData.TeamHire

	g_GameEventMgr:sendEvent(zbGameEvent.Event_LevelBattleResultSyn_Ack)
	g_Self.kRedPointHandler:refreshGameLevel()
end

local var_0_0 = 0
local var_0_1 = 0

function zbWsMsgHandler.WS_GameLevel_SaoDang_Req(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = {
		ForceId = arg_5_1,
		LevelId = arg_5_2,
		LevelType = arg_5_3,
		Count = arg_5_4
	}

	g_WsMsgHandler:wsPackMsg(var_5_0, MSG_ID.WS_GameLevel_SaoDang_Req)

	var_0_0 = g_GameData.BaseInfo.Level
	var_0_1 = g_GameData.BaseInfo.Exp
end

function zbWsMsgHandler.WS_GameLevel_SaoDang_Ack(arg_6_0, arg_6_1)
	echoInfo("WS_GameLevel_SaoDang_Ack")

	if g_MainScene.wndLevel ~= nil then
		g_MainScene.wndLevel:hide()
	end

	g_Self.kDataChange:update(arg_6_1)
	g_Self.kWarPathHandler:updateForceDetail(arg_6_1.RetData.ForceId, arg_6_1.RetData.ForceDetail)
	g_Self:updateBaseInfo(arg_6_1.RetData.BaseInfo)
	g_MainScene:showLevelSweep(arg_6_1.RetData)
end

function zbWsMsgHandler.WS_GameLevel_Reset_Req(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = {
		ForceId = arg_7_1,
		LevelId = arg_7_2,
		LevelType = arg_7_3
	}

	g_WsMsgHandler:wsPackMsg(var_7_0, MSG_ID.WS_GameLevel_Reset_Req)
end

function zbWsMsgHandler.WS_GameLevel_Reset_Ack(arg_8_0, arg_8_1)
	echoInfo("WS_GameLevel_Reset_Ack")
	g_Self.kDataChange:update(arg_8_1)
	g_Self.kWarPathHandler:updateForceDetail(arg_8_1.RetData.ForceId, arg_8_1.RetData.ForceDetail)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_ResetEliteLevel_Ack)
end

function zbWsMsgHandler.WS_GameLevel_StarAward_Req(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = {
		ForceId = arg_9_1,
		LevelType = arg_9_2,
		StarCount = arg_9_3
	}

	g_WsMsgHandler:wsPackMsg(var_9_0, MSG_ID.WS_GameLevel_StarAward_Req)
end

function zbWsMsgHandler.WS_GameLevel_StarAward_Ack(arg_10_0, arg_10_1)
	echoInfo("WS_GameLevel_StarAward_Ack")
	g_Self.kDataChange:update(arg_10_1)
	g_Self.kWarPathHandler:updateForceDetail(arg_10_1.RetData.ForceId, arg_10_1.RetData.ForceDetail)
	g_Self:updateBaseInfo(arg_10_1.RetData.BaseInfo)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_ForceStarAward_Ack)
	g_Self.kRedPointHandler:refreshGameLevel()
end

function zbWsMsgHandler.WS_Barrage_Send_Req(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1

	g_GameData.lastBarrage = var_11_0

	g_WsMsgHandler:wsPackMsg(var_11_0, MSG_ID.WS_Barrage_Send_Req)
	zbGlobalUtil:GameCallSDKFunction("hideNavigation", "", "")
end

function zbWsMsgHandler.WS_Barrage_Send_Ack(arg_12_0, arg_12_1)
	echoInfo("WS_Barrage_Send_Ack")
	g_GameEventMgr:sendEvent(zbGameEvent.Event_Barrage_Send_Ack)
end

function zbWsMsgHandler.WS_Barrage_Pull_Req(arg_13_0, arg_13_1)
	g_WsMsgHandler.sendMsgNeedCircle = false

	local var_13_0 = arg_13_1

	g_WsMsgHandler:wsPackMsg(var_13_0, MSG_ID.WS_Barrage_Pull_Req)

	g_WsMsgHandler.sendMsgNeedCircle = true
end

function zbWsMsgHandler.WS_Barrage_Pull_Ack(arg_14_0, arg_14_1)
	echoInfo("WS_Barrage_Pull_Ack")

	g_GameData.BarrageList = arg_14_1.RetData.BarrageList

	g_GameEventMgr:sendEvent(zbGameEvent.Event_Barrage_Pull_Ack)
end

function zbWsMsgHandler.WS_Treasure_Start_Req(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = {
		ForceId = arg_15_1,
		LevelType = arg_15_2
	}

	g_WsMsgHandler:wsPackMsg(var_15_0, MSG_ID.WS_Treasure_Start_Req)
end

function zbWsMsgHandler.WS_Treasure_Start_Ack(arg_16_0, arg_16_1)
	echoInfo("WS_Treasure_Start_Ack")
	g_Self.kDataChange:update(arg_16_1)
	g_Self.kWealthHandler:updateWealth(arg_16_1.RetData.Wealth)

	g_GameData.TreasureInfo = arg_16_1.RetData.TreasureInfo
	g_Self.kTreaSureHandler.treaSurewardList = arg_16_1.RetData.AwardList

	g_GameEventMgr:sendEvent(zbGameEvent.Event_TreaSure_Ack)
end

function zbWsMsgHandler.WS_Treasure_FastStart_Req(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = {
		ForceId = arg_17_1,
		LevelType = arg_17_2
	}

	g_WsMsgHandler:wsPackMsg(var_17_0, MSG_ID.WS_Treasure_FastStart_Req)
end

function zbWsMsgHandler.WS_Treasure_FastStart_Ack(arg_18_0, arg_18_1)
	echoInfo("WS_Treasure_FastStart_Ack")
	g_Self.kDataChange:update(arg_18_1)
	g_Self.kWealthHandler:updateWealth(arg_18_1.RetData.Wealth)

	g_GameData.TreasureInfo = arg_18_1.RetData.TreasureInfo
	g_Self.kTreaSureHandler.treaSurewardList = arg_18_1.RetData.AwardList

	g_GameEventMgr:sendEvent(zbGameEvent.Event_TreaSure_Ack)
end

function zbWsMsgHandler.WS_Treasure_GetBoxAward_Req(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = {
		ForceId = arg_19_1,
		LevelType = arg_19_2,
		BoxIndex = arg_19_3
	}

	g_WsMsgHandler:wsPackMsg(var_19_0, MSG_ID.WS_Treasure_GetBoxAward_Req)
end

function zbWsMsgHandler.WS_Treasure_GetBoxAward_Ack(arg_20_0, arg_20_1)
	echoInfo("WS_Treasure_GetBoxAward_Ack")
	g_Self.kDataChange:update(arg_20_1)
	g_Self.kWealthHandler:updateWealth(arg_20_1.RetData.Wealth)

	g_GameData.TreasureInfo = arg_20_1.RetData.TreasureInfo
	g_Self.kTreaSureHandler.treaSurewardList = arg_20_1.RetData.AwardList

	g_GameEventMgr:sendEvent(zbGameEvent.Event_TreaSureGetBoxAward_Ack)
end

function zbWsMsgHandler.WS_Treasure_GetInfo_Req(arg_21_0)
	local var_21_0 = {}

	g_WsMsgHandler:wsPackMsg(var_21_0, MSG_ID.WS_Treasure_GetInfo_Req)
end

function zbWsMsgHandler.WS_Treasure_GetInfo_Ack(arg_22_0, arg_22_1)
	echoInfo("WS_Treasure_GetInfo_Ack")

	g_GameData.TreasureInfo = arg_22_1.RetData.TreasureInfo
end

function zbWsMsgHandler.WS_GameLevel_GetData_Req(arg_23_0)
	local var_23_0 = {}

	g_WsMsgHandler:wsPackMsg(var_23_0, MSG_ID.WS_GameLevel_GetData_Req)
end

function zbWsMsgHandler.WS_GameLevel_GetData_Ack(arg_24_0, arg_24_1)
	echoInfo("WS_GameLevel_GetData_Ack")

	g_GameData.ForceSection = arg_24_1.RetData.ForceSection
end
