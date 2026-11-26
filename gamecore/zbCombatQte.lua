local var_0_0 = class("zbCombatQte")

var_0_0.__index = var_0_0
EQTEEval = {
	Bad = 0,
	Great = 3,
	Good = 1,
	Perfect = 4
}
COMBAT_QTE_MAX_COMBO = 5
COMBAT_QTE_ROUND_PROTECT = 3

function createCombatQte()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	return
end

function var_0_0.free(arg_3_0)
	return
end

function var_0_0.checkQte(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = g_CombatRound:getCurRound()

	if arg_4_3.thisRoundHitCount > 1 then
		return
	end

	if arg_4_1.lastQteLeftRound == var_4_0 and arg_4_1.qteTarget ~= nil and arg_4_1.qteTarget:isSame(arg_4_2) then
		arg_4_1:comboQte(arg_4_1, arg_4_2)

		if arg_4_1.qteComboCount >= COMBAT_QTE_MAX_COMBO then
			arg_4_1:exitQte()

			return
		end
	end

	if arg_4_2:isDie() then
		return
	end

	if arg_4_3.damageSectionCount ~= nil and arg_4_3.damageSectionCount > 1 and arg_4_3.damageSectionCount * arg_4_4 * 1.1 >= arg_4_2.curHp then
		echo("1111111111111111222222222222: multi damage section=" .. arg_4_3.damageSectionCount)

		return
	end

	if var_4_0 - arg_4_2.lastQteRightRound < COMBAT_QTE_ROUND_PROTECT then
		return
	end

	if arg_4_1.lastQteLeftRound == var_4_0 then
		return
	end

	if arg_4_1.forceType == ForceType.Right then
		return
	end

	if arg_4_3.skillSeqIndex ~= 0 and arg_4_3.skillSeqIndex ~= 1 and arg_4_3.skillSeqIndex ~= 2 then
		return
	end

	if g_CombatSystem:isPvPCombatType() then
		return
	end

	if arg_4_2:hasSkillExecing() then
		return
	end

	if arg_4_0:calcTriggerRate(arg_4_1, arg_4_2, arg_4_3) == false then
		return
	end

	if g_CombatSystem.combatData.rightPlayer:getLivedHeroCount() <= 1 and arg_4_3.damageSectionCount * arg_4_4 * 8 >= arg_4_2.curHp then
		return
	end

	arg_4_1:enterQte(arg_4_2)
end

function var_0_0.calcTriggerRate(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = 1

	if arg_5_2:isHasBossHalo() or arg_5_2:isBigBoss() or arg_5_2:isBigBoss() then
		var_5_0 = 5
	end

	local var_5_1 = 2

	if arg_5_2:getHpPercent() <= 50 then
		var_5_1 = 5
	end

	local var_5_2 = 1
	local var_5_3 = arg_5_1.heroRecord.heroType
	local var_5_4 = arg_5_2.heroRecord.heroType

	if var_5_3 == EHeroType.Force and var_5_4 == EHeroType.Intelligence then
		var_5_2 = 2
	elseif var_5_3 == EHeroType.Intelligence and var_5_4 == EHeroType.Tili then
		var_5_2 = 2
	elseif var_5_3 == EHeroType.Tili and var_5_4 == EHeroType.Force then
		var_5_2 = 2
	elseif var_5_4 == EHeroType.Force and var_5_3 == EHeroType.Intelligence then
		var_5_2 = 0.5
	elseif var_5_4 == EHeroType.Intelligence and var_5_3 == EHeroType.Tili then
		var_5_2 = 0.5
	elseif var_5_4 == EHeroType.Tili and var_5_3 == EHeroType.Force then
		var_5_2 = 0.5
	end

	local var_5_5 = 1

	if arg_5_3.skillSeqIndex == 2 then
		var_5_5 = 1.5
	elseif arg_5_3.skillSeqIndex == 1 then
		var_5_5 = 2
	end

	local var_5_6 = var_5_0 * var_5_1 * var_5_2 * var_5_5 * 10

	return (zbCombatFormula:isSucceedRate(var_5_6))
end

function var_0_0.getQteAttack(arg_6_0)
	local var_6_0 = g_CombatRound:getCurRound()
	local var_6_1 = g_CombatSystem:getHeros(ForceType.Left)

	for iter_6_0, iter_6_1 in pairs(var_6_1) do
		if iter_6_1:isQting() then
			return iter_6_1
		end
	end

	return nil
end

function var_0_0.getQteTarget(arg_7_0)
	local var_7_0 = g_CombatRound:getCurRound()
	local var_7_1 = g_CombatSystem:getHeros(ForceType.Left)

	for iter_7_0, iter_7_1 in pairs(var_7_1) do
		if iter_7_1:isQting() then
			return iter_7_1.qteTarget
		end
	end

	return nil
end

function var_0_0.update(arg_8_0, arg_8_1)
	return
end
