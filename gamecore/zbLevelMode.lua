zbLevelMode = class("zbLevelMode")
zbLevelMode.__index = zbLevelMode

function zbLevelMode.create(arg_1_0, arg_1_1)
	local var_1_0 = zbLevelMode.new()

	var_1_0:init(arg_1_1)

	return var_1_0
end

function zbLevelMode.init(arg_2_0, arg_2_1)
	arg_2_0.levelType = arg_2_1

	if arg_2_0.levelType == ELevelType.Normal then
		arg_2_0.curForceId = 1
		arg_2_0.curLevelId = 10001
		arg_2_0.levelDatas = {}
	elseif arg_2_0.levelType == ELevelType.Elite then
		arg_2_0.curForceId = 1
		arg_2_0.curLevelId = 10003
		arg_2_0.levelDatas = {}
	elseif arg_2_0.levelType == ELevelType.Nightmare then
		arg_2_0.curForceId = 1
		arg_2_0.curLevelId = 10009
		arg_2_0.levelDatas = {}
	end

	arg_2_0:refresh()
end

function zbLevelMode.refresh(arg_3_0)
	arg_3_0.visibleForces = {}

	arg_3_0:updateVisibleForces()
	arg_3_0:updateCurrEnemyId()
end

function zbLevelMode.getForceSection(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in pairs(g_GameData.ForceSection) do
		if iter_4_1.ForceId == arg_4_1 then
			return iter_4_1
		end
	end

	return nil
end

function zbLevelMode.getForceDetail(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in pairs(g_GameData.ForceSection) do
		if iter_5_1.ForceId == arg_5_1 then
			for iter_5_2, iter_5_3 in pairs(iter_5_1.ForceList) do
				if iter_5_3.LevelType == arg_5_0.levelType then
					return iter_5_3
				end
			end
		end
	end

	return nil
end

function zbLevelMode.getLevelInfo(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0:getForceDetail(arg_6_1)

	if var_6_0 ~= nil then
		for iter_6_0, iter_6_1 in pairs(var_6_0.LevelList) do
			if iter_6_1.LevelId == arg_6_2 then
				return iter_6_1
			end
		end
	end

	return nil
end

function zbLevelMode.getLevelStar(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0:getLevelInfo(arg_7_1, arg_7_2)

	if var_7_0 ~= nil then
		return var_7_0.StarCount
	end

	return 0
end

function zbLevelMode.getForceStarCount(arg_8_0, arg_8_1)
	local var_8_0 = {}
	local var_8_1 = table.getn(zbForceSetTable:getForceLevelRecordList(arg_8_1)) / 3

	for iter_8_0 = 1, var_8_1 do
		if arg_8_0.levelType == ELevelType.Nightmare then
			local var_8_2 = zbForceSetTable:getLastLevelId(arg_8_1)

			table.insert(var_8_0, var_8_2)

			break
		else
			local var_8_3 = tonumber(string.format("%d%.4d", arg_8_1, iter_8_0 * 3))

			table.insert(var_8_0, var_8_3)
		end
	end

	local var_8_4 = 0

	for iter_8_1, iter_8_2 in pairs(var_8_0) do
		var_8_4 = var_8_4 + arg_8_0:getLevelStar(arg_8_1, iter_8_2)
	end

	return var_8_4, table.getn(var_8_0) * 3
end

function zbLevelMode.isGetForceAward(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0:getForceDetail(arg_9_1)

	if var_9_0 ~= nil then
		for iter_9_0, iter_9_1 in pairs(var_9_0.StarAwardList) do
			if iter_9_1 == arg_9_2 then
				return true
			end
		end
	end

	return false
end

function zbLevelMode.updateCurrEnemyId(arg_10_0)
	arg_10_0.curLevelId = zbForceSetTable:getLastLevelId(arg_10_0.curForceId)

	if arg_10_0.levelType == ELevelType.Normal or arg_10_0.levelType == ELevelType.Elite then
		local var_10_0 = zbForceSetTable:getForceLevelRecordList(arg_10_0.curForceId)

		for iter_10_0, iter_10_1 in pairs(var_10_0) do
			if iter_10_1.levelType >= arg_10_0.levelType then
				local var_10_1 = iter_10_1.id

				if arg_10_0:getLevelStar(arg_10_0.curForceId, var_10_1) <= 0 and var_10_1 < arg_10_0.curLevelId then
					arg_10_0.curLevelId = var_10_1
				end
			end
		end
	end
end

function zbLevelMode.updateVisibleForces(arg_11_0)
	arg_11_0.visibleForces = {}
	arg_11_0.visibleForces[1] = true
	arg_11_0.curForceId = 1

	local var_11_0 = 1

	if arg_11_0.levelType == ELevelType.Normal then
		var_11_0 = 1
	elseif arg_11_0.levelType == ELevelType.Elite then
		var_11_0 = 3
	elseif arg_11_0.levelType == ELevelType.Nightmare then
		var_11_0 = zbForceSetTable:getLastLevelId(arg_11_0.curForceId)
	end

	for iter_11_0, iter_11_1 in pairs(zbForceTable.records) do
		local var_11_1 = tonumber(string.format("%d%.4d", iter_11_0, var_11_0))

		if arg_11_0.levelType == ELevelType.Nightmare then
			var_11_1 = zbForceSetTable:getLastLevelId(iter_11_0)
		end

		if arg_11_0:getLevelStar(iter_11_0, var_11_1) > 0 then
			arg_11_0.visibleForces[iter_11_0] = true
			arg_11_0.curForceId = math.max(arg_11_0.curForceId, iter_11_0)
		end
	end

	if arg_11_0.curForceId < zbForceTable:getMaxForceId() then
		local var_11_2 = zbForceSetTable:getLastLevelId(arg_11_0.curForceId)

		if arg_11_0:getLevelStar(arg_11_0.curForceId, var_11_2) > 0 then
			arg_11_0.visibleForces[arg_11_0.curForceId + 1] = true
			arg_11_0.curForceId = arg_11_0.curForceId + 1
		end
	end
end

function zbLevelMode.isVisibleForce(arg_12_0, arg_12_1)
	if arg_12_1 > 1 then
		local var_12_0 = zbForceTable:getRecord(arg_12_1)

		if var_12_0 ~= nil and g_Self:getLevel() < var_12_0.loginLevel then
			return false
		end
	end

	if arg_12_0.levelType == ELevelType.Elite then
		if g_Self.kWarPathHandler:getLevelStar(ELevelType.Normal, 2, zbForceSetTable:getLastLevelId(2)) <= 0 then
			return false
		end

		local var_12_1 = zbForceSetTable:getLastLevelId(arg_12_1)

		if g_Self.kWarPathHandler:getLevelStar(ELevelType.Normal, arg_12_1, var_12_1) <= 0 then
			return false
		end
	end

	if arg_12_0.levelType == ELevelType.Nightmare then
		if g_Self.kWarPathHandler:getLevelStar(ELevelType.Elite, 2, zbForceSetTable:getLastLevelId(2)) <= 0 then
			return false
		end

		local var_12_2 = zbForceSetTable:getLastLevelId(arg_12_1)

		if g_Self.kWarPathHandler:getLevelStar(ELevelType.Elite, arg_12_1, var_12_2) <= 0 then
			return false
		end
	end

	local var_12_3 = arg_12_0.visibleForces[arg_12_1]

	return var_12_3 ~= nil and var_12_3 == true
end

function zbLevelMode.isBossLevelPass(arg_13_0, arg_13_1)
	local var_13_0 = zbForceSetTable:getLastLevelId(arg_13_1)

	return arg_13_0:getLevelStar(arg_13_1, var_13_0) > 0
end

function zbLevelMode.hasAvailableForceAward(arg_14_0, arg_14_1)
	local var_14_0, var_14_1, var_14_2 = zbForceSetTable:getNeedStarCount(arg_14_0.levelType, arg_14_1)
	local var_14_3 = arg_14_0:isGetForceAward(arg_14_1, var_14_0)
	local var_14_4 = arg_14_0:isGetForceAward(arg_14_1, var_14_1)
	local var_14_5 = arg_14_0:isGetForceAward(arg_14_1, var_14_2)
	local var_14_6, var_14_7 = arg_14_0:getForceStarCount(arg_14_1)
	local var_14_8 = false

	return var_14_6 >= var_14_7 / 3 and var_14_3 == false and true or var_14_6 >= var_14_7 / 3 * 2 and var_14_4 == false and true or var_14_7 <= var_14_6 and var_14_5 == false and true or false
end

function zbLevelMode.hasAvailableAward(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0.visibleForces) do
		if arg_15_0:hasAvailableForceAward(iter_15_0) then
			return true
		end
	end

	return false
end
