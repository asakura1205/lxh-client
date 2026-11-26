zbFunHelper = {}

function zbFunHelper.isBuildingLockAndTip(arg_1_0, arg_1_1)
	return zbFunHelper:isBuildingLockCheckPopTip(arg_1_1, true)
end

function zbFunHelper.isBuildingLockNoTip(arg_2_0, arg_2_1)
	return zbFunHelper:isBuildingLockCheckPopTip(arg_2_1, false)
end

function zbFunHelper.isBuildingLockCheckPopTip(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == EBuildingType.Smithy then
		return zbFunHelper:isLock(EFuncType.Smelt, arg_3_2)
	elseif arg_3_1 == EBuildingType.Tech then
		return zbFunHelper:isLock(EFuncType.Tech, arg_3_2)
	elseif arg_3_1 == EBuildingType.Arena then
		return zbFunHelper:isLock(EFuncType.Arena, arg_3_2)
	elseif arg_3_1 == EBuildingType.Trial then
		return zbFunHelper:isLock(EFuncType.Trial, arg_3_2)
	elseif arg_3_1 == EBuildingType.Legion then
		return zbFunHelper:isLock(EFuncType.Legion, arg_3_2)
	elseif arg_3_1 == EBuildingType.World then
		return zbFunHelper:isLock(EFuncType.World, arg_3_2)
	elseif arg_3_1 == EBuildingType.Shop then
		return zbFunHelper:isLock(EFuncType.Shop, arg_3_2)
	elseif arg_3_1 == EBuildingType.Rank then
		return zbFunHelper:isLock(EFuncType.Rank, arg_3_2)
	end

	return false
end

function zbFunHelper.isLockAndTip(arg_4_0, arg_4_1)
	return zbFunHelper:isLock(arg_4_1, true)
end

function zbFunHelper.isLockNoTip(arg_5_0, arg_5_1)
	return zbFunHelper:isLock(arg_5_1, false)
end

function zbFunHelper.isLock(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = zbFunctionUnlockTable:getRecord(arg_6_1)

	if var_6_0 == nil then
		return false
	end

	if arg_6_1 ~= EFuncType.NightmareLevel and (var_6_0.requireForce > 0 and g_Self.kWarPathHandler:isBossLevelPass(ELevelType.Normal, var_6_0.requireForce) == false or var_6_0.requireLevel > 0 and g_Self:getLevel() < var_6_0.requireLevel) then
		if arg_6_2 then
			g_MainScene:showLockTipWnd(arg_6_1)
		end

		return true
	elseif arg_6_1 == EFuncType.NightmareLevel and (var_6_0.requireForce > 0 and g_Self.kWarPathHandler:isBossLevelPass(ELevelType.Elite, var_6_0.requireForce) == false or var_6_0.requireLevel > 0 and g_Self:getLevel() < var_6_0.requireLevel) then
		if arg_6_2 then
			g_MainScene:showLockTipWnd(arg_6_1)
		end

		return true
	end

	return false
end
