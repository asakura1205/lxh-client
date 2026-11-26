local var_0_0 = class("zbHeroFragHandler")

var_0_0.__index = var_0_0

function createHeroFragHandler()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	return
end

function var_0_0.fragNew(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in pairs(arg_3_1) do
		table.insert(g_GameData.HeroFragList, iter_3_1)
	end

	if table.getn(arg_3_1) > 0 then
		g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_FragHero)
	end
end

function var_0_0.fragUpdate(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in pairs(arg_4_1) do
		local var_4_0 = false

		for iter_4_2, iter_4_3 in pairs(g_GameData.HeroFragList) do
			if iter_4_3.TemplateId == iter_4_1.TemplateId then
				table.remove(g_GameData.HeroFragList, iter_4_2)
				table.insert(g_GameData.HeroFragList, iter_4_1)

				var_4_0 = true

				break
			end
		end

		if var_4_0 == false then
			echo("warning: can not find valid bagItem: " .. iter_4_1.TemplateId)
		end
	end

	if table.getn(arg_4_1) > 0 then
		g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_FragHero)
	end
end

function var_0_0.fragDel(arg_5_0, arg_5_1)
	local var_5_0 = false

	for iter_5_0, iter_5_1 in pairs(arg_5_1) do
		for iter_5_2, iter_5_3 in pairs(g_GameData.HeroFragList) do
			if iter_5_3.TemplateId == iter_5_1 then
				table.remove(g_GameData.HeroFragList, iter_5_2)

				var_5_0 = true

				break
			end
		end
	end

	if var_5_0 then
		g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_FragHero)
	end
end

function var_0_0.getHeroFragCount(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(g_GameData.HeroFragList) do
		if iter_6_1.TemplateId == arg_6_1 then
			return iter_6_1.Count
		end
	end

	return 0
end

function var_0_0.getHeroFragData(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in pairs(g_GameData.HeroFragList) do
		if iter_7_1.TemplateId == arg_7_1 then
			return iter_7_1
		end
	end

	return nil
end

function var_0_0.getHeroCanStarUp(arg_8_0, arg_8_1)
	local var_8_0 = g_Self.kHeroHandler:getHeroByTemplateId(arg_8_1)
	local var_8_1 = zbHeroTable:getRecord(arg_8_1)

	if var_8_0 == nil or var_8_0.HeroBaseInfo.Star >= var_8_1.startMax then
		return false
	end

	local var_8_2 = zbHeroStarUpgradeTable:getRecord(var_8_0.HeroBaseInfo.Star)

	if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Gold, var_8_2.gold) == false then
		return false
	end

	for iter_8_0, iter_8_1 in pairs(g_GameData.HeroFragList) do
		if arg_8_1 == iter_8_1.TemplateId then
			local var_8_3 = arg_8_0:getHeroComposeNeeds(iter_8_1.TemplateId)

			if var_8_3 and iter_8_1.Count >= var_8_3.needFrag then
				return true
			end
		end
	end

	return false
end

function var_0_0.getHeroComposeNeeds(arg_9_0, arg_9_1)
	local var_9_0 = g_Self.kHeroHandler:getHeroByTemplateId(arg_9_1)
	local var_9_1 = zbHeroTable:getRecord(arg_9_1)
	local var_9_2 = {}
	local var_9_3 = 1

	if var_9_0 ~= nil then
		if var_9_0.HeroBaseInfo.Star < var_9_1.startMax and var_9_0.HeroBaseInfo.Star >= 1 then
			var_9_3 = var_9_0.HeroBaseInfo.Star + 1
		elseif var_9_0.HeroBaseInfo.Star >= var_9_1.startMax then
			var_9_3 = var_9_0.HeroBaseInfo.Star
		end
	elseif var_9_1 then
		var_9_3 = var_9_1.star
	end

	var_9_2.needFrag = zbHeroTable:getHeroStarUpNeedFrag(arg_9_1, var_9_3)
	var_9_2.needGold = zbHeroStarUpgradeTable:getRecord(var_9_3).gold

	return var_9_2
end

function var_0_0.getSortedHeroFragsByType(arg_10_0)
	local var_10_0 = {}
	local var_10_1 = zbHeroTable:getNeedShowList()

	for iter_10_0, iter_10_1 in pairs(g_GameData.HeroFragList) do
		if g_Self.kHeroHandler:getHeroByTemplateId(iter_10_1.TemplateId) == nil then
			table.insert(var_10_0, iter_10_1)

			var_10_1[iter_10_1.TemplateId] = nil
		end
	end

	for iter_10_2, iter_10_3 in pairs(var_10_1) do
		if iter_10_3 ~= nil and g_Self.kHeroHandler:getHeroByTemplateId(iter_10_2) == nil then
			local var_10_2 = {
				TemplateId = iter_10_2
			}

			var_10_2.Count = 0

			table.insert(var_10_0, var_10_2)
		end
	end

	local function var_10_3(arg_11_0, arg_11_1)
		if arg_11_0.Count == arg_11_1.Count then
			local var_11_0 = zbHeroTable:getRecord(arg_11_0.TemplateId)
			local var_11_1 = zbHeroTable:getRecord(arg_11_1.TemplateId)

			if not var_11_0 or not var_11_1 then
				return false
			end

			if var_11_0.quality == var_11_1.quality then
				return var_11_0.star > var_11_1.star
			end

			return var_11_0.quality > var_11_1.quality
		end

		return arg_11_0.Count > arg_11_1.Count
	end

	table.sort(var_10_0, var_10_3)

	return var_10_0
end
