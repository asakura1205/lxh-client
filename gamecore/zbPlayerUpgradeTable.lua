require("gamebase.zbLoadCSV")

local var_0_0 = class("zbPlayerUpgradeRecord")

var_0_0.__index = var_0_0

function createPlayerUpgradeRecord()
	return (var_0_0.new())
end

zbPlayerUpgradeTable = {}
zbPlayerUpgradeTable.records = {}

function zbPlayerUpgradeTable.load(arg_2_0, arg_2_1)
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
				local var_2_2 = createPlayerUpgradeRecord()
				local var_2_3 = 1

				var_2_2.lvl = tonumber(iter_2_1[var_2_3])

				local var_2_4 = var_2_3 + 1

				var_2_2.exp = tonumber(iter_2_1[var_2_4])

				local var_2_5 = var_2_4 + 1

				var_2_2.tili = tonumber(iter_2_1[var_2_5])

				local var_2_6 = var_2_5 + 1

				arg_2_0.records[var_2_1] = var_2_2
			end
		end
	end

	return arg_2_0
end

function zbPlayerUpgradeTable.getRecord(arg_3_0, arg_3_1)
	return arg_3_0.records[arg_3_1]
end

function zbPlayerUpgradeTable.getExpNeed(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.records[arg_4_1]

	if var_4_0 ~= nil then
		return var_4_0.exp
	else
		return 0
	end
end

function zbPlayerUpgradeTable.getLevelAward(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.records[arg_5_1]

	if var_5_0 ~= nil then
		return var_5_0.tili
	else
		return 0
	end
end
