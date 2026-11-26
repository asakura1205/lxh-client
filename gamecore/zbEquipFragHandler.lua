local var_0_0 = class("zbEquipFragHandler")

var_0_0.__index = var_0_0

function createEquipFragHandler()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	return
end

function var_0_0.fragNew(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in pairs(arg_3_1) do
		table.insert(g_GameData.EquipFragList, iter_3_1)
	end

	if table.getn(arg_3_1) > 0 then
		g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_FragEquip)
	end
end

function var_0_0.fragUpdate(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in pairs(arg_4_1) do
		local var_4_0 = false

		for iter_4_2, iter_4_3 in pairs(g_GameData.EquipFragList) do
			if iter_4_3.TemplateId == iter_4_1.TemplateId then
				table.remove(g_GameData.EquipFragList, iter_4_2)
				table.insert(g_GameData.EquipFragList, iter_4_1)

				var_4_0 = true

				break
			end
		end

		if var_4_0 == false then
			echo("warning: can not find valid bagItem: " .. iter_4_1.TemplateId)
		end
	end

	if table.getn(arg_4_1) > 0 then
		g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_FragEquip)
	end
end

function var_0_0.fragDel(arg_5_0, arg_5_1)
	local var_5_0 = false

	for iter_5_0, iter_5_1 in pairs(arg_5_1) do
		for iter_5_2, iter_5_3 in pairs(g_GameData.EquipFragList) do
			if iter_5_3.TemplateId == iter_5_1 then
				table.remove(g_GameData.EquipFragList, iter_5_2)

				var_5_0 = true

				break
			end
		end
	end

	if var_5_0 then
		g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_FragEquip)
	end
end

function var_0_0.getEquipFragCount(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(g_GameData.EquipFragList) do
		if iter_6_1.TemplateId == arg_6_1 then
			return iter_6_1.Count, true
		end
	end

	return 0, false
end

function var_0_0.hasComposeEquipFrag(arg_7_0)
	return arg_7_0:getEquipFragCanComposeId() > 0
end

function var_0_0.getEquipComposeNeeds(arg_8_0, arg_8_1)
	local var_8_0 = zbItemTable:getRecord(arg_8_1)

	if var_8_0 ~= nil then
		local var_8_1 = var_8_0.quality
		local var_8_2 = zbEquipQualityTable:getRecord(var_8_1)

		return var_8_2.composeFragNum, var_8_2.composeGold
	end

	return 0, 0
end

function var_0_0.getEquipFragData(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in pairs(g_GameData.EquipFragList) do
		if iter_9_1.TemplateId == arg_9_1 then
			return iter_9_1
		end
	end

	return nil
end

function var_0_0.getEquipFragCanComposeId(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(g_GameData.EquipFragList) do
		local var_10_0 = zbItemTable:getRecord(iter_10_1.TemplateId)

		if var_10_0 and var_10_0.class == EItemType.Equip and arg_10_0:getEquipComposeNeeds(iter_10_1.TemplateId) <= iter_10_1.Count then
			return iter_10_1.TemplateId
		end
	end

	return 0
end

function var_0_0.getFragExchangeSoulNum(arg_11_0, arg_11_1)
	local var_11_0 = zbHeroTable:getRecord(arg_11_1)

	if var_11_0 ~= nil then
		local var_11_1 = var_11_0.quality

		return g_DataConfig.m_kCommonCfg.heroExchangeSoul.qualityList[var_11_1].soulNum
	end

	return -1
end

function var_0_0.getFragListByType(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(g_GameData.EquipFragList) do
		local var_12_1 = zbItemTable:getRecord(iter_12_1.TemplateId)

		if var_12_1 and var_12_1.type == arg_12_1 and var_12_1.subType == arg_12_2 then
			table.insert(var_12_0, iter_12_1)
		end
	end

	local function var_12_2(arg_13_0, arg_13_1)
		return arg_13_0.Count > arg_13_1.Count
	end

	table.sort(var_12_0, var_12_2)

	return var_12_0
end

function var_0_0.hasFragNotify(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getFragListByType(EItemType.Equip, arg_14_1)

	for iter_14_0, iter_14_1 in pairs(var_14_0) do
		local var_14_1 = arg_14_0:getEquipFragCount(iter_14_1.TemplateId)
		local var_14_2, var_14_3 = arg_14_0:getEquipComposeNeeds(iter_14_1.TemplateId)

		if var_14_2 <= var_14_1 then
			return true
		end
	end

	return false
end
