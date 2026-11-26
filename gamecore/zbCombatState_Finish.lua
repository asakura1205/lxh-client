zbCombatState_Finish = class("zbCombatState_Finish")
zbCombatState_Finish.__index = zbCombatState_Finish

local var_0_0 = 2

function zbCombatState_Finish.create(arg_1_0, arg_1_1)
	local var_1_0 = zbCombatState_Finish.new()

	var_1_0:init(arg_1_1)

	return var_1_0
end

function zbCombatState_Finish.init(arg_2_0, arg_2_1)
	arg_2_0.talking = true
	arg_2_0.stateId = arg_2_1
	arg_2_0.recvLevelResultAck = false
	arg_2_0.recvArenaResultAck = false
	arg_2_0.recvFriendResultAck = false
	arg_2_0.recvFriendBossResultAck = false
	arg_2_0.recvChatResultAck = false
	arg_2_0.recvYuanzhengResultAck = false
	arg_2_0.recvPataResultAck = false
	arg_2_0.recvHeroTrialResultAck = false
	arg_2_0.recvLegionBossResultAck = false
	arg_2_0.recvWorldBossResultAck = false
	arg_2_0.recvWorldResInfoResultAck = false
	arg_2_0.recvHorseResultAck = false
	arg_2_0.recvLegionWarBuildResultAck = false
	arg_2_0.recvLegionWarDailyResultAck = false
	arg_2_0.recvLegionWarPlayResultAck = false
	arg_2_0.recordArenaFightOver = false
	arg_2_0.sendUIEvent = false
	arg_2_0.accumTime = 0
	arg_2_0.sendResultAccumTime = 0
	arg_2_0.sendResultCount = 0
	arg_2_0.notityNode = CCNode:create()

	arg_2_0.notityNode:retain()
	g_GameEventMgr:registerEvent(arg_2_0.notityNode, function()
		arg_2_0:onLevelBattleResultSynAck()
	end, zbGameEvent.Event_LevelBattleResultSyn_Ack)
	g_GameEventMgr:registerEvent(arg_2_0.notityNode, function()
		arg_2_0:onArenaBattleResultSynAck()
	end, zbGameEvent.Event_ArenaFightResultSyn_Ack)
	g_GameEventMgr:registerEvent(arg_2_0.notityNode, function()
		arg_2_0:onArenaFightRecordEndAck()
	end, zbGameEvent.Event_ArenaFightRecordEnd_Ack)
	g_GameEventMgr:registerEvent(arg_2_0.notityNode, function()
		arg_2_0:onTrialFightResultAck()
	end, zbGameEvent.Event_Trial_FightResultAck)
	g_GameEventMgr:registerEvent(arg_2_0.notityNode, function()
		arg_2_0:onFriendBattleResultSynAck()
	end, zbGameEvent.Event_FriendFightResultSyn_Ack)
	g_GameEventMgr:registerEvent(arg_2_0.notityNode, function()
		arg_2_0:onFriendBossBattleResultSynAck()
	end, zbGameEvent.Event_FriendBossFightResultSyn_Ack)
	g_GameEventMgr:registerEvent(arg_2_0.notityNode, function()
		arg_2_0:onChatBattleResultSynAck()
	end, zbGameEvent.Event_ChatFightResultSyn_Ack)
	g_GameEventMgr:registerEvent(arg_2_0.notityNode, function()
		arg_2_0:onYuanzhengBattleResultSynAck()
	end, zbGameEvent.Event_Yuanzheng_FightResult_Ack)
	g_GameEventMgr:registerEvent(arg_2_0.notityNode, function()
		arg_2_0:onPataFightRecordEndAck()
	end, zbGameEvent.Event_Pata_FightResult_Ack)
	g_GameEventMgr:registerEvent(arg_2_0.notityNode, function()
		arg_2_0:onLegionBossBattleResultSynAck()
	end, zbGameEvent.Event_LegionBossFightResultSyn_Ack)
	g_GameEventMgr:registerEvent(arg_2_0.notityNode, function()
		arg_2_0:onWorldBossBattleResultSynAck()
	end, zbGameEvent.Event_WorldBossFightResult_Ack)
	g_GameEventMgr:registerEvent(arg_2_0.notityNode, function()
		arg_2_0:onLegionWarDailyResultSynAck()
	end, zbGameEvent.Event_LegionWarDailyResult_Ack)
	g_GameEventMgr:registerEvent(arg_2_0.notityNode, function()
		arg_2_0:onLegionWarBuildResultSynAck()
	end, zbGameEvent.Event_LegionWarBuildResult_Ack)
	g_GameEventMgr:registerEvent(arg_2_0.notityNode, function()
		arg_2_0:onLegionWarPlayResultSynAck()
	end, zbGameEvent.Event_LegionWarPlayResult_Ack)
	g_GameEventMgr:registerEvent(arg_2_0.notityNode, function()
		arg_2_0:onWorldResInfoFightResultAck()
	end, zbGameEvent.Event_WorldRes_FightResult_Ack)
	g_GameEventMgr:registerEvent(arg_2_0.notityNode, function()
		arg_2_0:onHorseBattleResultSynAck()
	end, zbGameEvent.Event_WorldHorse_FightResult_Ack)
end

function zbCombatState_Finish.free(arg_19_0)
	g_GameEventMgr:unregisterEvent(arg_19_0.notityNode, zbGameEvent.Event_LevelBattleResultSyn_Ack)
	g_GameEventMgr:unregisterEvent(arg_19_0.notityNode, zbGameEvent.Event_ArenaFightResultSyn_Ack)
	g_GameEventMgr:unregisterEvent(arg_19_0.notityNode, zbGameEvent.Event_ArenaFightRecordEnd_Ack)
	g_GameEventMgr:unregisterEvent(arg_19_0.notityNode, zbGameEvent.Event_Trial_FightResultAck)
	g_GameEventMgr:unregisterEvent(arg_19_0.notityNode, zbGameEvent.Event_FriendFightResultSyn_Ack)
	g_GameEventMgr:unregisterEvent(arg_19_0.notityNode, zbGameEvent.Event_FriendBossFightResultSyn_Ack)
	g_GameEventMgr:unregisterEvent(arg_19_0.notityNode, zbGameEvent.Event_ChatFightResultSyn_Ack)
	g_GameEventMgr:unregisterEvent(arg_19_0.notityNode, zbGameEvent.Event_Yuanzheng_FightResult_Ack)
	g_GameEventMgr:unregisterEvent(arg_19_0.notityNode, zbGameEvent.Event_Pata_FightResult_Ack)
	g_GameEventMgr:unregisterEvent(arg_19_0.notityNode, zbGameEvent.Event_LegionBossFightResultSyn_Ack)
	g_GameEventMgr:unregisterEvent(arg_19_0.notityNode, zbGameEvent.Event_WorldBossFightResult_Ack)
	g_GameEventMgr:unregisterEvent(arg_19_0.notityNode, zbGameEvent.Event_WorldRes_FightResult_Ack)
end

function zbCombatState_Finish.enter(arg_20_0)
	arg_20_0.talking = true
	arg_20_0.sendResultAccumTime = 0

	g_CombatSystem.combatResult:calcFightResult()
	g_MainScene:finishCombatTalk()
	g_CombatSystem:setNormalSpeed()
end

function zbCombatState_Finish.exit(arg_21_0)
	return
end

function zbCombatState_Finish.talkOver(arg_22_0)
	arg_22_0.talking = false
	arg_22_0.recvLevelResultAck = false
	arg_22_0.recvFriendResultAck = false
	arg_22_0.recvFriendBossResultAck = false
	arg_22_0.recvChatResultAck = false
	arg_22_0.recvArenaResultAck = false
	arg_22_0.recvYuanzhengResultAck = false
	arg_22_0.recvPataResultAck = false
	arg_22_0.recvHeroTrialResultAck = false
	arg_22_0.recvLegionBossResultAck = false
	arg_22_0.recvWorldBossResultAck = false
	arg_22_0.recvWorldResInfoResultAck = false
	arg_22_0.recvHorseResultAck = false
	arg_22_0.recvLegionWarBuildResultAck = false
	arg_22_0.recvLegionWarDailyResultAck = false
	arg_22_0.recvLegionWarPlayResultAck = false
	arg_22_0.recordArenaFightOver = false
	arg_22_0.sendUIEvent = false
	arg_22_0.accumTime = 0

	g_MainScene.wndCombat:gatherEnergyBallImmediate()
	g_CombatSystem.combatResult:sendServerResult()

	arg_22_0.sendResultCount = 0
	arg_22_0.sendResultAccumTime = 0

	arg_22_0:playWinnerPos()
	arg_22_0:playFightCheerMusic()
end

function zbCombatState_Finish.update(arg_23_0, arg_23_1)
	if arg_23_0.talking then
		return
	end

	arg_23_0.accumTime = arg_23_0.accumTime + arg_23_1
	arg_23_0.sendResultAccumTime = arg_23_0.sendResultAccumTime + arg_23_1

	if arg_23_0.recvLevelResultAck == true and arg_23_0.sendUIEvent == false and arg_23_0.accumTime >= var_0_0 then
		g_MainScene:showBalance()

		arg_23_0.sendUIEvent = true
	end

	if arg_23_0.recvArenaResultAck == true and arg_23_0.sendUIEvent == false and arg_23_0.accumTime >= var_0_0 then
		g_MainScene:showBalance()

		arg_23_0.sendUIEvent = true
	end

	if arg_23_0.recvFriendResultAck == true and arg_23_0.sendUIEvent == false and arg_23_0.accumTime >= var_0_0 then
		g_MainScene:showBalance()

		arg_23_0.sendUIEvent = true
	end

	if arg_23_0.recvFriendBossResultAck == true and arg_23_0.sendUIEvent == false and arg_23_0.accumTime >= var_0_0 then
		g_MainScene:showFriendBossBalance()

		arg_23_0.sendUIEvent = true
	end

	if arg_23_0.recvChatResultAck == true and arg_23_0.sendUIEvent == false and arg_23_0.accumTime >= var_0_0 then
		g_MainScene:showBalance()

		arg_23_0.sendUIEvent = true
	end

	if arg_23_0.recvLegionBossResultAck == true and arg_23_0.sendUIEvent == false and arg_23_0.accumTime >= var_0_0 then
		g_MainScene:showLegionBossBalance()

		arg_23_0.sendUIEvent = true
	end

	if arg_23_0.recvWorldBossResultAck == true and arg_23_0.sendUIEvent == false and arg_23_0.accumTime >= var_0_0 then
		g_MainScene:showWorldBossBalance()

		arg_23_0.sendUIEvent = true
	end

	if arg_23_0.recvYuanzhengResultAck == true and arg_23_0.sendUIEvent == false and arg_23_0.accumTime >= var_0_0 then
		g_MainScene:showBalance()

		arg_23_0.sendUIEvent = true
	end

	if arg_23_0.recordArenaFightOver == true and arg_23_0.accumTime >= var_0_0 then
		g_MainScene:showBalance()

		arg_23_0.recordArenaFightOver = false
		arg_23_0.sendUIEvent = true
	end

	if arg_23_0.recvPataResultAck == true and arg_23_0.sendUIEvent == false and arg_23_0.accumTime >= var_0_0 then
		g_MainScene:doShowPataBalance()

		arg_23_0.sendUIEvent = true
	end

	if arg_23_0.recvLegionWarDailyResultAck == true and arg_23_0.sendUIEvent == false and arg_23_0.accumTime >= var_0_0 then
		g_MainScene:showBalance()

		arg_23_0.sendUIEvent = true
	end

	if arg_23_0.recvLegionWarPlayResultAck == true and arg_23_0.sendUIEvent == false and arg_23_0.accumTime >= var_0_0 then
		g_MainScene:showBalance()

		arg_23_0.sendUIEvent = true
	end

	if arg_23_0.recvLegionWarBuildResultAck == true and arg_23_0.sendUIEvent == false and arg_23_0.accumTime >= var_0_0 then
		g_MainScene:showLegionWarBalanceWnd()

		arg_23_0.sendUIEvent = true
	end

	if arg_23_0.recvHeroTrialResultAck == true and arg_23_0.sendUIEvent == false and arg_23_0.accumTime >= var_0_0 then
		g_MainScene:showBalance()

		arg_23_0.sendUIEvent = true
	end

	if arg_23_0.recvWorldResInfoResultAck == true and arg_23_0.sendUIEvent == false and arg_23_0.accumTime >= var_0_0 then
		g_MainScene:showBalance(true)

		arg_23_0.sendUIEvent = true
	end

	if arg_23_0.recvHorseResultAck == true and arg_23_0.sendUIEvent == false and arg_23_0.accumTime >= var_0_0 then
		g_MainScene:showBalance()

		arg_23_0.sendUIEvent = true
	end

	if arg_23_0.sendUIEvent == false and arg_23_0.sendResultAccumTime > NET_TIMEOUT then
		if arg_23_0.sendResultCount == 0 then
			arg_23_0.sendResultAccumTime = 0
			arg_23_0.sendResultCount = arg_23_0.sendResultCount + 1

			g_CombatSystem.combatResult:sendServerResult()
		elseif arg_23_0.sendResultCount == 1 then
			local function var_23_0()
				g_CombatSystem:resume()
				g_CombatSystem:finish()
				g_MainScene.wndCombat:hide()

				if g_CombatSystem.combatType == COMBAT_TYPE_OCCUPY_CITY then
					g_Self.kWorldHandler:openWorld()

					return
				elseif g_CombatSystem.combatType == COMBAT_TYPE_LEGIONBATTLE then
					if g_GameData.LegionId > 0 then
						g_NetMsgHandler:LegionInfo_Req()
					else
						g_MainScene:showLegionNoJoinWnd()
					end

					return
				end

				if g_CombatSystem.combatType ~= COMBAT_TYPE_ARENARECORD and g_MainScene.wndEmbattle then
					g_MainScene.wndEmbattle:gotoPrevWnd()
				end
			end

			g_MessageBox:showYesNo("\xC7ף\xAC\xCD\xF8\xC2\xE7\xD2쳣\xA3\xAC\xB5\xE3\xBB\xF7ȷ\xB6\xA8\xCD˳\xF6ս\xB6\xB7\xBD\xE7\xC3档", var_23_0, var_23_0)

			arg_23_0.sendResultCount = arg_23_0.sendResultCount + 1
			arg_23_0.sendResultAccumTime = 0
		end
	end
end

function zbCombatState_Finish.playFightCheerMusic(arg_25_0)
	if g_CombatSystem.combatResult.result >= EBattleResult.Win1 then
		g_Audio:playMusic(AudioDefine.BGM_FIGHT_CHEER_WIN)
	else
		g_Audio:playMusic(AudioDefine.BGM_FIGHT_CHEER_LOSE)
	end
end

function zbCombatState_Finish.playWinnerPos(arg_26_0)
	local var_26_0 = g_CombatSystem:getHeros(g_CombatSystem.combatResult.winForce)

	if var_26_0 ~= nil then
		for iter_26_0, iter_26_1 in pairs(var_26_0) do
			if iter_26_1:isDie() == false then
				iter_26_1:setCurrState(HeroState_Win)
			end
		end
	end
end

function zbCombatState_Finish.onLevelBattleResultSynAck(arg_27_0)
	arg_27_0.recvLevelResultAck = true
end

function zbCombatState_Finish.onArenaBattleResultSynAck(arg_28_0)
	arg_28_0.recvArenaResultAck = true
end

function zbCombatState_Finish.onFriendBattleResultSynAck(arg_29_0)
	arg_29_0.recvFriendResultAck = true
end

function zbCombatState_Finish.onFriendBossBattleResultSynAck(arg_30_0)
	arg_30_0.recvFriendBossResultAck = true
end

function zbCombatState_Finish.onChatBattleResultSynAck(arg_31_0)
	arg_31_0.recvChatResultAck = true
end

function zbCombatState_Finish.onLegionBossBattleResultSynAck(arg_32_0)
	arg_32_0.recvLegionBossResultAck = true
end

function zbCombatState_Finish.onWorldBossBattleResultSynAck(arg_33_0)
	arg_33_0.recvWorldBossResultAck = true
end

function zbCombatState_Finish.onYuanzhengBattleResultSynAck(arg_34_0)
	arg_34_0.recvYuanzhengResultAck = true
end

function zbCombatState_Finish.onArenaFightRecordEndAck(arg_35_0)
	arg_35_0.recordArenaFightOver = true
end

function zbCombatState_Finish.onPataFightRecordEndAck(arg_36_0)
	arg_36_0.recvPataResultAck = true
end

function zbCombatState_Finish.onTrialFightResultAck(arg_37_0)
	arg_37_0.recvHeroTrialResultAck = true
end

function zbCombatState_Finish.onWorldResInfoFightResultAck(arg_38_0)
	arg_38_0.recvWorldResInfoResultAck = true
end

function zbCombatState_Finish.onHorseBattleResultSynAck(arg_39_0)
	arg_39_0.recvHorseResultAck = true
end

function zbCombatState_Finish.onLegionWarDailyResultSynAck(arg_40_0)
	arg_40_0.recvLegionWarDailyResultAck = true
end

function zbCombatState_Finish.onLegionWarBuildResultSynAck(arg_41_0)
	arg_41_0.recvLegionWarBuildResultAck = true
end

function zbCombatState_Finish.onLegionWarPlayResultSynAck(arg_42_0)
	arg_42_0.recvLegionWarPlayResultAck = true
end
