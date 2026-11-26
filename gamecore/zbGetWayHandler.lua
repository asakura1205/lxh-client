local var_0_0 = class("zbGetWayHandler")

var_0_0.__index = var_0_0

function createGetWayHandler()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	arg_2_0.itemWays = {}
end

function var_0_0.getWays(arg_3_0, arg_3_1)
	local var_3_0 = zbGetWayItemTable:getWays(arg_3_1)

	if var_3_0 ~= nil then
		local function var_3_1(arg_4_0, arg_4_1)
			arg_4_0.passedValue = arg_3_0:getPassedValue(arg_4_0)
			arg_4_1.passedValue = arg_3_0:getPassedValue(arg_4_1)

			if arg_4_0.passedValue == arg_4_1.passedValue then
				if arg_4_0.wayType == arg_4_1.wayType then
					if arg_4_0.forceId == arg_4_1.forceId then
						if arg_4_0.levelId == arg_4_1.levelId then
							return arg_4_0.levelType < arg_4_1.levelType
						end

						return arg_4_0.levelId < arg_4_1.levelId
					end

					return arg_4_0.forceId < arg_4_1.forceId
				else
					return arg_4_0.wayType < arg_4_1.wayType
				end
			else
				return arg_4_0.passedValue > arg_4_1.passedValue
			end
		end

		table.sort(var_3_0.ways, var_3_1)

		return var_3_0
	end

	return nil
end

function var_0_0.getPassedValue(arg_5_0, arg_5_1)
	local var_5_0 = true
	local var_5_1 = 1

	if arg_5_1.wayType == EItemGetWayType.GetWay_ForceAward then
		var_5_0 = arg_5_1.forceId <= g_Self.kWarPathHandler.levelModes[arg_5_1.levelType].curForceId
		var_5_0 = var_5_0 and arg_5_1.levelId <= g_Self.kWarPathHandler.levelModes[arg_5_1.levelType].curLevelId
		var_5_0 = var_5_0 and g_Self.kWarPathHandler:isVisibleForce(arg_5_1.levelType, arg_5_1.forceId)

		if arg_5_1.levelType ~= ELevelType.Normal then
			local var_5_2 = 0

			if arg_5_1.levelType == ELevelType.Elite then
				local var_5_3 = zbFunctionUnlockTable:getRecord(EFuncType.EliteLevel)

				var_5_2 = g_Self.kWarPathHandler:getLevelStar(ELevelType.Normal, var_5_3.requireForce, zbForceSetTable:getLastLevelId(var_5_3.requireForce))
			elseif arg_5_1.levelType == ELevelType.Nightmare then
				local var_5_4 = zbFunctionUnlockTable:getRecord(EFuncType.NightmareLevel)

				var_5_2 = g_Self.kWarPathHandler:getLevelStar(ELevelType.Elite, var_5_4.requireForce, zbForceSetTable:getLastLevelId(var_5_4.requireForce))
			end

			var_5_0 = var_5_0 and var_5_2 > 0
		end
	elseif arg_5_1.wayType == EItemGetWayType.GetWay_ShopNormal or arg_5_1.wayType == EItemGetWayType.GetWay_ShopShenMi or arg_5_1.wayType == EItemGetWayType.GetWay_ShopHonor then
		var_5_0 = not zbFunHelper:isBuildingLockNoTip(EBuildingType.Shop)
	elseif arg_5_1.wayType == EItemGetWayType.GetWay_Trial then
		var_5_0 = not zbFunHelper:isBuildingLockNoTip(EBuildingType.Trial)
	elseif arg_5_1.wayType == EItemGetWayType.GetWay_Yuanzheng or arg_5_1.wayType == EItemGetWayType.GetWay_YuanzhengJiFen then
		var_5_0 = not zbFunHelper:isLockNoTip(EFuncType.Bgz)
	elseif arg_5_1.wayType == EItemGetWayType.GetWay_Pata or arg_5_1.wayType == EItemGetWayType.GetWay_PataJiFen then
		var_5_0 = not zbFunHelper:isLockNoTip(EFuncType.Pata)
	elseif arg_5_1.wayType == EItemGetWayType.GetWay_WorldNode or arg_5_1.wayType == EItemGetWayType.GetWay_WorldTask then
		var_5_0 = not zbFunHelper:isBuildingLockNoTip(EBuildingType.World)
	end

	return var_5_0 == true and 1 or 0
end
