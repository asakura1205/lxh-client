zbCombatFormula = class("zbCombatFormula")
zbCombatFormula.__index = zbCombatFormula

function zbCombatFormula.create(arg_1_0)
	local var_1_0 = zbCombatFormula.new()

	var_1_0:init()

	return var_1_0
end

function zbCombatFormula.init(arg_2_0)
	arg_2_0:setRandomSeed(os_timenow())
end

function zbCombatFormula.free(arg_3_0)
	return
end

function zbCombatFormula.calcDamage(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	if g_FirstCombat:isActive() then
		return g_FirstCombat:calcDamage(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	end

	if arg_4_0:calcImmune(arg_4_1, arg_4_2, arg_4_3) == true then
		echo(string.format("%s%s hit %s, immune damage", ForceTypeDesc[arg_4_1.forceType], arg_4_1.heroRecord.name, arg_4_2.heroRecord.name))

		return EDamageResult.Immune, 0, false
	end

	local var_4_0 = arg_4_0:calcViolent(arg_4_1, arg_4_2, arg_4_3)
	local var_4_1 = arg_4_0:calcUnhit(arg_4_1, arg_4_2, arg_4_3)

	if var_4_0 == false and var_4_1 == true then
		echo(string.format("%s%s unhit %s, make damage 0", ForceTypeDesc[arg_4_1.forceType], arg_4_1.heroRecord.name, arg_4_2.heroRecord.name))
		g_CombatBubble:showBubble(arg_4_2, ECombatBubble.Unhit, 0, 0, 0.8)
		arg_4_2:playDodgeAnimation()

		return EDamageResult.Unhit, 0, false
	elseif var_4_0 == true and var_4_1 == true then
		var_4_0 = false

		local var_4_2 = false
	end

	local var_4_3 = EDamageResult.Hit
	local var_4_4 = 0
	local var_4_5 = false
	local var_4_6 = arg_4_2:isDie()
	local var_4_7 = false
	local var_4_8 = false
	local var_4_9 = 0
	local var_4_10 = 0

	arg_4_2.lastAttacker = arg_4_1

	local var_4_11 = arg_4_0:calcStepBase(arg_4_1, arg_4_2, arg_4_3)
	local var_4_12 = arg_4_0:calcStepSkill(var_4_11, arg_4_1, arg_4_2, arg_4_3)
	local var_4_13 = var_4_12 * 5
	local var_4_14 = arg_4_0:calcStepShake(var_4_12)

	if var_4_0 then
		var_4_14 = arg_4_0:calcStepViolent(var_4_14, arg_4_1, arg_4_2, arg_4_3)
	end

	local var_4_15 = arg_4_0:calcTargetDebuffDamageAdd(var_4_14, arg_4_1, arg_4_2, arg_4_3)
	local var_4_16 = arg_4_0:calcReduce(var_4_15, arg_4_1, arg_4_2, arg_4_3)
	local var_4_17 = var_4_16
	local var_4_18 = arg_4_0:calcShieldDefend(var_4_16, arg_4_1, arg_4_2, arg_4_3)

	if var_4_17 - var_4_18 > 1 then
		var_4_10 = math.max(var_4_17 - var_4_18, 0)
	end

	local var_4_19 = arg_4_0:calcRoundShieldDefend(var_4_18, arg_4_1, arg_4_2, arg_4_3)
	local var_4_20 = arg_4_0:calcFanTan(var_4_19, arg_4_1, arg_4_2, arg_4_3)
	local var_4_21 = arg_4_0:calcExtraDamage(var_4_20, arg_4_1, arg_4_2, arg_4_3)

	if arg_4_2.maxDamageHpPercentEnable then
		var_4_21 = math.min(var_4_21, arg_4_2.maxHp * arg_4_2.maxDamageHpPercent)
	end

	local var_4_22 = arg_4_0:calcPvPPowerAdd(var_4_21, arg_4_1, arg_4_2)
	local var_4_23 = math.ceil(var_4_22)

	if var_4_0 then
		var_4_3 = EDamageResult.Violent

		echo(string.format("%s%s attack %s, make violent damage: %d", ForceTypeDesc[arg_4_1.forceType], arg_4_1.heroRecord.name, arg_4_2.heroRecord.name, var_4_23))
	else
		var_4_3 = EDamageResult.Hit

		echo(string.format("%s%s attack %s, make normal damage: %d", ForceTypeDesc[arg_4_1.forceType], arg_4_1.heroRecord.name, arg_4_2.heroRecord.name, var_4_23))
	end

	if var_4_13 < var_4_23 and arg_4_2:isBigBoss() then
		var_4_23 = var_4_13
	end

	arg_4_1:addDamageStat(var_4_23)

	if var_4_23 > 0 then
		arg_4_3:addHitedTarget(arg_4_2)

		arg_4_3.thisRoundHitCount = arg_4_3.thisRoundHitCount + 1

		local var_4_24 = arg_4_1:getQteEvalDamage()

		if var_4_24 > 1 then
			var_4_23 = var_4_23 * var_4_24
		end

		local var_4_25 = math.max(math.ceil(var_4_23 / arg_4_2.maxHp * 100), 2)

		arg_4_2:addMp(var_4_25)

		local var_4_26 = arg_4_0:getDamageBubbleType(arg_4_1, arg_4_2, var_4_3)

		arg_4_2:addHp(-var_4_23, var_4_0, arg_4_3.hitBubbleCount, arg_4_4, arg_4_3.hitBubbleInterval, var_4_10)
		g_CombatSystem.combatData.combatQte:checkQte(arg_4_1, arg_4_2, arg_4_3, var_4_23)

		arg_4_3.hitTargeted = true

		local var_4_27 = zbAvatarSoundTable:getAttackSoundRecord(arg_4_1.avatarRecord.parentAvatarId, arg_4_3.skillSeqIndex)

		if var_4_27 ~= nil then
			g_Audio:playSound(var_4_27.attackSound)
		end
	end

	if var_4_6 == false and arg_4_2:isDie() then
		local var_4_28 = g_CombatSystem:getCombatType()

		if arg_4_1.forceType == ForceType.Left or g_CombatSystem:isPvPCombatType() then
			g_CombatBubble:showBubble(arg_4_1, ECombatBubble.KillMpBack, 0, 0, 1)
		end

		local var_4_29 = 30

		arg_4_1:addMp(var_4_29)

		var_4_7 = true

		for iter_4_0, iter_4_1 in pairs(arg_4_1.skillList) do
			if iter_4_1.passiveTriggerType == EPassiveTriggerType.killTarget then
				iter_4_1:execSkill()
			end
		end
	end

	if var_4_7 == false then
		arg_4_0:calcDamage2Cure(var_4_23, arg_4_1, arg_4_2, arg_4_3)
	end

	return var_4_3, var_4_23, var_4_7
end

function zbCombatFormula.calcImmune(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_2:isImmunePhysic() and arg_5_2:isImmuneMagic() then
		g_CombatBubble:showBubble(arg_5_2, ECombatBubble.ImmuneAll, 0, 0, 0.8)

		return true
	end

	if arg_5_1.heroRecord.attackType == EAttackType.Physic and arg_5_2:isImmunePhysic() then
		g_CombatBubble:showBubble(arg_5_2, ECombatBubble.ImmunePhysic, 0, 0, 0.8)

		return true
	end

	if arg_5_1.heroRecord.attackType == EAttackType.Magic and arg_5_2:isImmuneMagic() then
		g_CombatBubble:showBubble(arg_5_2, ECombatBubble.ImmuneMagic, 0, 0, 0.8)

		return true
	end

	return false
end

function zbCombatFormula.calcViolent(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_1.forceType == ForceType.Right and g_CombatSystem:isPvPCombatType() == false then
		return false
	end

	local var_6_0 = (arg_6_1.violent - arg_6_2.tough) * 1000 / math.max(100 + 10 * arg_6_2:getLevel(), 600)
	local var_6_1 = zbUtil:clamp(var_6_0, 50, 350)

	if g_CombatSystem.combatData.isRecordPlay then
		local var_6_2 = var_6_1

		var_6_1 = zbUtil:clamp(var_6_1 + arg_6_1.recordExtraViolent, 50, 900)
	end

	return arg_6_0:isSucceedRate(var_6_1)
end

function zbCombatFormula.calcUnhit(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_2.forceType == ForceType.Right and g_CombatSystem:isPvPCombatType() == false then
		return false
	end

	local var_7_0 = (arg_7_2.dodge - arg_7_1.hit) * 1000 / math.max(100 + 10 * arg_7_1:getLevel(), 600)
	local var_7_1 = zbUtil:clamp(var_7_0, 50, 350)

	if g_CombatSystem.combatData.isRecordPlay then
		local var_7_2 = var_7_1

		var_7_1 = zbUtil:clamp(var_7_1 + arg_7_2.recordExtraDodge, 100, 950)
	end

	return arg_7_0:isSucceedRate(var_7_1)
end

function zbCombatFormula.calcStepBase(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = 0
	local var_8_1 = arg_8_1.physicAttack
	local var_8_2 = arg_8_2.physicDefend

	if arg_8_1.heroRecord.attackType == EAttackType.Magic then
		var_8_1 = arg_8_1.magicAttack
		var_8_2 = arg_8_2.magicDefend
	end

	if var_8_1 > var_8_2 * 0.6 then
		var_8_0 = var_8_1 - var_8_2
	else
		echo(a2u("warning: 11111111111111111: \xC6Ʒ\xC0"))

		var_8_0 = var_8_1 * var_8_1 / (var_8_2 * 4.25)
	end

	local var_8_3 = 1 + (arg_8_1.pierceDamage - arg_8_1.block) / (100 + 10 * arg_8_2:getLevel())
	local var_8_4 = var_8_0 * zbUtil:clamp(var_8_3, 0.8, 1.25) / arg_8_3:getReduceHitCount()

	return (math.max(var_8_4, 1))
end

function zbCombatFormula.calcStepSkill(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = arg_9_1
	local var_9_1 = arg_9_4:getDamagePercent(arg_9_3)
	local var_9_2 = arg_9_4:getDamageAbs(arg_9_3)

	if arg_9_3:isZhongshang() then
		var_9_1 = var_9_1 + arg_9_2.zhongshangTargetDamageAddPercent
		var_9_2 = var_9_2 + arg_9_2.zhongshangTargetDamageAddAbs
	end

	if arg_9_3:isZhongdu() then
		var_9_1 = var_9_1 + arg_9_2.zhongduTargetDamageAddPercent
		var_9_2 = var_9_2 + arg_9_2.zhongduTargetDamageAddAbs
	end

	if arg_9_4.skillSeqIndex == 0 then
		local var_9_3
		local var_9_4 = g_CombatSystem:getHeros(arg_9_2.forceType, true)

		for iter_9_0, iter_9_1 in pairs(var_9_4) do
			if iter_9_1.jiuxianPutongDamageAddRatio > 0 then
				var_9_3 = iter_9_1

				break
			end
		end

		local var_9_5 = 0
		local var_9_6 = 0

		if var_9_3 ~= nil then
			var_9_5 = var_9_3.jiuxianPutongDamageAddRatio
			var_9_6 = var_9_3.jiuxianPutongDamageAddAbs
		end

		var_9_0 = var_9_0 * (var_9_1 + var_9_5) + (var_9_2 + var_9_6) / arg_9_4:getReduceHitCount()
	else
		var_9_0 = var_9_0 * var_9_1 + var_9_2 / arg_9_4:getReduceHitCount()
	end

	return var_9_0
end

function zbCombatFormula.calcStepShake(arg_10_0, arg_10_1)
	return arg_10_1 * arg_10_0:randomRange(0.95, 1.05)
end

function zbCombatFormula.calcStepViolent(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	return arg_11_1 * 2
end

function zbCombatFormula.calcTargetDebuffDamageAdd(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if arg_12_3:isHunmi() or arg_12_3:isMeihuo() or arg_12_3:isChenmo() then
		local var_12_0 = arg_12_1 * (1 + arg_12_2.targetDebuffDamageAddRatio) + arg_12_2.targetDebuffDamageAddAbs / arg_12_4:getReduceHitCount()
		local var_12_1 = math.max(var_12_0, 1)

		if arg_12_2.targetDebuffDamageAddRatio > 0 and arg_12_2.targetDebuffDamageAddSkill ~= nil then
			arg_12_2.targetDebuffDamageAddSkill:popupSkillBubble()
		end

		return var_12_1
	else
		return arg_12_1
	end
end

function zbCombatFormula.calcReduce(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	if arg_13_2.heroRecord.attackType == EAttackType.Physic then
		local var_13_0 = arg_13_3:getPhysicReduce() / arg_13_4:getReduceHitCount()

		if var_13_0 > 0 then
			arg_13_1 = math.max(arg_13_1 - var_13_0, arg_13_1 * 0.2)

			g_CombatBubble:showBubble(arg_13_3, ECombatBubble.JianMian, 0, 0.25, 0.8)
		end
	end

	if arg_13_2.heroRecord.attackType == EAttackType.Magic then
		local var_13_1 = arg_13_3:getMagicReduce() / arg_13_4:getReduceHitCount()

		if var_13_1 > 0 then
			arg_13_1 = math.max(arg_13_1 - var_13_1, arg_13_1 * 0.2)

			g_CombatBubble:showBubble(arg_13_3, ECombatBubble.JianMian, 0, 0.25, 0.8)
		end
	end

	if arg_13_3:isCanPMReduce() then
		arg_13_1 = math.max(arg_13_1 * (1 - arg_13_3:getPMReduceRatio()) - arg_13_3:getPMReduceAbs() / arg_13_4:getReduceHitCount(), arg_13_1 * 0.2)

		if arg_13_3.pmReduceSkill ~= nil then
			arg_13_3.pmReduceSkill:popupSkillBubble(0.15)
			g_CombatBubble:showBubble(arg_13_3, ECombatBubble.JianMian, 0, 0.25, 0.8)
		end
	end

	if arg_13_2:isZhongshang() and arg_13_0:isSucceedRate(arg_13_3.zhongshangTargetReduceRate * 1000) then
		arg_13_1 = math.max(arg_13_1 * (1 - arg_13_3.zhongshangTargetReduceRatio) - arg_13_3.zhongshangTargetReduceAbs / arg_13_4:getReduceHitCount(), 1)

		g_CombatBubble:showBubble(arg_13_3, ECombatBubble.JianMian, 0, 0.25, 0.8)
	end

	arg_13_1 = math.max(arg_13_1, 1)

	return arg_13_1
end

function zbCombatFormula.calcShieldDefend(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	local var_14_0 = arg_14_3:useDamageShield(arg_14_1, arg_14_2.heroRecord.attackType)

	if arg_14_1 - var_14_0 > 0 then
		g_CombatBubble:showBubble(arg_14_3, ECombatBubble.XiShou, 0, 0, 1)
	end

	return var_14_0
end

function zbCombatFormula.calcRoundShieldDefend(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_0 = arg_15_1

	if arg_15_3.roundReduceEnable then
		var_15_0 = math.max(var_15_0 * (1 - arg_15_3.roundReduceRatio) - arg_15_3.roundReduceAbs / arg_15_4:getReduceHitCount(), 1)

		g_CombatBubble:showBubble(arg_15_3, ECombatBubble.JianMian, 0, 0, 1)
	end

	return var_15_0
end

function zbCombatFormula.calcFanTan(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	if arg_16_0:isSucceedRate(arg_16_3.fanTanRate * 1000) then
		local var_16_0 = arg_16_1 * arg_16_3.fanTanPercent + arg_16_3.fanTanAbs / arg_16_4:getReduceHitCount()

		arg_16_2:addHp(-var_16_0, false, 1)

		if arg_16_3.fanTanControlBuffId ~= 0 then
			g_BuffSystem:createControlBuff(arg_16_3, arg_16_2, arg_16_3.fanTanControlBuffId)
		end

		g_CombatBubble:showBubble(arg_16_3, ECombatBubble.FanTan, 0, 0, 1)
	end

	return arg_16_1
end

function zbCombatFormula.calcExtraDamage(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0 = arg_17_1

	if arg_17_2.heroRecord.attackType == EAttackType.Physic then
		var_17_0 = var_17_0 + var_17_0 * (arg_17_2.extraPhysicDamageRatio - (1 - arg_17_3.extraPhysicDamageDefendRatio)) + (arg_17_2.extraPhysicDamageAbs - arg_17_3.extraPhysicDamageDefendAbs) / arg_17_4.damageSectionCount
	else
		var_17_0 = var_17_0 + var_17_0 * (arg_17_2.extraMagicDamageRatio - (1 - arg_17_3.extraMagicDamageDefendRatio)) + (arg_17_2.extraMagicDamageAbs - arg_17_3.extraMagicDamageDefendAbs) / arg_17_4.damageSectionCount
	end

	return (math.max(var_17_0, 1))
end

function zbCombatFormula.calcDamage2Cure(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	if arg_18_3.damage2CureSkill ~= nil and arg_18_0:isSucceedRate(arg_18_3.damage2CureRate * 1000) then
		if arg_18_3.damage2CureSkill.getCureValue ~= nil then
			local var_18_0 = arg_18_3.damage2CureSkill:getCureValue() / arg_18_4:getReduceHitCount()

			if var_18_0 > 0 then
				local var_18_1 = 1

				arg_18_3.damage2CureSkill:popupSkillBubble(var_18_1)
				arg_18_3:addHp(var_18_0, false, 1, var_18_1)
			end
		else
			echo("warning: target.damage2CureSkill:getCureValue == nil")
		end
	end
end

function zbCombatFormula.calcPvPPowerAdd(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = arg_19_1

	if g_CombatSystem:isPvPCombatType() and arg_19_2.forceType ~= arg_19_3.forceType and arg_19_2.fv > arg_19_3.fv then
		var_19_0 = var_19_0 * 1.1
	end

	return var_19_0
end

function zbCombatFormula.setRandomSeed(arg_20_0, arg_20_1)
	arg_20_0.randomSeed = arg_20_1

	zbGlobalUtil:RandomSeed(arg_20_1)
end

function zbCombatFormula.getRandomSeed(arg_21_0)
	return arg_21_0.randomSeed
end

function zbCombatFormula.isSucceedRate(arg_22_0, arg_22_1)
	if arg_22_1 <= 0 then
		return false
	elseif arg_22_1 >= 1000 then
		return true
	end

	return arg_22_1 >= zbGlobalUtil:RandomRange() * 10 % 1000
end

function zbCombatFormula.randomRange(arg_23_0, arg_23_1, arg_23_2)
	return arg_23_1 + zbGlobalUtil:RandomRange() / (1 / (arg_23_2 - arg_23_1) * 100)
end

function zbCombatFormula.getDamageBubbleType(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = ECombatBubble.Unknown

	if arg_24_3 == EDamageResult.Immune then
		if arg_24_1.heroRecord.attackType == EAttackType.Physic then
			var_24_0 = ECombatBubble.PhyImmune
		else
			var_24_0 = ECombatBubble.MagicImmune
		end
	elseif arg_24_3 == EDamageResult.Unhit then
		var_24_0 = ECombatBubble.Unhit
	elseif arg_24_3 == EDamageResult.Hit then
		if arg_24_2.forceType == ForceType.Left then
			var_24_0 = ECombatBubble.SelfDecHp
		else
			var_24_0 = ECombatBubble.EnemyDecHp
		end
	elseif arg_24_3 == EDamageResult.Violent then
		if arg_24_2.forceType == ForceType.Left then
			var_24_0 = ECombatBubble.SelfViolentDecHp
		else
			var_24_0 = ECombatBubble.EnemyViolentDecHp
		end
	end

	return var_24_0
end
