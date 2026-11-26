require("gamecore.zbHero")

zbCombatRoundSequence = class("zbCombatRoundSequence")
zbCombatRoundSequence.__index = zbCombatRoundSequence

local var_0_0 = 6.5

function zbCombatRoundSequence.create(arg_1_0)
	local var_1_0 = zbCombatRoundSequence.new()

	var_1_0:init()

	return var_1_0
end

function zbCombatRoundSequence.init(arg_2_0)
	arg_2_0:reset()

	arg_2_0.accumRound = 0
end

function zbCombatRoundSequence.free(arg_3_0)
	return
end

function zbCombatRoundSequence.reset(arg_4_0, arg_4_1)
	arg_4_0.currAttackForceType = -1
	arg_4_0.curRound = 0
	arg_4_0.maxRound = arg_4_1
	arg_4_0.curSelfFightIndex = 0
	arg_4_0.curEnemyFightIndex = 0
	arg_4_0.attackerHero = nil
	arg_4_0.lastNormalSeqTime = 0
	arg_4_0.redoHero = nil
end

function zbCombatRoundSequence.resetAccumRound(arg_5_0)
	arg_5_0.accumRound = 0
end

function zbCombatRoundSequence.start(arg_6_0)
	arg_6_0.curRound = 0

	arg_6_0:nextRound()
end

function zbCombatRoundSequence.nextRound(arg_7_0)
	if g_CombatSystem.combatData.leftPlayer:isAllDied() or g_CombatSystem.combatData.rightPlayer:isAllDied() then
		return
	end

	arg_7_0.accumRound = arg_7_0.accumRound + 1
	arg_7_0.curRound = arg_7_0.curRound + 1
	arg_7_0.curSelfFightIndex = 1
	arg_7_0.curEnemyFightIndex = 1
	arg_7_0.attackerHero = nil
	arg_7_0.currAttackForceType = ForceType.Left

	echo(string.format("----------------- nextround: %d -----------------", arg_7_0.curRound))

	local var_7_0 = g_CombatSystem:getHeros(ForceType.Left)
	local var_7_1 = g_CombatSystem:getHeros(ForceType.Right)

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		iter_7_1:clearRoundFlag()
	end

	for iter_7_2, iter_7_3 in pairs(var_7_1) do
		iter_7_3:clearRoundFlag()
	end

	g_CombatSystem:getLegend():newRound(arg_7_0.curRound)
	g_CombatSystem:getEnemyLegend():newRound(arg_7_0.curRound)
	g_CombatSystem.combatData.combatFocus:newRound(arg_7_0.curRound)
	g_BuffSystem:update(0)

	if g_MainScene ~= nil and g_MainScene.wndCombat ~= nil then
		g_MainScene.wndCombat:newRound(arg_7_0.curRound)
	end

	if g_FirstCombat:isActive() then
		g_FirstCombat:onRound(arg_7_0.curRound)
	end
end

function zbCombatRoundSequence.update(arg_8_0, arg_8_1)
	if g_CombatSystem:getLegend():isExecBigSkilling() then
		return
	end

	if g_CombatRound:isExecLootAttackSkilling() then
		return
	end

	if arg_8_0:curRoundIsOver() and arg_8_0.curRound <= arg_8_0.maxRound then
		local var_8_0 = g_CombatSystem.combatData.rightPlayer.curSection

		if g_MainScene:roundCombatTalk(var_8_0, arg_8_0.curRound + 1) then
			return
		end

		arg_8_0:nextRound()
	end

	arg_8_0:updateCurrRound(arg_8_1)
end

function zbCombatRoundSequence.updateCurrRound(arg_9_0, arg_9_1)
	if g_CombatSystem:getLegend():isExecBigSkilling() then
		return
	end

	arg_9_0.lastNormalSeqTime = arg_9_0.lastNormalSeqTime + arg_9_1

	if arg_9_0.lastNormalSeqTime <= var_0_0 then
		if arg_9_0.attackerHero ~= nil and arg_9_0.attackerHero:isRoundEnd() == false then
			return
		end

		if g_CombatRound:isExecLootAttackSkilling() then
			return
		end

		if g_CombatRound:isExecBigSkilling() then
			return
		end

		if g_CombatRound:isExecRevivingSkill() then
			return
		end

		if g_CombatRound:isExecBeattackedSkill() then
			return
		end

		if g_CombatRound:isAllDied(ForceType.Left) or g_CombatRound:isAllDied(ForceType.Right) then
			return
		end
	else
		echo("---------------------warnning: normal attack timeout: " .. arg_9_0.lastNormalSeqTime)

		if g_MainScene.wndCombat:isQteFxVisible() then
			echo("---------------------warnning: normal attack timeout: QteFxVisible")
		end

		if arg_9_0.redoHero ~= nil and arg_9_0.redoHero:isDie() == false then
			echo("---------------------warnning: normal attack timeout: redoHero")
		end
	end

	if g_MainScene.wndCombat:isQteFxVisible() then
		return
	end

	if arg_9_0.redoHero ~= nil and arg_9_0.redoHero:isDie() == false then
		arg_9_0.lastNormalSeqTime = 0

		arg_9_0.redoHero:roundBeginQteNormal()

		arg_9_0.attackerHero = arg_9_0.redoHero
		arg_9_0.redoHero = nil

		g_CombatBubble:showBubble(arg_9_0.attackerHero, ECombatBubble.Redo, 0, 0, 1)

		return
	end

	if arg_9_0:checkAutoBigSkill(arg_9_0.currAttackForceType) or arg_9_0:checkAutoBigSkill(getFlipForceType(arg_9_0.currAttackForceType)) then
		arg_9_0.lastNormalSeqTime = 0

		return
	end

	if arg_9_0:curRoundForceTypeIsOver(ForceType.Left) then
		arg_9_0.currAttackForceType = ForceType.Right
	elseif arg_9_0:curRoundForceTypeIsOver(ForceType.Right) then
		arg_9_0.currAttackForceType = ForceType.Left
	end

	if arg_9_0.currAttackForceType == ForceType.Left then
		if arg_9_0:checkLootAttack(ForceType.Right) then
			arg_9_0.lastNormalSeqTime = 0

			return
		end

		arg_9_0.lastNormalSeqTime = 0
		arg_9_0.attackerHero = arg_9_0:getCurRoundAttackHero(arg_9_0.currAttackForceType, arg_9_0.curSelfFightIndex)

		if arg_9_0.attackerHero ~= nil then
			arg_9_0.attackerHero:roundBegin()
		end

		arg_9_0.currAttackForceType = ForceType.Right
	elseif arg_9_0.currAttackForceType == ForceType.Right then
		if arg_9_0:checkLootAttack(ForceType.Left) then
			arg_9_0.lastNormalSeqTime = 0

			return
		end

		arg_9_0.lastNormalSeqTime = 0
		arg_9_0.attackerHero = arg_9_0:getCurRoundAttackHero(arg_9_0.currAttackForceType, arg_9_0.curEnemyFightIndex)

		if arg_9_0.attackerHero ~= nil then
			arg_9_0.attackerHero:roundBegin()
		end

		arg_9_0.currAttackForceType = ForceType.Left
	end
end

function zbCombatRoundSequence.checkAutoBigSkill(arg_10_0, arg_10_1)
	local var_10_0 = g_CombatSystem:getHeros(arg_10_1, true)

	for iter_10_0, iter_10_1 in pairs(var_10_0) do
		if iter_10_1:checkAutoBigSkill() then
			return true
		end
	end

	return false
end

function zbCombatRoundSequence.checkLootAttack(arg_11_0, arg_11_1)
	local var_11_0 = g_CombatSystem:getHeros(arg_11_1, true)

	for iter_11_0, iter_11_1 in pairs(var_11_0) do
		if g_CombatRound.lootAttackHeroRound:checkLootAttack(iter_11_1) then
			return true
		end
	end

	return false
end

function zbCombatRoundSequence.checkHeroRoundNotEnd(arg_12_0, arg_12_1)
	if arg_12_1 == nil or arg_12_1:isDie() then
		return false
	end

	if arg_12_1:isRoundEnd() == false then
		return true
	end

	if arg_12_1:isExecBeattackedSkill() == true then
		return true
	end

	return false
end

function zbCombatRoundSequence.curRoundIsOver(arg_13_0)
	if g_MainScene.wndCombat:isQteFxVisible() then
		return false
	end

	if arg_13_0.redoHero ~= nil and arg_13_0.redoHero:isDie() == false then
		return false
	end

	if arg_13_0.attackerHero ~= nil and arg_13_0.attackerHero:isRoundEnd() == false then
		return false
	end

	if g_CombatSystem.combatData.leftPlayer:isAllRealDied() or g_CombatSystem.combatData.rightPlayer:isAllRealDied() then
		return true
	end

	local var_13_0 = g_CombatSystem:getHeros(ForceType.Left)
	local var_13_1 = g_CombatSystem:getHeros(ForceType.Right)

	for iter_13_0 = arg_13_0.curSelfFightIndex, 5 do
		local var_13_2 = var_13_0[iter_13_0]

		if arg_13_0:checkHeroRoundNotEnd(var_13_2) then
			return false
		end
	end

	for iter_13_1 = arg_13_0.curEnemyFightIndex, 5 do
		local var_13_3 = var_13_1[iter_13_1]

		if arg_13_0:checkHeroRoundNotEnd(var_13_3) then
			return false
		end
	end

	return true
end

function zbCombatRoundSequence.curRoundForceTypeIsOver(arg_14_0, arg_14_1)
	local var_14_0 = g_CombatSystem:getHeros(arg_14_1)

	for iter_14_0 = 1, 5 do
		local var_14_1 = var_14_0[iter_14_0]

		if var_14_1 ~= nil and var_14_1:isDie() == false and var_14_1:isRoundEnd() == false then
			return false
		end
	end

	return true
end

function zbCombatRoundSequence.getCurRoundAttackHero(arg_15_0, arg_15_1, arg_15_2)
	local function var_15_0(arg_16_0)
		local function var_16_0(arg_17_0)
			local var_17_0 = {}

			if arg_15_1 == ForceType.Left then
				var_17_0 = g_CombatSystem:getHeros(ForceType.Left)
			else
				var_17_0 = g_CombatSystem:getHeros(ForceType.Right)
			end

			if table.getn(var_17_0) < arg_17_0 + 1 then
				return 1
			else
				return arg_17_0 + 1
			end
		end

		if arg_15_1 == ForceType.Left then
			arg_15_0.curSelfFightIndex = var_16_0(arg_16_0)
		else
			arg_15_0.curEnemyFightIndex = var_16_0(arg_16_0)
		end
	end

	local var_15_1 = g_CombatSystem:getHeros(arg_15_1)

	for iter_15_0 = arg_15_2, 5 do
		local var_15_2 = var_15_1[iter_15_0]

		if var_15_2 ~= nil and var_15_2:isDie() == false then
			if var_15_2:isHunmi() then
				if var_15_2.roundEnded == false then
					var_15_2:roundSimpleNoAction()
				end

				var_15_2.roundEnded = true
			else
				var_15_0(iter_15_0)

				return var_15_2
			end
		end
	end

	for iter_15_1 = 1, arg_15_2 do
		local var_15_3 = var_15_1[iter_15_1]

		if var_15_3 ~= nil and var_15_3:isDie() == false then
			if var_15_3:isHunmi() then
				if var_15_3.roundEnded == false then
					var_15_3:roundSimpleNoAction()
				end

				var_15_3.roundEnded = true
			else
				var_15_0(iter_15_1)

				return var_15_3
			end
		end
	end

	return nil
end

function zbCombatRoundSequence.guessNextAttackHero(arg_18_0, arg_18_1)
	local var_18_0 = 1

	if arg_18_1 == ForceType.Left then
		var_18_0 = arg_18_0.curSelfFightIndex
	else
		var_18_0 = arg_18_0.curEnemyFightIndex
	end

	local var_18_1 = g_CombatSystem:getHeros(arg_18_1)

	for iter_18_0 = var_18_0, 5 do
		local var_18_2 = var_18_1[iter_18_0]

		if var_18_2 ~= nil and var_18_2:isDie() == false and var_18_2:isHunmi() == false then
			return var_18_2
		end
	end

	for iter_18_1 = 1, var_18_0 do
		local var_18_3 = var_18_1[iter_18_1]

		if var_18_3 ~= nil and var_18_3:isDie() == false and var_18_3:isHunmi() == false then
			return var_18_3
		end
	end

	return nil
end

function zbCombatRoundSequence.isTimeOver(arg_19_0)
	if g_CombatSystem.combatData:getTrialType() == ETrialType.LimitRoundKill or g_CombatSystem.combatData:getTrialType() == ETrialType.LimitRoundSurvival then
		if arg_19_0.accumRound == arg_19_0.maxRound then
			if g_CombatSystem.combatData.rightPlayer:isAllRealDied() then
				return true
			end

			if arg_19_0:curRoundIsOver() then
				return true
			end
		end

		return arg_19_0.accumRound > arg_19_0.maxRound
	end

	if g_CombatSystem.combatData.leftPlayer:isLastSection() or g_CombatSystem.combatData.rightPlayer:isLastSection() then
		if arg_19_0.curRound == arg_19_0.maxRound and arg_19_0:curRoundIsOver() then
			return true
		end

		return arg_19_0.curRound > arg_19_0.maxRound
	end

	return false
end

function zbCombatRoundSequence.getCurRound(arg_20_0)
	return arg_20_0.curRound
end

function zbCombatRoundSequence.getAccumRound(arg_21_0)
	return arg_21_0.accumRound
end

function zbCombatRoundSequence.setRedoHero(arg_22_0, arg_22_1)
	arg_22_0.redoHero = arg_22_1
end
