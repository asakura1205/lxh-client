require("gamebase.zbLoadCSV")

local var_0_0 = class("zbLegionHongbaoRecord")

var_0_0.__index = var_0_0

function var_0_0.init(arg_1_0)
	return
end

function createLegionHongbaoRecord()
	local var_2_0 = var_0_0.new()

	var_2_0:init()

	return var_2_0
end

zbLegionHongbaoTable = {}
zbLegionHongbaoTable.records = {}

function zbLegionHongbaoTable.load(arg_3_0, arg_3_1)
	local var_3_0 = require(arg_3_1)

	if var_3_0 == nil then
		return
	end

	if type(var_3_0) == "table" then
		for iter_3_0, iter_3_1 in pairs(var_3_0) do
			if iter_3_0 == 1 or iter_3_0 == 2 or iter_3_1[1] == "" then
				-- block empty
			else
				local var_3_1 = tonumber(iter_3_1[1])
				local var_3_2 = createLegionHongbaoRecord()
				local var_3_3 = 1

				var_3_2.type = tonumber(iter_3_1[var_3_3])

				local var_3_4 = var_3_3 + 1

				var_3_2.name = iter_3_1[var_3_4]

				local var_3_5 = var_3_4 + 1

				var_3_2.diamond = tonumber(iter_3_1[var_3_5])

				local var_3_6 = var_3_5 + 1

				var_3_2.awardList = arg_3_0:parseContains(iter_3_1[var_3_6])

				local var_3_7 = var_3_6 + 1

				var_3_2.hongbao = arg_3_0:parseContains(iter_3_1[var_3_7])

				local var_3_8 = var_3_7 + 1

				var_3_2.num = tonumber(iter_3_1[var_3_8])

				local var_3_9 = var_3_8 + 1

				var_3_2.min = tonumber(iter_3_1[var_3_9])

				local var_3_10 = var_3_9 + 1

				var_3_2.needVip = tonumber(iter_3_1[var_3_10])

				local var_3_11 = var_3_10 + 1

				arg_3_0.records[var_3_1] = var_3_2
			end
		end
	end

	return arg_3_0
end

function zbLegionHongbaoTable.getRecord(arg_4_0, arg_4_1)
	return arg_4_0.records[arg_4_1]
end

function zbLegionHongbaoTable.parseContains(arg_5_0, arg_5_1)
	local var_5_0 = {}
	local var_5_1 = string.len(arg_5_1)
	local var_5_2 = string.sub(arg_5_1, 2, var_5_1 - 1)
	local var_5_3 = string.gsub(arg_5_1, "%[", "{")
	local var_5_4 = string.gsub(var_5_3, "%]", "}")
	local var_5_5 = wzUnserialize(var_5_4)

	if type(var_5_5) == "number" then
		return nil
	end

	local var_5_6 = {}
	local var_5_7 = 1

	for iter_5_0, iter_5_1 in pairs(var_5_5) do
		var_5_6[var_5_7] = {
			Type = tonumber(iter_5_1[1]),
			Id = tonumber(iter_5_1[2]),
			Count = tonumber(iter_5_1[3])
		}
		var_5_7 = var_5_7 + 1
	end

	return var_5_6
end
