require("gamebase.zbLoadCSV")

local var_0_0 = class("zbWorldBossRankAwardRecord")

var_0_0.__index = var_0_0

function creatWorldBossRankAwardRecord()
	return (var_0_0.new())
end

zbWorldBossRankAwardTable = {}
zbWorldBossRankAwardTable.records = {}

function zbWorldBossRankAwardTable.load(arg_2_0, arg_2_1)
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
				local var_2_2 = creatWorldBossRankAwardRecord()
				local var_2_3 = 1

				var_2_2.rank = tonumber(iter_2_1[var_2_3])

				local var_2_4 = var_2_3 + 1

				var_2_2.award = arg_2_0:parseAwardItemContains(iter_2_1[var_2_4])

				local var_2_5 = var_2_4 + 1

				table.insert(arg_2_0.records, var_2_2)
			end
		end
	end

	local function var_2_6(arg_3_0, arg_3_1)
		return arg_3_0.rank < arg_3_1.rank
	end

	table.sort(arg_2_0.records, var_2_6)

	return arg_2_0
end

function zbWorldBossRankAwardTable.parseAwardItemContains(arg_4_0, arg_4_1)
	local var_4_0 = {}
	local var_4_1 = string.len(arg_4_1)
	local var_4_2 = string.sub(arg_4_1, 2, var_4_1 - 1)
	local var_4_3 = string.gsub(arg_4_1, "%[", "{")
	local var_4_4 = string.gsub(var_4_3, "%]", "}")
	local var_4_5 = wzUnserialize(var_4_4)
	local var_4_6 = {}

	for iter_4_0, iter_4_1 in pairs(var_4_5) do
		local var_4_7 = {
			Type = tonumber(iter_4_1[1]),
			Id = tonumber(iter_4_1[2]),
			Count = tonumber(iter_4_1[3])
		}

		table.insert(var_4_6, var_4_7)
	end

	return var_4_6
end

function zbWorldBossRankAwardTable.getRankAward(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.records) do
		if arg_5_1 <= iter_5_1.rank then
			return iter_5_1.award
		end
	end

	return {}
end
