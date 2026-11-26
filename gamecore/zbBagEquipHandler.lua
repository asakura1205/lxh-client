local var_0_0 = class("zbBagEquipHandler")

var_0_0.__index = var_0_0

function createBagEquipHandler()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	arg_2_0.activateOrder = {}
	arg_2_0.activateOrder[EGemShape.Gold] = EGemShape.Water
	arg_2_0.activateOrder[EGemShape.Water] = EGemShape.Wood
	arg_2_0.activateOrder[EGemShape.Wood] = EGemShape.Fire
	arg_2_0.activateOrder[EGemShape.Fire] = EGemShape.Soli
	arg_2_0.activateOrder[EGemShape.Soli] = EGemShape.Gold
end

function var_0_0.equipNew(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in pairs(arg_3_1) do
		table.insert(g_GameData.BagEquipList, iter_3_1)
	end

	if table.getn(arg_3_1) > 0 then
		g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_BagEquip)
	end
end

function var_0_0.equipUpdate(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in pairs(arg_4_1) do
		local var_4_0 = false

		for iter_4_2, iter_4_3 in pairs(g_GameData.BagEquipList) do
			if iter_4_3.EquipId == iter_4_1.EquipId then
				table.remove(g_GameData.BagEquipList, iter_4_2)
				table.insert(g_GameData.BagEquipList, iter_4_1)

				var_4_0 = true

				break
			end
		end

		if var_4_0 == false then
			echo("warning: can not find valid bagEquip: " .. iter_4_1.EquipId)
		end
	end

	if table.getn(arg_4_1) > 0 then
		g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_BagEquip)
	end
end

function var_0_0.equipDel(arg_5_0, arg_5_1)
	local var_5_0 = false

	for iter_5_0, iter_5_1 in pairs(arg_5_1) do
		for iter_5_2, iter_5_3 in pairs(g_GameData.BagEquipList) do
			if iter_5_3.EquipId == iter_5_1 then
				table.remove(g_GameData.BagEquipList, iter_5_2)

				var_5_0 = true

				break
			end
		end
	end

	if var_5_0 then
		g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_BagEquip)
	end
end

function var_0_0.getEquipList(arg_6_0, arg_6_1)
	local var_6_0 = 3
	local var_6_1 = 0
	local var_6_2 = {}
	local var_6_3 = g_Self.kEquipFragHandler:getFragListByType(EItemType.Equip, arg_6_1)
	local var_6_4 = arg_6_0:getEquipFromHeroBagBySubType(arg_6_1)
	local var_6_5 = false

	for iter_6_0, iter_6_1 in pairs(var_6_3) do
		if iter_6_1.Count > 0 then
			if g_Self.kEquipFragHandler:getEquipComposeNeeds(iter_6_1.TemplateId) <= iter_6_1.Count then
				local var_6_6 = {
					equip = iter_6_1
				}

				var_6_6.isEmpty = false
				var_6_6.isFrag = true

				table.insert(var_6_2, var_6_6)

				var_6_3[iter_6_0] = nil
			else
				var_6_5 = true
			end
		end
	end

	for iter_6_2, iter_6_3 in pairs(var_6_4) do
		table.insert(var_6_2, iter_6_3)
	end

	local var_6_7 = -1

	if table.getn(var_6_2) % var_6_0 ~= 0 then
		local var_6_8 = {}

		var_6_8.isEmpty = true

		table.insert(var_6_2, var_6_8)
	end

	if table.getn(var_6_2) % var_6_0 ~= 0 then
		local var_6_9 = {}

		var_6_9.isEmpty = true

		table.insert(var_6_2, var_6_9)
	end

	local var_6_10 = table.getn(var_6_2) / var_6_0 + 1

	if var_6_5 == true then
		local var_6_11 = {}

		var_6_11.isSpeartor = true
		var_6_11.isSpeartor2 = false
		var_6_11.isSpeartor3 = false

		table.insert(var_6_2, var_6_11)

		local var_6_12 = {}

		var_6_12.isSpeartor = false
		var_6_12.isSpeartor2 = true
		var_6_12.isSpeartor3 = false

		table.insert(var_6_2, var_6_12)

		local var_6_13 = {}

		var_6_13.isSpeartor = false
		var_6_13.isSpeartor2 = false
		var_6_13.isSpeartor3 = true

		table.insert(var_6_2, var_6_13)

		for iter_6_4, iter_6_5 in pairs(var_6_3) do
			if iter_6_5 then
				local var_6_14 = {
					equip = iter_6_5
				}

				var_6_14.isEmpty = false
				var_6_14.isFrag = true

				table.insert(var_6_2, var_6_14)
			end
		end

		if table.getn(var_6_2) % var_6_0 ~= 0 then
			local var_6_15 = {}

			var_6_15.isEmpty = true

			table.insert(var_6_2, var_6_15)
		end

		if table.getn(var_6_2) % var_6_0 ~= 0 then
			local var_6_16 = {}

			var_6_16.isEmpty = true

			table.insert(var_6_2, var_6_16)
		end
	end

	return var_6_2, var_6_10
end

function var_0_0.getEquipFromHeroBagBySubType(arg_7_0, arg_7_1)
	local var_7_0 = {}
	local var_7_1 = 1

	for iter_7_0, iter_7_1 in pairs(g_GameData.HeroList) do
		local var_7_2 = iter_7_1.EquipList

		for iter_7_2, iter_7_3 in pairs(var_7_2) do
			if iter_7_3.EEquipType == arg_7_1 then
				local var_7_3 = {
					equip = iter_7_3.Equip,
					heroTemplateId = iter_7_1.HeroBaseInfo.TemplateId
				}

				var_7_3.isEmpty = false
				var_7_3.isFrag = false
				var_7_0[var_7_1] = var_7_3
				var_7_1 = var_7_1 + 1
			end
		end
	end

	for iter_7_4, iter_7_5 in pairs(g_GameData.BagEquipList) do
		local var_7_4 = zbItemTable:getRecord(iter_7_5.TemplateId)

		if var_7_4 ~= nil and var_7_4.type == EItemType.Equip and arg_7_1 ~= nil and var_7_4.subType == arg_7_1 then
			local var_7_5 = {
				equip = iter_7_5
			}

			var_7_5.heroTemplateId = 0
			var_7_5.isEmpty = false
			var_7_5.isFrag = false
			var_7_0[var_7_1] = var_7_5
			var_7_1 = var_7_1 + 1
		end
	end

	local function var_7_6(arg_8_0, arg_8_1)
		if arg_8_0.heroTemplateId == 0 and arg_8_1.heroTemplateId == 0 then
			if arg_8_0.equip.Quality == arg_8_1.equip.Quality then
				return arg_8_0.equip.Level > arg_8_1.equip.Level
			end

			return arg_8_0.equip.Quality > arg_8_1.equip.Quality
		end

		if arg_8_0.heroTemplateId == 0 then
			return false
		end

		if arg_8_1.heroTemplateId == 0 then
			return true
		end

		if arg_8_0.equip.Quality == arg_8_1.equip.Quality then
			return arg_8_0.equip.Level > arg_8_1.equip.Level
		end

		return arg_8_0.equip.Quality > arg_8_1.equip.Quality
	end

	table.sort(var_7_0, var_7_6)

	return var_7_0
end

function var_0_0.getItemFromHeroBagByItemId(arg_9_0, arg_9_1)
	local var_9_0 = tostring(arg_9_1)

	for iter_9_0, iter_9_1 in pairs(g_GameData.BagEquipList) do
		if tostring(iter_9_1.EquipId) == var_9_0 then
			return iter_9_1
		end
	end

	for iter_9_2, iter_9_3 in pairs(g_GameData.HeroList) do
		local var_9_1 = iter_9_3.EquipList

		for iter_9_4, iter_9_5 in pairs(var_9_1) do
			if tostring(iter_9_5.Equip.EquipId) == var_9_0 then
				return iter_9_5.Equip
			end
		end
	end

	return nil
end

function var_0_0.getBagEquipByPos(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs(g_GameData.BagEquipList) do
		local var_10_1 = zbItemTable:getRecord(iter_10_1.TemplateId)

		if var_10_1 ~= nil and var_10_1.type == EItemType.Equip and arg_10_1 ~= nil and var_10_1.subType == arg_10_1 and arg_10_2 ~= var_10_1.mainAttrList[1].AttrType then
			table.insert(var_10_0, iter_10_1)
		end
	end

	local function var_10_2(arg_11_0, arg_11_1)
		if arg_11_0.Quality == arg_11_1.Quality then
			return arg_11_0.Level > arg_11_1.Level
		end

		return arg_11_0.Quality > arg_11_1.Quality
	end

	table.sort(var_10_0, var_10_2)

	return var_10_0
end

function var_0_0.getFvBagEquip(arg_12_0, arg_12_1)
	local var_12_0 = 0
	local var_12_1 = zbItemTable:getRecord(arg_12_1)

	if var_12_1 ~= nil and var_12_1.type == EItemType.Equip then
		for iter_12_0, iter_12_1 in pairs(var_12_1.mainAttrList) do
			if iter_12_1.AttrAdditionType == EAttrAdditionType.Fixed then
				var_12_0 = var_12_0 + zbFvAttrTable:getRecord(iter_12_1.AttrType).value * iter_12_1.AttrValue
			end
		end

		for iter_12_2, iter_12_3 in pairs(var_12_1.subAttrList) do
			if iter_12_3.AttrAdditionType == EAttrAdditionType.Fixed then
				var_12_0 = var_12_0 + zbFvAttrTable:getRecord(iter_12_3.AttrType).value * iter_12_3.AttrValue
			end
		end
	elseif var_12_1 ~= nil and var_12_1.type == EItemType.Gem then
		var_12_0 = var_12_0 + var_12_1.fv
	end

	return var_12_0
end

function var_0_0.getBagEquipMain(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = ""

	for iter_13_0, iter_13_1 in pairs(arg_13_1.mainAttrList) do
		local var_13_1 = a2u(getItemPropStr(iter_13_1.AttrType))
		local var_13_2 = zbEquipUpStarTable:getRecord(arg_13_2.Star)
		local var_13_3 = (iter_13_1.AttrValue + iter_13_1.AttrValueGrow * (arg_13_2.Level - 1)) * (var_13_2.addAttrRate + 1)

		if arg_13_2.AttrInfo.Addition ~= 0 then
			if iter_13_1.AttrAdditionType == EAttrAdditionType.Fixed then
				var_13_0 = var_13_0 .. " " .. var_13_1 .. ":" .. var_13_3 .. "+" .. arg_13_2.AttrInfo.Addition * (iter_13_1.AttrValue + iter_13_1.AttrValueGrow * arg_13_2.Level)
			else
				var_13_0 = var_13_0 .. " " .. var_13_1 .. ":" .. var_13_3 * 100 .. "%" .. "+" .. arg_13_2.AttrInfo.Addition * (iter_13_1.AttrValue + iter_13_1.AttrValueGrow * arg_13_2.Level) * 100 .. "%"
			end
		elseif iter_13_1.AttrAdditionType == EAttrAdditionType.Fixed then
			var_13_0 = var_13_0 .. " " .. var_13_1 .. ":" .. var_13_3
		else
			var_13_0 = var_13_0 .. " " .. var_13_1 .. ":" .. var_13_3 * 100 .. "%"
		end
	end

	return var_13_0
end

function var_0_0.getEquipCanEnchant(arg_14_0, arg_14_1)
	if arg_14_1 == nil or zbFunHelper:isLockNoTip(EFuncType.GemSet) then
		return false
	end

	for iter_14_0, iter_14_1 in pairs(arg_14_1.GemList) do
		if iter_14_1 then
			if iter_14_1.TemplateId == 0 then
				local var_14_0 = g_Self.kBagItemHandler:getGemsAtType(iter_14_1.GemShape)

				if table.getn(var_14_0) ~= 0 then
					return true
				end
			else
				local var_14_1 = zbItemTable:getRecord(iter_14_1.TemplateId)
				local var_14_2 = g_Self.kBagItemHandler:getGemsAtType(iter_14_1.GemShape)
				local var_14_3 = false

				for iter_14_2, iter_14_3 in pairs(var_14_2) do
					if zbItemTable:getRecord(iter_14_3.TemplateId).quality > var_14_1.quality then
						var_14_3 = true

						break
					end
				end

				if var_14_3 then
					return true
				end
			end
		end
	end

	if arg_14_1.Quality < EItemQuality.Blue then
		return false
	end

	local var_14_4 = g_Self.kBagItemHandler:getItemCount(EItemType.Material, EMaterialType.GemOpenHole)

	for iter_14_4 = table.getn(arg_14_1.GemList) + 1, 5 do
		local var_14_5 = zbEquipHoleTable:getRecord(iter_14_4)

		if var_14_4 >= var_14_5.cost and var_14_5.lvl <= arg_14_1.Level then
			return true
		end
	end

	return false
end

function var_0_0.getCanEnchant(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:getEquipFromHeroBagBySubType(arg_15_1)

	for iter_15_0, iter_15_1 in pairs(var_15_0) do
		if arg_15_0:getEquipCanEnchant(iter_15_1.equip) == true then
			return true
		end
	end

	return false
end

function var_0_0.getEnchantLight(arg_16_0, arg_16_1)
	if table.getn(arg_16_1.GemList) < 5 then
		return 0
	end

	local var_16_0 = 5

	for iter_16_0, iter_16_1 in pairs(arg_16_1.GemList) do
		if iter_16_1.TemplateId == 0 then
			return 0
		end

		local var_16_1 = zbItemTable:getRecord(iter_16_1.TemplateId)

		if var_16_1 == nil then
			return 0
		end

		var_16_0 = math.min(arg_16_0:exChangeGem(var_16_1.subType), var_16_0)
	end

	return var_16_0
end

function var_0_0.exChangeGem(arg_17_0, arg_17_1)
	if arg_17_1 >= EGemType.Level1 and arg_17_1 <= EGemType.Level2 then
		return 1
	elseif arg_17_1 >= EGemType.Level3 and arg_17_1 <= EGemType.Level4 then
		return 2
	elseif arg_17_1 >= EGemType.Level5 and arg_17_1 <= EGemType.Level6 then
		return 3
	elseif arg_17_1 >= EGemType.Level7 and arg_17_1 <= EGemType.Level8 then
		return 4
	else
		return 5
	end
end
