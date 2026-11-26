function zbWsMsgHandler.WS_ActivityOs_GetData_Req(arg_1_0)
	local var_1_0 = {}

	g_WsMsgHandler:wsPackMsg(var_1_0, MSG_ID.WS_ActivityOs_GetData_Req)
end

function zbWsMsgHandler.WS_ActivityOs_GetData_Ack(arg_2_0, arg_2_1)
	echoInfo("WS_ActivityOs_GetData_Ack")

	g_GameData.ActivityOs = arg_2_1.RetData

	g_GameEventMgr:sendEvent(zbGameEvent.Event_Seven_Ack)
end

function zbWsMsgHandler.WS_ActivityOs_LevelAward_Req(arg_3_0, arg_3_1)
	local var_3_0 = {
		Level = arg_3_1
	}

	g_WsMsgHandler:wsPackMsg(var_3_0, MSG_ID.WS_ActivityOs_LevelAward_Req)
end

function zbWsMsgHandler.WS_ActivityOs_LevelAward_Ack(arg_4_0, arg_4_1)
	echoInfo("WS_ActivityOs_LevelAward_Ack")

	if g_Self.kSevenHandler.lastTemplateId > 0 then
		local var_4_0 = {
			Id = g_Self.kSevenHandler.lastTemplateId
		}

		var_4_0.bHave = g_Self.kHeroHandler:hasHeroByTemplateId(var_4_0.Id)

		g_MainScene:showPubGetHeroWnd(var_4_0, false, false, function()
			g_Self.kDataChange:update(arg_4_1)
		end)

		g_Self.kSevenHandler.lastTemplateId = 0
	else
		g_Self.kDataChange:update(arg_4_1)
	end

	g_GameData.ActivityOs.LevelAward = arg_4_1.RetData.LevelAward

	g_GameEventMgr:sendEvent(zbGameEvent.Event_Seven_Ack)
end

function zbWsMsgHandler.WS_ActivityOs_StarAward_Req(arg_6_0, arg_6_1)
	local var_6_0 = {
		Star = arg_6_1
	}

	g_WsMsgHandler:wsPackMsg(var_6_0, MSG_ID.WS_ActivityOs_StarAward_Req)
end

function zbWsMsgHandler.WS_ActivityOs_StarAward_Ack(arg_7_0, arg_7_1)
	echoInfo("WS_ActivityOs_StarAward_Ack")
	g_Self.kDataChange:update(arg_7_1)

	g_GameData.ActivityOs.StarAward = arg_7_1.RetData.StarAward

	g_GameEventMgr:sendEvent(zbGameEvent.Event_Seven_Ack)
end

function zbWsMsgHandler.WS_ActivityOs_PataAward_Req(arg_8_0, arg_8_1)
	local var_8_0 = {
		Level = arg_8_1
	}

	g_WsMsgHandler:wsPackMsg(var_8_0, MSG_ID.WS_ActivityOs_PataAward_Req)
end

function zbWsMsgHandler.WS_ActivityOs_PataAward_Ack(arg_9_0, arg_9_1)
	echoInfo("WS_ActivityOs_PataAward_Ack")
	g_Self.kDataChange:update(arg_9_1)

	g_GameData.ActivityOs.PataAward = arg_9_1.RetData.PataAward

	g_GameEventMgr:sendEvent(zbGameEvent.Event_Seven_Ack)
end

function zbWsMsgHandler.WS_ActivityOs_FVAward_Req(arg_10_0, arg_10_1)
	local var_10_0 = {
		FV = arg_10_1
	}

	g_WsMsgHandler:wsPackMsg(var_10_0, MSG_ID.WS_ActivityOs_FVAward_Req)
end

function zbWsMsgHandler.WS_ActivityOs_FVAward_Ack(arg_11_0, arg_11_1)
	echoInfo("WS_ActivityOs_FVAward_Ack")
	g_Self.kDataChange:update(arg_11_1)

	g_GameData.ActivityOs.FVAward = arg_11_1.RetData.FVAward

	g_GameEventMgr:sendEvent(zbGameEvent.Event_Seven_Ack)
end

function zbWsMsgHandler.WS_ActivityOs_ArenaAward_Req(arg_12_0, arg_12_1)
	local var_12_0 = {
		Rank = arg_12_1
	}

	g_WsMsgHandler:wsPackMsg(var_12_0, MSG_ID.WS_ActivityOs_ArenaAward_Req)
end

function zbWsMsgHandler.WS_ActivityOs_ArenaAward_Ack(arg_13_0, arg_13_1)
	echoInfo("WS_ActivityOs_ArenaAward_Ack")
	g_Self.kDataChange:update(arg_13_1)

	g_GameData.ActivityOs.ArenaAward = arg_13_1.RetData.ArenaAward

	g_GameEventMgr:sendEvent(zbGameEvent.Event_Seven_Ack)
end

function zbWsMsgHandler.WS_ActivityOs_LoginAward_Req(arg_14_0, arg_14_1)
	local var_14_0 = {
		Day = arg_14_1
	}

	g_WsMsgHandler:wsPackMsg(var_14_0, MSG_ID.WS_ActivityOs_LoginAward_Req)
end

function zbWsMsgHandler.WS_ActivityOs_LoginAward_Ack(arg_15_0, arg_15_1)
	echoInfo("WS_ActivityOs_LoginAward_Ack")

	if g_Self.kActivityHandler.lastTemplateId > 0 then
		local var_15_0 = {
			Id = g_Self.kActivityHandler.lastTemplateId
		}

		var_15_0.bHave = g_Self.kHeroHandler:hasHeroByTemplateId(var_15_0.Id)

		g_MainScene:showPubGetHeroWnd(var_15_0, false, false, function()
			g_Self.kDataChange:update(arg_15_1)
		end)

		g_Self.kActivityHandler.lastTemplateId = 0
	else
		g_Self.kDataChange:update(arg_15_1)
	end

	g_GameData.ActivityOs.LoginAward = arg_15_1.RetData.LoginAward

	g_GameEventMgr:sendEvent(zbGameEvent.Event_Seven_Ack)
end

function zbWsMsgHandler.WS_ActivityOs_HalfPacks_Req(arg_17_0, arg_17_1)
	local var_17_0 = {
		Day = arg_17_1
	}

	g_WsMsgHandler:wsPackMsg(var_17_0, MSG_ID.WS_ActivityOs_HalfPacks_Req)
end

function zbWsMsgHandler.WS_ActivityOs_HalfPacks_Ack(arg_18_0, arg_18_1)
	echoInfo("WS_ActivityOs_HalfPacks_Ack")
	g_Self.kDataChange:update(arg_18_1)

	g_GameData.ActivityOs.HalfPacks = arg_18_1.RetData.HalfPacks

	g_GameEventMgr:sendEvent(zbGameEvent.Event_Seven_Ack)
end

function zbWsMsgHandler.WS_ActivityOs_RechargeAward_Req(arg_19_0, arg_19_1)
	local var_19_0 = {
		Diamond = arg_19_1
	}

	g_WsMsgHandler:wsPackMsg(var_19_0, MSG_ID.WS_ActivityOs_RechargeAward_Req)
end

function zbWsMsgHandler.WS_ActivityOs_RechargeAward_Ack(arg_20_0, arg_20_1)
	echoInfo("WS_ActivityOs_RechargeAward_Ack")
	g_Self.kDataChange:update(arg_20_1)

	g_GameData.ActivityOs.RechargeAward = arg_20_1.RetData.RechargeAward

	g_GameEventMgr:sendEvent(zbGameEvent.Event_Seven_Ack)
end
