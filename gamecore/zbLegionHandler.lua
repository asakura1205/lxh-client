local var_0_0 = class("zbLegionHandler")

var_0_0.__index = var_0_0

function createLegionHandler()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	arg_2_0.curPage = 1
	arg_2_0.PageCountMax = 1
	arg_2_0.legionListData = nil
	arg_2_0.bLegionMemBaseFormationInfoReq = false
	arg_2_0.selIconId = 1011
	arg_2_0.legionDetail = nil
	arg_2_0.legionMemberDetail = nil
	arg_2_0.hasNotify = false
	arg_2_0.legionBossDamageRank = nil
	arg_2_0.fightBossInfo = nil
	arg_2_0.legionHongbaoLogList = nil
	arg_2_0.legionbossHit = 0
	arg_2_0.showLegionDinner = false
	arg_2_0.legionWarBaseInfo = g_GameData.LegionWarBaseInfo
	arg_2_0.legionWarNodeList = {}
end

function var_0_0.update(arg_3_0)
	if g_GameStateMachine:isOneSecondPassed() == false then
		return
	end

	arg_3_0.hasNotify = false

	if zbFunHelper:isBuildingLockNoTip(EBuildingType.Legion) then
		arg_3_0.hasNotify = false
	elseif arg_3_0:hasNotifyTrain() or arg_3_0:hasNotifyRolling() or arg_3_0:hasNotifyWelfare() or arg_3_0:hasNotifyHongbao() or arg_3_0:hasBossFight() or arg_3_0:hasBossAwardGet() then
		arg_3_0.hasNotify = true
	end

	g_Self.kRedPointHandler:refreshLegion()
end

function var_0_0.hasBossFight(arg_4_0)
	if g_GameData.LegionInfo then
		local var_4_0 = g_GameData.LegionInfo.LegionBoss

		if var_4_0 and var_4_0.FightMax <= var_4_0.FightCount then
			return false
		end
	end

	if arg_4_0.legionDetail and zbUtil:isValidTable(arg_4_0.legionDetail.BossInfoList) then
		for iter_4_0, iter_4_1 in pairs(arg_4_0.legionDetail.BossInfoList) do
			if iter_4_1.State == ELegionBossState.Fighting then
				return true
			end
		end
	end

	return false
end

function var_0_0.hasBossAwardGet(arg_5_0)
	if arg_5_0.legionDetail and zbUtil:isValidTable(arg_5_0.legionDetail.BossInfoList) then
		for iter_5_0, iter_5_1 in pairs(arg_5_0.legionDetail.BossInfoList) do
			if iter_5_1.State == ELegionBossState.PassNotGetAward then
				return true
			end
		end
	end

	return false
end

function var_0_0.hasNotifyTrain(arg_6_0)
	if arg_6_0.legionDetail then
		local var_6_0 = arg_6_0.legionDetail.Train

		if zbUtil:isValidTable(var_6_0) then
			for iter_6_0, iter_6_1 in pairs(var_6_0) do
				if iter_6_1.EndTm ~= nil and iter_6_1.State == ELegionTrainState.Train and iter_6_1.EndTm - g_Self.kTimeHandler:getServerTime() <= 0 then
					return true
				end
			end
		end
	end

	return false
end

function var_0_0.hasNotifyRolling(arg_7_0)
	if arg_7_0.legionDetail then
		local var_7_0 = arg_7_0.legionDetail.Rolling
		local var_7_1 = ELegionTechType.Treasure
		local var_7_2 = zbLegionTechTable:getRecord(var_7_1)

		if var_7_2 and (zbLegionTechUpgradeTable:getlimitByIdAndLv(var_7_2.upgradeId, arg_7_0:getTechLevel(ELegionTechType.Treasure)) > var_7_0.OpenCount or var_7_0.State == 1) then
			return true
		end
	end

	return false
end

function var_0_0.hasNotifyWelfare(arg_8_0)
	if g_GameData.LegionInfo and g_GameData.LegionInfo.Welfare == 0 and arg_8_0.legionDetail and arg_8_0.legionDetail.LegionBaseInfo.Level >= zbLegionTechTable:getUnlocak(ELegionTechType.LegionWelfare) then
		return true
	end

	return false
end

function var_0_0.hasNotifyHongbao(arg_9_0)
	if g_GameData.LegionInfo and g_GameData.LegionInfo.Hongbao and arg_9_0.legionDetail then
		for iter_9_0, iter_9_1 in pairs(arg_9_0.legionDetail.LegionHongbao) do
			if g_GameData.LegionInfo.Hongbao.GainCount < g_GameData.LegionInfo.Hongbao.GainMax and iter_9_1.State == 0 and iter_9_1.LeftCount > 0 then
				return true
			end
		end
	end

	return false
end

function var_0_0.getLegionName(arg_10_0)
	if arg_10_0.legionDetail then
		return arg_10_0.legionDetail.LegionBaseInfo.LegionName
	end

	return a2u("\xBF\xD5")
end

function var_0_0.updateLegionListInfo(arg_11_0, arg_11_1)
	if arg_11_1 then
		arg_11_0.legionListData = arg_11_1

		local function var_11_0(arg_12_0, arg_12_1)
			return arg_12_0.Rank < arg_12_1.Rank
		end

		table.sort(arg_11_0.legionListData.LegionList, var_11_0)

		arg_11_0.curPage = arg_11_1.Page
		arg_11_0.PageCountMax = math.ceil(arg_11_1.LegionCount / arg_11_1.PageSize)
	end
end

function var_0_0.getLegionList(arg_13_0, arg_13_1)
	local var_13_0 = {}

	if arg_13_0.legionListData then
		var_13_0 = arg_13_0.legionListData.LegionList
	end

	return var_13_0
end

function var_0_0.updateLegionWarBase(arg_14_0, arg_14_1)
	if arg_14_1.LegionWarBaseInfo then
		arg_14_0.legionWarBaseInfo = arg_14_1.LegionWarBaseInfo
	end
end

function var_0_0.updateLegionWarNode(arg_15_0, arg_15_1)
	if arg_15_1.LegionWarNodeList then
		arg_15_0.legionWarNodeList = arg_15_1.LegionWarNodeList
	end
end

function var_0_0.updateLegionWarNodeInfo(arg_16_0, arg_16_1)
	if zbUtil:isValidTable(arg_16_1) == false then
		echo("warning: invalid legionWarNodeInfo")

		return
	end

	for iter_16_0, iter_16_1 in pairs(arg_16_0.legionWarNodeList) do
		if iter_16_1.NodeId == arg_16_1.NodeId then
			table.remove(arg_16_0.legionWarNodeList, iter_16_0)
			table.insert(arg_16_0.legionWarNodeList, arg_16_1)
			g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_LegionWarNodeInfo)

			return
		end
	end

	echo("warning: no match exist legionWarNodeInfo")
end

function var_0_0.updateLegionDetail(arg_17_0, arg_17_1)
	arg_17_0.legionDetail = arg_17_1
end

function var_0_0.updateLegionBaseInfo(arg_18_0, arg_18_1)
	if arg_18_0.legionDetail then
		arg_18_0.legionDetail.LegionBaseInfo = arg_18_1
	end
end

function var_0_0.updateLegionManagerInfo(arg_19_0, arg_19_1)
	if arg_19_0.legionDetail and arg_19_1 then
		arg_19_0.legionDetail.ManagerInfo = arg_19_1
	end
end

function var_0_0.updateLegionRolling(arg_20_0, arg_20_1)
	if arg_20_0.legionDetail and arg_20_1 then
		arg_20_0.legionDetail.Rolling = arg_20_1
	end
end

function var_0_0.updateLegionTrain(arg_21_0, arg_21_1)
	if arg_21_0.legionDetail and arg_21_1 then
		arg_21_0.legionDetail.Train = arg_21_1
	end
end

function var_0_0.updateLegionDinner(arg_22_0, arg_22_1)
	if arg_22_0.legionDetail and arg_22_1 then
		arg_22_0.legionDetail.LegionDinner = arg_22_1
	end
end

function var_0_0.updateLegionMemberDetail(arg_23_0, arg_23_1)
	arg_23_0.legionMemberDetail = arg_23_1
end

function var_0_0.updateLegionApplyData(arg_24_0, arg_24_1)
	if LegionGetApplyAckData then
		if arg_24_1 == 0 then
			LegionGetApplyAckData = nil
		else
			for iter_24_0, iter_24_1 in pairs(LegionGetApplyAckData.LegionApply) do
				if iter_24_1.PlayerId == arg_24_1 then
					table.remove(LegionGetApplyAckData.LegionApply, iter_24_0)

					return
				end
			end
		end
	end
end

function var_0_0.updateLegionBless(arg_25_0, arg_25_1)
	if arg_25_0.legionDetail and arg_25_1 then
		arg_25_0.legionDetail.LegionBless = arg_25_1
	end
end

function var_0_0.updateLegionHongbao(arg_26_0, arg_26_1)
	if arg_26_0.legionDetail and arg_26_1 then
		arg_26_0.legionDetail.LegionHongbao = arg_26_1
	end
end

function var_0_0.updateLegionHongbaoDetail(arg_27_0, arg_27_1)
	if arg_27_0.legionDetail and arg_27_0.legionDetail.LegionHongbao and arg_27_1 then
		for iter_27_0, iter_27_1 in pairs(arg_27_0.legionDetail.LegionHongbao) do
			if iter_27_1.UUID == arg_27_1.UUID then
				table.remove(arg_27_0.legionDetail.LegionHongbao, iter_27_0)
				table.insert(arg_27_0.legionDetail.LegionHongbao, arg_27_1)
				g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionHongbao_Ack)

				return
			end
		end
	end
end

function var_0_0.updateLegionHongbaoLogList(arg_28_0, arg_28_1)
	arg_28_0.legionHongbaoLogList = arg_28_1

	g_GameEventMgr:sendEvent(zbGameEvent.Event_LegionHongbaoLogListAck)
end

function var_0_0.updateLegionBossInfoAndBase(arg_29_0, arg_29_1)
	if arg_29_0.legionDetail then
		arg_29_0.legionDetail.BossInfoList = arg_29_1.BossInfoList
	end

	if g_GameData.LegionInfo then
		g_GameData.LegionInfo.LegionBoss = arg_29_1.BaseInfo
	end
end

function var_0_0.updateLegionBossInfo(arg_30_0, arg_30_1)
	if arg_30_0.legionDetail then
		arg_30_0.legionDetail.BossInfoList = arg_30_1.BossInfoList
	end
end

function var_0_0.updateLegionBossInfoById(arg_31_0, arg_31_1)
	if arg_31_0.legionDetail and zbUtil:isValidTable(arg_31_0.legionDetail.BossInfoList) then
		for iter_31_0, iter_31_1 in pairs(arg_31_0.legionDetail.BossInfoList) do
			if arg_31_1.BossId == iter_31_1.BossId then
				echo("......bossInfo...", arg_31_1.State)

				arg_31_0.legionDetail.BossInfoList[iter_31_0] = arg_31_1

				return
			end
		end
	end
end

function var_0_0.getLegionBossInfoById(arg_32_0, arg_32_1)
	if arg_32_0.legionDetail and zbUtil:isValidTable(arg_32_0.legionDetail.BossInfoList) then
		for iter_32_0, iter_32_1 in pairs(arg_32_0.legionDetail.BossInfoList) do
			if arg_32_1 == iter_32_1.BossId then
				return iter_32_1
			end
		end
	end

	return nil
end

function var_0_0.getFightingLegionBoss(arg_33_0)
	if arg_33_0.legionDetail and zbUtil:isValidTable(arg_33_0.legionDetail.BossInfoList) then
		for iter_33_0, iter_33_1 in pairs(arg_33_0.legionDetail.BossInfoList) do
			if ELegionBossState.Fighting == iter_33_1.State then
				return iter_33_1
			end
		end
	end

	return nil
end

function var_0_0.getTechExp(arg_34_0, arg_34_1)
	if arg_34_0.legionDetail then
		for iter_34_0, iter_34_1 in pairs(arg_34_0.legionDetail.LegionTech) do
			if iter_34_1.LegionTechId == arg_34_1 then
				return iter_34_1.Exp
			end
		end
	end

	return 0
end

function var_0_0.getTechLevel(arg_35_0, arg_35_1)
	if arg_35_0.legionDetail then
		for iter_35_0, iter_35_1 in pairs(arg_35_0.legionDetail.LegionTech) do
			if iter_35_1.LegionTechId == arg_35_1 then
				return iter_35_1.Level
			end
		end
	end

	return 1
end

function var_0_0.getOfficeById(arg_36_0, arg_36_1)
	if arg_36_0.legionDetail and arg_36_0.legionDetail.ManagerInfo then
		local var_36_0 = arg_36_0.legionDetail.ManagerInfo

		if arg_36_1 == var_36_0.LeaderId then
			return ELegionOffice.Leader
		end

		for iter_36_0, iter_36_1 in pairs(var_36_0.Adviser) do
			if iter_36_1 == arg_36_1 then
				return ELegionOffice.Adviser
			end
		end
	end

	return ELegionOffice.Member
end

function var_0_0.getDonateValue(arg_37_0, arg_37_1)
	if arg_37_0.legionMemberDetail then
		for iter_37_0, iter_37_1 in pairs(arg_37_0.legionMemberDetail.MemberList) do
			if iter_37_1.PlayerBaseInfo.PlayerId == arg_37_1 then
				return iter_37_1.MemberBaseInfo.Donate
			end
		end
	end

	return 0
end

function var_0_0.getMemberData(arg_38_0, arg_38_1)
	if arg_38_0.legionMemberDetail then
		for iter_38_0, iter_38_1 in pairs(arg_38_0.legionMemberDetail.MemberList) do
			if iter_38_1.PlayerBaseInfo.PlayerId == arg_38_1 then
				return iter_38_1
			end
		end
	end

	return nil
end

function var_0_0.getApplyNodeList(arg_39_0)
	local var_39_0 = {}

	if arg_39_0.legionWarNodeList then
		for iter_39_0, iter_39_1 in pairs(arg_39_0.legionWarNodeList) do
			if arg_39_0:isHoldNodeByNodeId(iter_39_1.NodeId) == false then
				table.insert(var_39_0, iter_39_1)
			end
		end
	end

	local function var_39_1(arg_40_0, arg_40_1)
		local var_40_0 = g_Self.kWorldHandler:isNodeOpenById(arg_40_0.NodeId)
		local var_40_1 = g_Self.kWorldHandler:isNodeOpenById(arg_40_1.NodeId)

		if var_40_0 and var_40_1 then
			return arg_40_0.NodeState < arg_40_1.NodeState
		elseif var_40_0 == true and var_40_1 == false then
			return true
		elseif var_40_0 == false and var_40_1 == true then
			return false
		else
			return arg_40_0.NodeId < arg_40_1.NodeId
		end
	end

	table.sort(var_39_0, var_39_1)

	return var_39_0
end

function var_0_0.isHoldNodeByNodeId(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0:getHoldNodeList()

	for iter_41_0, iter_41_1 in pairs(var_41_0) do
		if arg_41_1 and iter_41_1.NodeId == arg_41_1 then
			return true
		end
	end

	return false
end

function var_0_0.getHoldNodeList(arg_42_0)
	local var_42_0 = {}
	local var_42_1 = {}

	if arg_42_0.legionWarNodeList then
		for iter_42_0, iter_42_1 in pairs(arg_42_0.legionWarNodeList) do
			if g_GameData.LegionInfo and iter_42_1.Legion and g_GameData.LegionInfo.LegionId == iter_42_1.Legion.LegionId then
				table.insert(var_42_0, iter_42_1)
			else
				table.insert(var_42_1, iter_42_1)
			end
		end
	end

	local function var_42_2(arg_43_0, arg_43_1)
		local var_43_0 = arg_43_0.NodeState == ELegionWarNodeState.AlreadyApply
		local var_43_1 = arg_43_1.NodeState == ELegionWarNodeState.AlreadyApply

		if var_43_0 and var_43_1 then
			return arg_43_0.NodeId < arg_43_1.NodeId
		elseif var_43_0 == true and var_43_1 == false then
			return true
		elseif var_43_0 == false and var_43_1 == true then
			return false
		else
			return arg_43_0.NodeId < arg_43_1.NodeId
		end
	end

	table.sort(var_42_1, var_42_2)

	return var_42_0, var_42_1
end

function var_0_0.getDenfendbyNodeId(arg_44_0, arg_44_1)
	local var_44_0 = 0
	local var_44_1 = 0

	for iter_44_0, iter_44_1 in pairs(arg_44_0.legionWarNodeList) do
		if iter_44_1.NodeId == arg_44_1 then
			for iter_44_2, iter_44_3 in pairs(iter_44_1.BuildList) do
				var_44_1 = var_44_1 + table.getn(iter_44_3.DefendList)

				for iter_44_4, iter_44_5 in pairs(iter_44_3.DefendList) do
					if iter_44_5 ~= 0 then
						var_44_0 = var_44_0 + 1
					end
				end
			end
		end
	end

	return var_44_0, var_44_1
end

function var_0_0.getNodeInfobyId(arg_45_0, arg_45_1)
	for iter_45_0, iter_45_1 in pairs(arg_45_0.legionWarNodeList) do
		if iter_45_1.NodeId == arg_45_1 then
			return iter_45_1
		end
	end

	return nil
end

function var_0_0.isNodeCanFight(arg_46_0, arg_46_1)
	local var_46_0 = false

	for iter_46_0, iter_46_1 in pairs(arg_46_0.legionWarNodeList) do
		if arg_46_1 == iter_46_1.NodeId then
			for iter_46_2, iter_46_3 in pairs(iter_46_1.AttackLegion) do
				if g_GameData.LegionInfo.LegionId == iter_46_3 then
					var_46_0 = true

					break
				end
			end

			if var_46_0 then
				break
			end
		end
	end

	return var_46_0
end
