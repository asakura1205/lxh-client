require("gamebase.zbLoadCSV")

local var_0_0 = class("zbEquipQualityRecord")

var_0_0.__index = var_0_0

function createEquipQualityRecord()
	return (var_0_0.new())
end

zbEquipQualityTable = {}
zbEquipQualityTable.records = {}

function zbEquipQualityTable.load(arg_2_0, arg_2_1)
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
				local var_2_2 = createEquipQualityRecord()
				local var_2_3 = 1

				var_2_2.quality = tonumber(iter_2_1[var_2_3])

				local var_2_4 = var_2_3 + 1

				var_2_2.composeFragNum = tonumber(iter_2_1[var_2_4])

				local var_2_5 = var_2_4 + 1

				var_2_2.composeGold = tonumber(iter_2_1[var_2_5])

				local var_2_6 = var_2_5 + 1

				var_2_2.decomposeEquip = tonumber(iter_2_1[var_2_6])

				local var_2_7 = var_2_6 + 1

				var_2_2.decomposeEquipFrag = tonumber(iter_2_1[var_2_7])

				local var_2_8 = var_2_7 + 1

				var_2_2.exchangeExp = tonumber(iter_2_1[var_2_8])

				local var_2_9 = var_2_8 + 1

				var_2_2.exchangeFragExp = tonumber(iter_2_1[var_2_9])

				local var_2_10 = var_2_9 + 1

				arg_2_0.records[var_2_1] = var_2_2
			end
		end
	end

	return arg_2_0
end

function zbEquipQualityTable.getRecord(arg_3_0, arg_3_1)
	return arg_3_0.records[arg_3_1]
end
