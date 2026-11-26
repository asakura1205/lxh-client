function zbWsMsgHandler.ErrorCode_Ack(arg_1_0, arg_1_1)
	local var_1_0 = ""
	local var_1_1 = EErrorCodeMap[arg_1_1.RetCode] or tostring(arg_1_1.RetCode)
	local var_1_2 = a2u(var_1_1) .. "." .. a2u("[") .. arg_1_1.RetCode .. a2u("]")

	g_Bubble:bubbleInfo(var_1_2)
	echoInfo(var_1_2)

	if arg_1_1.RetCode == EErrorCode.NotLoginGame or arg_1_1.RetCode == EErrorCode.UserKicked then
		g_Login:reqAreaList()
		g_GameStateMachine:setStateImmediate(GameState_Login)
	else
		g_WsMsgHandler:WS_SyncData_Ntf(arg_1_1)
	end

	local function var_1_3()
		if EErrorCode.NotEnoughGold == arg_1_1.RetCode then
			g_MainScene:showGoldenTouch(EExchangeType.Gold)
		elseif EErrorCode.NotEnoughFood == arg_1_1.RetCode then
			g_MainScene:showGoldenTouch(EExchangeType.Food)
		elseif EErrorCode.NotEnoughTili == arg_1_1.RetCode then
			g_MainScene:showGoldenTouch(EExchangeType.Tili)
		elseif EErrorCode.NotEnoughDiamond == arg_1_1.RetCode then
			g_MainScene:showVipBuyWnd()
		end
	end

	if EErrorCode.NotEnoughGold == arg_1_1.RetCode then
		local var_1_4 = a2u("\xBD\xF0\xDF\xF7\xB1Ҳ\xBB\xD7㣬\xB8\xFA\xD7\xC5\xCE\xD2ȥ\xB8\xE3\xB5\xE3\xBD\xF0\xDF\xF7\xB1Ұɡ\xA3")

		g_MessageBox:showYesNo(var_1_4, var_1_3)
	elseif EErrorCode.NotEnoughFood == arg_1_1.RetCode then
		local var_1_5 = a2u("è\xB7\xB9\xB2\xBB\xD7㣬\xB8\xFA\xD7\xC5\xCE\xD2ȥ\xB8\xE3\xB5\xE3è\xB7\xB9\xB0ɡ\xA3")

		g_MessageBox:showYesNo(var_1_5, var_1_3)
	elseif EErrorCode.NotEnoughTili == arg_1_1.RetCode then
		local var_1_6 = a2u("\xD3\xE3\xB8ɲ\xBB\xD7㣬\xB8\xFA\xD7\xC5\xCE\xD2ȥ\xB8\xE3\xB5\xE3\xD3\xE3\xB8ɰɡ\xA3")

		g_MessageBox:showYesNo(var_1_6, var_1_3)
	elseif EErrorCode.NotEnoughDiamond == arg_1_1.RetCode then
		local var_1_7 = a2u("\xD7\xEAʯ\xB2\xBB\xD7㣬\xB8\xFA\xD7\xC5\xCE\xD2ȥ\xB8\xE3\xB5\xE3\xD7\xEAʯ\xB0ɡ\xA3")

		g_MessageBox:showYesNo(var_1_7, var_1_3)
	end
end

function zbWsMsgHandler.WS_Common_GetGameEnv_Req(arg_3_0)
	local var_3_0 = {}

	g_WsMsgHandler.sendMsgNeedCircle = false

	g_WsMsgHandler:wsPackMsg(var_3_0, MSG_ID.WS_Common_GetGameEnv_Req)

	g_WsMsgHandler.sendMsgNeedCircle = true
end

function zbWsMsgHandler.WS_Common_GetGameEnv_Ack(arg_4_0, arg_4_1)
	echo("info: zbWsMsgHandler:WS_Common_GetGameEnv_Ack")
	g_Self:updateGameEnvInfo(arg_4_1.RetData)

	g_WsMsgHandler.heartPackCheckback = true
end

function zbWsMsgHandler.WS_Login_Game_Req(arg_5_0)
	local var_5_0 = {
		ServerId = g_Login.selectServerId,
		ChannelId = g_Login.channel,
		AccountId = g_Login.accountId,
		Account = g_Login.account,
		IMEI = g_Login.device_uuid,
		Version = g_Login.resVersion,
		Platform = g_Login.platform,
		Ticket = g_Login.ticket
	}

	g_WsMsgHandler:wsPackMsg(var_5_0, MSG_ID.WS_Login_Game_Req)
end

function zbWsMsgHandler.WS_Login_Game_Ack(arg_6_0, arg_6_1)
	if g_GameStateMachine:getCurrStateId() == GameState_Scene then
		if zbUtil:isValidTable(arg_6_1.RetData) then
			for iter_6_0, iter_6_1 in pairs(arg_6_1.RetData) do
				g_GameData[iter_6_0] = iter_6_1
			end
		end

		return
	end

	zbGameCore:Instance():setConfigValue(CONFIG_KEY_LAST_SERVERID, g_Login.selectServerId)

	g_GameData = arg_6_1.RetData

	g_GameStateMachine:setStateImmediate(GameState_Scene)
	zbChannelUtil_Report:submitRoleInfoByChannel(ESubRoleInfoType.E_ENTER_GAME)
	zbChannelUtil_Report:reportGameData(3)
	zbGlobalUtil:GameCallSDKFunction("hideNavigation", "", "")
	echoInfo("WS_Login_Game_Ack")
end

function zbWsMsgHandler.WS_Login_Out_Req(arg_7_0)
	local var_7_0 = {}

	g_WsMsgHandler:wsPackMsg(var_7_0, MSG_ID.WS_Login_Out_Req)
end

function zbWsMsgHandler.WS_Login_Out_Ack(arg_8_0, arg_8_1)
	echoInfo("WS_LoginOut_Ack")
	g_GameStateMachine:setStateImmediate(GameState_Login)
end

function zbWsMsgHandler.WS_Login_GameComplete_Req(arg_9_0, arg_9_1)
	local var_9_0 = {}

	g_WsMsgHandler.sendMsgNeedCircle = false

	g_WsMsgHandler:wsPackMsg(var_9_0, MSG_ID.WS_Login_GameComplete_Req)

	g_WsMsgHandler.sendMsgNeedCircle = true
end

function zbWsMsgHandler.WS_Login_GameComplete_Ack(arg_10_0, arg_10_1)
	echoInfo("WS_Login_GameComplete_Ack")

	g_GameData.ActivityAct = arg_10_1.RetData.ActivityAct
	g_GameData.ActivityOs = arg_10_1.RetData.ActivityOs
	g_GameData.ActivityGm = arg_10_1.RetData.ActivityGm

	if g_PushCenter then
		g_PushCenter:pushFixMessage()
	end

	if g_MainScene.wndMain ~= nil then
		g_MainScene.wndMain.mainShortcut:refreshDetail()
	end

	g_GameEventMgr:sendEvent(zbGameEvent.Event_Activity_Ack)
end
