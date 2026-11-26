require("gamecore.zbHero")

zbCombatRoundLootAttackHero = class("zbCombatRoundLootAttackHero")
zbCombatRoundLootAttackHero.__index = zbCombatRoundLootAttackHero

function zbCombatRoundLootAttackHero.create(arg_1_0)
	local var_1_0 = zbCombatRoundLootAttackHero.new()

	var_1_0:init()

	return var_1_0
end

function zbCombatRoundLootAttackHero.init(arg_2_0)
	arg_2_0:reset()
end

function zbCombatRoundLootAttackHero.free(arg_3_0)
	return
end

function zbCombatRoundLootAttackHero.reset(arg_4_0)
	arg_4_0.hero = nil
	arg_4_0.starting = false
	arg_4_0.over = true
	arg_4_0.accumTime = 0
end

function zbCombatRoundLootAttackHero.checkLootAttack(arg_5_0, arg_5_1)
	if arg_5_0:isLootAttacking() then
		return false
	end

	if arg_5_1:hasLootAttackSkill() == false then
		return false
	end

	arg_5_0.hero = arg_5_1
	arg_5_0.starting = false
	arg_5_0.over = true
	arg_5_0.accumTime = 0
	arg_5_0.oldRoundEndFlag = arg_5_0.hero.roundEnded

	if arg_5_0.hero:execLootAttackSkill() then
		arg_5_0.starting = true
		arg_5_0.over = false

		return true
	end

	return false
end

function zbCombatRoundLootAttackHero.endLootAttack(arg_6_0)
	if arg_6_0:isLootAttacking() and arg_6_0.hero ~= nil and arg_6_0.hero.curSkill ~= nil and arg_6_0.hero.curSkill.passiveTriggerType == EPassiveTriggerType.LootAttack then
		arg_6_0.hero.roundEnded = arg_6_0.oldRoundEndFlag
		arg_6_0.hero.curSkill = nil
	end

	arg_6_0.starting = false
	arg_6_0.over = true
	arg_6_0.hero = nil
end

function zbCombatRoundLootAttackHero.isLootAttacking(arg_7_0)
	if arg_7_0.hero == nil then
		return false
	end

	return arg_7_0.starting == true and arg_7_0.over == false
end

function zbCombatRoundLootAttackHero.update(arg_8_0, arg_8_1)
	arg_8_0.accumTime = arg_8_0.accumTime + arg_8_1

	if arg_8_0.accumTime > 3 then
		arg_8_0:endLootAttack()

		return
	end

	if arg_8_0.hero == nil or arg_8_0.hero:isDie() then
		arg_8_0:endLootAttack()

		return
	end

	if g_CombatRound:isExecBigSkilling() then
		return
	end

	if arg_8_0.starting then
		if arg_8_0.hero:lootAttackIsOver() then
			arg_8_0:endLootAttack()
		end

		return
	end

	if g_CombatRound:isAllDied(ForceType.Left) or g_CombatRound:isAllDied(ForceType.Right) then
		arg_8_0:endLootAttack()

		return
	end
end
