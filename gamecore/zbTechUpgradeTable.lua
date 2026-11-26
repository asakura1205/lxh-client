require("gamebase.zbLoadCSV")

local var_0_0 = class("zbTechUpgradeRecord")

var_0_0.__index = var_0_0

function createTechUpgradeRecord()
	return (var_0_0.new())
end

zbTechUpgradeTable = {}
zbTechUpgradeTable.records = {}

function zbTechUpgradeTable.load(arg_2_0, arg_2_1)
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
				local var_2_2 = tonumber(iter_2_1[2])
				local var_2_3 = createTechUpgradeRecord()
				local var_2_4 = 1

				var_2_3.upgradeId = tonumber(iter_2_1[var_2_4])

				local var_2_5 = var_2_4 + 1

				var_2_3.lvl = tonumber(iter_2_1[var_2_5])

				local var_2_6 = var_2_5 + 1

				var_2_3.cost = tonumber(iter_2_1[var_2_6])

				local var_2_7 = var_2_6 + 1
				local var_2_8 = arg_2_0.records[var_2_1]

				if var_2_8 == nil then
					var_2_8 = {}
					arg_2_0.records[var_2_1] = var_2_8
				end

				var_2_8[var_2_2] = var_2_3
			end
		end
	end

	return arg_2_0
end

function zbTechUpgradeTable.getRecord(arg_3_0, arg_3_1, arg_3_2)
	return arg_3_0.records[arg_3_1][arg_3_2]
end

function zbTechUpgradeTable.getTechUpgradeCost(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = zbTechTable:getRecord(arg_4_1)
	local var_4_1 = arg_4_0.records[var_4_0.upgradeId][arg_4_2]
	local var_4_2 = 0

	if var_4_1 and var_4_1.cost ~= nil then
		var_4_2 = var_4_1.cost
	end

	return var_4_2
end

function zbTechUpgradeTable.getTechMaxUpgradeCost(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = zbTechTable:getRecord(arg_5_1)
	local var_5_1 = 0
	local var_5_2 = g_Self:getLevel()

	if var_5_0.upInterval > 1 then
		var_5_2 = math.floor((var_5_2 - var_5_0.unlockLvl) / var_5_0.upInterval)

		for iter_5_0 = arg_5_2, var_5_2 do
			local var_5_3 = arg_5_0.records[var_5_0.upgradeId][iter_5_0]

			if var_5_3 and var_5_3.cost ~= nil then
				var_5_1 = var_5_3.cost + var_5_1
			end
		end

		for iter_5_1 = var_5_2, arg_5_2, -1 do
			if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Food, var_5_1) == true then
				return var_5_1, iter_5_1
			end

			local var_5_4 = arg_5_0.records[var_5_0.upgradeId][iter_5_1]

			if var_5_4 and var_5_4.cost ~= nil then
				var_5_1 = var_5_1 - var_5_4.cost
			end
		end
	else
		for iter_5_2 = arg_5_2, var_5_2 - 1 do
			local var_5_5 = arg_5_0.records[var_5_0.upgradeId][iter_5_2]

			if var_5_5 and var_5_5.cost ~= nil then
				var_5_1 = var_5_5.cost + var_5_1
			end
		end

		for iter_5_3 = var_5_2, arg_5_2 + 1, -1 do
			if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Food, var_5_1) == true then
				return var_5_1, iter_5_3
			end

			local var_5_6 = arg_5_0.records[var_5_0.upgradeId][iter_5_3 - 1]

			if var_5_6 and var_5_6.cost ~= nil then
				var_5_1 = var_5_1 - var_5_6.cost
			end
		end
	end

	return 0, 0
end
