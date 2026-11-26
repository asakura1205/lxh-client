require("gamebase.zbLoadCSV")

local var_0_0 = class("zbTaskRecord")

var_0_0.__index = var_0_0

function createPataBuffBaseRecord()
	return (var_0_0.new())
end

zbPataBuffBaseTable = {}
zbPataBuffBaseTable.records = {}

function zbPataBuffBaseTable.load(arg_2_0, arg_2_1)
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
				local var_2_2 = createPataBuffBaseRecord()
				local var_2_3 = 1

				var_2_2.buffId = tonumber(iter_2_1[var_2_3])

				local var_2_4 = var_2_3 + 1

				var_2_2.skillIndex = tonumber(iter_2_1[var_2_4])

				local var_2_5 = var_2_4 + 1

				var_2_2.cost = arg_2_0:parseContains(iter_2_1[var_2_5])

				local var_2_6 = var_2_5 + 1

				var_2_2.weight = tonumber(iter_2_1[var_2_6])

				local var_2_7 = var_2_6 + 1

				var_2_2.times = tonumber(iter_2_1[var_2_7])

				local var_2_8 = var_2_7 + 1

				arg_2_0.records[var_2_1] = var_2_2
			end
		end
	end

	return arg_2_0
end

function zbPataBuffBaseTable.getRecord(arg_3_0, arg_3_1)
	return arg_3_0.records[arg_3_1]
end

function zbPataBuffBaseTable.parseContains(arg_4_0, arg_4_1)
	local var_4_0 = {}
	local var_4_1 = string.len(arg_4_1)
	local var_4_2 = string.sub(arg_4_1, 2, var_4_1 - 1)
	local var_4_3 = string.gsub(arg_4_1, "%[", "{")
	local var_4_4 = string.gsub(var_4_3, "%]", "}")
	local var_4_5 = wzUnserialize(var_4_4)

	if type(var_4_5) == "number" then
		return nil
	end

	local var_4_6 = 1
	local var_4_7 = {}

	for iter_4_0, iter_4_1 in pairs(var_4_5) do
		var_4_7.type = tonumber(iter_4_1[1])
		var_4_7.id = tonumber(iter_4_1[2])
		var_4_7.count = tonumber(iter_4_1[3])
	end

	return var_4_7
end
