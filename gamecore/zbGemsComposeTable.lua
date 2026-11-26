require("gamebase.zbLoadCSV")

local var_0_0 = class("wzGemsComposeRecord")

var_0_0.__index = var_0_0

function createGemsComposeRecord()
	return (var_0_0.new())
end

zbGemsComposeTable = {}
zbGemsComposeTable.records = {}

function zbGemsComposeTable.load(arg_2_0, arg_2_1)
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
				local var_2_2 = createGemsComposeRecord()
				local var_2_3 = 1

				var_2_2.level = tonumber(iter_2_1[var_2_3])

				local var_2_4 = var_2_3 + 1

				var_2_2.templateId = tonumber(iter_2_1[var_2_4])

				local var_2_5 = var_2_4 + 1

				var_2_2.weight = tonumber(iter_2_1[var_2_5])

				local var_2_6 = var_2_5 + 1

				var_2_2.desc = iter_2_1[var_2_6]

				local var_2_7 = var_2_6 + 1

				arg_2_0.records[var_2_1] = var_2_2
				var_2_1 = var_2_1 + 1
			end
		end
	end

	return arg_2_0
end

function zbGemsComposeTable.getRecordBylevel(arg_3_0, arg_3_1)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in pairs(arg_3_0.records) do
		if iter_3_1.level == arg_3_1 then
			table.insert(var_3_0, iter_3_1)
		end
	end

	return var_3_0
end
