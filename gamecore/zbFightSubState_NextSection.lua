g_NextSectionForceType = 0
zbFightSubState_NextSection = class("zbFightSubState_NextSection")
zbFightSubState_NextSection.__index = zbFightSubState_NextSection

function zbFightSubState_NextSection.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbFightSubState_NextSection.new()

	var_1_0:init(arg_1_1, arg_1_2)

	return var_1_0
end

function zbFightSubState_NextSection.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.fsm = arg_2_1
	arg_2_0.stateId = arg_2_2
end

function zbFightSubState_NextSection.free(arg_3_0)
	return
end

function zbFightSubState_NextSection.enter(arg_4_0)
	g_MainScene.wndCombat:gatherEnergyBallImmediate()

	local var_4_0 = g_CombatSystem:getHeros(getFlipForceType(g_NextSectionForceType))

	for iter_4_0, iter_4_1 in pairs(var_4_0) do
		iter_4_1.anim:setAnimation(iter_4_1:getIdleWeakSequence(), true)
	end

	if g_NextSectionForceType == ForceType.Left then
		g_CombatSystem.combatData.leftPlayer:gotoNextSection()
		g_CombatSystem.combatData.rightPlayer:clearHeroAddedProperty()
	elseif g_NextSectionForceType == ForceType.Right then
		g_CombatSystem.combatData.rightPlayer:gotoNextSection()
		g_CombatSystem.combatData.leftPlayer:clearHeroAddedProperty()
	end

	local var_4_1 = g_CombatSystem:getHeros(g_NextSectionForceType)

	for iter_4_2, iter_4_3 in pairs(var_4_1) do
		iter_4_3.stateMachine:setCurrState(HeroState_Enter)
	end

	g_Audio:playSound("audio/sound/move.mp3")

	if g_NextSectionForceType == ForceType.Left then
		g_MainScene.wndCombat:refreshHeroUIList()
	end

	if g_NextSectionForceType == ForceType.Right and g_CombatSystem.combatData.rightPlayer:isLastSection() then
		g_MainScene.wndCombat:showBossWarning()
		g_MainScene.wndCombat:refreshBossHud()
	end

	g_CombatRound:resetSection()
	g_DarkNode:resetSection()
	g_CombatSystem.combatData.leftPlayer:resume()
	g_CombatSystem.combatData.rightPlayer:resume()
end

function zbFightSubState_NextSection.exit(arg_5_0)
	return
end

function zbFightSubState_NextSection.update(arg_6_0, arg_6_1)
	if arg_6_0:isReadyFight() then
		g_MainScene:startCombatTalk(g_CombatSystem.combatData.rightPlayer.curSection)
		arg_6_0.fsm:setCurrState(FightSubState_Fight)
	end
end

function zbFightSubState_NextSection.isReadyFight(arg_7_0)
	local var_7_0 = g_CombatSystem:getHeros(ForceType.Left)
	local var_7_1 = g_CombatSystem:getHeros(ForceType.Right)

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		if iter_7_1:isDie() == false and iter_7_1.isReadyFight == false then
			return false
		end
	end

	for iter_7_2, iter_7_3 in pairs(var_7_1) do
		if iter_7_3:isDie() == false and iter_7_3.isReadyFight == false then
			return false
		end
	end

	return true
end
