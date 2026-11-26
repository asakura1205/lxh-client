require("gamebase.zbLoadCSV")

local var_0_0 = class("zbWorldNodeRecord")

var_0_0.__index = var_0_0

function createWorldNodeRecord()
	return (var_0_0.new())
end

zbWorldNodeTable = {}
zbWorldNodeTable.records = {}
zbWorldNodeTable.maincityRecord = nil

function zbWorldNodeTable.load(arg_2_0, arg_2_1)
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
				local var_2_2 = createWorldNodeRecord()
				local var_2_3 = 1

				var_2_2.id = tonumber(iter_2_1[var_2_3])

				local var_2_4 = var_2_3 + 1

				var_2_2.name = iter_2_1[var_2_4]

				local var_2_5 = var_2_4 + 1

				var_2_2.nodeType = tonumber(iter_2_1[var_2_5])

				local var_2_6 = var_2_5 + 1

				var_2_2.areaId = tonumber(iter_2_1[var_2_6])

				local var_2_7 = var_2_6 + 1

				var_2_2.gridList = arg_2_0:parseContains(iter_2_1[var_2_7])

				local var_2_8 = var_2_7 + 1

				var_2_2.needTechLevel = tonumber(iter_2_1[var_2_8])

				local var_2_9 = var_2_8 + 1

				var_2_2.needFood = tonumber(iter_2_1[var_2_9])

				local var_2_10 = var_2_9 + 1

				var_2_2.fightneedFood = tonumber(iter_2_1[var_2_10])

				local var_2_11 = var_2_10 + 1

				var_2_2.resOut = arg_2_0:parseContains(iter_2_1[var_2_11])

				local var_2_12 = var_2_11 + 1

				var_2_2.maxOut = tonumber(iter_2_1[var_2_12])

				local var_2_13 = var_2_12 + 1

				var_2_2.addRatio = tonumber(iter_2_1[var_2_13])

				local var_2_14 = var_2_13 + 1

				var_2_2.decreaseFight = tonumber(iter_2_1[var_2_14])

				local var_2_15 = var_2_14 + 1

				var_2_2.npcId = tonumber(iter_2_1[var_2_15])

				local var_2_16 = var_2_15 + 1

				var_2_2.taskId = tonumber(iter_2_1[var_2_16])

				local var_2_17 = var_2_16 + 1

				var_2_2.desc = iter_2_1[var_2_17]

				local var_2_18 = var_2_17 + 1

				var_2_2.texPath = iter_2_1[var_2_18]

				local var_2_19 = var_2_18 + 1

				var_2_2.sceneId = tonumber(iter_2_1[var_2_19])

				local var_2_20 = var_2_19 + 1

				var_2_2.pixelX = tonumber(iter_2_1[var_2_20])

				local var_2_21 = var_2_20 + 1

				var_2_2.pixelY = tonumber(iter_2_1[var_2_21])

				local var_2_22 = var_2_21 + 1

				var_2_2.resTechId = tonumber(iter_2_1[var_2_22])

				local var_2_23 = var_2_22 + 1

				if var_2_2.nodeType == EWorldNodeType.MainCity then
					zbWorldNodeTable.maincityRecord = var_2_2
				end

				arg_2_0.records[var_2_1] = var_2_2

				if table.getn(var_2_2.resOut) == 3 then
					zbGetWayItemTable:addItemNewWaysShop(var_2_2.resOut[2], EItemGetWayType.GetWay_WorldNode, var_2_2.resOut[1])
				end
			end
		end
	end

	return arg_2_0
end

function zbWorldNodeTable.parseContains(arg_3_0, arg_3_1)
	local var_3_0 = {}
	local var_3_1 = string.len(arg_3_1)
	local var_3_2 = string.sub(arg_3_1, 2, var_3_1 - 1)
	local var_3_3 = string.gsub(arg_3_1, "%[", "{")
	local var_3_4 = string.gsub(var_3_3, "%]", "}")
	local var_3_5 = wzUnserialize(var_3_4)

	if type(var_3_5) == "number" then
		return nil
	end

	local var_3_6 = {}
	local var_3_7 = 1

	for iter_3_0, iter_3_1 in pairs(var_3_5) do
		var_3_6[var_3_7] = tonumber(iter_3_1)
		var_3_7 = var_3_7 + 1
	end

	return var_3_6
end

function zbWorldNodeTable.getRecord(arg_4_0, arg_4_1)
	return arg_4_0.records[arg_4_1]
end

function zbWorldNodeTable.getWorldNpcList(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.records[arg_5_1]

	if var_5_0 == nil then
		return
	end

	if var_5_0.npcId > 0 then
		local var_5_1 = zbWorldNpcTable:getRecord(var_5_0.npcId)

		if var_5_1 then
			return var_5_1.heroList
		end
	end

	return {}
end

function zbWorldNodeTable.getGuideTalkId(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getRecord(arg_6_1)

	if var_6_0 ~= nil then
		return var_6_0.resTechId
	end

	return 23002
end
