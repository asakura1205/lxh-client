local var_0_0 = class("zbWealthHandler")

var_0_0.__index = var_0_0

function createWealthHandler()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	arg_2_0.lastTili = 0
end

function var_0_0.update(arg_3_0, arg_3_1)
	arg_3_0:updateTiliSyn()
end

function var_0_0.updateWealth(arg_4_0, arg_4_1)
	if zbUtil:isValidTable(arg_4_1) == false then
		return
	end

	g_GameData.Wealth = arg_4_1

	g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_Wealth)
end

function var_0_0.updateTiliSyn(arg_5_0)
	if g_GameData.Wealth.Tili < g_GameData.CapacityInfo.Tili and arg_5_0.lastTili > g_GameData.CapacityInfo.Tili then
		g_WsMsgHandler:WS_Common_HeartBeat_Req()
	end

	arg_5_0.lastTili = g_GameData.Wealth.Tili
end

function var_0_0.hasEnoughMoney(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == ECommonAwardType.Gold then
		return arg_6_2 <= g_GameData.Wealth.Gold
	elseif arg_6_1 == ECommonAwardType.Diamond then
		return arg_6_2 <= g_GameData.Wealth.Diamond
	elseif arg_6_1 == ECommonAwardType.Food then
		return arg_6_2 <= g_GameData.Wealth.Food
	elseif arg_6_1 == ECommonAwardType.Tili then
		return arg_6_2 <= g_GameData.Wealth.Tili
	elseif arg_6_1 == ECommonAwardType.Soul then
		return arg_6_2 <= g_GameData.Wealth.Soul
	elseif arg_6_1 == ECommonAwardType.BarCard then
		return arg_6_2 <= g_GameData.Wealth.BarCard
	elseif arg_6_1 == ECommonAwardType.BarMoney then
		return arg_6_2 <= g_GameData.Wealth.BarMoney
	elseif arg_6_1 == ECommonAwardType.EquipSoul then
		return arg_6_2 <= g_GameData.Wealth.EquipSoul
	elseif arg_6_1 == ECommonAwardType.Arena then
		return arg_6_2 <= g_GameData.Wealth.Arena
	elseif arg_6_1 == ECommonAwardType.Bgz then
		return arg_6_2 <= g_GameData.Wealth.Bgz
	elseif arg_6_1 == ECommonAwardType.Legion then
		return arg_6_2 <= g_GameData.Wealth.Legion
	elseif arg_6_1 == ECommonAwardType.Horn then
		return arg_6_2 <= g_GameData.Wealth.Horn
	elseif arg_6_1 == ECommonAwardType.DollsMoney then
		return arg_6_2 <= g_GameData.Wealth.DollsMoney
	end

	return false
end

function var_0_0.getWealthMoneyByType(arg_7_0, arg_7_1)
	if arg_7_1 == ECommonAwardType.Gold then
		return g_GameData.Wealth.Gold
	elseif arg_7_1 == ECommonAwardType.Diamond then
		return g_GameData.Wealth.Diamond
	elseif arg_7_1 == ECommonAwardType.Food then
		return g_GameData.Wealth.Food
	elseif arg_7_1 == ECommonAwardType.Tili then
		return g_GameData.Wealth.Tili
	elseif arg_7_1 == ECommonAwardType.BarCard then
		return g_GameData.Wealth.BarCard
	elseif arg_7_1 == ECommonAwardType.BarMoney then
		return g_GameData.Wealth.BarMoney
	elseif arg_7_1 == ECommonAwardType.Soul then
		return g_GameData.Wealth.Soul
	elseif arg_7_1 == ECommonAwardType.EquipSoul then
		return g_GameData.Wealth.EquipSoul
	elseif arg_7_1 == ECommonAwardType.Arena then
		return g_GameData.Wealth.Arena
	elseif arg_7_1 == ECommonAwardType.Bgz then
		return g_GameData.Wealth.Bgz
	elseif arg_7_1 == ECommonAwardType.Legion then
		return g_GameData.Wealth.Legion
	elseif arg_7_1 == ECommonAwardType.Horn then
		return g_GameData.Wealth.Horn
	elseif arg_7_1 == ECommonAwardType.DollsMoney then
		return g_GameData.Wealth.DollsMoney
	end

	return 0
end
