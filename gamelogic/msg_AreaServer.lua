function zbHttpMsgHandler.AS_ErrorCode_Ack(arg_1_0, arg_1_1)
	local var_1_0 = ""
	local var_1_1 = EErrorCodeMap[arg_1_1.RetCode] or tostring(arg_1_1.RetCode)
	local var_1_2 = a2u("\xB5\xC7¼\xB7\xFE\xCE\xF1\xC6\xF7\xB7\xB5\xBBش\xED\xCE\xF3:") .. a2u(var_1_1)

	g_Bubble:bubbleInfo(var_1_2)
	echoInfo(var_1_2)
end

function zbHttpMsgHandler.AS_NoticeList_Req(arg_2_0, arg_2_1)
	echoInfo("AS_NoticeList_Req")

	local var_2_0 = {
		Channel = g_Login.channel,
		Platform = g_Login.platform,
		ServerId = arg_2_1
	}

	g_HttpMsgHandler:packMsg(var_2_0, MSG_ID.AS_NoticeList_Req, g_areaReq_url)
end

function zbHttpMsgHandler.AS_NoticeList_Ack(arg_3_0, arg_3_1)
	echoInfo("AS_NoticeList_Ack")

	g_Login.noticeData = arg_3_1

	if g_GameStateMachine:getCurrStateId() == GameState_Login then
		g_LoginScene:showServerNotice()
	elseif g_GameStateMachine:getCurrStateId() == GameState_Scene then
		g_MainScene:showServerNotice()
	end
end

function zbHttpMsgHandler.AS_AreaList_Req(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = PacketHeader

	var_4_0.MsgID = MSG_ID.AS_AreaList_Req

	local var_4_1 = NodMsg

	var_4_1.Header = var_4_0
	var_4_1.Msg = arg_4_1

	local var_4_2 = require("cjson").encode(var_4_1)
	local var_4_3 = arg_4_2 .. var_4_2

	g_HttpMsgHandler:sendMsg(var_4_3, var_4_0.MsgID)
	echoInfo("AS_AreaList_Req " .. var_4_3)
end

function zbHttpMsgHandler.AS_AreaList_Ack(arg_5_0, arg_5_1)
	echoInfo("AS_AreaList_Ack")

	g_Login.areaInfo = arg_5_1

	g_GameEventMgr:sendEvent(zbGameEvent.Event_Refresh_ServerList)
end

function zbHttpMsgHandler.AS_RoleInfoReq(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = PacketHeader

	var_6_0.MsgID = MSG_ID.AS_RoleInfo_Req

	local var_6_1 = NodMsg

	var_6_1.Header = var_6_0
	var_6_1.Msg = arg_6_1

	local var_6_2 = require("cjson").encode(var_6_1)
	local var_6_3 = arg_6_2 .. var_6_2

	echoInfo("AS_RoleInfoReq: " .. var_6_3)
	g_HttpMsgHandler:sendMsg(var_6_3, var_6_0.MsgID)
end

function zbHttpMsgHandler.AS_RoleInfoAck(arg_7_0, arg_7_1)
	echoInfo("AS_RoleInfoAck")

	g_Login.areaRoleInfo = arg_7_1

	g_GameEventMgr:sendEvent(zbGameEvent.Event_Server_Role)
end

function zbHttpMsgHandler.AS_AccountCheck_Req(arg_8_0)
	local var_8_0 = {
		Channel = g_Login.channel,
		AccountId = g_Login.accountId,
		Platform = g_Login.platform
	}

	g_HttpMsgHandler:packMsg(var_8_0, MSG_ID.AS_AccountCheck_Req, g_areaReq_url)
end

function zbHttpMsgHandler.AS_AccountCheck_Ack(arg_9_0, arg_9_1)
	g_Login.account_active = arg_9_1.Ret

	g_GameEventMgr:sendEvent(zbGameEvent.Event_AccountAc_Check)
end

function zbHttpMsgHandler.AS_AccountActivate_Req(arg_10_0, arg_10_1)
	local var_10_0 = {
		Channel = g_Login.channel,
		AccountId = g_Login.accountId,
		AcCode = arg_10_1,
		Platform = g_Login.platform
	}

	g_HttpMsgHandler:packMsg(var_10_0, MSG_ID.AS_AccountActivate_Req, g_areaReq_url)
end

function zbHttpMsgHandler.AS_AccountActivate_Ack(arg_11_0, arg_11_1)
	g_Login.account_active = arg_11_1.Ret

	if arg_11_1.Ret == 1 then
		g_Bubble:bubbleInfo(a2u("\xBC\xA4\xBB\xEE\xB3ɹ\xA6"))
	else
		g_Bubble:bubbleInfo(a2u("\xBC\xA4\xBB\xEEʧ\xB0\xDC"))
	end
end
