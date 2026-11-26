require("gamebase.zbLoadCSV")

local var_0_0 = class("zbBgzScoreAwardRecord")

var_0_0.__index = var_0_0

function createBgzScoreAwardRecord()
	return (var_0_0.new())
end

zbBgzScoreAwardTable = {}
zbBgzScoreAwardTable.records = {}

function zbBgzScoreAwardTable.load(arg_2_0, arg_2_1)
	local var_2_0 = require(arg_2_1)

	if var_2_0 == nil then
		return
	end

	if type(var_2_0) == "table" then
		for iter_2_0, iter_2_1 in pairs(var_2_0) do
			if iter_2_0 == 1 or iter_2_0 == 2 or iter_2_1[1] == "" then
				-- block empty
			else
				local var_2_1 = createBgzScoreAwardRecord()
				local var_2_2 = 1

				var_2_1.score = tonumber(iter_2_1[var_2_2])

				local var_2_3 = var_2_2 + 1

				var_2_1.awardList = arg_2_0:parseContains(iter_2_1[var_2_3])

				local var_2_4 = var_2_3 + 1

				table.insert(arg_2_0.records, var_2_1)
			end
		end
	end

	local function var_2_5(arg_3_0, arg_3_1)
		return arg_3_0.score < arg_3_1.score
	end

	table.sort(arg_2_0.records, var_2_5)

	return arg_2_0
end

function zbBgzScoreAwardTable.parseContains(arg_4_0, arg_4_1)
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
		local var_4_8 = {
			awardType = tonumber(iter_4_1[1]),
			awardId = tonumber(iter_4_1[2]),
			awardNum = tonumber(iter_4_1[3])
		}

		zbGetWayItemTable:addItemNewWaysShop(var_4_8.awardId, EItemGetWayType.GetWay_YuanzhengJiFen, var_4_8.awardType)

		var_4_6[var_4_7] = var_4_8
		var_4_7 = var_4_7 + 1
	end

	return var_4_6
end

function zbBgzScoreAwardTable.getTotalPage(arg_5_0, arg_5_1)
	local var_5_0 = 1

	return (math.ceil(table.getn(arg_5_0.records) / arg_5_1))
end

function zbBgzScoreAwardTable.getRecordsByPage(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = {}

	for iter_6_0 = (arg_6_1 - 1) * arg_6_2 + 1, arg_6_1 * arg_6_2 do
		if arg_6_0.records[iter_6_0] then
			table.insert(var_6_0, arg_6_0.records[iter_6_0])
		end
	end

	return var_6_0
end

function zbBgzScoreAwardTable.getAwardByScore(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.records[arg_7_1]

	if var_7_0 ~= nil then
		return var_7_0.awardList
	end

	return nil
end
