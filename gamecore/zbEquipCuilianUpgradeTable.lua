require("gamebase.zbLoadCSV")

local var_0_0 = class("zbEquipCuilianUpgradeRecord")

var_0_0.__index = var_0_0

function createEquipCuilianUpgradeRecord()
	return (var_0_0.new())
end

zbEquipCuilianUpgradeTable = {}
zbEquipCuilianUpgradeTable.records = {}

function zbEquipCuilianUpgradeTable.load(arg_2_0, arg_2_1)
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
				local var_2_2 = createEquipCuilianUpgradeRecord()
				local var_2_3 = 1

				var_2_2.lvl = tonumber(iter_2_1[var_2_3])

				local var_2_4 = var_2_3 + 1

				var_2_2.green = tonumber(iter_2_1[var_2_4])

				local var_2_5 = var_2_4 + 1

				var_2_2.blue = tonumber(iter_2_1[var_2_5])

				local var_2_6 = var_2_5 + 1

				var_2_2.purple = tonumber(iter_2_1[var_2_6])

				local var_2_7 = var_2_6 + 1

				var_2_2.gold = tonumber(iter_2_1[var_2_7])

				local var_2_8 = var_2_7 + 1

				var_2_2.red = tonumber(iter_2_1[var_2_8])

				local var_2_9 = var_2_8 + 1

				var_2_2.black = tonumber(iter_2_1[var_2_9])

				local var_2_10 = var_2_9 + 1

				arg_2_0.records[var_2_1] = var_2_2
			end
		end
	end

	return arg_2_0
end

function zbEquipCuilianUpgradeTable.getRecord(arg_3_0, arg_3_1)
	return arg_3_0.records[arg_3_1]
end

function zbEquipCuilianUpgradeTable.getRecordbyQuality(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.records[arg_4_1]

	if arg_4_2 == EItemQuality.Green then
		return var_4_0.green
	elseif arg_4_2 == EItemQuality.Blue then
		return var_4_0.blue
	elseif arg_4_2 == EItemQuality.Purple then
		return var_4_0.purple
	elseif arg_4_2 == EItemQuality.Golden then
		return var_4_0.gold
	elseif arg_4_2 == EItemQuality.Red then
		return var_4_0.red
	elseif arg_4_2 == EItemQuality.Black then
		return var_4_0.black
	end
end

function zbEquipCuilianUpgradeTable.getCanUpgradeLevel(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	local var_5_0 = arg_5_1
	local var_5_1 = arg_5_2
	local var_5_2 = 0
	local var_5_3 = arg_5_0:getRecordbyQuality(arg_5_1, arg_5_4) - arg_5_2
	local var_5_4 = table.getn(arg_5_0.records)
	local var_5_5 = var_5_4
	local var_5_6 = arg_5_0:getRecordbyQuality(var_5_4, arg_5_4)
	local var_5_7 = arg_5_0:getRecordbyQuality(var_5_4, arg_5_4)

	for iter_5_0 = arg_5_1, var_5_4 - 2 do
		if arg_5_3 < var_5_3 then
			var_5_5 = iter_5_0
			var_5_6 = arg_5_0:getRecordbyQuality(var_5_5, arg_5_4) - (var_5_3 - arg_5_3)
			var_5_7 = arg_5_0:getRecordbyQuality(var_5_5, arg_5_4)

			break
		elseif var_5_3 == arg_5_3 then
			var_5_5 = iter_5_0 + 1
			var_5_6 = 0
			var_5_7 = arg_5_0:getRecordbyQuality(var_5_5, arg_5_4)

			break
		end

		var_5_3 = var_5_3 + arg_5_0:getRecordbyQuality(iter_5_0 + 1, arg_5_4)
	end

	if arg_5_5 < var_5_5 then
		var_5_5 = arg_5_5
		var_5_6 = arg_5_0:getRecordbyQuality(var_5_5 + 1, arg_5_4)
		var_5_7 = arg_5_0:getRecordbyQuality(var_5_5 + 1, arg_5_4)
	end

	return var_5_5, var_5_6, var_5_7
end
