function zbWsMsgHandler.WS_DailyTask_GetData_Req(arg_1_0)
	local var_1_0 = {}

	g_WsMsgHandler:wsPackMsg(var_1_0, MSG_ID.WS_DailyTask_GetData_Req)
end

function zbWsMsgHandler.WS_DailyTask_GetData_Ack(arg_2_0, arg_2_1)
	echoInfo("WS_DailyTask_GetData_Ack")
	g_Self.kDailyHandler:updateDailyTask(arg_2_1.RetData.DailyTask)
end

function zbWsMsgHandler.WS_DailyTask_Complete_Req(arg_3_0, arg_3_1)
	local var_3_0 = {
		TaskType = arg_3_1
	}

	g_WsMsgHandler:wsPackMsg(var_3_0, MSG_ID.WS_DailyTask_Complete_Req)
end

function zbWsMsgHandler.WS_DailyTask_Complete_Ack(arg_4_0, arg_4_1)
	echoInfo("WS_DailyTask_Complete_Ack")
	g_Self.kDailyHandler:updateDailyTask(arg_4_1.RetData.DailyTask)

	if arg_4_1.RetData.BaseInfo.Exp > g_GameData.BaseInfo.Exp then
		local var_4_0 = {}
		local var_4_1 = {
			awardType = ECommonAwardType.RoleExp
		}

		var_4_1.awardId = 0
		var_4_1.awardCount = arg_4_1.RetData.BaseInfo.Exp - g_GameData.BaseInfo.Exp

		table.insert(var_4_0, var_4_1)
		g_MainScene:showAwardWnd(var_4_0)
	end

	g_Self:updateBaseInfo(arg_4_1.RetData.BaseInfo)
	g_Self.kDataChange:update(arg_4_1)
	g_MainScene:checkShowLevelUpWnd()
end

function zbWsMsgHandler.WS_DailyTask_Award_Req(arg_5_0, arg_5_1)
	local var_5_0 = {
		Active = arg_5_1
	}

	g_WsMsgHandler:wsPackMsg(var_5_0, MSG_ID.WS_DailyTask_Award_Req)
end

function zbWsMsgHandler.WS_DailyTask_Award_Ack(arg_6_0, arg_6_1)
	echoInfo("WS_DailyTask_Award_Ack")
	g_Self.kDailyHandler:updateDailyTask(arg_6_1.RetData.DailyTask)
	g_Self.kDataChange:update(arg_6_1)
end
