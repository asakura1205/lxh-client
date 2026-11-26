require("gamebase.zbLoadCSV")

local var_0_0 = class("zbWorldGridRecord")

var_0_0.__index = var_0_0

function createWorldGridRecord()
	return (var_0_0.new())
end

zbWorldGridTable = {}
zbWorldGridTable.records = {}

function zbWorldGridTable.load(arg_2_0, arg_2_1)
	local var_2_0 = require(arg_2_1)

	if var_2_0 == nil then
		return
	end

	if type(var_2_0) == "table" then
		local var_2_1 = 1

		for iter_2_0, iter_2_1 in pairs(var_2_0) do
			if iter_2_0 == 1 or iter_2_0 == 2 or iter_2_1[1] == "" then
				-- block empty
			else
				local var_2_2 = tonumber(iter_2_1[1])
				local var_2_3 = createWorldGridRecord()
				local var_2_4 = 1

				var_2_3.id = tonumber(iter_2_1[var_2_4])

				local var_2_5 = var_2_4 + 1

				var_2_3.pos = arg_2_0:parseContains(iter_2_1[var_2_5])

				local var_2_6 = var_2_5 + 1

				arg_2_0.records[var_2_1] = var_2_3
				var_2_1 = var_2_1 + 1
			end
		end
	end

	return arg_2_0
end

function zbWorldGridTable.parseContains(arg_3_0, arg_3_1)
	local var_3_0 = {}
	local var_3_1 = string.len(arg_3_1)
	local var_3_2 = string.sub(arg_3_1, 2, var_3_1 - 1)
	local var_3_3 = string.gsub(arg_3_1, "%[", "{")
	local var_3_4 = string.gsub(var_3_3, "%]", "}")
	local var_3_5 = wzUnserialize(var_3_4)

	if type(var_3_5) == "number" then
		return nil
	end

	local var_3_6 = {}
	local var_3_7 = 1

	for iter_3_0, iter_3_1 in pairs(var_3_5) do
		var_3_6[var_3_7] = tonumber(iter_3_1)
		var_3_7 = var_3_7 + 1
	end

	return var_3_6
end

function zbWorldGridTable.getRecord(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.records) do
		if iter_4_1.id == arg_4_1 then
			return iter_4_1
		end
	end
end
