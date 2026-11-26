require("gamebase.zbLoadCSV")

local var_0_0 = class("zbArenaDailyAwardRecord")

var_0_0.__index = var_0_0

function createArenaDailyAwardRecord()
	return (var_0_0.new())
end

zbArenaDailyAwardTable = {}
zbArenaDailyAwardTable.records = {}

function zbArenaDailyAwardTable.load(arg_2_0, arg_2_1)
	local var_2_0 = require(arg_2_1)

	if var_2_0 == nil then
		return
	end

	if type(var_2_0) == "table" then
		for iter_2_0, iter_2_1 in pairs(var_2_0) do
			if iter_2_0 == 1 or iter_2_0 == 2 or iter_2_1[1] == "" then
				-- block empty
			else
				local var_2_1 = createArenaDailyAwardRecord()

				var_2_1.rank = tonumber(iter_2_1[1])
				var_2_1.diamond = tonumber(iter_2_1[2])
				var_2_1.rankMoney = tonumber(iter_2_1[3])

				table.insert(arg_2_0.records, var_2_1)
			end
		end
	end

	local function var_2_2(arg_3_0, arg_3_1)
		return arg_3_0.rank < arg_3_1.rank
	end

	table.sort(arg_2_0.records, var_2_2)

	return arg_2_0
end

function zbArenaDailyAwardTable.getRecord(arg_4_0, arg_4_1)
	if arg_4_1 == nil then
		return nil
	end

	arg_4_1 = tonumber(arg_4_1)

	for iter_4_0, iter_4_1 in pairs(arg_4_0.records) do
		if arg_4_1 <= iter_4_1.rank then
			return arg_4_0.records[iter_4_0]
		end
	end

	return nil
end
