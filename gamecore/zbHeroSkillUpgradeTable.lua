require("gamebase.zbLoadCSV")

local var_0_0 = class("zbHeroSkillUpgradeRecord")

var_0_0.__index = var_0_0

function creatHeroSkillUpgradeRecord()
	return (var_0_0.new())
end

zbHeroSkillUpgradeTable = {}
zbHeroSkillUpgradeTable.records = {}

function zbHeroSkillUpgradeTable.load(arg_2_0, arg_2_1)
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
				local var_2_2 = creatHeroSkillUpgradeRecord()
				local var_2_3 = 1

				var_2_2.id = tonumber(iter_2_1[var_2_3])

				local var_2_4 = var_2_3 + 1

				var_2_2.lvl = tonumber(iter_2_1[var_2_4])

				local var_2_5 = var_2_4 + 1

				var_2_2.skillPoint = tonumber(iter_2_1[var_2_5])

				local var_2_6 = var_2_5 + 1
				local var_2_7 = arg_2_0.records[var_2_1]

				if var_2_7 == nil then
					var_2_7 = {}
					arg_2_0.records[var_2_1] = var_2_7
				end

				var_2_7[var_2_2.lvl] = var_2_2
			end
		end
	end

	return arg_2_0
end

function zbHeroSkillUpgradeTable.getRecord(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0.records[arg_3_1]

	if var_3_0 ~= nil then
		return var_3_0[arg_3_2]
	end

	return nil
end

function zbHeroSkillUpgradeTable.getHeroSkillLevelUpNeed(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0:getRecord(arg_4_1, arg_4_2)
	local var_4_1 = 999999

	if var_4_0 == nil then
		return var_4_1
	end

	return var_4_0.skillPoint
end

function zbHeroSkillUpgradeTable.getHeroSkillNeedPoint(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = 0

	for iter_5_0 = arg_5_2, arg_5_3 - 1 do
		var_5_0 = var_5_0 + arg_5_0:getHeroSkillLevelUpNeed(arg_5_1, iter_5_0)
	end

	return var_5_0
end

function zbHeroSkillUpgradeTable.getMaxLevel(arg_6_0, arg_6_1)
	local var_6_0 = 99

	local function var_6_1(arg_7_0, arg_7_1)
		return arg_7_0.lvl > arg_7_1.lvl
	end

	local var_6_2 = arg_6_0.records[arg_6_1]

	if var_6_2 ~= nil then
		table.sort(var_6_2, var_6_1)

		var_6_0 = var_6_2[table.getn(var_6_2)].lvl
	end

	return var_6_0
end
