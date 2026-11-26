require("gamebase.zbLoadCSV")

local var_0_0 = class("zbForceStarAwardRecord")

var_0_0.__index = var_0_0

function createForceStarAwardRecord()
	return (var_0_0.new())
end

zbForceStarAwardTable = {}
zbForceStarAwardTable.records = {}

function zbForceStarAwardTable.load(arg_2_0, arg_2_1)
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
				local var_2_2 = createForceStarAwardRecord()
				local var_2_3 = 1

				var_2_2.forceId = tonumber(iter_2_1[var_2_3])

				local var_2_4 = var_2_3 + 1

				var_2_2.starNormal = tonumber(iter_2_1[var_2_4])

				local var_2_5 = var_2_4 + 1

				var_2_2.awardNormal = arg_2_0:parseContains(iter_2_1[var_2_5])

				local var_2_6 = var_2_5 + 1

				var_2_2.starElite = tonumber(iter_2_1[var_2_6])

				local var_2_7 = var_2_6 + 1

				var_2_2.awardElite = arg_2_0:parseContains(iter_2_1[var_2_7])

				local var_2_8 = var_2_7 + 1

				var_2_2.starNightware = tonumber(iter_2_1[var_2_8])

				local var_2_9 = var_2_8 + 1

				var_2_2.awardNightware = arg_2_0:parseContains(iter_2_1[var_2_9])

				local var_2_10 = var_2_9 + 1

				table.insert(arg_2_0.records, var_2_2)
			end
		end
	end

	return arg_2_0
end

function zbForceStarAwardTable.parseContains(arg_3_0, arg_3_1)
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

function zbForceStarAwardTable.getRecord(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.records) do
		if iter_4_1.forceId == arg_4_2 then
			if arg_4_1 == ELevelType.Normal and iter_4_1.starNormal == arg_4_3 then
				return iter_4_1.awardNormal
			elseif arg_4_1 == ELevelType.Elite and iter_4_1.starElite == arg_4_3 then
				return iter_4_1.awardElite
			elseif arg_4_1 == ELevelType.Nightmare and iter_4_1.starNightware == arg_4_3 then
				return iter_4_1.awardNightware
			end
		end
	end

	return nil
end
