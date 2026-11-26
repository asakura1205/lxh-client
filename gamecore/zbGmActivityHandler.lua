local var_0_0 = class("zbGmActivityHandler")

var_0_0.__index = var_0_0

function createGmActivityHandler()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	arg_2_0.lastTime = os_timenow()
	arg_2_0.curSprintTime = ""
	arg_2_0.testDelta = 5
end

function var_0_0.update(arg_3_0)
	if os_timenow() - arg_3_0.lastTime > arg_3_0.testDelta then
		local var_3_0 = zbUtil:SprintfHHMMSS(g_Self.kTimeHandler:getServerTime() + g_Self.kTimeHandler:getTimeZoneDelt())

		arg_3_0:refreshTime()
	end
end

function var_0_0.refreshTime(arg_4_0)
	arg_4_0.lastTime = os_timenow()

	local var_4_0 = zbUtil:SprintfYYYYMMDD(g_Self.kTimeHandler:getServerTime())
	local var_4_1 = zbUtil:SprintfHHMMSS(g_Self.kTimeHandler:getServerTime() + g_Self.kTimeHandler:getTimeZoneDelt())

	arg_4_0.curSprintTime = var_4_0 .. " " .. var_4_1

	if var_4_1 > "23:58:00" then
		arg_4_0.testDelta = 5
	else
		arg_4_0.testDelta = 60
	end
end

function var_0_0.isShowTime(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == 0 and arg_5_2 == 0 then
		return true
	end

	if arg_5_0.curSprintTime == "" then
		return false
	end

	if arg_5_1 <= arg_5_0.curSprintTime and arg_5_2 >= arg_5_0.curSprintTime then
		return true
	end

	return false
end

function var_0_0.getActivityGmCount(arg_6_0)
	local var_6_0 = 0
	local var_6_1 = 0
	local var_6_2 = 0
	local var_6_3 = 0
	local var_6_4 = 0
	local var_6_5 = 0
	local var_6_6 = 0
	local var_6_7 = 0

	if zbUtil:isValidTable(g_GameData.ActivityGm) == true then
		var_6_5 = var_6_0 + 1

		if zbUtil:isValidTable(g_GameData.ActivityGm.Fund) == true and arg_6_0:isShowTime(g_GameData.ActivityGm.Fund.GmBaseInfo.ShowStart, g_GameData.ActivityGm.Fund.GmBaseInfo.ShowEnd) then
			var_6_0 = var_6_0 + 1
		end

		if zbUtil:isValidTable(g_GameData.ActivityGm.FundWelfare) == true and arg_6_0:isShowTime(g_GameData.ActivityGm.FundWelfare.GmBaseInfo.ShowStart, g_GameData.ActivityGm.FundWelfare.GmBaseInfo.ShowEnd) then
			var_6_0 = var_6_0 + 1
		end

		if zbUtil:isValidTable(g_GameData.ActivityGm.Notice) == true then
			for iter_6_0, iter_6_1 in pairs(g_GameData.ActivityGm.Notice) do
				if arg_6_0:isShowTime(iter_6_1.ShowStart, iter_6_1.ShowEnd) then
					var_6_0 = var_6_0 + 1
				end
			end
		end

		if zbUtil:isValidTable(g_GameData.ActivityGm.DoubleDrop) == true then
			for iter_6_2, iter_6_3 in pairs(g_GameData.ActivityGm.DoubleDrop) do
				if arg_6_0:isShowTime(iter_6_3.GmBaseInfo.ShowStart, iter_6_3.GmBaseInfo.ShowEnd) then
					var_6_0 = var_6_0 + 1
				end
			end
		end

		if zbUtil:isValidTable(g_GameData.ActivityGm.DailyActive) == true then
			for iter_6_4, iter_6_5 in pairs(g_GameData.ActivityGm.DailyActive) do
				if arg_6_0:isShowTime(iter_6_5.GmBaseInfo.ShowStart, iter_6_5.GmBaseInfo.ShowEnd) then
					var_6_0 = var_6_0 + 1
				end
			end
		end

		if zbUtil:isValidTable(g_GameData.ActivityGm.ItemExchange) == true then
			for iter_6_6, iter_6_7 in pairs(g_GameData.ActivityGm.ItemExchange) do
				if arg_6_0:isShowTime(iter_6_7.GmBaseInfo.ShowStart, iter_6_7.GmBaseInfo.ShowEnd) then
					var_6_0 = var_6_0 + 1
				end
			end
		end

		if zbUtil:isValidTable(g_GameData.ActivityGm.LimitTimeHero) == true then
			if table.getn(g_GameData.ActivityGm.LimitTimeHero) > 0 then
				var_6_1 = var_6_0 + 1
			end

			for iter_6_8, iter_6_9 in pairs(g_GameData.ActivityGm.LimitTimeHero) do
				if arg_6_0:isShowTime(iter_6_9.GmBaseInfo.ShowStart, iter_6_9.GmBaseInfo.ShowEnd) then
					var_6_0 = var_6_0 + 1
				end
			end
		end

		if zbUtil:isValidTable(g_GameData.ActivityGm.LimitTimeShop) == true then
			if table.getn(g_GameData.ActivityGm.LimitTimeShop) > 0 then
				var_6_6 = var_6_0 + 1
			end

			for iter_6_10, iter_6_11 in pairs(g_GameData.ActivityGm.LimitTimeShop) do
				if arg_6_0:isShowTime(iter_6_11.GmBaseInfo.ShowStart, iter_6_11.GmBaseInfo.ShowEnd) then
					var_6_0 = var_6_0 + 1
				end
			end
		end

		if zbUtil:isValidTable(g_GameData.ActivityGm.RechargeDaily) == true then
			if table.getn(g_GameData.ActivityGm.RechargeDaily) > 0 then
				var_6_3 = var_6_0 + 1
			end

			for iter_6_12, iter_6_13 in pairs(g_GameData.ActivityGm.RechargeDaily) do
				if arg_6_0:isShowTime(iter_6_13.GmBaseInfo.ShowStart, iter_6_13.GmBaseInfo.ShowEnd) then
					var_6_0 = var_6_0 + 1
				end
			end
		end

		if zbUtil:isValidTable(g_GameData.ActivityGm.RechargeDailySum) == true then
			for iter_6_14, iter_6_15 in pairs(g_GameData.ActivityGm.RechargeDailySum) do
				if arg_6_0:isShowTime(iter_6_15.GmBaseInfo.ShowStart, iter_6_15.GmBaseInfo.ShowEnd) then
					var_6_0 = var_6_0 + 1
				end
			end
		end

		if zbUtil:isValidTable(g_GameData.ActivityGm.RechargeDailySingle) == true then
			for iter_6_16, iter_6_17 in pairs(g_GameData.ActivityGm.RechargeDailySingle) do
				if arg_6_0:isShowTime(iter_6_17.GmBaseInfo.ShowStart, iter_6_17.GmBaseInfo.ShowEnd) then
					var_6_0 = var_6_0 + 1
				end
			end
		end

		if zbUtil:isValidTable(g_GameData.ActivityGm.RechargeSingle) == true then
			if table.getn(g_GameData.ActivityGm.RechargeSingle) > 0 then
				var_6_4 = var_6_0 + 1
			end

			for iter_6_18, iter_6_19 in pairs(g_GameData.ActivityGm.RechargeSingle) do
				if arg_6_0:isShowTime(iter_6_19.GmBaseInfo.ShowStart, iter_6_19.GmBaseInfo.ShowEnd) then
					var_6_0 = var_6_0 + 1
				end
			end
		end

		if zbUtil:isValidTable(g_GameData.ActivityGm.RechargeSum) == true then
			if table.getn(g_GameData.ActivityGm.RechargeSum) > 0 then
				var_6_2 = var_6_0 + 1
			end

			for iter_6_20, iter_6_21 in pairs(g_GameData.ActivityGm.RechargeSum) do
				if arg_6_0:isShowTime(iter_6_21.GmBaseInfo.ShowStart, iter_6_21.GmBaseInfo.ShowEnd) then
					var_6_0 = var_6_0 + 1
				end
			end
		end

		if zbUtil:isValidTable(g_GameData.ActivityGm.ConsumSum) == true then
			if table.getn(g_GameData.ActivityGm.ConsumSum) > 0 then
				var_6_7 = var_6_0 + 1
			end

			for iter_6_22, iter_6_23 in pairs(g_GameData.ActivityGm.ConsumSum) do
				if arg_6_0:isShowTime(iter_6_23.GmBaseInfo.ShowStart, iter_6_23.GmBaseInfo.ShowEnd) then
					var_6_0 = var_6_0 + 1
				end
			end
		end

		if zbUtil:isValidTable(g_GameData.ActivityGm.ConsumDailySum) == true then
			for iter_6_24, iter_6_25 in pairs(g_GameData.ActivityGm.ConsumDailySum) do
				if arg_6_0:isShowTime(iter_6_25.GmBaseInfo.ShowStart, iter_6_25.GmBaseInfo.ShowEnd) then
					var_6_0 = var_6_0 + 1
				end
			end
		end

		if zbUtil:isValidTable(g_GameData.ActivityGm.HeroReset) == true then
			for iter_6_26, iter_6_27 in pairs(g_GameData.ActivityGm.HeroReset) do
				if arg_6_0:isShowTime(iter_6_27.GmBaseInfo.ShowStart, iter_6_27.GmBaseInfo.ShowEnd) then
					var_6_0 = var_6_0 + 1
				end
			end
		end
	end

	return var_6_0, var_6_1, var_6_2, var_6_3, var_6_4, var_6_5, var_6_6, var_6_7
end

function var_0_0.getActiveInfoByActId(arg_7_0, arg_7_1)
	if zbUtil:isValidTable(g_GameData.ActivityGm) == true and zbUtil:isValidTable(g_GameData.ActivityGm.DailyActive) == true then
		for iter_7_0, iter_7_1 in pairs(g_GameData.ActivityGm.DailyActive) do
			if iter_7_1.ActId == arg_7_1 then
				return iter_7_1
			end
		end
	end

	return nil
end

function var_0_0.getExchangeInfoByActId(arg_8_0, arg_8_1)
	if zbUtil:isValidTable(g_GameData.ActivityGm) == true and zbUtil:isValidTable(g_GameData.ActivityGm.ItemExchange) == true then
		for iter_8_0, iter_8_1 in pairs(g_GameData.ActivityGm.ItemExchange) do
			if iter_8_1.ActId == arg_8_1 then
				return iter_8_1
			end
		end
	end

	return nil
end

function var_0_0.getTimeHeroInfoByActId(arg_9_0, arg_9_1)
	if zbUtil:isValidTable(g_GameData.ActivityGm) == true and zbUtil:isValidTable(g_GameData.ActivityGm.LimitTimeHero) == true then
		for iter_9_0, iter_9_1 in pairs(g_GameData.ActivityGm.LimitTimeHero) do
			if iter_9_1.ActId == arg_9_1 then
				return iter_9_1
			end
		end
	end

	return nil
end

function var_0_0.getTimeShopInfoByActId(arg_10_0, arg_10_1)
	if zbUtil:isValidTable(g_GameData.ActivityGm) == true and zbUtil:isValidTable(g_GameData.ActivityGm.LimitTimeShop) == true then
		for iter_10_0, iter_10_1 in pairs(g_GameData.ActivityGm.LimitTimeShop) do
			if iter_10_1.ActId == arg_10_1 then
				return iter_10_1
			end
		end
	end

	return nil
end

function var_0_0.getRechargeDailyInfoByActId(arg_11_0, arg_11_1)
	if zbUtil:isValidTable(g_GameData.ActivityGm) == true and zbUtil:isValidTable(g_GameData.ActivityGm.RechargeDaily) == true then
		for iter_11_0, iter_11_1 in pairs(g_GameData.ActivityGm.RechargeDaily) do
			if iter_11_1.ActId == arg_11_1 then
				return iter_11_1
			end
		end
	end

	return nil
end

function var_0_0.getRechargeDailySumInfoByActId(arg_12_0, arg_12_1)
	if zbUtil:isValidTable(g_GameData.ActivityGm) == true and zbUtil:isValidTable(g_GameData.ActivityGm.RechargeDailySum) == true then
		for iter_12_0, iter_12_1 in pairs(g_GameData.ActivityGm.RechargeDailySum) do
			if iter_12_1.ActId == arg_12_1 then
				return iter_12_1
			end
		end
	end

	return nil
end

function var_0_0.getRechargeDailySingleInfoByActId(arg_13_0, arg_13_1)
	if zbUtil:isValidTable(g_GameData.ActivityGm) == true and zbUtil:isValidTable(g_GameData.ActivityGm.RechargeDailySingle) == true then
		for iter_13_0, iter_13_1 in pairs(g_GameData.ActivityGm.RechargeDailySingle) do
			if iter_13_1.ActId == arg_13_1 then
				return iter_13_1
			end
		end
	end

	return nil
end

function var_0_0.getRechargeSingleInfoByActId(arg_14_0, arg_14_1)
	if zbUtil:isValidTable(g_GameData.ActivityGm) == true and zbUtil:isValidTable(g_GameData.ActivityGm.RechargeSingle) == true then
		for iter_14_0, iter_14_1 in pairs(g_GameData.ActivityGm.RechargeSingle) do
			if iter_14_1.ActId == arg_14_1 then
				return iter_14_1
			end
		end
	end

	return nil
end

function var_0_0.getRechargeSumInfoByActId(arg_15_0, arg_15_1)
	if zbUtil:isValidTable(g_GameData.ActivityGm) == true and zbUtil:isValidTable(g_GameData.ActivityGm.RechargeSum) == true then
		for iter_15_0, iter_15_1 in pairs(g_GameData.ActivityGm.RechargeSum) do
			if iter_15_1.ActId == arg_15_1 then
				return iter_15_1
			end
		end
	end

	return nil
end

function var_0_0.getConsumSumInfoByActId(arg_16_0, arg_16_1)
	if zbUtil:isValidTable(g_GameData.ActivityGm) == true and zbUtil:isValidTable(g_GameData.ActivityGm.ConsumSum) == true then
		for iter_16_0, iter_16_1 in pairs(g_GameData.ActivityGm.ConsumSum) do
			if iter_16_1.ActId == arg_16_1 then
				return iter_16_1
			end
		end
	end

	return nil
end

function var_0_0.getConsumDailySumInfoByActId(arg_17_0, arg_17_1)
	if zbUtil:isValidTable(g_GameData.ActivityGm) == true and zbUtil:isValidTable(g_GameData.ActivityGm.ConsumDailySum) == true then
		for iter_17_0, iter_17_1 in pairs(g_GameData.ActivityGm.ConsumDailySum) do
			if iter_17_1.ActId == arg_17_1 then
				return iter_17_1
			end
		end
	end

	return nil
end

function var_0_0.hasGmActivityGift(arg_18_0)
	GMTAB_COUNT, GMTAB_LIMITHERO, GMTAB_RECHARGESUM, GMTAB_RECHARGEDAILY, GMTAB_RECHARGESINGLE, GMTAB_FUND, GMTAB_LIMITSHOP, GMTAB_CONSUMSUM = arg_18_0:getActivityGmCount()

	if zbUtil:isValidTable(g_GameData.ActivityGm) == false then
		return false
	end

	if arg_18_0:hasFundGift() == true or arg_18_0:hasFundWelfareGift() == true then
		return true
	end

	for iter_18_0 = 1, GMTAB_COUNT do
		if arg_18_0:hasActivieGift(iter_18_0) == true then
			return true
		elseif arg_18_0:hasExchangeGift(iter_18_0) == true then
			return true
		elseif arg_18_0:hasTimeHeroGift(iter_18_0) == true then
			return true
		elseif arg_18_0:hasRechargeDailyGift(iter_18_0) == true then
			return true
		elseif arg_18_0:hasRechargeDailySumGift(iter_18_0) == true then
			return true
		elseif arg_18_0:hasRechargeDailySingleGift(iter_18_0) == true then
			return true
		elseif arg_18_0:hasRechargeSingleGift(iter_18_0) == true then
			return true
		elseif arg_18_0:hasRechargeSumGift(iter_18_0) == true then
			return true
		elseif arg_18_0:hasConsumSumGift(iter_18_0) == true then
			return true
		elseif arg_18_0:hasConsumDailySumGift(iter_18_0) == true then
			return true
		end
	end

	return false
end

function var_0_0.hasActivieGift(arg_19_0, arg_19_1)
	if zbUtil:isValidTable(g_GameData.ActivityGm) == false or zbUtil:isValidTable(g_GameData.ActivityGm.DailyActive) == false or zbUtil:isValidTable(g_GameData.ActivityGm.DailyActive[arg_19_1]) == false then
		return false
	end

	if g_GameData.DailyTask.ActiveCount >= 100 and g_GameData.ActivityGm.DailyActive[arg_19_1].State == 0 then
		return true
	end

	return false
end

function var_0_0.hasExchangeGift(arg_20_0, arg_20_1)
	if zbUtil:isValidTable(g_GameData.ActivityGm) == false or zbUtil:isValidTable(g_GameData.ActivityGm.ItemExchange) == false or zbUtil:isValidTable(g_GameData.ActivityGm.ItemExchange[arg_20_1]) == false then
		return false
	end

	for iter_20_0, iter_20_1 in pairs(g_GameData.ActivityGm.ItemExchange[arg_20_1].ExchangeList) do
		if (iter_20_1.LimitNum == 0 or iter_20_1.LimitNum > iter_20_1.ExchangeNum) and g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Diamond, iter_20_1.CostDiamond) == true and iter_20_1.CostNum < g_Self.kBagItemHandler:getItemCountByTemplateId(g_GameData.ActivityGm.ItemExchange[arg_20_1].TemplateId) then
			return true
		end
	end

	return false
end

function var_0_0.hasTimeHeroGift(arg_21_0, arg_21_1)
	if zbUtil:isValidTable(g_GameData.ActivityGm) == false or zbUtil:isValidTable(g_GameData.ActivityGm.LimitTimeHero) == false or zbUtil:isValidTable(g_GameData.ActivityGm.LimitTimeHero[arg_21_1]) == false then
		return false
	end

	if arg_21_0:isShowTime(g_GameData.ActivityGm.LimitTimeHero[arg_21_1].GmBaseInfo.ActStart, g_GameData.ActivityGm.LimitTimeHero[arg_21_1].GmBaseInfo.ActEnd) == false then
		return false
	end

	if g_GameData.ActivityGm.LimitTimeHero[arg_21_1].FreeTm ~= nil and g_GameData.ActivityGm.LimitTimeHero[arg_21_1].FreeTm - g_Self.kTimeHandler:getServerTime() <= 0 then
		return true
	end

	for iter_21_0, iter_21_1 in pairs(g_GameData.ActivityGm.LimitTimeHero[arg_21_1].ScoreList) do
		if (iter_21_1.LimitNum == 0 or iter_21_1.LimitNum > iter_21_1.ExchangeNum) and iter_21_1.Score < g_GameData.ActivityGm.LimitTimeHero[arg_21_1].LeftScore then
			return true
		end
	end

	return false
end

function var_0_0.getTimeHeroGift(arg_22_0)
	for iter_22_0 = 1, GMTAB_COUNT do
		if arg_22_0:hasTimeHeroGift(iter_22_0) == true then
			return iter_22_0
		end
	end

	return false
end

function var_0_0.getRechargeSumGift(arg_23_0)
	for iter_23_0 = 1, GMTAB_COUNT do
		if arg_23_0:hasRechargeSumGift(iter_23_0) == true then
			return iter_23_0
		end
	end

	return false
end

function var_0_0.getRechargeDailyGift(arg_24_0)
	for iter_24_0 = 1, GMTAB_COUNT do
		if arg_24_0:hasRechargeDailyGift(iter_24_0) == true then
			return iter_24_0
		end
	end

	return false
end

function var_0_0.getRechargeSingleGift(arg_25_0)
	for iter_25_0 = 1, GMTAB_COUNT do
		if arg_25_0:hasRechargeSingleGift(iter_25_0) == true then
			return iter_25_0
		end
	end

	return false
end

function var_0_0.getConsumSumGift(arg_26_0)
	for iter_26_0 = 1, GMTAB_COUNT do
		if arg_26_0:hasConsumSumGift(iter_26_0) == true then
			return iter_26_0
		end
	end

	return false
end

function var_0_0.hasFundGift(arg_27_0)
	if zbUtil:isValidTable(g_GameData.ActivityGm) == false or zbUtil:isValidTable(g_GameData.ActivityGm.Fund) == false then
		return false
	end

	for iter_27_0, iter_27_1 in pairs(g_GameData.ActivityGm.Fund.IncomeList) do
		if iter_27_1.State == 0 and g_Self:getLevel() >= iter_27_1.Level and g_GameData.ActivityGm.Fund.BuyState == 1 then
			return true
		end
	end

	return false
end

function var_0_0.hasFundWelfareGift(arg_28_0)
	if zbUtil:isValidTable(g_GameData.ActivityGm) == false or zbUtil:isValidTable(g_GameData.ActivityGm.FundWelfare) == false then
		return false
	end

	for iter_28_0, iter_28_1 in pairs(g_GameData.ActivityGm.FundWelfare.WelfareList) do
		if iter_28_1.State == 1 then
			return true
		end
	end

	return false
end

function var_0_0.hasRechargeDailyGift(arg_29_0, arg_29_1)
	if zbUtil:isValidTable(g_GameData.ActivityGm) == false or zbUtil:isValidTable(g_GameData.ActivityGm.RechargeDaily) == false or zbUtil:isValidTable(g_GameData.ActivityGm.RechargeDaily[arg_29_1]) == false then
		return false
	end

	for iter_29_0, iter_29_1 in pairs(g_GameData.ActivityGm.RechargeDaily[arg_29_1].DayList) do
		if iter_29_1.State == 1 then
			return true
		end
	end

	return false
end

function var_0_0.hasRechargeDailySumGift(arg_30_0, arg_30_1)
	if zbUtil:isValidTable(g_GameData.ActivityGm) == false or zbUtil:isValidTable(g_GameData.ActivityGm.RechargeDailySum) == false or zbUtil:isValidTable(g_GameData.ActivityGm.RechargeDailySum[arg_30_1]) == false then
		return false
	end

	for iter_30_0, iter_30_1 in pairs(g_GameData.ActivityGm.RechargeDailySum[arg_30_1].RechargeList) do
		if iter_30_1.State == 1 then
			return true
		end
	end

	return false
end

function var_0_0.hasRechargeDailySingleGift(arg_31_0, arg_31_1)
	if zbUtil:isValidTable(g_GameData.ActivityGm) == false or zbUtil:isValidTable(g_GameData.ActivityGm.RechargeDailySingle) == false or zbUtil:isValidTable(g_GameData.ActivityGm.RechargeDailySingle[arg_31_1]) == false then
		return false
	end

	for iter_31_0, iter_31_1 in pairs(g_GameData.ActivityGm.RechargeDailySingle[arg_31_1].RechargeList) do
		if iter_31_1.State == 1 then
			return true
		end
	end

	return false
end

function var_0_0.hasRechargeSingleGift(arg_32_0, arg_32_1)
	if zbUtil:isValidTable(g_GameData.ActivityGm) == false or zbUtil:isValidTable(g_GameData.ActivityGm.RechargeSingle) == false or zbUtil:isValidTable(g_GameData.ActivityGm.RechargeSingle[arg_32_1]) == false then
		return false
	end

	for iter_32_0, iter_32_1 in pairs(g_GameData.ActivityGm.RechargeSingle[arg_32_1].RechargeList) do
		if iter_32_1.State == 1 then
			return true
		end
	end

	return false
end

function var_0_0.hasRechargeSumGift(arg_33_0, arg_33_1)
	if zbUtil:isValidTable(g_GameData.ActivityGm) == false or zbUtil:isValidTable(g_GameData.ActivityGm.RechargeSum) == false or zbUtil:isValidTable(g_GameData.ActivityGm.RechargeSum[arg_33_1]) == false then
		return false
	end

	for iter_33_0, iter_33_1 in pairs(g_GameData.ActivityGm.RechargeSum[arg_33_1].RechargeList) do
		if iter_33_1.State == 1 then
			return true
		end
	end

	return false
end

function var_0_0.hasConsumSumGift(arg_34_0, arg_34_1)
	if zbUtil:isValidTable(g_GameData.ActivityGm) == false or zbUtil:isValidTable(g_GameData.ActivityGm.ConsumSum) == false or zbUtil:isValidTable(g_GameData.ActivityGm.ConsumSum[arg_34_1]) == false then
		return false
	end

	for iter_34_0, iter_34_1 in pairs(g_GameData.ActivityGm.ConsumSum[arg_34_1].ConsumList) do
		if iter_34_1.State == 1 then
			return true
		end
	end

	return false
end

function var_0_0.hasConsumDailySumGift(arg_35_0, arg_35_1)
	if zbUtil:isValidTable(g_GameData.ActivityGm) == false or zbUtil:isValidTable(g_GameData.ActivityGm.ConsumDailySum) == false or zbUtil:isValidTable(g_GameData.ActivityGm.ConsumDailySum[arg_35_1]) == false then
		return false
	end

	for iter_35_0, iter_35_1 in pairs(g_GameData.ActivityGm.ConsumDailySum[arg_35_1].ConsumList) do
		if iter_35_1.State == 1 then
			return true
		end
	end

	return false
end

function var_0_0.getGmActivityDoubleDrop(arg_36_0, arg_36_1)
	if zbUtil:isValidTable(g_GameData.ActivityGm) == false or zbUtil:isValidTable(g_GameData.ActivityGm.DoubleDrop) == false then
		return nil
	end

	for iter_36_0, iter_36_1 in ipairs(g_GameData.ActivityGm.DoubleDrop) do
		if arg_36_0:isShowTime(iter_36_1.GmBaseInfo.ActStart, iter_36_1.GmBaseInfo.ActEnd) and arg_36_1 == iter_36_1.Type then
			return arg_36_1
		end
	end

	return nil
end

function var_0_0.getGmActivityHeroReset(arg_37_0)
	if zbUtil:isValidTable(g_GameData.ActivityGm) == false or zbUtil:isValidTable(g_GameData.ActivityGm.HeroReset) == false then
		return nil
	end

	for iter_37_0, iter_37_1 in ipairs(g_GameData.ActivityGm.HeroReset) do
		if arg_37_0:isShowTime(iter_37_1.GmBaseInfo.ActStart, iter_37_1.GmBaseInfo.ActEnd) then
			return iter_37_1.Diamond
		end
	end

	return nil
end
