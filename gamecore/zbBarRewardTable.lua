require("gamebase.zbLoadCSV")

local var_0_0 = class("zbBarRewardRecord")

var_0_0.__index = var_0_0

function createBarRewardRecord()
	return (var_0_0.new())
end

zbBarRewardTable = {}
zbBarRewardTable.records = {}

function zbBarRewardTable.load(arg_2_0, arg_2_1)
	local var_2_0 = require(arg_2_1)

	if var_2_0 == nil then
		return
	end

	if type(var_2_0) == "table" then
		local var_2_1 = 1

		for iter_2_0, iter_2_1 in pairs(var_2_0) do
			if iter_2_0 == 1 or iter_2_0 == 2 or iter_2_1[1] == "" then
				-- block empty
			else
				local var_2_2 = createBarRewardRecord()
				local var_2_3 = 1

				var_2_2.poolType = tonumber(iter_2_1[var_2_3])

				local var_2_4 = var_2_3 + 1

				var_2_2.awardType = tonumber(iter_2_1[var_2_4])

				local var_2_5 = var_2_4 + 1

				var_2_2.templateId = tonumber(iter_2_1[var_2_5])

				local var_2_6 = var_2_5 + 1

				var_2_2.count = tonumber(iter_2_1[var_2_6])

				local var_2_7 = var_2_6 + 1

				var_2_2.weight = tonumber(iter_2_1[var_2_7])

				local var_2_8 = var_2_7 + 1

				var_2_2.bPreview = tonumber(iter_2_1[var_2_8])

				local var_2_9 = var_2_8 + 1

				var_2_2.rem1 = iter_2_1[var_2_9]

				local var_2_10 = var_2_9 + 1

				var_2_2.rem2 = iter_2_1[var_2_10]

				local var_2_11 = var_2_10 + 1

				var_2_2.rem3 = iter_2_1[var_2_11]

				local var_2_12 = var_2_11 + 1

				arg_2_0.records[var_2_1] = var_2_2
				var_2_1 = var_2_1 + 1

				zbGetWayItemTable:addItemNewWaysShop(var_2_2.templateId, EItemGetWayType.GetWay_Pub, var_2_2.awardType)
			end
		end
	end

	return arg_2_0
end

function zbBarRewardTable.getHeroPreViewByRarity(arg_3_0, arg_3_1)
	local var_3_0 = {}

	local function var_3_1(arg_4_0)
		for iter_4_0, iter_4_1 in pairs(var_3_0) do
			if iter_4_1.id == arg_4_0 then
				return true
			end
		end

		return false
	end

	for iter_3_0, iter_3_1 in pairs(arg_3_0.records) do
		if iter_3_1.bPreview == 1 and (iter_3_1.awardType == ECommonAwardType.Hero or iter_3_1.awardType == ECommonAwardType.HeroFrag) and var_3_1(iter_3_1.templateId) == false then
			local var_3_2 = zbHeroTable:getRecord(iter_3_1.templateId)

			if var_3_2 and var_3_2.rarity == arg_3_1 then
				table.insert(var_3_0, var_3_2)
			end
		end
	end

	return var_3_0
end
