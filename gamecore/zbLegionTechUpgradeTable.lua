require("gamebase.zbLoadCSV")

local var_0_0 = class("zbLegionTechUpgradeRecord")

var_0_0.__index = var_0_0

function creatLegionTechUpgradeRecord()
	return (var_0_0.new())
end

zbLegionTechUpgradeTable = {}
zbLegionTechUpgradeTable.records = {}

function zbLegionTechUpgradeTable.load(arg_2_0, arg_2_1)
	local var_2_0 = require(arg_2_1)

	if var_2_0 == nil then
		return
	end

	local var_2_1 = 1

	if type(var_2_0) == "table" then
		for iter_2_0, iter_2_1 in pairs(var_2_0) do
			if iter_2_0 == 1 or iter_2_0 == 2 or iter_2_1[1] == "" then
				-- block empty
			else
				local var_2_2 = creatLegionTechUpgradeRecord()
				local var_2_3 = 1

				var_2_2.id = tonumber(iter_2_1[var_2_3])

				local var_2_4 = var_2_3 + 1

				var_2_2.lv = tonumber(iter_2_1[var_2_4])

				local var_2_5 = var_2_4 + 1

				var_2_2.exp = tonumber(iter_2_1[var_2_5])

				local var_2_6 = var_2_5 + 1

				var_2_2.limit = tonumber(iter_2_1[var_2_6])

				local var_2_7 = var_2_6 + 1

				var_2_2.desc = iter_2_1[var_2_7]

				local var_2_8 = var_2_7 + 1

				arg_2_0.records[var_2_1] = var_2_2
				var_2_1 = var_2_1 + 1
			end
		end
	end

	return arg_2_0
end

function zbLegionTechUpgradeTable.getexpByIdAndLv(arg_3_0, arg_3_1, arg_3_2)
	echo("......id......lv.......", arg_3_1, arg_3_2)

	for iter_3_0, iter_3_1 in pairs(arg_3_0.records) do
		if iter_3_1.id == arg_3_1 and arg_3_2 == iter_3_1.lv then
			return iter_3_1.exp
		end
	end

	return 0
end

function zbLegionTechUpgradeTable.getlimitByIdAndLv(arg_4_0, arg_4_1, arg_4_2)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.records) do
		if iter_4_1.id == arg_4_1 and arg_4_2 == iter_4_1.lv then
			return iter_4_1.limit
		end
	end

	return 0
end

function zbLegionTechUpgradeTable.getdescByIdAndLv(arg_5_0, arg_5_1, arg_5_2)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.records) do
		if iter_5_1.id == arg_5_1 and arg_5_2 == iter_5_1.lv then
			return iter_5_1.desc
		end
	end

	return 0
end
