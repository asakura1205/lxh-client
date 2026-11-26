local var_0_0 = -1

function zbWsMsgHandler.WS_Mail_GetList_Req(arg_1_0)
	local var_1_0 = {}

	g_WsMsgHandler:wsPackMsg(var_1_0, MSG_ID.WS_Mail_GetList_Req)
end

function zbWsMsgHandler.WS_Mail_GetList_Ack(arg_2_0, arg_2_1)
	echoInfo("WS_Mail_GetList_Ack")
	g_Self.kMailHandler:updateMailList(arg_2_1.RetData.MailList)
end

function zbWsMsgHandler.WS_Mail_Read_Req(arg_3_0, arg_3_1)
	local var_3_0 = {
		MailId = arg_3_1
	}

	var_0_0 = arg_3_1

	g_WsMsgHandler:wsPackMsg(var_3_0, MSG_ID.WS_Mail_Read_Req)
end

function zbWsMsgHandler.WS_Mail_Read_Ack(arg_4_0, arg_4_1)
	echoInfo("WS_Mail_Read_Ack")
	g_Self.kMailHandler:updateMailRead(var_0_0, arg_4_1)
end

function zbWsMsgHandler.WS_Mail_GetAward_Req(arg_5_0, arg_5_1)
	local var_5_0 = {
		MailId = arg_5_1
	}

	g_WsMsgHandler:wsPackMsg(var_5_0, MSG_ID.WS_Mail_GetAward_Req)
end

function zbWsMsgHandler.WS_Mail_GetAward_Ack(arg_6_0, arg_6_1)
	echoInfo("WS_Mail_GetAward_Ack")
	g_Self.kDataChange:update(arg_6_1)
	g_Self.kMailHandler:updateMailDetail(arg_6_1.RetData.MailDetail)

	if g_MainScene.wndMailDetail then
		g_MainScene.wndMailDetail:hide()
	end
end

function zbWsMsgHandler.WS_Mail_GetAllAward_Req(arg_7_0)
	local var_7_0 = {}

	g_WsMsgHandler:wsPackMsg(var_7_0, MSG_ID.WS_Mail_GetAllAward_Req)
end

function zbWsMsgHandler.WS_Mail_GetAllAward_Ack(arg_8_0, arg_8_1)
	echoInfo("WS_Mail_GetAllAward_Ack")
	g_Self.kDataChange:update(arg_8_1)
	g_Self.kMailHandler:updateMailList(arg_8_1.RetData.MailList)
end

function zbWsMsgHandler.WS_Mail_Delete_Req(arg_9_0, arg_9_1)
	local var_9_0 = {
		DelList = arg_9_1
	}

	g_WsMsgHandler:wsPackMsg(var_9_0, MSG_ID.WS_Mail_Delete_Req)
end

function zbWsMsgHandler.WS_Mail_Delete_Ack(arg_10_0, arg_10_1)
	echoInfo("WS_Mail_Delete_Ack")
	g_Self.kMailHandler:deleteMailList(arg_10_1.RetData)

	if g_MainScene.wndMailDetail then
		g_MainScene.wndMailDetail:hide()
	end
end
