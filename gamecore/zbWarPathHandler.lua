require("gamecore.zbLevelMode")

zbWarPathHandler = class("zbWarPathHandler")
zbWarPathHandler.__index = zbWarPathHandler

function createWarPathHandler()
	local var_1_0 = zbWarPathHandler.new()

	var_1_0:init()

	return var_1_0
end

function zbWarPathHandler.init(arg_2_0)
	arg_2_0.normalLevelMode = zbLevelMode:create(ELevelType.Normal)
	arg_2_0.eliteLevelMode = zbLevelMode:create(ELevelType.Elite)
	arg_2_0.hardLevelMode = zbLevelMode:create(ELevelType.Nightmare)
	arg_2_0.levelModes = {}
	arg_2_0.levelModes[ELevelType.Normal] = arg_2_0.normalLevelMode
	arg_2_0.levelModes[ELevelType.Elite] = arg_2_0.eliteLevelMode
	arg_2_0.levelModes[ELevelType.Nightmare] = arg_2_0.hardLevelMode
end

function zbWarPathHandler.refresh(arg_3_0)
	arg_3_0.normalLevelMode:refresh()
	arg_3_0.eliteLevelMode:refresh()
	arg_3_0.hardLevelMode:refresh()
end

function zbWarPathHandler.updateForceDetail(arg_4_0, arg_4_1, arg_4_2)
	if zbUtil:isValidTable(arg_4_2) == false then
		return
	end

	local var_4_0 = false

	for iter_4_0, iter_4_1 in pairs(g_GameData.ForceSection) do
		if iter_4_1.ForceId == arg_4_1 then
			var_4_0 = true

			break
		end
	end

	if var_4_0 == false then
		local var_4_1 = {
			ForceId = arg_4_1,
			ForceList = {}
		}

		table.insert(var_4_1.ForceList, arg_4_2)
		table.insert(g_GameData.ForceSection, var_4_1)
	end

	for iter_4_2, iter_4_3 in pairs(g_GameData.ForceSection) do
		if iter_4_3.ForceId == arg_4_1 then
			local var_4_2 = false

			for iter_4_4, iter_4_5 in pairs(iter_4_3.ForceList) do
				if iter_4_5.LevelType == arg_4_2.LevelType then
					var_4_2 = true

					table.remove(iter_4_3.ForceList, iter_4_4)
					table.insert(iter_4_3.ForceList, arg_4_2)

					break
				end
			end

			if var_4_2 == false then
				table.insert(iter_4_3.ForceList, arg_4_2)
			end

			break
		end
	end

	arg_4_0:refresh()
	g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_ForceDetail)
end

function zbWarPathHandler.blevelPassed(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = ELevelType.Normal

	if arg_5_3 ~= nil then
		var_5_0 = arg_5_3
	end

	local var_5_1
	local var_5_2
	local var_5_3

	for iter_5_0, iter_5_1 in pairs(g_GameData.ForceSection) do
		if iter_5_1.ForceId == arg_5_1 then
			var_5_1 = iter_5_1.ForceList

			break
		end
	end

	if zbUtil:isValidTable(var_5_1) then
		for iter_5_2, iter_5_3 in pairs(var_5_1) do
			if iter_5_3.LevelType == var_5_0 then
				var_5_2 = iter_5_3.LevelList

				break
			end
		end
	end

	if zbUtil:isValidTable(var_5_2) then
		for iter_5_4, iter_5_5 in pairs(var_5_2) do
			if iter_5_5.LevelId == arg_5_2 then
				var_5_3 = iter_5_5

				break
			end
		end
	end

	if var_5_3 and var_5_3.StarCount > 0 then
		return true
	end

	return false
end

function zbWarPathHandler.getLevelInfo(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	return arg_6_0.levelModes[arg_6_1]:getLevelInfo(arg_6_2, arg_6_3)
end

function zbWarPathHandler.getLevelStar(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	return arg_7_0.levelModes[arg_7_1]:getLevelStar(arg_7_2, arg_7_3)
end

function zbWarPathHandler.getForceStarCount(arg_8_0, arg_8_1, arg_8_2)
	return arg_8_0.levelModes[arg_8_1]:getForceStarCount(arg_8_2)
end

function zbWarPathHandler.isFullStar(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0, var_9_1 = arg_9_0:getForceStarCount(arg_9_1, arg_9_2)

	return var_9_1 <= var_9_0
end

function zbWarPathHandler.isGetForceAward(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	return arg_10_0.levelModes[arg_10_1]:isGetForceAward(arg_10_2, arg_10_3)
end

function zbWarPathHandler.isVisibleForce(arg_11_0, arg_11_1, arg_11_2)
	return arg_11_0.levelModes[arg_11_1]:isVisibleForce(arg_11_2)
end

function zbWarPathHandler.isBossLevelPass(arg_12_0, arg_12_1, arg_12_2)
	return arg_12_0.levelModes[arg_12_1]:isBossLevelPass(arg_12_2)
end

function zbWarPathHandler.hasAvailableAward(arg_13_0)
	if arg_13_0.levelModes[ELevelType.Normal]:hasAvailableAward() then
		return true
	end

	if arg_13_0.levelModes[ELevelType.Elite]:hasAvailableAward() then
		return true
	end

	if arg_13_0.levelModes[ELevelType.Nightmare]:hasAvailableAward() then
		return true
	end

	if arg_13_0:hasTreaSureRedPoint() then
		return true
	end

	return false
end

function zbWarPathHandler.hasAvailableForceAward(arg_14_0, arg_14_1, arg_14_2)
	return arg_14_0.levelModes[arg_14_1]:hasAvailableForceAward(arg_14_2)
end

function zbWarPathHandler.hasTreaSureRedPoint(arg_15_0)
	return false
end
