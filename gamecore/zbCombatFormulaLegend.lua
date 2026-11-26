zbCombatFormulaLegend = class("zbCombatFormulaLegend")
zbCombatFormulaLegend.__index = zbCombatFormulaLegend

function zbCombatFormulaLegend.create(arg_1_0)
	local var_1_0 = zbCombatFormulaLegend.new()

	var_1_0:init()

	return var_1_0
end

function zbCombatFormulaLegend.init(arg_2_0)
	return
end

function zbCombatFormulaLegend.free(arg_3_0)
	return
end

function zbCombatFormulaLegend.calcLegendDamage(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if g_FirstCombat:isActive() then
		return g_FirstCombat:calcLegendDamage(arg_4_1, arg_4_2, arg_4_3)
	end

	if arg_4_0:calcImmune(arg_4_1, arg_4_2) == true then
		echo(string.format("legend hit %s, immune damage", arg_4_1.heroRecord.name))

		return 0
	end

	local var_4_0 = 0
	local var_4_1 = false
	local var_4_2 = arg_4_3
	local var_4_3 = arg_4_0:calcStepShake(var_4_2)
	local var_4_4 = arg_4_0:calcReduce(arg_4_1, arg_4_2, var_4_3)
	local var_4_5 = arg_4_0:calcShieldDefend(arg_4_1, arg_4_2, var_4_4)
	local var_4_6 = math.ceil(var_4_5)

	if var_4_6 > 0 then
		arg_4_1:addHp(-var_4_6, false, 1)

		local var_4_7 = math.max(math.ceil(var_4_6 / arg_4_1.maxHp * 100), 2)

		arg_4_1:addMp(var_4_7)
	end

	if arg_4_1:isDie() == false then
		arg_4_0:calcDamage2Cure(arg_4_1, arg_4_2, var_4_6)
	end

	echo(string.format("legend attack %s, make normal damage: %d", arg_4_1.heroRecord.name, var_4_6))

	return var_4_6
end

function zbCombatFormulaLegend.calcImmune(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_2 == EAttackType.Physic and arg_5_1:isImmunePhysic() then
		g_CombatBubble:showBubble(arg_5_1, ECombatBubble.ImmunePhysic, 0, 0, 0.8)

		return true
	end

	if arg_5_2 == EAttackType.Magic and arg_5_1:isImmuneMagic() then
		g_CombatBubble:showBubble(arg_5_1, ECombatBubble.ImmuneMagic, 0, 0, 0.8)

		return true
	end

	return false
end

function zbCombatFormulaLegend.calcStepShake(arg_6_0, arg_6_1)
	return arg_6_1 * arg_6_0:randomRange(0.95, 1.05)
end

function zbCombatFormulaLegend.calcReduce(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_2 == EAttackType.Physic then
		local var_7_0 = arg_7_1:getPhysicReduce()

		if var_7_0 > 0 then
			arg_7_3 = math.max(arg_7_3 - var_7_0, 1)

			g_CombatBubble:showBubble(arg_7_1, ECombatBubble.JianMian, 0, 0, 0.8)
		end
	end

	if arg_7_2 == EAttackType.Magic then
		local var_7_1 = arg_7_1:getMagicReduce()

		if var_7_1 > 0 then
			arg_7_3 = math.max(arg_7_3 - var_7_1, 1)

			g_CombatBubble:showBubble(arg_7_1, ECombatBubble.JianMian, 0, 0, 0.8)
		end
	end

	if arg_7_1:isCanPMReduce() then
		arg_7_3 = math.max(arg_7_3 * (1 - arg_7_1:getPMReduceRatio()) - arg_7_1:getPMReduceAbs(), arg_7_3 * 0.2)

		if arg_7_1.pmReduceSkill ~= nil then
			arg_7_1.pmReduceSkill:popupSkillBubble(0.15)
			g_CombatBubble:showBubble(arg_7_1, ECombatBubble.JianMian, 0, 0.25, 0.8)
		end
	end

	return arg_7_3
end

function zbCombatFormulaLegend.calcShieldDefend(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_2 ~= EAttackType.Physic and arg_8_2 ~= EAttackType.Magic then
		return arg_8_3
	end

	local var_8_0 = arg_8_1:useDamageShield(arg_8_3, arg_8_2)

	if arg_8_3 - var_8_0 > 0 then
		g_CombatBubble:showBubble(arg_8_1, ECombatBubble.XiShou, 0, 0, 1)
	end

	return var_8_0
end

function zbCombatFormulaLegend.calcDamage2Cure(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_1.damage2CureSkill ~= nil and arg_9_0:isSucceedRate(arg_9_1.damage2CureRate * 1000) then
		if arg_9_1.damage2CureSkill.getCureValue ~= nil then
			local var_9_0 = arg_9_1.damage2CureSkill:getCureValue()

			if var_9_0 > 0 then
				local var_9_1 = 1

				arg_9_1.damage2CureSkill:popupSkillBubble(var_9_1)
				arg_9_1:addHp(var_9_0, false, 1, var_9_1)
			end
		else
			echo("warning: target.damage2CureSkill:getCureValue == nil")
		end
	end
end

function zbCombatFormulaLegend.isSucceedRate(arg_10_0, arg_10_1)
	return arg_10_1 >= zbGlobalUtil:RandomRange() * 10 % 1000
end

function zbCombatFormulaLegend.randomRange(arg_11_0, arg_11_1, arg_11_2)
	return arg_11_1 + zbGlobalUtil:RandomRange() / (1 / (arg_11_2 - arg_11_1) * 100)
end

function zbCombatFormulaLegend.getDamageBubbleType(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = ECombatBubble.Unknown

	if arg_12_2 == EDamageResult.Immune then
		if arg_12_0.skillRecord.attackType == EAttackType.Physic then
			var_12_0 = ECombatBubble.PhyImmune
		else
			var_12_0 = ECombatBubble.MagicImmune
		end
	elseif arg_12_2 == EDamageResult.Unhit then
		var_12_0 = ECombatBubble.Unhit
	elseif arg_12_2 == EDamageResult.Hit then
		if arg_12_1.forceType == ForceType.Left then
			var_12_0 = ECombatBubble.SelfDecHp
		else
			var_12_0 = ECombatBubble.EnemyDecHp
		end
	elseif arg_12_2 == EDamageResult.Violent then
		if arg_12_1.forceType == ForceType.Left then
			var_12_0 = ECombatBubble.SelfViolentDecHp
		else
			var_12_0 = ECombatBubble.EnemyViolentDecHp
		end
	end

	return var_12_0
end
