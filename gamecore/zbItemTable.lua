require("gamebase.zbLoadCSV")

local var_0_0 = class("zbItemRecord")

var_0_0.__index = var_0_0

function createItemRecord()
	return (var_0_0.new())
end

function var_0_0.getFirstMainAttrValue(arg_2_0)
	if zbUtil:isValidTable(arg_2_0.mainAttrList) then
		return arg_2_0.mainAttrList[1].AttrValue
	else
		return 0
	end
end

zbItemTable = {}
zbItemTable.records = {}

function zbItemTable.load(arg_3_0, arg_3_1)
	local var_3_0 = require(arg_3_1)

	if var_3_0 == nil then
		return
	end

	if type(var_3_0) == "table" then
		for iter_3_0, iter_3_1 in pairs(var_3_0) do
			if iter_3_0 == 1 or iter_3_0 == 2 or iter_3_1[1] == "" then
				-- block empty
			else
				local var_3_1 = tonumber(iter_3_1[1])
				local var_3_2 = createItemRecord()
				local var_3_3 = 1

				var_3_2.id = tonumber(iter_3_1[var_3_3])

				local var_3_4 = var_3_3 + 1

				var_3_2.name = iter_3_1[var_3_4]

				local var_3_5 = var_3_4 + 1

				var_3_2.description = iter_3_1[var_3_5]

				local var_3_6 = var_3_5 + 1

				var_3_2.icon = iter_3_1[var_3_6]

				local var_3_7 = var_3_6 + 1

				var_3_2.quality = tonumber(iter_3_1[var_3_7])

				local var_3_8 = var_3_7 + 1

				var_3_2.type = tonumber(iter_3_1[var_3_8])

				local var_3_9 = var_3_8 + 1

				var_3_2.subType = tonumber(iter_3_1[var_3_9])

				local var_3_10 = var_3_9 + 1

				var_3_2.mainAttrList = arg_3_0:parseContains(iter_3_1[var_3_10])

				local var_3_11 = var_3_10 + 1

				var_3_2.subAttrList = arg_3_0:parseContains(iter_3_1[var_3_11])

				local var_3_12 = var_3_11 + 1

				var_3_2.gemShape = tonumber(iter_3_1[var_3_12])

				local var_3_13 = var_3_12 + 1

				var_3_2.box = arg_3_0:parseBox(iter_3_1[var_3_13])

				local var_3_14 = var_3_13 + 1

				var_3_2.key = tonumber(iter_3_1[var_3_14])

				local var_3_15 = var_3_14 + 1

				var_3_2.emboitementId = tonumber(iter_3_1[var_3_15])

				local var_3_16 = var_3_15 + 1

				var_3_2.virtual = tonumber(iter_3_1[var_3_16])

				local var_3_17 = var_3_16 + 1

				var_3_2.fv = tonumber(iter_3_1[var_3_17])

				local var_3_18 = var_3_17 + 1

				var_3_2.sellPrice = tonumber(iter_3_1[var_3_18])

				local var_3_19 = var_3_18 + 1

				var_3_2.preShow = tonumber(iter_3_1[var_3_19])

				local var_3_20 = var_3_19 + 1

				var_3_2.gmShow = tonumber(iter_3_1[var_3_20])

				local var_3_21 = var_3_20 + 1

				arg_3_0.records[var_3_1] = var_3_2
			end
		end
	end

	return arg_3_0
end

function zbItemTable.parseContains(arg_4_0, arg_4_1)
	local var_4_0 = {}
	local var_4_1 = string.len(arg_4_1)
	local var_4_2 = string.sub(arg_4_1, 2, var_4_1 - 1)
	local var_4_3 = string.gsub(arg_4_1, "%[", "{")
	local var_4_4 = string.gsub(var_4_3, "%]", "}")
	local var_4_5 = wzUnserialize(var_4_4)

	if type(var_4_5) == "number" then
		return nil
	end

	local var_4_6 = {}
	local var_4_7 = 1

	for iter_4_0, iter_4_1 in pairs(var_4_5) do
		var_4_6[var_4_7] = {
			AttrType = tonumber(iter_4_1[1]),
			AttrAdditionType = tonumber(iter_4_1[2]),
			AttrValue = tonumber(iter_4_1[3]),
			AttrValueGrow = tonumber(iter_4_1[4])
		}
		var_4_7 = var_4_7 + 1
	end

	return var_4_6
end

function zbItemTable.parseBox(arg_5_0, arg_5_1)
	local var_5_0 = {}
	local var_5_1 = string.len(arg_5_1)
	local var_5_2 = string.sub(arg_5_1, 2, var_5_1 - 1)
	local var_5_3 = string.gsub(arg_5_1, "%[", "{")
	local var_5_4 = string.gsub(var_5_3, "%]", "}")
	local var_5_5 = wzUnserialize(var_5_4)

	if type(var_5_5) == "number" then
		return nil
	end

	local var_5_6 = {}
	local var_5_7 = 1

	for iter_5_0, iter_5_1 in pairs(var_5_5) do
		var_5_6[var_5_7] = {
			itemId = tonumber(iter_5_1[1]),
			roundNum = tonumber(iter_5_1[2])
		}
		var_5_7 = var_5_7 + 1
	end

	return var_5_6
end

function zbItemTable.getRecord(arg_6_0, arg_6_1)
	return arg_6_0.records[arg_6_1]
end

function zbItemTable.getAllShowEquipList(arg_7_0, arg_7_1)
	local function var_7_0(arg_8_0, arg_8_1)
		return arg_8_0.quality > arg_8_1.quality
	end

	local var_7_1 = {}

	for iter_7_0, iter_7_1 in pairs(arg_7_0.records) do
		if iter_7_1 ~= nil and iter_7_1.preShow == 1 and iter_7_1.type == EItemType.Equip and iter_7_1.subType == arg_7_1 then
			table.insert(var_7_1, iter_7_1)
		end
	end

	table.sort(var_7_1, var_7_0)

	local var_7_2 = 0

	for iter_7_2, iter_7_3 in pairs(var_7_1) do
		if iter_7_3 ~= nil then
			var_7_2 = var_7_2 + 1
		end
	end

	return var_7_1, var_7_2
end

function zbItemTable.getNeedShowEquipList(arg_9_0, arg_9_1, arg_9_2)
	local function var_9_0(arg_10_0, arg_10_1)
		return arg_10_0.quality > arg_10_1.quality
	end

	local function var_9_1(arg_11_0)
		for iter_11_0, iter_11_1 in pairs(g_GameData.BagEquipList) do
			if arg_11_0 == iter_11_1.TemplateId then
				return false
			end
		end

		return true
	end

	local var_9_2 = {}

	for iter_9_0, iter_9_1 in pairs(arg_9_0.records) do
		if iter_9_1 ~= nil and iter_9_1.preShow == 1 and iter_9_1.type == EItemType.Equip and iter_9_1.subType == arg_9_1 and arg_9_2 ~= iter_9_1.mainAttrList[1].AttrType and var_9_1(iter_9_1.templateId) then
			table.insert(var_9_2, iter_9_1)
		end
	end

	table.sort(var_9_2, var_9_0)

	local var_9_3 = 0

	for iter_9_2, iter_9_3 in pairs(var_9_2) do
		if iter_9_3 ~= nil then
			var_9_3 = var_9_3 + 1
		end
	end

	return var_9_2, var_9_3
end

function zbItemTable.getItemType(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.records[arg_12_1]

	if var_12_0 ~= nil then
		return var_12_0.type
	end

	return -1
end

function zbItemTable.getItemQuality(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.records[arg_13_1]

	if var_13_0 ~= nil then
		return var_13_0.quality
	end

	return -1
end

function zbItemTable.getEquipLevelUpItems(arg_14_0)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in pairs(arg_14_0.records) do
		if iter_14_1.type == EItemType.Material and iter_14_1.subType == EMaterialType.EquipCuilian then
			table.insert(var_14_0, iter_14_1)
		end
	end

	local function var_14_1(arg_15_0, arg_15_1)
		return arg_15_0.virtual < arg_15_1.virtual
	end

	table.sort(var_14_0, var_14_1)

	return var_14_0
end

function zbItemTable.getHeroLevelUpItems(arg_16_0)
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in pairs(arg_16_0.records) do
		if iter_16_1.type == EItemType.Material and iter_16_1.subType == EMaterialType.HeroExpPill then
			table.insert(var_16_0, iter_16_1)
		end
	end

	local function var_16_1(arg_17_0, arg_17_1)
		return arg_17_0.virtual < arg_17_1.virtual
	end

	table.sort(var_16_0, var_16_1)

	return var_16_0
end

function zbItemTable.getGodLevelUpItems(arg_18_0)
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in pairs(arg_18_0.records) do
		if iter_18_1.type == EItemType.Material and iter_18_1.subType == EMaterialType.GodLevel then
			table.insert(var_18_0, iter_18_1)
		end
	end

	local function var_18_1(arg_19_0, arg_19_1)
		return arg_19_0.virtual < arg_19_1.virtual
	end

	table.sort(var_18_0, var_18_1)

	return var_18_0
end

function zbItemTable.getGodStarUpItems(arg_20_0)
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in pairs(arg_20_0.records) do
		if iter_20_1.type == EItemType.Material and iter_20_1.subType == EMaterialType.GodStar then
			table.insert(var_20_0, iter_20_1)
		end
	end

	local function var_20_1(arg_21_0, arg_21_1)
		return arg_21_0.virtual < arg_21_1.virtual
	end

	table.sort(var_20_0, var_20_1)

	return var_20_0
end

function zbItemTable.getGodSkillUpItems(arg_22_0)
	local var_22_0 = {}

	for iter_22_0, iter_22_1 in pairs(arg_22_0.records) do
		if iter_22_1.type == EItemType.Material and iter_22_1.subType == EMaterialType.GodSkill then
			table.insert(var_22_0, iter_22_1)
		end
	end

	local function var_22_1(arg_23_0, arg_23_1)
		return arg_23_0.virtual < arg_23_1.virtual
	end

	table.sort(var_22_0, var_22_1)

	return var_22_0
end

function zbItemTable.getHeroXilianItems(arg_24_0)
	for iter_24_0, iter_24_1 in pairs(arg_24_0.records) do
		if iter_24_1.type == EItemType.Material and iter_24_1.subType == EMaterialType.HeroXilian then
			return iter_24_1
		end
	end

	return nil
end

function zbItemTable.getHeroTupoItems(arg_25_0)
	for iter_25_0, iter_25_1 in pairs(arg_25_0.records) do
		if iter_25_1.type == EItemType.Material and iter_25_1.subType == EMaterialType.HeroTupo then
			return iter_25_1
		end
	end

	return nil
end

function zbItemTable.getMagnifierInfo(arg_26_0)
	if zbUtil:isValidTable(g_GameData.BagItemList) then
		for iter_26_0, iter_26_1 in pairs(g_GameData.BagItemList) do
			local var_26_0 = arg_26_0.records[iter_26_1.TemplateId]

			if var_26_0 and var_26_0.type == EItemType.Material and var_26_0.subType == EMaterialType.Magnifier then
				return iter_26_1
			end
		end
	end

	return nil
end

function zbItemTable.isEquip(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0.records[arg_27_1]

	return var_27_0 ~= nil and var_27_0.type == EItemType.Equip
end

function zbItemTable.IsConsumItem(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0.records[arg_28_1]

	return var_28_0 ~= nil and (var_28_0.type == EItemType.Material or var_28_0.type == EItemType.Box or var_28_0.type == EItemType.Key or var_28_0.type == EItemType.Gem)
end

g_strAttrType = {}
g_strAttrType[EAttrType.Force] = "\xC1\xA6\xC1\xBF"
g_strAttrType[EAttrType.Intelligence] = "\xD6\xC7\xC1\xA6"
g_strAttrType[EAttrType.Tili] = "\xCC\xE5\xC1\xA6"
g_strAttrType[EAttrType.HP] = "Ѫ\xC1\xBF"
g_strAttrType[EAttrType.PhysicAttack] = "\xCE﹥"
g_strAttrType[EAttrType.PhysicDefend] = "\xCE\xEF\xB7\xC0"
g_strAttrType[EAttrType.MagicAttack] = "\xB7\xA8\xB9\xA5"
g_strAttrType[EAttrType.MagicDefend] = "\xB7\xA8\xB7\xC0"
g_strAttrType[EAttrType.Violent] = "\xB1\xA9\xBB\xF7"
g_strAttrType[EAttrType.Tough] = "\xC8\xCD\xD0\xD4"
g_strAttrType[EAttrType.Hit] = "\xC3\xFC\xD6\xD0"
g_strAttrType[EAttrType.Dodge] = "\xC9\xC1\xB1\xDC"
g_strAttrType[EAttrType.PierceDamage] = "\xD4\xF6\xC9\xCB"
g_strAttrType[EAttrType.Block] = "\xBC\xF5\xC9\xCB"

function getItemPropStr(arg_29_0)
	if g_strAttrType[arg_29_0] then
		return g_strAttrType[arg_29_0]
	else
		return "\xCE\xDE"
	end
end

function wrapPropValue(arg_30_0, arg_30_1)
	return arg_30_1
end

function getEquipExtraAttributeStrName(arg_31_0, arg_31_1)
	if arg_31_0 == nil then
		return ""
	end

	if arg_31_0.ExtraAttribute == nil or arg_31_1 > table.getn(arg_31_0.ExtraAttribute) then
		return ""
	end

	return (getItemPropStr(arg_31_0.ExtraAttribute[arg_31_1].AttrType))
end

function getEquipExtraAttributeStr(arg_32_0, arg_32_1)
	if arg_32_0 == nil then
		return ""
	end

	if arg_32_0.ExtraAttribute == nil or arg_32_1 > table.getn(arg_32_0.ExtraAttribute) then
		return ""
	end

	return getItemPropStr(arg_32_0.ExtraAttribute[arg_32_1].AttrType) .. " +" .. wrapPropValue(arg_32_0.ExtraAttribute[arg_32_1].AttrType, arg_32_0.ExtraAttribute[arg_32_1].AttrValue)
end

function getEquipExtraAttributeTempStr(arg_33_0, arg_33_1)
	if arg_33_0 == nil then
		return ""
	end

	if arg_33_0.ExtraAttributeTemp == nil or arg_33_1 > table.getn(arg_33_0.ExtraAttributeTemp) then
		return ""
	end

	return getItemPropStr(arg_33_0.ExtraAttributeTemp[arg_33_1].AttrType) .. " +" .. wrapPropValue(arg_33_0.ExtraAttributeTemp[arg_33_1].AttrType, arg_33_0.ExtraAttributeTemp[arg_33_1].AttrValue)
end

function getEquipBackExtraAttributeStr(arg_34_0, arg_34_1)
	if arg_34_0 == nil then
		return ""
	end

	if arg_34_0.ExtraAttribute == nil or arg_34_1 > table.getn(arg_34_0.BackExtraAttribute) then
		return "\xCE\xDE"
	end

	return getItemPropStr(arg_34_0.BackExtraAttribute[arg_34_1].AttrType) .. " +" .. wrapPropValue(arg_34_0.BackExtraAttribute[arg_34_1].AttrType, arg_34_0.BackExtraAttribute[arg_34_1].AttrValue)
end

function RefreshEquipQuality(arg_35_0, arg_35_1)
	if arg_35_1 == nil then
		for iter_35_0 = 1, 6 do
			arg_35_0:getChildByTag(iter_35_0):setVisible(false)
		end

		return
	end

	for iter_35_1 = 1, 6 do
		if iter_35_1 <= arg_35_1.quality then
			arg_35_0:getChildByTag(iter_35_1):setVisible(true)
		else
			arg_35_0:getChildByTag(iter_35_1):setVisible(false)
		end
	end
end
