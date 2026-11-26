local var_0_0 = class("zbBagItemHandler")

var_0_0.__index = var_0_0

function createBagItemHandler()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	arg_2_0.decomposeItems = {}
end

function var_0_0.itemNew(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in pairs(arg_3_1) do
		table.insert(g_GameData.BagItemList, iter_3_1)
	end

	if table.getn(arg_3_1) > 0 then
		g_Self.kRedPointHandler:refreshBag()
		g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_BagItem)
	end
end

function var_0_0.itemUpdate(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in pairs(arg_4_1) do
		local var_4_0 = false

		for iter_4_2, iter_4_3 in pairs(g_GameData.BagItemList) do
			if iter_4_3.TemplateId == iter_4_1.TemplateId then
				table.remove(g_GameData.BagItemList, iter_4_2)
				table.insert(g_GameData.BagItemList, iter_4_1)

				var_4_0 = true

				break
			end
		end

		if var_4_0 == false then
			echo("warning: can not find valid bagItem: " .. iter_4_1.TemplateId)
		end
	end

	if table.getn(arg_4_1) > 0 then
		g_Self.kRedPointHandler:refreshBag()
		g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_BagItem)
	end
end

function var_0_0.itemDel(arg_5_0, arg_5_1)
	local var_5_0 = false

	for iter_5_0, iter_5_1 in pairs(arg_5_1) do
		for iter_5_2, iter_5_3 in pairs(g_GameData.BagItemList) do
			if iter_5_3.TemplateId == iter_5_1 then
				table.remove(g_GameData.BagItemList, iter_5_2)

				var_5_0 = true

				break
			end
		end
	end

	if var_5_0 then
		g_Self.kRedPointHandler:refreshBag()
		g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_BagItem)
	end
end

function var_0_0.getItemCount(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = 0

	for iter_6_0, iter_6_1 in pairs(g_GameData.BagItemList) do
		local var_6_1 = zbItemTable:getRecord(iter_6_1.TemplateId)

		if var_6_1 ~= nil and var_6_1.type == arg_6_1 and (arg_6_2 == nil or var_6_1.subType == arg_6_2) then
			var_6_0 = var_6_0 + iter_6_1.Count
		end
	end

	return var_6_0
end

function var_0_0.getItemListBySubType(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = {}
	local var_7_1 = 1

	for iter_7_0, iter_7_1 in pairs(g_GameData.BagItemList) do
		local var_7_2 = zbItemTable:getRecord(iter_7_1.TemplateId)

		if var_7_2 ~= nil and var_7_2.type == arg_7_1 and arg_7_2 ~= nil and var_7_2.subType == arg_7_2 then
			var_7_0[var_7_1] = iter_7_1
			var_7_1 = var_7_1 + 1
		end
	end

	return var_7_0
end

function var_0_0.getItemCountByTemplateId(arg_8_0, arg_8_1)
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in pairs(g_GameData.BagItemList) do
		if arg_8_1 == iter_8_1.TemplateId then
			var_8_0 = iter_8_1.Count
		end
	end

	return var_8_0
end

function var_0_0.hasBox(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(g_GameData.BagItemList) do
		local var_9_0 = zbItemTable:getRecord(iter_9_1.TemplateId)

		if var_9_0 ~= nil and var_9_0.type == EItemType.Box then
			return true
		end
	end

	return false
end

function var_0_0.getEquipDecomposeList(arg_10_0, arg_10_1)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs(g_GameData.BagEquipList) do
		if arg_10_0:autoAddRule(iter_10_1) and (arg_10_1 == nil or arg_10_1 ~= iter_10_1.EquipId) then
			table.insert(var_10_0, iter_10_1)
		end
	end

	local function var_10_1(arg_11_0, arg_11_1)
		return arg_11_0.Quality < arg_11_1.Quality
	end

	table.sort(var_10_0, var_10_1)

	return var_10_0
end

function var_0_0.autoAddRule(arg_12_0, arg_12_1)
	local var_12_0 = zbItemTable:getRecord(arg_12_1.TemplateId).quality

	if var_12_0 <= EItemQuality.Green then
		return true
	elseif tonumber(g_Self.kSetHandler:getDecomposeQuality(var_12_0)) == 1 then
		return true
	end

	return false
end

function var_0_0.getItemRealPrice(arg_13_0, arg_13_1)
	if arg_13_1 == nil then
		return 0
	end

	local var_13_0 = 0
	local var_13_1 = zbItemTable:getRecord(arg_13_1.TemplateId)

	if var_13_1 ~= nil then
		var_13_0 = var_13_1.sellPrice
	end

	return var_13_0
end

function var_0_0.getItemDecomposeReturnPrice(arg_14_0, arg_14_1)
	if arg_14_1.equip == nil then
		return 0
	end

	local var_14_0 = 0
	local var_14_1 = zbItemTable:getRecord(arg_14_1.equip.TemplateId)

	if arg_14_1.isFrag then
		local var_14_2 = zbEquipDecomposeTable:getRecord(var_14_1.quality).composeNeedNum

		var_14_0 = var_14_1.sellPrice / var_14_2
	else
		var_14_0 = var_14_1.sellPrice

		if zbItemTable:isEquip(arg_14_1.equip.TemplateId) and arg_14_1.equip.Level >= 2 then
			for iter_14_0 = 1, arg_14_1.equip.Level - 1 do
				local var_14_3 = zbItemUpgradeTable:getRecord(iter_14_0)

				if var_14_3 then
					var_14_0 = var_14_0 + var_14_3.costValue[var_14_1.quality]
				end
			end
		end
	end

	if var_14_1 ~= nil then
		-- block empty
	end

	return var_14_0
end

function var_0_0.getComposeGems(arg_15_0)
	local var_15_0 = {}
	local var_15_1 = g_GameData.BagItemList

	for iter_15_0, iter_15_1 in pairs(var_15_1) do
		local var_15_2 = zbItemTable:getRecord(iter_15_1.TemplateId)

		if var_15_2 and var_15_2.type == EItemType.Gem and var_15_2.subType <= EGemType.MaxNum then
			table.insert(var_15_0, iter_15_1)
		end
	end

	local function var_15_3(arg_16_0, arg_16_1)
		local var_16_0 = zbItemTable:getRecord(arg_16_0.TemplateId)
		local var_16_1 = zbItemTable:getRecord(arg_16_1.TemplateId)

		return var_16_0.subType < var_16_1.subType
	end

	table.sort(var_15_0, var_15_3)

	return var_15_0
end

function var_0_0.getGems(arg_17_0)
	local var_17_0 = {}
	local var_17_1 = g_GameData.BagItemList

	for iter_17_0, iter_17_1 in pairs(var_17_1) do
		local var_17_2 = zbItemTable:getRecord(iter_17_1.TemplateId)

		if var_17_2 and var_17_2.type == EItemType.Gem then
			table.insert(var_17_0, iter_17_1)
		end
	end

	local function var_17_3(arg_18_0, arg_18_1)
		local var_18_0 = zbItemTable:getRecord(arg_18_0.TemplateId)
		local var_18_1 = zbItemTable:getRecord(arg_18_1.TemplateId)

		return var_18_0.subType < var_18_1.subType
	end

	table.sort(var_17_0, var_17_3)

	return var_17_0
end

function var_0_0.getGemsAtType(arg_19_0, arg_19_1)
	local var_19_0 = {}
	local var_19_1 = g_GameData.BagItemList

	for iter_19_0, iter_19_1 in pairs(var_19_1) do
		local var_19_2 = zbItemTable:getRecord(iter_19_1.TemplateId)

		if var_19_2 and var_19_2.type == EItemType.Gem and var_19_2.gemShape == arg_19_1 then
			table.insert(var_19_0, iter_19_1)
		end
	end

	local function var_19_3(arg_20_0, arg_20_1)
		local var_20_0 = zbItemTable:getRecord(arg_20_0.TemplateId)
		local var_20_1 = zbItemTable:getRecord(arg_20_1.TemplateId)

		return var_20_0.quality > var_20_1.quality
	end

	table.sort(var_19_0, var_19_3)

	return var_19_0
end

function var_0_0.canBagItemSell(arg_21_0, arg_21_1)
	return true
end

function var_0_0.canBagItemUse(arg_22_0, arg_22_1)
	local var_22_0 = zbItemTable:getRecord(arg_22_1)

	if var_22_0 and var_22_0.class == EItemType.Gem then
		return false
	end

	return true
end

function var_0_0.getBagByType(arg_23_0, arg_23_1)
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in pairs(g_GameData.BagItemList) do
		local var_23_1 = zbItemTable:getRecord(iter_23_1.TemplateId)

		if var_23_1 ~= nil and arg_23_0:isVisibleByBagItemType(var_23_1.type, arg_23_1) then
			table.insert(var_23_0, iter_23_1)
		end
	end

	local function var_23_2(arg_24_0, arg_24_1)
		local var_24_0 = zbItemTable:getRecord(arg_24_0.TemplateId)
		local var_24_1 = zbItemTable:getRecord(arg_24_1.TemplateId)

		if var_24_0.type == var_24_1.type then
			if var_24_0.subType == var_24_1.subType then
				return var_24_0.quality > var_24_1.quality
			end

			return var_24_0.subType > var_24_1.subType
		end

		return var_24_0.type > var_24_1.type
	end

	local function var_23_3(arg_25_0, arg_25_1)
		local var_25_0 = zbItemTable:getRecord(arg_25_0.TemplateId)
		local var_25_1 = zbItemTable:getRecord(arg_25_1.TemplateId)

		if var_25_0.subType == var_25_1.subType then
			return var_25_0.fv > var_25_1.fv
		end

		return var_25_0.subType > var_25_1.subType
	end

	if arg_23_1 == EBagTab.Gemstone then
		table.sort(var_23_0, var_23_3)
	else
		table.sort(var_23_0, var_23_2)
	end

	return var_23_0
end

function var_0_0.isVisibleByBagItemType(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = false

	if arg_26_2 == EBagTab.Consumables and arg_26_1 == EItemType.Material then
		var_26_0 = true
	elseif arg_26_2 == EBagTab.Gemstone and arg_26_1 == EItemType.Gem then
		var_26_0 = true
	elseif arg_26_2 == EBagTab.GiftBag and (arg_26_1 == EItemType.Box or arg_26_1 == EItemType.Key) then
		var_26_0 = true
	end

	return var_26_0
end

function var_0_0.getItemDataByTemplateId(arg_27_0, arg_27_1)
	local var_27_0 = g_GameData.BagItemList

	for iter_27_0, iter_27_1 in pairs(var_27_0) do
		if iter_27_1.TemplateId == arg_27_1 then
			return iter_27_1
		end
	end

	return nil
end
