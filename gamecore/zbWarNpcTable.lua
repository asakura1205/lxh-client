require("gamebase.zbLoadCSV")

local var_0_0 = class("zbWarNpcRecord")

var_0_0.__index = var_0_0

function createWarNpcRecord()
	return (var_0_0.new())
end

zbWarNpcTable = {}
zbWarNpcTable.records = {}

function zbWarNpcTable.load(arg_2_0, arg_2_1)
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
				local var_2_2 = createWarNpcRecord()
				local var_2_3 = 1

				var_2_2.id = tonumber(iter_2_1[var_2_3])

				local var_2_4 = var_2_3 + 1

				var_2_2.heroList = {}

				for iter_2_2 = 1, 5 do
					local var_2_5 = {
						templateId = tonumber(iter_2_1[var_2_4])
					}

					var_2_4 = var_2_4 + 1
					var_2_5.level = tonumber(iter_2_1[var_2_4])
					var_2_4 = var_2_4 + 1
					var_2_5.formationIndex = tonumber(iter_2_1[var_2_4])
					var_2_4 = var_2_4 + 1
					var_2_5.difficult = tonumber(iter_2_1[var_2_4])
					var_2_4 = var_2_4 + 1
					var_2_5.boss = tonumber(iter_2_1[var_2_4])
					var_2_4 = var_2_4 + 1
					var_2_5.quality = 7
					var_2_2.heroList[iter_2_2] = var_2_5
				end

				arg_2_0.records[var_2_1] = var_2_2
			end
		end
	end

	return arg_2_0
end

function zbWarNpcTable.getRecord(arg_3_0, arg_3_1)
	if arg_3_1 == nil or arg_3_1 <= 0 then
		return nil
	end

	return arg_3_0.records[arg_3_1]
end
