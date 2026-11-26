function zbWsMsgHandler.WS_MainTask_GetData_Req(arg_1_0)
	local var_1_0 = {}

	g_WsMsgHandler:wsPackMsg(var_1_0, MSG_ID.WS_MainTask_GetData_Req)
end

function zbWsMsgHandler.WS_MainTask_GetData_Ack(arg_2_0, arg_2_1)
	echoInfo("WS_MainTask_GetData_Ack")
	g_Self.kTaskHandler:updateMainTask(arg_2_1.RetData.MainTask)
end

function zbWsMsgHandler.WS_MainTask_Award_Req(arg_3_0, arg_3_1)
	local var_3_0 = {
		TaskId = arg_3_1
	}

	g_WsMsgHandler:wsPackMsg(var_3_0, MSG_ID.WS_MainTask_Award_Req)
end

function zbWsMsgHandler.WS_MainTask_Award_Ack(arg_4_0, arg_4_1)
	echoInfo("WS_MainTask_Award_Ack")
	g_Self.kTaskHandler:updateMainTask(arg_4_1.RetData.MainTask)
	g_Self.kDataChange:update(arg_4_1)
end
