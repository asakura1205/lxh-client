require("gamebase.zbLoadCSV")

local var_0_0 = class("zbLegionBossRecord")

var_0_0.__index = var_0_0

function creatLegionBossRecord()
	return (var_0_0.new())
end

zbLegionBossTable = {}
zbLegionBossTable.records = {}

function zbLegionBossTable.load(arg_2_0, arg_2_1)
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
				local var_2_2 = creatLegionBossRecord()
				local var_2_3 = 1

				var_2_2.id = tonumber(iter_2_1[var_2_3])

				local var_2_4 = var_2_3 + 1

				var_2_2.teampId = tonumber(iter_2_1[var_2_4])

				local var_2_5 = var_2_4 + 1

				var_2_2.level = tonumber(iter_2_1[var_2_5])

				local var_2_6 = var_2_5 + 1

				var_2_2.formationIndex = tonumber(iter_2_1[var_2_6])

				local var_2_7 = var_2_6 + 1

				var_2_2.difficult = tonumber(iter_2_1[var_2_7])

				local var_2_8 = var_2_7 + 1

				var_2_2.isboss = tonumber(iter_2_1[var_2_8])

				local var_2_9 = var_2_8 + 1

				var_2_2.combatAward = arg_2_0:parseAwardItemContains(iter_2_1[var_2_9])

				local var_2_10 = var_2_9 + 1

				var_2_2.passAward = arg_2_0:parseAwardItemContains(iter_2_1[var_2_10])
				var_2_2.icon = iter_2_1[var_2_10 + 1]
				arg_2_0.records[var_2_1] = var_2_2
			end
		end
	end

	return arg_2_0
end

function zbLegionBossTable.parseAwardItemContains(arg_3_0, arg_3_1)
	local var_3_0 = {}
	local var_3_1 = string.len(arg_3_1)
	local var_3_2 = string.sub(arg_3_1, 2, var_3_1 - 1)
	local var_3_3 = string.gsub(arg_3_1, "%[", "{")
	local var_3_4 = string.gsub(var_3_3, "%]", "}")
	local var_3_5 = wzUnserialize(var_3_4)
	local var_3_6 = {}

	for iter_3_0, iter_3_1 in pairs(var_3_5) do
		local var_3_7 = {
			awardType = tonumber(iter_3_1[1]),
			awardId = tonumber(iter_3_1[2]),
			awardNum = tonumber(iter_3_1[3])
		}

		table.insert(var_3_6, var_3_7)
	end

	return var_3_6
end

function zbLegionBossTable.getRecord(arg_4_0, arg_4_1)
	return arg_4_0.records[arg_4_1]
end
