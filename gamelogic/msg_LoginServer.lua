function zbHttpMsgHandler.LS_ErrorCode_Ack(arg_1_0, arg_1_1)
	local var_1_0 = ""
	local var_1_1 = EErrorCodeMap[arg_1_1.RetCode] or tostring(arg_1_1.RetCode)
	local var_1_2 = a2u("\xB5\xC7¼\xB7\xFE\xCE\xF1\xC6\xF7\xB7\xB5\xBBش\xED\xCE\xF3:") .. a2u(var_1_1)

	g_Bubble:bubbleInfo(var_1_2)

	if EErrorCode.EErrorCode_LS_TokenError == arg_1_1.RetCode then
		zbChannelUtil_Login:onLoginTokenValidByChanelType()
	end

	echoInfo(var_1_2)
end

function zbHttpMsgHandler.LS_LoginReq(arg_2_0, arg_2_1)
	g_HttpMsgHandler:sendMsg(arg_2_1)
end

function zbHttpMsgHandler.LS_LoginAck(arg_3_0, arg_3_1)
	g_Login.accountId = arg_3_1.AccountId
	g_Login.account = arg_3_1.Account
	g_Login.ticket = arg_3_1.Ticket

	zbChannelUtil_Login:initSdkLoginState()
	g_Login:reqAreaList()
	g_HttpMsgHandler:AS_NoticeList_Req(g_Login.selectServerId)
	echoInfo("LS_LoginAck")
end
