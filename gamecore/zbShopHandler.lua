local var_0_0 = class("zbShopHandler")

var_0_0.__index = var_0_0

function createShopHandler()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	arg_2_0.AllShopList = {}
	arg_2_0.shopLastRefreshTime = {}
end

function var_0_0.updateShopList(arg_3_0, arg_3_1)
	if zbUtil:isValidTable(arg_3_1) == false then
		echo("warning: invalid allShopInfo")

		return
	end

	if zbUtil:isValidTable(arg_3_1.AllShopList) then
		arg_3_0.AllShopList = arg_3_1.AllShopList
	end

	for iter_3_0, iter_3_1 in pairs(arg_3_0.AllShopList) do
		arg_3_0.shopLastRefreshTime[iter_3_1.ShopType] = zbUtil:SprintfHHMMSS(g_Self.kTimeHandler:getServerTime() + g_Self.kTimeHandler:getTimeZoneDelt())
	end

	g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_Shop)
end

function var_0_0.updateShopDetail(arg_4_0, arg_4_1)
	if zbUtil:isValidTable(arg_4_1) == false then
		echo("warning: invalid shopInfo")

		return
	end

	for iter_4_0, iter_4_1 in pairs(arg_4_0.AllShopList) do
		if iter_4_1.ShopType == arg_4_1.ShopType then
			table.remove(arg_4_0.AllShopList, iter_4_0)
			table.insert(arg_4_0.AllShopList, arg_4_1)
			g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_Shop)

			return
		end
	end
end

function var_0_0.getShopData(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.AllShopList) do
		if iter_5_1.ShopType == arg_5_1 then
			return iter_5_1
		end
	end

	return nil
end

function var_0_0.getShopListByType(arg_6_0, arg_6_1)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(arg_6_0.AllShopList) do
		if iter_6_1.ShopType == arg_6_1 then
			var_6_0 = iter_6_1.ItemList
		end
	end

	return var_6_0
end

function var_0_0.needRefreshShop(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.shopLastRefreshTime[arg_7_1]

	if var_7_0 == nil then
		return true
	end

	local var_7_1 = zbUtil:SprintfHHMMSS(g_Self.kTimeHandler:getServerTime() + g_Self.kTimeHandler:getTimeZoneDelt())
	local var_7_2 = g_DataConfig.m_kCommonCfg.shops[arg_7_1].dailyRefreshTime

	for iter_7_0 = 1, table.getn(var_7_2) do
		if var_7_1 >= var_7_2[iter_7_0] and var_7_0 < var_7_2[iter_7_0] then
			return true
		end
	end

	return false
end

function var_0_0.getNextRefreshTime(arg_8_0, arg_8_1)
	local var_8_0 = zbUtil:SprintfHHMMSS(g_Self.kTimeHandler:getServerTime() + g_Self.kTimeHandler:getTimeZoneDelt())
	local var_8_1 = g_DataConfig.m_kCommonCfg.shops[arg_8_1].dailyRefreshTime
	local var_8_2 = var_8_1[1]

	for iter_8_0 = 1, table.getn(var_8_1) do
		if var_8_0 < var_8_1[iter_8_0] then
			var_8_2 = var_8_1[iter_8_0]

			break
		end
	end

	return (zbUtil:getNextRefreshTime(var_8_2))
end

function var_0_0.getShopItemByShopIndex(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0:getShopListItem(arg_9_1)

	for iter_9_0, iter_9_1 in pairs(var_9_0) do
		if iter_9_1.ShopIndex == arg_9_2 then
			return iter_9_1
		end
	end

	return nil
end

function var_0_0.gethaveShopItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = 0

	if arg_10_1 == ECommonAwardType.Hero then
		if g_Self.kHeroHandler:hasHeroByTemplateId(arg_10_2) == true then
			var_10_0 = 1
		end
	elseif arg_10_1 == ECommonAwardType.HeroFrag then
		var_10_0 = g_Self.kHeroFragHandler:getHeroFragCount(arg_10_2)
	elseif arg_10_1 == ECommonAwardType.Item then
		var_10_0 = g_Self.kBagItemHandler:getItemCountByTemplateId(arg_10_2)
	elseif arg_10_1 == ECommonAwardType.EquipFrag then
		var_10_0 = g_Self.kEquipFragHandler:getEquipFragCount(arg_10_2)
	elseif arg_10_1 == ECommonAwardType.RoleExp then
		-- block empty
	else
		var_10_0 = g_Self.kWealthHandler:getWealthMoneyByType(arg_10_1)
	end

	return var_10_0
end
