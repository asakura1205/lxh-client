require("gamebase.zbLoadCSV")

local var_0_0 = class("zbHeroSoulHallRecord")

var_0_0.__index = var_0_0

function createHeroSoulHallRecord()
	return (var_0_0.new())
end

zbHeroSoulHallTable = {}
zbHeroSoulHallTable.records = {}
zbHeroSoulHallTable.count = 0
zbHeroSoulHallTable.minForceId = 1000
zbHeroSoulHallTable.maxForceId = 0

function zbHeroSoulHallTable.load(arg_2_0, arg_2_1)
	local var_2_0 = require(arg_2_1)

	if var_2_0 == nil then
		return
	end

	if type(var_2_0) == "table" then
		for iter_2_0, iter_2_1 in pairs(var_2_0) do
			if iter_2_0 == 1 or iter_2_0 == 2 or iter_2_1[1] == "" then
				-- block empty
			else
				local var_2_1 = 1
				local var_2_2 = tonumber(iter_2_1[var_2_1])
				local var_2_3 = createHeroSoulHallRecord()

				var_2_3.id = tonumber(iter_2_1[var_2_1])

				local var_2_4 = var_2_1 + 1

				var_2_3.name = a2u(iter_2_1[var_2_4])

				local var_2_5 = var_2_4 + 1

				var_2_3.openLevel = tonumber(iter_2_1[var_2_5])

				local var_2_6 = var_2_5 + 1

				var_2_3.heroId1 = tonumber(iter_2_1[var_2_6])

				local var_2_7 = var_2_6 + 1

				var_2_3.heroId2 = tonumber(iter_2_1[var_2_7])

				local var_2_8 = var_2_7 + 1

				var_2_3.heroId3 = tonumber(iter_2_1[var_2_8])

				local var_2_9 = var_2_8 + 1

				var_2_3.heroId4 = tonumber(iter_2_1[var_2_9])

				local var_2_10 = var_2_9 + 1

				var_2_3.heroId5 = tonumber(iter_2_1[var_2_10])

				local var_2_11 = var_2_10 + 1

				arg_2_0.count = arg_2_0.count + 1

				table.insert(arg_2_0.records, var_2_3)
			end
		end
	end

	local function var_2_12(arg_3_0, arg_3_1)
		if arg_3_0.openLevel == arg_3_1.openLevel then
			return arg_3_0.id < arg_3_1.id
		end

		return arg_3_0.openLevel < arg_3_1.openLevel
	end

	table.sort(arg_2_0.records, var_2_12)
	arg_2_0:checkMinMaxForceId()

	return arg_2_0
end

function zbHeroSoulHallTable.getRecord(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.records) do
		if arg_4_1 == iter_4_1.id then
			return iter_4_1
		end
	end

	return nil
end

function zbHeroSoulHallTable.getHeroID(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:getRecord(arg_5_1)

	if var_5_0 ~= nil then
		if arg_5_2 == 1 then
			return var_5_0.heroId1
		elseif arg_5_2 == 2 then
			return var_5_0.heroId2
		elseif arg_5_2 == 3 then
			return var_5_0.heroId3
		elseif arg_5_2 == 4 then
			return var_5_0.heroId4
		else
			return var_5_0.heroId5
		end
	end
end

function zbHeroSoulHallTable.checkMinMaxForceId(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.records) do
		arg_6_0.minForceId = math.min(iter_6_1.id, arg_6_0.minForceId)
		arg_6_0.maxForceId = math.max(iter_6_1.id, arg_6_0.maxForceId)
	end
end

function zbHeroSoulHallTable.getMinForceId(arg_7_0)
	return arg_7_0.minForceId
end

function zbHeroSoulHallTable.getMaxForceId(arg_8_0)
	return arg_8_0.maxForceId
end
