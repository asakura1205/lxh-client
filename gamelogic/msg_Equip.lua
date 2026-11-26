function zbWsMsgHandler.WS_Equip_Upgrade_Req(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = {
		SrcSlot = arg_1_1,
		ToLevel = arg_1_2
	}

	g_WsMsgHandler:wsPackMsg(var_1_0, MSG_ID.WS_Equip_Upgrade_Req)
end

function zbWsMsgHandler.WS_Equip_Upgrade_Ack(arg_2_0, arg_2_1)
	echoInfo("WS_Equip_Upgrade_Ack")
	g_Self.kDataChange:update(arg_2_1)
	g_MainScene:showEffectUIPlayWnd(UI_EFFECT_SHENGJI_SUC)
end

function zbWsMsgHandler.WS_Equip_Cuilian_Req(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = {
		ItemTid = arg_3_2,
		Count = arg_3_3,
		SrcSlot = arg_3_1
	}

	g_WsMsgHandler:wsPackMsg(var_3_0, MSG_ID.WS_Equip_Cuilian_Req)
end

function zbWsMsgHandler.WS_Equip_Cuilian_Ack(arg_4_0, arg_4_1)
	echoInfo("WS_Equip_Cuilian_Ack")

	g_AwardShowDelayTime = 2

	g_Self.kDataChange:update(arg_4_1)
	g_MainScene:showEffectUIPlayWnd(UI_EFFECT_CUILIAN_SUC)

	g_AwardShowDelayTime = 0
end

function zbWsMsgHandler.WS_Equip_Compose_Req(arg_5_0, arg_5_1)
	local var_5_0 = {
		TemplateId = arg_5_1
	}

	g_WsMsgHandler:wsPackMsg(var_5_0, MSG_ID.WS_Equip_Compose_Req)
end

function zbWsMsgHandler.WS_Equip_Compose_Ack(arg_6_0, arg_6_1)
	echoInfo("WS_Equip_Cuilian_Ack")
	g_Self.kDataChange:update(arg_6_1)
end

function zbWsMsgHandler.WS_Equip_OpenHole_Req(arg_7_0, arg_7_1)
	local var_7_0 = {
		SrcSlot = arg_7_1
	}

	g_WsMsgHandler:wsPackMsg(var_7_0, MSG_ID.WS_Equip_OpenHole_Req)
end

function zbWsMsgHandler.WS_Equip_OpenHole_Ack(arg_8_0, arg_8_1)
	echoInfo("WS_Equip_OpenHole_Ack")
	g_Self.kDataChange:update(arg_8_1)
	g_MainScene:showEffectUIPlayWnd(UI_EFFECT_JIEYIN_SUC)
end

function zbWsMsgHandler.WS_Equip_RefreshHole_Req(arg_9_0, arg_9_1)
	local var_9_0 = {
		SrcSlot = arg_9_1
	}

	g_WsMsgHandler:wsPackMsg(var_9_0, MSG_ID.WS_Equip_RefreshHole_Req)
end

function zbWsMsgHandler.WS_Equip_RefreshHole_Ack(arg_10_0, arg_10_1)
	echoInfo("WS_Equip_RefreshHole_Ack")
	g_Self.kDataChange:update(arg_10_1)
end

function zbWsMsgHandler.WS_Equip_GemSet_Req(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = {
		SrcSlot = arg_11_1,
		Index = arg_11_2,
		GemTid = arg_11_3
	}

	g_WsMsgHandler:wsPackMsg(var_11_0, MSG_ID.WS_Equip_GemSet_Req)
end

function zbWsMsgHandler.WS_Equip_GemSet_Ack(arg_12_0, arg_12_1)
	echoInfo("WS_Equip_GemSet_Ack")
	g_Self.kDataChange:update(arg_12_1)
	g_MainScene:showEffectUIPlayWnd(UI_EFFECT_FULING_SUC)
end

function zbWsMsgHandler.WS_Equip_GemRemove_Req(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = {
		SrcSlot = arg_13_1,
		Index = arg_13_2
	}

	g_WsMsgHandler:wsPackMsg(var_13_0, MSG_ID.WS_Equip_GemRemove_Req)
end

function zbWsMsgHandler.WS_Equip_GemRemove_Ack(arg_14_0, arg_14_1)
	echoInfo("WS_Equip_GemRemove_Ack")
	g_Self.kDataChange:update(arg_14_1)
end

function zbWsMsgHandler.WS_Equip_UpStar_Req(arg_15_0, arg_15_1)
	local var_15_0 = {
		SrcSlot = arg_15_1
	}

	g_WsMsgHandler:wsPackMsg(var_15_0, MSG_ID.WS_Equip_UpStar_Req)
end

function zbWsMsgHandler.WS_Equip_UpStar_Ack(arg_16_0, arg_16_1)
	echoInfo("WS_Equip_UpStar_Ack")
	g_Self.kDataChange:update(arg_16_1)

	if arg_16_1.RetData.Result == 1 then
		g_Bubble:bubbleInfo(a2u("\xC9\xFD\xD0ǳɹ\xA6"))
	end
end
