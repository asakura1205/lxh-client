require("gamebase.zbLoadCSV")

local var_0_0 = class("zbHeroUpgradeRecord")

var_0_0.__index = var_0_0

function createHeroUpgradeRecord()
	return (var_0_0.new())
end

zbHeroUpgradeTable = {}
zbHeroUpgradeTable.records = {}

function zbHeroUpgradeTable.load(arg_2_0, arg_2_1)
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
				local var_2_2 = createHeroUpgradeRecord()
				local var_2_3 = 1

				var_2_2.lvl = tonumber(iter_2_1[var_2_3])

				local var_2_4 = var_2_3 + 1

				var_2_2.exp = tonumber(iter_2_1[var_2_4])

				local var_2_5 = var_2_4 + 1

				arg_2_0.records[var_2_2.lvl] = var_2_2
			end
		end
	end

	return arg_2_0
end

function zbHeroUpgradeTable.getRecord(arg_3_0, arg_3_1)
	return arg_3_0.records[arg_3_1]
end

function zbHeroUpgradeTable.getHeroUpgradeNeedExp(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:getRecord(arg_4_1)

	if var_4_0 == nil then
		return 0
	else
		return var_4_0.exp
	end
end

function zbHeroUpgradeTable.getLevelExpAfterAddExp(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = arg_5_1
	local var_5_1 = arg_5_2
	local var_5_2 = 0
	local var_5_3 = arg_5_0.records[arg_5_1].exp - arg_5_2
	local var_5_4 = table.getn(arg_5_0.records)
	local var_5_5 = var_5_4
	local var_5_6 = arg_5_0.records[var_5_4].exp
	local var_5_7 = arg_5_0.records[var_5_4].exp

	for iter_5_0 = arg_5_1, var_5_4 - 2 do
		if arg_5_3 < var_5_3 then
			var_5_5 = iter_5_0
			var_5_6 = arg_5_0.records[var_5_5].exp - (var_5_3 - arg_5_3)
			var_5_7 = arg_5_0.records[var_5_5].exp

			break
		elseif var_5_3 == arg_5_3 then
			var_5_5 = iter_5_0 + 1
			var_5_6 = 0
			var_5_7 = arg_5_0.records[var_5_5].exp

			break
		end

		var_5_3 = var_5_3 + arg_5_0.records[iter_5_0 + 1].exp
	end

	if arg_5_4 < var_5_5 then
		var_5_5 = arg_5_4
		var_5_6 = arg_5_0.records[var_5_5 + 1].exp
		var_5_7 = arg_5_0.records[var_5_5 + 1].exp
	end

	return var_5_5, var_5_6, var_5_7
end
