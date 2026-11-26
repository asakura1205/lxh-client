require("gamebase.zbLoadCSV")

local var_0_0 = class("zbFateRecord")

var_0_0.__index = var_0_0

function createFateRecord()
	return (var_0_0.new())
end

zbFateTable = {}
zbFateTable.records = {}
zbFateTable.recordsTemplate = {}

function zbFateTable.load(arg_2_0, arg_2_1)
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
				local var_2_2 = tonumber(iter_2_1[2])
				local var_2_3 = {}

				if arg_2_0.recordsTemplate[var_2_2] ~= nil then
					var_2_3 = arg_2_0.recordsTemplate[var_2_2]
				end

				local var_2_4 = createFateRecord()

				var_2_4.id = tonumber(iter_2_1[var_2_1])

				local var_2_5 = var_2_1 + 1

				var_2_4.templateId = tonumber(iter_2_1[var_2_5])

				local var_2_6 = var_2_5 + 1

				var_2_4.fateName = iter_2_1[var_2_6]

				local var_2_7 = var_2_6 + 1

				var_2_4.fateType = tonumber(iter_2_1[var_2_7])

				local var_2_8 = var_2_7 + 1

				var_2_4.unlockLvl = tonumber(iter_2_1[var_2_8])

				local var_2_9 = var_2_8 + 1

				var_2_4.changeGold = tonumber(iter_2_1[var_2_9])

				local var_2_10 = var_2_9 + 1

				var_2_4.fateCondition = arg_2_0:parseAbilityContains(iter_2_1[var_2_10])

				local var_2_11 = var_2_10 + 1

				var_2_4.fateAttr = tonumber(iter_2_1[var_2_11])

				local var_2_12 = var_2_11 + 1

				var_2_4.growthPercent = tonumber(iter_2_1[var_2_12])

				local var_2_13 = var_2_12 + 1

				var_2_4.growthValue = tonumber(iter_2_1[var_2_13])

				local var_2_14 = var_2_13 + 1

				table.insert(var_2_3, var_2_4)

				arg_2_0.recordsTemplate[var_2_2] = var_2_3
				arg_2_0.records[var_2_4.id] = var_2_4
			end
		end
	end

	local var_2_15 = createFateRecord()

	var_2_15.id = -1
	arg_2_0.commonRecord = var_2_15

	return arg_2_0
end

function zbFateTable.getRecord(arg_3_0, arg_3_1)
	return arg_3_0.records[arg_3_1]
end

function zbFateTable.getRecordTemplateId(arg_4_0, arg_4_1)
	return arg_4_0.recordsTemplate[arg_4_1]
end

function zbFateTable.getHeroFateRecord(arg_5_0, arg_5_1, arg_5_2)
	local function var_5_0(arg_6_0, arg_6_1)
		if arg_6_0.unlockLvl == arg_6_1.unlockLvl then
			return arg_6_0.id > arg_6_1.id
		end

		return arg_6_0.unlockLvl < arg_6_1.unlockLvl
	end

	local var_5_1 = {}
	local var_5_2 = arg_5_0.recordsTemplate[arg_5_1]

	if zbUtil:isValidTable(var_5_2) then
		for iter_5_0, iter_5_1 in pairs(var_5_2) do
			if iter_5_1.fateType == arg_5_2 then
				table.insert(var_5_1, iter_5_1)
			end
		end
	end

	if zbUtil:isValidTable(var_5_2) then
		table.sort(var_5_1, var_5_0)
	end

	return var_5_1
end

function zbFateTable.parseAbilityContains(arg_7_0, arg_7_1)
	local var_7_0 = {}

	if arg_7_1 == "" then
		return var_7_0
	end

	local var_7_1 = string.len(arg_7_1)
	local var_7_2 = string.sub(arg_7_1, 2, var_7_1 - 1)
	local var_7_3 = string.gsub(arg_7_1, "%[", "{")
	local var_7_4 = string.gsub(var_7_3, "%]", "}")
	local var_7_5 = wzUnserialize(var_7_4)
	local var_7_6 = {}

	for iter_7_0, iter_7_1 in pairs(var_7_5) do
		local var_7_7 = tonumber(iter_7_1)

		table.insert(var_7_6, var_7_7)
	end

	return var_7_6
end

function zbFateTable.getFateName(arg_8_0, arg_8_1)
	local var_8_0 = a2u("无")
	local var_8_1 = -1
	local var_8_2 = -1
	local var_8_3 = {}
	local var_8_4 = {}

	for iter_8_0, iter_8_1 in pairs(arg_8_0.records) do
		for iter_8_2, iter_8_3 in pairs(iter_8_1.fateCondition) do
			local var_8_5 = iter_8_3

			if var_8_5 ~= -1 and var_8_5 == arg_8_1 then
				local var_8_6 = iter_8_1.templateId

				table.insert(var_8_3, var_8_6)
			end
		end
	end

	for iter_8_4, iter_8_5 in pairs(var_8_3) do
		local var_8_7 = zbHeroTable:getRecord(iter_8_5)

		if var_8_7 then
			table.insert(var_8_4, var_8_7.name)
		end
	end

	if table.getn(var_8_4) >= 1 then
		var_8_0 = ""

		if table.getn(var_8_4) < 13 then
			for iter_8_6 = 1, table.getn(var_8_4) do
				var_8_0 = var_8_0 .. var_8_4[iter_8_6] .. ","
			end

			return string.sub(var_8_0, 1, -2)
		else
			for iter_8_7 = 1, 13 do
				var_8_0 = var_8_0 .. var_8_4[iter_8_7] .. ","
			end

			var_8_0 = string.sub(var_8_0, 1, -2)

			return var_8_0 .. "......"
		end
	end

	return var_8_0
end

function zbFateTable.getRecordByIdAndFateName(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0:getRecord(arg_9_1)

	if var_9_0 then
		for iter_9_0, iter_9_1 in ipairs(var_9_0) do
			if iter_9_1.fateName == arg_9_2 then
				return iter_9_1
			end
		end
	end

	return nil
end
