require("gamebase.zbLoadCSV")

local var_0_0 = class("zbHeroQualityRecord")

var_0_0.__index = var_0_0

function creatHeroQualityRecord()
	return (var_0_0.new())
end

zbHeroQualityTable = {}
zbHeroQualityTable.records = {}
zbHeroQualityTable.recordQuality = {}
zbHeroQualityTable.num = 0

local function var_0_1(arg_2_0, arg_2_1)
	return arg_2_0 < arg_2_1
end

function zbHeroQualityTable.load(arg_3_0, arg_3_1)
	local var_3_0 = require(arg_3_1)

	if var_3_0 == nil then
		return
	end

	if type(var_3_0) == "table" then
		for iter_3_0, iter_3_1 in pairs(var_3_0) do
			if iter_3_0 == 1 or iter_3_0 == 2 or iter_3_1[1] == "" then
				-- block empty
			else
				local var_3_1 = creatHeroQualityRecord()
				local var_3_2 = 1

				arg_3_0.num = arg_3_0.num + 1
				var_3_1.qualityLevel = tonumber(iter_3_1[var_3_2])

				local var_3_3 = var_3_2 + 1

				var_3_1.quality = tonumber(iter_3_1[var_3_3])

				local var_3_4 = var_3_3 + 1
				local var_3_5 = arg_3_0.recordQuality[var_3_1.quality]

				if var_3_5 == nil then
					var_3_5 = {}
				end

				table.insert(var_3_5, var_3_1.qualityLevel)

				arg_3_0.recordQuality[var_3_1.quality] = var_3_5
				arg_3_0.records[var_3_1.qualityLevel] = var_3_1
			end
		end

		for iter_3_2, iter_3_3 in pairs(arg_3_0.recordQuality) do
			table.sort(iter_3_3, var_0_1)
		end
	end

	return arg_3_0
end

function zbHeroQualityTable.getRecord(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.records[arg_4_1]

	if var_4_0 == nil then
		return 3
	end

	return var_4_0
end

function zbHeroQualityTable.exchangeHeroQuality(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:getRecord(arg_5_1)
	local var_5_1 = arg_5_0.recordQuality[var_5_0.quality]

	if var_5_1 then
		return var_5_0.quality, arg_5_1 - var_5_1[1]
	end

	return 3, 0
end
