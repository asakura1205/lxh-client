function zbWsMsgHandler.WS_Bag_GemCompose_Req(arg_1_0, arg_1_1)
	local var_1_0 = {
		ItemList = arg_1_1
	}

	g_WsMsgHandler:wsPackMsg(var_1_0, MSG_ID.WS_Bag_GemCompose_Req)
end

function zbWsMsgHandler.WS_Bag_GemCompose_Ack(arg_2_0, arg_2_1)
	echoInfo("WS_Bag_GemCompose_Ack")

	g_AwardShowDelayTime = 2
	BagGemComposeAckData = arg_2_1.RetData

	g_Self.kDataChange:update(arg_2_1)
	g_MainScene:showEffectUIPlayWnd(UI_EFFECT_RONGLIAN_SUC)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_GemsDecomposeSuccess)

	g_AwardShowDelayTime = 0
end

function zbWsMsgHandler.WS_Equip_Decompose_Req(arg_3_0, arg_3_1)
	local var_3_0 = {}
	local var_3_1 = {}
	local var_3_2 = {}

	for iter_3_0, iter_3_1 in pairs(arg_3_1) do
		local var_3_3 = {}

		if iter_3_1.isFrag then
			var_3_3[1] = iter_3_1.equip.TemplateId
			var_3_3[2] = iter_3_1.count

			table.insert(var_3_2, var_3_3)
		else
			table.insert(var_3_1, iter_3_1.equip.EquipId)
		end
	end

	var_3_0.EquipList = var_3_1
	var_3_0.FragList = var_3_2

	g_WsMsgHandler:wsPackMsg(var_3_0, MSG_ID.WS_Equip_Decompose_Req)
end

function zbWsMsgHandler.WS_Equip_Decompose_Ack(arg_4_0, arg_4_1)
	echoInfo("WS_Equip_Decompose_Ack")

	g_AwardShowDelayTime = 2
	EquipDecomposeAckData = arg_4_1.RetData

	g_Self.kDataChange:update(arg_4_1)
	g_MainScene:showEffectUIPlayWnd(UI_EFFECT_RONGLIAN_SUC)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_EquipDecomposeSuccess)

	g_AwardShowDelayTime = 0
end

function zbWsMsgHandler.WS_HeroFrag_Decompose_Req(arg_5_0, arg_5_1)
	local var_5_0 = {
		FragList = {}
	}

	for iter_5_0, iter_5_1 in pairs(arg_5_1) do
		local var_5_1 = {}

		table.insert(var_5_1, iter_5_1.heroDesc.heroTemplateId)
		table.insert(var_5_1, iter_5_1.count)
		table.insert(var_5_0.FragList, var_5_1)
	end

	g_WsMsgHandler:wsPackMsg(var_5_0, MSG_ID.WS_HeroFrag_Decompose_Req)
end

function zbWsMsgHandler.WS_HeroFrag_Decompose_Ack(arg_6_0, arg_6_1)
	echoInfo("WS_HeroFrag_Decompose_Ack")

	g_AwardShowDelayTime = 2
	HeroFragDecomposeAckData = arg_6_1.RetData

	g_Self.kDataChange:update(arg_6_1)
	g_MainScene:showEffectUIPlayWnd(UI_EFFECT_RONGLIAN_SUC)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_HeroDecomposeSuccess)

	g_AwardShowDelayTime = 0
end

function zbWsMsgHandler.WS_Hero_CalcReset_Req(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = {
		TemplateId = arg_7_1,
		Diamond = arg_7_2
	}

	g_WsMsgHandler:wsPackMsg(var_7_0, MSG_ID.WS_Hero_CalcReset_Req)
end

function zbWsMsgHandler.WS_Hero_CalcReset_Ack(arg_8_0, arg_8_1)
	echoInfo("WS_Hero_CalcReset_Ack")

	if zbUtil:isValidTable(arg_8_1.RetData.AwardList) == false then
		echo("warning: invalid awardList")

		return
	end

	if g_MainScene.wndHeroReset ~= nil then
		g_MainScene.wndHeroReset:refreshResetItems(arg_8_1.RetData.AwardList)
	end
end

function zbWsMsgHandler.WS_Hero_ConfirmReset_Req(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = {
		TemplateId = arg_9_1,
		Diamond = arg_9_2
	}

	g_WsMsgHandler:wsPackMsg(var_9_0, MSG_ID.WS_Hero_ConfirmReset_Req)
end

function zbWsMsgHandler.WS_Hero_ConfirmReset_Ack(arg_10_0, arg_10_1)
	echoInfo("WS_Hero_ConfirmReset_Ack")
	g_Self.kDataChange:update(arg_10_1)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_HeroResetSuccess)
end
