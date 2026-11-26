require("gamebase.zbLoadCSV")
require("gamecore.zbGetWayItemTable")

local var_0_0 = class("wzVipRecord")

var_0_0.__index = var_0_0

function var_0_0.init(arg_1_0)
	arg_1_0.vipLevel = -1
	arg_1_0.growthValue = 0
	arg_1_0.vipGift = nil
	arg_1_0.vipGiftInitDiamond = 0
	arg_1_0.needGold = 0
	arg_1_0.eliteLevelResetNum = 0
	arg_1_0.nightmareLevelResetNum = 0
	arg_1_0.equipCritPercent = 0
	arg_1_0.equipCritMaxValue = 0
	arg_1_0.bagSlotNum = 0
	arg_1_0.exchangeGoldNum = 0
	arg_1_0.exchangeFoodNum = 0
	arg_1_0.exchangeSkillBookNum = 0
	arg_1_0.exchangeTiliNum = 0
	arg_1_0.exchangeGemOpenHoleNum = 0
	arg_1_0.exchangeDollsMoneyNum = 0
	arg_1_0.arenaResetNum = 0
	arg_1_0.pataResetNum = 0
	arg_1_0.campaignResetNum = 0
	arg_1_0.saodang10 = 0
	arg_1_0.friendsNum = 0
	arg_1_0.maxheroTrialTimes = 0
	arg_1_0.bgzReset = 0
	arg_1_0.bgzBribery = 0
end

function createVipRecord()
	local var_2_0 = var_0_0.new()

	var_2_0:init()

	return var_2_0
end

local function var_0_1(arg_3_0)
	local var_3_0 = {}
	local var_3_1 = string.len(arg_3_0)
	local var_3_2 = string.sub(arg_3_0, 2, var_3_1 - 1)
	local var_3_3 = string.gsub(arg_3_0, "%[", "{")
	local var_3_4 = string.gsub(var_3_3, "%]", "}")
	local var_3_5 = wzUnserialize(var_3_4)
	local var_3_6 = {}

	for iter_3_0, iter_3_1 in pairs(var_3_5) do
		local var_3_7 = {
			type = tonumber(iter_3_1[1]),
			value = tonumber(iter_3_1[2]),
			number = tonumber(iter_3_1[3])
		}

		table.insert(var_3_6, var_3_7)
	end

	return var_3_6
end

zbVipTable = {}
zbVipTable.records = {}
zbVipTable.yuanzhengResetOpenViplv = 0
zbVipTable.minheroTrialSweepOpenlv = 0
zbVipTable.minlevelSweepOpenlv = 0

function zbVipTable.load(arg_4_0, arg_4_1)
	local var_4_0 = require(arg_4_1)

	if var_4_0 == nil then
		return
	end

	if type(var_4_0) == "table" then
		for iter_4_0, iter_4_1 in pairs(var_4_0) do
			if iter_4_0 == 1 or iter_4_0 == 2 or iter_4_1[1] == "" then
				-- block empty
			else
				local var_4_1 = createVipRecord()
				local var_4_2 = 1

				var_4_1.vipLevel = tonumber(iter_4_1[var_4_2])

				local var_4_3 = var_4_2 + 1

				var_4_1.growthValue = tonumber(iter_4_1[var_4_3])

				local var_4_4 = var_4_3 + 1

				var_4_1.vipGift = iter_4_1[var_4_4]

				local var_4_5 = var_4_4 + 1

				var_4_1.vipGiftInitDiamond = tonumber(iter_4_1[var_4_5])

				local var_4_6 = var_4_5 + 1

				var_4_1.vipGiftDiamond = tonumber(iter_4_1[var_4_6])

				local var_4_7 = var_4_6 + 1

				var_4_1.eliteLevelResetNum = tonumber(iter_4_1[var_4_7])

				local var_4_8 = var_4_7 + 1

				var_4_1.nightmareLevelResetNum = tonumber(iter_4_1[var_4_8])

				local var_4_9 = var_4_8 + 1

				var_4_1.equipCritPercent = tonumber(iter_4_1[var_4_9])

				local var_4_10 = var_4_9 + 1

				var_4_1.equipCritMaxValue = tonumber(iter_4_1[var_4_10])

				local var_4_11 = var_4_10 + 1

				var_4_1.bagSlotNum = tonumber(iter_4_1[var_4_11])

				local var_4_12 = var_4_11 + 1

				var_4_1.exchangeGoldNum = tonumber(iter_4_1[var_4_12])

				local var_4_13 = var_4_12 + 1

				var_4_1.exchangeFoodNum = tonumber(iter_4_1[var_4_13])

				local var_4_14 = var_4_13 + 1

				var_4_1.exchangeSkillBookNum = tonumber(iter_4_1[var_4_14])

				local var_4_15 = var_4_14 + 1

				var_4_1.exchangeTiliNum = tonumber(iter_4_1[var_4_15])

				local var_4_16 = var_4_15 + 1

				var_4_1.exchangeGemOpenHoleNum = tonumber(iter_4_1[var_4_16])

				local var_4_17 = var_4_16 + 1

				var_4_1.exchangeDollsMoneyNum = tonumber(iter_4_1[var_4_17])

				local var_4_18 = var_4_17 + 1

				var_4_1.arenaResetNum = tonumber(iter_4_1[var_4_18])

				local var_4_19 = var_4_18 + 1

				var_4_1.pataResetNum = tonumber(iter_4_1[var_4_19])

				local var_4_20 = var_4_19 + 1

				var_4_1.saodang10 = tonumber(iter_4_1[var_4_20]) == 1

				local var_4_21 = var_4_20 + 1

				var_4_1.friendsNum = tonumber(iter_4_1[var_4_21])

				local var_4_22 = var_4_21 + 1

				var_4_1.maxheroTrialTimes = tonumber(iter_4_1[var_4_22])

				local var_4_23 = var_4_22 + 1

				var_4_1.heroTrialSweepbOpen = tonumber(iter_4_1[var_4_23]) == 1

				local var_4_24 = var_4_23 + 1

				var_4_1.bgzReset = tonumber(iter_4_1[var_4_24])

				local var_4_25 = var_4_24 + 1

				var_4_1.bgzBribery = tonumber(iter_4_1[var_4_25])

				local var_4_26 = var_4_25 + 1

				var_4_1.barrageColor = tonumber(iter_4_1[var_4_26])

				local var_4_27 = var_4_26 + 1

				if var_4_1.heroTrialSweepbOpen then
					if zbVipTable.minheroTrialSweepOpenlv == 0 then
						zbVipTable.minheroTrialSweepOpenlv = var_4_1.vipLevel
					elseif zbVipTable.minheroTrialSweepOpenlv > var_4_1.vipLevel then
						zbVipTable.minheroTrialSweepOpenlv = var_4_1.vipLevel
					end
				end

				if var_4_1.saodang10 then
					if zbVipTable.minlevelSweepOpenlv == 0 then
						zbVipTable.minlevelSweepOpenlv = var_4_1.vipLevel
					elseif zbVipTable.minlevelSweepOpenlv > var_4_1.vipLevel then
						zbVipTable.minlevelSweepOpenlv = var_4_1.vipLevel
					end
				end

				if var_4_1.bgzReset > 0 then
					if zbVipTable.yuanzhengResetOpenViplv == 0 then
						zbVipTable.yuanzhengResetOpenViplv = var_4_1.vipLevel
					elseif var_4_1.vipLevel < zbVipTable.yuanzhengResetOpenViplv then
						zbVipTable.yuanzhengResetOpenViplv = var_4_1.vipLevel
					end
				end

				arg_4_0.records[var_4_1.vipLevel] = var_4_1

				local var_4_28 = var_0_1(iter_4_1[3])

				for iter_4_2, iter_4_3 in pairs(var_4_28) do
					iter_4_3.awardType = iter_4_3.type
					iter_4_3.awardId = iter_4_3.value
					iter_4_3.awardNum = iter_4_3.number

					zbGetWayItemTable:addItemNewWaysShop(iter_4_3.awardId, EItemGetWayType.GetWay_VipGift, iter_4_3.awardType)
				end
			end
		end
	end

	return arg_4_0
end

function zbVipTable.getRecord(arg_5_0, arg_5_1)
	return arg_5_0.records[arg_5_1]
end

function zbVipTable.getVipLevelDesc(arg_6_0, arg_6_1)
	local var_6_0 = {}
	local var_6_1 = zbVipTable.records[arg_6_1]

	if var_6_1 == nil then
		return var_6_0
	end

	if var_6_1.growthValue > 0 then
		local var_6_2 = a2u(". 累计充值[color=0xFFB51E]") .. var_6_1.growthValue .. a2u("[/color]钻石即可享受该特权  ")

		table.insert(var_6_0, var_6_2)
	end

	if var_6_1.saodang10 == 1 then
		local var_6_3 = a2u(". 开启十次扫荡功能   ")
	end

	if var_6_1.heroTrialSweepbOpen then
		local var_6_4 = ""

		if zbVipTable.minheroTrialSweepOpenlv == arg_6_1 then
			local var_6_5 = a2u(". [color=0x008000]开启村的日常扫荡功能[/color] ")

			table.insert(var_6_0, 2, var_6_5)
		else
			local var_6_6 = a2u(". 开启村的日常扫荡功能 ")

			table.insert(var_6_0, var_6_6)
		end
	end

	if var_6_1.bgzReset > 0 then
		local var_6_7 = ""

		if zbVipTable.yuanzhengResetOpenViplv == arg_6_1 then
			local var_6_8 = a2u(". [color=0x008000]每日团鼠可重置次数为") .. var_6_1.bgzReset .. a2u("次[/color]    ")

			table.insert(var_6_0, 2, var_6_8)
		else
			local var_6_9 = a2u(". 每日[color=0xFFB51E]团鼠[/color]可重置次数为[color=0xFFB51E]") .. var_6_1.bgzReset .. a2u("[/color]次    ")

			table.insert(var_6_0, var_6_9)
		end
	end

	if var_6_1.bgzBribery > 0 then
		local var_6_10 = a2u(". 每日[color=0xFFB51E]团鼠大作战线索[/color]可贿赂[color=0xFFB51E]") .. var_6_1.eliteLevelResetNum .. a2u("[/color]次    ")

		table.insert(var_6_0, var_6_10)
	end

	if var_6_1.eliteLevelResetNum > 0 then
		local var_6_11 = a2u(". 每日[color=0xFFB51E]精英关卡[/color]可重置[color=0xFFB51E]") .. var_6_1.eliteLevelResetNum .. a2u("[/color]次    ")

		table.insert(var_6_0, var_6_11)
	end

	if var_6_1.nightmareLevelResetNum > 0 then
		local var_6_12 = a2u(". 每日[color=0xFFB51E]神话关卡[/color]可重置[color=0xFFB51E]") .. var_6_1.nightmareLevelResetNum .. a2u("[/color]次    ")

		table.insert(var_6_0, var_6_12)
	end

	if var_6_1.bagSlotNum > 0 then
		local var_6_13 = a2u(". [color=0xFFB51E]背包容量[/color]上限增加到[color=0xFFB51E]") .. var_6_1.bagSlotNum .. "[/color]    "

		table.insert(var_6_0, var_6_13)
	end

	if var_6_1.exchangeGoldNum > 0 then
		local var_6_14 = a2u(". 每日[color=0xFFB51E]金喵币[/color]可兑换[color=0xFFB51E]") .. var_6_1.exchangeGoldNum .. a2u("[/color]次    ")

		table.insert(var_6_0, var_6_14)
	end

	if var_6_1.exchangeFoodNum > 0 then
		local var_6_15 = a2u(". 每日[color=0xFFB51E]猫饭[/color]可兑换[color=0xFFB51E]") .. var_6_1.exchangeFoodNum .. a2u("[/color]次    ")

		table.insert(var_6_0, var_6_15)
	end

	if var_6_1.exchangeSkillBookNum > 0 then
		local var_6_16 = a2u(". 每日[color=0xFFB51E]技能书[/color]可兑换[color=0xFFB51E]") .. var_6_1.exchangeSkillBookNum .. a2u("[/color]次    ")

		table.insert(var_6_0, var_6_16)
	end

	if var_6_1.exchangeTiliNum > 0 then
		local var_6_17 = a2u(". 每日[color=0xFFB51E]鱼干[/color]可兑换[color=0xFFB51E]") .. var_6_1.exchangeTiliNum .. a2u("[/color]次    ")

		table.insert(var_6_0, var_6_17)
	end

	if var_6_1.exchangeGemOpenHoleNum > 0 then
		local var_6_18 = a2u(". 每日[color=0xFFB51E]解印符[/color]可兑换[color=0xFFB51E]") .. var_6_1.exchangeGemOpenHoleNum .. a2u("[/color]次    ")

		table.insert(var_6_0, var_6_18)
	end

	if var_6_1.exchangeDollsMoneyNum > 0 then
		local var_6_19 = a2u(". 每日[color=0xFFB51E]娃娃机代币[/color]可兑换[color=0xFFB51E]") .. var_6_1.exchangeDollsMoneyNum .. a2u("[/color]次    ")

		table.insert(var_6_0, var_6_19)
	end

	if var_6_1.arenaResetNum > 0 then
		local var_6_20 = a2u(". 每日[color=0xFFB51E]斗帅宫[/color]可重置[color=0xFFB51E]") .. var_6_1.arenaResetNum .. a2u("[/color]次    ")

		table.insert(var_6_0, var_6_20)
	end

	if var_6_1.pataResetNum > 0 then
		local var_6_21 = a2u(". 每日[color=0xFFB51E]后山探险[/color]可重置[color=0xFFB51E]") .. var_6_1.pataResetNum .. a2u("[/color]次    ")

		table.insert(var_6_0, var_6_21)
	end

	if var_6_1.maxheroTrialTimes > 1 then
		local var_6_22 = a2u(". [color=0xFFB51E]村的日常[/color]每日可挑战次数增加[color=0xFFB51E]") .. var_6_1.maxheroTrialTimes .. a2u("[/color]倍    ")

		table.insert(var_6_0, var_6_22)
	end

	if var_6_1.barrageColor > 0 then
		local var_6_23 = a2u(". 弹幕可使用红色字体   ")

		table.insert(var_6_0, var_6_23)
	end

	local var_6_24 = {}
	local var_6_25 = 1

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		iter_6_1 = var_6_25 .. iter_6_1

		table.insert(var_6_24, iter_6_1)

		var_6_25 = var_6_25 + 1
	end

	return var_6_24
end

function zbVipTable.getActionNum(arg_7_0, arg_7_1)
	return arg_7_0.records[arg_7_1].friendsActionNum
end
