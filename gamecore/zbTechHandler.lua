zbTechHandler = class("zbTechHandler")
zbTechHandler.__index = zbTechHandler

function createTechHandler()
	local var_1_0 = zbTechHandler.new()

	var_1_0:init()

	return var_1_0
end

function zbTechHandler.init(arg_2_0)
	return
end

function zbTechHandler.updateTechList(arg_3_0, arg_3_1)
	if zbUtil:isValidTable(arg_3_1) == false then
		return
	end

	g_GameData.TechList = arg_3_1

	g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_Tech)
	g_Self.kRedPointHandler:refreshTech()
end

function zbTechHandler.isVisible(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in pairs(g_GameData.TechList) do
		if iter_4_1.TechId == arg_4_1 and iter_4_1.Level > 0 then
			return true
		end
	end

	return false
end

function zbTechHandler.getStudyedTech(arg_5_0, arg_5_1)
	local var_5_0 = zbTechTable:getUnlockLevel(arg_5_1)

	for iter_5_0, iter_5_1 in pairs(g_GameData.TechList) do
		if iter_5_1.TechId == arg_5_1 and var_5_0 <= g_Self:getLevel() then
			return iter_5_1
		end
	end

	return nil
end

function zbTechHandler.getStudyedTechLevel(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(g_GameData.TechList) do
		if iter_6_1.TechId == arg_6_1 then
			return iter_6_1.Level
		end
	end

	return 0
end

function zbTechHandler.canUpgrade(arg_7_0, arg_7_1)
	local var_7_0 = zbTechTable:getRecord(arg_7_1)

	if var_7_0 == nil then
		return false
	end

	local var_7_1 = arg_7_0:getStudyedTech(arg_7_1)

	if var_7_1 == nil and g_Self:getLevel() >= var_7_0.unlockLvl then
		return true
	end

	if var_7_1 == nil then
		return false
	end

	if var_7_1 ~= nil and g_Self:getLevel() >= var_7_0.unlockLvl and var_7_1.Level < var_7_0.maxLvl then
		if var_7_0.upInterval > 1 then
			return var_7_1.Level * var_7_0.upInterval + var_7_0.unlockLvl <= g_Self:getLevel()
		else
			return var_7_1.Level + 1 <= g_Self:getLevel()
		end
	end

	return false
end

function zbTechHandler.hasTechFormationCanUpgrade(arg_8_0)
	local var_8_0 = {}
	local var_8_1 = {}

	for iter_8_0, iter_8_1 in pairs(g_GameData.TechList) do
		local var_8_2 = zbTechTable:getRecord(iter_8_1.TechId)

		if var_8_2 and var_8_2.type == ETechType.Formation and arg_8_0:canUpgrade(iter_8_1.TechId) then
			table.insert(var_8_0, iter_8_1)
		end

		if var_8_2 and var_8_2.type == ETechType.Formation and iter_8_1.Level > 0 then
			table.insert(var_8_1, iter_8_1)
		end
	end

	return table.getn(var_8_0) == table.getn(var_8_1)
end

function zbTechHandler.hasTechCanUpgrade(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(g_GameData.TechList) do
		local var_9_0 = zbTechTable:getRecord(iter_9_1.TechId)

		if var_9_0 and var_9_0.type == ETechType.Formation and arg_9_0:hasTechFormationCanUpgrade() then
			return true
		elseif var_9_0 and var_9_0.type ~= ETechType.Formation and arg_9_0:canUpgrade(iter_9_1.TechId) then
			return true
		end
	end

	return false
end

function zbTechHandler.sortFormationList(arg_10_0)
	local function var_10_0(arg_11_0, arg_11_1)
		if arg_11_0.Level == arg_11_1.Level then
			return arg_11_0.TechId < arg_11_1.TechId
		end

		return arg_11_0.Level > arg_11_1.Level
	end

	local var_10_1 = {}

	for iter_10_0, iter_10_1 in pairs(zbTechTable.records) do
		if iter_10_1.isFormation then
			local var_10_2 = g_Self.kTechHandler:getStudyedTech(iter_10_1.id)

			if var_10_2 ~= nil then
				table.insert(var_10_1, var_10_2)
			end
		end
	end

	table.sort(var_10_1, var_10_0)

	return var_10_1
end

function zbTechHandler.getParterTechLevelByPos(arg_12_0, arg_12_1)
	local var_12_0 = 0

	if arg_12_1 == EParterAttrType.Attack then
		var_12_0 = EParterTechId.AttackTech
	elseif arg_12_1 == EParterAttrType.Defend then
		var_12_0 = EParterTechId.DefendTech
	elseif arg_12_1 == EParterAttrType.HP then
		var_12_0 = EParterTechId.HpTech
	end

	return arg_12_0:getStudyedTechLevel(var_12_0)
end

function zbTechHandler.parterEnableByTechId(arg_13_0, arg_13_1)
	local var_13_0 = zbTechTable:getRecord(arg_13_1)

	return arg_13_0:getStudyedTechLevel(arg_13_1) > 0 and var_13_0.unlockLvl <= g_Self:getLevel()
end

function zbTechHandler.parterEnableByPos(arg_14_0, arg_14_1)
	local var_14_0 = zbTechTable:getParterTechRecord(arg_14_1)

	return arg_14_0:getParterTechLevelByPos(arg_14_1) > 0 and var_14_0.unlockLvl <= g_Self:getLevel()
end

function zbTechHandler.getParterTechOpenLevel(arg_15_0, arg_15_1)
	local var_15_0 = 0

	if arg_15_1 == EParterAttrType.Attack then
		var_15_0 = EParterTechId.AttackTech
	elseif arg_15_1 == EParterAttrType.Defend then
		var_15_0 = EParterTechId.DefendTech
	elseif arg_15_1 == EParterAttrType.HP then
		var_15_0 = EParterTechId.HpTech
	end

	local var_15_1 = zbTechTable:getRecord(var_15_0)

	if var_15_1 == nil then
		return 0
	end

	return var_15_1.unlockLvl
end
