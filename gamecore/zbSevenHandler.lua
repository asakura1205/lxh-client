local var_0_0 = class("zbSevenHandler")

var_0_0.__index = var_0_0

function createSevenHandler()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	arg_2_0.lastTemplateId = 0
end

function var_0_0.update(arg_3_0, arg_3_1)
	if zbUtil:isValidTable(g_GameData.ActivityOs) and zbUtil:isValidTable(g_GameData.ActivityOs.OsBaseInfo) then
		g_GameData.ActivityOs.OsBaseInfo.LeftTm = math.max(g_GameData.ActivityOs.OsBaseInfo.LeftTm - arg_3_1, 0)
	end
end

function var_0_0.getSevenVisible(arg_4_0)
	return zbUtil:isValidTable(g_GameData.ActivityOs)
end

function var_0_0.getSevenLessTime(arg_5_0)
	if zbUtil:isValidTable(g_GameData.ActivityOs) == false or zbUtil:isValidTable(g_GameData.ActivityOs.OsBaseInfo) == false then
		return 0
	else
		return g_GameData.ActivityOs.OsBaseInfo.LeftTm
	end
end

function var_0_0.hasSevenGift(arg_6_0)
	if zbUtil:isValidTable(g_GameData.ActivityOs) == false then
		return false
	end

	return arg_6_0:hasSignGift() or arg_6_0:hasStarGift() or arg_6_0:hasLevelGift() or arg_6_0:hasPataGift() or arg_6_0:hasArenaGift() or arg_6_0:hasPowerGift()
end

function var_0_0.hasSignGift(arg_7_0)
	if zbUtil:isValidTable(g_GameData.ActivityOs) == false or zbUtil:isValidTable(g_GameData.ActivityOs.LoginAward) == false then
		return false
	end

	for iter_7_0, iter_7_1 in pairs(g_GameData.ActivityOs.LoginAward.LoginAwardList) do
		if iter_7_1.State == 1 then
			return true
		end
	end

	return false
end

function var_0_0.hasStarGift(arg_8_0)
	if zbUtil:isValidTable(g_GameData.ActivityOs) == false or zbUtil:isValidTable(g_GameData.ActivityOs.StarAward) == false then
		return false
	end

	for iter_8_0, iter_8_1 in pairs(g_GameData.ActivityOs.StarAward) do
		if iter_8_1.State == 1 then
			return true
		end
	end

	return false
end

function var_0_0.hasLevelGift(arg_9_0)
	if zbUtil:isValidTable(g_GameData.ActivityOs) == false or zbUtil:isValidTable(g_GameData.ActivityOs.LevelAward) == false then
		return false
	end

	for iter_9_0, iter_9_1 in pairs(g_GameData.ActivityOs.LevelAward) do
		if iter_9_1.State == 1 then
			return true
		end
	end

	return false
end

function var_0_0.hasPataGift(arg_10_0)
	if zbUtil:isValidTable(g_GameData.ActivityOs) == false or zbUtil:isValidTable(g_GameData.ActivityOs.PataAward) == false then
		return false
	end

	for iter_10_0, iter_10_1 in pairs(g_GameData.ActivityOs.PataAward) do
		if iter_10_1.State == 1 then
			return true
		end
	end

	return false
end

function var_0_0.hasArenaGift(arg_11_0)
	if zbUtil:isValidTable(g_GameData.ActivityOs) == false or zbUtil:isValidTable(g_GameData.ActivityOs.ArenaAward) == false then
		return false
	end

	for iter_11_0, iter_11_1 in pairs(g_GameData.ActivityOs.ArenaAward) do
		if iter_11_1.State == 1 then
			return true
		end
	end

	return false
end

function var_0_0.hasPowerGift(arg_12_0)
	if zbUtil:isValidTable(g_GameData.ActivityOs) == false or zbUtil:isValidTable(g_GameData.ActivityOs.FVAward) == false then
		return false
	end

	for iter_12_0, iter_12_1 in pairs(g_GameData.ActivityOs.FVAward) do
		if iter_12_1.State == 1 then
			return true
		end
	end

	return false
end

function var_0_0.hasChargeGift(arg_13_0)
	if zbUtil:isValidTable(g_GameData.ActivityOs) == false or zbUtil:isValidTable(g_GameData.ActivityOs.RechargeAward) == false then
		return false
	end

	for iter_13_0, iter_13_1 in pairs(g_GameData.ActivityOs.RechargeAward) do
		if iter_13_1.State == 1 then
			return true
		end
	end

	return false
end
