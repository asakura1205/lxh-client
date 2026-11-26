require("gamecore.zbCombatDefine")
require("gamecore.zbCombatRound")
require("gamecore.zbFightSubStateMachine")

zbCombatState_Fight = class("zbCombatState_Fight")
zbCombatState_Fight.__index = zbCombatState_Fight

function zbCombatState_Fight.create(arg_1_0, arg_1_1)
	local var_1_0 = zbCombatState_Fight.new()

	var_1_0:init(arg_1_1)

	return var_1_0
end

function zbCombatState_Fight.init(arg_2_0, arg_2_1)
	arg_2_0.stateId = arg_2_1
	arg_2_0.hasFormationEffect = false
	arg_2_0.formationEffectAccumTime = 0
	arg_2_0.checkCombatTalked = false
	arg_2_0.checkReadyStarted = false
	arg_2_0.checkReadyCompleted = false
	arg_2_0.fsm = zbFightSubStateMachine:create()
end

function zbCombatState_Fight.free(arg_3_0)
	return
end

function zbCombatState_Fight.enter(arg_4_0)
	arg_4_0.checkCombatTalked = false
	arg_4_0.formationEffectAccumTime = 0
	arg_4_0.checkReadyStarted = false
	arg_4_0.checkReadyCompleted = false
	arg_4_0.hasFormationEffect = g_MainScene.wndCombat:showFormationEffect()

	arg_4_0.fsm:setCurrState(FightSubState_Fight)
	g_CombatPreload:stop()
end

function zbCombatState_Fight.exit(arg_5_0)
	return
end

function zbCombatState_Fight.update(arg_6_0, arg_6_1)
	if arg_6_0.hasFormationEffect then
		arg_6_0.formationEffectAccumTime = arg_6_0.formationEffectAccumTime + arg_6_1

		if arg_6_0.formationEffectAccumTime <= 1.5 then
			return
		end
	end

	if arg_6_0.checkCombatTalked == false then
		g_MainScene:startCombatTalk(g_CombatSystem.combatData.rightPlayer.curSection)

		arg_6_0.checkCombatTalked = true

		return
	end

	if arg_6_0.checkReadyStarted == false then
		g_MainScene.wndCombat:showReadyStartEffect()

		arg_6_0.checkReadyStarted = true

		return
	end

	if arg_6_0.checkReadyStarted == true and arg_6_0.checkReadyCompleted == false then
		arg_6_0.checkReadyCompleted = g_MainScene.wndCombat:isReadyStartEffectComplete()

		if arg_6_0.checkReadyCompleted then
			g_MainScene.wndCombat:hideReadyStartEffect()
		else
			return
		end
	end

	if g_CombatSystem.combatData:getTrialType() == ETrialType.NarrowMeet then
		if g_CombatRound:getCurRound() > g_CombatRound.maxRound then
			if g_CombatSystem.combatData.leftPlayer:getCurrHpPercent() < g_CombatSystem.combatData.rightPlayer:getCurrHpPercent() then
				if g_CombatSystem.combatData.leftPlayer:isLastSection() then
					g_CombatStateMachine:setCurrState(CombatState_Finish)

					return
				else
					arg_6_0:gotoNextSection(ForceType.Left)
				end
			elseif g_CombatSystem.combatData.rightPlayer:isLastSection() then
				g_CombatStateMachine:setCurrState(CombatState_Finish)

				return
			else
				arg_6_0:gotoNextSection(ForceType.Right)
			end
		elseif g_CombatSystem.combatData.leftPlayer:needNextSection() then
			arg_6_0:gotoNextSection(ForceType.Left)
		elseif g_CombatSystem.combatData.rightPlayer:needNextSection() then
			arg_6_0:gotoNextSection(ForceType.Right)
		end
	else
		if (g_CombatSystem.combatData:getTrialType() == ETrialType.LimitRoundKill or g_CombatSystem.combatData:getTrialType() == ETrialType.LimitRoundSurvival) and arg_6_0:isOver() then
			g_CombatStateMachine:setCurrState(CombatState_Finish)

			return
		end

		if g_CombatSystem.combatData.leftPlayer:needNextSection() then
			arg_6_0:gotoNextSection(ForceType.Left)
		elseif g_CombatSystem.combatData.rightPlayer:needNextSection() then
			arg_6_0:gotoNextSection(ForceType.Right)
		end
	end

	if arg_6_0:isOver() then
		g_CombatStateMachine:setCurrState(CombatState_Finish)

		return
	end

	arg_6_0:updateSection(arg_6_1)
end

function zbCombatState_Fight.updateSection(arg_7_0, arg_7_1)
	arg_7_0.fsm:update(arg_7_1)
end

function zbCombatState_Fight.gotoNextSection(arg_8_0, arg_8_1)
	g_NextSectionForceType = arg_8_1

	arg_8_0.fsm:setCurrState(FightSubState_NextSection)
end

function zbCombatState_Fight.isOver(arg_9_0)
	if g_CombatRound:isTimeOver() then
		return true
	end

	return g_CombatSystem.combatData.leftPlayer:isOver() or g_CombatSystem.combatData.rightPlayer:isOver()
end

function zbCombatState_Fight.getSubStateId(arg_10_0)
	return arg_10_0.fsm:getCurrStateId()
end
