require("gamebase.zbLoadCSV")

local var_0_0 = class("zbBuffRecord")

var_0_0.__index = var_0_0

function createBuffRecord()
	return (var_0_0.new())
end

zbBuffTable = {}
zbBuffTable.records = {}

function zbBuffTable.load(arg_2_0, arg_2_1)
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
				local var_2_2 = createBuffRecord()

				var_2_2.id = tonumber(iter_2_1[1])
				var_2_2.name = iter_2_1[2]
				var_2_2.description = iter_2_1[3]
				var_2_2.buffType = tonumber(iter_2_1[4])
				var_2_2.pataDesc = tonumber(iter_2_1[5])
				var_2_2.param1 = tonumber(iter_2_1[6])
				var_2_2.param2 = tonumber(iter_2_1[7])
				var_2_2.round = tonumber(iter_2_1[8])
				var_2_2.replaceadd = tonumber(iter_2_1[9])
				var_2_2.canClear = tonumber(iter_2_1[10]) ~= 0
				var_2_2.bossImmune = tonumber(iter_2_1[11]) == 1
				arg_2_0.records[var_2_1] = var_2_2
			end
		end
	end

	return arg_2_0
end

function zbBuffTable.getRecord(arg_3_0, arg_3_1)
	return arg_3_0.records[arg_3_1]
end
