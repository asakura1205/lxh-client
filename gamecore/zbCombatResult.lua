require("gamecore.zbCombatPlayer")

zbCombatResult = class("zbCombatResult")
zbCombatResult.__index = zbCombatResult

function zbCombatResult.create(arg_1_0)
	local var_1_0 = zbCombatResult.new()

	var_1_0:init()

	return var_1_0
end

function zbCombatResult.init(arg_2_0)
	arg_2_0:clearData()
end

function zbCombatResult.free(arg_3_0)
	return
end

function zbCombatResult.clearData(arg_4_0)
	arg_4_0.result = EBattleResult.Fail
	arg_4_0.winForce = -1
	arg_4_0.breqCombatResult = false
end

function zbCombatResult.calcFightResult(arg_5_0)
	local var_5_0 = g_CombatSystem.combatData.leftPlayer:getTotalHeroCount()
	local var_5_1 = g_CombatSystem.combatData.leftPlayer:getLivedHeroCount()
	local var_5_2 = g_CombatSystem.combatData.rightPlayer:getTotalHeroCount()
	local var_5_3 = g_CombatSystem.combatData.rightPlayer:getLivedHeroCount()

	if g_CombatSystem:getMyForceType() == ForceType.Right then
		var_5_0 = g_CombatSystem.combatData.rightPlayer:getTotalHeroCount()
		var_5_1 = g_CombatSystem.combatData.rightPlayer:getLivedHeroCount()

		local var_5_4 = g_CombatSystem.combatData.leftPlayer:getTotalHeroCount()

		var_5_3 = g_CombatSystem.combatData.leftPlayer:getLivedHeroCount()
	end

	local var_5_5 = var_5_0 - var_5_1

	local function var_5_6()
		local var_6_0 = -1
		local var_6_1 = EBattleResult.Fail

		if var_5_1 == 0 then
			var_6_0 = ForceType.Right
			var_6_1 = EBattleResult.Fail
		elseif var_5_3 > 0 then
			var_6_0 = ForceType.Right
			var_6_1 = EBattleResult.Fail
		elseif g_CombatRound:getCurRound() > g_CombatRound.maxRound then
			var_6_0 = ForceType.Right
			var_6_1 = EBattleResult.Fail
		elseif var_5_5 == 0 then
			var_6_0 = ForceType.Left
			var_6_1 = EBattleResult.Win3
		elseif var_5_5 == 1 then
			var_6_0 = ForceType.Left
			var_6_1 = EBattleResult.Win2
		else
			var_6_0 = ForceType.Left
			var_6_1 = EBattleResult.Win1
		end

		if g_CombatSystem:getMyForceType() == ForceType.Right then
			if var_6_0 == ForceType.Left then
				var_6_0 = ForceType.Right
			elseif var_6_0 == ForceType.Right then
				var_6_0 = ForceType.Left
			end
		end

		return var_6_0, var_6_1
	end

	local function var_5_7()
		local var_7_0 = -1
		local var_7_1 = EBattleResult.Fail
		local var_7_2 = g_CombatRound:getCurRound()
		local var_7_3 = g_CombatSystem.combatData:getTrialType()

		if var_7_3 == ETrialType.LimitRoundKill then
			if var_5_1 > 0 and var_5_3 == 0 then
				if var_7_2 >= 10 then
					var_7_0 = ForceType.Left
					var_7_1 = EBattleResult.Win1
				elseif var_7_2 >= 8 then
					var_7_0 = ForceType.Left
					var_7_1 = EBattleResult.Win2
				else
					var_7_0 = ForceType.Left
					var_7_1 = EBattleResult.Win3
				end
			else
				var_7_0 = ForceType.Right
				var_7_1 = EBattleResult.Fail
			end
		elseif var_7_3 == ETrialType.LimitRoundSurvival then
			if var_5_1 >= 5 then
				var_7_0 = ForceType.Left
				var_7_1 = EBattleResult.Win3
			elseif var_5_1 >= 3 then
				var_7_0 = ForceType.Left
				var_7_1 = EBattleResult.Win2
			elseif var_5_1 >= 1 then
				var_7_0 = ForceType.Left
				var_7_1 = EBattleResult.Win1
			else
				var_7_0 = ForceType.Right
				var_7_1 = EBattleResult.Fail
			end
		elseif var_7_3 == ETrialType.ImageFight then
			var_7_0, var_7_1 = var_5_6()
		elseif var_7_3 == ETrialType.NarrowMeet then
			if var_5_3 > 0 then
				if var_5_1 > 0 then
					if g_CombatSystem.combatData.leftPlayer:getCurrHpPercent() > g_CombatSystem.combatData.rightPlayer:getCurrHpPercent() then
						var_7_0 = ForceType.Left
						var_7_1 = EBattleResult.Win1
					else
						var_7_0 = ForceType.Right
						var_7_1 = EBattleResult.Fail
					end
				else
					var_7_0 = ForceType.Right
					var_7_1 = EBattleResult.Fail
				end
			else
				local var_7_4 = g_CombatSystem.combatData.leftPlayer.maxSection - g_CombatSystem.combatData.leftPlayer.curSection

				if var_7_4 >= 3 then
					var_7_0 = ForceType.Left
					var_7_1 = EBattleResult.Win3
				elseif var_7_4 >= 2 then
					var_7_0 = ForceType.Left
					var_7_1 = EBattleResult.Win2
				elseif var_7_4 >= 1 then
					var_7_0 = ForceType.Left
					var_7_1 = EBattleResult.Win1
				else
					echo("1111111111111111111111222222222333333333333")

					var_7_0 = ForceType.Right
					var_7_1 = EBattleResult.Fail
				end
			end
		elseif var_7_3 == ETrialType.GoldCopy then
			local var_7_5 = g_CombatSystem.combatData.rightPlayer:getCurrHpPercent()

			if g_CombatSystem.combatData.rightPlayer:isAllRealDied() then
				var_7_0 = ForceType.Left
				var_7_1 = EBattleResult.Win3
			elseif var_7_5 >= 50 then
				var_7_0 = ForceType.Left
				var_7_1 = EBattleResult.Win2
			else
				var_7_0 = ForceType.Left
				var_7_1 = EBattleResult.Win1
			end
		end

		return var_7_0, var_7_1
	end

	local function var_5_8()
		local var_8_0 = -1
		local var_8_1 = EBattleResult.Fail

		if var_5_1 == 0 then
			var_8_0 = ForceType.Right
			var_8_1 = EBattleResult.Fail
		elseif var_5_3 > 0 then
			var_8_0 = ForceType.Right
			var_8_1 = EBattleResult.Fail
		elseif g_CombatSystem.combatData.leftPlayer.curSection >= 3 then
			var_8_0 = ForceType.Left
			var_8_1 = EBattleResult.Win1
		elseif g_CombatSystem.combatData.leftPlayer.curSection >= 2 then
			var_8_0 = ForceType.Left
			var_8_1 = EBattleResult.Win2
		elseif g_CombatSystem.combatData.leftPlayer.curSection >= 1 then
			var_8_0 = ForceType.Left
			var_8_1 = EBattleResult.Win3
		else
			echo("warning: invalid NightmareResult, curSection=" .. g_CombatSystem.combatData.leftPlayer.curSection)
		end

		return var_8_0, var_8_1
	end

	local function var_5_9()
		local var_9_0 = -1
		local var_9_1 = EBattleResult.Fail
		local var_9_2 = g_CombatSystem.combatData.rightPlayer:getLiveSectionCount()

		if var_5_3 > 0 then
			if var_9_2 == 1 then
				var_9_0 = ForceType.Right
				var_9_1 = EBattleResult.Win2
			elseif var_9_2 == 2 then
				var_9_0 = ForceType.Right
				var_9_1 = EBattleResult.Win1
			else
				var_9_0 = ForceType.Right
				var_9_1 = EBattleResult.Fail
			end
		else
			var_9_0 = ForceType.Left
			var_9_1 = EBattleResult.Win3
		end

		return var_9_0, var_9_1
	end

	if g_CombatSystem.combatData:getLevelType() == ELevelType.Nightmare then
		arg_5_0.winForce, arg_5_0.result = var_5_8()
	elseif g_CombatSystem.combatData:getTrialType() > 0 then
		arg_5_0.winForce, arg_5_0.result = var_5_7()
	elseif g_CombatSystem.combatData.legionWarBuildReadyAckData ~= nil then
		arg_5_0.winForce, arg_5_0.result = var_5_9()
	else
		arg_5_0.winForce, arg_5_0.result = var_5_6()
	end

	return arg_5_0.winForce, arg_5_0.result
end

function zbCombatResult.sendServerResult(arg_10_0)
	if g_MainScene.wndGodDetail then
		g_MainScene.wndGodDetail:hide()
	end

	if g_MainScene.wndBulletScreen then
		g_MainScene.wndBulletScreen:hide()
	end

	local var_10_0 = g_CombatSystem.combatData

	arg_10_0.breqCombatResult = true

	if var_10_0.levelBattleReadyAckData ~= nil then
		g_WsMsgHandler:WS_GameLevel_FightResult_Req(var_10_0.levelBattleReadyAckData.ForceId, var_10_0.levelBattleReadyAckData.LevelId, var_10_0.levelBattleReadyAckData.LevelType, arg_10_0.result)
	elseif var_10_0.yuanZhengFightReadyAckData ~= nil then
		g_WsMsgHandler:WS_Bgz_FightResult_Req(var_10_0.yuanZhengFightReadyAckData.BattleInfo.RandomSeed, arg_10_0.result)
	elseif var_10_0.arenaFightReadyAckData ~= nil then
		g_WsMsgHandler:WS_Arena_FightResult_Req(var_10_0.arenaFightReadyAckData.BattleInfo.EnemyBaseInfo[1].PlayerId, var_10_0.arenaFightReadyAckData.BattleInfo.RandomSeed, arg_10_0.result)
	elseif var_10_0.friendFightReadyAckData ~= nil then
		g_WsMsgHandler:WS_Friends_FightResult_Req(var_10_0.friendFightReadyAckData.BattleInfo.EnemyBaseInfo[1].PlayerId, var_10_0.friendFightReadyAckData.BattleInfo.RandomSeed, arg_10_0.result)
	elseif var_10_0.friendBossReadyAckData ~= nil then
		local var_10_1 = g_CombatSystem.combatData.leftPlayer:getBigBossHitHpStat()
		local var_10_2 = g_CombatSystem.combatData.rightPlayer:getBigBossCurrHpPercent()
		local var_10_3 = g_Self.kFriendHandler.curBossInfo.BossRoleId

		g_WsMsgHandler:WS_FriendsBoss_FightResult_Req(var_10_2, var_10_1, var_10_3, g_Self.kFriendHandler.curBossInfo.BossDegree)
	elseif var_10_0.chatFightReadyAckData ~= nil then
		g_WsMsgHandler:WS_Common_FightResult_Req(var_10_0.chatFightReadyAckData.BattleInfo.EnemyBaseInfo[1].PlayerId, var_10_0.chatFightReadyAckData.BattleInfo.RandomSeed, arg_10_0.result)
	elseif var_10_0.pataFightReadyAckData ~= nil then
		g_WsMsgHandler:WS_Pata_FightResult_Req(var_10_0.pataFightReadyAckData.BattleInfo.RandomSeed, arg_10_0.result)
	elseif var_10_0.legionBossFightReadyAckData ~= nil then
		local var_10_4 = g_CombatSystem.combatData.leftPlayer:getBigBossHitHpStat()
		local var_10_5 = g_CombatSystem.combatData.rightPlayer:getBigBossCurrHpPercent()
		local var_10_6 = g_Self.kLegionHandler.fightBossInfo.BossId

		g_WsMsgHandler:WS_LegionBoss_FightResult_Req(var_10_0.legionBossFightReadyAckData.BattleInfo.RandomSeed, var_10_5, var_10_4)
	elseif var_10_0.legionWarFightReadyAckData ~= nil then
		g_WsMsgHandler:WS_LegionWar_DailyFightResult_Req(var_10_0.legionWarFightReadyAckData, arg_10_0.result)
	elseif var_10_0.legionWarBuildReadyAckData ~= nil then
		g_WsMsgHandler:WS_LegionWar_BuildFightResult_Req(var_10_0.legionWarBuildReadyAckData, arg_10_0.result)
	elseif var_10_0.legionWarPlayReadyAckData ~= nil then
		g_WsMsgHandler:WS_LegionWar_PlayerFightResult_Req(var_10_0.legionWarPlayReadyAckData, arg_10_0.result)
	elseif var_10_0.worldBossFightReadyAckData ~= nil then
		local var_10_7 = g_CombatSystem.combatData.leftPlayer:getBigBossHitHpStat()
		local var_10_8 = g_CombatSystem.combatData.rightPlayer:getBigBossCurrHpPercent()

		g_WsMsgHandler:WS_WorldBoss_FightResult_Req(var_10_8, var_10_7, var_10_0.worldBossFightReadyAckData.BattleInfo.RandomSeed, var_10_0.worldBossFightReadyAckData.SelfInfo.FightCount)
	elseif var_10_0.occupyResFightReadyAckData ~= nil then
		local var_10_9 = var_10_0.occupyResFightReadyAckData

		g_WsMsgHandler:WS_WorldRes_FightResult_Req(var_10_9.NodeId, var_10_9.BattleInfo.RandomSeed, arg_10_0.result)
	elseif var_10_0.occupyPlayerFightReadyAckData ~= nil then
		local var_10_10 = var_10_0.occupyPlayerFightReadyAckData

		g_NetMsgHandler:PlayerResourceFightResult_Req(g_Self.kArenaHandler.newFormationId, g_Self.kArenaHandler.newLayOut, var_10_10.BattleInfo.RandomSeed, arg_10_0.result)
	elseif var_10_0.horseFightReadyAckData ~= nil then
		local var_10_11 = var_10_0.horseFightReadyAckData

		g_WsMsgHandler:WS_WorldSpe_HCFightResult_Req(var_10_11.BattleInfo.RandomSeed, arg_10_0.result)
	elseif var_10_0.occupyCityFightReadyAckData ~= nil then
		local var_10_12 = var_10_0.occupyCityFightReadyAckData

		g_NetMsgHandler:PlayerCityFightResult_Req(g_Self.kArenaHandler.newFormationId, g_Self.kArenaHandler.newLayOut, var_10_12.BattleInfo.RandomSeed, arg_10_0.result)
	elseif var_10_0.yuanzhengTaskFightAckData ~= nil then
		local var_10_13 = var_10_0.yuanzhengTaskFightAckData

		g_NetMsgHandler:BgzTaskFightResult_Req(g_Self.kArenaHandler.newFormationId, g_Self.kArenaHandler.newLayOut, var_10_13.BattleInfo.RandomSeed, arg_10_0.result)
	elseif var_10_0.legionFightAckData ~= nil then
		local var_10_14 = var_10_0.legionFightAckData

		g_NetMsgHandler:LegionFightMatchingMemberFightSys_Req(g_Self.kArenaHandler.newFormationId, g_Self.kArenaHandler.newLayOut, var_10_14.BattleInfo.RandomSeed, arg_10_0.result)
	elseif var_10_0.arenaFightRecordData ~= nil then
		g_GameEventMgr:sendEvent(zbGameEvent.Event_ArenaFightRecordEnd_Ack)
	elseif var_10_0.CSLiansaiAckData ~= nil then
		local var_10_15 = var_10_0.CSLiansaiAckData

		g_NetMsgHandler:CrossServerFightResult_Req(var_10_15.CSPlayerBaseInfo.ServerId, var_10_15.BattleInfo.EnemyRoleId, var_10_15.BattleInfo.RandomSeed, arg_10_0.result)
	elseif var_10_0.CSXiuluoAckData ~= nil then
		local var_10_16 = var_10_0.CSXiuluoAckData

		g_NetMsgHandler:CrossServerXLFightResult_Req(var_10_16.CSPlayerBaseInfo.ServerId, var_10_16.BattleInfo.EnemyRoleId, var_10_16.BattleInfo.RandomSeed, arg_10_0.result)
	elseif var_10_0.CSDaluandouAckData ~= nil then
		local var_10_17 = var_10_0.CSDaluandouAckData

		g_NetMsgHandler:CrossServerDLDFightResult_Req(var_10_17.CSPlayerBaseInfo.ServerId, var_10_17.BattleInfo.EnemyRoleId, var_10_17.BattleInfo.RandomSeed, arg_10_0.result)
	elseif var_10_0.trailReadyAckData ~= nil then
		local var_10_18 = 100 - g_CombatSystem.combatData.leftPlayer:getCurrHpPercent()
		local var_10_19 = 100 - g_CombatSystem.combatData.rightPlayer:getCurrHpPercent()

		g_WsMsgHandler:WS_Trial_FightResult_Req(var_10_0.trailReadyAckData.TrialType, var_10_0.trailReadyAckData.Level, var_10_19, arg_10_0.result, var_10_0.trailReadyAckData.BattleInfo.RandomSeed)
	elseif var_10_0.combatTestData ~= nil then
		g_CombatSystem:resume()
		g_CombatSystem:finish()
		g_MainScene.wndCombat:hide()

		if g_CombatSystem.combatType ~= COMBAT_TYPE_ARENARECORD and g_MainScene.wndEmbattle then
			g_MainScene.wndEmbattle:gotoPrevWnd()
		end
	end
end
