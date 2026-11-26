zbCombatFormulaCure = class("zbCombatFormulaCure")
zbCombatFormulaCure.__index = zbCombatFormulaCure

function zbCombatFormulaCure.create(arg_1_0)
	local var_1_0 = zbCombatFormulaCure.new()

	var_1_0:init()

	return var_1_0
end

function zbCombatFormulaCure.init(arg_2_0)
	return
end

function zbCombatFormulaCure.free(arg_3_0)
	return
end

function zbCombatFormulaCure.calcCure(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	local var_4_0 = 0
	local var_4_1 = false

	if arg_4_5 == nil then
		arg_4_5 = 1
	end

	local var_4_2 = arg_4_0:calcStepBase(arg_4_1, arg_4_3) * arg_4_3:getDamageRatio() + arg_4_3:getDamageAbs()
	local var_4_3 = arg_4_0:calcStepShake(var_4_2, arg_4_1, arg_4_3)
	local var_4_4 = math.ceil(var_4_3)
	local var_4_5 = arg_4_0:getCureBubbleType(arg_4_2, var_4_1)

	arg_4_2:addHp(var_4_4, var_4_1, arg_4_5, arg_4_4)

	return var_4_1, var_4_4
end

function zbCombatFormulaCure.calcStepBase(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1.heroRecord.attackType == EAttackType.Physic then
		return arg_5_1.physicAttack
	else
		return arg_5_1.magicAttack
	end
end

function zbCombatFormulaCure.calcStepShake(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	return arg_6_1 * g_CombatFormula:randomRange(0.95, 1.05)
end

function zbCombatFormulaCure.calcStepViolent(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_1
	local var_7_1 = g_CombatFormula:isSucceedRate(50)

	if var_7_1 then
		var_7_0 = var_7_0 * 2
	end

	return var_7_1, var_7_0
end

function zbCombatFormulaCure.getCureBubbleType(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = ECombatBubble.Unknown

	if arg_8_2 then
		if arg_8_1.forceType == ForceType.Left then
			var_8_0 = ECombatBubble.SelfViolentAddHp
		else
			var_8_0 = ECombatBubble.EnemyViolentAddHp
		end
	elseif arg_8_1.forceType == ForceType.Left then
		var_8_0 = ECombatBubble.SelfAddHp
	else
		var_8_0 = ECombatBubble.EnemyAddHp
	end

	return var_8_0
end
