function zbWsMsgHandler.WS_SyncData_HeroList_Req(arg_1_0)
	local var_1_0 = {}

	g_WsMsgHandler:wsPackMsg(var_1_0, MSG_ID.WS_SyncData_HeroList_Req)
end

function zbWsMsgHandler.WS_SyncData_HeroList_Ack(arg_2_0, arg_2_1)
	echoInfo("WS_SyncData_HeroList_Ack")
	g_Self.kHeroHandler:updateHeroList(arg_2_1.RetData.HeroList)
end

function zbWsMsgHandler.WS_HeroFrag_Compose_Req(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = {
		TemplateId = arg_3_1
	}

	g_Self.kHeroHandler.lastTemplateId = arg_3_1
	g_Self.kHeroHandler.customHideCallback = arg_3_2

	g_WsMsgHandler:wsPackMsg(var_3_0, MSG_ID.WS_HeroFrag_Compose_Req)
end

function zbWsMsgHandler.WS_HeroFrag_Compose_Ack(arg_4_0, arg_4_1)
	echoInfo("WS_HeroFrag_Compose_Ack")

	if g_Self.kHeroHandler.lastTemplateId > 0 then
		local var_4_0 = {
			Id = g_Self.kHeroHandler.lastTemplateId
		}

		var_4_0.bHave = false

		g_MainScene:showPubGetHeroWnd(var_4_0, false, false, g_Self.kHeroHandler.customHideCallback)

		g_Self.kHeroHandler.lastTemplateId = 0
	end

	g_Self.kDataChange:update(arg_4_1)
end

function zbWsMsgHandler.WS_Hero_Upgrade_Req(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = {
		HeroTid = arg_5_1,
		ItemTid = arg_5_2,
		Count = arg_5_3
	}

	g_WsMsgHandler:wsPackMsg(var_5_0, MSG_ID.WS_Hero_Upgrade_Req)
end

function zbWsMsgHandler.WS_Hero_Upgrade_Ack(arg_6_0, arg_6_1)
	echoInfo("WS_Hero_Upgrade_Ack")
	g_Self.kDataChange:update(arg_6_1)

	if arg_6_1.RetData.UpLevel > 0 then
		g_MainScene:showEffectUIPlayWnd(UI_EFFECT_SHENGJI_SUC)
	end
end

function zbWsMsgHandler.WS_Hero_UpgradeQuality_Req(arg_7_0, arg_7_1)
	local var_7_0 = {
		TemplateId = arg_7_1
	}

	g_Self.kHeroHandler.lastTemplateId = arg_7_1

	g_WsMsgHandler:wsPackMsg(var_7_0, MSG_ID.WS_Hero_UpgradeQuality_Req)
end

function zbWsMsgHandler.WS_Hero_UpgradeQuality_Ack(arg_8_0, arg_8_1)
	echoInfo("WS_Hero_UpgradeQuality_Ack")
	g_Self.kDataChange:update(arg_8_1)
	g_MainScene:showHeroStarUpWnd(EHeroDetailTab.Phase)
end

function zbWsMsgHandler.WS_Hero_UpgradeStar_Req(arg_9_0, arg_9_1)
	local var_9_0 = {
		TemplateId = arg_9_1
	}

	g_Self.kHeroHandler.lastTemplateId = arg_9_1

	g_WsMsgHandler:wsPackMsg(var_9_0, MSG_ID.WS_Hero_UpgradeStar_Req)
end

function zbWsMsgHandler.WS_Hero_UpgradeStar_Ack(arg_10_0, arg_10_1)
	echoInfo("WS_Hero_UpgradeStar_Ack")
	g_Self.kDataChange:update(arg_10_1)
	g_MainScene:showHeroStarUpWnd(EHeroDetailTab.StarUp)
end

function zbWsMsgHandler.WS_Hero_WearEquip_Req(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = {
		SrcSlot = arg_11_1,
		DstSlot = arg_11_2
	}

	g_WsMsgHandler:wsPackMsg(var_11_0, MSG_ID.WS_Hero_WearEquip_Req)
end

function zbWsMsgHandler.WS_Hero_WearEquip_Ack(arg_12_0, arg_12_1)
	echoInfo("WS_Hero_WearEquip_Ack")
	g_Self.kDataChange:update(arg_12_1)
end

function zbWsMsgHandler.WS_Hero_SwapEquip_Req(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = {
		SrcHero = arg_13_1,
		DstHero = arg_13_2
	}

	g_WsMsgHandler:wsPackMsg(var_13_0, MSG_ID.WS_Hero_SwapEquip_Req)
end

function zbWsMsgHandler.WS_Hero_SwapEquip_Ack(arg_14_0, arg_14_1)
	echoInfo("WS_Hero_SwapEquip_Ack")
	g_Self.kDataChange:update(arg_14_1)
end

function zbWsMsgHandler.WS_Hero_FastUpgradeEquip_Req(arg_15_0, arg_15_1)
	local var_15_0 = {
		TemplateId = arg_15_1
	}

	g_WsMsgHandler:wsPackMsg(var_15_0, MSG_ID.WS_Hero_FastUpgradeEquip_Req)
end

function zbWsMsgHandler.WS_Hero_FastUpgradeEquip_Ack(arg_16_0, arg_16_1)
	echoInfo("WS_Hero_FastUpgradeEquip_Ack")
	g_Self.kDataChange:update(arg_16_1)
	g_MainScene:showEffectUIPlayWnd(UI_EFFECT_SHENGJI_SUC)
end

function zbWsMsgHandler.WS_Hero_UpgradeSkill_Req(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = {
		TemplateId = arg_17_1,
		Index = arg_17_2,
		ToLevel = arg_17_3
	}

	g_WsMsgHandler:wsPackMsg(var_17_0, MSG_ID.WS_Hero_UpgradeSkill_Req)
end

function zbWsMsgHandler.WS_Hero_UpgradeSkill_Ack(arg_18_0, arg_18_1)
	echoInfo("WS_Hero_UpgradeSkill_Ack")
	g_Self.kDataChange:update(arg_18_1)
	g_MainScene:showEffectUIPlayWnd(UI_EFFECT_SHENGJI_SUC)
end

function zbWsMsgHandler.WS_Hero_Xilian_Req(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = {
		TemplateId = arg_19_1,
		Type = arg_19_2,
		Count = arg_19_3
	}

	g_WsMsgHandler:wsPackMsg(var_19_0, MSG_ID.WS_Hero_Xilian_Req)
end

function zbWsMsgHandler.WS_Hero_Xilian_Ack(arg_20_0, arg_20_1)
	echoInfo("WS_Hero_Xilian_Ack")
	g_Self.kDataChange:update(arg_20_1)
	g_MainScene:showEffectUIPlayWnd(UI_EFFECT_QIANGHUA_SUC)
end

function zbWsMsgHandler.WS_Hero_Tupo_Req(arg_21_0, arg_21_1)
	local var_21_0 = {
		TemplateId = arg_21_1
	}

	g_WsMsgHandler:wsPackMsg(var_21_0, MSG_ID.WS_Hero_Tupo_Req)
end

function zbWsMsgHandler.WS_Hero_Tupo_Ack(arg_22_0, arg_22_1)
	echoInfo("WS_Hero_Tupo_Ack")
	g_Self.kDataChange:update(arg_22_1)
	g_MainScene:showEffectUIPlayWnd(UI_EFFECT_TUPO_SUC)
end

function zbWsMsgHandler.WS_Hero_Cast_Req(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = {
		TemplateId = arg_23_1,
		Index = arg_23_2
	}

	g_WsMsgHandler:wsPackMsg(var_23_0, MSG_ID.WS_Hero_Cast_Req)
end

function zbWsMsgHandler.WS_Hero_Cast_Ack(arg_24_0, arg_24_1)
	echoInfo("WS_Hero_Cast_Ack")
	g_Self.kDataChange:update(arg_24_1)
	g_MainScene:showEffectUIPlayWnd(UI_EFFECT_ZHUZAO_SUC)
end

function zbWsMsgHandler.WS_Hero_ExchangeFate_Req(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = {
		TemplateId = arg_25_1,
		FateIdRes = arg_25_2,
		FateIdDes = arg_25_3
	}

	g_WsMsgHandler:wsPackMsg(var_25_0, MSG_ID.WS_Hero_ExchangeFate_Req)
end

function zbWsMsgHandler.WS_Hero_ExchangeFate_Ack(arg_26_0, arg_26_1)
	echoInfo("WS_Hero_ExchangeFate_Ack")
	g_Self.kDataChange:update(arg_26_1)
end

function zbWsMsgHandler.WS_Hero_PutOnPartner_Req(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = {
		Index = arg_27_1,
		HeroTemplateId = arg_27_2,
		PartnerTemplateId = arg_27_3
	}

	g_WsMsgHandler:wsPackMsg(var_27_0, MSG_ID.WS_Hero_PutOnPartner_Req)
end

function zbWsMsgHandler.WS_Hero_PutOnPartner_Ack(arg_28_0, arg_28_1)
	echoInfo("WS_Hero_PutOnPartner_Ack")
	g_Self.kDataChange:update(arg_28_1)
end

function zbWsMsgHandler.WS_Hero_PutDownPartner_Req(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = {
		Index = arg_29_1,
		HeroTemplateId = arg_29_2
	}

	g_WsMsgHandler:wsPackMsg(var_29_0, MSG_ID.WS_Hero_PutDownPartner_Req)
end

function zbWsMsgHandler.WS_Hero_PutDownPartner_Ack(arg_30_0, arg_30_1)
	echoInfo("WS_Hero_PutDownPartner_Ack")
	g_Self.kDataChange:update(arg_30_1)
end

function zbWsMsgHandler.WS_HeroComment_AddComment_Req(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = {
		HeroTemplateId = arg_31_1,
		Content = arg_31_2
	}

	g_WsMsgHandler:wsPackMsg(var_31_0, MSG_ID.WS_HeroComment_AddComment_Req)
end

function zbWsMsgHandler.WS_HeroComment_AddComment_Ack(arg_32_0, arg_32_1)
	echoInfo("WS_HeroComment_AddComment_Ack")

	if arg_32_1.RetData.Result == 1 then
		g_Self.kHeroHandler:addHeroCommentToList(arg_32_1.RetData.Comment)
		g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_HeroComment)
	end
end

function zbWsMsgHandler.WS_HeroComment_Thumb_Req(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = {
		HeroTemplateId = arg_33_1,
		UUID = arg_33_2
	}

	g_WsMsgHandler:wsPackMsg(var_33_0, MSG_ID.WS_HeroComment_Thumb_Req)
end

function zbWsMsgHandler.WS_HeroComment_Thumb_Ack(arg_34_0, arg_34_1)
	echoInfo("WS_HeroComment_Thumb_Ack")
end

function zbWsMsgHandler.WS_HeroComment_PullComment_Req(arg_35_0, arg_35_1)
	local var_35_0 = {
		HeroTemplateId = arg_35_1
	}

	var_35_0.LastRecordTm = 0

	g_WsMsgHandler:wsPackMsg(var_35_0, MSG_ID.WS_HeroComment_PullComment_Req)
end

function zbWsMsgHandler.WS_HeroComment_PullComment_Ack(arg_36_0, arg_36_1)
	echoInfo("WS_HeroComment_PullComment_Ack")
	g_Self.kHeroHandler:updateHeroCommentList(arg_36_1.RetData.CommentList)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_HeroComment)
end
