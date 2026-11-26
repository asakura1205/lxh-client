require("gamecore.zbCombatPlayer")
require("gamecore.zbCombatFocus")
require("gamecore.zbCombatQte")

local var_0_0 = class("zbCombatData")

var_0_0.__index = var_0_0

function createCombatData(arg_1_0)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0)

	return var_1_0
end

function createCombatData()
	local var_2_0 = var_0_0.new()

	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	arg_3_0.balanceAckData = nil
	arg_3_0.result = 0
	arg_3_0.awardList = nil
	arg_3_0.awardRank = 0
	arg_3_0.leftPlayer = nil
	arg_3_0.rightPlayer = nil
	arg_3_0.backupRoleLevel = g_GameData.BaseInfo.Level
	arg_3_0.isRecordPlay = false
	arg_3_0.recordLeftWin = -1
	arg_3_0.recordLeftTotalHp = 1
	arg_3_0.recordRightTotalHp = 1
	arg_3_0.lastLevelStar = 0
	arg_3_0.combatFocus = createCombatFocus()
	arg_3_0.combatQte = createCombatQte()

	g_CombatRound.sequenceRound:resetAccumRound()
end

function var_0_0.free(arg_4_0)
	if arg_4_0.leftPlayer ~= nil then
		arg_4_0.leftPlayer:free()
		arg_4_0.rightPlayer:free()
	end
end

function var_0_0.createPlayData(arg_5_0, arg_5_1)
	g_CombatBubble:clear()
	g_DarkNode:clear()
	g_EffectSystem:clear()
	zbCombatFormula:setRandomSeed(arg_5_1.RandomSeed)
	g_CombatRound:setMaxRound(arg_5_1.MaxRound)

	arg_5_0.leftPlayer = createCombatPlayer(ForceType.Left, arg_5_1.SelfBaseInfo[1], arg_5_1.SelfFormation)
	arg_5_0.rightPlayer = createCombatPlayer(ForceType.Right, arg_5_1.EnemyBaseInfo[1], arg_5_1.EnemyFormation)

	if arg_5_1.SelfBaseInfo[1] ~= nil and arg_5_1.SelfBaseInfo[1].PlayerId == g_Self:getPlayerId() then
		arg_5_0.myLegend = arg_5_0.leftPlayer.legend
		arg_5_0.enemyLegend = arg_5_0.rightPlayer.legend
	elseif arg_5_1.EnemyBaseInfo[1] ~= nil and arg_5_1.EnemyBaseInfo[1].PlayerId == g_Self:getPlayerId() then
		arg_5_0.myLegend = arg_5_0.rightPlayer.legend
		arg_5_0.enemyLegend = arg_5_0.leftPlayer.legend
	else
		arg_5_0.myLegend = arg_5_0.leftPlayer.legend
		arg_5_0.enemyLegend = arg_5_0.rightPlayer.legend
	end

	g_CombatStateMachine:setCurrState(CombatState_Ready)
	g_MainScene:showCombat()
end

function var_0_0.update(arg_6_0, arg_6_1)
	arg_6_0.leftPlayer:update(arg_6_1)
	arg_6_0.rightPlayer:update(arg_6_1)
	arg_6_0.combatFocus:update(arg_6_1)
	arg_6_0.combatQte:update(arg_6_1)
end

function var_0_0.setLevelBattleReadyAckData(arg_7_0, arg_7_1)
	arg_7_0.levelBattleReadyAckData = arg_7_1

	arg_7_0:createPlayData(arg_7_1.BattleInfo)

	arg_7_0.lastLevelStar = g_Self.kWarPathHandler:getLevelStar(arg_7_0.levelBattleReadyAckData.LevelType, arg_7_0.levelBattleReadyAckData.ForceId, arg_7_0.levelBattleReadyAckData.LevelId)
end

function var_0_0.setTrailReadyAckData(arg_8_0, arg_8_1)
	arg_8_0.trailReadyAckData = arg_8_1

	arg_8_0:createPlayData(arg_8_1.BattleInfo)
end

function var_0_0.setArenaBattleReadyAckData(arg_9_0, arg_9_1)
	arg_9_0.arenaFightReadyAckData = arg_9_1

	arg_9_0:createPlayData(arg_9_1.BattleInfo)
end

function var_0_0.setPataBattleReadyAckData(arg_10_0, arg_10_1)
	arg_10_0.pataFightReadyAckData = arg_10_1

	arg_10_0:createPlayData(arg_10_1.BattleInfo)
end

function var_0_0.setYuanzhengBattleReadyAckData(arg_11_0, arg_11_1)
	arg_11_0.yuanZhengFightReadyAckData = arg_11_1

	arg_11_0:createPlayData(arg_11_1.BattleInfo)
end

function var_0_0.setFriendBattleReadyAckData(arg_12_0, arg_12_1)
	arg_12_0.friendFightReadyAckData = arg_12_1

	arg_12_0:createPlayData(arg_12_1.BattleInfo)
end

function var_0_0.setFriendBossBattleReadyAckData(arg_13_0, arg_13_1)
	arg_13_0.friendBossReadyAckData = arg_13_1

	arg_13_0:createPlayData(arg_13_1.BattleInfo)
end

function var_0_0.setLegionBossBattleReadyAckData(arg_14_0, arg_14_1)
	arg_14_0.legionBossFightReadyAckData = arg_14_1

	arg_14_0:createPlayData(arg_14_1.BattleInfo)
end

function var_0_0.setLegionWarBattleReadyAckData(arg_15_0, arg_15_1)
	arg_15_0.legionWarFightReadyAckData = arg_15_1

	arg_15_0:createPlayData(arg_15_1.BattleInfo)
end

function var_0_0.setLegionWarPlayBattleAck(arg_16_0, arg_16_1)
	arg_16_0.legionWarPlayReadyAckData = arg_16_1

	arg_16_0:createPlayData(arg_16_1.BattleInfo)
end

function var_0_0.setLegionWarBuildBattleAck(arg_17_0, arg_17_1)
	arg_17_0.legionWarBuildReadyAckData = arg_17_1

	arg_17_0:createPlayData(arg_17_1.BattleInfo)
end

function var_0_0.setWorldBossBattleReadyAckData(arg_18_0, arg_18_1)
	arg_18_0.worldBossFightReadyAckData = arg_18_1

	arg_18_0:createPlayData(arg_18_1.BattleInfo)
end

function var_0_0.setChatBattleReadyAckData(arg_19_0, arg_19_1)
	arg_19_0.chatFightReadyAckData = arg_19_1

	arg_19_0:createPlayData(arg_19_1.BattleInfo)
end

function var_0_0.setArenaFightRecordData(arg_20_0, arg_20_1)
	arg_20_0.arenaFightRecordData = arg_20_1

	arg_20_0:createPlayData(arg_20_1.BattleInfo)
	arg_20_0:checkRecordData()
end

function var_0_0.setCombatTestData(arg_21_0, arg_21_1)
	arg_21_0.combatTestData = arg_21_1

	arg_21_0:createPlayData(arg_21_1.BattleInfo)
end

function var_0_0.setOccupyResFightReadyAckData(arg_22_0, arg_22_1)
	arg_22_0.occupyResFightReadyAckData = arg_22_1

	arg_22_0:createPlayData(arg_22_1.BattleInfo)
end

function var_0_0.setHorseBattleReadyAckData(arg_23_0, arg_23_1)
	arg_23_0.horseFightReadyAckData = arg_23_1

	arg_23_0:createPlayData(arg_23_1.BattleInfo)
end

function var_0_0.getTrialType(arg_24_0)
	if arg_24_0.trailReadyAckData == nil then
		return 0
	else
		return arg_24_0.trailReadyAckData.TrialType
	end
end

function var_0_0.getLastLevelStar(arg_25_0)
	return arg_25_0.lastLevelStar
end

function var_0_0.getLevelType(arg_26_0)
	if arg_26_0.levelBattleReadyAckData ~= nil then
		return arg_26_0.levelBattleReadyAckData.LevelType
	else
		return 0
	end
end

function var_0_0.getLevelId(arg_27_0)
	if arg_27_0.levelBattleReadyAckData ~= nil then
		return arg_27_0.levelBattleReadyAckData.LevelId
	else
		return 0
	end
end

function var_0_0.isLevelType(arg_28_0)
	return arg_28_0.levelBattleReadyAckData ~= nil
end

function var_0_0.getBossHero(arg_29_0)
	local var_29_0 = g_CombatSystem:getHeros(ForceType.Right, true)

	for iter_29_0, iter_29_1 in pairs(var_29_0) do
		if iter_29_1:isHasBossHalo() then
			return iter_29_1
		end
	end

	return nil
end

function var_0_0.checkRecordData(arg_30_0)
	arg_30_0.isRecordPlay = true
	arg_30_0.recordLeftWin = -1

	if arg_30_0.arenaFightRecordData.BattleInfo.SelfBaseInfo[1].PlayerId == g_Self:getPlayerId() then
		if g_CombatArenaRecordResult == 1 then
			arg_30_0.recordLeftWin = 1
		else
			arg_30_0.recordLeftWin = 0
		end
	elseif arg_30_0.arenaFightRecordData.BattleInfo.EnemyBaseInfo[1].PlayerId == g_Self:getPlayerId() then
		if g_CombatArenaRecordResult == 1 then
			arg_30_0.recordLeftWin = 0
		else
			arg_30_0.recordLeftWin = 1
		end
	end

	local var_30_0 = {}

	if arg_30_0.recordLeftWin == 1 then
		var_30_0 = g_CombatSystem:getHeros(ForceType.Left, true)
	elseif arg_30_0.recordLeftWin == 0 then
		var_30_0 = g_CombatSystem:getHeros(ForceType.Right, true)
	end

	g_ShowHp = false
	g_ShowBubble = false

	for iter_30_0, iter_30_1 in pairs(var_30_0) do
		iter_30_1:addBuffMaxHp(0.1)
	end

	g_ShowHp = true
	g_ShowBubble = true
	arg_30_0.recordLeftTotalHp = arg_30_0.leftPlayer:getMaxTotalHp()
	arg_30_0.recordRightTotalHp = arg_30_0.rightPlayer:getMaxTotalHp()
end

function var_0_0.checkRecordHeroDied(arg_31_0, arg_31_1)
	if arg_31_0.isRecordPlay == false then
		return
	end

	local function var_31_0()
		if arg_31_0.recordLeftWin == 1 then
			return arg_31_0.leftPlayer:getLivedHeroCount() <= arg_31_0.rightPlayer:getLivedHeroCount() or arg_31_0.leftPlayer:getCurTotalHp() / arg_31_0.recordLeftTotalHp < arg_31_0.rightPlayer:getCurTotalHp() / arg_31_0.recordRightTotalHp
		elseif arg_31_0.recordLeftWin == 0 then
			return arg_31_0.rightPlayer:getLivedHeroCount() <= arg_31_0.leftPlayer:getLivedHeroCount() or arg_31_0.rightPlayer:getCurTotalHp() / arg_31_0.recordRightTotalHp < arg_31_0.leftPlayer:getCurTotalHp() / arg_31_0.recordLeftTotalHp
		else
			return false
		end
	end

	local function var_31_1(arg_33_0, arg_33_1)
		if arg_33_1 then
			arg_33_0.recordExtraDodge = math.min(arg_33_0.recordExtraDodge + 200, 1000)
			arg_33_0.recordExtraViolent = math.min(arg_33_0.recordExtraViolent + 200, 1000)
			arg_33_0.recordExtraResist = math.min(arg_33_0.recordExtraResist + 0.25, 1)
			arg_33_0.recordExtraMagicResist = math.min(arg_33_0.recordExtraResist + 0.25, 1)
		else
			arg_33_0.recordExtraDodge = 0
			arg_33_0.recordExtraViolent = 0
			arg_33_0.recordExtraResist = 0
			arg_33_0.recordExtraMagicResist = 0
		end
	end

	local var_31_2 = var_31_0()
	local var_31_3 = {}

	if arg_31_0.recordLeftWin == 1 then
		var_31_3 = g_CombatSystem:getHeros(ForceType.Left, true)
	elseif arg_31_0.recordLeftWin == 0 then
		var_31_3 = g_CombatSystem:getHeros(ForceType.Right, true)
	end

	for iter_31_0, iter_31_1 in pairs(var_31_3) do
		var_31_1(iter_31_1, var_31_2)
	end
end

function var_0_0.setBalanceAwards(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4)
	if arg_34_4 == nil then
		arg_34_4 = 0
	end

	arg_34_0.balanceAckData = arg_34_1
	arg_34_0.result = arg_34_2
	arg_34_0.awardList = arg_34_3
	arg_34_0.awardRank = arg_34_4
end

function var_0_0.execInitPassiveSkill(arg_35_0, arg_35_1)
	for iter_35_0, iter_35_1 in pairs(arg_35_1) do
		arg_35_0.leftPlayer.legend:execInitPassiveSkill(iter_35_1)
		arg_35_0.rightPlayer.legend:execInitPassiveSkill(iter_35_1)
	end
end
