local var_0_0 = class("zbGiftHandler")

var_0_0.__index = var_0_0

function createGiftHandler()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	return
end

function var_0_0.hasGift(arg_3_0)
	if zbUtil:isValidTable(g_GameData.ActivityAct) == false or zbFunHelper:isLockNoTip(EFuncType.Activity) then
		return false
	end

	return arg_3_0:hasSignGift() or arg_3_0:hasAccumGift() or arg_3_0:hasUpgradeGift() or arg_3_0:hasTiliGift() or arg_3_0:hasCardGift() or arg_3_0:hasVIPGift() or arg_3_0:hasDesireGift()
end

function var_0_0.hasDesireGift(arg_4_0)
	if zbUtil:isValidTable(g_GameData.ActivityAct) == false or zbUtil:isValidTable(g_GameData.ActivityAct.WishTurntable) == false then
		return false
	end

	return g_GameData.ActivityAct.WishTurntable.RunCost == 0
end

function var_0_0.hasSignGift(arg_5_0)
	if zbUtil:isValidTable(g_GameData.ActivityAct) == false or zbUtil:isValidTable(g_GameData.ActivityAct.DailySign) == false then
		return false
	end

	return g_GameData.ActivityAct.DailySign.SignToday == 0
end

function var_0_0.hasAccumGift(arg_6_0)
	if zbUtil:isValidTable(g_GameData.ActivityAct) == false or zbUtil:isValidTable(g_GameData.ActivityAct.SerialLogin) == false then
		return false
	end

	for iter_6_0, iter_6_1 in pairs(g_GameData.ActivityAct.SerialLogin.LoginAward) do
		if iter_6_1.State == 1 then
			return true
		end
	end

	return false
end

function var_0_0.hasUpgradeGift(arg_7_0)
	if zbUtil:isValidTable(g_GameData.ActivityAct) == false or zbUtil:isValidTable(g_GameData.ActivityAct.CrazyUpgrade) == false then
		return false
	end

	local var_7_0 = 1

	for iter_7_0, iter_7_1 in pairs(zbActCrazyUpgradeTable.records) do
		if g_Self:getLevel() >= iter_7_1.level then
			local var_7_1 = 0

			for iter_7_2, iter_7_3 in pairs(g_GameData.ActivityAct.CrazyUpgrade) do
				if iter_7_1.level == iter_7_3 then
					var_7_1 = 1

					break
				end
			end

			if var_7_1 == 0 then
				return true
			end
		end
	end

	return false
end

function var_0_0.hasTiliGift(arg_8_0)
	if zbUtil:isValidTable(g_GameData.ActivityAct) == false or zbUtil:isValidTable(g_GameData.ActivityAct.Tili) == false then
		return false
	end

	local var_8_0 = zbUtil:SprintfHHMMSS(g_Self.kTimeHandler:getServerTime() + g_Self.kTimeHandler:getTimeZoneDelt())

	for iter_8_0, iter_8_1 in pairs(g_GameData.ActivityAct.Tili) do
		local var_8_1 = string.format("%02d:00:00", iter_8_1.StartHour)
		local var_8_2 = string.format("%02d:00:00", iter_8_1.EndHour)

		if (iter_8_1.State == 0 and var_8_1 < var_8_0 and var_8_0 < var_8_2) == true then
			return true
		end
	end

	return false
end

function var_0_0.hasVIPGift(arg_9_0)
	if zbUtil:isValidTable(g_GameData.ActivityAct) == false or zbUtil:isValidTable(g_GameData.ActivityAct.LoginVip) == false then
		return false
	end

	if g_GameData.DailyTask.ActiveCount < 100 then
		return false
	end

	if g_GameData.ActivityAct.LoginVip.State == 1 then
		return false
	end

	return true
end

function var_0_0.hasCardGift(arg_10_0)
	if zbUtil:isValidTable(g_GameData.VipInfo) == false or zbUtil:isValidTable(g_GameData.VipInfo.MonthCard) == false or zbUtil:isValidTable(g_GameData.VipInfo.ForeverCard) == false or zbUtil:isValidTable(g_GameData.VipInfo.TwoCard) == false then
		return false
	end

	if g_GameData.VipInfo.MonthCard.DailyAward == 1 or g_GameData.VipInfo.ForeverCard.DailyAward == 1 or g_GameData.VipInfo.TwoCard.DailyAward == 1 then
		return true
	end

	return false
end

function var_0_0.getBtnLuckCatVisible(arg_11_0)
	if zbUtil:isValidTable(g_GameData.ActivityAct) and zbUtil:isValidTable(g_GameData.ActivityAct.LuckyDiamond) and g_Self:getVipLevel() >= g_GameData.ActivityAct.LuckyDiamond.NeedVip and g_GameData.ActivityAct.LuckyDiamond.Diamond > 0 then
		return true
	end

	return false
end
