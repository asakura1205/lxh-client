require("gamebase.zbLoadCSV")

local var_0_0 = class("zbHeroSkillRecord")

var_0_0.__index = var_0_0

function creatHeroSkillRecord()
	return (var_0_0.new())
end

zbHeroSkillTable = {}
zbHeroSkillTable.records = {}

function zbHeroSkillTable.load(arg_2_0, arg_2_1)
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
				local var_2_2 = creatHeroSkillRecord()
				local var_2_3 = 1

				var_2_2.id = tonumber(iter_2_1[var_2_3])

				local var_2_4 = var_2_3 + 1

				var_2_2.name = iter_2_1[var_2_4]

				local var_2_5 = var_2_4 + 1

				var_2_2.descBase = iter_2_1[var_2_5]

				local var_2_6 = var_2_5 + 1

				var_2_2.descLevel = iter_2_1[var_2_6]

				local var_2_7 = var_2_6 + 1

				var_2_2.icon = iter_2_1[var_2_7]

				local var_2_8 = var_2_7 + 1

				var_2_2.upgradeId = tonumber(iter_2_1[var_2_8])

				local var_2_9 = var_2_8 + 1

				var_2_2.riseEffectId = tonumber(iter_2_1[var_2_9])

				local var_2_10 = var_2_9 + 1

				var_2_2.riseAttackEffectId = tonumber(iter_2_1[var_2_10])

				local var_2_11 = var_2_10 + 1

				var_2_2.flyEffectId = tonumber(iter_2_1[var_2_11])

				local var_2_12 = var_2_11 + 1

				var_2_2.hitEffectId = tonumber(iter_2_1[var_2_12])

				local var_2_13 = var_2_12 + 1

				var_2_2.targetEffectId = tonumber(iter_2_1[var_2_13])

				local var_2_14 = var_2_13 + 1

				var_2_2.skillBase = tonumber(iter_2_1[var_2_14])

				local var_2_15 = var_2_14 + 1

				var_2_2.skillGrowth = tonumber(iter_2_1[var_2_15])

				local var_2_16 = var_2_15 + 1

				var_2_2.fvBase = tonumber(iter_2_1[var_2_16])

				local var_2_17 = var_2_16 + 1

				var_2_2.fvGrowth = tonumber(iter_2_1[var_2_17])

				local var_2_18 = var_2_17 + 1

				arg_2_0.records[var_2_1] = var_2_2
			end
		end
	end

	return arg_2_0
end

function zbHeroSkillTable.getRecord(arg_3_0, arg_3_1)
	return arg_3_0.records[arg_3_1]
end
