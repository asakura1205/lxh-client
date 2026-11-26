local var_0_0 = class("zbCombatLegend")

var_0_0.__index = var_0_0

function createCombatLegend(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.forceType = arg_2_1
	arg_2_0.battleGod = arg_2_2
	arg_2_0.energy = 0
	arg_2_0.legender = nil
	arg_2_0.nodeAction = CCNode:create()

	arg_2_0.nodeAction:retain()
	g_MainScene:addChild(arg_2_0.nodeAction)

	if zbUtil:isValidTable(arg_2_2) then
		arg_2_0.legender = g_LegendSkillSystem:createLegender(arg_2_0, arg_2_2)

		if g_CombatSystem:isPvPCombatType() then
			arg_2_0.energy = 70
		else
			arg_2_0.energy = arg_2_2.Energy
		end
	end
end

function var_0_0.free(arg_3_0)
	arg_3_0.nodeAction:stopAllActions()
end

function var_0_0.getId(arg_4_0)
	if zbUtil:isValidTable(arg_4_0.battleGod) then
		return arg_4_0.battleGod.GodId
	else
		return 0
	end
end

function var_0_0.isEmpty(arg_5_0)
	return arg_5_0.legender == nil
end

function var_0_0.execInitPassiveSkill(arg_6_0, arg_6_1)
	if arg_6_0:isEmpty() then
		return
	end

	arg_6_0.legender:execInitPassiveSkill(arg_6_1)
end

function var_0_0.heroDied(arg_7_0, arg_7_1)
	if arg_7_0:isEmpty() then
		return
	end

	if arg_7_1.forceType == g_CombatSystem:getMyForceType() and g_CombatSystem:isPvPCombatType() == false then
		return
	end

	if zbCombatFormula:isSucceedRate(400) then
		local var_7_0 = arg_7_1:getFixPosition()

		var_7_0.y = var_7_0.y + 50

		g_MainScene.wndCombat:spawnEnergyBall(arg_7_1.forceType, var_7_0, 10)
	end
end

function var_0_0.newRound(arg_8_0, arg_8_1)
	if arg_8_0:isEmpty() then
		return
	end

	if arg_8_1 > 1 then
		arg_8_0:addEnergy(10)
	end
end

function var_0_0.addEnergy(arg_9_0, arg_9_1)
	if arg_9_0:isEmpty() then
		return
	end

	if arg_9_0.energy < 100 and arg_9_0.forceType == g_CombatSystem:getMyForceType() and arg_9_0.energy + arg_9_1 >= 100 then
		g_Audio:playSound(AudioDefine.UI_BATTLE_MPFULL)
	end

	arg_9_0.energy = math.min(arg_9_0.energy + arg_9_1, 100)
end

function var_0_0.getEnergy(arg_10_0)
	return arg_10_0.energy
end

function var_0_0.getEnergyPercent(arg_11_0)
	if arg_11_0.energy == 0 then
		return 0
	elseif arg_11_0.energy >= 100 then
		return 100
	else
		return arg_11_0.energy % 100
	end
end

function var_0_0.isCanExec(arg_12_0)
	return arg_12_0.legender ~= nil and arg_12_0.energy >= 100
end

function var_0_0.execBigSkill(arg_13_0)
	if arg_13_0.energy < 100 then
		g_Bubble:bubbleInfo("\xB7\xA8\xB1\xA6\xC4\xDC\xC1\xBF\xB2\xBB\xD7\xE3")

		return false
	end

	if arg_13_0.legender ~= nil then
		arg_13_0.legender:action1()

		arg_13_0.energy = 0

		return true
	end

	return false
end

function var_0_0.update(arg_14_0, arg_14_1)
	return
end

function var_0_0.isExecBigSkilling(arg_15_0)
	if arg_15_0.legender == nil then
		return false
	end

	return arg_15_0.legender:isActioning()
end

function var_0_0.checkAutoExecBigSkill(arg_16_0)
	if arg_16_0.legender == nil then
		return
	end

	if arg_16_0.energy < 100 then
		return
	end

	if arg_16_0.legender:isActioning() then
		return
	end

	if g_FirstCombat:isActive() == false and g_CombatSystem:isPvPCombatType() == false then
		return
	end

	if g_CombatSystem:getLegend():isExecBigSkilling() or g_CombatSystem:getEnemyLegend():isExecBigSkilling() then
		return
	end

	if g_CombatStateMachine:getCurrStateId() ~= CombatState_Fight then
		return
	end

	if g_CombatStateMachine:getCurrState():getSubStateId() ~= FightSubState_Fight then
		return
	end

	if g_CombatSystem.combatData.leftPlayer:getCurTotalHp() <= 0 or g_CombatSystem.combatData.rightPlayer:getCurTotalHp() <= 0 then
		return
	end

	if g_MainScene.wndCombatTalk ~= nil and g_MainScene.wndCombatTalk.isShow and g_MainScene.wndCombatTalk:isVisible() == true then
		return
	end

	if g_MainScene.wndCombat:isQteFxVisible() then
		return false
	end

	if g_CombatSystem.combatData.combatQte:getQteTarget() ~= nil then
		return false
	end

	arg_16_0.legender:action1()

	arg_16_0.energy = 0
end

function var_0_0.popPassiveBubble(arg_17_0)
	if arg_17_0.legender ~= nil then
		return arg_17_0.legender:popPassiveBubble()
	end

	return nil
end
