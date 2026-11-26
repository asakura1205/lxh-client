require("gamebase.zbLoadCSV")

local var_0_0 = class("zbSkillRecord")

var_0_0.__index = var_0_0

function createSkillRecord()
	return (var_0_0.new())
end

zbSkillTable = {}
zbSkillTable.records = {}

function zbSkillTable.load(arg_2_0, arg_2_1)
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
				local var_2_2 = createSkillRecord()
				local var_2_3 = 1

				var_2_2.id = tonumber(iter_2_1[var_2_3])

				local var_2_4 = var_2_3 + 1

				var_2_2.icon = iter_2_1[var_2_4]

				local var_2_5 = var_2_4 + 1

				var_2_2.name = iter_2_1[var_2_5]

				local var_2_6 = var_2_5 + 1

				var_2_2.skillType = tonumber(iter_2_1[var_2_6])

				local var_2_7 = var_2_6 + 1

				var_2_2.affectRange = tonumber(iter_2_1[var_2_7])

				local var_2_8 = var_2_7 + 1

				var_2_2.unlockLevel = tonumber(iter_2_1[var_2_8])

				local var_2_9 = var_2_8 + 1

				var_2_2.expBonus = tonumber(iter_2_1[var_2_9])

				local var_2_10 = var_2_9 + 1

				var_2_2.basePowerBonus = tonumber(iter_2_1[var_2_10])

				local var_2_11 = var_2_10 + 1

				var_2_2.equipmentPowerBonus = tonumber(iter_2_1[var_2_11])

				local var_2_12 = var_2_11 + 1

				var_2_2.reduceEquipBrokeChance = tonumber(iter_2_1[var_2_12])

				local var_2_13 = var_2_12 + 1

				var_2_2.findMoreGold = tonumber(iter_2_1[var_2_13])

				local var_2_14 = var_2_13 + 1

				var_2_2.lootCountBonus = tonumber(iter_2_1[var_2_14])

				local var_2_15 = var_2_14 + 1

				var_2_2.survivalChanceBonus = tonumber(iter_2_1[var_2_15])

				local var_2_16 = var_2_15 + 1

				var_2_2.reduceReviveTime = tonumber(iter_2_1[var_2_16])

				local var_2_17 = var_2_16 + 1

				var_2_2.reduceResttime = tonumber(iter_2_1[var_2_17])

				local var_2_18 = var_2_17 + 1

				var_2_2.reduceMissionTime = tonumber(iter_2_1[var_2_18])

				local var_2_19 = var_2_18 + 1

				var_2_2.desc = iter_2_1[var_2_19]

				local var_2_20 = var_2_19 + 1

				arg_2_0.records[var_2_1] = var_2_2
			end
		end
	end

	return arg_2_0
end

function zbSkillTable.getRecord(arg_3_0, arg_3_1)
	return arg_3_0.records[arg_3_1]
end

function zbSkillTable.getHeroSkillLevelDesc(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = skillRecord

	if var_4_0 == nil then
		var_4_0 = arg_4_0.records[arg_4_1]
	end

	local var_4_1 = var_4_0.descriptionLevel1
	local var_4_2 = ""
	local var_4_3 = string.format(getStringTable(400113), arg_4_2)
	local var_4_4 = a2u(var_4_3)

	if arg_4_2 == 0 then
		var_4_1 = var_4_0.descriptionLevel1
		var_4_4 = a2u(getStringTable(400112))
	elseif arg_4_2 == 1 then
		var_4_1 = var_4_0.descriptionLevel1
	elseif arg_4_2 == 2 then
		var_4_1 = var_4_0.descriptionLevel2
	elseif arg_4_2 == 3 then
		var_4_1 = var_4_0.descriptionLevel3
	elseif arg_4_2 == 4 then
		var_4_1 = var_4_0.descriptionLevel4
	elseif arg_4_2 == 5 then
		var_4_1 = var_4_0.descriptionLevel5
	elseif arg_4_2 == 6 then
		var_4_1 = var_4_0.descriptionLevel6
	elseif arg_4_2 == 7 then
		var_4_1 = var_4_0.descriptionLevel7
	elseif arg_4_2 == 8 then
		var_4_1 = var_4_0.descriptionLevel8
	elseif arg_4_2 == 9 then
		var_4_1 = var_4_0.descriptionLevel9
	elseif arg_4_2 == 10 then
		var_4_1 = var_4_0.descriptionLevel10
		var_4_4 = ""
	end

	return var_4_1, var_4_4
end
