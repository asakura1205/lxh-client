local var_0_0 = class("zbGodHandler")

var_0_0.__index = var_0_0

local var_0_1 = {
	"godstar1.png",
	"godstar2.png",
	"godstar3.png",
	"godstar4.png",
	"godstar5.png",
	"godstar6.png",
	"godstar7.png",
	"godstar8.png",
	"godstar9.png"
}
local var_0_2 = {
	"godequip_type1.png",
	"godequip_type2.png",
	"godequip_type3.png",
	"godequip_type4.png",
	"godequip_type5.png"
}

function createGodHandler()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	arg_2_0.godLevelPreReqLevelUp = 0
	arg_2_0.getnewGodId = nil
	arg_2_0.bgodChange = false
	arg_2_0.spriteframeCache = CCSpriteFrameCache:sharedSpriteFrameCache()

	arg_2_0.spriteframeCache:addSpriteFramesWithFile("ui/image/plist/godequip.plist")
end

function var_0_0.setGodStarTexture(arg_3_0, arg_3_1, arg_3_2)
	if var_0_1[arg_3_2] then
		local var_3_0 = arg_3_0.spriteframeCache:spriteFrameByName(var_0_1[arg_3_2])

		if var_3_0 then
			arg_3_1:initWithSpriteFrame(var_3_0)
		end
	end
end

function var_0_0.setGodTypeTexture(arg_4_0, arg_4_1, arg_4_2)
	if var_0_2[arg_4_2] then
		local var_4_0 = arg_4_0.spriteframeCache:spriteFrameByName(var_0_2[arg_4_2])

		if var_4_0 then
			arg_4_1:initWithSpriteFrame(var_4_0)
		end
	end
end

function var_0_0.updateGodInfo(arg_5_0, arg_5_1, arg_5_2)
	if zbUtil:isValidTable(arg_5_1) then
		if arg_5_2 then
			arg_5_0.getnewGodId = arg_5_0:hasNewGodOpen(arg_5_1)
		end

		g_GameData.GodInfo = arg_5_1

		g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_GodInfo)

		if zbUtil:isValidTable(arg_5_1) then
			g_Self.kFormation.godId = arg_5_1.GodId
		end
	end
end

function var_0_0.hasNewGodOpen(arg_6_0, arg_6_1)
	if g_GameData.GodInfo and arg_6_1 then
		local function var_6_0(arg_7_0)
			if zbUtil:isValidTable(g_GameData.GodInfo.GodList) then
				for iter_7_0, iter_7_1 in pairs(g_GameData.GodInfo.GodList) do
					if iter_7_1 == arg_7_0 then
						return true
					end
				end
			end

			return false
		end

		local var_6_1

		if zbUtil:isValidTable(arg_6_1.GodList) then
			for iter_6_0, iter_6_1 in pairs(arg_6_1.GodList) do
				if var_6_0(iter_6_1) == false then
					var_6_1 = iter_6_1
				end
			end
		end

		return var_6_1
	end
end

function var_0_0.isGodOpen(arg_8_0, arg_8_1)
	for iter_8_0 = 1, table.getn(g_GameData.GodInfo.GodList) do
		if g_GameData.GodInfo.GodList[iter_8_0] == arg_8_1 then
			return true
		end
	end

	return false
end

function var_0_0.getLevelByexp(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getGodMaxLevel()
	local var_9_1 = 0
	local var_9_2 = 1

	for iter_9_0 = 1, var_9_0 do
		local var_9_3 = zbGodUpgradeTable:getRecord(iter_9_0)

		if var_9_3 then
			var_9_1 = var_9_1 + var_9_3.exp

			if arg_9_1 <= var_9_1 then
				local var_9_4 = var_9_3.id

				return math.min(var_9_4, var_9_0)
			end
		end
	end

	return var_9_0
end

function var_0_0.getSkillLevel(arg_10_0, arg_10_1)
	for iter_10_0 = 1, table.getn(g_GameData.GodInfo.SkillList) do
		local var_10_0 = g_GameData.GodInfo.SkillList[iter_10_0]

		if var_10_0.SkillId == arg_10_1 then
			return var_10_0.Level
		end
	end

	return 0
end

function var_0_0.getGodMaxLevel(arg_11_0, arg_11_1)
	local var_11_0 = 1

	if arg_11_1 == nil then
		arg_11_1 = true
	end

	for iter_11_0, iter_11_1 in pairs(zbGodUpgradeTable.records) do
		if var_11_0 < iter_11_1.id then
			var_11_0 = iter_11_1.id
		end
	end

	if arg_11_1 then
		var_11_0 = math.min(var_11_0, g_Self:getLevel())
	end

	return var_11_0
end

function var_0_0.getGodSkillUpSucRate(arg_12_0, arg_12_1)
	local var_12_0 = 0

	for iter_12_0, iter_12_1 in pairs(zbGodSkillUpgradeTable.records) do
		if iter_12_1.skilllv == arg_12_1 then
			var_12_0 = iter_12_1.successrate

			break
		end
	end

	return var_12_0
end

function var_0_0.getGodMaxStar(arg_13_0)
	local var_13_0 = 1

	for iter_13_0, iter_13_1 in pairs(zbGodStarTable.records) do
		if var_13_0 < iter_13_1.id then
			var_13_0 = iter_13_1.id
		end
	end

	return var_13_0
end

function var_0_0.getGodMaxSkillLevel(arg_14_0)
	local var_14_0 = 1

	for iter_14_0, iter_14_1 in pairs(zbGodSkillUpgradeTable.records) do
		if var_14_0 < iter_14_1.skilllv then
			var_14_0 = iter_14_1.skilllv
		end
	end

	return var_14_0
end

function var_0_0.getCurLevelAllExp(arg_15_0, arg_15_1)
	local var_15_0 = 0

	if arg_15_1 == 1 then
		return 0
	end

	for iter_15_0 = 1, arg_15_1 - 1 do
		local var_15_1 = zbGodUpgradeTable:getRecord(iter_15_0)

		if var_15_1 then
			var_15_0 = var_15_0 + var_15_1.exp
		end
	end

	return var_15_0
end

function var_0_0.getCurLevelMaxExp(arg_16_0, arg_16_1)
	local var_16_0 = zbGodUpgradeTable:getRecord(arg_16_1)

	if var_16_0 then
		return var_16_0.exp
	end

	return 0
end

function var_0_0.getGodPower(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = 0
	local var_17_1 = zbGodUpgradeTable:getRecord(arg_17_1)
	local var_17_2 = 1

	if var_17_1 then
		var_17_2 = var_17_1.power
	end

	local var_17_3 = zbGodStarTable:getRecord(arg_17_2)
	local var_17_4 = 1

	if var_17_3 then
		var_17_4 = var_17_3.power
	end

	return var_17_2 * var_17_4
end

function var_0_0.getGodSkillDesc(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = zbGodSkillTable:getRecord(arg_18_1)
	local var_18_1 = ""

	if var_18_0 then
		var_18_1 = var_18_0.desc

		local var_18_2 = var_18_0.base1 + var_18_0.powerFactor * g_GameData.GodInfo.Power * math.pow(1.1, arg_18_2)
		local var_18_3 = var_18_0.base2 + arg_18_2 * var_18_0.lvlFactor

		if var_18_1 ~= "" then
			var_18_1 = string.format(var_18_1, var_18_2, var_18_3)
		end
	end

	return var_18_1
end

function var_0_0.isGodCanLevelUp(arg_19_0)
	if g_GameData.GodInfo == nil then
		return false
	end

	local var_19_0 = g_GameData.GodInfo.Level

	if var_19_0 >= g_Self.kGodHandler:getGodMaxLevel() then
		return false
	end

	local var_19_1 = g_Self.kGodHandler:getCurLevelMaxExp(var_19_0)
	local var_19_2 = zbItemTable:getGodLevelUpItems()
	local var_19_3 = 0

	for iter_19_0, iter_19_1 in pairs(var_19_2) do
		var_19_3 = g_Self.kBagItemHandler:getItemCountByTemplateId(iter_19_1.id) * iter_19_1.virtual + var_19_3
	end

	if var_19_1 <= var_19_3 then
		return true
	end

	return false
end

function var_0_0.haveGodSkillCanUp(arg_20_0)
	if g_GameData.GodInfo == nil then
		return false
	end

	if zbUtil:isValidTable(g_GameData.GodInfo.SkillList) then
		for iter_20_0, iter_20_1 in pairs(g_GameData.GodInfo.SkillList) do
			return arg_20_0:isGodSkillCanUp(iter_20_1)
		end
	end

	return false
end

function var_0_0.isGodSkillCanUp(arg_21_0, arg_21_1)
	if g_GameData.GodInfo == nil or arg_21_1 == nil then
		return false
	end

	if arg_21_1.Level == 0 then
		return false
	end

	if g_Self.kGodHandler:getGodMaxSkillLevel() <= arg_21_1.Level then
		return false
	end

	local var_21_0 = zbGodSkillUpgradeTable:getRecord(arg_21_1.Level)
	local var_21_1 = 0
	local var_21_2 = 0
	local var_21_3 = 0
	local var_21_4 = zbItemTable:getGodSkillUpItems()

	if var_21_0 then
		var_21_1 = var_21_0.costitemCount
		var_21_3 = var_21_0.costgold
	end

	local var_21_5 = 0

	if zbUtil:isValidTable(var_21_4) then
		var_21_5 = var_21_4[1].id
	end

	local var_21_6 = g_Self.kBagItemHandler:getItemCountByTemplateId(var_21_5)

	arg_21_0.limitCostItem = false

	if var_21_6 < var_21_1 then
		arg_21_0.limitCostItem = true
	end

	if var_21_3 > g_GameData.Wealth.Gold then
		arg_21_0.limitCostItem = true
	end

	return not arg_21_0.limitCostItem
end

function var_0_0.isGodCanStarUp(arg_22_0)
	if g_GameData.GodInfo == nil then
		return false
	end

	local var_22_0 = g_GameData.GodInfo.Star

	if var_22_0 >= g_Self.kGodHandler:getGodMaxStar() then
		return false
	end

	local var_22_1 = zbGodStarTable:getRecord(var_22_0)
	local var_22_2 = zbItemTable:getGodStarUpItems()
	local var_22_3 = 0
	local var_22_4 = 0

	if var_22_1 then
		var_22_3 = var_22_1.costitemCount
		var_22_4 = var_22_1.costgold
	else
		return false
	end

	local var_22_5 = 0

	if zbUtil:isValidTable(var_22_2) then
		var_22_5 = var_22_2[1].id
	end

	if var_22_3 > g_Self.kBagItemHandler:getItemCountByTemplateId(var_22_5) then
		return false
	end

	if var_22_4 > g_GameData.Wealth.Gold then
		return false
	end

	return true
end
