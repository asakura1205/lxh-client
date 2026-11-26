function zbWsMsgHandler.WS_Rank_Arena_Req(arg_1_0)
	local var_1_0 = {}

	g_WsMsgHandler:wsPackMsg(var_1_0, MSG_ID.WS_Rank_Arena_Req)
end

function zbWsMsgHandler.WS_Rank_Arena_Ack(arg_2_0, arg_2_1)
	echoInfo("WS_Rank_Arena_Ack")
	g_Self.kRankHandler:updateArenaRankData(arg_2_1.RetData.RankList)
	g_MainScene:showRankListWnd(ERankTab.Arena)
end

local var_0_0 = -1

function zbWsMsgHandler.WS_Rank_Comm_Req(arg_3_0, arg_3_1)
	local var_3_0 = {}

	var_0_0 = arg_3_1
	var_3_0.RankType = arg_3_1

	g_WsMsgHandler:wsPackMsg(var_3_0, MSG_ID.WS_Rank_Comm_Req)
end

function zbWsMsgHandler.WS_Rank_Comm_Ack(arg_4_0, arg_4_1)
	echoInfo("WS_Rank_Comm_Ack")
	g_Self.kRankHandler:updateCommRankData(arg_4_1.RetData, var_0_0)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_UpdateCommonRankAck)
end

function zbWsMsgHandler.WS_Rank_Legion_Req(arg_5_0)
	local var_5_0 = {}

	g_WsMsgHandler:wsPackMsg(var_5_0, MSG_ID.WS_Rank_Legion_Req)
end

function zbWsMsgHandler.WS_Rank_Legion_Ack(arg_6_0, arg_6_1)
	echoInfo("WS_Rank_Legion_Ack")
	g_Self.kRankHandler:updateLegionRankData(arg_6_1.RetData.RankList)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_UpdateLegionRankAck)
end

function zbWsMsgHandler.WS_Rank_Hero_Req(arg_7_0)
	local var_7_0 = {}

	g_WsMsgHandler:wsPackMsg(var_7_0, MSG_ID.WS_Rank_Hero_Req)
end

function zbWsMsgHandler.WS_Rank_Hero_Ack(arg_8_0, arg_8_1)
	echoInfo("WS_Rank_Hero_Ack")
	g_Self.kRankHandler:updateHeroRankData(arg_8_1.RetData.RankList)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_UpdateHeroRankAck)
end
