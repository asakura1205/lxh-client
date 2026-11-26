require("gamebase.zbLoadCSV")

local var_0_0 = class("zbWorldTaskRecord")

var_0_0.__index = var_0_0

function createWorldTaskRecord()
	return (var_0_0.new())
end

zbWorldTaskTable = {}
zbWorldTaskTable.records = {}

function zbWorldTaskTable.load(arg_2_0, arg_2_1)
	local var_2_0 = require(arg_2_1)

	if var_2_0 == nil then
		return
	end

	if type(var_2_0) == "table" then
		local var_2_1 = 1

		for iter_2_0, iter_2_1 in pairs(var_2_0) do
			if iter_2_0 == 1 or iter_2_0 == 2 or iter_2_1[1] == "" then
				-- block empty
			else
				local var_2_2 = tonumber(iter_2_1[1])
				local var_2_3 = createWorldTaskRecord()
				local var_2_4 = 1

				var_2_3.id = tonumber(iter_2_1[var_2_4])

				local var_2_5 = var_2_4 + 1

				var_2_3.name = iter_2_1[var_2_5]

				local var_2_6 = var_2_5 + 1

				var_2_3.needTm = tonumber(iter_2_1[var_2_6])

				local var_2_7 = var_2_6 + 1

				var_2_3.needFightValue = tonumber(iter_2_1[var_2_7])

				local var_2_8 = var_2_7 + 1

				var_2_3.maxTeamCnt = tonumber(iter_2_1[var_2_8])

				local var_2_9 = var_2_8 + 1

				var_2_3.needFood = tonumber(iter_2_1[var_2_9])

				local var_2_10 = var_2_9 + 1

				var_2_3.award = arg_2_0:parseContains(iter_2_1[var_2_10])

				local var_2_11 = var_2_10 + 1

				var_2_3.awardPreview = arg_2_0:parseContains(iter_2_1[var_2_11])

				local var_2_12 = var_2_11 + 1

				var_2_3.desc = iter_2_1[var_2_12]

				local var_2_13 = var_2_12 + 1

				arg_2_0.records[var_2_1] = var_2_3
				var_2_1 = var_2_1 + 1

				for iter_2_2, iter_2_3 in pairs(var_2_3.awardPreview) do
					zbGetWayItemTable:addItem(EItemGetWayType.GetWay_WorldTask, iter_2_3)
				end
			end
		end
	end

	return arg_2_0
end

function zbWorldTaskTable.parseContains(arg_3_0, arg_3_1)
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
		var_3_6[var_3_7] = {
			awardType = tonumber(iter_3_1[1]),
			awardId = tonumber(iter_3_1[2]),
			awardCount = tonumber(iter_3_1[3])
		}
		var_3_7 = var_3_7 + 1
	end

	return var_3_6
end

function zbWorldTaskTable.getRecord(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.records) do
		if iter_4_1.id == arg_4_1 then
			return iter_4_1
		end
	end
end
