function zbWsMsgHandler.WS_Building_GetData_Req(arg_1_0)
	local var_1_0 = {}

	g_WsMsgHandler:wsPackMsg(var_1_0, MSG_ID.WS_Building_GetData_Req)
end

function zbWsMsgHandler.WS_Building_GetData_Ack(arg_2_0, arg_2_1)
	echoInfo("WS_Building_GetData_Ack")
	g_Self.kFarmHandler:updateInfo(arg_2_1.RetData.BuildingList)
end

function zbWsMsgHandler.WS_Building_Upgrade_Req(arg_3_0)
	local var_3_0 = {
		BuildingId = EBuildingType.Farm
	}

	g_WsMsgHandler:wsPackMsg(var_3_0, MSG_ID.WS_Building_Upgrade_Req)
end

function zbWsMsgHandler.WS_Building_Upgrade_Ack(arg_4_0, arg_4_1)
	echoInfo("WS_Building_Upgrade_Ack")
	g_Self.kDataChange:update(arg_4_1)
	g_Self.kFarmHandler:updateInfo(arg_4_1.RetData.BuildingList)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_FarmUpgrade_Ack)
end

function zbWsMsgHandler.WS_Building_ImmComplete_Req(arg_5_0)
	local var_5_0 = {
		BuildingId = EBuildingType.Farm
	}

	g_WsMsgHandler:wsPackMsg(var_5_0, MSG_ID.WS_Building_ImmComplete_Req)
end

function zbWsMsgHandler.WS_Building_ImmComplete_Ack(arg_6_0, arg_6_1)
	echoInfo("WS_Building_ImmComplete_Ack")
	g_Self.kDataChange:update(arg_6_1)
	g_Self.kFarmHandler:updateInfo(arg_6_1.RetData.BuildingList)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_FarmUpgrade_Ack)
end

function zbWsMsgHandler.WS_Building_Income_Req(arg_7_0)
	local var_7_0 = {
		BuildingId = EBuildingType.Farm
	}

	g_WsMsgHandler:wsPackMsg(var_7_0, MSG_ID.WS_Building_Income_Req)
end

function zbWsMsgHandler.WS_Building_Income_Ack(arg_8_0, arg_8_1)
	echoInfo("WS_Building_Income_Ack")
	g_Self.kDataChange:update(arg_8_1)
	g_Self.kFarmHandler:updateInfo(arg_8_1.RetData.BuildingList)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_FarmLevy_Ack)

	if g_MainScene.wndFarm ~= nil then
		g_MainScene.wndFarm:hide()
	end
end
