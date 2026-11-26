function zbWsMsgHandler.WS_Legion_PageList_Req(arg_1_0, arg_1_1)
	local var_1_0 = {
		Page = arg_1_1
	}

	g_WsMsgHandler:wsPackMsg(var_1_0, MSG_ID.WS_Legion_PageList_Req)
end

function zbWsMsgHandler.WS_Legion_PageList_Ack(arg_2_0, arg_2_1)
	echo("WS_Legion_PageList_Ack")
	g_Self.kLegionHandler:updateLegionListInfo(arg_2_1.RetData)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_UpdateLegionListAck)
end

function zbWsMsgHandler.WS_Legion_Search_Req(arg_3_0, arg_3_1)
	local var_3_0 = {
		LegionName = arg_3_1
	}

	g_WsMsgHandler:wsPackMsg(var_3_0, MSG_ID.WS_Legion_Search_Req)
end

function zbWsMsgHandler.WS_Legion_Search_Ack(arg_4_0, arg_4_1)
	echo("WS_Legion_Search_Ack")

	LegionSearchAckData = arg_4_1.RetData

	if LegionSearchAckData.LegionList == nil or table.getn(LegionSearchAckData.LegionList) <= 0 then
		g_Bubble:bubbleInfo(a2u("û\xD3в\xE9ѯ\xB5\xBD\xB4˻\xE1\xB9\xDD"))
	end

	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionSearchAck)
end

function zbWsMsgHandler.WS_Legion_Create_Req(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = {
		LegionName = arg_5_1,
		IconId = arg_5_2
	}

	g_WsMsgHandler:wsPackMsg(var_5_0, MSG_ID.WS_Legion_Create_Req)
end

function zbWsMsgHandler.WS_Legion_Create_Ack(arg_6_0, arg_6_1)
	echo("WS_Legion_Create_Ack")
	g_Self.kDataChange:update(arg_6_1)

	g_GameData.LegionInfo = arg_6_1.RetData.LegionInfo

	g_Self.kLegionHandler:updateLegionDetail(arg_6_1.RetData.LegionDetail)

	if g_MainScene.wndLegionNo then
		g_MainScene.wndLegionNo:hide()
	end

	g_MainScene:showLegionSceneWnd()
end

function zbWsMsgHandler.WS_Legion_Apply_Req(arg_7_0, arg_7_1)
	local var_7_0 = {
		LegionId = arg_7_1
	}

	g_WsMsgHandler:wsPackMsg(var_7_0, MSG_ID.WS_Legion_Apply_Req)
end

function zbWsMsgHandler.WS_Legion_Apply_Ack(arg_8_0, arg_8_1)
	echo("WS_Legion_Apply_Ack")

	g_GameData.LegionInfo = arg_8_1.RetData.LegionInfo

	if g_GameData.LegionInfo.LegionId == 0 then
		g_Bubble:bubbleInfo(a2u("\xC9\xEA\xC7\xEB\xD2\xD1\xCCύ"))

		return
	end

	g_Self.kLegionHandler:updateLegionDetail(arg_8_1.RetData.LegionDetail)

	if g_MainScene.wndLegionNo then
		g_MainScene.wndLegionNo:hide()
	end

	g_MainScene:showLegionSceneWnd()
end

function zbWsMsgHandler.WS_Legion_JoinQuick_Req(arg_9_0)
	local var_9_0 = {}

	g_WsMsgHandler:wsPackMsg(var_9_0, MSG_ID.WS_Legion_JoinQuick_Req)
end

function zbWsMsgHandler.WS_Legion_JoinQuick_Ack(arg_10_0, arg_10_1)
	echo("WS_Legion_JoinQuick_Ack")

	g_GameData.LegionInfo = arg_10_1.RetData.LegionInfo

	if g_GameData.LegionInfo.LegionId == 0 then
		g_Bubble:bubbleInfo(a2u("\xC9\xEA\xC7\xEB\xD2\xD1\xCCύ"))

		return
	end

	g_Self.kLegionHandler:updateLegionDetail(arg_10_1.RetData.LegionDetail)

	if g_MainScene.wndLegionNo then
		g_MainScene.wndLegionNo:hide()
	end

	g_MainScene:showLegionSceneWnd()
end

function zbWsMsgHandler.WS_Legion_ClearJoinCD_Req(arg_11_0)
	local var_11_0 = {}

	g_WsMsgHandler:wsPackMsg(var_11_0, MSG_ID.WS_Legion_ClearJoinCD_Req)
end

function zbWsMsgHandler.WS_Legion_ClearJoinCD_Ack(arg_12_0, arg_12_1)
	echo("WS_Legion_ClearJoinCD_Ack")
	g_Self.kDataChange:update(arg_12_1)

	g_GameData.LegionInfo = arg_12_1.RetData.LegionInfo
end

function zbWsMsgHandler.WS_Legion_Quit_Req(arg_13_0)
	local var_13_0 = {}

	g_WsMsgHandler:wsPackMsg(var_13_0, MSG_ID.WS_Legion_Quit_Req)
end

function zbWsMsgHandler.WS_Legion_Quit_Ack(arg_14_0, arg_14_1)
	echo("WS_Legion_Quit_Ack")

	g_GameData.LegionInfo = arg_14_1.RetData.LegionInfo

	g_Bubble:bubbleInfo(a2u("\xCD˳\xF6\xBB\xE1\xB9ݳɹ\xA6"))

	if g_MainScene.wndLegionMem then
		g_MainScene.wndLegionMem:hide()
	end

	if g_MainScene.wndLegionScene then
		g_MainScene.wndLegionScene:hide()
	end
end

function zbWsMsgHandler.WS_Legion_GetData_Req(arg_15_0)
	local var_15_0 = {}

	g_WsMsgHandler:wsPackMsg(var_15_0, MSG_ID.WS_Legion_GetData_Req)
end

function zbWsMsgHandler.WS_Legion_GetData_Ack(arg_16_0, arg_16_1)
	echo("WS_Legion_GetData_Ack")
	g_Self.kLegionHandler:updateLegionDetail(arg_16_1.RetData)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionDetailAck)
end

function zbWsMsgHandler.WS_LegionManage_Signature_Req(arg_17_0, arg_17_1)
	local var_17_0 = {
		Signature = arg_17_1
	}

	g_WsMsgHandler:wsPackMsg(var_17_0, MSG_ID.WS_LegionManage_Signature_Req)
end

function zbWsMsgHandler.WS_LegionManage_Signature_Ack(arg_18_0, arg_18_1)
	echo("WS_LegionManage_Signature_Ack")
	g_Self.kLegionHandler:updateLegionBaseInfo(arg_18_1.RetData)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionDetailAck)
end

function zbWsMsgHandler.WS_Legion_GetMembers_Req(arg_19_0)
	local var_19_0 = {}

	g_WsMsgHandler:wsPackMsg(var_19_0, MSG_ID.WS_Legion_GetMembers_Req)
end

function zbWsMsgHandler.WS_Legion_GetMembers_Ack(arg_20_0, arg_20_1)
	echo("WS_Legion_GetMembers_Ack")
	g_Self.kLegionHandler:updateLegionManagerInfo(arg_20_1.RetData.ManagerInfo)
	g_Self.kLegionHandler:updateLegionMemberDetail(arg_20_1.RetData)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionMemberDetailAck)
end

function zbWsMsgHandler.WS_Legion_GetLog_Req(arg_21_0)
	local var_21_0 = {}

	g_WsMsgHandler:wsPackMsg(var_21_0, MSG_ID.WS_Legion_GetLog_Req)
end

function zbWsMsgHandler.WS_Legion_GetLog_Ack(arg_22_0, arg_22_1)
	echo("WS_Legion_GetLog_Ack")

	LegionGetLogAckData = arg_22_1.RetData

	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionLogAck)
end

function zbWsMsgHandler.WS_Legion_GetApply_Req(arg_23_0)
	local var_23_0 = {}

	g_WsMsgHandler:wsPackMsg(var_23_0, MSG_ID.WS_Legion_GetApply_Req)
end

function zbWsMsgHandler.WS_Legion_GetApply_Ack(arg_24_0, arg_24_1)
	echo("WS_Legion_GetApply_Ack")

	LegionGetApplyAckData = arg_24_1.RetData

	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionApplyListAck)
end

function zbWsMsgHandler.WS_LegionManage_JoinSet_Req(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = {
		LimitLvl = arg_25_1,
		Confirm = arg_25_2
	}

	g_WsMsgHandler:wsPackMsg(var_25_0, MSG_ID.WS_LegionManage_JoinSet_Req)
end

function zbWsMsgHandler.WS_LegionManage_JoinSet_Ack(arg_26_0, arg_26_1)
	echo("WS_LegionManage_JoinSet_Ack")
	g_Bubble:bubbleInfo(a2u("\xD0޸ĳɹ\xA6"))
	g_Self.kLegionHandler:updateLegionBaseInfo(arg_26_1.RetData)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionLimitSetAck)
end

function zbWsMsgHandler.WS_LegionManage_ApplyPass_Req(arg_27_0, arg_27_1)
	local var_27_0 = {
		PlayerId = arg_27_1
	}

	g_WsMsgHandler:wsPackMsg(var_27_0, MSG_ID.WS_LegionManage_ApplyPass_Req)
end

function zbWsMsgHandler.WS_LegionManage_ApplyPass_Ack(arg_28_0, arg_28_1)
	echo("WS_LegionManage_ApplyPass_Ack")
	g_Self.kLegionHandler:updateLegionMemberDetail(arg_28_1.RetData)

	LegionGetApplyAckData = arg_28_1.RetData

	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionApplyListAck)
end

function zbWsMsgHandler.WS_LegionManage_ApplyRefuse_Req(arg_29_0, arg_29_1)
	local var_29_0 = {
		PlayerId = arg_29_1
	}

	g_WsMsgHandler:wsPackMsg(var_29_0, MSG_ID.WS_LegionManage_ApplyRefuse_Req)
end

function zbWsMsgHandler.WS_LegionManage_ApplyRefuse_Ack(arg_30_0, arg_30_1)
	echo("WS_LegionManage_ApplyRefuse_Ack")
	g_Self.kLegionHandler:updateLegionApplyData(arg_30_1.RetData)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionApplyListAck)
end

function zbWsMsgHandler.WS_LegionManage_Kick_Req(arg_31_0, arg_31_1)
	local var_31_0 = {
		PlayerId = arg_31_1
	}

	g_WsMsgHandler:wsPackMsg(var_31_0, MSG_ID.WS_LegionManage_Kick_Req)
end

function zbWsMsgHandler.WS_LegionManage_Kick_Ack(arg_32_0, arg_32_1)
	echo("WS_LegionManage_Kick_Ack")
	g_Self.kLegionHandler:updateLegionMemberDetail(arg_32_1.RetData)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionMemberDetailAck)
end

function zbWsMsgHandler.WS_LegionManage_OfficeSet_Req(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = {
		PlayerId = arg_33_1,
		Office = arg_33_2
	}

	g_WsMsgHandler:wsPackMsg(var_33_0, MSG_ID.WS_LegionManage_OfficeSet_Req)
end

function zbWsMsgHandler.WS_LegionManage_OfficeSet_Ack(arg_34_0, arg_34_1)
	echo("WS_LegionManage_OfficeSet_Ack")
	g_Self.kLegionHandler:updateLegionManagerInfo(arg_34_1.RetData.ManagerInfo)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionMemberDetailAck)
end

function zbWsMsgHandler.WS_Legion_GetSelfInfo_Req(arg_35_0)
	local var_35_0 = {}

	g_WsMsgHandler:wsPackMsg(var_35_0, MSG_ID.WS_Legion_GetSelfInfo_Req)
end

function zbWsMsgHandler.WS_Legion_GetSelfInfo_Ack(arg_36_0, arg_36_1)
	echo("WS_Legion_GetSelfInfo_Ack")

	g_GameData.LegionInfo = arg_36_1.RetData.LegionInfo

	if g_GameData.LegionInfo.LegionId == 0 then
		g_Bubble:bubbleInfo(a2u("\xC4㱻\xCC߳\xF6\xBB\xE1\xB9\xDD"))
		g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionTickOutAck)
	end
end

function zbWsMsgHandler.WS_LegionGame_RollingOpen_Req(arg_37_0)
	local var_37_0 = {}

	g_WsMsgHandler:wsPackMsg(var_37_0, MSG_ID.WS_LegionGame_RollingOpen_Req)
end

function zbWsMsgHandler.WS_LegionGame_RollingOpen_Ack(arg_38_0, arg_38_1)
	echo("WS_LegionGame_RollingOpen_Ack")
	g_Self.kDataChange:update(arg_38_1)
	g_Self.kLegionHandler:updateLegionRolling(arg_38_1.RetData.Rolling)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionRollingOpenAck)
end

function zbWsMsgHandler.WS_LegionGame_RollingContinue_Req(arg_39_0)
	local var_39_0 = {}

	g_WsMsgHandler:wsPackMsg(var_39_0, MSG_ID.WS_LegionGame_RollingContinue_Req)
end

function zbWsMsgHandler.WS_LegionGame_RollingContinue_Ack(arg_40_0, arg_40_1)
	echo("WS_LegionGame_RollingContinue_Ack")
	g_Self.kDataChange:update(arg_40_1)
	g_Self.kLegionHandler:updateLegionRolling(arg_40_1.RetData.Rolling)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionRollingOpenAck)
end

function zbWsMsgHandler.WS_LegionGame_RollingGain_Req(arg_41_0)
	local var_41_0 = {}

	g_WsMsgHandler:wsPackMsg(var_41_0, MSG_ID.WS_LegionGame_RollingGain_Req)
end

function zbWsMsgHandler.WS_LegionGame_RollingGain_Ack(arg_42_0, arg_42_1)
	echo("WS_LegionGame_RollingGain_Ack")
	g_Self.kDataChange:update(arg_42_1)
	g_Self.kLegionHandler:updateLegionRolling(arg_42_1.RetData.Rolling)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionLuckCatEnd)
end

function zbWsMsgHandler.WS_Legion_Donate_Req(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = {
		LegionTechId = arg_43_1,
		Type = arg_43_2
	}

	g_WsMsgHandler:wsPackMsg(var_43_0, MSG_ID.WS_Legion_Donate_Req)
end

function zbWsMsgHandler.WS_Legion_Donate_Ack(arg_44_0, arg_44_1)
	echo("WS_Legion_Donate_Ack")
	g_Self.kDataChange:update(arg_44_1)

	g_GameData.LegionInfo = arg_44_1.RetData.LegionInfo

	g_Self.kLegionHandler:updateLegionDetail(arg_44_1.RetData.LegionDetail)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionDetailAck)
end

function zbWsMsgHandler.WS_LegionGame_Welfare_Req(arg_45_0)
	local var_45_0 = {}

	g_WsMsgHandler:wsPackMsg(var_45_0, MSG_ID.WS_LegionGame_Welfare_Req)
end

function zbWsMsgHandler.WS_LegionGame_Welfare_Ack(arg_46_0, arg_46_1)
	echo("WS_LegionGame_Welfare_Ack")
	g_Self.kDataChange:update(arg_46_1)

	g_GameData.LegionInfo = arg_46_1.RetData.LegionInfo

	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionWelfare_Ack)
end

function zbWsMsgHandler.WS_LegionGame_TrainStart_Req(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	local var_47_0 = {
		Index = arg_47_1,
		TemplateId = arg_47_2,
		TrainMode = arg_47_3
	}

	g_WsMsgHandler:wsPackMsg(var_47_0, MSG_ID.WS_LegionGame_TrainStart_Req)
end

function zbWsMsgHandler.WS_LegionGame_TrainStart_Ack(arg_48_0, arg_48_1)
	echo("WS_LegionGame_TrainStart_Ack")
	g_Self.kDataChange:update(arg_48_1)
	g_Self.kLegionHandler:updateLegionTrain(arg_48_1.RetData.Train)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionTrainStart_Ack)
end

function zbWsMsgHandler.WS_LegionGame_TrainComplete_Req(arg_49_0, arg_49_1)
	local var_49_0 = {
		Index = arg_49_1
	}

	g_WsMsgHandler:wsPackMsg(var_49_0, MSG_ID.WS_LegionGame_TrainComplete_Req)
end

function zbWsMsgHandler.WS_LegionGame_TrainComplete_Ack(arg_50_0, arg_50_1)
	echo("WS_LegionGame_TrainComplete_Ack")
	g_Self.kDataChange:update(arg_50_1)
	g_Self.kLegionHandler:updateLegionTrain(arg_50_1.RetData.Train)
	g_MainScene:showEffectUIPlayWnd(UI_EFFECT_QIANGHUA_SUC)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionTrainComplete_Ack)
end

function zbWsMsgHandler.WS_LegionGame_DinnerOpen_Req(arg_51_0)
	local var_51_0 = {}

	g_WsMsgHandler:wsPackMsg(var_51_0, MSG_ID.WS_LegionGame_DinnerOpen_Req)
end

function zbWsMsgHandler.WS_LegionGame_DinnerOpen_Ack(arg_52_0, arg_52_1)
	echo("WS_LegionGame_DinnerOpen_Ack")
	g_Self.kDataChange:update(arg_52_1)
	g_Self.kLegionHandler:updateLegionDinner(arg_52_1.RetData.LegionDinner)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionGetDinner_Ack)
end

function zbWsMsgHandler.WS_LegionGame_DinnerGain_Req(arg_53_0, arg_53_1)
	local var_53_0 = {
		Type = arg_53_1
	}

	g_WsMsgHandler:wsPackMsg(var_53_0, MSG_ID.WS_LegionGame_DinnerGain_Req)
end

function zbWsMsgHandler.WS_LegionGame_DinnerGain_Ack(arg_54_0, arg_54_1)
	echo("WS_LegionGame_DinnerGain_Ack")
	g_Self.kDataChange:update(arg_54_1)
	g_Self.kLegionHandler:updateLegionDinner(arg_54_1.RetData.LegionDinner)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionGetDinner_Ack)
end

function zbWsMsgHandler.WS_LegionGame_GetDinner_Req(arg_55_0, arg_55_1)
	local var_55_0 = {}

	g_Self.kLegionHandler.showLegionDinner = arg_55_1

	g_WsMsgHandler:wsPackMsg(var_55_0, MSG_ID.WS_LegionGame_GetDinner_Req)
end

function zbWsMsgHandler.WS_LegionGame_GetDinner_Ack(arg_56_0, arg_56_1)
	echo("WS_LegionGame_GetDinner_Ack")
	g_Self.kLegionHandler:updateLegionDinner(arg_56_1.RetData.LegionDinner)

	if g_Self.kLegionHandler.showLegionDinner == true then
		g_MainScene:showLegionParty()
	end
end

function zbWsMsgHandler.WS_LegionGame_GetDinnerLog_Req(arg_57_0)
	local var_57_0 = {}

	g_WsMsgHandler:wsPackMsg(var_57_0, MSG_ID.WS_LegionGame_GetDinnerLog_Req)
end

function zbWsMsgHandler.WS_LegionGame_GetDinnerLog_Ack(arg_58_0, arg_58_1)
	echo("WS_LegionGame_GetDinnerLog_Ack")
	g_MainScene:showLegionLog(arg_58_1.RetData.LogList, ELegionPartLogType.Party)
end

function zbWsMsgHandler.WS_LegionGame_BuyBless_Req(arg_59_0, arg_59_1)
	local var_59_0 = {
		AttrType = arg_59_1
	}

	g_WsMsgHandler:wsPackMsg(var_59_0, MSG_ID.WS_LegionGame_BuyBless_Req)
end

function zbWsMsgHandler.WS_LegionGame_BuyBless_Ack(arg_60_0, arg_60_1)
	echo("WS_LegionGame_BuyBless_Ack")
	g_Self.kDataChange:update(arg_60_1)
	g_Self.kLegionHandler:updateLegionBless(arg_60_1.RetData.LegionBless)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionBless_Ack)
end

function zbWsMsgHandler.WS_LegionGame_GetBless_Req(arg_61_0)
	local var_61_0 = {}

	g_WsMsgHandler:wsPackMsg(var_61_0, MSG_ID.WS_LegionGame_GetBless_Req)
end

function zbWsMsgHandler.WS_LegionGame_GetBless_Ack(arg_62_0, arg_62_1)
	echo("WS_LegionGame_GetBless_Ack")
	g_Self.kLegionHandler:updateLegionBless(arg_62_1.RetData.LegionBless)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionBless_Ack)
end

function zbWsMsgHandler.WS_LegionGame_GetBlessLog_Req(arg_63_0)
	local var_63_0 = {}

	g_WsMsgHandler:wsPackMsg(var_63_0, MSG_ID.WS_LegionGame_GetBlessLog_Req)
end

function zbWsMsgHandler.WS_LegionGame_GetBlessLog_Ack(arg_64_0, arg_64_1)
	echo("WS_LegionGame_GetBlessLog_Ack")
	g_MainScene:showLegionLog(arg_64_1.RetData.LogList, ELegionPartLogType.Bless)
end

function zbWsMsgHandler.WS_LegionGame_SendHongbao_Req(arg_65_0, arg_65_1)
	local var_65_0 = {
		Type = arg_65_1
	}

	g_WsMsgHandler:wsPackMsg(var_65_0, MSG_ID.WS_LegionGame_SendHongbao_Req)
end

function zbWsMsgHandler.WS_LegionGame_SendHongbao_Ack(arg_66_0, arg_66_1)
	echo("WS_LegionGame_SendHongbao_Ack")
	g_Self.kDataChange:update(arg_66_1)

	g_GameData.LegionInfo = arg_66_1.RetData.LegionInfo

	g_Self.kLegionHandler:updateLegionHongbao(arg_66_1.RetData.LegionHongbao)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionHongbao_Ack)
end

function zbWsMsgHandler.WS_LegionGame_GainHongbao_Req(arg_67_0, arg_67_1)
	local var_67_0 = {
		UUID = arg_67_1
	}

	g_WsMsgHandler:wsPackMsg(var_67_0, MSG_ID.WS_LegionGame_GainHongbao_Req)
end

function zbWsMsgHandler.WS_LegionGame_GainHongbao_Ack(arg_68_0, arg_68_1)
	echo("WS_LegionGame_GainHongbao_Ack")
	g_Self.kDataChange:update(arg_68_1)

	g_GameData.LegionInfo = arg_68_1.RetData.LegionInfo

	g_Self.kLegionHandler:updateLegionHongbaoDetail(arg_68_1.RetData.HongbaoDetail)
	g_Self.kLegionHandler:updateLegionHongbaoLogList(arg_68_1.RetData.LogList)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionHongbao_Ack)
end

function zbWsMsgHandler.WS_LegionGame_GetHongbao_Req(arg_69_0)
	local var_69_0 = {}

	g_WsMsgHandler:wsPackMsg(var_69_0, MSG_ID.WS_LegionGame_GetHongbao_Req)
end

function zbWsMsgHandler.WS_LegionGame_GetHongbao_Ack(arg_70_0, arg_70_1)
	echo("WS_LegionGame_GetHongbao_Ack")
	g_Self.kLegionHandler:updateLegionHongbao(arg_70_1.RetData.LegionHongbao)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionHongbao_Ack)
end

function zbWsMsgHandler.WS_LegionBoss_GetInfo_Req(arg_71_0)
	local var_71_0 = {}

	g_WsMsgHandler:wsPackMsg(var_71_0, MSG_ID.WS_LegionBoss_GetInfo_Req)
end

function zbWsMsgHandler.WS_LegionBoss_GetInfo_Ack(arg_72_0, arg_72_1)
	echo("WS_LegionBoss_GetInfo_Ack")
	g_Self.kLegionHandler:updateLegionBossInfo(arg_72_1.RetData)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionBoss_GetInfo_Ack)
end

function zbWsMsgHandler.WS_LegionBoss_GetHurtRank_Req(arg_73_0, arg_73_1)
	local var_73_0 = {
		BossId = arg_73_1
	}

	g_WsMsgHandler:wsPackMsg(var_73_0, MSG_ID.WS_LegionBoss_GetHurtRank_Req)
end

function zbWsMsgHandler.WS_LegionBoss_GetHurtRank_Ack(arg_74_0, arg_74_1)
	echo("WS_LegionBoss_GetHurtRank_Ack")

	g_Self.kLegionHandler.legionBossDamageRank = arg_74_1.RetData

	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionBossDamageRank_Ack)
end

function zbWsMsgHandler.WS_LegionBoss_BuyBuff_Req(arg_75_0, arg_75_1)
	local var_75_0 = {
		BuffId = arg_75_1
	}

	g_WsMsgHandler:wsPackMsg(var_75_0, MSG_ID.WS_LegionBoss_BuyBuff_Req)
end

function zbWsMsgHandler.WS_LegionBoss_BuyBuff_Ack(arg_76_0, arg_76_1)
	echo("WS_LegionBoss_BuyBuff_Ack")
	g_Self.kWealthHandler:updateWealth(arg_76_1.RetData.Wealth)

	if g_GameData.LegionInfo then
		g_GameData.LegionInfo.LegionBoss = arg_76_1.RetData.BaseInfo
	end

	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionBossBuff_Ack)
end

function zbWsMsgHandler.WS_LegionBoss_GetAward_Req(arg_77_0, arg_77_1)
	local var_77_0 = {
		BossId = arg_77_1
	}

	g_WsMsgHandler:wsPackMsg(var_77_0, MSG_ID.WS_LegionBoss_GetAward_Req)
end

function zbWsMsgHandler.WS_LegionBoss_GetAward_Ack(arg_78_0, arg_78_1)
	echo("WS_LegionBoss_GetAward_Ack")
	g_Self.kDataChange:update(arg_78_1)

	if g_GameData.LegionInfo then
		g_GameData.LegionInfo.LegionBoss = arg_78_1.RetData.BaseInfo
	end

	g_Self.kLegionHandler:updateLegionBossInfoById(arg_78_1.RetData.BossInfo)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionBoss_GetInfo_Ack)
end

function zbWsMsgHandler.WS_LegionBoss_StartFight_Req(arg_79_0, arg_79_1)
	local var_79_0 = {
		BossId = arg_79_1
	}

	g_WsMsgHandler:wsPackMsg(var_79_0, MSG_ID.WS_LegionBoss_StartFight_Req)
end

function zbWsMsgHandler.WS_LegionBoss_StartFight_Ack(arg_80_0, arg_80_1)
	echoInfo("WS_LegionBoss_StartFight_Ack")

	if g_CombatSystem:isFighting() then
		return
	end

	if arg_80_1.RetData.BattleInfo and zbUtil:fightReqAckSign(arg_80_1.RetData.BattleInfo) ~= arg_80_1.RetData.BattleInfo.Sign then
		g_Bubble:bubbleInfo(a2u("ս\xB6\xB7\xCA\xFD\xBE\xDDУ\xD1\xE9ʧ\xB0\xDC"))

		return
	end

	g_CombatSystem:startLegionBossBattle(arg_80_1.RetData)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionBossFight_Ack)
end

function zbWsMsgHandler.WS_LegionBoss_FightResult_Req(arg_81_0, arg_81_1, arg_81_2, arg_81_3)
	local var_81_0 = {
		RandomSeed = arg_81_1,
		Energy = g_CombatSystem:getLegendEnergy(),
		HpPercent = arg_81_2,
		HurtHp = arg_81_3,
		BossId = g_Self.kLegionHandler.fightBossInfo.BossId
	}

	g_Self.kLegionHandler.legionbossHit = arg_81_3
	var_81_0.Sign = zbUtil:fightResultReqSign(var_81_0)

	g_WsMsgHandler:wsPackMsg(var_81_0, MSG_ID.WS_LegionBoss_FightResult_Req)
end

function zbWsMsgHandler.WS_LegionBoss_FightResult_Ack(arg_82_0, arg_82_1)
	echoInfo("WS_LegionBoss_FightResult_Ack")
	g_Self.kDataChange:update(arg_82_1)
	g_CombatSystem.combatData:setBalanceAwards(arg_82_1.RetData, EBattleResult.Win1, arg_82_1.RetData.AwardList)
	g_Self.kLegionHandler:updateLegionBossInfo(arg_82_1.RetData)

	if g_GameData.LegionInfo then
		g_GameData.LegionInfo.LegionBoss = arg_82_1.RetData.BaseInfo
	end

	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionBossFightResultSyn_Ack)
end
