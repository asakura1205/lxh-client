require("gamebase.zbLoadCSV")

local var_0_0 = class("zbFunctionUnlockRecord")

var_0_0.__index = var_0_0

function createFunctionUnlockRecord()
	return (var_0_0.new())
end

zbFunctionUnlockTable = {}
zbFunctionUnlockTable.records = {}

function zbFunctionUnlockTable.load(arg_2_0, arg_2_1)
	local var_2_0 = require(arg_2_1)

	if var_2_0 == nil then
		return
	end

	if type(var_2_0) == "table" then
		for iter_2_0, iter_2_1 in pairs(var_2_0) do
			if iter_2_0 == 1 or iter_2_0 == 2 or iter_2_1[1] == "" then
				-- block empty
			else
				local var_2_1 = tonumber(iter_2_1[1])
				local var_2_2 = createFunctionUnlockRecord()
				local var_2_3 = 1

				var_2_2.id = tonumber(iter_2_1[var_2_3])

				local var_2_4 = var_2_3 + 1

				var_2_2.name = iter_2_1[var_2_4]

				local var_2_5 = var_2_4 + 1

				var_2_2.requireForce = tonumber(iter_2_1[var_2_5])

				local var_2_6 = var_2_5 + 1

				var_2_2.requireLevel = tonumber(iter_2_1[var_2_6])

				local var_2_7 = var_2_6 + 1

				var_2_2.showTime = tonumber(iter_2_1[var_2_7])

				local var_2_8 = var_2_7 + 1

				var_2_2.icon = iter_2_1[var_2_8]

				local var_2_9 = var_2_8 + 1

				var_2_2.functionDesc = iter_2_1[var_2_9]

				local var_2_10 = var_2_9 + 1

				var_2_2.unlockDesc = iter_2_1[var_2_10]

				local var_2_11 = var_2_10 + 1

				var_2_2.linkIcon = iter_2_1[var_2_11]

				local var_2_12 = var_2_11 + 1

				var_2_2.linkUrl = iter_2_1[var_2_12]

				local var_2_13 = var_2_12 + 1

				arg_2_0.records[var_2_1] = var_2_2

				if var_2_1 == EFuncType.Friends then
					OPEN_FRIENDS_LEVEL = var_2_2.requireLevel
				elseif var_2_1 == EFuncType.Legion then
					OPEN_LEGION_LEVEL = var_2_2.requireLevel
				end
			end
		end
	end

	return arg_2_0
end

function zbFunctionUnlockTable.getRecord(arg_3_0, arg_3_1)
	return arg_3_0.records[arg_3_1]
end

function zbFunctionUnlockTable.getCurNewFunction(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.records) do
		if arg_4_1 and iter_4_1.requireLevel > 0 and g_Self:getLevel() == iter_4_1.requireLevel then
			return iter_4_1
		elseif iter_4_1.requireForce > 0 then
			if iter_4_1.id ~= EFuncType.NightmareLevel and g_CombatSystem.combatData ~= nil and g_CombatSystem.combatData:getLevelType() == ELevelType.Normal and g_Self:isFirstPassForce() and g_Self.kWarPathHandler:isBossLevelPass(ELevelType.Normal, iter_4_1.requireForce) and iter_4_1.requireForce >= table.getn(g_GameData.ForceSection) then
				local var_4_0 = zbForceSetTable:getLastLevelId(iter_4_1.requireForce)

				if g_CombatSystem.combatData:getLevelId() == var_4_0 then
					return iter_4_1
				else
					return nil
				end
			elseif iter_4_1.id == EFuncType.NightmareLevel and g_CombatSystem.combatData ~= nil and g_CombatSystem.combatData:getLevelType() == ELevelType.Elite and g_Self:isFirstPassForce() and g_Self.kWarPathHandler:isBossLevelPass(ELevelType.Elite, iter_4_1.requireForce) then
				local var_4_1 = zbForceSetTable:getLastLevelId(iter_4_1.requireForce)

				if g_CombatSystem.combatData:getLevelId() == var_4_1 then
					return iter_4_1
				end
			end
		end
	end

	return nil
end
