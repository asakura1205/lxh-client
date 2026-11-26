function zbWsMsgHandler.WS_ActivityAct_DailySign_Req(arg_1_0)
	local var_1_0 = {}

	g_WsMsgHandler:wsPackMsg(var_1_0, MSG_ID.WS_ActivityAct_DailySign_Req)
end

function zbWsMsgHandler.WS_ActivityAct_DailySign_Ack(arg_2_0, arg_2_1)
	echoInfo("WS_ActivityAct_DailySign_Ack")

	if g_Self.kActivityHandler.lastTemplateId > 0 then
		local var_2_0 = {
			Id = g_Self.kActivityHandler.lastTemplateId
		}

		var_2_0.bHave = g_Self.kHeroHandler:hasHeroByTemplateId(var_2_0.Id)

		g_MainScene:showPubGetHeroWnd(var_2_0, false, false)

		g_Self.kActivityHandler.lastTemplateId = 0
	end

	g_Self.kDataChange:update(arg_2_1)

	g_GameData.ActivityAct.DailySign = arg_2_1.RetData.DailySign

	g_GameEventMgr:sendEvent(zbGameEvent.Event_Activity_Ack)
end

function zbWsMsgHandler.WS_ActivityAct_TiliAdded_Req(arg_3_0, arg_3_1)
	local var_3_0 = {
		Index = arg_3_1
	}

	g_WsMsgHandler:wsPackMsg(var_3_0, MSG_ID.WS_ActivityAct_TiliAdded_Req)
end

function zbWsMsgHandler.WS_ActivityAct_TiliAdded_Ack(arg_4_0, arg_4_1)
	echoInfo("WS_ActivityAct_TiliAdded_Ack")
	g_Self.kDataChange:update(arg_4_1)

	g_GameData.ActivityAct.Tili = arg_4_1.RetData.Tili

	g_GameEventMgr:sendEvent(zbGameEvent.Event_Activity_Ack)
end

function zbWsMsgHandler.WS_ActivityAct_Tili_Req(arg_5_0)
	local var_5_0 = {}

	g_WsMsgHandler:wsPackMsg(var_5_0, MSG_ID.WS_ActivityAct_Tili_Req)
end

function zbWsMsgHandler.WS_ActivityAct_Tili_Ack(arg_6_0, arg_6_1)
	echoInfo("WS_ActivityAct_Tili_Ack")
	g_Self.kDataChange:update(arg_6_1)

	g_GameData.ActivityAct.Tili = arg_6_1.RetData.Tili

	g_GameEventMgr:sendEvent(zbGameEvent.Event_Activity_Ack)
end

function zbWsMsgHandler.WS_ActivityAct_SerialLogin_Req(arg_7_0, arg_7_1)
	local var_7_0 = {
		Day = arg_7_1
	}

	g_WsMsgHandler:wsPackMsg(var_7_0, MSG_ID.WS_ActivityAct_SerialLogin_Req)
end

function zbWsMsgHandler.WS_ActivityAct_SerialLogin_Ack(arg_8_0, arg_8_1)
	echoInfo("WS_ActivityAct_SerialLogin_Ack")
	g_Self.kDataChange:update(arg_8_1)

	g_GameData.ActivityAct.SerialLogin = arg_8_1.RetData.SerialLogin

	g_GameEventMgr:sendEvent(zbGameEvent.Event_Activity_Ack)
end

function zbWsMsgHandler.WS_ActivityAct_CrazyUpgrade_Req(arg_9_0, arg_9_1)
	local var_9_0 = {
		Level = arg_9_1
	}

	g_WsMsgHandler:wsPackMsg(var_9_0, MSG_ID.WS_ActivityAct_CrazyUpgrade_Req)
end

function zbWsMsgHandler.WS_ActivityAct_CrazyUpgrade_Ack(arg_10_0, arg_10_1)
	echoInfo("WS_ActivityAct_CrazyUpgrade_Ack")
	g_Self.kDataChange:update(arg_10_1)

	g_GameData.ActivityAct.CrazyUpgrade = arg_10_1.RetData.CrazyUpgrade

	if arg_10_1.RetData.Rank > 0 then
		g_Bubble:bubbleInfo("\xB9\xA7ϲ\xC4\xFA\xA3\xAC\xBB\xF1\xB5\xC3\xC1\xCBǰ100\xC3\xFB˫\xB1\xB6\xBD\xB1\xC0\xF8")
	elseif arg_10_1.RetData.Rank == 0 then
		g_Bubble:bubbleInfo("\xBA\xDC\xD2ź\xB6\xA3\xACû\xD3л\xF1\xB5\xC3ǰ100\xC3\xFB˫\xB1\xB6\xBD\xB1\xC0\xF8")
	end

	g_GameEventMgr:sendEvent(zbGameEvent.Event_Activity_Ack)
end

function zbWsMsgHandler.WS_ActivityAct_LoginVip_Req(arg_11_0, arg_11_1)
	local var_11_0 = {
		Level = arg_11_1
	}

	g_WsMsgHandler:wsPackMsg(var_11_0, MSG_ID.WS_ActivityAct_LoginVip_Req)
end

function zbWsMsgHandler.WS_ActivityAct_LoginVip_Ack(arg_12_0, arg_12_1)
	echoInfo("WS_ActivityAct_LoginVip_Ack")
	g_Self.kDataChange:update(arg_12_1)

	g_GameData.VipInfo = arg_12_1.RetData.VipInfo
	g_GameData.ActivityAct.LoginVip = arg_12_1.RetData.LoginVip

	g_Self:updateBaseInfo(arg_12_1.RetData.BaseInfo)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_Activity_Ack)
end

function zbWsMsgHandler.WS_ActivityAct_WishTabRun_Req(arg_13_0)
	local var_13_0 = {}

	g_WsMsgHandler:wsPackMsg(var_13_0, MSG_ID.WS_ActivityAct_WishTabRun_Req)
end

function zbWsMsgHandler.WS_ActivityAct_WishTabRun_Ack(arg_14_0, arg_14_1)
	echoInfo("WS_ActivityAct_WishTabRun_Ack")

	g_GameData.ActivityAct.WishTurntable = arg_14_1.RetData.WishTurntable
	g_Self.kActivityHandler.wishTurntableSoltType = arg_14_1.RetData.Index
	g_Self.kActivityHandler.wishData = arg_14_1

	g_GameEventMgr:sendEvent(zbGameEvent.Event_WishTurntable_Ack)
end

function zbWsMsgHandler.WS_ActivityAct_WishTabRefresh_Req(arg_15_0)
	local var_15_0 = {}

	g_WsMsgHandler:wsPackMsg(var_15_0, MSG_ID.WS_ActivityAct_WishTabRefresh_Req)
end

function zbWsMsgHandler.WS_ActivityAct_WishTabRefresh_Ack(arg_16_0, arg_16_1)
	echoInfo("WS_ActivityAct_WishTabRefresh_Ack")
	g_Self.kDataChange:update(arg_16_1)

	g_GameData.ActivityAct.WishTurntable = arg_16_1.RetData.WishTurntable

	g_GameEventMgr:sendEvent(zbGameEvent.Event_Activity_Ack)
end

function zbWsMsgHandler.WS_ActivityAct_RedeemCode_Req(arg_17_0, arg_17_1)
	local var_17_0 = {
		RedeemCode = arg_17_1
	}

	g_WsMsgHandler:wsPackMsg(var_17_0, MSG_ID.WS_ActivityAct_RedeemCode_Req)
end

function zbWsMsgHandler.WS_ActivityAct_RedeemCode_Ack(arg_18_0, arg_18_1)
	echoInfo("WS_ActivityAct_RedeemCode_Ack")
	g_Self.kDataChange:update(arg_18_1)
end

function zbWsMsgHandler.WS_ActivityAct_OnlineAward_Req(arg_19_0)
	local var_19_0 = {}

	g_WsMsgHandler:wsPackMsg(var_19_0, MSG_ID.WS_ActivityAct_OnlineAward_Req)
end

function zbWsMsgHandler.WS_ActivityAct_OnlineAward_Ack(arg_20_0, arg_20_1)
	echoInfo("WS_ActivityAct_OnlineAward_Ack")
	g_Self.kDataChange:update(arg_20_1)

	g_GameData.ActivityAct.OnlineAward = arg_20_1.RetData.OnlineAward

	g_GameEventMgr:sendEvent(zbGameEvent.Event_Activity_Ack)
end

function zbWsMsgHandler.WS_ActivityAct_LuckyDiamond_Req(arg_21_0, arg_21_1)
	local var_21_0 = {}

	g_WsMsgHandler:wsPackMsg(var_21_0, MSG_ID.WS_ActivityAct_LuckyDiamond_Req)
end

function zbWsMsgHandler.WS_ActivityAct_LuckyDiamond_Ack(arg_22_0, arg_22_1)
	echoInfo("WS_ActivityAct_LuckyDiamond_Ack")

	g_Self.kActivityHandler.HitDiamond = arg_22_1.RetData.HitDiamond
	g_Self.kActivityHandler.luckData = arg_22_1
	g_GameData.ActivityAct.LuckyDiamond = arg_22_1.RetData.LuckyDiamond
	g_Self.kActivityHandler.RecordList = arg_22_1.RetData.RecordList

	g_GameEventMgr:sendEvent(zbGameEvent.Event_LuckyDiamond_Ack)
end

function zbWsMsgHandler.WS_ActivityAct_LuckyDiamondLog_Req(arg_23_0, arg_23_1)
	local var_23_0 = {}

	g_WsMsgHandler:wsPackMsg(var_23_0, MSG_ID.WS_ActivityAct_LuckyDiamondLog_Req)
end

function zbWsMsgHandler.WS_ActivityAct_LuckyDiamondLog_Ack(arg_24_0, arg_24_1)
	echoInfo("WS_ActivityAct_LuckyDiamondLog_Ack")

	g_Self.kActivityHandler.RecordList = arg_24_1.RetData.RecordList

	g_GameEventMgr:sendEvent(zbGameEvent.Event_LuckyRecord_Ack)
end

function zbWsMsgHandler.WS_ActivityAct_VipCardAward_Req(arg_25_0, arg_25_1)
	local var_25_0 = {
		GoodsType = arg_25_1
	}

	g_WsMsgHandler:wsPackMsg(var_25_0, MSG_ID.WS_ActivityAct_VipCardAward_Req)
end

function zbWsMsgHandler.WS_ActivityAct_VipCardAward_Ack(arg_26_0, arg_26_1)
	echoInfo("WS_ActivityAct_VipCardAward_Ack")

	g_GameData.VipInfo.MonthCard = arg_26_1.RetData.MonthCard
	g_GameData.VipInfo.QuarterCard = arg_26_1.RetData.QuarterCard
	g_GameData.VipInfo.ForeverCard = arg_26_1.RetData.ForeverCard

	g_Self.kDataChange:update(arg_26_1)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_Activity_Ack)
end

function zbWsMsgHandler.WS_ActivityAct_TwoCardAward_Req(arg_27_0)
	local var_27_0 = {}

	g_WsMsgHandler:wsPackMsg(var_27_0, MSG_ID.WS_ActivityAct_TwoCardAward_Req)
end

function zbWsMsgHandler.WS_ActivityAct_TwoCardAward_Ack(arg_28_0, arg_28_1)
	echoInfo("WS_ActivityAct_TwoCardAward_Ack")

	g_GameData.VipInfo.TwoCard = arg_28_1.RetData.TwoCard

	g_Self.kDataChange:update(arg_28_1)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_Activity_Ack)
end

function zbWsMsgHandler.WS_ActivityAct_FirstRecharge_Req(arg_29_0)
	local var_29_0 = {}

	g_WsMsgHandler:wsPackMsg(var_29_0, MSG_ID.WS_ActivityAct_FirstRecharge_Req)
end

function zbWsMsgHandler.WS_ActivityAct_FirstRecharge_Ack(arg_30_0, arg_30_1)
	echoInfo("WS_ActivityAct_FirstRecharge_Ack")

	if g_Self.kActivityHandler.lastTemplateId > 0 then
		local var_30_0 = {
			Id = g_Self.kActivityHandler.lastTemplateId
		}

		var_30_0.bHave = g_Self.kHeroHandler:hasHeroByTemplateId(var_30_0.Id)

		g_MainScene:showPubGetHeroWnd(var_30_0, false, false, function()
			g_Self.kDataChange:update(arg_30_1)
		end)

		g_Self.kActivityHandler.lastTemplateId = 0
	else
		g_Self.kDataChange:update(arg_30_1)
	end

	g_GameData.VipInfo.FirstBuy = arg_30_1.RetData.FirstBuy

	g_GameEventMgr:sendEvent(zbGameEvent.Event_Activity_Ack)
end

function zbWsMsgHandler.WS_ActivityAct_RebateAward_Req(arg_32_0)
	local var_32_0 = {}

	g_WsMsgHandler:wsPackMsg(var_32_0, MSG_ID.WS_ActivityAct_RebateAward_Req)
end

function zbWsMsgHandler.WS_ActivityAct_RebateAward_Ack(arg_33_0, arg_33_1)
	echoInfo("WS_ActivityAct_RebateAward_Ack")

	g_GameData.ActivityAct.RebateAward = arg_33_1.RetData.RebateAward
	g_GameData.VipInfo = arg_33_1.RetData.VipInfo

	g_Self.kDataChange:update(arg_33_1)
	g_Self:updateBaseInfo(arg_33_1.RetData.BaseInfo)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_Activity_Ack)
end
