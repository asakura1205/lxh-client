require("gamebase.zbLoadCSV")

local var_0_0 = class("zbHeroSoulRecord")

var_0_0.__index = var_0_0

function createHeroSoulRecord()
	return (var_0_0.new())
end

zbHeroSoulTable = {}
zbHeroSoulTable.records = {}
zbHeroSoulTable.recordIds = {}

function zbHeroSoulTable.load(arg_2_0, arg_2_1)
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

				if arg_2_0.records[var_2_2] ~= nil then
					var_2_3 = arg_2_0.records[var_2_2]
				end

				local var_2_4 = createHeroSoulRecord()

				var_2_4.id = tonumber(iter_2_1[var_2_1])

				local var_2_5 = var_2_1 + 1

				var_2_4.quality = tonumber(iter_2_1[var_2_5])

				local var_2_6 = var_2_5 + 1

				var_2_4.qualityDesc = a2u(iter_2_1[var_2_6])

				local var_2_7 = var_2_6 + 1

				var_2_4.grade = tonumber(iter_2_1[var_2_7])

				local var_2_8 = var_2_7 + 1

				var_2_4.gradeDesc = a2u(iter_2_1[var_2_8])

				local var_2_9 = var_2_8 + 1

				var_2_4.openLevel = tonumber(iter_2_1[var_2_9])

				local var_2_10 = var_2_9 + 1

				var_2_4.price = arg_2_0:parseAbilityContains(iter_2_1[var_2_10])

				local var_2_11 = var_2_10 + 1

				var_2_4.addAttack = tonumber(iter_2_1[var_2_11])

				local var_2_12 = var_2_11 + 1

				var_2_4.addMagic = tonumber(iter_2_1[var_2_12])

				local var_2_13 = var_2_12 + 1

				var_2_4.addAttackDefense = tonumber(iter_2_1[var_2_13])

				local var_2_14 = var_2_13 + 1

				var_2_4.addMagicDefense = tonumber(iter_2_1[var_2_14])

				local var_2_15 = var_2_14 + 1

				var_2_4.addBlood = tonumber(iter_2_1[var_2_15])

				local var_2_16 = var_2_15 + 1

				table.insert(var_2_3, var_2_4)

				arg_2_0.records[var_2_2] = var_2_3
				arg_2_0.recordIds[var_2_4.id] = var_2_4
			end
		end
	end

	return arg_2_0
end

function zbHeroSoulTable.parseAbilityContains(arg_3_0, arg_3_1)
	local var_3_0 = {}

	if arg_3_1 == "" then
		return var_3_0
	end

	local var_3_1 = string.len(arg_3_1)
	local var_3_2 = string.sub(arg_3_1, 2, var_3_1 - 1)
	local var_3_3 = string.gsub(arg_3_1, "%[", "{")
	local var_3_4 = string.gsub(var_3_3, "%]", "}")
	local var_3_5 = wzUnserialize(var_3_4)

	return {
		awardType = tonumber(var_3_5[1]),
		awardId = tonumber(var_3_5[2]),
		awardNum = tonumber(var_3_5[3])
	}
end

function zbHeroSoulTable.getRecord(arg_4_0, arg_4_1)
	return arg_4_0.records[arg_4_1]
end

function zbHeroSoulTable.getAddition(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_2 == 1 then
		return arg_5_1.addAttack
	elseif arg_5_2 == 2 then
		return arg_5_1.addMagic
	elseif arg_5_2 == 3 then
		return arg_5_1.addAttackDefense
	elseif arg_5_2 == 4 then
		return arg_5_1.addMagicDefense
	else
		return arg_5_1.addBlood
	end
end

function zbHeroSoulTable.getRecordUseId(arg_6_0, arg_6_1)
	return arg_6_0.recordIds[arg_6_1]
end
