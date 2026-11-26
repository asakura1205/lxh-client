function zbWsMsgHandler.WS_Common_HeartBeat_Req(arg_1_0)
	local var_1_0 = {}

	g_WsMsgHandler.sendMsgNeedCircle = false

	g_WsMsgHandler:wsPackMsg(var_1_0, MSG_ID.WS_Common_HeartBeat_Req)

	g_WsMsgHandler.sendMsgNeedCircle = true
end

function zbWsMsgHandler.WS_Common_HeartBeat_Ack(arg_2_0, arg_2_1)
	echoInfo("WS_Common_HeartBeat_Ack")
	g_Self.kChatHandler:setCdInfo(arg_2_1.RetData.CDInfo)
	g_Self.kWealthHandler:updateWealth(arg_2_1.RetData.Wealth)
end

function zbWsMsgHandler.WS_Player_BaseFormation_Req(arg_3_0, arg_3_1)
	local var_3_0 = {
		PlayerId = arg_3_1
	}

	g_WsMsgHandler:wsPackMsg(var_3_0, MSG_ID.WS_Player_BaseFormation_Req)
end

function zbWsMsgHandler.WS_Player_BaseFormation_Ack(arg_4_0, arg_4_1)
	echoInfo("WS_Player_BaseFormation_Ack")
	g_MainScene:showRankTipArenaWnd(arg_4_1.RetData)
end

function zbWsMsgHandler.WS_Player_Formation_Req(arg_5_0, arg_5_1)
	local var_5_0 = {
		PlayerId = arg_5_1
	}

	g_WsMsgHandler:wsPackMsg(var_5_0, MSG_ID.WS_Player_Formation_Req)
end

function zbWsMsgHandler.WS_Player_Formation_Ack(arg_6_0, arg_6_1)
	echoInfo("WS_Player_Formation_Ack")

	PlayerFormationInfo = arg_6_1.RetData

	if g_Self.kFriendHandler.bfriendBaseFormationInfoReq then
		g_Self.kFriendHandler.bfriendBaseFormationInfoReq = false

		g_GameEventMgr:sendEvent(zbGameEvent.Event_FriendBaseFormationAck)
	elseif g_Self.kLegionHandler.bLegionMemBaseFormationInfoReq then
		g_Self.kLegionHandler.bLegionMemBaseFormationInfoReq = false

		g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionMemBaseFormationAck)
	elseif g_Self.kWorldHandler.bworldHorseBaseFormationInfoReq then
		g_Self.kWorldHandler.bworldHorseBaseFormationInfoReq = false

		g_GameEventMgr:sendEvent(zbGameEvent.Event_WorldHorseBaseFormationAck)
	elseif g_Self.kChatHandler.bChatBaseFormationInfoReq then
		g_Self.kChatHandler.bChatBaseFormationInfoReq = false

		g_GameEventMgr:sendEvent(zbGameEvent.Event_ChatBaseFormationAck)
	end
end

function zbWsMsgHandler.WS_Player_GameInfo_Req(arg_7_0, arg_7_1)
	local var_7_0 = {
		PlayerId = arg_7_1
	}

	g_WsMsgHandler:wsPackMsg(var_7_0, MSG_ID.WS_Player_GameInfo_Req)
end

function zbWsMsgHandler.WS_Player_GameInfo_Ack(arg_8_0, arg_8_1)
	echoInfo("WS_Player_GameInfo_Ack")
end

function zbWsMsgHandler.WS_Common_DiamondExchange_Req(arg_9_0, arg_9_1)
	local var_9_0 = {
		ExchangeType = arg_9_1
	}

	g_WsMsgHandler:wsPackMsg(var_9_0, MSG_ID.WS_Common_DiamondExchange_Req)
end

function zbWsMsgHandler.WS_Common_DiamondExchange_Ack(arg_10_0, arg_10_1)
	echoInfo("WS_Common_DiamondExchange_Ack")

	g_GameData.ExchangeInfo = arg_10_1.RetData.ExchangeInfo

	g_Self.kDataChange:update(arg_10_1)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_GoldTouch_Ack)
end

function zbWsMsgHandler.WS_SyncData_Ntf(arg_11_0, arg_11_1)
	echoInfo("WS_SyncData_Ntf")

	g_WsMsgHandler.sendMsgNeedCircle = false

	if arg_11_1.SyncId == MSG_ID.WS_SyncData_GameInfo_Req then
		g_WsMsgHandler:WS_SyncData_GameInfo_Req()
	elseif arg_11_1.SyncId == MSG_ID.WS_SyncData_UpgradeInfo_Req then
		g_WsMsgHandler:WS_SyncData_UpgradeInfo_Req()
	elseif arg_11_1.SyncId == MSG_ID.WS_Arena_GetData_Req then
		g_WsMsgHandler:WS_Arena_GetData_Req()
	elseif arg_11_1.SyncId == MSG_ID.WS_Arena_RecordList_Req then
		g_WsMsgHandler:WS_Arena_RecordList_Req()
	elseif arg_11_1.SyncId == MSG_ID.WS_SyncData_Formation_Req then
		g_WsMsgHandler:WS_SyncData_Formation_Req()
	elseif arg_11_1.SyncId == MSG_ID.WS_SyncData_HeroList_Req then
		g_WsMsgHandler:WS_SyncData_HeroList_Req()
	elseif arg_11_1.SyncId == MSG_ID.WS_MainTask_GetData_Req then
		g_WsMsgHandler:WS_MainTask_GetData_Req()
	elseif arg_11_1.SyncId == MSG_ID.WS_DailyTask_GetData_Req then
		g_WsMsgHandler:WS_DailyTask_GetData_Req()
	elseif arg_11_1.SyncId == MSG_ID.WS_Mail_GetList_Req then
		g_WsMsgHandler:WS_Mail_GetList_Req()
	elseif arg_11_1.SyncId == MSG_ID.WS_Friends_GetData_Req then
		g_Self.kFriendHandler.bfriendNotify = true

		g_WsMsgHandler:WS_Friends_GetData_Req()
	elseif arg_11_1.SyncId == MSG_ID.WS_Legion_GetSelfInfo_Req then
		g_WsMsgHandler:WS_Legion_GetSelfInfo_Req()
	elseif arg_11_1.SyncId == MSG_ID.WS_Legion_GetApply_Req then
		g_WsMsgHandler:WS_Legion_GetApply_Req()
	elseif arg_11_1.SyncId == MSG_ID.WS_Legion_GetData_Req then
		g_WsMsgHandler:WS_Legion_GetData_Req()
	elseif arg_11_1.SyncId == MSG_ID.WS_LegionGame_GetDinner_Req then
		g_WsMsgHandler:WS_LegionGame_GetDinner_Req()
	elseif arg_11_1.SyncId == MSG_ID.WS_WorldRes_GetInfo_Req then
		g_WsMsgHandler:WS_WorldRes_GetInfo_Req()
	elseif arg_11_1.SyncId == MSG_ID.WS_World_GetLog_Req then
		-- block empty
	elseif arg_11_1.SyncId == MSG_ID.WS_ActivityOs_GetData_Req then
		g_WsMsgHandler:WS_ActivityOs_GetData_Req()
	elseif arg_11_1.SyncId == MSG_ID.WS_ActivityGm_GetData_Req then
		g_WsMsgHandler:WS_ActivityGm_GetData_Req()
	elseif arg_11_1.SyncId == MSG_ID.WS_Vip_SuccessOrder_Req then
		g_WsMsgHandler:WS_Vip_SuccessOrder_Req()
	elseif arg_11_1.SyncId == MSG_ID.WS_LegionGame_GetBless_Req then
		g_WsMsgHandler:WS_LegionGame_GetBless_Req()
	elseif arg_11_1.SyncId == MSG_ID.WS_LegionBoss_GetInfo_Req then
		g_WsMsgHandler:WS_LegionBoss_GetInfo_Req()
	elseif arg_11_1.SyncId == MSG_ID.WS_WorldBoss_GetInfo_Req then
		g_WsMsgHandler:WS_WorldBoss_GetInfo_Req()
	elseif arg_11_1.SyncId == MSG_ID.WS_Treasure_GetInfo_Req then
		g_WsMsgHandler:WS_Treasure_GetInfo_Req()
	elseif arg_11_1.SyncId == MSG_ID.WS_World_GetInfo_Req then
		g_WsMsgHandler:WS_World_GetInfo_Req()
	elseif arg_11_1.SyncId == MSG_ID.WS_LegionGame_GetHongbao_Req then
		g_WsMsgHandler:WS_LegionGame_GetHongbao_Req()
	elseif arg_11_1.SyncId == MSG_ID.WS_GameLevel_GetData_Req then
		g_WsMsgHandler:WS_GameLevel_GetData_Req()
	elseif arg_11_1.SyncId == MSG_ID.WS_Shop_GetShopItems_Req then
		g_WsMsgHandler:WS_Shop_GetShopItems_Req()
	elseif arg_11_1.SyncId == MSG_ID.WS_Tech_GetData_Req then
		g_WsMsgHandler:WS_Tech_GetData_Req()
	elseif arg_11_1.SyncId == MSG_ID.WS_Pata_GetInfo_Req then
		g_WsMsgHandler:WS_Pata_GetInfo_Req()
	end

	g_WsMsgHandler.sendMsgNeedCircle = true
end

function zbWsMsgHandler.WS_SyncData_GameInfo_Req(arg_12_0)
	local var_12_0 = {}

	g_WsMsgHandler:wsPackMsg(var_12_0, MSG_ID.WS_SyncData_GameInfo_Req)
end

function zbWsMsgHandler.WS_SyncData_GameInfo_Ack(arg_13_0, arg_13_1)
	echoInfo("WS_SyncData_GameInfo_Ack")
	g_Self.kPataHandler:updatePataInfo(arg_13_1.RetData.PataInfo)
	g_Self:updateGameEnvInfo(arg_13_1.RetData.GameEnvInfo)
	g_Self.kWealthHandler:updateWealth(arg_13_1.RetData.Wealth)
	g_Self.kDailyHandler:updateDailyTask(arg_13_1.RetData.DailyTask)
	g_Self.kHeroTrialHandler:updateAllTrialInfo(arg_13_1.RetData.TrialInfo)
	g_Self.kPubHandler:updateBarInfoAwardList(arg_13_1.RetData.BarInfo)
	g_Self.kYuanzhengHandler:updateYuanzhengInfo(arg_13_1.RetData.BgzInfo)

	g_GameData.SelfArenaInfo = arg_13_1.RetData.SelfArenaInfo
	g_GameData.CDInfo = arg_13_1.RetData.CDInfo
	g_GameData.DailyRefresh = arg_13_1.RetData.DailyRefresh
	g_GameData.LegionInfo = arg_13_1.RetData.LegionInfo
	g_GameData.ActivityAct = arg_13_1.RetData.ActivityAct

	g_Self.kRedPointHandler:refreshAll()
end

function zbWsMsgHandler.WS_SyncData_UpgradeInfo_Req(arg_14_0)
	local var_14_0 = {}

	g_WsMsgHandler:wsPackMsg(var_14_0, MSG_ID.WS_SyncData_UpgradeInfo_Req)
end

function zbWsMsgHandler.WS_SyncData_UpgradeInfo_Ack(arg_15_0, arg_15_1)
	echoInfo("WS_SyncData_UpgradeInfo_Ack")
	g_Self.kWealthHandler:updateWealth(arg_15_1.RetData.Wealth)
	g_Self:updateBaseInfo(arg_15_1.RetData.BaseInfo)
	g_Self:updateCapacityInfo(arg_15_1.RetData.CapacityInfo)
end
