zbFarmHandler = class("zbFarmHandler")
zbFarmHandler.__index = zbFarmHandler

function createFarmHandler()
	local var_1_0 = zbFarmHandler.new()

	var_1_0:init()

	return var_1_0
end

function zbFarmHandler.init(arg_2_0)
	arg_2_0.lastUpgradeReqLevel = 0
	arg_2_0.lastUpgradeReqTime = 0
end

function zbFarmHandler.update(arg_3_0, arg_3_1)
	if arg_3_0:isUpgrading() == false then
		return
	end

	if arg_3_0:getNeedTime() > 0 then
		return
	end

	if arg_3_0.lastUpgradeReqLevel ~= arg_3_0:getLevel() then
		g_WsMsgHandler:WS_Building_GetData_Req()

		arg_3_0.lastUpgradeReqLevel = arg_3_0:getLevel()
	elseif arg_3_0.lastUpgradeReqTime >= 10 then
		g_WsMsgHandler:WS_Building_GetData_Req()

		arg_3_0.lastUpgradeReqTime = 0
		arg_3_0.lastUpgradeReqLevel = arg_3_0:getLevel()
	end

	arg_3_0.lastUpgradeReqTime = arg_3_0.lastUpgradeReqTime + arg_3_1
end

function zbFarmHandler.updateInfo(arg_4_0, arg_4_1)
	if zbUtil:isValidTable(arg_4_1) == false then
		return
	end

	g_GameData.BuildingList = arg_4_1

	g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_Farm)
end

function zbFarmHandler.getFarmInfo(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(g_GameData.BuildingList) do
		if iter_5_1.BuildingId == EBuildingType.Farm then
			return iter_5_1
		end
	end

	return nil
end

function zbFarmHandler.getLevel(arg_6_0)
	return arg_6_0:getFarmInfo().Level
end

function zbFarmHandler.isUpgrading(arg_7_0)
	if arg_7_0:getFarmInfo().UpgradeEndTm == 0 then
		return false
	end

	return true
end

function zbFarmHandler.getNeedTime(arg_8_0)
	local var_8_0 = arg_8_0:getFarmInfo()

	if var_8_0.UpgradeEndTm == 0 then
		return 0
	end

	return math.max(var_8_0.UpgradeEndTm - g_Self.kTimeHandler:getServerTime(), 0)
end

function zbFarmHandler.getUpgradeTimePercent(arg_9_0)
	local var_9_0 = arg_9_0:getFarmInfo()

	if var_9_0.UpgradeEndTm == 0 then
		return 0
	end

	local var_9_1 = (var_9_0.UpgradeEndTm - g_Self.kTimeHandler:getServerTime()) / (var_9_0.UpgradeEndTm - var_9_0.UpgradeStartTm)

	return 1 - zbUtil:clamp(var_9_1, 0, 1)
end

function zbFarmHandler.isCanLevelUp(arg_10_0)
	local var_10_0 = arg_10_0:getFarmInfo().Level

	if var_10_0 >= g_Self:getLevel() then
		return false
	end

	if var_10_0 >= FARM_MAX_LEVEL then
		return false
	end

	if arg_10_0:isUpgrading() then
		return false
	end

	if arg_10_0:getUpgradeCost() > g_GameData.Wealth.Gold then
		return false
	end

	return true
end

function zbFarmHandler.getImmCompleteGold(arg_11_0)
	local var_11_0 = arg_11_0:getNeedTime()
	local var_11_1 = 0
	local var_11_2 = math.ceil(var_11_0 / 60)

	if var_11_2 > 5000 then
		var_11_1 = var_11_1 + (var_11_2 - 5000) * 0.2
	end

	if var_11_2 > 1000 then
		local var_11_3 = 0

		var_11_1 = var_11_1 + (var_11_2 >= 5000 and 4000 or var_11_2 - 1000) * 0.5
	end

	if var_11_2 > 0 then
		local var_11_4 = 0

		var_11_1 = var_11_1 + (var_11_2 >= 1000 and 1000 or var_11_2) * 1
	end

	return (math.floor(var_11_1 + 0.5))
end

function zbFarmHandler.getUpgradeCost(arg_12_0)
	local var_12_0 = 0
	local var_12_1 = arg_12_0:getLevel()
	local var_12_2 = zbBuildingUpgradeTable:getRecord(var_12_1)

	if var_12_2 ~= nil and var_12_2.farmCost ~= nil then
		var_12_0 = var_12_2.farmCost
	end

	return var_12_0
end

function zbFarmHandler.getCurLevyTime(arg_13_0)
	local var_13_0 = arg_13_0:getFarmInfo()
	local var_13_1, var_13_2, var_13_3 = zbBuildingUpgradeTable:getIncome(var_13_0.Level)

	if var_13_0.NextIncomeTm ~= nil then
		local var_13_4 = var_13_0.NextIncomeTm - g_Self.kTimeHandler:getServerTime()

		if var_13_4 <= 0 then
			return var_13_3 * 3600
		else
			return var_13_3 * 3600 - var_13_4
		end
	else
		return var_13_3 * 3600
	end
end
