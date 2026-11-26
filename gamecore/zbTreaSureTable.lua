require("gamebase.zbLoadCSV")

local var_0_0 = class("zbTreaSureRecord")

var_0_0.__index = var_0_0

function creatTreaSureRecord()
	return (var_0_0.new())
end

zbTreaSureTable = {}
zbTreaSureTable.records = {}

function zbTreaSureTable.load(arg_2_0, arg_2_1)
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
				local var_2_2 = creatTreaSureRecord()
				local var_2_3 = 1

				var_2_2.chapterId = tonumber(iter_2_1[var_2_3])

				local var_2_4 = var_2_3 + 1

				var_2_2.levelId = tonumber(iter_2_1[var_2_4])

				local var_2_5 = var_2_4 + 1

				var_2_2.scenePath = iter_2_1[var_2_5]

				local var_2_6 = var_2_5 + 1

				var_2_2.box1Times = tonumber(iter_2_1[var_2_6])

				local var_2_7 = var_2_6 + 1

				var_2_2.box2Times = tonumber(iter_2_1[var_2_7])

				local var_2_8 = var_2_7 + 1

				var_2_2.box3Times = tonumber(iter_2_1[var_2_8])

				local var_2_9 = var_2_8 + 1

				var_2_2.randAward = arg_2_0:parseAwardItemContains(iter_2_1[var_2_9])

				local var_2_10 = var_2_9 + 1

				var_2_2.randAward2 = arg_2_0:parseAwardItemContains(iter_2_1[var_2_10])

				local var_2_11 = var_2_10 + 1

				var_2_2.box1Award = arg_2_0:parseAwardItemContains(iter_2_1[var_2_11])

				local var_2_12 = var_2_11 + 1

				var_2_2.box2Award = arg_2_0:parseAwardItemContains(iter_2_1[var_2_12])

				local var_2_13 = var_2_12 + 1

				var_2_2.box3Award = arg_2_0:parseAwardItemContains(iter_2_1[var_2_13])

				local var_2_14 = var_2_13 + 1

				var_2_2.treasureName = iter_2_1[var_2_14]

				local var_2_15 = var_2_14 + 1

				var_2_2.treasureDes = iter_2_1[var_2_15]

				local var_2_16 = var_2_15 + 1

				arg_2_0.records[var_2_1] = var_2_2
			end
		end
	end

	return arg_2_0
end

function zbTreaSureTable.parseAwardItemContains(arg_3_0, arg_3_1)
	local var_3_0 = {}
	local var_3_1 = string.len(arg_3_1)
	local var_3_2 = string.sub(arg_3_1, 2, var_3_1 - 1)
	local var_3_3 = string.gsub(arg_3_1, "%[", "{")
	local var_3_4 = string.gsub(var_3_3, "%]", "}")
	local var_3_5 = wzUnserialize(var_3_4)
	local var_3_6 = {}

	for iter_3_0, iter_3_1 in pairs(var_3_5) do
		local var_3_7 = {
			Type = tonumber(iter_3_1[1]),
			Id = tonumber(iter_3_1[2]),
			Count = tonumber(iter_3_1[3])
		}

		table.insert(var_3_6, var_3_7)
	end

	return var_3_6
end

function zbTreaSureTable.getRecord(arg_4_0, arg_4_1)
	return arg_4_0.records[arg_4_1]
end
