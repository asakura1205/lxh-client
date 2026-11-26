require("gamecore.zbSkillDefine")

local var_0_0 = {
	1,
	4,
	7
}
local var_0_1 = {
	2,
	5,
	8
}
local var_0_2 = {
	3,
	6,
	9
}
local var_0_3 = {
	var_0_0,
	var_0_1,
	var_0_2
}
local var_0_4 = {
	1,
	2,
	3
}
local var_0_5 = {
	4,
	5,
	6
}
local var_0_6 = {
	7,
	8,
	9
}

local function var_0_7(arg_1_0)
	if arg_1_0 == 1 or arg_1_0 == 4 or arg_1_0 == 7 then
		return 1
	elseif arg_1_0 == 2 or arg_1_0 == 5 or arg_1_0 == 8 then
		return 2
	elseif arg_1_0 == 3 or arg_1_0 == 6 or arg_1_0 == 9 then
		return 3
	else
		return 0
	end
end

local function var_0_8(arg_2_0)
	if arg_2_0 == 1 or arg_2_0 == 2 or arg_2_0 == 3 then
		return 1
	elseif arg_2_0 == 4 or arg_2_0 == 5 or arg_2_0 == 6 then
		return 2
	elseif arg_2_0 == 7 or arg_2_0 == 8 or arg_2_0 == 9 then
		return 3
	else
		return 0
	end
end

local function var_0_9(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in pairs(arg_3_0) do
		if iter_3_1 == arg_3_1 then
			return true
		end
	end

	return false
end

local function var_0_10(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in pairs(arg_4_0) do
		if iter_4_1 == arg_4_1 then
			return true
		end
	end

	return false
end

local function var_0_11(arg_5_0, arg_5_1)
	local var_5_0 = false

	for iter_5_0, iter_5_1 in pairs(arg_5_1) do
		if iter_5_1:isSame(targetHero) then
			var_5_0 = true

			break
		end
	end

	return var_5_0
end

zbTargetHandler = class("zbTargetHandler")
zbTargetHandler.__index = zbTargetHandler

function zbTargetHandler.create(arg_6_0)
	return (zbTargetHandler.new())
end

function zbTargetHandler.selectTarget(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	if arg_7_2:isDamageSkill() and arg_7_1:isQting() then
		local var_7_0 = {}

		table.insert(var_7_0, arg_7_1.qteTarget)
		echo("1111111111111111111111 zbTargetHandler:selectTarget 1")

		return var_7_0
	end

	local var_7_1

	if arg_7_2:isDamageSkill() then
		local var_7_2, var_7_3 = arg_7_0:getFocusTarget(arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)

		if var_7_2 then
			var_7_1 = var_7_3
		end
	end

	local var_7_4 = arg_7_1:getChaofengSrc()

	if var_7_1 == nil and var_7_4 ~= nil and var_7_4:isDie() == false and arg_7_2:isDamageSkill() and arg_7_4 ~= ETargetType.Random_5 and arg_7_3 == ESideType.Enemy then
		local var_7_5 = arg_7_0:getPreHeroList(arg_7_1, arg_7_3, arg_7_4)
		local var_7_6 = arg_7_0:getFinalTargetList(var_7_5, var_7_1, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)

		if var_7_6 ~= nil and table.getn(var_7_6) > 1 then
			for iter_7_0, iter_7_1 in pairs(var_7_5) do
				if iter_7_1:isSame(var_7_4) then
					return var_7_6
				end
			end
		end

		local var_7_7 = {}

		table.insert(var_7_7, var_7_4)

		return var_7_7
	end

	local var_7_8 = arg_7_0:getPreHeroList(arg_7_1, arg_7_3, arg_7_4)

	return arg_7_0:getFinalTargetList(var_7_8, var_7_1, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
end

function zbTargetHandler.getFinalTargetList(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6, arg_8_7)
	local var_8_0 = {}
	local var_8_1 = false

	if arg_8_2 ~= nil then
		for iter_8_0, iter_8_1 in pairs(arg_8_1) do
			if iter_8_1:isSame(arg_8_2) then
				var_8_1 = true
			end
		end
	end

	local var_8_2

	if var_8_1 and arg_8_6 ~= ETargetType.Random_5 then
		var_8_2 = {}

		table.insert(var_8_2, arg_8_2)
	else
		var_8_2 = arg_8_0:getTargetHeros(arg_8_3, arg_8_1, arg_8_4, arg_8_6)
	end

	for iter_8_2, iter_8_3 in pairs(var_8_2) do
		local var_8_3 = arg_8_0:getSubTargetHeros(arg_8_3, iter_8_3, arg_8_7)

		for iter_8_4, iter_8_5 in pairs(var_8_3) do
			if var_0_11(iter_8_5, var_8_0) == false then
				table.insert(var_8_0, iter_8_5)
			end
		end
	end

	return var_8_0
end

function zbTargetHandler.getFocusTarget(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	if arg_9_2:isDamageSkill() == false then
		return false, nil
	end

	if g_CombatSystem:isPvPCombatType() or arg_9_1.forceType ~= ForceType.Left then
		return false, nil
	end

	if arg_9_3 == ForceType.Left then
		return false, nil
	end

	if arg_9_1:isMeihuo() then
		return false, nil
	end

	local var_9_0 = g_CombatSystem.combatData.combatFocus:getTarget()

	if var_9_0 ~= nil then
		return true, var_9_0
	else
		return false, nil
	end
end

function zbTargetHandler.getPreHeroList(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0

	if arg_10_2 == ESideType.Self then
		var_10_0 = g_CombatSystem:getHeros(arg_10_1.forceType)
	else
		var_10_0 = g_CombatSystem:getHeros(getFlipForceType(arg_10_1.forceType))
	end

	local var_10_1 = {}
	local var_10_2 = false
	local var_10_3 = false
	local var_10_4 = false
	local var_10_5

	if arg_10_3 == ETargetType.Random_1_Died then
		var_10_2 = true
		var_10_5 = false
	else
		var_10_2 = false
		var_10_5 = true
	end

	if arg_10_3 == ETargetType.Random_1_EXCLUDESELF then
		var_10_4 = true
	end

	for iter_10_0, iter_10_1 in pairs(var_10_0) do
		local var_10_6 = true

		if var_10_2 and iter_10_1:isDie() == false then
			var_10_6 = false
		end

		if var_10_5 and iter_10_1:isDie() then
			var_10_6 = false
		end

		if var_10_4 and iter_10_1:isSame(arg_10_1) then
			var_10_6 = false
		end

		if var_10_6 then
			table.insert(var_10_1, iter_10_1)
		end
	end

	return var_10_1
end

local function var_0_12(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = table.getn(arg_11_1)

	if var_11_0 == 0 then
		return
	end

	local var_11_1 = {}
	local var_11_2 = 1

	for iter_11_0, iter_11_1 in pairs(arg_11_1) do
		var_11_1[var_11_2] = iter_11_1
		var_11_2 = var_11_2 + 1
	end

	local var_11_3 = math.min(var_11_0, arg_11_2)

	for iter_11_2 = 1, var_11_3 do
		while true do
			local var_11_4 = zbGlobalUtil:RandomRange() % var_11_0 + 1

			if arg_11_0[var_11_4] == nil then
				arg_11_0[var_11_4] = var_11_1[var_11_4]

				break
			end
		end
	end
end

local function var_0_13(arg_12_0, arg_12_1, arg_12_2)
	for iter_12_0, iter_12_1 in pairs(arg_12_1) do
		if iter_12_1:getFormationIndex() == arg_12_2 then
			return iter_12_1
		end
	end

	return nil
end

local function var_0_14(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = var_0_3[arg_13_2]

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		local var_13_1 = var_0_13(arg_13_0, arg_13_1, iter_13_1)

		if var_13_1 ~= nil then
			return var_13_1
		end
	end

	return nil
end

local function var_0_15(arg_14_0)
	if arg_14_0 == 1 or arg_14_0 == 4 or arg_14_0 == 7 then
		return 1
	elseif arg_14_0 == 2 or arg_14_0 == 5 or arg_14_0 == 8 then
		return 2
	else
		return 3
	end
end

local function var_0_16(arg_15_0, arg_15_1)
	local var_15_0

	for iter_15_0, iter_15_1 in pairs(arg_15_1) do
		if var_15_0 == nil or iter_15_1.curHp > var_15_0.curHp then
			var_15_0 = iter_15_1
		end
	end

	if var_15_0 ~= nil then
		table.insert(arg_15_0, var_15_0)
	end
end

local function var_0_17(arg_16_0, arg_16_1)
	local var_16_0

	for iter_16_0, iter_16_1 in pairs(arg_16_1) do
		if var_16_0 == nil or iter_16_1:getHpPercent() < var_16_0:getHpPercent() then
			var_16_0 = iter_16_1
		end
	end

	if var_16_0 ~= nil then
		table.insert(arg_16_0, var_16_0)
	end
end

local function var_0_18(arg_17_0, arg_17_1)
	local var_17_0

	for iter_17_0, iter_17_1 in pairs(arg_17_1) do
		if var_17_0 == nil or iter_17_1.maxHp < var_17_0.maxHp then
			var_17_0 = iter_17_1
		end
	end

	if var_17_0 ~= nil then
		table.insert(arg_17_0, var_17_0)
	end
end

local function var_0_19(arg_18_0, arg_18_1)
	local var_18_0

	for iter_18_0, iter_18_1 in pairs(arg_18_1) do
		if var_18_0 == nil or iter_18_1.maxHp > var_18_0.maxHp then
			var_18_0 = iter_18_1
		end
	end

	if var_18_0 ~= nil then
		table.insert(arg_18_0, var_18_0)
	end
end

local function var_0_20(arg_19_0, arg_19_1)
	local var_19_0

	for iter_19_0, iter_19_1 in pairs(arg_19_1) do
		if var_19_0 == nil or iter_19_1.curMp < var_19_0.curMp then
			var_19_0 = iter_19_1
		end
	end

	if var_19_0 ~= nil then
		table.insert(arg_19_0, var_19_0)
	end
end

local function var_0_21(arg_20_0, arg_20_1)
	local var_20_0

	for iter_20_0, iter_20_1 in pairs(arg_20_1) do
		if var_20_0 == nil or iter_20_1.curMp > var_20_0.curMp then
			var_20_0 = iter_20_1
		end
	end

	if var_20_0 ~= nil then
		table.insert(arg_20_0, var_20_0)
	end
end

local function var_0_22(arg_21_0, arg_21_1)
	local var_21_0

	for iter_21_0, iter_21_1 in pairs(arg_21_1) do
		if var_21_0 == nil or iter_21_1.force < var_21_0.force then
			var_21_0 = iter_21_1
		end
	end

	if var_21_0 ~= nil then
		table.insert(arg_21_0, var_21_0)
	end
end

local function var_0_23(arg_22_0, arg_22_1)
	local var_22_0

	for iter_22_0, iter_22_1 in pairs(arg_22_1) do
		if var_22_0 == nil or iter_22_1.force > var_22_0.force then
			var_22_0 = iter_22_1
		end
	end

	if var_22_0 ~= nil then
		table.insert(arg_22_0, var_22_0)
	end
end

local function var_0_24(arg_23_0, arg_23_1)
	local var_23_0

	for iter_23_0, iter_23_1 in pairs(arg_23_1) do
		if var_23_0 == nil or iter_23_1.intelligence < var_23_0.intelligence then
			var_23_0 = iter_23_1
		end
	end

	if var_23_0 ~= nil then
		table.insert(arg_23_0, var_23_0)
	end
end

local function var_0_25(arg_24_0, arg_24_1)
	local var_24_0

	for iter_24_0, iter_24_1 in pairs(arg_24_1) do
		if var_24_0 == nil or iter_24_1.intelligence > var_24_0.intelligence then
			var_24_0 = iter_24_1
		end
	end

	if var_24_0 ~= nil then
		table.insert(arg_24_0, var_24_0)
	end
end

local function var_0_26(arg_25_0, arg_25_1)
	local var_25_0

	for iter_25_0, iter_25_1 in pairs(arg_25_1) do
		if var_25_0 == nil or iter_25_1.tili < var_25_0.tili then
			var_25_0 = iter_25_1
		end
	end

	if var_25_0 ~= nil then
		table.insert(arg_25_0, var_25_0)
	end
end

local function var_0_27(arg_26_0, arg_26_1)
	local var_26_0

	for iter_26_0, iter_26_1 in pairs(arg_26_1) do
		if var_26_0 == nil or iter_26_1.tili > var_26_0.tili then
			var_26_0 = iter_26_1
		end
	end

	if var_26_0 ~= nil then
		table.insert(arg_26_0, var_26_0)
	end
end

local function var_0_28(arg_27_0, arg_27_1)
	local var_27_0

	for iter_27_0, iter_27_1 in pairs(arg_27_1) do
		if var_27_0 == nil or iter_27_1.physicAttack > var_27_0.physicAttack then
			var_27_0 = iter_27_1
		end
	end

	if var_27_0 ~= nil then
		table.insert(arg_27_0, var_27_0)
	end
end

local function var_0_29(arg_28_0, arg_28_1)
	local var_28_0

	for iter_28_0, iter_28_1 in pairs(arg_28_1) do
		if var_28_0 == nil or iter_28_1.magicAttack > var_28_0.magicAttack then
			var_28_0 = iter_28_1
		end
	end

	if var_28_0 ~= nil then
		table.insert(arg_28_0, var_28_0)
	end
end

local var_0_30 = {
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8,
	9
}

function zbTargetHandler.getTargetHeros(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4)
	local var_29_0 = {}

	if arg_29_4 == ETargetType.Default then
		local var_29_1 = var_0_14(var_29_0, arg_29_2, var_0_15(arg_29_1:getFormationIndex()))

		if var_29_1 ~= nil then
			table.insert(var_29_0, var_29_1)
		else
			for iter_29_0, iter_29_1 in pairs(var_0_30) do
				local var_29_2 = var_0_13(var_29_0, arg_29_2, iter_29_1)

				if var_29_2 ~= nil then
					table.insert(var_29_0, var_29_2)

					break
				end
			end
		end
	elseif arg_29_4 == ETargetType.Random_1 then
		var_0_12(var_29_0, arg_29_2, 1)
	elseif arg_29_4 == ETargetType.Random_2 then
		var_0_12(var_29_0, arg_29_2, 2)
	elseif arg_29_4 == ETargetType.Random_3 then
		var_0_12(var_29_0, arg_29_2, 3)
	elseif arg_29_4 == ETargetType.Random_4 then
		var_0_12(var_29_0, arg_29_2, 4)
	elseif arg_29_4 == ETargetType.Random_5 then
		var_0_12(var_29_0, arg_29_2, 5)
	elseif arg_29_4 == ETargetType.Random_1_EXCLUDESELF then
		var_0_12(var_29_0, arg_29_2, 1)
	elseif arg_29_4 == ETargetType.Random_1_Died then
		var_0_12(var_29_0, arg_29_2, 1)
	elseif arg_29_4 == ETargetType.Self then
		table.insert(var_29_0, arg_29_1)
	elseif arg_29_4 == ETargetType.Condition_UpMinHp then
		var_0_18(var_29_0, arg_29_2)
	elseif arg_29_4 == ETargetType.Condition_UpMaxHp then
		var_0_19(var_29_0, arg_29_2)
	elseif arg_29_4 == ETargetType.Condition_MinHpPercent then
		var_0_17(var_29_0, arg_29_2)
	elseif arg_29_4 == ETargetType.Condition_MaxHp then
		var_0_16(var_29_0, arg_29_2)
	elseif arg_29_4 == ETargetType.Condition_MinMp then
		var_0_20(var_29_0, arg_29_2)
	elseif arg_29_4 == ETargetType.Condition_MaxMp then
		var_0_21(var_29_0, arg_29_2)
	elseif arg_29_4 == ETargetType.Condition_MinForce then
		var_0_22(var_29_0, arg_29_2)
	elseif arg_29_4 == ETargetType.Condition_MaxForce then
		var_0_23(var_29_0, arg_29_2)
	elseif arg_29_4 == ETargetType.Condition_MinIntelligence then
		var_0_24(var_29_0, arg_29_2)
	elseif arg_29_4 == ETargetType.Condition_MaxIntelligence then
		var_0_25(var_29_0, arg_29_2)
	elseif arg_29_4 == ETargetType.Condition_MinTili then
		var_0_26(var_29_0, arg_29_2)
	elseif arg_29_4 == ETargetType.Condition_MaxTili then
		var_0_27(var_29_0, arg_29_2)
	elseif arg_29_4 == ETargetType.Condition_MaxPhyAttack then
		var_0_28(var_29_0, arg_29_2)
	elseif arg_29_4 == ETargetType.Condition_MaxMagicAttack then
		var_0_29(var_29_0, arg_29_2)
	end

	return var_29_0
end

function zbTargetHandler.getSubTargetHeros(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = {}

	if arg_30_3 == ESubTargetType.All then
		table.insert(var_30_0, arg_30_2)
	elseif arg_30_3 == ESubTargetType.Row then
		var_30_0 = arg_30_0:rowHeros(arg_30_2)
	elseif arg_30_3 == ESubTargetType.Column then
		var_30_0 = arg_30_0:columnHeros(arg_30_2)
	elseif arg_30_3 == ESubTargetType.Ten then
		var_30_0 = arg_30_0:tenHeros(arg_30_2)
	end

	return var_30_0
end

function zbTargetHandler.rowHeros(arg_31_0, arg_31_1)
	local var_31_0 = {}
	local var_31_1 = arg_31_1:getFormationIndex()
	local var_31_2 = g_CombatSystem:getHeros(arg_31_1.forceType)

	for iter_31_0, iter_31_1 in pairs(var_31_2) do
		if iter_31_1:isDie() == false then
			local var_31_3 = iter_31_1:getFormationIndex()

			if var_0_9(var_0_0, var_31_1) and var_0_9(var_0_0, var_31_3) or var_0_9(var_0_1, var_31_1) and var_0_9(var_0_1, var_31_3) or var_0_9(var_0_2, var_31_1) and var_0_9(var_0_2, var_31_3) then
				table.insert(var_31_0, iter_31_1)
			end
		end
	end

	return var_31_0
end

function zbTargetHandler.columnHeros(arg_32_0, arg_32_1)
	local var_32_0 = {}

	if arg_32_1:isDie() == false then
		table.insert(var_32_0, arg_32_1)
	end

	local var_32_1 = arg_32_1:getFormationIndex()
	local var_32_2 = g_CombatSystem:getHeros(arg_32_1.forceType)

	for iter_32_0, iter_32_1 in pairs(var_32_2) do
		if iter_32_1:isDie() == false and iter_32_1:isSame(arg_32_1) == false then
			local var_32_3 = iter_32_1:getFormationIndex()

			if var_0_9(var_0_4, var_32_1) and var_0_9(var_0_4, var_32_3) or var_0_9(var_0_5, var_32_1) and var_0_9(var_0_5, var_32_3) or var_0_9(var_0_6, var_32_1) and var_0_9(var_0_6, var_32_3) then
				table.insert(var_32_0, iter_32_1)
			end
		end
	end

	return var_32_0
end

function zbTargetHandler.tenHeros(arg_33_0, arg_33_1)
	local var_33_0 = {}

	table.insert(var_33_0, arg_33_1)

	local var_33_1 = arg_33_1:getFormationIndex()
	local var_33_2 = var_0_7(var_33_1)
	local var_33_3 = var_0_8(var_33_1)
	local var_33_4 = g_CombatSystem:getHeros(arg_33_1.forceType)

	for iter_33_0, iter_33_1 in pairs(var_33_4) do
		if iter_33_1:isDie() == false then
			local var_33_5 = iter_33_1:getFormationIndex()
			local var_33_6 = var_0_7(var_33_5)
			local var_33_7 = var_0_8(var_33_5)

			if var_33_5 == var_33_1 - 1 and var_33_7 == var_33_3 or var_33_5 == var_33_1 + 1 and var_33_7 == var_33_3 or var_33_5 == var_33_1 - 3 and var_33_6 == var_33_2 or var_33_5 == var_33_1 + 3 and var_33_6 == var_33_2 then
				table.insert(var_33_0, iter_33_1)
			end
		end
	end

	return var_33_0
end
