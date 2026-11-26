require("gamebase.zbLoadCSV")

local var_0_0 = class("zbForceSetRecord")

var_0_0.__index = var_0_0

function createForceSetRecord()
	return (var_0_0.new())
end

zbForceSetTable = {}
zbForceSetTable.records = {}
zbForceSetTable.focrds = {}

function zbForceSetTable.load(arg_2_0, arg_2_1)
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
				local var_2_2 = createForceSetRecord()
				local var_2_3 = 1

				var_2_2.id = tonumber(iter_2_1[var_2_3])

				local var_2_4 = var_2_3 + 1

				var_2_2.forceId = tonumber(iter_2_1[var_2_4])

				local var_2_5 = var_2_4 + 1

				var_2_2.name = iter_2_1[var_2_5]

				local var_2_6 = var_2_5 + 1

				var_2_2.showBoss = tonumber(iter_2_1[var_2_6]) == 1

				local var_2_7 = var_2_6 + 1

				var_2_2.desc1 = iter_2_1[var_2_7]

				local var_2_8 = var_2_7 + 1

				var_2_2.desc2 = iter_2_1[var_2_8]

				local var_2_9 = var_2_8 + 1

				var_2_2.levelIcon = iter_2_1[var_2_9]

				local var_2_10 = var_2_9 + 1

				var_2_2.sceneId = tonumber(iter_2_1[var_2_10])

				local var_2_11 = var_2_10 + 1

				var_2_2.levelType = tonumber(iter_2_1[var_2_11])

				local var_2_12 = var_2_11 + 1

				var_2_2.loginTiliNormal = tonumber(iter_2_1[var_2_12])

				local var_2_13 = var_2_12 + 1

				var_2_2.winTiliNormal = tonumber(iter_2_1[var_2_13])

				local var_2_14 = var_2_13 + 1

				var_2_2.roleExpNormal = tonumber(iter_2_1[var_2_14])

				local var_2_15 = var_2_14 + 1

				var_2_2.heroExpNormal = tonumber(iter_2_1[var_2_15])

				local var_2_16 = var_2_15 + 1

				var_2_2.heroSPNormal = tonumber(iter_2_1[var_2_16])

				local var_2_17 = var_2_16 + 1

				var_2_2.awardGoldNormal = tonumber(iter_2_1[var_2_17])

				local var_2_18 = var_2_17 + 1

				var_2_2.awardItemListNormal = tonumber(iter_2_1[var_2_18])

				local var_2_19 = var_2_18 + 1

				var_2_2.heroListNormal = arg_2_0:parseContains(iter_2_1[var_2_19])

				local var_2_20 = var_2_19 + 1

				var_2_2.loginTiliElite = tonumber(iter_2_1[var_2_20])

				local var_2_21 = var_2_20 + 1

				var_2_2.winTiliElite = tonumber(iter_2_1[var_2_21])

				local var_2_22 = var_2_21 + 1

				var_2_2.roleExpElite = tonumber(iter_2_1[var_2_22])

				local var_2_23 = var_2_22 + 1

				var_2_2.heroExpElite = tonumber(iter_2_1[var_2_23])

				local var_2_24 = var_2_23 + 1

				var_2_2.heroSPElite = tonumber(iter_2_1[var_2_24])

				local var_2_25 = var_2_24 + 1

				var_2_2.awardGoldElite = tonumber(iter_2_1[var_2_25])

				local var_2_26 = var_2_25 + 1

				var_2_2.awardItemListElite = tonumber(iter_2_1[var_2_26])

				local var_2_27 = var_2_26 + 1

				var_2_2.heroListElite = arg_2_0:parseContains(iter_2_1[var_2_27])

				local var_2_28 = var_2_27 + 1

				var_2_2.loginTiliware = tonumber(iter_2_1[var_2_28])

				local var_2_29 = var_2_28 + 1

				var_2_2.winTiliware = tonumber(iter_2_1[var_2_29])

				local var_2_30 = var_2_29 + 1

				var_2_2.roleExpware = tonumber(iter_2_1[var_2_30])

				local var_2_31 = var_2_30 + 1

				var_2_2.heroExpware = tonumber(iter_2_1[var_2_31])

				local var_2_32 = var_2_31 + 1

				var_2_2.heroSPware = tonumber(iter_2_1[var_2_32])

				local var_2_33 = var_2_32 + 1

				var_2_2.awardGoldware = tonumber(iter_2_1[var_2_33])

				local var_2_34 = var_2_33 + 1

				var_2_2.awardItemListNightmare = tonumber(iter_2_1[var_2_34])

				local var_2_35 = var_2_34 + 1

				var_2_2.heroListNightmare = arg_2_0:parseContains(iter_2_1[var_2_35])

				local var_2_36 = var_2_35 + 1

				arg_2_0.records[var_2_1] = var_2_2

				if arg_2_0.focrds[var_2_2.forceId] == nil then
					arg_2_0.focrds[var_2_2.forceId] = {}
				end

				if arg_2_0.focrds[var_2_2.forceId].levels == nil then
					arg_2_0.focrds[var_2_2.forceId].levels = {}
					arg_2_0.focrds[var_2_2.forceId].lastLevelId = var_2_2.id
				end

				table.insert(arg_2_0.focrds[var_2_2.forceId].levels, var_2_2)

				for iter_2_2, iter_2_3 in pairs(arg_2_0.focrds[var_2_2.forceId].levels) do
					if arg_2_0.focrds[var_2_2.forceId].lastLevelId < var_2_2.id then
						arg_2_0.focrds[var_2_2.forceId].lastLevelId = var_2_2.id

						break
					end
				end

				zbGetWayItemTable:addItem(EItemGetWayType.GetWay_ForceAward, var_2_2)
			end
		end
	end

	return arg_2_0
end

function zbForceSetTable.parseContains(arg_3_0, arg_3_1)
	local var_3_0 = {}
	local var_3_1 = string.len(arg_3_1)
	local var_3_2 = string.sub(arg_3_1, 2, var_3_1 - 1)
	local var_3_3 = string.gsub(arg_3_1, "%[", "{")
	local var_3_4 = string.gsub(var_3_3, "%]", "}")
	local var_3_5 = wzUnserialize(var_3_4)

	if type(var_3_5) == "number" then
		local var_3_6 = {}

		table.insert(var_3_6, var_3_5)

		return var_3_6
	end

	return var_3_5
end

function zbForceSetTable.getRecord(arg_4_0, arg_4_1)
	return arg_4_0.records[arg_4_1]
end

function zbForceSetTable.getRecordName(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.records[arg_5_1]

	if var_5_0 then
		return var_5_0.name
	end

	return ""
end

function zbForceSetTable.getLastLevelId(arg_6_0, arg_6_1)
	if arg_6_0.focrds[arg_6_1] == nil then
		return 0
	end

	return arg_6_0.focrds[arg_6_1].lastLevelId
end

function zbForceSetTable.getForceLevelRecordList(arg_7_0, arg_7_1)
	if arg_7_0.focrds[arg_7_1] == nil then
		return {}
	end

	return arg_7_0.focrds[arg_7_1].levels
end

function zbForceSetTable.getNeedStarCount(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0:getForceLevelRecordList(arg_8_2)
	local var_8_1 = table.getn(var_8_0) / 3 * 3 / 3

	if arg_8_1 == ELevelType.Normal then
		return var_8_1, var_8_1 * 2, var_8_1 * 3
	elseif arg_8_1 == ELevelType.Elite then
		return var_8_1, var_8_1 * 2, var_8_1 * 3
	elseif arg_8_1 == ELevelType.Nightmare then
		return 1, 2, 3
	end

	return 0, 0, 0
end

function zbForceSetTable.getLevelHeroList(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.records[arg_9_1]

	if var_9_0 == nil then
		return
	end

	local var_9_1 = 0

	if ELevelType.Normal == arg_9_2 then
		var_9_1 = var_9_0.heroListNormal[table.getn(var_9_0.heroListNormal)]
	elseif ELevelType.Elite == arg_9_2 then
		var_9_1 = var_9_0.heroListElite[table.getn(var_9_0.heroListElite)]
	else
		var_9_1 = var_9_0.heroListNightmare[table.getn(var_9_0.heroListNightmare)]
	end

	if var_9_1 > 0 then
		local var_9_2 = zbForceHeroTable:getRecord(var_9_1)

		if var_9_2 then
			return var_9_2.heroList
		end
	end

	return {}
end

function zbForceSetTable.getLevelAwardItems(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.records[arg_10_1]

	if var_10_0 == nil then
		return
	end

	local var_10_1 = 0
	local var_10_2 = 0
	local var_10_3 = 0

	if ELevelType.Normal == arg_10_2 then
		var_10_1 = var_10_0.awardItemListNormal
		var_10_2 = var_10_0.heroExpNormal
		var_10_3 = var_10_0.awardGoldNormal
	elseif ELevelType.Elite == arg_10_2 then
		var_10_1 = var_10_0.awardItemListElite
		var_10_2 = var_10_0.heroExpElite
		var_10_3 = var_10_0.awardGoldElite
	else
		var_10_1 = var_10_0.awardItemListNightmare
		var_10_2 = var_10_0.heroExpware
		var_10_3 = var_10_0.awardGoldware
	end

	if var_10_1 > 0 then
		local var_10_4 = zbForceLevelAwardTable:getRecord(var_10_1)

		if var_10_4 then
			return var_10_4.awardList, var_10_3, var_10_2
		end
	end

	return {}, var_10_3, var_10_2
end

function zbForceSetTable.getLoginAndWinTili(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = 0
	local var_11_1 = 0
	local var_11_2 = arg_11_0.records[arg_11_1]

	if var_11_2 then
		if arg_11_2 == ELevelType.Normal then
			var_11_0 = var_11_2.loginTiliNormal
			var_11_1 = var_11_2.winTiliNormal
		elseif arg_11_2 == ELevelType.Elite then
			var_11_0 = var_11_2.loginTiliElite
			var_11_1 = var_11_2.winTiliElite
		elseif arg_11_2 == ELevelType.Nightmare then
			var_11_0 = var_11_2.loginTiliware
			var_11_1 = var_11_2.winTiliware
		end
	end

	return var_11_0, var_11_1
end

function zbForceSetTable.getSceneId(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.records[arg_12_1]

	if var_12_0 and g_DataConfig:isValidSceneId(var_12_0.sceneId) then
		return var_12_0.sceneId
	else
		return 1
	end
end
