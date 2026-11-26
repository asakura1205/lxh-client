require("gamebase.zbLoadCSV")

local var_0_0 = class("zbTechRecord")

var_0_0.__index = var_0_0

function createTechRecord()
	return (var_0_0.new())
end

zbTechTable = {}
zbTechTable.records = {}

function zbTechTable.load(arg_2_0, arg_2_1)
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
				local var_2_2 = createTechRecord()
				local var_2_3 = 1

				var_2_2.id = tonumber(iter_2_1[var_2_3])

				local var_2_4 = var_2_3 + 1

				var_2_2.type = tonumber(iter_2_1[var_2_4])

				local var_2_5 = var_2_4 + 1

				var_2_2.name = iter_2_1[var_2_5]

				local var_2_6 = var_2_5 + 1

				var_2_2.history = iter_2_1[var_2_6]

				local var_2_7 = var_2_6 + 1

				var_2_2.description = iter_2_1[var_2_7]

				local var_2_8 = var_2_7 + 1

				var_2_2.iconPath = iter_2_1[var_2_8]

				local var_2_9 = var_2_8 + 1

				var_2_2.unlockLvl = tonumber(iter_2_1[var_2_9])

				local var_2_10 = var_2_9 + 1

				var_2_2.maxLvl = tonumber(iter_2_1[var_2_10])

				local var_2_11 = var_2_10 + 1

				var_2_2.upInterval = tonumber(iter_2_1[var_2_11])

				local var_2_12 = var_2_11 + 1

				var_2_2.attrType1 = tonumber(iter_2_1[var_2_12])

				local var_2_13 = var_2_12 + 1

				var_2_2.attrBase1 = tonumber(iter_2_1[var_2_13])

				local var_2_14 = var_2_13 + 1

				var_2_2.attrGrowth1 = tonumber(iter_2_1[var_2_14])

				local var_2_15 = var_2_14 + 1

				var_2_2.attrType2 = tonumber(iter_2_1[var_2_15])

				local var_2_16 = var_2_15 + 1

				var_2_2.attrBase2 = tonumber(iter_2_1[var_2_16])

				local var_2_17 = var_2_16 + 1

				var_2_2.attrGrowth2 = tonumber(iter_2_1[var_2_17])

				local var_2_18 = var_2_17 + 1

				var_2_2.upgradeId = tonumber(iter_2_1[var_2_18])

				local var_2_19 = var_2_18 + 1

				var_2_2.fv = tonumber(iter_2_1[var_2_19])

				local var_2_20 = var_2_19 + 1

				var_2_2.isFormation = var_2_2.type == ETechType.Formation
				arg_2_0.records[var_2_1] = var_2_2
			end
		end
	end

	return arg_2_0
end

function zbTechTable.getRecord(arg_3_0, arg_3_1)
	return arg_3_0.records[arg_3_1]
end

function zbTechTable.getUnlockLevel(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:getRecord(arg_4_1)

	if var_4_0 ~= nil then
		return var_4_0.unlockLvl
	end

	return 0
end

function zbTechTable.getFormationPropertyDesc(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:getRecord(arg_5_1)

	if var_5_0 == nil then
		return ""
	end

	local var_5_1 = getItemPropStr(var_5_0.attrType1)
	local var_5_2 = getItemPropStr(var_5_0.attrType2)
	local var_5_3 = "\xBB\xEF\xB0\xE9"

	if var_5_1 ~= nil then
		local var_5_4 = var_5_0.attrBase1 + var_5_0.attrGrowth1 * arg_5_2

		if var_5_4 > 0 then
			var_5_3 = var_5_3 .. "\xD4\xF6\xBC\xD3" .. var_5_4 .. "\xB5\xE3" .. var_5_1
		end
	end

	if var_5_2 ~= nil then
		local var_5_5 = var_5_0.attrBase2 + var_5_0.attrGrowth2 * arg_5_2

		if var_5_5 > 0 then
			var_5_3 = var_5_3 .. " " .. var_5_5 .. "\xB5\xE3" .. var_5_2
		end
	end

	return a2u(var_5_3)
end

function zbTechTable.getParterTechRecord(arg_6_0, arg_6_1)
	if arg_6_1 == EParterAttrType.Attack then
		return arg_6_0:getRecord(EParterTechId.AttackTech)
	elseif arg_6_1 == EParterAttrType.Defend then
		return arg_6_0:getRecord(EParterTechId.DefendTech)
	elseif arg_6_1 == EParterAttrType.HP then
		return arg_6_0:getRecord(EParterTechId.HpTech)
	end

	return nil
end
