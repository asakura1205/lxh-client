require("gamebase.zbLoadCSV")

local var_0_0 = class("zbLegionDailyAwardRecord")

var_0_0.__index = var_0_0

function var_0_0.init(arg_1_0)
	return
end

function createLegionDailyAwardRecord()
	local var_2_0 = var_0_0.new()

	var_2_0:init()

	return var_2_0
end

zbLegionDailyAwardTable = {}
zbLegionDailyAwardTable.records = {}

function zbLegionDailyAwardTable.load(arg_3_0, arg_3_1)
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
				local var_3_2 = createLegionDailyAwardRecord()
				local var_3_3 = 1

				var_3_2.level = tonumber(iter_3_1[var_3_3])

				local var_3_4 = var_3_3 + 1

				var_3_2.dailyAward1 = arg_3_0:parseAwardItemContains(iter_3_1[var_3_4])

				local var_3_5 = var_3_4 + 1

				var_3_2.dailyAward2 = arg_3_0:parseAwardItemContains(iter_3_1[var_3_5])

				local var_3_6 = var_3_5 + 1

				var_3_2.dailyAward3 = arg_3_0:parseAwardItemContains(iter_3_1[var_3_6])

				local var_3_7 = var_3_6 + 1

				arg_3_0.records[var_3_1] = var_3_2
			end
		end
	end

	return arg_3_0
end

function zbLegionDailyAwardTable.getRecord(arg_4_0, arg_4_1)
	return arg_4_0.records[arg_4_1]
end

function zbLegionDailyAwardTable.parseAwardItemContains(arg_5_0, arg_5_1)
	local var_5_0 = {}
	local var_5_1 = string.len(arg_5_1)
	local var_5_2 = string.sub(arg_5_1, 2, var_5_1 - 1)
	local var_5_3 = string.gsub(arg_5_1, "%[", "{")
	local var_5_4 = string.gsub(var_5_3, "%]", "}")
	local var_5_5 = wzUnserialize(var_5_4)
	local var_5_6 = {}

	for iter_5_0, iter_5_1 in pairs(var_5_5) do
		local var_5_7 = {
			type = tonumber(iter_5_1[1]),
			value = tonumber(iter_5_1[2]),
			number = tonumber(iter_5_1[3])
		}

		table.insert(var_5_6, var_5_7)
	end

	return var_5_6
end
