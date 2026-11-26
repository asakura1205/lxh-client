require("gamebase.zbLoadCSV")

local var_0_0 = class("zbBuildingUpgradeRecord")

var_0_0.__index = var_0_0

function var_0_0.init(arg_1_0)
	arg_1_0.lvl = 0
	arg_1_0.farmCost = 0
	arg_1_0.farmCD = 0
	arg_1_0.foodIncome = 0
	arg_1_0.maxFood = 0
end

function createBuildingUpgradeRecord()
	local var_2_0 = var_0_0.new()

	var_2_0:init()

	return var_2_0
end

zbBuildingUpgradeTable = {}
zbBuildingUpgradeTable.records = {}

function zbBuildingUpgradeTable.load(arg_3_0, arg_3_1)
	local var_3_0 = require(arg_3_1)

	if var_3_0 == nil then
		return
	end

	if type(var_3_0) == "table" then
		for iter_3_0, iter_3_1 in pairs(var_3_0) do
			if iter_3_0 == 1 or iter_3_0 == 2 or iter_3_1[1] == "" then
				-- block empty
			else
				local var_3_1 = tonumber(iter_3_1[1])
				local var_3_2 = createBuildingUpgradeRecord()
				local var_3_3 = 1

				var_3_2.lvl = tonumber(iter_3_1[var_3_3])

				local var_3_4 = var_3_3 + 1

				var_3_2.farmCost = tonumber(iter_3_1[var_3_4])

				local var_3_5 = var_3_4 + 1

				var_3_2.farmCD = tonumber(iter_3_1[var_3_5]) * 60

				local var_3_6 = var_3_5 + 1

				var_3_2.foodIncome = tonumber(iter_3_1[var_3_6])

				local var_3_7 = var_3_6 + 1

				var_3_2.maxFood = tonumber(iter_3_1[var_3_7])

				local var_3_8 = var_3_7 + 1

				arg_3_0.records[var_3_2.lvl] = var_3_2
			end
		end
	end

	return arg_3_0
end

function zbBuildingUpgradeTable.getRecord(arg_4_0, arg_4_1)
	return arg_4_0.records[arg_4_1]
end

function zbBuildingUpgradeTable.getIncome(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:getRecord(arg_5_1)

	if var_5_0 ~= nil then
		return var_5_0.foodIncome, var_5_0.maxFood, var_5_0.maxFood / var_5_0.foodIncome
	end

	return 0, 1, 1
end
