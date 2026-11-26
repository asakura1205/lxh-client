require("gamebase.zbLoadCSV")

local var_0_0 = class("zbHeroQualityUpgradeRecord")

var_0_0.__index = var_0_0

function creatHeroQualityUpgradeRecord()
	return (var_0_0.new())
end

zbHeroQualityUpgradeTable = {}
zbHeroQualityUpgradeTable.records = {}

function zbHeroQualityUpgradeTable.load(arg_2_0, arg_2_1)
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
				local var_2_2 = creatHeroQualityUpgradeRecord()
				local var_2_3 = 1

				var_2_2.id = tonumber(iter_2_1[var_2_3])

				local var_2_4 = var_2_3 + 1

				var_2_2.quality = tonumber(iter_2_1[var_2_4])

				local var_2_5 = var_2_4 + 1

				var_2_2.heroLvl = tonumber(iter_2_1[var_2_5])

				local var_2_6 = var_2_5 + 1

				var_2_2.gold = tonumber(iter_2_1[var_2_6])

				local var_2_7 = var_2_6 + 1

				var_2_2.item = arg_2_0:parseContains(iter_2_1[var_2_7])

				local var_2_8 = var_2_7 + 1

				var_2_2.attrPhase = tonumber(iter_2_1[var_2_8])

				local var_2_9 = var_2_8 + 1

				var_2_2.desc = iter_2_1[var_2_9]

				local var_2_10 = var_2_9 + 1
				local var_2_11 = arg_2_0.records[var_2_1]

				if var_2_11 == nil then
					var_2_11 = {}
					arg_2_0.records[var_2_1] = var_2_11
				end

				var_2_11[var_2_2.quality] = var_2_2
			end
		end
	end

	return arg_2_0
end

function zbHeroQualityUpgradeTable.parseContains(arg_3_0, arg_3_1)
	local var_3_0 = {}
	local var_3_1 = string.len(arg_3_1)
	local var_3_2 = string.sub(arg_3_1, 2, var_3_1 - 1)
	local var_3_3 = string.gsub(arg_3_1, "%[", "{")
	local var_3_4 = string.gsub(var_3_3, "%]", "}")
	local var_3_5 = wzUnserialize(var_3_4)

	if type(var_3_5) == "number" then
		local var_3_6 = {}

		table.insert(var_3_6, var_3_5)

		return var_3_6
	end

	return var_3_5
end

function zbHeroQualityUpgradeTable.getRecord(arg_4_0, arg_4_1, arg_4_2)
	return arg_4_0.records[arg_4_1][arg_4_2]
end
