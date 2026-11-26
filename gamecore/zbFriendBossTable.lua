require("gamebase.zbLoadCSV")

zbFriendBossTable = {}
zbFriendBossTable.records = {}

function zbFriendBossTable.load(arg_1_0, arg_1_1)
	local var_1_0 = require(arg_1_1)

	if var_1_0 == nil then
		return
	end

	if type(var_1_0) == "table" then
		for iter_1_0, iter_1_1 in pairs(var_1_0) do
			if iter_1_0 == 1 or iter_1_0 == 2 or iter_1_1[1] == "" then
				-- block empty
			else
				local var_1_1 = 1
				local var_1_2 = {
					level = tonumber(iter_1_1[1])
				}
				local var_1_3 = var_1_1 + 1

				var_1_2.bossInfo = {}

				for iter_1_2 = 1, 2 do
					local var_1_4 = {}

					var_1_2.templateId = tonumber(iter_1_1[var_1_3])
					var_1_3 = var_1_3 + 1
					var_1_2.index = tonumber(iter_1_1[var_1_3])
					var_1_3 = var_1_3 + 1
					var_1_2.difficult = tonumber(iter_1_1[var_1_3])
					var_1_3 = var_1_3 + 1
					var_1_4.victoryAward = arg_1_0:parseContains(iter_1_1[var_1_3])
					var_1_3 = var_1_3 + 1
					var_1_4.discoveryAward = arg_1_0:parseContains(iter_1_1[var_1_3])
					var_1_3 = var_1_3 + 1
					var_1_4.participationAward = arg_1_0:parseContains(iter_1_1[var_1_3])
					var_1_3 = var_1_3 + 1
					var_1_4.killAward = arg_1_0:parseContains(iter_1_1[var_1_3])
					var_1_3 = var_1_3 + 1
					var_1_4.time = tonumber(iter_1_1[var_1_3])
					var_1_3 = var_1_3 + 1
					var_1_4.desc = iter_1_1[var_1_3]
					var_1_3 = var_1_3 + 1
					var_1_2.bossInfo[iter_1_2] = var_1_4
				end

				arg_1_0.records[var_1_2.level] = var_1_2
			end
		end
	end

	return arg_1_0
end

function zbFriendBossTable.parseContains(arg_2_0, arg_2_1)
	local var_2_0 = {}
	local var_2_1 = string.len(arg_2_1)
	local var_2_2 = string.sub(arg_2_1, 2, var_2_1 - 1)
	local var_2_3 = string.gsub(arg_2_1, "%[", "{")
	local var_2_4 = string.gsub(var_2_3, "%]", "}")
	local var_2_5 = wzUnserialize(var_2_4)

	if type(var_2_5) == "number" then
		local var_2_6 = {}

		table.insert(var_2_6, var_2_5)

		return var_2_6
	end

	return var_2_5
end

function zbFriendBossTable.getRecord(arg_3_0, arg_3_1)
	if arg_3_1 == nil or arg_3_1 <= 0 then
		return nil
	end

	return arg_3_0.records[arg_3_1]
end
