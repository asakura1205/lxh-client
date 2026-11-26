zbForceLevelAwardTable = {}
zbForceLevelAwardTable.records = {}

function zbForceLevelAwardTable.load(arg_1_0, arg_1_1)
	local var_1_0 = require(arg_1_1)

	if var_1_0 == nil then
		return
	end

	if type(var_1_0) == "table" then
		for iter_1_0, iter_1_1 in pairs(var_1_0) do
			if iter_1_0 == 1 or iter_1_0 == 2 or iter_1_1[1] == "" then
				-- block empty
			else
				local var_1_1 = {
					awardID = tonumber(iter_1_1[1]),
					awardList = {}
				}

				for iter_1_2 = 0, 4 do
					local var_1_2 = 2 + iter_1_2 * 4

					if iter_1_1[var_1_2] ~= "" then
						local var_1_3 = {
							awardType = tonumber(iter_1_1[var_1_2]),
							awardId = tonumber(iter_1_1[var_1_2 + 1]),
							awardCount = tonumber(iter_1_1[var_1_2 + 2]),
							dropRate = tonumber(iter_1_1[var_1_2 + 3])
						}

						table.insert(var_1_1.awardList, var_1_3)
					end
				end

				arg_1_0.records[var_1_1.awardID] = var_1_1
			end
		end
	end

	return arg_1_0
end

function zbForceLevelAwardTable.getRecord(arg_2_0, arg_2_1)
	return arg_2_0.records[arg_2_1]
end
