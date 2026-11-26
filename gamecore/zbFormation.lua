zbFormation = class("zbFormation")
zbFormation.__index = zbFormation

local var_0_0 = 9

function createFormation()
	local var_1_0 = zbFormation.new()

	var_1_0:init()

	return var_1_0
end

function zbFormation.init(arg_2_0)
	arg_2_0.godId = 0
	arg_2_0.techId = 0
	arg_2_0.slots = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
end

function zbFormation.reset(arg_3_0)
	arg_3_0.godId = 0
	arg_3_0.techId = 0
	arg_3_0.slots = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
end

function zbFormation.remove(arg_4_0, arg_4_1)
	arg_4_0.slots[arg_4_1] = 0

	arg_4_0:refreshFormationId()
end

function zbFormation.removeHero(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.slots) do
		if iter_5_1 == arg_5_1 then
			arg_5_0.slots[iter_5_0] = 0
		end
	end

	arg_5_0:refreshFormationId()
end

function zbFormation.replace(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0.slots[arg_6_1] == nil then
		return
	end

	for iter_6_0, iter_6_1 in pairs(arg_6_0.slots) do
		if iter_6_0 ~= arg_6_1 and iter_6_1 == arg_6_2 then
			arg_6_0.slots[iter_6_0] = 0
		end
	end

	arg_6_0.slots[arg_6_1] = arg_6_2

	arg_6_0:refreshFormationId()
end

function zbFormation.replaceSlots(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in pairs(arg_7_1) do
		arg_7_0.slots[iter_7_0] = iter_7_1
	end

	arg_7_0:refreshFormationId()
end

function zbFormation.exchange(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_0.slots[arg_8_1] == nil or arg_8_0.slots[arg_8_2] == nil then
		return
	end

	local var_8_0 = arg_8_0.slots[arg_8_2]

	arg_8_0.slots[arg_8_2] = arg_8_3
	arg_8_0.slots[arg_8_1] = var_8_0

	arg_8_0:refreshFormationId()
end

function zbFormation.isEmpty(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.slots) do
		if iter_9_0 <= var_0_0 and g_Self.kHeroHandler:getHeroByTemplateId(iter_9_1) ~= nil then
			return false
		end
	end

	return true
end

function zbFormation.getWorkingHeroCount(arg_10_0)
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in pairs(arg_10_0.slots) do
		if iter_10_0 <= var_0_0 and g_Self.kHeroHandler:getHeroByTemplateId(iter_10_1) ~= nil then
			var_10_0 = var_10_0 + 1
		end
	end

	return var_10_0
end

function zbFormation.getWorkingHero(arg_11_0)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs(arg_11_0.slots) do
		if iter_11_0 <= var_0_0 and g_Self.kHeroHandler:getHeroByTemplateId(iter_11_1) ~= nil then
			local var_11_1 = g_Self.kHeroHandler:getHeroByTemplateId(iter_11_1)

			table.insert(var_11_0, var_11_1.HeroBaseInfo)
		end
	end

	return var_11_0
end

function zbFormation.isWorking(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.slots) do
		if iter_12_0 <= var_0_0 and arg_12_1 == iter_12_1 then
			return true
		end
	end

	return false
end

function zbFormation.isPartner(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.slots) do
		if iter_13_0 > var_0_0 and arg_13_1 == iter_13_1 then
			return true
		end
	end

	return false
end

function zbFormation.canPartner(arg_14_0, arg_14_1)
	if arg_14_0.slots[arg_14_1] == nil then
		return false
	end

	local var_14_0 = arg_14_1 - var_0_0

	if var_14_0 <= 0 then
		return false
	end

	return g_Self.kTechHandler:parterEnableByPos(var_14_0)
end

function zbFormation.getFirstHeroId(arg_15_0)
	local var_15_0

	for iter_15_0, iter_15_1 in pairs(arg_15_0.slots) do
		if iter_15_0 <= var_0_0 and g_Self.kHeroHandler:getHeroByTemplateId(iter_15_1) ~= nil then
			var_15_0 = iter_15_1
		end
	end

	return var_15_0
end

function zbFormation.isInFormation(arg_16_0, arg_16_1)
	for iter_16_0 = 1, 12 do
		if arg_16_0.slots[iter_16_0] == arg_16_1 and arg_16_1 > 0 then
			return true
		end
	end

	return false
end

function zbFormation.getEmptyPosIndex(arg_17_0)
	for iter_17_0 = 2, 9 do
		if arg_17_0.slots[iter_17_0] == 0 then
			return iter_17_0
		end
	end

	return 1
end

function zbFormation.getEmptyFormationPosIndex(arg_18_0, arg_18_1)
	for iter_18_0 = 2, 9 do
		if arg_18_1[iter_18_0] == 1 and arg_18_0.slots[iter_18_0] == 0 then
			return iter_18_0
		end
	end

	return 1
end

function zbFormation.refreshFormationId(arg_19_0)
	arg_19_0.techId = arg_19_0:checkMatchFormationId()
end

function zbFormation.checkMatchFormationId(arg_20_0)
	local function var_20_0(arg_21_0)
		return arg_21_0 ~= 0 and arg_21_0 ~= -1
	end

	local function var_20_1(arg_22_0)
		local var_22_0 = FormationSlots[arg_22_0]

		if var_22_0 ~= nil then
			for iter_22_0, iter_22_1 in pairs(var_22_0) do
				if var_20_0(arg_20_0.slots[iter_22_0]) ~= var_20_0(iter_22_1) then
					return false
				end
			end
		else
			echo("warning: invalid formationId: " .. arg_22_0)

			return false
		end

		return true
	end

	if arg_20_0:getWorkingHeroCount() < 5 then
		return 0
	end

	for iter_20_0, iter_20_1 in pairs(FormationSlots) do
		if var_20_1(iter_20_0) then
			echo("check math formation: " .. iter_20_0)

			return iter_20_0
		end
	end

	return 0
end

function zbFormation.getCombatPower(arg_23_0)
	return g_GameData.Formation.FV
end

function zbFormation.getPartPropertyAdd(arg_24_0, arg_24_1)
	local var_24_0 = ""

	if g_Self.kTechHandler:parterEnableByPos(arg_24_1) == false then
		if arg_24_1 == 1 then
			var_24_0 = "\xB9\xA5\xBB\xF7λ:δ\xBD\xE2\xCB\xF8"
		elseif arg_24_1 == 2 then
			var_24_0 = "\xB7\xC0\xD3\xF9λ:δ\xBD\xE2\xCB\xF8"
		elseif arg_24_1 == 3 then
			var_24_0 = "\xC9\xFA\xB4\xE6λ:δ\xBD\xE2\xCB\xF8"
		end

		return a2u(var_24_0)
	end

	local var_24_1 = arg_24_0.slots[arg_24_1 + 9]

	if var_24_1 == nil then
		return a2u(var_24_0)
	end

	local var_24_2 = g_Self.kHeroHandler:getHeroByTemplateId(var_24_1)

	if var_24_2 == nil then
		if arg_24_1 == 1 then
			var_24_0 = "\xB9\xA5\xBB\xF7λ:δ\xC9\xCF\xD5\xF3"
		elseif arg_24_1 == 2 then
			var_24_0 = "\xB7\xC0\xD3\xF9λ:δ\xC9\xCF\xD5\xF3"
		elseif arg_24_1 == 3 then
			var_24_0 = "\xC9\xFA\xB4\xE6λ:δ\xC9\xCF\xD5\xF3"
		end

		return a2u(var_24_0)
	end

	local var_24_3 = zbHeroTable:getRecord(var_24_2.HeroBaseInfo.TemplateId)

	if var_24_3 == nil then
		return a2u(var_24_0)
	end

	local var_24_4 = zbHeroHelper:getHeroAttributeTable(var_24_2)
	local var_24_5 = ""
	local var_24_6 = var_24_2.HeroBaseInfo.FV
	local var_24_7 = g_Self.kTechHandler:getParterTechLevelByPos(arg_24_1)

	if arg_24_1 == 1 then
		var_24_5 = "\xB9\xA5\xBB\xF7λ:ȫ\xCC幥\xBB\xF7+"
	elseif arg_24_1 == 2 then
		var_24_5 = "\xB7\xC0\xD3\xF9λ:ȫ\xCC\xE5\xB7\xC0\xD3\xF9+"
	elseif arg_24_1 == 3 then
		var_24_5 = "\xC9\xFA\xB4\xE6λ:ȫ\xCC\xE5Ѫ\xC1\xBF+"
	end

	local var_24_8 = zbTechTable:getParterTechRecord(arg_24_1)

	if var_24_8 ~= nil then
		var_24_0 = a2u(var_24_5) .. math.ceil(var_24_6 * (var_24_8.attrBase1 + var_24_7 * var_24_8.attrGrowth1)) .. "  (" .. var_24_3.name .. ")"
	end

	return var_24_0
end

function zbFormation.hasEmptyParter(arg_25_0)
	return g_Self.kTechHandler:parterEnableByPos(EParterAttrType.Attack) and arg_25_0.slots[EParterAttrType.Attack + 9] == 0 or g_Self.kTechHandler:parterEnableByPos(EParterAttrType.Defend) and arg_25_0.slots[EParterAttrType.Defend + 9] == 0 or g_Self.kTechHandler:parterEnableByPos(EParterAttrType.HP) and arg_25_0.slots[EParterAttrType.HP + 9] == 0
end

function zbFormation.getEmptyParterCount(arg_26_0)
	local var_26_0 = 0

	if g_Self.kTechHandler:parterEnableByPos(EParterAttrType.Attack) and arg_26_0.slots[EParterAttrType.Attack + 9] == 0 then
		var_26_0 = var_26_0 + 1
	end

	if g_Self.kTechHandler:parterEnableByPos(EParterAttrType.Defend) and arg_26_0.slots[EParterAttrType.Defend + 9] == 0 then
		var_26_0 = var_26_0 + 1
	end

	if g_Self.kTechHandler:parterEnableByPos(EParterAttrType.HP) and arg_26_0.slots[EParterAttrType.HP + 9] == 0 then
		var_26_0 = var_26_0 + 1
	end

	return var_26_0
end

function zbFormation.updateServerFormation(arg_27_0, arg_27_1, arg_27_2)
	g_GameData.Formation = arg_27_1

	local var_27_0 = 0

	if zbUtil:isValidTable(arg_27_2) then
		var_27_0 = arg_27_2.GodId
	end

	local var_27_1 = arg_27_0.godId == var_27_0
	local var_27_2 = arg_27_0.techId == arg_27_1.TechId
	local var_27_3 = true
	local var_27_4 = table.getn(arg_27_0.slots)

	for iter_27_0 = 1, var_27_4 do
		if arg_27_0.slots[iter_27_0] ~= arg_27_1.Layout[iter_27_0] then
			var_27_3 = false

			break
		end
	end

	if var_27_1 == false or var_27_2 == false or var_27_3 == false then
		arg_27_0.godId = var_27_0
		arg_27_0.techId = arg_27_1.TechId

		if zbUtil:isValidTable(arg_27_1.Layout) then
			for iter_27_1 = 1, 12 do
				if arg_27_1.Layout[iter_27_1] ~= nil then
					arg_27_0.slots[iter_27_1] = arg_27_1.Layout[iter_27_1]
				else
					arg_27_0.slots[iter_27_1] = 0
				end
			end
		else
			for iter_27_2 = 1, 12 do
				arg_27_0.slots[iter_27_2] = 0
			end
		end
	end

	g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_Formation)
	g_Self.kRedPointHandler:refreshFormation()
end

function zbFormation.save(arg_28_0)
	g_WsMsgHandler:WS_Formation_Save_Req(arg_28_0.techId, arg_28_0.godId, arg_28_0.slots)
end

function zbFormation.print(arg_29_0)
	for iter_29_0, iter_29_1 in pairs(arg_29_0.slots) do
		echo("zbFormation:print: index=" .. iter_29_0 .. ", id=" .. iter_29_1)
	end
end
