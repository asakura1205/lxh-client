require("gamebase.zbLoadCSV")

local var_0_0 = class("zbWorldNpcRecord")

var_0_0.__index = var_0_0

function createWorldNpcRecord()
	return (var_0_0.new())
end

zbWorldNpcTable = {}
zbWorldNpcTable.records = {}

function zbWorldNpcTable.load(arg_2_0, arg_2_1)
	local var_2_0 = require(arg_2_1)

	if var_2_0 == nil then
		return
	end

	if type(var_2_0) == "table" then
		for iter_2_0, iter_2_1 in pairs(var_2_0) do
			if iter_2_0 == 1 or iter_2_0 == 2 or iter_2_1[1] == "" then
				-- block empty
			else
				local var_2_1 = createWorldNpcRecord()

				var_2_1.npcID = tonumber(iter_2_1[1])
				var_2_1.heroList = {}

				for iter_2_2 = 0, 4 do
					local var_2_2 = 2 + iter_2_2 * 4

					if iter_2_1[var_2_2] ~= "" and tonumber(iter_2_1[var_2_2]) ~= 0 then
						local var_2_3 = {
							templateId = tonumber(iter_2_1[var_2_2]),
							formationIndex = tonumber(iter_2_1[var_2_2 + 1]),
							boss = tonumber(iter_2_1[var_2_2 + 2]),
							quality = tonumber(iter_2_1[var_2_2 + 3])
						}

						table.insert(var_2_1.heroList, var_2_3)
					end
				end

				arg_2_0.records[var_2_1.npcID] = var_2_1
			end
		end
	end

	return arg_2_0
end

function zbWorldNpcTable.getRecord(arg_3_0, arg_3_1)
	return arg_3_0.records[arg_3_1]
end
