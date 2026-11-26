function zbWsMsgHandler.WS_SyncData_Formation_Req(arg_1_0)
	local var_1_0 = {}

	g_WsMsgHandler:wsPackMsg(var_1_0, MSG_ID.WS_SyncData_Formation_Req)
end

function zbWsMsgHandler.WS_SyncData_Formation_Ack(arg_2_0, arg_2_1)
	echoInfo("WS_SyncData_Formation_Ack")
	g_Self.kFormation:updateServerFormation(arg_2_1.RetData.Formation, arg_2_1.RetData.GodInfo)
	g_MainScene:showFightPowerUpWnd()
end

function zbWsMsgHandler.WS_Formation_Save_Req(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = {
		TechId = arg_3_1,
		GodId = arg_3_2,
		Layout = arg_3_3
	}

	g_WsMsgHandler:wsPackMsg(var_3_0, MSG_ID.WS_Formation_Save_Req)
end

function zbWsMsgHandler.WS_Formation_Save_Ack(arg_4_0, arg_4_1)
	echoInfo("WS_Formation_Save_Ack")
	g_Self.kFormation:updateServerFormation(arg_4_1.RetData.Formation, arg_4_1.RetData.GodInfo)
	g_MainScene:showFightPowerUpWnd()
end
