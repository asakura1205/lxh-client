require("gamebase.zbLoadCSV")

local var_0_0 = class("zbWarNodeRecord")

var_0_0.__index = var_0_0

function createWarNodeRecord()
	return (var_0_0.new())
end

zbWarNodeTable = {}
zbWarNodeTable.records = {}

function zbWarNodeTable.load(arg_2_0, arg_2_1)
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
				local var_2_2 = createWarNodeRecord()
				local var_2_3 = 1

				var_2_2.nodeId = tonumber(iter_2_1[var_2_3])

				local var_2_4 = var_2_3 + 1

				var_2_2.name = tonumber(iter_2_1[var_2_4])

				local var_2_5 = var_2_4 + 1

				var_2_2.hpMax = tonumber(iter_2_1[var_2_5])

				local var_2_6 = var_2_5 + 1

				var_2_2.dailyMaxHP = tonumber(iter_2_1[var_2_6])

				local var_2_7 = var_2_6 + 1

				var_2_2.iWinAwardList = arg_2_0:parseContains(iter_2_1[var_2_7])

				local var_2_8 = var_2_7 + 1

				var_2_2.iWinLossHP = tonumber(iter_2_1[var_2_8])

				local var_2_9 = var_2_8 + 1

				var_2_2.foodRepair = tonumber(iter_2_1[var_2_9])

				local var_2_10 = var_2_9 + 1

				var_2_2.diamondRepair = tonumber(iter_2_1[var_2_10])

				local var_2_11 = var_2_10 + 1

				var_2_2.foodRepairAwardList = arg_2_0:parseContains(iter_2_1[var_2_11])

				local var_2_12 = var_2_11 + 1

				var_2_2.diamondRepairAwardList = arg_2_0:parseContains(iter_2_1[var_2_12])

				local var_2_13 = var_2_12 + 1

				var_2_2.attackLegionMax = tonumber(iter_2_1[var_2_13])

				local var_2_14 = var_2_13 + 1

				var_2_2.aWinAwardList = arg_2_0:parseContains(iter_2_1[var_2_14])

				local var_2_15 = var_2_14 + 1

				var_2_2.aWinLossHP = tonumber(iter_2_1[var_2_15])

				local var_2_16 = var_2_15 + 1

				var_2_2.aiWinScore = tonumber(iter_2_1[var_2_16])

				local var_2_17 = var_2_16 + 1

				var_2_2.awardList1 = arg_2_0:parseContains(iter_2_1[var_2_17])

				local var_2_18 = var_2_17 + 1

				var_2_2.awardList2 = arg_2_0:parseContains(iter_2_1[var_2_18])

				local var_2_19 = var_2_18 + 1

				var_2_2.awardList3 = arg_2_0:parseContains(iter_2_1[var_2_19])

				local var_2_20 = var_2_19 + 1

				var_2_2.buildNode = {}

				for iter_2_2 = 1, 5 do
					local var_2_21 = {
						buildName = iter_2_1[var_2_20]
					}

					var_2_20 = var_2_20 + 1
					var_2_21.buildIcon = iter_2_1[var_2_20]
					var_2_20 = var_2_20 + 1
					var_2_21.buildPre = arg_2_0:parseSkillSequence(iter_2_1[var_2_20])
					var_2_20 = var_2_20 + 1
					var_2_21.buildBuff = tonumber(iter_2_1[var_2_20])
					var_2_20 = var_2_20 + 1
					var_2_21.buildHPRatio = tonumber(iter_2_1[var_2_20])
					var_2_20 = var_2_20 + 1
					var_2_21.buildNpc = tonumber(iter_2_1[var_2_20])
					var_2_20 = var_2_20 + 1
					var_2_21.buildDesc = iter_2_1[var_2_20]
					var_2_20 = var_2_20 + 1
					var_2_2.buildNode[iter_2_2] = var_2_21
				end

				arg_2_0.records[var_2_1] = var_2_2
			end
		end
	end

	return arg_2_0
end

function zbWarNodeTable.parseSkillSequence(arg_3_0, arg_3_1)
	local var_3_0 = string.gsub(arg_3_1, "%[", "{")
	local var_3_1 = string.gsub(var_3_0, "%]", "}")

	ret = wzUnserialize(var_3_1)

	local var_3_2 = wzUnserialize(var_3_1)
	local var_3_3 = {}

	for iter_3_0, iter_3_1 in pairs(var_3_2) do
		var_3_3[iter_3_0] = tonumber(iter_3_1)
	end

	return var_3_3
end

function zbWarNodeTable.parseContains(arg_4_0, arg_4_1)
	local var_4_0 = {}
	local var_4_1 = string.len(arg_4_1)
	local var_4_2 = string.sub(arg_4_1, 2, var_4_1 - 1)
	local var_4_3 = string.gsub(arg_4_1, "%[", "{")
	local var_4_4 = string.gsub(var_4_3, "%]", "}")
	local var_4_5 = wzUnserialize(var_4_4)

	if type(var_4_5) == "number" then
		return nil
	end

	local var_4_6 = {}
	local var_4_7 = 1

	for iter_4_0, iter_4_1 in pairs(var_4_5) do
		var_4_6[var_4_7] = {
			type = tonumber(iter_4_1[1]),
			id = tonumber(iter_4_1[2]),
			count = tonumber(iter_4_1[3])
		}
		var_4_7 = var_4_7 + 1
	end

	return var_4_6
end

function zbWarNodeTable.getRecord(arg_5_0, arg_5_1)
	if arg_5_1 == nil or arg_5_1 <= 0 then
		return nil
	end

	return arg_5_0.records[arg_5_1]
end
