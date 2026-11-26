require("gamebase.zbLoadCSV")

local var_0_0 = class("zbForceRecord")

var_0_0.__index = var_0_0

function createForceRecord()
	return (var_0_0.new())
end

local function var_0_1(arg_2_0, arg_2_1)
	return arg_2_0.id < arg_2_1.id
end

zbForceTable = {}
zbForceTable.records = {}
zbForceTable.minForceId = 1
zbForceTable.maxForceId = 1

function zbForceTable.load(arg_3_0, arg_3_1)
	local var_3_0 = require(arg_3_1)

	if var_3_0 == nil then
		return
	end

	local var_3_1 = {}

	if type(var_3_0) == "table" then
		for iter_3_0, iter_3_1 in pairs(var_3_0) do
			if iter_3_0 == 1 or iter_3_0 == 2 or iter_3_1[1] == "" then
				-- block empty
			else
				local var_3_2 = createForceRecord()
				local var_3_3 = 1

				var_3_2.id = tonumber(iter_3_1[var_3_3])

				local var_3_4 = var_3_3 + 1

				var_3_2.name = iter_3_1[var_3_4]

				local var_3_5 = var_3_4 + 1

				var_3_2.loginLevel = tonumber(iter_3_1[var_3_5])

				local var_3_6 = var_3_5 + 1

				var_3_2.normalMaxFight = tonumber(iter_3_1[var_3_6])

				local var_3_7 = var_3_6 + 1

				var_3_2.eliteMaxFight = tonumber(iter_3_1[var_3_7])

				local var_3_8 = var_3_7 + 1

				var_3_2.nightmareMaxFight = tonumber(iter_3_1[var_3_8])

				local var_3_9 = var_3_8 + 1

				var_3_2.sound = iter_3_1[var_3_9]

				local var_3_10 = var_3_9 + 1

				table.insert(var_3_1, var_3_2)
			end
		end
	end

	table.sort(var_3_1, var_0_1)

	for iter_3_2, iter_3_3 in pairs(var_3_1) do
		arg_3_0.records[iter_3_2] = iter_3_3
	end

	arg_3_0:checkMinMaxForceId()

	return arg_3_0
end

function zbForceTable.getRecord(arg_4_0, arg_4_1)
	return arg_4_0.records[arg_4_1]
end

function zbForceTable.getMinForceId(arg_5_0)
	return arg_5_0.minForceId
end

function zbForceTable.getMaxForceId(arg_6_0)
	return arg_6_0.maxForceId
end

function zbForceTable.checkMinMaxForceId(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.records) do
		arg_7_0.minForceId = math.min(iter_7_1.id, arg_7_0.minForceId)
		arg_7_0.maxForceId = math.max(iter_7_1.id, arg_7_0.maxForceId)
	end
end

function zbForceTable.getRecordName(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.records[arg_8_1]

	if var_8_0 then
		return var_8_0.name
	end

	return ""
end
