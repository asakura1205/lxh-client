require("gamecore.zbCombatStateMachine")
require("gamecore.zbCombatGlobal")
require("gamecore.zbCombatDefine")
require("gamecore.zbEffectSystem")
require("gamecore.zbBuffSystem")
require("gamecore.zbSkillSystem")
require("gamecore.zbCombatBubble")
require("gamecore.zbCombatLegend")
require("gamecore.zbCombatData")
require("gamecore.zbCombatResult")
require("gamecore.zbCombatPlayer")
require("gamecore.zbCombatFormula")
require("gamecore.zbCombatFormulaCure")
require("gamecore.zbCombatFormulaLegend")
require("gamecore.zbCombatPreLoad")
require("gamecore.zbCombatTest")
require("gamecore.zbHero")
require("gamecore.zbDarkNode")
require("gamecore.zbLegendSkillSystem")

local var_0_0 = class("zbCombatSystem")

var_0_0.__index = var_0_0

function createCombatSystem()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	arg_2_0.combatType = COMBAT_TYPE_UNKNOWN
	arg_2_0.lastTime = -1
	arg_2_0.isPause = false
	arg_2_0.autoCombat = false
	arg_2_0.openBulllet = false
	arg_2_0.combatSceneId = 1
	arg_2_0.combatTalkId = 0
	arg_2_0.combatData = nil
	arg_2_0.combatResult = zbCombatResult:create()
	arg_2_0.combatTest = zbCombatTest:create()
	g_CombatStateMachine = zbCombatStateMachine:create()
	g_CombatBubble = zbCombatBubble:create()
	g_SkillSystem = zbSkillSystem:create()
	g_EffectSystem = zbEffectSystem:create()
	g_BuffSystem = zbBuffSystem:create()
	g_CombatRound = zbCombatRound:create()
	g_CombatFormula = zbCombatFormula:create()
	g_CombatFormulaCure = zbCombatFormulaCure:create()
	g_CombatFormulaLegend = zbCombatFormulaLegend:create()
	g_CombatPreload = zbCombatPreLoad:create()
	g_DarkNode = zbDarkNode:create()
	g_LegendSkillSystem = zbLegendSkillSystem:create()
	arg_2_0.tmpLeftQueryHeros = {}
	arg_2_0.tmpRightQueryHeros = {}
	arg_2_0.tmpEmptyQueryHeros = {}
end

function var_0_0.free(arg_3_0)
	g_CombatStateMachine:free()

	g_CombatStateMachine = nil

	g_SkillSystem:free()

	g_SkillSystem = nil

	g_LegendSkillSystem:free()

	g_LegendSkillSystem = nil

	g_EffectSystem:free()

	g_EffectSystem = nil

	g_BuffSystem:free()

	g_EffectSystem = nil

	g_CombatBubble:free()

	g_CombatBubble = nil

	arg_3_0.combatData:free()

	arg_3_0.combatData = nil

	g_CombatRound:free()

	g_CombatRound = nil

	g_CombatFormula:free()

	g_CombatFormula = nil

	g_CombatFormulaCure:free()

	g_CombatFormulaCure = nil

	g_CombatFormulaLegend:free()

	g_CombatFormulaLegend = nil

	g_DarkNode:free()

	g_DarkNode = nil

	g_CombatPreload:free()

	g_CombatPreload = nil
end

function var_0_0.update(arg_4_0)
	local var_4_0 = os_timenow()

	if arg_4_0.lastTime == -1 then
		arg_4_0.lastTime = var_4_0
	end

	local var_4_1 = var_4_0 - arg_4_0.lastTime

	arg_4_0.lastTime = var_4_0

	if arg_4_0.isPause == false then
		g_CombatStateMachine:update(var_4_1)
		arg_4_0.combatData:update(var_4_1)
		g_EffectSystem:update(var_4_1)
		g_BuffSystem:update(var_4_1)
		g_CombatBubble:update(var_4_1)
		g_DarkNode:update(var_4_1)
	end

	g_CombatPreload:update(var_4_1)
end

function var_0_0.startLevelBattle(arg_5_0, arg_5_1)
	arg_5_0.combatType = COMBAT_TYPE_LEVEL
	arg_5_0.combatData = createCombatData()

	arg_5_0.combatData:setLevelBattleReadyAckData(arg_5_1)
end

function var_0_0.startTrial(arg_6_0, arg_6_1)
	arg_6_0.combatType = COMBAT_TYPE_TRIAL
	arg_6_0.combatData = createCombatData()

	arg_6_0.combatData:setTrailReadyAckData(arg_6_1)
end

function var_0_0.startArenaBattle(arg_7_0, arg_7_1)
	arg_7_0.combatType = COMBAT_TYPE_ARENA
	arg_7_0.combatData = createCombatData()

	arg_7_0.combatData:setArenaBattleReadyAckData(arg_7_1)
	arg_7_0:setAutoCombat(true)
end

function var_0_0.startPataBattle(arg_8_0, arg_8_1)
	arg_8_0.combatType = COMBAT_TYPE_PATA
	arg_8_0.combatData = createCombatData()

	arg_8_0.combatData:setPataBattleReadyAckData(arg_8_1)
end

function var_0_0.startYuanzhengBattle(arg_9_0, arg_9_1)
	arg_9_0.combatType = COMBAT_TYPE_YUANZHENG
	arg_9_0.combatData = createCombatData()

	arg_9_0.combatData:setYuanzhengBattleReadyAckData(arg_9_1)
end

function var_0_0.startFriendBattle(arg_10_0, arg_10_1)
	arg_10_0.combatType = COMBAT_TYPE_FRIEND
	arg_10_0.combatData = createCombatData()

	arg_10_0.combatData:setFriendBattleReadyAckData(arg_10_1)
	arg_10_0:setAutoCombat(true)
end

function var_0_0.startLegionBossBattle(arg_11_0, arg_11_1)
	arg_11_0.combatType = COMBAT_TYPE_LEGIONBOSS
	arg_11_0.combatData = createCombatData()

	arg_11_0.combatData:setLegionBossBattleReadyAckData(arg_11_1)
end

function var_0_0.startLegionWarBattle(arg_12_0, arg_12_1)
	arg_12_0.combatType = COMBAT_TYPE_LEGIONWAR
	arg_12_0.combatData = createCombatData()

	arg_12_0.combatData:setLegionWarBattleReadyAckData(arg_12_1)
end

function var_0_0.startLegionWarPlayBattle(arg_13_0, arg_13_1)
	arg_13_0.combatType = COMBAT_TYPE_LEGIONWAR
	arg_13_0.combatData = createCombatData()

	arg_13_0.combatData:setLegionWarPlayBattleAck(arg_13_1)
end

function var_0_0.startLegionWarBuildBattle(arg_14_0, arg_14_1)
	arg_14_0.combatType = COMBAT_TYPE_LEGIONWAR
	arg_14_0.combatData = createCombatData()

	arg_14_0.combatData:setLegionWarBuildBattleAck(arg_14_1)
end

function var_0_0.startWorldBossBattle(arg_15_0, arg_15_1)
	arg_15_0.combatType = COMBAT_TYPE_WORLDBOSS
	arg_15_0.combatData = createCombatData()

	arg_15_0.combatData:setWorldBossBattleReadyAckData(arg_15_1)
end

function var_0_0.startFriendBossBattle(arg_16_0, arg_16_1)
	arg_16_0.combatType = COMBAT_TYPE_FRIENDBOSS
	arg_16_0.combatData = createCombatData()

	arg_16_0.combatData:setFriendBossBattleReadyAckData(arg_16_1)
end

function var_0_0.startChatBattle(arg_17_0, arg_17_1)
	arg_17_0.combatType = COMBAT_TYPE_CHAT
	arg_17_0.combatData = createCombatData()

	arg_17_0.combatData:setChatBattleReadyAckData(arg_17_1)
	arg_17_0:setAutoCombat(true)
end

function var_0_0.startCombatRecord(arg_18_0, arg_18_1)
	arg_18_0.combatType = COMBAT_TYPE_ARENARECORD
	arg_18_0.combatData = createCombatData()

	arg_18_0.combatData:setArenaFightRecordData(arg_18_1)
	arg_18_0:setAutoCombat(true)
end

function var_0_0.startCombatTest(arg_19_0, arg_19_1)
	arg_19_0.combatType = COMBAT_TYPE_LOCALTEST
	arg_19_0.combatData = createCombatData()

	arg_19_0.combatData:setCombatTestData(arg_19_1)
end

function var_0_0.startWorldResInfoBattle(arg_20_0, arg_20_1)
	arg_20_0.combatType = COMBAT_TYPE_OCCUPY_PLAYER
	arg_20_0.combatData = createCombatData()

	arg_20_0.combatData:setOccupyResFightReadyAckData(arg_20_1)
	arg_20_0:setAutoCombat(true)
end

function var_0_0.startHorseBattle(arg_21_0, arg_21_1)
	arg_21_0.combatType = COMBAT_TYPE_RANDROB
	arg_21_0.combatData = createCombatData()

	arg_21_0.combatData:setHorseBattleReadyAckData(arg_21_1)
end

function var_0_0.finish(arg_22_0)
	g_EffectSystem:clear()

	if arg_22_0.combatData then
		arg_22_0.combatData:free()
	end
end

function var_0_0.getSpeed(arg_23_0)
	return g_CombatSpeed
end

function var_0_0.setSpeed(arg_24_0, arg_24_1)
	g_CombatSpeed = arg_24_1

	CCDirector:sharedDirector():getScheduler():setTimeScale(g_CombatSpeed)
end

function var_0_0.setNormalSpeed(arg_25_0)
	arg_25_0:setSpeed(1)
end

function var_0_0.isAutoCombat(arg_26_0)
	return arg_26_0.autoCombat
end

function var_0_0.setAutoCombat(arg_27_0, arg_27_1)
	arg_27_0.autoCombat = arg_27_1
end

function var_0_0.isOpenBulllet(arg_28_0)
	return arg_28_0.openBulllet
end

function var_0_0.setOpenBulllet(arg_29_0, arg_29_1)
	arg_29_0.openBulllet = arg_29_1
end

function var_0_0.pause(arg_30_0)
	arg_30_0.isPause = true

	arg_30_0.combatData.leftPlayer:pause()
	arg_30_0.combatData.rightPlayer:pause()
end

function var_0_0.resume(arg_31_0)
	arg_31_0.isPause = false

	arg_31_0.combatData.leftPlayer:resume()
	arg_31_0.combatData.rightPlayer:resume()
end

function var_0_0.isPaused(arg_32_0)
	return arg_32_0.isPause
end

function var_0_0.pauseExclude(arg_33_0, arg_33_1)
	arg_33_0.combatData.leftPlayer:pauseExclude(arg_33_1)
	arg_33_0.combatData.rightPlayer:pauseExclude(arg_33_1)
end

function var_0_0.resumeExclude(arg_34_0, arg_34_1)
	arg_34_0.combatData.leftPlayer:resumeExclude(arg_34_1)
	arg_34_0.combatData.rightPlayer:resumeExclude(arg_34_1)
end

function var_0_0.getCombatPlayer(arg_35_0, arg_35_1)
	if arg_35_1 == ForceType.Left then
		return arg_35_0.combatData.leftPlayer
	elseif arg_35_1 == ForceType.Right then
		return arg_35_0.combatData.rightPlayer
	else
		return nil
	end
end

function var_0_0.cloneTable(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	for iter_36_0, iter_36_1 in pairs(arg_36_2) do
		if arg_36_3 == true then
			if iter_36_1:isDie() == false then
				table.insert(arg_36_1, iter_36_1)
			end
		else
			table.insert(arg_36_1, iter_36_1)
		end
	end
end

function var_0_0.getHeros(arg_37_0, arg_37_1, arg_37_2)
	if arg_37_2 == nil then
		return arg_37_0:getHerosNoLocal(arg_37_1)
	end

	if arg_37_1 == ForceType.Left then
		for iter_37_0 = #arg_37_0.tmpLeftQueryHeros, 1, -1 do
			table.remove(arg_37_0.tmpLeftQueryHeros, iter_37_0)
		end
	elseif arg_37_1 == ForceType.Right then
		for iter_37_1 = #arg_37_0.tmpRightQueryHeros, 1, -1 do
			table.remove(arg_37_0.tmpRightQueryHeros, iter_37_1)
		end
	end

	if arg_37_1 == ForceType.Left then
		arg_37_0:cloneTable(arg_37_0.tmpLeftQueryHeros, arg_37_0.combatData.leftPlayer.heros, arg_37_2)

		return arg_37_0.tmpLeftQueryHeros
	elseif arg_37_1 == ForceType.Right then
		arg_37_0:cloneTable(arg_37_0.tmpRightQueryHeros, arg_37_0.combatData.rightPlayer.heros, arg_37_2)

		return arg_37_0.tmpRightQueryHeros
	end

	return arg_37_0.tmpEmptyQueryHeros
end

function var_0_0.getHerosNoLocal(arg_38_0, arg_38_1)
	if arg_38_1 == ForceType.Left then
		return arg_38_0.combatData.leftPlayer.heros
	elseif arg_38_1 == ForceType.Right then
		return arg_38_0.combatData.rightPlayer.heros
	else
		return {}
	end
end

function var_0_0.getHero(arg_39_0, arg_39_1, arg_39_2)
	if arg_39_1 == ForceType.Left then
		return arg_39_0.combatData.leftPlayer.heros[arg_39_2]
	elseif arg_39_1 == ForceType.Right then
		return arg_39_0.combatData.rightPlayer.heros[arg_39_2]
	else
		return nil
	end
end

function var_0_0.getHeroByTemplateId(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = arg_40_0:getHeros(arg_40_1)

	for iter_40_0, iter_40_1 in pairs(var_40_0) do
		if iter_40_1:getTemplateId() == arg_40_2 then
			return iter_40_1
		end
	end

	return nil
end

function var_0_0.getFriendMinHpHero(arg_41_0, arg_41_1)
	local var_41_0
	local var_41_1 = arg_41_0:getHeros(arg_41_1.forceType, true)

	for iter_41_0, iter_41_1 in pairs(var_41_1) do
		if iter_41_1:isSame(arg_41_1) == false then
			if var_41_0 == nil then
				var_41_0 = iter_41_1
			elseif iter_41_1.curHp < var_41_0.curHp then
				var_41_0 = iter_41_1
			end
		end
	end

	if var_41_0 == nil then
		var_41_0 = arg_41_1
	end

	return var_41_0
end

function var_0_0.getLivedHeroCount(arg_42_0, arg_42_1)
	if arg_42_1 == ForceType.Left then
		return arg_42_0.combatData.leftPlayer:getLivedHeroCount()
	elseif arg_42_1 == ForceType.Right then
		return arg_42_0.combatData.rightPlayer:getLivedHeroCount()
	else
		return 0
	end
end

function var_0_0.getHeroDiedCount(arg_43_0, arg_43_1)
	if arg_43_1 == ForceType.Left then
		return arg_43_0.combatData.leftPlayer:getHeroDiedCount()
	elseif arg_43_1 == ForceType.Right then
		return arg_43_0.combatData.rightPlayer:getHeroDiedCount()
	else
		return 0
	end
end

function var_0_0.getMyForceType(arg_44_0)
	if arg_44_0.combatType == COMBAT_TYPE_ARENARECORD then
		if arg_44_0.combatData.arenaFightRecordData.BattleInfo.SelfBaseInfo[1].PlayerId == g_Self:getPlayerId() then
			return ForceType.Left
		elseif arg_44_0.combatData.arenaFightRecordData.BattleInfo.EnemyBaseInfo[1].PlayerId == g_Self:getPlayerId() then
			return ForceType.Right
		end
	end

	return ForceType.Left
end

function var_0_0.getCombatType(arg_45_0)
	return arg_45_0.combatType
end

function var_0_0.isPvPCombatType(arg_46_0)
	return arg_46_0.combatType == COMBAT_TYPE_OCCUPY_PLAYER or arg_46_0.combatType == COMBAT_TYPE_OCCUPY_CITY or arg_46_0.combatType == COMBAT_TYPE_ARENA or arg_46_0.combatType == COMBAT_TYPE_ARENARECORD or arg_46_0.combatType == COMBAT_TYPE_FRIEND or arg_46_0.combatType == COMBAT_TYPE_LEGIONBATTLE or arg_46_0.combatType == COMBAT_TYPE_RANDROB
end

function var_0_0.getPvPCombatTypeDesc(arg_47_0)
	if arg_47_0.combatType == COMBAT_TYPE_OCCUPY_PLAYER then
		return "资源争夺"
	elseif arg_47_0.combatType == COMBAT_TYPE_OCCUPY_CITY then
		return "城池争夺"
	elseif arg_47_0.combatType == COMBAT_TYPE_ARENA then
		return "斗帅宫"
	elseif arg_47_0.combatType == COMBAT_TYPE_ARENARECORD then
		return "斗帅宫回放"
	elseif arg_47_0.combatType == COMBAT_TYPE_FRIEND then
		return "好友切磋"
	elseif arg_47_0.combatType == COMBAT_TYPE_RANDROB then
		return "马车资源争夺"
	else
		return ""
	end
end

function var_0_0.getLegendEnergy(arg_48_0)
	return arg_48_0.combatData.myLegend.energy
end

function var_0_0.getLegend(arg_49_0)
	return arg_49_0.combatData.myLegend
end

function var_0_0.getEnemyLegend(arg_50_0)
	return arg_50_0.combatData.enemyLegend
end

function var_0_0.isFighting(arg_51_0)
	return g_GameStateMachine.m_eState == GameState_Scene and g_MainScene ~= nil and g_MainScene.wndCombat ~= nil and g_MainScene.wndCombat.isShow
end
