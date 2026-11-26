require("gamebase.zbLoadCSV")

local var_0_0 = class("zbHeroMainAttrUpgradeRecord")

var_0_0.__index = var_0_0

function creatHeroMainAttrUpgradeRecord()
	return (var_0_0.new())
end

zbHeroMainAttrUpgradeTable = {}
zbHeroMainAttrUpgradeTable.records = {}

function zbHeroMainAttrUpgradeTable.load(arg_2_0, arg_2_1)
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
				local var_2_2 = creatHeroMainAttrUpgradeRecord()
				local var_2_3 = 1

				var_2_2.id = tonumber(iter_2_1[var_2_3])

				local var_2_4 = var_2_3 + 1

				var_2_2.lvl = tonumber(iter_2_1[var_2_4])

				local var_2_5 = var_2_4 + 1

				var_2_2.max = tonumber(iter_2_1[var_2_5])

				local var_2_6 = var_2_5 + 1

				var_2_2.unlockLvl = tonumber(iter_2_1[var_2_6])

				local var_2_7 = var_2_6 + 1

				var_2_2.cost = tonumber(iter_2_1[var_2_7])

				local var_2_8 = var_2_7 + 1

				var_2_2.itemRange = arg_2_0:parseContains(iter_2_1[var_2_8])

				local var_2_9 = var_2_8 + 1

				var_2_2.itemCost = tonumber(iter_2_1[var_2_9])

				local var_2_10 = var_2_9 + 1

				var_2_2.diamondRange = arg_2_0:parseContains(iter_2_1[var_2_10])

				local var_2_11 = var_2_10 + 1

				var_2_2.diamondCost = tonumber(iter_2_1[var_2_11])

				local var_2_12 = var_2_11 + 1

				var_2_2.desc = tonumber(iter_2_1[var_2_12])

				local var_2_13 = var_2_12 + 1
				local var_2_14 = arg_2_0.records[var_2_1]

				if var_2_14 == nil then
					var_2_14 = {}
					arg_2_0.records[var_2_1] = var_2_14
				end

				var_2_14[var_2_2.lvl] = var_2_2
			end
		end
	end

	return arg_2_0
end

function zbHeroMainAttrUpgradeTable.parseContains(arg_3_0, arg_3_1)
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

function zbHeroMainAttrUpgradeTable.getRecord(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_2 <= 0 then
		arg_4_2 = 1
	end

	return arg_4_0.records[arg_4_1][arg_4_2]
end

function zbHeroMainAttrUpgradeTable.getMaxlvlCurrLevel(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.records[arg_5_1]

	if var_5_0 == nil then
		return 50
	end

	local var_5_1 = 0

	for iter_5_0, iter_5_1 in pairs(var_5_0) do
		if arg_5_2 >= iter_5_1.unlockLvl and var_5_1 < iter_5_1.lvl then
			var_5_1 = iter_5_1.lvl
		end
	end

	return (math.min(var_5_1 + 1, 50))
end
