require("gamebase.zbLoadCSV")

local var_0_0 = class("zbDailyTaskRecord")

var_0_0.__index = var_0_0

function createDailyTaskRecord()
	return (var_0_0.new())
end

zbDailyTaskTable = {}
zbDailyTaskTable.records = {}

function zbDailyTaskTable.load(arg_2_0, arg_2_1)
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
				local var_2_2 = createDailyTaskRecord()
				local var_2_3 = 1

				var_2_2.type = tonumber(iter_2_1[var_2_3])

				local var_2_4 = var_2_3 + 1

				var_2_2.requireLevel = tonumber(iter_2_1[var_2_4])

				local var_2_5 = var_2_4 + 1

				var_2_2.maxComplete = tonumber(iter_2_1[var_2_5])

				local var_2_6 = var_2_5 + 1

				var_2_2.active = tonumber(iter_2_1[var_2_6])

				local var_2_7 = var_2_6 + 1

				var_2_2.award0 = arg_2_0:parseContains(iter_2_1[var_2_7])

				local var_2_8 = var_2_7 + 1

				var_2_2.award1 = arg_2_0:parseContains(iter_2_1[var_2_8])

				local var_2_9 = var_2_8 + 1

				var_2_2.award2 = arg_2_0:parseContains(iter_2_1[var_2_9])

				local var_2_10 = var_2_9 + 1

				var_2_2.description = iter_2_1[var_2_10]

				local var_2_11 = var_2_10 + 1

				var_2_2.linkName = iter_2_1[var_2_11]

				local var_2_12 = var_2_11 + 1

				var_2_2.icon = iter_2_1[var_2_12]

				local var_2_13 = var_2_12 + 1

				var_2_2.linkUrl = iter_2_1[var_2_13]

				local var_2_14 = var_2_13 + 1

				arg_2_0.records[var_2_1] = var_2_2
			end
		end
	end

	return arg_2_0
end

function zbDailyTaskTable.getRecord(arg_3_0, arg_3_1)
	return arg_3_0.records[arg_3_1]
end

function zbDailyTaskTable.parseContains(arg_4_0, arg_4_1)
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
			awardType = tonumber(iter_4_1[1]),
			awardId = tonumber(iter_4_1[2]),
			awardCount = tonumber(iter_4_1[3])
		}
		var_4_7 = var_4_7 + 1
	end

	return var_4_6
end
