local var_0_0 = class("zbHeroTrialHandler")

var_0_0.__index = var_0_0

function createHeroTrialHandler()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	arg_2_0.DollsList = {}
	arg_2_0.DollsInfo = {}
end

function var_0_0.openHeroTrial(arg_3_0)
	if g_GameData.TrialInfo == nil then
		g_WsMsgHandler:WS_Trial_GetInfo_Req()

		return
	end

	g_MainScene:showHeroTrialWnd()
end

function var_0_0.updateAllTrialInfo(arg_4_0, arg_4_1)
	if zbUtil:isValidTable(arg_4_1) == false then
		echo("warning: invalid allTrialInfo")

		return
	end

	g_GameData.TrialInfo = arg_4_1

	g_Self.kRedPointHandler:refreshHeroTrial()
end

function var_0_0.updateTrialInfo(arg_5_0, arg_5_1)
	if zbUtil:isValidTable(arg_5_1) == false then
		echo("warning: invalid trialInfo")

		return
	end

	for iter_5_0, iter_5_1 in pairs(g_GameData.TrialInfo.TrialList) do
		if iter_5_1.TrialType == arg_5_1.TrialType then
			table.remove(g_GameData.TrialInfo.TrialList, iter_5_0)
			table.insert(g_GameData.TrialInfo.TrialList, arg_5_1)
			g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_TrialInfo)
			g_Self.kRedPointHandler:refreshHeroTrial()

			return
		end
	end

	echo("warning: no match exist trialInfo")
end

function var_0_0.getLeftTrialNumByType(arg_6_0, arg_6_1)
	local var_6_0 = 0
	local var_6_1 = 0

	if zbUtil:isValidTable(g_GameData.TrialInfo) then
		for iter_6_0, iter_6_1 in pairs(g_GameData.TrialInfo.TrialList) do
			if iter_6_1.TrialType == arg_6_1 then
				var_6_0 = iter_6_1.FightCount
				var_6_1 = iter_6_1.LimitCount

				break
			end
		end
	end

	return var_6_1 - var_6_0, var_6_1
end

function var_0_0.getTrialStars(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in pairs(g_GameData.TrialInfo.TrialList) do
		if iter_7_1.TrialType == arg_7_1 then
			for iter_7_2, iter_7_3 in pairs(iter_7_1.LevelList) do
				if iter_7_3.TrailLevel == arg_7_2 then
					var_7_0 = iter_7_3.MaxStar
				end
			end
		end
	end

	return var_7_0
end

function var_0_0.hasChallengeNotify(arg_8_0, arg_8_1)
	local var_8_0, var_8_1 = arg_8_0:getLeftTrialNumByType(arg_8_1)

	if var_8_0 > 0 then
		return true
	end

	return false
end

function var_0_0.updateDollsInfo(arg_9_0, arg_9_1)
	if zbUtil:isValidTable(arg_9_1) == false then
		echo("warning: invalid DollsInfo")

		return
	end

	arg_9_0.DollsInfo = arg_9_1

	local var_9_0 = zbUtil:random(1, 8)
	local var_9_1 = 0

	for iter_9_0, iter_9_1 in pairs(arg_9_1.ItemList) do
		if var_9_1 == var_9_0 then
			local var_9_2 = {
				Index = 0
			}

			table.insert(arg_9_0.DollsList, var_9_2)
		end

		table.insert(arg_9_0.DollsList, iter_9_1)

		var_9_1 = var_9_1 + 1
	end
end
