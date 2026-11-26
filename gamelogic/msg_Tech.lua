function zbWsMsgHandler.WS_Tech_Upgrade_Req(arg_1_0, arg_1_1)
	local var_1_0 = {
		TechId = arg_1_1
	}

	g_WsMsgHandler:wsPackMsg(var_1_0, MSG_ID.WS_Tech_Upgrade_Req)
end

function zbWsMsgHandler.WS_Tech_Upgrade_Ack(arg_2_0, arg_2_1)
	echoInfo("WS_Tech_Upgrade_Ack")
	g_Self.kDataChange:update(arg_2_1)
	g_Self.kTechHandler:updateTechList(arg_2_1.RetData.TechList)
	g_MainScene:showEffectUIPlayWnd(UI_EFFECT_SHENGJI_SUC)
end

function zbWsMsgHandler.WS_Tech_FastUpgrade_Req(arg_3_0, arg_3_1)
	local var_3_0 = {
		TechId = arg_3_1
	}

	g_WsMsgHandler:wsPackMsg(var_3_0, MSG_ID.WS_Tech_FastUpgrade_Req)
end

function zbWsMsgHandler.WS_Tech_FastUpgrade_Ack(arg_4_0, arg_4_1)
	echoInfo("WS_Tech_FastUpgrade_Ack")
	g_Self.kDataChange:update(arg_4_1)
	g_Self.kTechHandler:updateTechList(arg_4_1.RetData.TechList)
	g_MainScene:showEffectUIPlayWnd(UI_EFFECT_SHENGJI_SUC)
end

function zbWsMsgHandler.WS_Tech_GetData_Req(arg_5_0)
	local var_5_0 = {}

	g_WsMsgHandler:wsPackMsg(var_5_0, MSG_ID.WS_Tech_GetData_Req)
end

function zbWsMsgHandler.WS_Tech_GetData_Ack(arg_6_0, arg_6_1)
	echoInfo("WS_Tech_GetData_Ack")
	g_Self.kDataChange:update(arg_6_1)
	g_Self.kTechHandler:updateTechList(arg_6_1.RetData.TechList)
end
