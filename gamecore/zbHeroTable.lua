require("gamebase.zbLoadCSV")

local var_0_0 = class("zbHeroRecord")

var_0_0.__index = var_0_0

function createHeroRecord()
	return (var_0_0.new())
end

zbHeroTable = {}
zbHeroTable.records = {}
zbHeroTable.needShowHero = {}

function zbHeroTable.load(arg_2_0, arg_2_1)
	local var_2_0 = require(arg_2_1)

	if var_2_0 == nil then
		return
	end

	if type(var_2_0) == "table" then
		for iter_2_0, iter_2_1 in pairs(var_2_0) do
			if iter_2_0 == 1 or iter_2_0 == 2 or iter_2_1[1] == "" then
				-- block empty
			else
				local var_2_1 = tonumber(iter_2_1[1])
				local var_2_2 = createHeroRecord()
				local var_2_3 = 1

				var_2_2.id = tonumber(iter_2_1[var_2_3])

				local var_2_4 = var_2_3 + 1

				var_2_2.name = iter_2_1[var_2_4]

				local var_2_5 = var_2_4 + 1

				var_2_2.description0 = iter_2_1[var_2_5]

				local var_2_6 = var_2_5 + 1

				var_2_2.description = iter_2_1[var_2_6]

				local var_2_7 = var_2_6 + 1

				var_2_2.description2 = iter_2_1[var_2_7]

				local var_2_8 = var_2_7 + 1

				var_2_2.avatarId = tonumber(iter_2_1[var_2_8])

				local var_2_9 = var_2_8 + 1

				var_2_2.rarity = tonumber(iter_2_1[var_2_9])

				local var_2_10 = var_2_9 + 1

				var_2_2.heroType = tonumber(iter_2_1[var_2_10])

				local var_2_11 = var_2_10 + 1

				var_2_2.attackType = tonumber(iter_2_1[var_2_11])

				local var_2_12 = var_2_11 + 1

				var_2_2.star = tonumber(iter_2_1[var_2_12])

				local var_2_13 = var_2_12 + 1

				var_2_2.startMax = tonumber(iter_2_1[var_2_13])

				local var_2_14 = var_2_13 + 1

				var_2_2.quality = tonumber(iter_2_1[var_2_14])

				local var_2_15 = var_2_14 + 1

				var_2_2.qualityMax = tonumber(iter_2_1[var_2_15])

				local var_2_16 = var_2_15 + 1

				var_2_2.qualityUpId = tonumber(iter_2_1[var_2_16])

				local var_2_17 = var_2_16 + 1

				var_2_2.mainAttrUpId = tonumber(iter_2_1[var_2_17])

				local var_2_18 = var_2_17 + 1

				var_2_2.tupo = tonumber(iter_2_1[var_2_18])

				local var_2_19 = var_2_18 + 1

				var_2_2.extraAttrList = arg_2_0:parseSkillSequence(iter_2_1[var_2_19])

				local var_2_20 = var_2_19 + 1

				var_2_2.extraAttrUpId = tonumber(iter_2_1[var_2_20])

				local var_2_21 = var_2_20 + 1

				var_2_2.starNeedFrag = {}
				var_2_2.star1NeedFrag = tonumber(iter_2_1[var_2_21])

				local var_2_22 = var_2_21 + 1

				var_2_2.star2NeedFrag = tonumber(iter_2_1[var_2_22])

				local var_2_23 = var_2_22 + 1

				var_2_2.star3NeedFrag = tonumber(iter_2_1[var_2_23])

				local var_2_24 = var_2_23 + 1

				var_2_2.star4NeedFrag = tonumber(iter_2_1[var_2_24])

				local var_2_25 = var_2_24 + 1

				var_2_2.star5NeedFrag = tonumber(iter_2_1[var_2_25])

				local var_2_26 = var_2_25 + 1

				var_2_2.star6NeedFrag = tonumber(iter_2_1[var_2_26])

				local var_2_27 = var_2_26 + 1

				var_2_2.star7NeedFrag = tonumber(iter_2_1[var_2_27])

				local var_2_28 = var_2_27 + 1

				var_2_2.star8NeedFrag = tonumber(iter_2_1[var_2_28])

				local var_2_29 = var_2_28 + 1

				table.insert(var_2_2.starNeedFrag, var_2_2.star1NeedFrag)
				table.insert(var_2_2.starNeedFrag, var_2_2.star2NeedFrag)
				table.insert(var_2_2.starNeedFrag, var_2_2.star3NeedFrag)
				table.insert(var_2_2.starNeedFrag, var_2_2.star4NeedFrag)
				table.insert(var_2_2.starNeedFrag, var_2_2.star5NeedFrag)
				table.insert(var_2_2.starNeedFrag, var_2_2.star6NeedFrag)
				table.insert(var_2_2.starNeedFrag, var_2_2.star7NeedFrag)
				table.insert(var_2_2.starNeedFrag, var_2_2.star8NeedFrag)

				var_2_2.attrStar1 = tonumber(iter_2_1[var_2_29])

				local var_2_30 = var_2_29 + 1

				var_2_2.attrStar2 = tonumber(iter_2_1[var_2_30])

				local var_2_31 = var_2_30 + 1

				var_2_2.attrStar3 = tonumber(iter_2_1[var_2_31])

				local var_2_32 = var_2_31 + 1

				var_2_2.attrStar4 = tonumber(iter_2_1[var_2_32])

				local var_2_33 = var_2_32 + 1

				var_2_2.attrStar5 = tonumber(iter_2_1[var_2_33])

				local var_2_34 = var_2_33 + 1

				var_2_2.attrStar6 = tonumber(iter_2_1[var_2_34])

				local var_2_35 = var_2_34 + 1

				var_2_2.attrStar7 = tonumber(iter_2_1[var_2_35])

				local var_2_36 = var_2_35 + 1

				var_2_2.attrStar8 = tonumber(iter_2_1[var_2_36])

				local var_2_37 = var_2_36 + 1

				var_2_2.skillId0 = tonumber(iter_2_1[var_2_37])

				local var_2_38 = var_2_37 + 1

				var_2_2.skillLvl0 = tonumber(iter_2_1[var_2_38])

				local var_2_39 = var_2_38 + 1

				var_2_2.skillId1 = tonumber(iter_2_1[var_2_39])

				local var_2_40 = var_2_39 + 1

				var_2_2.skillLvl1 = tonumber(iter_2_1[var_2_40])

				local var_2_41 = var_2_40 + 1

				var_2_2.skillId2 = tonumber(iter_2_1[var_2_41])

				local var_2_42 = var_2_41 + 1

				var_2_2.skillLvl2 = tonumber(iter_2_1[var_2_42])

				local var_2_43 = var_2_42 + 1

				var_2_2.skillId3 = tonumber(iter_2_1[var_2_43])

				local var_2_44 = var_2_43 + 1

				var_2_2.skillLvl3 = tonumber(iter_2_1[var_2_44])

				local var_2_45 = var_2_44 + 1

				var_2_2.skillId4 = tonumber(iter_2_1[var_2_45])

				local var_2_46 = var_2_45 + 1

				var_2_2.skillLvl4 = tonumber(iter_2_1[var_2_46])

				local var_2_47 = var_2_46 + 1

				var_2_2.skillSequence = arg_2_0:parseSkillSequence(iter_2_1[var_2_47])

				local var_2_48 = var_2_47 + 1

				var_2_2.forceBase = tonumber(iter_2_1[var_2_48])

				local var_2_49 = var_2_48 + 1

				var_2_2.forceGrowth = tonumber(iter_2_1[var_2_49])

				local var_2_50 = var_2_49 + 1

				var_2_2.intelligenceBase = tonumber(iter_2_1[var_2_50])

				local var_2_51 = var_2_50 + 1

				var_2_2.intelligenceGrowth = tonumber(iter_2_1[var_2_51])

				local var_2_52 = var_2_51 + 1

				var_2_2.tiliBase = tonumber(iter_2_1[var_2_52])

				local var_2_53 = var_2_52 + 1

				var_2_2.tiliGrowth = tonumber(iter_2_1[var_2_53])

				local var_2_54 = var_2_53 + 1

				var_2_2.hpBase = tonumber(iter_2_1[var_2_54])

				local var_2_55 = var_2_54 + 1

				var_2_2.physicAttackBase = tonumber(iter_2_1[var_2_55])

				local var_2_56 = var_2_55 + 1

				var_2_2.magicAttackBase = tonumber(iter_2_1[var_2_56])

				local var_2_57 = var_2_56 + 1

				var_2_2.physicDefendBase = tonumber(iter_2_1[var_2_57])

				local var_2_58 = var_2_57 + 1

				var_2_2.magicDefendBase = tonumber(iter_2_1[var_2_58])

				local var_2_59 = var_2_58 + 1

				var_2_2.violentBase = tonumber(iter_2_1[var_2_59])

				local var_2_60 = var_2_59 + 1

				var_2_2.toughBase = tonumber(iter_2_1[var_2_60])

				local var_2_61 = var_2_60 + 1

				var_2_2.hitBase = tonumber(iter_2_1[var_2_61])

				local var_2_62 = var_2_61 + 1

				var_2_2.dodgeBase = tonumber(iter_2_1[var_2_62])

				local var_2_63 = var_2_62 + 1

				var_2_2.pierceDamageBase = tonumber(iter_2_1[var_2_63])

				local var_2_64 = var_2_63 + 1

				var_2_2.blockBase = tonumber(iter_2_1[var_2_64])

				local var_2_65 = var_2_64 + 1

				var_2_2.preShow = tonumber(iter_2_1[var_2_65])

				local var_2_66 = var_2_65 + 1

				var_2_2.gmShow = tonumber(iter_2_1[var_2_66])

				local var_2_67 = var_2_66 + 1

				var_2_2.shortWord1 = arg_2_0:parseContains(iter_2_1[var_2_67], var_2_2.id)

				local var_2_68 = var_2_67 + 1

				var_2_2.shortWord2 = arg_2_0:parseContains(iter_2_1[var_2_68], var_2_2.id)

				local var_2_69 = var_2_68 + 1

				if var_2_2.preShow > 0 then
					arg_2_0.needShowHero[var_2_2.id] = var_2_2.heroType
				end

				arg_2_0.records[var_2_1] = var_2_2
			end
		end
	end

	return arg_2_0
end

function zbHeroTable.getHeroStarRate(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0:getRecord(arg_3_1)

	if var_3_0 == nil then
		return 0
	end

	local var_3_1 = 0

	for iter_3_0 = 1, arg_3_2 do
		var_3_1 = var_3_1 + var_3_0.starNeedFrag[iter_3_0]
	end

	return math.ceil(var_3_1)
end

function zbHeroTable.getHeroStarUpNeedFrag(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0:getRecord(arg_4_1)

	if var_4_0 == nil then
		return 0
	end

	if arg_4_2 == 1 then
		return var_4_0.star1NeedFrag
	elseif arg_4_2 == 2 then
		return var_4_0.star2NeedFrag
	elseif arg_4_2 == 3 then
		return var_4_0.star3NeedFrag
	elseif arg_4_2 == 4 then
		return var_4_0.star4NeedFrag
	elseif arg_4_2 == 5 then
		return var_4_0.star5NeedFrag
	elseif arg_4_2 == 6 then
		return var_4_0.star6NeedFrag
	elseif arg_4_2 == 7 then
		return var_4_0.star7NeedFrag
	elseif arg_4_2 == 8 then
		return var_4_0.star8NeedFrag
	end

	return 0
end

function zbHeroTable.getHeroStarAttrGrow(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:getRecord(arg_5_1)

	if var_5_0 == nil then
		return 0
	end

	if arg_5_2 == 1 then
		return var_5_0.attrStar1
	elseif arg_5_2 == 2 then
		return var_5_0.attrStar2
	elseif arg_5_2 == 3 then
		return var_5_0.attrStar3
	elseif arg_5_2 == 4 then
		return var_5_0.attrStar4
	elseif arg_5_2 == 5 then
		return var_5_0.attrStar5
	elseif arg_5_2 == 6 then
		return var_5_0.attrStar6
	elseif arg_5_2 == 7 then
		return var_5_0.attrStar7
	elseif arg_5_2 >= 8 then
		return var_5_0.attrStar8
	end

	return 0
end

function zbHeroTable.getHeroSkillId(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0:getRecord(arg_6_1)

	if var_6_0 == nil then
		return 0
	end

	if arg_6_2 == 1 then
		return var_6_0.skillId0
	elseif arg_6_2 == 2 then
		return var_6_0.skillId1
	elseif arg_6_2 == 3 then
		return var_6_0.skillId2
	elseif arg_6_2 == 4 then
		return var_6_0.skillId3
	elseif arg_6_2 == 5 then
		return var_6_0.skillId4
	end

	return 0
end

function zbHeroTable.getHeroSkillLockLevel(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0:getRecord(arg_7_1)

	if var_7_0 == nil then
		return 0
	end

	if arg_7_2 == 1 then
		return var_7_0.skillLvl0
	elseif arg_7_2 == 2 then
		return var_7_0.skillLvl1
	elseif arg_7_2 == 3 then
		return var_7_0.skillLvl2
	elseif arg_7_2 == 4 then
		return var_7_0.skillLvl3
	elseif arg_7_2 == 5 then
		return var_7_0.skillLvl4
	end

	return 0
end

function zbHeroTable.parseSkillSequence(arg_8_0, arg_8_1)
	local var_8_0 = string.gsub(arg_8_1, "%[", "{")
	local var_8_1 = string.gsub(var_8_0, "%]", "}")

	ret = wzUnserialize(var_8_1)

	local var_8_2 = wzUnserialize(var_8_1)
	local var_8_3 = {}

	for iter_8_0, iter_8_1 in pairs(var_8_2) do
		var_8_3[iter_8_0] = tonumber(iter_8_1)
	end

	return var_8_3
end

function zbHeroTable.parseContains(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = string.gsub(arg_9_1, "%[", "{")
	local var_9_1 = string.gsub(var_9_0, "%]", "}")

	ret = wzUnserialize(var_9_1)

	return (wzUnserialize(var_9_1))
end

function zbHeroTable.getNeedShowList(arg_10_0)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs(arg_10_0.needShowHero) do
		var_10_0[iter_10_0] = iter_10_1
	end

	return var_10_0
end

function zbHeroTable.getRecord(arg_11_0, arg_11_1)
	if arg_11_1 == nil or arg_11_1 <= 0 then
		return nil
	end

	return arg_11_0.records[arg_11_1]
end

function zbHeroTable.getHeroType(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getRecord(arg_12_1)

	if var_12_0 == nil then
		return -1
	end

	return var_12_0.heroType
end

function zbHeroTable.getLevelExpAfterAddExp(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = arg_13_1
	local var_13_1 = arg_13_2
	local var_13_2 = 0
	local var_13_3 = zbHeroUpgradeTable.records[arg_13_1 + 1].exp - arg_13_2
	local var_13_4 = table.getn(zbHeroUpgradeTable.records)
	local var_13_5 = var_13_4
	local var_13_6 = zbHeroUpgradeTable.records[var_13_4].exp
	local var_13_7 = zbHeroUpgradeTable.records[var_13_4].exp

	for iter_13_0 = arg_13_1, var_13_4 - 2 do
		if arg_13_3 < var_13_3 then
			var_13_5 = iter_13_0
			var_13_6 = zbHeroUpgradeTable.records[var_13_5 + 1].exp - (var_13_3 - arg_13_3)
			var_13_7 = zbHeroUpgradeTable.records[var_13_5 + 1].exp

			break
		elseif var_13_3 == arg_13_3 then
			var_13_5 = iter_13_0 + 1
			var_13_6 = 0
			var_13_7 = zbHeroUpgradeTable.records[var_13_5 + 1].exp

			break
		end

		var_13_3 = var_13_3 + zbHeroUpgradeTable.records[iter_13_0 + 2].exp
	end

	if arg_13_4 < var_13_5 then
		var_13_5 = arg_13_4
		var_13_6 = zbHeroUpgradeTable.records[var_13_5 + 1].exp
		var_13_7 = zbHeroUpgradeTable.records[var_13_5 + 1].exp
	end

	return var_13_5, var_13_6, var_13_7
end

function RefreshHeroStarLevel(arg_14_0, arg_14_1)
	if arg_14_1 == nil then
		for iter_14_0 = 1, 5 do
			arg_14_0:getChildByTag(iter_14_0):setVisible(false)
		end

		return
	end

	RefreshHeroStar(arg_14_0, arg_14_1.HeroBaseInfo.Star)
end

function RefreshHeroStar(arg_15_0, arg_15_1)
	for iter_15_0 = 1, 5 do
		arg_15_0:getChildByTag(iter_15_0):setVisible(false)
	end

	if arg_15_1 <= 5 then
		for iter_15_1 = 1, 5 do
			local var_15_0 = tolua.cast(arg_15_0:getChildByTag(iter_15_1), "CCSprite")

			var_15_0:setTexture(CCTextureCache:sharedTextureCache():addImage(HERO_LV5_TEXTURE))
			var_15_0:setVisible(iter_15_1 <= arg_15_1)
		end
	else
		for iter_15_2 = 1, 3 do
			local var_15_1 = tolua.cast(arg_15_0:getChildByTag(iter_15_2), "CCSprite")

			var_15_1:setTexture(CCTextureCache:sharedTextureCache():addImage(HERO_LV8_TEXTURE))
			var_15_1:setVisible(arg_15_1 >= iter_15_2 + 5)
		end
	end
end

function RefreshHeroTag(arg_16_0, arg_16_1)
	for iter_16_0 = 1, 4 do
		-- block empty
	end

	if zbHeroTable:getRecord(arg_16_1) == nil then
		return
	end
end

function getHeroTagIconList(arg_17_0, arg_17_1)
	local var_17_0 = {}
	local var_17_1 = zbHeroTable:getRecord(arg_17_0)

	if var_17_1 == nil then
		return var_17_0
	end

	if arg_17_1 ~= nil and arg_17_1 == true then
		table.insert(var_17_0, HeroTagIcon[EHeroTagType.EHeroTagType_EHeroType][var_17_1.heroType])
	end

	table.insert(var_17_0, HeroTagIcon[EHeroTagType.EHeroTagType_ECountryType][var_17_1.country])
	table.insert(var_17_0, HeroTagIcon[EHeroTagType.EHeroTagType_EFloorHeightType][var_17_1.floorHeight])
	table.insert(var_17_0, HeroTagIcon[EHeroTagType.EHeroTagType_EArmsType][var_17_1.armsType])

	return var_17_0
end

function getHeroTagIconDescList(arg_18_0, arg_18_1)
	local var_18_0 = {}
	local var_18_1 = zbHeroTable:getRecord(arg_18_0)

	if var_18_1 == nil then
		return var_18_0
	end

	if arg_18_1 ~= nil and arg_18_1 == true then
		local var_18_2 = {
			icon = HeroTagIcon[EHeroTagType.EHeroTagType_EHeroType][var_18_1.heroType],
			desc = HeroTagDesc[EHeroTagType.EHeroTagType_EHeroType][var_18_1.heroType]
		}

		table.insert(var_18_0, var_18_2)
	end

	local var_18_3 = {
		icon = HeroTagIcon[EHeroTagType.EHeroTagType_ECountryType][var_18_1.country],
		desc = HeroTagDesc[EHeroTagType.EHeroTagType_ECountryType][var_18_1.country]
	}

	table.insert(var_18_0, var_18_3)

	local var_18_4 = {
		icon = HeroTagIcon[EHeroTagType.EHeroTagType_EFloorHeightType][var_18_1.floorHeight],
		desc = HeroTagDesc[EHeroTagType.EHeroTagType_EFloorHeightType][var_18_1.floorHeight]
	}

	table.insert(var_18_0, var_18_4)

	local var_18_5 = {
		icon = HeroTagIcon[EHeroTagType.EHeroTagType_EArmsType][var_18_1.armsType],
		desc = HeroTagDesc[EHeroTagType.EHeroTagType_EArmsType][var_18_1.armsType]
	}

	table.insert(var_18_0, var_18_5)

	return var_18_0
end
