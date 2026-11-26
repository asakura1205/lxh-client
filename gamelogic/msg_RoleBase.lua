function zbWsMsgHandler.WS_Common_SetFirst_Req(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = {
		AvatarId = arg_1_1,
		RoleName = arg_1_2
	}

	g_WsMsgHandler:wsPackMsg(var_1_0, MSG_ID.WS_Common_SetFirst_Req)
end

function zbWsMsgHandler.WS_Common_SetFirst_Ack(arg_2_0, arg_2_1)
	echoInfo("WS_Common_SetFirst_Ack")
	g_Self.kDataChange:update(arg_2_1)
	g_Self:updateBaseInfo(arg_2_1.RetData.BaseInfo)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_FirstRoleInfoSet_Ack)
	zbChannelUtil_Report:submitRoleInfoByChannel(ESubRoleInfoType.E_CREATE)
end

function zbWsMsgHandler.WS_Common_SetRoleName_Req(arg_3_0, arg_3_1)
	local var_3_0 = {
		RoleName = arg_3_1
	}

	g_WsMsgHandler:wsPackMsg(var_3_0, MSG_ID.WS_Common_SetRoleName_Req)
end

function zbWsMsgHandler.WS_Common_SetRoleName_Ack(arg_4_0, arg_4_1)
	g_Self.kDataChange:update(arg_4_1)
	g_Self:updateBaseInfo(arg_4_1.RetData.BaseInfo)
end

function zbWsMsgHandler.WS_Common_SetHeadId_Req(arg_5_0, arg_5_1)
	local var_5_0 = {
		HeadId = arg_5_1
	}

	g_WsMsgHandler:wsPackMsg(var_5_0, MSG_ID.WS_Common_SetHeadId_Req)
end

function zbWsMsgHandler.WS_Common_SetHeadId_Ack(arg_6_0, arg_6_1)
	g_Self:updateBaseInfo(arg_6_1.RetData.BaseInfo)
end

function zbWsMsgHandler.WS_Common_SetSex_Req(arg_7_0)
	local var_7_0 = {}

	g_WsMsgHandler:wsPackMsg(var_7_0, MSG_ID.WS_Common_SetSex_Req)
end

function zbWsMsgHandler.WS_Common_SetSex_Ack(arg_8_0, arg_8_1)
	g_Self:updateBaseInfo(arg_8_1.RetData.BaseInfo)
end

function zbWsMsgHandler.WS_Common_SetSignature_Req(arg_9_0, arg_9_1)
	local var_9_0 = {
		Signature = arg_9_1
	}

	g_WsMsgHandler:wsPackMsg(var_9_0, MSG_ID.WS_Common_SetSignature_Req)
end

function zbWsMsgHandler.WS_Common_SetSignature_Ack(arg_10_0, arg_10_1)
	g_Self:updateBaseInfo(arg_10_1.RetData.BaseInfo)
end

function zbWsMsgHandler.WS_Rank_GetData_Req(arg_11_0, arg_11_1)
	local var_11_0 = {
		RankType = arg_11_1
	}

	g_WsMsgHandler:wsPackMsg(var_11_0, MSG_ID.WS_Rank_GetData_Req)
end

function zbWsMsgHandler.WS_Rank_GetData_Ack(arg_12_0, arg_12_1)
	echoInfo("WS_Rank_GetData_Ack")
	g_Self.kRankHandler:updateRankList(arg_12_1.RetData)
end
