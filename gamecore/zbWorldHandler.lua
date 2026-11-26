local var_0_0 = class("zbWorldHandler")

var_0_0.__index = var_0_0

function createWorldHandler()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	arg_2_0.worldInfo = nil
	arg_2_0.openGridList = {}
	arg_2_0.bworldHorseBaseFormationInfoReq = false
	arg_2_0.needRefreshOpenDlg = false
	arg_2_0.worldLogList = nil
	arg_2_0.changeNodeId = 0
	arg_2_0.worldhasNotify = false
	arg_2_0.combatSeceneId = 0
	arg_2_0.fightResNodeId = 0
	arg_2_0.worldBossInfo = nil
	arg_2_0.worldBossSelfInfo = nil
	arg_2_0.worldBossBuffList = {}
	arg_2_0.worldbossHit = 0
end

function var_0_0.update(arg_3_0)
	if g_GameStateMachine:isOneSecondPassed() == false then
		return
	end

	arg_3_0.worldhasNotify = false

	if zbFunHelper:isBuildingLockNoTip(EBuildingType.World) then
		arg_3_0.worldhasNotify = false
	elseif arg_3_0:hasNewNodeCanOpen() or arg_3_0:hasNotiFyResNode() or arg_3_0:hasNotiFyTaskNode() then
		arg_3_0.worldhasNotify = true
	end

	g_Self.kRedPointHandler:refreshWorld()
end

function var_0_0.nodeCanOpen(arg_4_0, arg_4_1, arg_4_2)
	return arg_4_1 <= arg_4_2
end

function var_0_0.hasNewNodeCanOpen(arg_5_0)
	if g_Self.kWorldHandler.needRefreshOpenDlg then
		local var_5_0 = zbWorldNodeTable.records

		if zbUtil:isValidTable(var_5_0) then
			for iter_5_0, iter_5_1 in pairs(var_5_0) do
				local var_5_1 = iter_5_1.needTechLevel
				local var_5_2 = g_Self.kTechHandler:getStudyedTechLevel(3001)

				if g_Self.kWorldHandler:isNodeOpenById(iter_5_1.id) == false and arg_5_0:nodeCanOpen(var_5_1, var_5_2) then
					return true
				end
			end
		end
	end

	return false
end

function var_0_0.hasNotiFyResNode(arg_6_0)
	if arg_6_0.changeNodeId ~= 0 then
		return true
	end

	if arg_6_0.worldInfo then
		for iter_6_0, iter_6_1 in pairs(arg_6_0.worldInfo.HoldNodeList) do
			if iter_6_1.FullTm <= g_Self.kTimeHandler:getServerTime() then
				return true
			end
		end
	end

	return false
end

function var_0_0.hasNotiFyResNodeById(arg_7_0, arg_7_1)
	if arg_7_0.changeNodeId ~= 0 and arg_7_1 == arg_7_0.changeNodeId then
		return true
	end

	if arg_7_0.worldInfo then
		for iter_7_0, iter_7_1 in pairs(arg_7_0.worldInfo.HoldNodeList) do
			if arg_7_1 == iter_7_1.NodeId and iter_7_1.FullTm <= g_Self.kTimeHandler:getServerTime() then
				return true
			end
		end
	end

	return false
end

function var_0_0.hasHeroFight(arg_8_0)
	local var_8_0 = arg_8_0.worldInfo
	local var_8_1 = 0

	if var_8_0 and zbUtil:isValidTable(var_8_0.TaskList) then
		for iter_8_0, iter_8_1 in pairs(var_8_0.TaskList) do
			if zbUtil:isValidTable(iter_8_1.TeamList) then
				for iter_8_2, iter_8_3 in pairs(iter_8_1.TeamList) do
					for iter_8_4, iter_8_5 in pairs(iter_8_3.HeroList) do
						var_8_1 = var_8_1 + 1
					end
				end
			end
		end
	end

	if var_8_1 >= table.getn(g_GameData.HeroList) then
		return false
	end

	return true
end

function var_0_0.hasNotiFyTaskNode(arg_9_0)
	if arg_9_0.worldInfo and zbUtil:isValidTable(arg_9_0.worldInfo.TaskList) then
		for iter_9_0, iter_9_1 in pairs(arg_9_0.worldInfo.TaskList) do
			local var_9_0 = zbWorldNodeTable:getRecord(iter_9_1.NodeId)

			if var_9_0 then
				local var_9_1 = zbWorldTaskTable:getRecord(var_9_0.taskId)

				if var_9_1 then
					for iter_9_2, iter_9_3 in pairs(iter_9_1.TeamList) do
						if iter_9_3.EndTm <= g_Self.kTimeHandler:getServerTime() then
							return true
						end
					end

					if iter_9_1.DailyCount < var_9_1.maxTeamCnt and arg_9_0:hasHeroFight() then
						return true
					end
				end
			end
		end
	end

	return false
end

function var_0_0.hasNotiFyTaskNodeById(arg_10_0, arg_10_1)
	if arg_10_0.worldInfo and zbUtil:isValidTable(arg_10_0.worldInfo.TaskList) then
		for iter_10_0, iter_10_1 in pairs(arg_10_0.worldInfo.TaskList) do
			if arg_10_1 == iter_10_1.NodeId then
				local var_10_0 = zbWorldNodeTable:getRecord(iter_10_1.NodeId)

				if var_10_0 then
					local var_10_1 = zbWorldTaskTable:getRecord(var_10_0.taskId)

					if var_10_1 then
						if iter_10_1.DailyCount < var_10_1.maxTeamCnt and arg_10_0:hasHeroFight() then
							return true
						end

						for iter_10_2, iter_10_3 in pairs(iter_10_1.TeamList) do
							if iter_10_3.EndTm <= g_Self.kTimeHandler:getServerTime() then
								return true
							end
						end
					end
				end
			end
		end
	end

	return false
end

function var_0_0.updateWorldInfo(arg_11_0, arg_11_1)
	if arg_11_1 then
		arg_11_0.worldInfo = arg_11_1

		arg_11_0:updateOpenGridList()
	end

	g_GameEventMgr:sendEvent(zbGameEvent.Event_UpdateWorldInfo)
end

function var_0_0.updateWorldSettleList(arg_12_0, arg_12_1)
	if arg_12_0.worldInfo then
		arg_12_0.worldInfo.SettleList = arg_12_1
	end
end

function var_0_0.updateUnlockInfo(arg_13_0, arg_13_1)
	if arg_13_0.worldInfo then
		table.insert(arg_13_0.worldInfo.NodeList, arg_13_1.NodeId)

		if arg_13_1.NodeType == EWorldNodeType.ResNode then
			table.insert(arg_13_0.worldInfo.ViewNodeList, arg_13_1.WorldViewNode)
		elseif arg_13_1.NodeType == EWorldNodeType.TaskNode then
			table.insert(arg_13_0.worldInfo.TaskList, arg_13_1.WorldTaskNode)
		elseif arg_13_1.NodeType == EWorldNodeType.GodDomain then
			table.insert(arg_13_0.worldInfo.GodDomainList, arg_13_1.WorldGodDomainNode)
		elseif arg_13_1.NodeType == EWorldNodeType.NullNode and arg_13_1.SpecialNode ~= 0 then
			table.insert(arg_13_0.worldInfo.SpecialList, arg_13_1.SpecialNode)
		end

		arg_13_0:updateOpenGridList()
	end

	g_GameEventMgr:sendEvent(zbGameEvent.Event_UnlockWorldAck)
end

function var_0_0.resetWorldShopInfo(arg_14_0)
	if arg_14_0.worldInfo and arg_14_0.worldInfo.ShopInfo then
		arg_14_0.worldInfo.ShopInfo.NodeId = 0
	end
end

function var_0_0.updateWorldSpecialInfo(arg_15_0, arg_15_1)
	if arg_15_0.worldInfo then
		arg_15_0.worldInfo.SpecialList = arg_15_1.SpecialList
		arg_15_0.worldInfo.HorseCarList = arg_15_1.HorseCarList
		arg_15_0.worldInfo.FaceList = arg_15_1.FaceList
		arg_15_0.worldInfo.BgzInfo = arg_15_1.BgzInfo
		arg_15_0.worldInfo.ShopInfo = arg_15_1.ShopInfo
		arg_15_0.worldInfo.AwardBoxList = arg_15_1.AwardBoxList
	end
end

function var_0_0.updateWorldBgzInfo(arg_16_0, arg_16_1)
	if arg_16_0.worldInfo then
		arg_16_0.worldInfo.BgzInfo = arg_16_1
	end
end

function var_0_0.updateWorldFaceInfo(arg_17_0, arg_17_1)
	if arg_17_0.worldInfo then
		arg_17_0.worldInfo.FaceList = arg_17_1
	end
end

function var_0_0.updateWorldHorseCarInfo(arg_18_0, arg_18_1)
	if arg_18_0.worldInfo then
		arg_18_0.worldInfo.HorseCarList = arg_18_1
	end
end

function var_0_0.updateWorldAwardBoxInfo(arg_19_0, arg_19_1)
	if arg_19_0.worldInfo then
		arg_19_0.worldInfo.AwardBoxList = arg_19_1
	end
end

function var_0_0.updateWorldTaskInfoById(arg_20_0, arg_20_1)
	if arg_20_0.worldInfo and zbUtil:isValidTable(arg_20_0.worldInfo.TaskList) then
		for iter_20_0, iter_20_1 in pairs(arg_20_0.worldInfo.TaskList) do
			if iter_20_1.NodeId == arg_20_1.NodeId then
				arg_20_0.worldInfo.TaskList[iter_20_0] = arg_20_1

				break
			end
		end
	end
end

function var_0_0.getFaceDataById(arg_21_0, arg_21_1)
	if arg_21_0.worldInfo and zbUtil:isValidTable(arg_21_0.worldInfo.FaceList) then
		for iter_21_0, iter_21_1 in pairs(arg_21_0.worldInfo.FaceList) do
			if iter_21_1.NodeId == arg_21_1 then
				return iter_21_1
			end
		end
	end

	return nil
end

function var_0_0.getWorldDomainInfoById(arg_22_0, arg_22_1)
	if arg_22_0.worldInfo and zbUtil:isValidTable(arg_22_0.worldInfo.GodDomainList) then
		for iter_22_0, iter_22_1 in pairs(arg_22_0.worldInfo.GodDomainList) do
			if iter_22_1.NodeId == arg_22_1 then
				return iter_22_1
			end
		end
	end

	return nil
end

function var_0_0.getWorldTaskInfoById(arg_23_0, arg_23_1)
	if arg_23_0.worldInfo and zbUtil:isValidTable(arg_23_0.worldInfo.TaskList) then
		for iter_23_0, iter_23_1 in pairs(arg_23_0.worldInfo.TaskList) do
			if iter_23_1.NodeId == arg_23_1 then
				return iter_23_1
			end
		end
	end

	return nil
end

function var_0_0.getWorldNodeResInfoById(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_0.worldInfo then
		local var_24_0 = {}

		if arg_24_1 == EWorldNodeOccupyType.E_HOLD then
			var_24_0 = arg_24_0.worldInfo.HoldNodeList
		else
			var_24_0 = arg_24_0.worldInfo.ViewNodeList
		end

		if zbUtil:isValidTable(var_24_0) then
			for iter_24_0, iter_24_1 in pairs(var_24_0) do
				if iter_24_1.NodeId == arg_24_2 then
					return iter_24_1
				end
			end
		end
	end

	return nil
end

function var_0_0.getWorldHorseInfoById(arg_25_0, arg_25_1)
	if arg_25_0.worldInfo and zbUtil:isValidTable(arg_25_0.worldInfo.HorseCarList) then
		for iter_25_0, iter_25_1 in pairs(arg_25_0.worldInfo.HorseCarList) do
			if iter_25_1.NodeId == arg_25_1 then
				return iter_25_1
			end
		end
	end

	return nil
end

function var_0_0.openSpecialAck(arg_26_0, arg_26_1)
	if arg_26_1 then
		local var_26_0 = zbWorldNodeTable:getRecord(arg_26_1.NodeId)

		if arg_26_1.SpecialType == EWorldSpecialNode.HorseCar then
			g_MainScene:showWorldRobInfoWnd(var_26_0)
		elseif arg_26_1.SpecialType == EWorldSpecialNode.Face then
			g_MainScene:showWorldGameWnd(var_26_0)
		elseif arg_26_1.SpecialType == EWorldSpecialNode.BgzClue then
			g_MainScene:showWorldYuanZheng()
		elseif arg_26_1.SpecialType == EWorldSpecialNode.Shop then
			if arg_26_0:getWorldShopLessTimeByNodeId() > 0 then
				g_MainScene:showShopWorldWnd()
			end
		elseif arg_26_1.SpecialType == EWorldSpecialNode.AwardBox then
			g_MainScene:showWorldBoxWnd(var_26_0)
		end
	end
end

function var_0_0.updateOpenGridList(arg_27_0)
	arg_27_0.openGridList = {}

	local function var_27_0(arg_28_0)
		for iter_28_0, iter_28_1 in pairs(arg_27_0.openGridList) do
			if iter_28_1[1] == arg_28_0[1] and iter_28_1[2] == arg_28_0[2] then
				return true
			end
		end

		return false
	end

	for iter_27_0, iter_27_1 in pairs(arg_27_0.worldInfo.NodeList) do
		local var_27_1 = zbWorldNodeTable:getRecord(iter_27_1)

		if var_27_1 == nil then
			return false
		end

		local var_27_2 = var_27_1.gridList

		if zbUtil:isValidTable(var_27_2) then
			for iter_27_2, iter_27_3 in pairs(var_27_2) do
				local var_27_3 = zbWorldGridTable:getRecord(iter_27_3)

				if var_27_3 and not var_27_0(var_27_3.pos) then
					table.insert(arg_27_0.openGridList, var_27_3.pos)
				end
			end
		end
	end
end

function var_0_0.getNodeIndexById(arg_29_0, arg_29_1)
	local var_29_0 = zbWorldNodeTable:getRecord(arg_29_1)
	local var_29_1 = {}

	if var_29_0 == nil then
		return var_29_1
	end

	local var_29_2 = var_29_0.gridList

	if zbUtil:isValidTable(var_29_2) then
		for iter_29_0, iter_29_1 in pairs(var_29_2) do
			local var_29_3 = zbWorldGridTable:getRecord(iter_29_1)

			if var_29_3 then
				table.insert(var_29_1, var_29_3.pos)
			end
		end
	end

	return var_29_1
end

function var_0_0.isNodeOpenById(arg_30_0, arg_30_1)
	if arg_30_0.worldInfo == nil then
		return false
	end

	for iter_30_0, iter_30_1 in pairs(arg_30_0.worldInfo.NodeList) do
		if iter_30_1 == arg_30_1 then
			return true
		end
	end

	return false
end

function var_0_0.getNodeOpenTechLv(arg_31_0, arg_31_1)
	local var_31_0 = zbWorldNodeTable:getRecord(arg_31_1)

	if var_31_0 then
		return var_31_0.needTechLevel
	end

	return nil
end

function var_0_0.isNodeOpenByIndex(arg_32_0, arg_32_1, arg_32_2)
	for iter_32_0, iter_32_1 in pairs(arg_32_0.openGridList) do
		if iter_32_1[1] == arg_32_1 and iter_32_1[2] == arg_32_2 then
			return true
		end
	end

	return false
end

function var_0_0.getNodeIdByIndex(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = zbWorldNodeTable.records

	if zbUtil:isValidTable(var_33_0) then
		for iter_33_0, iter_33_1 in pairs(var_33_0) do
			local var_33_1 = iter_33_1.gridList

			if zbUtil:isValidTable(var_33_1) then
				for iter_33_2, iter_33_3 in pairs(var_33_1) do
					local var_33_2 = zbWorldGridTable:getRecord(iter_33_3)

					if var_33_2 and var_33_2.pos[1] == arg_33_1 and var_33_2.pos[2] == arg_33_2 then
						return iter_33_1.id
					end
				end
			end
		end
	end

	return nil
end

function var_0_0.updateWorldViewNodeList(arg_34_0, arg_34_1)
	if zbUtil:isValidTable(arg_34_1) == false or arg_34_0.worldInfo == nil then
		return
	end

	arg_34_0.worldInfo.ViewNodeList = arg_34_1
end

function var_0_0.updateWorldViewNode(arg_35_0, arg_35_1)
	if arg_35_1 == nil or arg_35_0.worldInfo == nil then
		return
	end

	for iter_35_0, iter_35_1 in pairs(arg_35_0.worldInfo.ViewNodeList) do
		if iter_35_1.NodeId == arg_35_1.NodeId then
			arg_35_0.worldInfo.ViewNodeList[iter_35_0] = arg_35_1

			return
		end
	end
end

function var_0_0.updateWorldHoldNode(arg_36_0, arg_36_1)
	if zbUtil:isValidTable(arg_36_1) == false or arg_36_0.worldInfo == nil then
		return
	end

	for iter_36_0, iter_36_1 in pairs(arg_36_0.worldInfo.HoldNodeList) do
		if iter_36_1.NodeId == arg_36_1.NodeId then
			arg_36_0.worldInfo.HoldNodeList[iter_36_0] = arg_36_1

			return
		end
	end

	table.insert(arg_36_0.worldInfo.HoldNodeList, arg_36_1)
end

function var_0_0.updateWorldBossInfo(arg_37_0, arg_37_1)
	arg_37_0.worldBossInfo = arg_37_1
end

function var_0_0.updateWorldBossSelfInfo(arg_38_0, arg_38_1)
	arg_38_0.worldBossSelfInfo = arg_38_1
end

function var_0_0.updateWorldBossBuffList(arg_39_0, arg_39_1)
	arg_39_0.worldBossBuffList = arg_39_1
end

function var_0_0.delNodeFromViewNodeList(arg_40_0, arg_40_1)
	if arg_40_0.worldInfo then
		for iter_40_0, iter_40_1 in pairs(arg_40_0.worldInfo.ViewNodeList) do
			if iter_40_1.NodeId == arg_40_1 then
				table.remove(arg_40_0.worldInfo.ViewNodeList, iter_40_0)
			end
		end
	end
end

function var_0_0.updateWorldHoldNodeList(arg_41_0, arg_41_1)
	if zbUtil:isValidTable(arg_41_1) == false or arg_41_0.worldInfo == nil then
		return
	end

	arg_41_0.worldInfo.HoldNodeList = arg_41_1
end

function var_0_0.getHoldAndFullSecondsByNodeId(arg_42_0, arg_42_1)
	local var_42_0 = 0
	local var_42_1 = 0
	local var_42_2 = arg_42_0:getWorldNodeResInfoById(EWorldNodeOccupyType.E_HOLD, arg_42_1)
	local var_42_3 = zbWorldNodeTable:getRecord(arg_42_1)

	if var_42_3 ~= nil and var_42_2 ~= nil then
		var_42_1 = var_42_3.maxOut / var_42_2.Output * 3600
	end

	for iter_42_0, iter_42_1 in pairs(arg_42_0.worldInfo.HoldNodeList) do
		if arg_42_1 == iter_42_1.NodeId then
			local var_42_4 = iter_42_1.FullTm - g_Self.kTimeHandler:getServerTime()

			if var_42_4 < 0 then
				var_42_0 = var_42_1
			else
				var_42_0 = var_42_1 - var_42_4
			end
		end
	end

	if var_42_0 < 0 then
		var_42_0 = 0
	end

	return var_42_0, var_42_1
end

function var_0_0.getWorldResTypeByNodeId(arg_43_0, arg_43_1)
	for iter_43_0, iter_43_1 in pairs(arg_43_0.worldInfo.HoldNodeList) do
		if arg_43_1 == iter_43_1.NodeId then
			return EWorldNodeOccupyType.E_HOLD
		end
	end

	for iter_43_2, iter_43_3 in pairs(arg_43_0.worldInfo.ViewNodeList) do
		if arg_43_1 == iter_43_3.NodeId then
			return EWorldNodeOccupyType.E_LOSE
		end
	end

	return 0
end

function var_0_0.openWorldInfoRes(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_0:getWorldResTypeByNodeId(arg_44_1)

	if var_44_0 == EWorldNodeOccupyType.E_HOLD then
		if g_Self.kTimeHandler:getServerTime() > arg_44_0:getWorldNodeResInfoById(var_44_0, arg_44_1).FullTm then
			g_WsMsgHandler:WS_WorldRes_Gain_Req(arg_44_1)
		else
			g_MainScene:showWorldResWnd(arg_44_1)
		end
	elseif var_44_0 == EWorldNodeOccupyType.E_LOSE then
		g_MainScene:showWorldResInfoWnd(arg_44_1)
	end
end

function var_0_0.getWorldShopLessTimeByNodeId(arg_45_0)
	if arg_45_0.worldInfo then
		return math.max(arg_45_0.worldInfo.ShopInfo.EndTm - g_Self.kTimeHandler:getServerTime(), 0)
	end
end

function var_0_0.getNextOpenNeedTechlv(arg_46_0)
	local var_46_0 = 100
	local var_46_1 = zbWorldNodeTable.records
	local var_46_2 = g_Self.kTechHandler:getStudyedTechLevel(3001)

	if zbUtil:isValidTable(var_46_1) then
		for iter_46_0, iter_46_1 in pairs(var_46_1) do
			local var_46_3 = iter_46_1.needTechLevel

			if var_46_2 < var_46_3 and var_46_3 < var_46_0 then
				var_46_0 = var_46_3
			end
		end
	end

	return var_46_0
end

function var_0_0.updateGodDomainNode(arg_47_0, arg_47_1)
	if zbUtil:isValidTable(arg_47_1) == false or arg_47_0.worldInfo == nil then
		return
	end

	for iter_47_0, iter_47_1 in pairs(arg_47_0.worldInfo.GodDomainList) do
		if iter_47_1.NodeId == arg_47_1.NodeId then
			arg_47_0.worldInfo.GodDomainList[iter_47_0] = arg_47_1

			return
		end
	end

	table.insert(arg_47_0.worldInfo.GodDomainList, arg_47_1)
end
