function zbWsMsgHandler.WS_Friends_GetData_Req(arg_1_0)
	local var_1_0 = {}

	g_WsMsgHandler:wsPackMsg(var_1_0, MSG_ID.WS_Friends_GetData_Req)
end

function zbWsMsgHandler.WS_Friends_GetData_Ack(arg_2_0, arg_2_1)
	echo("WS_Friends_GetData_Ack")

	if arg_2_1.RetData then
		g_Self.kFriendHandler:updateFriendinfo(arg_2_1.RetData)
	end

	g_GameEventMgr:sendEvent(zbGameEvent.Event_TeamForce)
end

function zbWsMsgHandler.WS_Friends_Apply_Req(arg_3_0, arg_3_1)
	if g_Self.kFriendHandler:getFriendInfoById(arg_3_1) == nil then
		local var_3_0 = {
			PlayerId = arg_3_1
		}

		g_WsMsgHandler:wsPackMsg(var_3_0, MSG_ID.WS_Friends_Apply_Req)
	else
		g_Bubble:bubbleInfo(a2u("\xD2Ѿ\xAD\xCAǺ\xC3\xD3\xD1"))
	end
end

function zbWsMsgHandler.WS_Friends_Apply_Ack(arg_4_0, arg_4_1)
	g_Bubble:bubbleInfo(a2u("\xC9\xEA\xC7\xEB\xB3ɹ\xA6"))
end

function zbWsMsgHandler.WS_Friends_ApplyPass_Req(arg_5_0, arg_5_1)
	local var_5_0 = {
		PlayerId = arg_5_1
	}

	g_WsMsgHandler:wsPackMsg(var_5_0, MSG_ID.WS_Friends_ApplyPass_Req)
end

function zbWsMsgHandler.WS_Friends_ApplyPass_Ack(arg_6_0, arg_6_1)
	g_Self.kFriendHandler:passFriendApply(arg_6_1.RetData)
end

function zbWsMsgHandler.WS_Friends_ApplyRefuse_Req(arg_7_0, arg_7_1)
	local var_7_0 = {
		PlayerId = arg_7_1
	}

	g_WsMsgHandler:wsPackMsg(var_7_0, MSG_ID.WS_Friends_ApplyRefuse_Req)
end

function zbWsMsgHandler.WS_Friends_ApplyRefuse_Ack(arg_8_0, arg_8_1)
	g_Self.kFriendHandler:delFriendsApplyListById(arg_8_1.RetData)
end

function zbWsMsgHandler.WS_Friends_ApplyRefuseAll_Req(arg_9_0)
	local var_9_0 = {}

	g_WsMsgHandler:wsPackMsg(var_9_0, MSG_ID.WS_Friends_ApplyRefuseAll_Req)
end

function zbWsMsgHandler.WS_Friends_ApplyRefuseAll_Ack(arg_10_0, arg_10_1)
	g_Self.kFriendHandler:clearFriendsApplyList()
end

function zbWsMsgHandler.WS_Friends_Delete_Req(arg_11_0, arg_11_1)
	local var_11_0 = {
		PlayerId = arg_11_1
	}

	g_WsMsgHandler:wsPackMsg(var_11_0, MSG_ID.WS_Friends_Delete_Req)
end

function zbWsMsgHandler.WS_Friends_Delete_Ack(arg_12_0, arg_12_1)
	g_Self.kFriendHandler:updateFriendsBaseInfo(arg_12_1.RetData.FriendsBaseInfo)
	g_Self.kFriendHandler:delFriendsById(arg_12_1.RetData.PlayerId)
end

function zbWsMsgHandler.WS_Friends_Action_Req(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = {
		PlayerId = arg_13_1,
		ActionType = arg_13_2
	}

	g_WsMsgHandler:wsPackMsg(var_13_0, MSG_ID.WS_Friends_Action_Req)
end

function zbWsMsgHandler.WS_Friends_Action_Ack(arg_14_0, arg_14_1)
	g_Self.kDataChange:update(arg_14_1)
	g_Self.kFriendHandler:updateFriendsData(arg_14_1.RetData.FriendsDetail)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_UpdateFriendsActionAck)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_UpdateFriendsAck)
	g_MainScene:showFriendBubble(arg_14_1.RetData.FriendsDetail)
end

function zbWsMsgHandler.WS_Friends_Search_Req(arg_15_0, arg_15_1)
	local var_15_0 = {
		RoleName = arg_15_1
	}

	g_WsMsgHandler:wsPackMsg(var_15_0, MSG_ID.WS_Friends_Search_Req)
end

function zbWsMsgHandler.WS_Friends_Search_Ack(arg_16_0, arg_16_1)
	FriendsSearchAckData = arg_16_1.RetData

	if FriendsSearchAckData.SearchList == nil or table.getn(FriendsSearchAckData.SearchList) <= 0 then
		g_Bubble:bubbleInfo(a2u("û\xD3д\xCB\xCD\xE6\xBC\xD2"))
	end

	g_GameEventMgr:sendEvent(zbGameEvent.Event_FriendSearchAck)
end

function zbWsMsgHandler.WS_Friends_Recommend_Req(arg_17_0)
	local var_17_0 = {}

	g_WsMsgHandler:wsPackMsg(var_17_0, MSG_ID.WS_Friends_Recommend_Req)
end

function zbWsMsgHandler.WS_Friends_Recommend_Ack(arg_18_0, arg_18_1)
	FriendsRecommendAckData = arg_18_1.RetData

	g_GameEventMgr:sendEvent(zbGameEvent.Event_FriendTuijian)
end

function zbWsMsgHandler.WS_Friends_GiveTili_Req(arg_19_0, arg_19_1)
	local var_19_0 = {
		PlayerId = arg_19_1
	}

	g_WsMsgHandler:wsPackMsg(var_19_0, MSG_ID.WS_Friends_GiveTili_Req)
end

function zbWsMsgHandler.WS_Friends_GiveTili_Ack(arg_20_0, arg_20_1)
	echo("WS_Friends_GiveTili_Ack")
	g_Bubble:bubbleInfo(a2u("\xD4\xF9\xCBͳɹ\xA6"))
	g_Self.kFriendHandler:updateFriendsData(arg_20_1.RetData.FriendsDetail)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_UpdateFriendsAck)
end

function zbWsMsgHandler.WS_Friends_GiveTiliAll_Req(arg_21_0)
	local var_21_0 = {}

	g_WsMsgHandler:wsPackMsg(var_21_0, MSG_ID.WS_Friends_GiveTiliAll_Req)
end

function zbWsMsgHandler.WS_Friends_GiveTiliAll_Ack(arg_22_0, arg_22_1)
	echo("WS_Friends_GiveTiliAll_Ack")
	g_Bubble:bubbleInfo(a2u("\xD4\xF9\xCBͳɹ\xA6"))
	g_Self.kFriendHandler:updateFriendList(arg_22_1.RetData.FriendsList)
end

function zbWsMsgHandler.WS_Friends_GetTili_Req(arg_23_0, arg_23_1)
	local var_23_0 = {
		PlayerId = arg_23_1
	}

	g_WsMsgHandler:wsPackMsg(var_23_0, MSG_ID.WS_Friends_GetTili_Req)
end

function zbWsMsgHandler.WS_Friends_GetTili_Ack(arg_24_0, arg_24_1)
	echo("WS_Friends_GetTili_Ack")
	g_Bubble:bubbleInfo(a2u("\xC1\xECȡ\xB3ɹ\xA6"))
	g_Self.kDataChange:update(arg_24_1)
	g_Self.kFriendHandler:updateFriendsBaseInfo(arg_24_1.RetData.FriendsBaseInfo)
	g_Self.kFriendHandler:updateFriendsData(arg_24_1.RetData.FriendsDetail)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_UpdateFriendsAck)
end

function zbWsMsgHandler.WS_Friends_GetTiliAll_Req(arg_25_0)
	local var_25_0 = {}

	g_WsMsgHandler:wsPackMsg(var_25_0, MSG_ID.WS_Friends_GetTiliAll_Req)
end

function zbWsMsgHandler.WS_Friends_GetTiliAll_Ack(arg_26_0, arg_26_1)
	echo("WS_Friends_GetTiliAll_Ack")
	g_Bubble:bubbleInfo(a2u("\xC1\xECȡ\xB3ɹ\xA6"))
	g_Self.kDataChange:update(arg_26_1)
	g_Self.kFriendHandler:updateFriendsBaseInfo(arg_26_1.RetData.FriendsBaseInfo)
	g_Self.kFriendHandler:updateFriendList(arg_26_1.RetData.FriendsList)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_UpdateFriendsAck)
end

function zbWsMsgHandler.WS_Friends_FightStart_Req(arg_27_0, arg_27_1)
	local var_27_0 = {
		PlayerId = arg_27_1
	}

	g_WsMsgHandler:wsPackMsg(var_27_0, MSG_ID.WS_Friends_FightStart_Req)
end

function zbWsMsgHandler.WS_Friends_FightStart_Ack(arg_28_0, arg_28_1)
	echoInfo("WS_Friends_FightStart_Ack")

	if g_CombatSystem:isFighting() then
		return
	end

	if arg_28_1.RetData.BattleInfo and zbUtil:fightReqAckSign(arg_28_1.RetData.BattleInfo) ~= arg_28_1.RetData.BattleInfo.Sign then
		g_Bubble:bubbleInfo(a2u("ս\xB6\xB7\xCA\xFD\xBE\xDDУ\xD1\xE9ʧ\xB0\xDC"))

		return
	end

	g_CombatSystem:startFriendBattle(arg_28_1.RetData)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_FriendFight_Ack)
end

function zbWsMsgHandler.WS_Friends_FightResult_Req(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = {
		PlayerId = arg_29_1,
		RandomSeed = arg_29_2,
		Result = arg_29_3,
		Energy = g_CombatSystem:getLegendEnergy()
	}

	var_29_0.Sign = zbUtil:fightResultReqSign(var_29_0)

	g_WsMsgHandler:wsPackMsg(var_29_0, MSG_ID.WS_Friends_FightResult_Req)
end

function zbWsMsgHandler.WS_Friends_FightResult_Ack(arg_30_0, arg_30_1)
	echoInfo("WS_Friends_FightResult_Ack")
	g_Self.kDataChange:update(arg_30_1)
	g_CombatSystem.combatData:setBalanceAwards(arg_30_1.RetData, arg_30_1.RetData.Result, arg_30_1.RetData.AwardList)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_FriendFightResultSyn_Ack)
end

function zbWsMsgHandler.WS_FriendsBoss_FightStart_Req(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = {
		BossRoleId = arg_31_1,
		LevelIndex = arg_31_2
	}

	g_WsMsgHandler:wsPackMsg(var_31_0, MSG_ID.WS_FriendsBoss_FightStart_Req)
end

function zbWsMsgHandler.WS_FriendsBoss_FightStart_Ack(arg_32_0, arg_32_1)
	echoInfo("WS_FriendsBoss_FightStart_Ack")

	if g_CombatSystem:isFighting() then
		return
	end

	if arg_32_1.RetData.BattleInfo and zbUtil:fightReqAckSign(arg_32_1.RetData.BattleInfo) ~= arg_32_1.RetData.BattleInfo.Sign then
		g_Bubble:bubbleInfo(a2u("ս\xB6\xB7\xCA\xFD\xBE\xDDУ\xD1\xE9ʧ\xB0\xDC"))

		return
	end

	g_CombatSystem:startFriendBossBattle(arg_32_1.RetData)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_FriendFight_Ack)
end

function zbWsMsgHandler.WS_FriendsBoss_FightResult_Req(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	local var_33_0 = {
		HpPercent = arg_33_1,
		HurtHp = arg_33_2,
		BossRoleId = arg_33_3,
		LevelIndex = arg_33_4
	}

	var_33_0.Sign = zbUtil:fightResultReqSign(var_33_0)
	g_Self.kFriendHandler.hitStat = arg_33_2

	g_WsMsgHandler:wsPackMsg(var_33_0, MSG_ID.WS_FriendsBoss_FightResult_Req)
end

function zbWsMsgHandler.WS_FriendsBoss_FightResult_Ack(arg_34_0, arg_34_1)
	echoInfo("WS_FriendsBoss_FightResult_Ack")

	g_Self.kFriendHandler.curBossInfo = arg_34_1.RetData.BossInfo

	g_CombatSystem.combatData:setBalanceAwards(arg_34_1.RetData, arg_34_1.RetData.Result, arg_34_1.RetData.AwardList)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_FriendBossFightResultSyn_Ack)
end

function zbWsMsgHandler.WS_FriendsBoss_GetInfo_Req(arg_35_0, arg_35_1)
	local var_35_0 = {}

	g_Self.kFriendHandler.openFriendBoss = arg_35_1

	g_WsMsgHandler:wsPackMsg(var_35_0, MSG_ID.WS_FriendsBoss_GetInfo_Req)
end

function zbWsMsgHandler.WS_FriendsBoss_GetInfo_Ack(arg_36_0, arg_36_1)
	echoInfo("WS_FriendsBoss_GetInfo_Ack")
	g_Self.kFriendHandler:updateFriendBossinfo(arg_36_1.RetData)

	if g_Self.kFriendHandler.openFriendBoss == true then
		g_MainScene:showFriendBossListWnd()
	end

	g_Self.kFriendHandler.openFriendBoss = false
end

function zbWsMsgHandler.WS_FriendsBoss_GetBossInfo_Req(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	return
end

function zbWsMsgHandler.WS_FriendsBoss_GetBossInfo_Ack(arg_38_0, arg_38_1)
	echoInfo("WS_FriendsBoss_GetBossInfo_Ack")

	g_Self.kFriendHandler.newBossInfo = arg_38_1.RetData.BossInfo

	g_Self.kFriendHandler:addFriendBossinfo(arg_38_1.RetData)

	g_Self.kFriendHandler.haveNewFriendBoss = true
end
