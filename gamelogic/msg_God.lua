function zbWsMsgHandler.WS_God_Change_Req(arg_1_0, arg_1_1)
	local var_1_0 = {
		GodId = arg_1_1
	}

	g_WsMsgHandler:wsPackMsg(var_1_0, MSG_ID.WS_God_Change_Req)
end

function zbWsMsgHandler.WS_God_Change_Ack(arg_2_0, arg_2_1)
	echoInfo("WS_God_Change_Ack")

	g_Self.kGodHandler.bgodChange = true

	g_Self.kGodHandler:updateGodInfo(arg_2_1.RetData.GodInfo)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_Formation)
end

function zbWsMsgHandler.WS_God_Upgrade_Req(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = {
		ItemTid = arg_3_1,
		Count = arg_3_2
	}

	if g_GameData.GodInfo then
		g_Self.kGodHandler.godLevelPreReqLevelUp = g_GameData.GodInfo.Level
	end

	g_WsMsgHandler:wsPackMsg(var_3_0, MSG_ID.WS_God_Upgrade_Req)
end

function zbWsMsgHandler.WS_God_Upgrade_Ack(arg_4_0, arg_4_1)
	echoInfo("WS_God_Upgrade_Ack")
	g_Self.kDataChange:update(arg_4_1)

	if arg_4_1.RetData.GodInfo.Level > g_Self.kGodHandler.godLevelPreReqLevelUp then
		g_MainScene:showEffectUIPlayWnd(UI_EFFECT_SHENGJI_SUC)
	end

	g_Self.kGodHandler:updateGodInfo(arg_4_1.RetData.GodInfo)
end

function zbWsMsgHandler.WS_God_UpgradeStar_Req(arg_5_0)
	local var_5_0 = {}

	g_WsMsgHandler:wsPackMsg(var_5_0, MSG_ID.WS_God_UpgradeStar_Req)
end

function zbWsMsgHandler.WS_God_UpgradeStar_Ack(arg_6_0, arg_6_1)
	echoInfo("WS_God_UpgradeStar_Ack")
	g_Self.kDataChange:update(arg_6_1)
	g_MainScene:showEffectUIPlayWnd(UI_EFFECT_JINJIE_SUC)
	g_Self.kGodHandler:updateGodInfo(arg_6_1.RetData.GodInfo)
end

function zbWsMsgHandler.WS_God_UpgradeSkill_Req(arg_7_0, arg_7_1)
	local var_7_0 = {
		Index = arg_7_1
	}

	g_WsMsgHandler:wsPackMsg(var_7_0, MSG_ID.WS_God_UpgradeSkill_Req)
end

function zbWsMsgHandler.WS_God_UpgradeSkill_Ack(arg_8_0, arg_8_1)
	echoInfo("WS_God_UpgradeSkill_Ack")
	g_Self.kDataChange:update(arg_8_1)

	if arg_8_1.RetData.UpgradeState == 0 then
		g_Bubble:bubbleInfo(a2u("\xBC\xBC\xC4\xDC\xC9\xFD\xBC\xB6ʧ\xB0\xDC"))
	else
		g_Bubble:bubbleInfo(a2u("\xBC\xBC\xC4\xDC\xC9\xFD\xBC\xB6\xB3ɹ\xA6"))
	end

	g_Self.kGodHandler:updateGodInfo(arg_8_1.RetData.GodInfo)
end
