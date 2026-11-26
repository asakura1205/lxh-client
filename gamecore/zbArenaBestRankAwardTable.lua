require("gamebase.zbLoadCSV")

local var_0_0 = class("zbArenaBestRankAwardRecord")

var_0_0.__index = var_0_0

function createArenaBestRankAwardRecord()
	return (var_0_0.new())
end

zbArenaBestRankAwardTable = {}
zbArenaBestRankAwardTable.records = {}

function zbArenaBestRankAwardTable.load(arg_2_0, arg_2_1)
	local var_2_0 = require(arg_2_1)

	if var_2_0 == nil then
		return
	end

	if type(var_2_0) == "table" then
		for iter_2_0, iter_2_1 in pairs(var_2_0) do
			if iter_2_0 == 1 or iter_2_0 == 2 or iter_2_1[1] == "" then
				-- block empty
			else
				local var_2_1 = createArenaBestRankAwardRecord()

				var_2_1.rank = tonumber(iter_2_1[1])
				var_2_1.diamond = tonumber(iter_2_1[2])

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

function zbArenaBestRankAwardTable.getBestRankAward(arg_4_0, arg_4_1, arg_4_2)
	arg_4_1 = tonumber(arg_4_1)
	arg_4_2 = tonumber(arg_4_2)

	if arg_4_1 <= arg_4_2 then
		return 0
	end

	local var_4_0 = 0
	local var_4_1 = 0
	local var_4_2 = false
	local var_4_3 = false
	local var_4_4 = 0
	local var_4_5 = 0

	for iter_4_0, iter_4_1 in pairs(arg_4_0.records) do
		if var_4_2 == false then
			if arg_4_1 >= iter_4_1.rank then
				var_4_0 = iter_4_1.rank
			else
				var_4_2 = true
			end
		end

		if var_4_3 == false then
			if arg_4_2 >= iter_4_1.rank then
				var_4_1 = iter_4_1.rank
				var_4_5 = iter_4_1.diamond
			else
				var_4_3 = true
			end
		end

		if var_4_3 then
			if var_4_2 then
				if var_4_0 == var_4_1 then
					var_4_4 = var_4_5 * (arg_4_1 - arg_4_2)

					break
				end

				var_4_4 = var_4_4 + var_4_5 * (arg_4_1 - var_4_0)

				break
			else
				var_4_4 = var_4_4 + var_4_5 * (iter_4_1.rank - arg_4_2)
				arg_4_2 = iter_4_1.rank
			end
		end

		var_4_5 = iter_4_1.diamond
	end

	return var_4_4
end
