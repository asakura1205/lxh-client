zbItemWays = class("zbItemWays")
zbItemWays.__index = zbItemWays

function zbItemWays.create(arg_1_0, arg_1_1)
	local var_1_0 = zbItemWays.new()

	var_1_0:init(arg_1_1)

	return var_1_0
end

function zbItemWays.init(arg_2_0, arg_2_1)
	arg_2_0.templateId = arg_2_1
	arg_2_0.ways = {}
end

function zbItemWays.add(arg_3_0, arg_3_1)
	table.insert(arg_3_0.ways, arg_3_1)
end

zbGetWayItemTable = {}
zbGetWayItemTable.itemWays = {}

function zbGetWayItemTable.getWays(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.itemWays[arg_4_1]

	if var_4_0 == nil then
		var_4_0 = zbItemWays:create(arg_4_1)
	end

	return var_4_0
end

function zbGetWayItemTable.addItem(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == EItemGetWayType.GetWay_ForceAward then
		for iter_5_0 = 1, arg_5_2.levelType do
			if iter_5_0 == ELevelType.Normal then
				local var_5_0 = zbForceLevelAwardTable:getRecord(arg_5_2.awardItemListNormal)

				if var_5_0 then
					for iter_5_1, iter_5_2 in pairs(var_5_0.awardList) do
						arg_5_0:addItemNewWays(iter_5_2.awardId, arg_5_1, iter_5_0, arg_5_2.forceId, arg_5_2.id, iter_5_2.awardType)
					end
				end
			end

			if iter_5_0 == ELevelType.Elite then
				local var_5_1 = zbForceLevelAwardTable:getRecord(arg_5_2.awardItemListElite)

				if var_5_1 then
					for iter_5_3, iter_5_4 in pairs(var_5_1.awardList) do
						arg_5_0:addItemNewWays(iter_5_4.awardId, arg_5_1, iter_5_0, arg_5_2.forceId, arg_5_2.id, iter_5_4.awardType)
					end
				end
			end

			if iter_5_0 == ELevelType.Nightmare then
				local var_5_2 = zbForceLevelAwardTable:getRecord(arg_5_2.awardItemListNightmare)

				if var_5_2 then
					for iter_5_5, iter_5_6 in pairs(var_5_2.awardList) do
						arg_5_0:addItemNewWays(iter_5_6.awardId, arg_5_1, iter_5_0, arg_5_2.forceId, arg_5_2.id, iter_5_6.awardType)
					end
				end
			end
		end
	else
		arg_5_0:addItemNewWaysShop(arg_5_2.awardId, arg_5_1, arg_5_2.awardType)
	end
end

function zbGetWayItemTable.addItemNewWays(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6)
	local var_6_0 = arg_6_5 % 10000

	if arg_6_5 ~= nil and var_6_0 % 3 > 0 and arg_6_3 == ELevelType.Normal then
		return
	end

	local var_6_1 = arg_6_0.itemWays[arg_6_1]

	if var_6_1 ~= nil then
		local var_6_2 = {
			wayType = arg_6_2,
			levelType = arg_6_3,
			forceId = arg_6_4,
			levelId = arg_6_5,
			itemType = arg_6_6
		}

		var_6_1:add(var_6_2)

		return
	end

	local var_6_3 = zbItemWays:create(arg_6_1)
	local var_6_4 = {
		wayType = arg_6_2,
		levelType = arg_6_3,
		forceId = arg_6_4,
		levelId = arg_6_5,
		itemType = arg_6_6
	}

	var_6_3:add(var_6_4)

	arg_6_0.itemWays[arg_6_1] = var_6_3
end

function zbGetWayItemTable.addItemNewWaysShop(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_0.itemWays[arg_7_1]

	if var_7_0 ~= nil then
		for iter_7_0, iter_7_1 in pairs(var_7_0.ways) do
			if iter_7_1.wayType == arg_7_2 then
				return
			end
		end

		local var_7_1 = {
			wayType = arg_7_2
		}

		var_7_1.levelType = 0
		var_7_1.forceId = 0
		var_7_1.levelId = 0
		var_7_1.itemType = arg_7_3

		var_7_0:add(var_7_1)

		return
	end

	local var_7_2 = zbItemWays:create(arg_7_1)
	local var_7_3 = {
		wayType = arg_7_2
	}

	var_7_3.levelType = 0
	var_7_3.forceId = 0
	var_7_3.levelId = 0
	var_7_3.itemType = arg_7_3

	var_7_2:add(var_7_3)

	arg_7_0.itemWays[arg_7_1] = var_7_2
end
