local var_0_0 = class("zbHeroHandler")

var_0_0.__index = var_0_0

function createHeroHandler()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	arg_2_0.lastTemplateId = 0
	arg_2_0.isNewHero = {}
	arg_2_0.heroCommentList = {}
	arg_2_0.commentHeroTemlatedId = nil
end

function var_0_0.updateHeroCommentList(arg_3_0, arg_3_1)
	arg_3_0.heroCommentList = arg_3_1
end

function var_0_0.addHeroCommentToList(arg_4_0, arg_4_1)
	if zbUtil:isValidTable(arg_4_0.heroCommentList) then
		if table.getn(arg_4_0.heroCommentList) >= 50 then
			table.insert(arg_4_0.heroCommentList, 4, arg_4_1)
			table.remove(arg_4_0.heroCommentList, table.getn(arg_4_0.heroCommentList))
		elseif table.getn(arg_4_0.heroCommentList) <= 3 then
			table.insert(arg_4_0.heroCommentList, arg_4_1)
		else
			table.insert(arg_4_0.heroCommentList, 4, arg_4_1)
		end

		echo(".........table.getn(self.heroCommentList)..............", table.getn(arg_4_0.heroCommentList))
	end
end

function var_0_0.updateHeroList(arg_5_0, arg_5_1)
	if zbUtil:isValidTable(arg_5_1) then
		g_GameData.HeroList = arg_5_1

		g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_Hero)
	end
end

function var_0_0.heroNew(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_1) do
		table.insert(g_GameData.HeroList, iter_6_1)
	end

	if table.getn(arg_6_1) > 0 then
		g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_Hero)
		g_Self.kRedPointHandler:refreshFormation()
	end
end

function var_0_0.heroUpdate(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in pairs(arg_7_1) do
		local var_7_0 = false

		for iter_7_2, iter_7_3 in pairs(g_GameData.HeroList) do
			if iter_7_3.HeroBaseInfo.TemplateId == iter_7_1.HeroBaseInfo.TemplateId then
				table.remove(g_GameData.HeroList, iter_7_2)
				table.insert(g_GameData.HeroList, iter_7_1)

				var_7_0 = true

				break
			end
		end

		if var_7_0 == false then
			echo("warning: can not find valid bagItem: " .. iter_7_1.HeroBaseInfo.TemplateId)
		end
	end

	if table.getn(arg_7_1) > 0 then
		g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_Hero)
	end
end

function var_0_0.heroDel(arg_8_0, arg_8_1)
	local var_8_0 = false

	for iter_8_0, iter_8_1 in pairs(arg_8_1) do
		for iter_8_2, iter_8_3 in pairs(g_GameData.HeroList) do
			if iter_8_3.HeroBaseInfo.TemplateId == iter_8_1 then
				table.remove(g_GameData.HeroList, iter_8_2)

				var_8_0 = true

				break
			end
		end
	end

	if var_8_0 then
		g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_Hero)
	end
end

function var_0_0.hasHeroByTemplateId(arg_9_0, arg_9_1)
	return arg_9_0:getHeroByTemplateId(arg_9_1) ~= nil
end

function var_0_0.getHeroLevel(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in pairs(g_GameData.HeroList) do
		if iter_10_1.HeroBaseInfo.TemplateId == arg_10_1 then
			return iter_10_1.HeroBaseInfo.Level
		end
	end

	return 1
end

function var_0_0.getHeroCount(arg_11_0)
	return table.getn(g_GameData.HeroList)
end

function var_0_0.getHeroByTemplateId(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in pairs(g_GameData.HeroList) do
		if iter_12_1.HeroBaseInfo.TemplateId == arg_12_1 then
			return iter_12_1
		end
	end

	return nil
end

function var_0_0.getHeroEquipByPos(arg_13_0, arg_13_1, arg_13_2)
	for iter_13_0, iter_13_1 in pairs(g_GameData.HeroList) do
		if iter_13_1.HeroBaseInfo.TemplateId == arg_13_1 then
			for iter_13_2, iter_13_3 in pairs(iter_13_1.EquipList) do
				if iter_13_3.EEquipType == arg_13_2 then
					return iter_13_3
				end
			end
		end
	end

	return nil
end

function var_0_0.getHeroEquips(arg_14_0, arg_14_1)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in pairs(g_GameData.HeroList) do
		if iter_14_1.HeroBaseInfo.TemplateId == arg_14_1 then
			for iter_14_2, iter_14_3 in pairs(iter_14_1.EquipList) do
				table.insert(var_14_0, iter_14_3)
			end
		end
	end

	return var_14_0
end

local function var_0_1(arg_15_0, arg_15_1)
	if arg_15_0.HeroBaseInfo.FV == arg_15_1.HeroBaseInfo.FV then
		if arg_15_0.HeroBaseInfo.Quality == arg_15_1.HeroBaseInfo.Quality then
			return arg_15_0.HeroBaseInfo.Level > arg_15_1.HeroBaseInfo.Level
		else
			return arg_15_0.HeroBaseInfo.Quality > arg_15_1.HeroBaseInfo.Quality
		end
	else
		return arg_15_0.HeroBaseInfo.FV > arg_15_1.HeroBaseInfo.FV
	end
end

function var_0_0.getWorkHeros(arg_16_0)
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in pairs(g_GameData.HeroList) do
		if g_Self.kFormation:isInFormation(iter_16_1.HeroBaseInfo.TemplateId) then
			table.insert(var_16_0, iter_16_1)
		end
	end

	table.sort(var_16_0, var_0_1)

	return var_16_0
end

function var_0_0.getEntourageHeros(arg_17_0)
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in pairs(g_GameData.HeroList) do
		if iter_17_1.PartnerInfo.MasterTid ~= 0 then
			table.insert(var_17_0, iter_17_1)
		end
	end

	table.sort(var_17_0, var_0_1)

	return var_17_0
end

function var_0_0.getHeroByTabType(arg_18_0, arg_18_1)
	local var_18_0 = {}

	if arg_18_1 == EHeroTab.All then
		for iter_18_0, iter_18_1 in pairs(g_GameData.HeroList) do
			table.insert(var_18_0, iter_18_1)
		end
	elseif arg_18_1 == EHeroTab.Force then
		for iter_18_2, iter_18_3 in pairs(g_GameData.HeroList) do
			local var_18_1 = zbHeroTable:getRecord(iter_18_3.HeroBaseInfo.TemplateId)

			if var_18_1 and var_18_1.heroType == EAttrType.Force then
				table.insert(var_18_0, iter_18_3)
			end
		end
	elseif arg_18_1 == EHeroTab.Intelligence then
		for iter_18_4, iter_18_5 in pairs(g_GameData.HeroList) do
			local var_18_2 = zbHeroTable:getRecord(iter_18_5.HeroBaseInfo.TemplateId)

			if var_18_2 and var_18_2.heroType == EAttrType.Intelligence then
				table.insert(var_18_0, iter_18_5)
			end
		end
	elseif arg_18_1 == EHeroTab.Tili then
		for iter_18_6, iter_18_7 in pairs(g_GameData.HeroList) do
			local var_18_3 = zbHeroTable:getRecord(iter_18_7.HeroBaseInfo.TemplateId)

			if var_18_3 and var_18_3.heroType == EAttrType.Tili then
				table.insert(var_18_0, iter_18_7)
			end
		end
	end

	return var_18_0
end

function var_0_0.getNoUseHeros(arg_19_0)
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in pairs(g_GameData.HeroList) do
		if g_Self.kFormation:isInFormation(iter_19_1.HeroBaseInfo.TemplateId) == false and iter_19_1.PartnerInfo.MasterTid == 0 then
			table.insert(var_19_0, iter_19_1)
		end
	end

	table.sort(var_19_0, var_0_1)

	return var_19_0
end

function var_0_0.getSortedHeros(arg_20_0)
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in pairs(g_GameData.HeroList) do
		if iter_20_1.PartnerInfo.MasterTid == 0 then
			table.insert(var_20_0, iter_20_1)
		end
	end

	table.sort(var_20_0, var_0_1)

	return var_20_0
end

function var_0_0.hasEquipCanUpgrade(arg_21_0)
	local var_21_0 = g_Self:getLevel()

	for iter_21_0, iter_21_1 in pairs(g_GameData.HeroList) do
		for iter_21_2, iter_21_3 in pairs(iter_21_1.EquipList) do
			if var_21_0 > iter_21_3.Equip.Level then
				return true
			end
		end
	end

	return false
end

function var_0_0.heroEquipCanUpgrade(arg_22_0, arg_22_1)
	local var_22_0 = g_Self:getLevel()

	for iter_22_0, iter_22_1 in pairs(arg_22_1.EquipList) do
		if var_22_0 > iter_22_1.Equip.Level then
			return true
		end
	end

	return false
end

function var_0_0.equipCanUpgrade(arg_23_0, arg_23_1)
	if arg_23_1 == nil then
		return false
	end

	return g_Self:getLevel() > arg_23_1.Equip.Level
end

function var_0_0.getHeroGrow(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	local var_24_0 = zbHeroTable:getRecord(arg_24_1)

	if var_24_0 == nil then
		echoInfo("error hero template id: " .. arg_24_1)

		return 0, 0, 0
	end

	local var_24_1 = zbHeroQualityUpgradeTable:getRecord(var_24_0.qualityUpId, arg_24_4)
	local var_24_2 = zbHeroTable:getHeroStarAttrGrow(arg_24_1, arg_24_3)
	local var_24_3 = var_24_0.forceGrowth * var_24_1.attrPhase * var_24_2
	local var_24_4 = var_24_0.intelligenceGrowth * var_24_1.attrPhase * var_24_2
	local var_24_5 = var_24_0.tiliGrowth * var_24_1.attrPhase * var_24_2

	return var_24_3, var_24_4, var_24_5
end

function var_0_0.hasBestEquipCanChange(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = false

	if arg_25_1 == nil then
		return false
	end

	local var_25_1 = zbHeroTable:getRecord(arg_25_1.HeroBaseInfo.TemplateId)

	if var_25_1 == nil then
		echoInfo("error hero template id: " .. arg_25_1.HeroBaseInfo.TemplateId)

		return false
	end

	local var_25_2 = -1

	if var_25_1.attackType == EAttackType.Physic then
		var_25_2 = EAttrType.MagicAttack
	else
		var_25_2 = EAttrType.PhysicAttack
	end

	local var_25_3 = g_Self.kHeroHandler:getHeroEquipByPos(arg_25_1.HeroBaseInfo.TemplateId, arg_25_2)

	if var_25_3 == nil then
		return false
	end

	local var_25_4 = g_Self.kBagEquipHandler:getBagEquipByPos(arg_25_2, var_25_2)
	local var_25_5 = arg_25_1.HeroBaseInfo.Level
	local var_25_6 = zbItemTable:getRecord(var_25_3.Equip.TemplateId)

	if var_25_6 == nil then
		return false
	end

	for iter_25_0, iter_25_1 in pairs(var_25_4) do
		local var_25_7 = zbItemTable:getRecord(iter_25_1.TemplateId)

		if var_25_7 ~= nil and var_25_7.quality > var_25_6.quality then
			var_25_0 = true

			break
		end
	end

	return var_25_0
end

function var_0_0.hasGemsOrGemshole(arg_26_0, arg_26_1)
	if arg_26_1 == nil then
		return false
	end

	local var_26_0 = false

	for iter_26_0, iter_26_1 in pairs(arg_26_1.EquipData.EquipDatas) do
		var_26_0 = g_Self.kBagEquipHandler:hasInlay(iter_26_1)

		if var_26_0 then
			return var_26_0
		end
	end

	return var_26_0
end

function var_0_0.heroHasItemCanEquip(arg_27_0, arg_27_1)
	if arg_27_1 == nil then
		return false
	end

	local var_27_0 = zbHeroTable:getRecord(arg_27_1.HeroBaseInfo.TemplateId)

	if var_27_0 == nil then
		echoInfo("error hero template id: " .. arg_27_1.HeroBaseInfo.TemplateId)

		return false
	end

	local var_27_1 = -1

	if var_27_0.attackType == EAttackType.Physic then
		var_27_1 = EAttrType.MagicAttack
	else
		var_27_1 = EAttrType.PhysicAttack
	end

	for iter_27_0 = EEquipType.Weapon, EEquipType.Magic do
		local var_27_2 = g_Self.kBagEquipHandler:getBagEquipByPos(iter_27_0, var_27_1)

		if table.getn(var_27_2) ~= 0 then
			return true
		end
	end

	return false
end

function var_0_0.getHeroCanskillUp(arg_28_0, arg_28_1)
	local var_28_0 = false

	if arg_28_1 == nil then
		return false
	end

	local var_28_1 = arg_28_1.SkillList

	for iter_28_0, iter_28_1 in pairs(var_28_1) do
		local var_28_2 = iter_28_1.Level

		if iter_28_1.SkillId ~= -1 then
			local var_28_3 = zbHeroSkillTable:getRecord(iter_28_1.SkillId)
			local var_28_4 = arg_28_1.HeroBaseInfo.Level

			if zbHeroSkillUpgradeTable:getHeroSkillLevelUpNeed(var_28_3.upgradeId, var_28_2) <= arg_28_1.HeroSubInfo.SkillPoint and var_28_2 < var_28_4 then
				var_28_0 = true

				break
			end
		end
	end

	return var_28_0
end

function var_0_0.getHeroSkillLevel(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = 0

	if arg_29_1 == nil then
		arg_29_1 = arg_29_0:getHeroByTemplateId(arg_29_3)

		if arg_29_1 == nil then
			return var_29_0
		end
	end

	local var_29_1 = {
		arg_29_1.Skill1Id,
		arg_29_1.Skill2Id,
		arg_29_1.Skill3Id,
		arg_29_1.Skill4Id,
		arg_29_1.Skill5Id
	}

	if arg_29_2 == arg_29_1.Skill1Id then
		return arg_29_1.Skill1Level
	elseif arg_29_2 == arg_29_1.Skill2Id then
		return arg_29_1.Skill2Level
	elseif arg_29_2 == arg_29_1.Skill3Id then
		return arg_29_1.Skill3Level
	elseif arg_29_2 == arg_29_1.Skill4Id then
		return arg_29_1.Skill4Level
	elseif arg_29_2 == arg_29_1.Skill5Id then
		return arg_29_1.Skill5Level
	end

	return var_29_0
end

function var_0_0.getHeroCanParners(arg_30_0, arg_30_1)
	return arg_30_0:getHeroCanParner(arg_30_1, 1) or arg_30_0:getHeroCanParner(arg_30_1, 2) or arg_30_0:getHeroCanParner(arg_30_1, 3)
end

function var_0_0.getHeroCanParner(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = zbHeroServantTable:getRecord(arg_31_1.HeroBaseInfo.TemplateId)

	if var_31_0 == nil then
		echoInfo("error hero template id: " .. arg_31_1.HeroBaseInfo.TemplateId)

		return false
	end

	if arg_31_1.PartnerInfo.MasterTid > 0 then
		return false
	end

	local var_31_1 = false

	if arg_31_1.PartnerInfo.PartnerList[arg_31_2] == 0 then
		if arg_31_1.HeroBaseInfo.Level >= var_31_0.attrLevel[arg_31_2] then
			local var_31_2 = arg_31_0:getNoUseHeros()

			return table.getn(var_31_2) > 0
		else
			return false
		end
	else
		if var_31_0.heroId[arg_31_2] == arg_31_1.PartnerInfo.PartnerList[arg_31_2] then
			return false
		end

		local var_31_3 = g_Self.kHeroHandler:getHeroByTemplateId(arg_31_1.PartnerInfo.PartnerList[arg_31_2])
		local var_31_4 = arg_31_0:getNoUseHeros()

		for iter_31_0, iter_31_1 in pairs(var_31_4) do
			if var_31_3.HeroBaseInfo.FV < iter_31_1.HeroBaseInfo.FV or var_31_0.heroId[arg_31_2] == iter_31_1.HeroBaseInfo.TemplateId then
				return true
			end
		end

		return false
	end
end

local var_0_2 = {
	[EHeroType.Force] = EAttrType.Force,
	[EHeroType.Intelligence] = EAttrType.Intelligence,
	[EHeroType.Tili] = EAttrType.Tili
}

function var_0_0.getHeroCanXiLian(arg_32_0, arg_32_1)
	if zbFunHelper:isLockNoTip(EFuncType.HeroRefresh) then
		return false
	end

	local var_32_0 = zbHeroTable:getRecord(arg_32_1.HeroBaseInfo.TemplateId)

	if var_32_0 == nil then
		echoInfo("error hero template id: " .. arg_32_1.HeroBaseInfo.TemplateId)

		return false
	end

	local var_32_1 = zbHeroMainAttrUpgradeTable:getRecord(var_32_0.mainAttrUpId, arg_32_1.WashInfo.Level)
	local var_32_2 = true

	for iter_32_0, iter_32_1 in pairs(arg_32_1.WashInfo.MAttr) do
		if iter_32_1[1] == var_0_2[var_32_0.heroType] then
			if iter_32_1[3] < var_32_1.max * 2 then
				var_32_2 = false

				break
			end
		elseif iter_32_1[3] < var_32_1.max then
			var_32_2 = false

			break
		end
	end

	if var_32_2 == false then
		return g_Self.kBagItemHandler:getItemCount(EItemType.Material, EMaterialType.HeroXilian) >= var_32_1.itemCost
	else
		if arg_32_1.HeroBaseInfo.Level < var_32_1.unlockLvl then
			return false
		end

		return g_Self.kBagItemHandler:getItemCount(EItemType.Material, EMaterialType.HeroTupo) >= var_32_1.cost
	end
end

function var_0_0.getHeroCanJuxingUp(arg_33_0, arg_33_1)
	if arg_33_1 == nil then
		return false
	end

	local var_33_0 = zbHeroTable:getRecord(arg_33_1.HeroBaseInfo.TemplateId)
	local var_33_1 = zbHeroQualityUpgradeTable:getRecord(var_33_0.qualityUpId, arg_33_1.HeroBaseInfo.Quality)

	if var_33_1.heroLvl > arg_33_1.HeroBaseInfo.Level then
		return false
	end

	local var_33_2 = 1

	for iter_33_0, iter_33_1 in pairs(var_33_1.item) do
		if g_Self.kBagItemHandler:getItemCountByTemplateId(iter_33_1[2]) < iter_33_1[3] then
			return false
		end

		var_33_2 = var_33_2 + 1
	end

	if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Gold, var_33_1.gold) == false then
		return false
	end

	return true
end

function var_0_0.getHeroEquipNotify(arg_34_0, arg_34_1)
	for iter_34_0 = EEquipType.Weapon, EEquipType.Magic do
		local var_34_0 = arg_34_0:getHeroEquipByPos(arg_34_1.HeroBaseInfo.TemplateId, iter_34_0)

		if var_34_0 ~= nil then
			canEquipUp = arg_34_0:equipCanUpgrade(var_34_0) or arg_34_0:hasBestEquipCanChange(arg_34_1, iter_34_0) or g_Self.kBagEquipHandler:getEquipCanEnchant(var_34_0.Equip)

			if canEquipUp == true then
				return true
			end
		else
			local var_34_1 = zbHeroTable:getRecord(arg_34_1.HeroBaseInfo.TemplateId)

			if var_34_1 == nil then
				echoInfo("error hero template id: " .. arg_34_1.HeroBaseInfo.TemplateId)

				return false
			end

			local var_34_2 = -1

			if var_34_1.attackType == EAttackType.Physic then
				var_34_2 = EAttrType.MagicAttack
			else
				var_34_2 = EAttrType.PhysicAttack
			end

			local var_34_3 = g_Self.kBagEquipHandler:getBagEquipByPos(iter_34_0, var_34_2)

			if table.getn(var_34_3) > 0 then
				return true
			end
		end
	end

	return false
end

function var_0_0.getHeroNotify(arg_35_0, arg_35_1)
	return g_Self.kHeroFragHandler:getHeroCanStarUp(arg_35_1.HeroBaseInfo.TemplateId) or arg_35_0:getHeroCanParners(arg_35_1) or arg_35_0:getHeroCanskillUp(arg_35_1) or arg_35_0:getHeroCanJuxingUp(arg_35_1) or arg_35_0:getHeroCanXiLian(arg_35_1) or arg_35_0:getHeroEquipNotify(arg_35_1)
end

function var_0_0.getUnObtainHeroNotify(arg_36_0)
	local var_36_0 = g_Self.kHeroFragHandler:getSortedHeroFragsByType()
	local var_36_1 = 1

	for iter_36_0, iter_36_1 in pairs(var_36_0) do
		local var_36_2 = iter_36_1.Count
		local var_36_3 = g_Self.kHeroFragHandler:getHeroComposeNeeds(iter_36_1.TemplateId)

		if var_36_3 ~= nil and var_36_2 >= var_36_3.needFrag then
			return true
		end
	end

	return false
end

function var_0_0.getBattleHeroNotify(arg_37_0)
	for iter_37_0, iter_37_1 in pairs(arg_37_0:getWorkHeros()) do
		if arg_37_0:getHeroNotify(iter_37_1) == true then
			return true
		end
	end

	return false
end

function var_0_0.getEntourageHeroNotify(arg_38_0)
	for iter_38_0, iter_38_1 in pairs(arg_38_0:getEntourageHeros()) do
		if arg_38_0:getHeroNotify(iter_38_1) == true then
			return true
		end
	end

	return false
end

function var_0_0.geUnUseHeroNotify(arg_39_0)
	for iter_39_0, iter_39_1 in pairs(arg_39_0:getNoUseHeros()) do
		if arg_39_0:getHeroNotify(iter_39_1) == true then
			return true
		end
	end

	return false
end

function var_0_0.getAllHeroNotify(arg_40_0)
	for iter_40_0, iter_40_1 in pairs(arg_40_0:getWorkHeros()) do
		if arg_40_0:getHeroNotify(iter_40_1) == true then
			return true
		end
	end

	for iter_40_2, iter_40_3 in pairs(arg_40_0:getEntourageHeros()) do
		if arg_40_0:getHeroNotify(iter_40_3) == true then
			return true
		end
	end

	local var_40_0 = g_Self.kHeroFragHandler:getSortedHeroFragsByType()
	local var_40_1 = 1

	for iter_40_4, iter_40_5 in pairs(var_40_0) do
		local var_40_2 = iter_40_5.Count
		local var_40_3 = g_Self.kHeroFragHandler:getHeroComposeNeeds(iter_40_5.TemplateId)

		if var_40_3 ~= nil and var_40_2 >= var_40_3.needFrag then
			return true
		end
	end

	return false
end
