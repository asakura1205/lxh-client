require("gamebase.zbLoadCSV")

local var_0_0 = class("zbTaskRecord")

var_0_0.__index = var_0_0

function createActCrazyUpgradeRecord()
	return (var_0_0.new())
end

zbActCrazyUpgradeTable = {}
zbActCrazyUpgradeTable.records = {}
zbActCrazyUpgradeTable.number = 0

function zbActCrazyUpgradeTable.load(arg_2_0, arg_2_1)
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
				local var_2_2 = createActCrazyUpgradeRecord()
				local var_2_3 = 1

				var_2_2.level = tonumber(iter_2_1[var_2_3])

				local var_2_4 = var_2_3 + 1

				var_2_2.AwardList = arg_2_0:parseContains(iter_2_1[var_2_4])

				local var_2_5 = var_2_4 + 1

				var_2_2.rank100 = tonumber(iter_2_1[var_2_5])

				local var_2_6 = var_2_5 + 1

				table.insert(arg_2_0.records, var_2_2)

				arg_2_0.number = arg_2_0.number + 1
			end
		end
	end

	local function var_2_7(arg_3_0, arg_3_1)
		return arg_3_0.level < arg_3_1.level
	end

	table.sort(arg_2_0.records, var_2_7)

	return arg_2_0
end

function zbActCrazyUpgradeTable.parseContains(arg_4_0, arg_4_1)
	local var_4_0 = {}
	local var_4_1 = string.len(arg_4_1)
	local var_4_2 = string.sub(arg_4_1, 2, var_4_1 - 1)
	local var_4_3 = string.gsub(arg_4_1, "%[", "{")
	local var_4_4 = string.gsub(var_4_3, "%]", "}")
	local var_4_5 = wzUnserialize(var_4_4)

	if type(var_4_5) == "number" then
		return nil
	end

	local var_4_6 = {}
	local var_4_7 = 1

	for iter_4_0, iter_4_1 in pairs(var_4_5) do
		var_4_6[var_4_7] = {
			Type = tonumber(iter_4_1[1]),
			Id = tonumber(iter_4_1[2]),
			Count = tonumber(iter_4_1[3])
		}
		var_4_7 = var_4_7 + 1
	end

	return var_4_6
end
