require("gamebase.zbLoadCSV")

local var_0_0 = class("zbTaskRecord")

var_0_0.__index = var_0_0

function createFvAttrRecord()
	return (var_0_0.new())
end

zbFvAttrTable = {}
zbFvAttrTable.records = {}

function zbFvAttrTable.load(arg_2_0, arg_2_1)
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
				local var_2_2 = createFvAttrRecord()
				local var_2_3 = 1

				var_2_2.attr = tonumber(iter_2_1[var_2_3])

				local var_2_4 = var_2_3 + 1

				var_2_2.value = tonumber(iter_2_1[var_2_4])

				local var_2_5 = var_2_4 + 1

				arg_2_0.records[var_2_1] = var_2_2
			end
		end
	end

	return arg_2_0
end

function zbFvAttrTable.getRecord(arg_3_0, arg_3_1)
	return arg_3_0.records[arg_3_1]
end
