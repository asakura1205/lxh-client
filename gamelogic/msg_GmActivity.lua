function zbWsMsgHandler.WS_ActivityGm_GetData_Req(arg_1_0)
	local var_1_0 = {}

	g_WsMsgHandler:wsPackMsg(var_1_0, MSG_ID.WS_ActivityGm_GetData_Req)
end

function zbWsMsgHandler.WS_ActivityGm_GetData_Ack(arg_2_0, arg_2_1)
	echoInfo("WS_ActivityGm_GetData_Ack")

	g_GameData.ActivityGm = arg_2_1.RetData

	g_GameEventMgr:sendEvent(zbGameEvent.Event_GmActivity_Ack)
end

function zbWsMsgHandler.WS_ActivityGm_DailyActive_Req(arg_3_0, arg_3_1)
	local var_3_0 = {
		ActId = arg_3_1
	}

	g_WsMsgHandler:wsPackMsg(var_3_0, MSG_ID.WS_ActivityGm_DailyActive_Req)
end

function zbWsMsgHandler.WS_ActivityGm_DailyActive_Ack(arg_4_0, arg_4_1)
	echoInfo("WS_ActivityGm_DailyActive_Ack")
	g_Self.kDataChange:update(arg_4_1)

	g_GameData.ActivityGm.DailyActive = arg_4_1.RetData.DailyActive

	g_GameEventMgr:sendEvent(zbGameEvent.Event_GmActivity_Ack)
end

function zbWsMsgHandler.WS_ActivityGm_ItemExchange_Req(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = {
		ActId = arg_5_1,
		Index = arg_5_2
	}

	g_WsMsgHandler:wsPackMsg(var_5_0, MSG_ID.WS_ActivityGm_ItemExchange_Req)
end

function zbWsMsgHandler.WS_ActivityGm_ItemExchange_Ack(arg_6_0, arg_6_1)
	echoInfo("WS_ActivityGm_ItemExchange_Ack")
	g_Self.kDataChange:update(arg_6_1)

	g_GameData.ActivityGm.ItemExchange = arg_6_1.RetData.ItemExchange

	g_GameEventMgr:sendEvent(zbGameEvent.Event_GmActivity_Ack)
end

function zbWsMsgHandler.WS_ActivityGm_LimitTimeHero_Req(arg_7_0, arg_7_1)
	local var_7_0 = {
		ActId = arg_7_1
	}

	g_WsMsgHandler:wsPackMsg(var_7_0, MSG_ID.WS_ActivityGm_LimitTimeHero_Req)
end

function zbWsMsgHandler.WS_ActivityGm_LimitTimeHero_Ack(arg_8_0, arg_8_1)
	echoInfo("WS_ActivityGm_LimitTimeHero_Ack")
	g_Self.kDataChange:update(arg_8_1)

	g_GameData.ActivityGm.LimitTimeHero = arg_8_1.RetData.LimitTimeHero

	g_GameEventMgr:sendEvent(zbGameEvent.Event_GmActivity_Ack)
end

function zbWsMsgHandler.WS_ActivityGm_LimitTimeScore_Req(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = {
		ActId = arg_9_1,
		Index = arg_9_2
	}

	g_WsMsgHandler:wsPackMsg(var_9_0, MSG_ID.WS_ActivityGm_LimitTimeScore_Req)
end

function zbWsMsgHandler.WS_ActivityGm_LimitTimeScore_Ack(arg_10_0, arg_10_1)
	echoInfo("WS_ActivityGm_LimitTimeScore_Ack")
	g_Self.kDataChange:update(arg_10_1)

	g_GameData.ActivityGm.LimitTimeHero = arg_10_1.RetData.LimitTimeHero

	g_GameEventMgr:sendEvent(zbGameEvent.Event_GmActivity_Ack)
end

function zbWsMsgHandler.WS_ActivityGm_LimitTimeShop_Req(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = {
		ActId = arg_11_1,
		Index = arg_11_2
	}

	g_WsMsgHandler:wsPackMsg(var_11_0, MSG_ID.WS_ActivityGm_LimitTimeShop_Req)
end

function zbWsMsgHandler.WS_ActivityGm_LimitTimeShop_Ack(arg_12_0, arg_12_1)
	echoInfo("WS_ActivityGm_LimitTimeShop_Ack")
	g_Self.kDataChange:update(arg_12_1)

	g_GameData.ActivityGm.LimitTimeShop = arg_12_1.RetData.LimitTimeShop

	g_GameEventMgr:sendEvent(zbGameEvent.Event_GmActivity_Ack)
end

function zbWsMsgHandler.WS_ActivityGm_FundBuy_Req(arg_13_0)
	local var_13_0 = {}

	g_WsMsgHandler:wsPackMsg(var_13_0, MSG_ID.WS_ActivityGm_FundBuy_Req)
end

function zbWsMsgHandler.WS_ActivityGm_FundBuy_Ack(arg_14_0, arg_14_1)
	echoInfo("WS_ActivityGm_FundBuy_Ack")
	g_Self.kDataChange:update(arg_14_1)

	g_GameData.ActivityGm.Fund = arg_14_1.RetData.Fund
	g_GameData.ActivityGm.FundWelfare = arg_14_1.RetData.FundWelfare

	g_GameEventMgr:sendEvent(zbGameEvent.Event_GmActivity_Ack)
end

function zbWsMsgHandler.WS_ActivityGm_FundAward_Req(arg_15_0, arg_15_1)
	local var_15_0 = {
		Level = arg_15_1
	}

	g_WsMsgHandler:wsPackMsg(var_15_0, MSG_ID.WS_ActivityGm_FundAward_Req)
end

function zbWsMsgHandler.WS_ActivityGm_FundAward_Ack(arg_16_0, arg_16_1)
	echoInfo("WS_ActivityGm_FundAward_Ack")
	g_Self.kDataChange:update(arg_16_1)

	g_GameData.ActivityGm.Fund = arg_16_1.RetData.Fund

	g_GameEventMgr:sendEvent(zbGameEvent.Event_GmActivity_Ack)
end

function zbWsMsgHandler.WS_ActivityGm_FundWelfare_Req(arg_17_0, arg_17_1)
	local var_17_0 = {
		Count = arg_17_1
	}

	g_WsMsgHandler:wsPackMsg(var_17_0, MSG_ID.WS_ActivityGm_FundWelfare_Req)
end

function zbWsMsgHandler.WS_ActivityGm_FundWelfare_Ack(arg_18_0, arg_18_1)
	echoInfo("WS_ActivityGm_FundWelfare_Ack")
	g_Self.kDataChange:update(arg_18_1)

	g_GameData.ActivityGm.FundWelfare = arg_18_1.RetData.FundWelfare

	g_GameEventMgr:sendEvent(zbGameEvent.Event_GmActivity_Ack)
end

function zbWsMsgHandler.WS_ActivityGm_RechargeDaily_Req(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = {
		ActId = arg_19_1,
		Day = arg_19_2
	}

	g_WsMsgHandler:wsPackMsg(var_19_0, MSG_ID.WS_ActivityGm_RechargeDaily_Req)
end

function zbWsMsgHandler.WS_ActivityGm_RechargeDaily_Ack(arg_20_0, arg_20_1)
	echoInfo("WS_ActivityGm_RechargeDaily_Ack")
	g_Self.kDataChange:update(arg_20_1)

	g_GameData.ActivityGm.RechargeDaily = arg_20_1.RetData.RechargeDaily

	g_GameEventMgr:sendEvent(zbGameEvent.Event_GmActivity_Ack)
end

function zbWsMsgHandler.WS_ActivityGm_RechargeDailySum_Req(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = {
		ActId = arg_21_1,
		Diamond = arg_21_2
	}

	g_WsMsgHandler:wsPackMsg(var_21_0, MSG_ID.WS_ActivityGm_RechargeDailySum_Req)
end

function zbWsMsgHandler.WS_ActivityGm_RechargeDailySum_Ack(arg_22_0, arg_22_1)
	echoInfo("WS_ActivityGm_RechargeDailySum_Ack")
	g_Self.kDataChange:update(arg_22_1)

	g_GameData.ActivityGm.RechargeDailySum = arg_22_1.RetData.RechargeDailySum

	g_GameEventMgr:sendEvent(zbGameEvent.Event_GmActivity_Ack)
end

function zbWsMsgHandler.WS_ActivityGm_RechargeDailySingle_Req(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = {
		ActId = arg_23_1,
		Diamond = arg_23_2
	}

	g_WsMsgHandler:wsPackMsg(var_23_0, MSG_ID.WS_ActivityGm_RechargeDailySingle_Req)
end

function zbWsMsgHandler.WS_ActivityGm_RechargeDailySingle_Ack(arg_24_0, arg_24_1)
	echoInfo("WS_ActivityGm_RechargeDailySingle_Ack")
	g_Self.kDataChange:update(arg_24_1)

	g_GameData.ActivityGm.RechargeDailySingle = arg_24_1.RetData.RechargeDailySingle

	g_GameEventMgr:sendEvent(zbGameEvent.Event_GmActivity_Ack)
end

function zbWsMsgHandler.WS_ActivityGm_RechargeSingle_Req(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = {
		ActId = arg_25_1,
		Diamond = arg_25_2
	}

	g_WsMsgHandler:wsPackMsg(var_25_0, MSG_ID.WS_ActivityGm_RechargeSingle_Req)
end

function zbWsMsgHandler.WS_ActivityGm_RechargeSingle_Ack(arg_26_0, arg_26_1)
	echoInfo("WS_ActivityGm_RechargeSingle_Ack")
	g_Self.kDataChange:update(arg_26_1)

	g_GameData.ActivityGm.RechargeSingle = arg_26_1.RetData.RechargeSingle

	g_GameEventMgr:sendEvent(zbGameEvent.Event_GmActivity_Ack)
end

function zbWsMsgHandler.WS_ActivityGm_RechargeSum_Req(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = {
		ActId = arg_27_1,
		Diamond = arg_27_2
	}

	g_WsMsgHandler:wsPackMsg(var_27_0, MSG_ID.WS_ActivityGm_RechargeSum_Req)
end

function zbWsMsgHandler.WS_ActivityGm_RechargeSum_Ack(arg_28_0, arg_28_1)
	echoInfo("WS_ActivityGm_RechargeSum_Ack")
	g_Self.kDataChange:update(arg_28_1)

	g_GameData.ActivityGm.RechargeSum = arg_28_1.RetData.RechargeSum

	g_GameEventMgr:sendEvent(zbGameEvent.Event_GmActivity_Ack)
end

function zbWsMsgHandler.WS_ActivityGm_ConsumSum_Req(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = {
		ActId = arg_29_1,
		Diamond = arg_29_2
	}

	g_WsMsgHandler:wsPackMsg(var_29_0, MSG_ID.WS_ActivityGm_ConsumSum_Req)
end

function zbWsMsgHandler.WS_ActivityGm_ConsumSum_Ack(arg_30_0, arg_30_1)
	echoInfo("WS_ActivityGm_ConsumSum_Ack")
	g_Self.kDataChange:update(arg_30_1)

	g_GameData.ActivityGm.ConsumSum = arg_30_1.RetData.ConsumSum

	g_GameEventMgr:sendEvent(zbGameEvent.Event_GmActivity_Ack)
end

function zbWsMsgHandler.WS_ActivityGm_ConsumDailySum_Req(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = {
		ActId = arg_31_1,
		Diamond = arg_31_2
	}

	g_WsMsgHandler:wsPackMsg(var_31_0, MSG_ID.WS_ActivityGm_ConsumDailySum_Req)
end

function zbWsMsgHandler.WS_ActivityGm_ConsumDailySum_Ack(arg_32_0, arg_32_1)
	echoInfo("WS_ActivityGm_ConsumDailySum_Ack")
	g_Self.kDataChange:update(arg_32_1)

	g_GameData.ActivityGm.ConsumDailySum = arg_32_1.RetData.ConsumDailySum

	g_GameEventMgr:sendEvent(zbGameEvent.Event_GmActivity_Ack)
end
