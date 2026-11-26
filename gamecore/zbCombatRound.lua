require("gamecore.zbCombatDefine")
require("gamecore.zbCombatPlayer")
require("gamecore.zbHero")
require("gamecore.zbCombatRoundSequence")
require("gamecore.zbCombatRoundLootAttackHero")

zbCombatRound = class("zbCombatRound")
zbCombatRound.__index = zbCombatRound

function zbCombatRound.create(arg_1_0)
	local var_1_0 = zbCombatRound.new()

	var_1_0:init()

	return var_1_0
end

function zbCombatRound.init(arg_2_0)
	arg_2_0.started = false
	arg_2_0.maxRound = FIGHT_TOTAL_ROUND
	arg_2_0.sequenceRound = zbCombatRoundSequence:create()
	arg_2_0.lootAttackHeroRound = zbCombatRoundLootAttackHero:create()
end

function zbCombatRound.free(arg_3_0)
	return
end

function zbCombatRound.setMaxRound(arg_4_0, arg_4_1)
	arg_4_0.maxRound = arg_4_1
end

function zbCombatRound.reset(arg_5_0)
	arg_5_0.started = false

	arg_5_0.sequenceRound:reset(arg_5_0.maxRound)
	arg_5_0.lootAttackHeroRound:reset()
end

function zbCombatRound.resetSection(arg_6_0)
	arg_6_0.sequenceRound:reset(arg_6_0.maxRound)
	arg_6_0.lootAttackHeroRound:reset()
	arg_6_0.sequenceRound:start()
end

function zbCombatRound.start(arg_7_0)
	arg_7_0.started = true

	arg_7_0.sequenceRound:start()
end

function zbCombatRound.update(arg_8_0, arg_8_1)
	if arg_8_0.started == false then
		return
	end

	arg_8_0.lootAttackHeroRound:update(arg_8_1)
	arg_8_0.sequenceRound:update(arg_8_1)
end

function zbCombatRound.getCurRound(arg_9_0)
	return arg_9_0.sequenceRound:getCurRound()
end

function zbCombatRound.getAccumRound(arg_10_0)
	return arg_10_0.sequenceRound:getAccumRound()
end

function zbCombatRound.isExecLootAttackSkilling(arg_11_0)
	return arg_11_0.lootAttackHeroRound:isLootAttacking()
end

function zbCombatRound.isExecBigSkilling(arg_12_0)
	local var_12_0 = g_CombatSystem:getHerosNoLocal(ForceType.Left)

	for iter_12_0, iter_12_1 in pairs(var_12_0) do
		if iter_12_1:isExecBigSkilling() then
			return true
		end
	end

	local var_12_1 = g_CombatSystem:getHerosNoLocal(ForceType.Right)

	for iter_12_2, iter_12_3 in pairs(var_12_1) do
		if iter_12_3:isExecBigSkilling() then
			return true
		end
	end

	return false
end

function zbCombatRound.isExecBeattackedSkill(arg_13_0)
	local var_13_0 = g_CombatSystem:getHeros(ForceType.Left)
	local var_13_1 = g_CombatSystem:getHeros(ForceType.Right)

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		if iter_13_1:isExecBeattackedSkill() then
			return true
		end
	end

	for iter_13_2, iter_13_3 in pairs(var_13_1) do
		if iter_13_3:isExecBeattackedSkill() then
			return true
		end
	end

	return false
end

function zbCombatRound.isExecRevivingSkill(arg_14_0)
	local var_14_0 = g_CombatSystem:getHeros(ForceType.Left)
	local var_14_1 = g_CombatSystem:getHeros(ForceType.Right)

	for iter_14_0, iter_14_1 in pairs(var_14_0) do
		if iter_14_1:isReviving() then
			return true
		end
	end

	for iter_14_2, iter_14_3 in pairs(var_14_1) do
		if iter_14_3:isReviving() then
			return true
		end
	end

	return false
end

function zbCombatRound.isAllDied(arg_15_0, arg_15_1)
	if arg_15_1 == ForceType.Left then
		return g_CombatSystem.combatData.leftPlayer:getCurTotalHp() == 0
	elseif arg_15_1 == ForceType.Right then
		return g_CombatSystem.combatData.rightPlayer:getCurTotalHp() == 0
	end

	return false
end

function zbCombatRound.isTimeOver(arg_16_0)
	return arg_16_0.sequenceRound:isTimeOver()
end

function zbCombatRound.setRedoHero(arg_17_0, arg_17_1)
	arg_17_0.sequenceRound:setRedoHero(arg_17_1)
end
