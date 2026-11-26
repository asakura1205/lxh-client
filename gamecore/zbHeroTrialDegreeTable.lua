require("gamebase.zbLoadCSV")

local var_0_0 = class("zbHeroTrialDegreeRecord")

var_0_0.__index = var_0_0

function createHeroTrialDegreeRecord()
	return (var_0_0.new())
end

zbHeroTrialDegreeTable = {}
zbHeroTrialDegreeTable.records = {}

function zbHeroTrialDegreeTable.load(arg_2_0, arg_2_1)
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
				local var_2_3 = createHeroTrialDegreeRecord()
				local var_2_4 = 1

				var_2_3.trialId = tonumber(iter_2_1[var_2_4])

				local var_2_5 = var_2_4 + 1

				var_2_3.difficultyId = tonumber(iter_2_1[var_2_5])

				local var_2_6 = var_2_5 + 1

				var_2_3.desc = iter_2_1[var_2_6]

				local var_2_7 = var_2_6 + 1

				var_2_3.openLevel = tonumber(iter_2_1[var_2_7])

				local var_2_8 = var_2_7 + 1

				var_2_3.awardList = arg_2_0:parseContains(iter_2_1[var_2_8])

				local var_2_9 = var_2_8 + 1

				var_2_3.formatId = arg_2_0:parseFormatId(iter_2_1[var_2_9])

				local var_2_10 = var_2_9 + 1
				local var_2_11 = arg_2_0.records[var_2_1]

				if var_2_11 == nil then
					var_2_11 = {}
					arg_2_0.records[var_2_1] = var_2_11
				end

				var_2_11[var_2_2] = var_2_3
			end
		end
	end

	return arg_2_0
end

function zbHeroTrialDegreeTable.parseContains(arg_3_0, arg_3_1)
	local var_3_0 = {}
	local var_3_1 = string.len(arg_3_1)
	local var_3_2 = string.sub(arg_3_1, 2, var_3_1 - 1)
	local var_3_3 = string.gsub(arg_3_1, "%[", "{")
	local var_3_4 = string.gsub(var_3_3, "%]", "}")
	local var_3_5 = wzUnserialize(var_3_4)

	if type(var_3_5) == "number" then
		return nil
	end

	local var_3_6 = {}
	local var_3_7 = 1

	for iter_3_0, iter_3_1 in pairs(var_3_5) do
		local var_3_8 = {
			awardType = tonumber(iter_3_1[1]),
			awardId = tonumber(iter_3_1[2]),
			awardCount = tonumber(iter_3_1[3])
		}

		zbGetWayItemTable:addItemNewWaysShop(var_3_8.awardId, EItemGetWayType.GetWay_Trial, var_3_8.awardType)

		var_3_6[var_3_7] = var_3_8
		var_3_7 = var_3_7 + 1
	end

	return var_3_6
end

function zbHeroTrialDegreeTable.parseFormatId(arg_4_0, arg_4_1)
	local var_4_0 = string.gsub(arg_4_1, "%[", "{")
	local var_4_1 = string.gsub(var_4_0, "%]", "}")

	ret = wzUnserialize(var_4_1)

	local var_4_2 = wzUnserialize(var_4_1)

	if type(var_4_2) == "number" then
		return var_4_2
	end

	local var_4_3 = {}

	for iter_4_0, iter_4_1 in pairs(var_4_2) do
		var_4_3[iter_4_0] = tonumber(iter_4_1)
	end

	return var_4_3[table.getn(var_4_3)]
end

function zbHeroTrialDegreeTable.getRecord(arg_5_0, arg_5_1, arg_5_2)
	return arg_5_0.records[arg_5_1][arg_5_2]
end

function zbHeroTrialDegreeTable.getTypeRecord(arg_6_0, arg_6_1)
	return arg_6_0.records[arg_6_1]
end
