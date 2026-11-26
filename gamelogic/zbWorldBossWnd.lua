require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbWorldBossWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createWorldBossWnd()
	local var_1_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_1_0:initBase()
	var_1_0:init()

	return var_1_0
end

function var_0_0.extend(arg_2_0)
	local var_2_0 = tolua.getpeer(arg_2_0)

	if not var_2_0 then
		var_2_0 = {}

		tolua.setpeer(arg_2_0, var_2_0)
	end

	setmetatable(var_2_0, var_0_0)

	return arg_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		return
	end

	local function var_3_1()
		local function var_5_0(arg_6_0, arg_6_1)
			local var_6_0 = CCSprite:create(arg_6_1)

			var_6_0:setAnchorPoint(ccp(0, 0))

			local var_6_1 = CCProgressTimer:create(var_6_0)

			var_6_1:setAnchorPoint(ccp(0, 0))
			var_6_1:setPercentage(100)
			var_6_1:setMidpoint(ccp(0, 1))
			var_6_1:setBarChangeRate(ccp(1, 0))
			var_6_1:setType(kCCProgressTimerTypeBar)
			var_6_1:retain()
			var_6_1:setPosition(1, 0)
			arg_6_0:addChild(var_6_1)

			return var_6_1
		end

		local var_5_1 = CCBProxy:create()
		local var_5_2 = CCBReaderLoad("ccbi/world_boss.ccbi", var_5_1, true, "")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCNode")

		arg_3_0.spriteAvatar = tolua.cast(var_5_3:getChildByTag(1), "CCSprite")
		arg_3_0.lbName = tolua.cast(var_5_3:getChildByTag(2), "CCLabelTTF")
		arg_3_0.nodeRank = tolua.cast(var_5_3:getChildByTag(3), "CCNode")
		arg_3_0.lbRank = tolua.cast(arg_3_0.nodeRank:getChildByTag(1), "CCLabelTTF")
		arg_3_0.lbDamage = tolua.cast(arg_3_0.nodeRank:getChildByTag(2), "CCLabelTTF")
		arg_3_0.nodeProgress = tolua.cast(var_5_3:getChildByTag(4), "CCNode")
		arg_3_0.spriteProgressBg = tolua.cast(arg_3_0.nodeProgress:getChildByTag(1), "CCSprite")
		arg_3_0.spriteProgress = var_5_0(arg_3_0.spriteProgressBg, "image/world/boss/boss_progress.png")
		arg_3_0.lbProgress = tolua.cast(arg_3_0.nodeProgress:getChildByTag(2), "CCLabelTTF")
		arg_3_0.lbFightEnd = tolua.cast(arg_3_0.nodeProgress:getChildByTag(3), "CCLabelTTF")
		arg_3_0.lbBossDesc = tolua.cast(var_5_3:getChildByTag(5), "CCLabelTTF")
		arg_3_0.nodeFight = tolua.cast(var_5_3:getChildByTag(6), "CCNode")
		arg_3_0.lbTimeDesc = tolua.cast(arg_3_0.nodeFight:getChildByTag(1), "CCLabelTTF")
		arg_3_0.lbTime = tolua.cast(arg_3_0.nodeFight:getChildByTag(2), "CCLabelTTF")
		arg_3_0.lbOpenTime = tolua.cast(arg_3_0.nodeFight:getChildByTag(3), "CCLabelTTF")
		arg_3_0.btnFight = tolua.cast(arg_3_0.nodeFight:getChildByTag(4), "CCControlButton")
		arg_3_0.nodeRelive = tolua.cast(arg_3_0.nodeFight:getChildByTag(5), "CCNode")
		arg_3_0.lbReliveTime = tolua.cast(arg_3_0.nodeRelive:getChildByTag(1), "CCLabelTTF")
		arg_3_0.spriteMoney = tolua.cast(arg_3_0.nodeRelive:getChildByTag(2), "CCLabelTTF")
		arg_3_0.lbMoney = tolua.cast(arg_3_0.nodeRelive:getChildByTag(3), "CCLabelTTF")
		arg_3_0.btnRelive = tolua.cast(arg_3_0.nodeRelive:getChildByTag(4), "CCControlButton")
		arg_3_0.btnAward = tolua.cast(arg_3_0.nodeFight:getChildByTag(6), "CCControlButton")
		arg_3_0.lbTimeRefresh = zbTimeLabel:create(arg_3_0.lbTime, a2u(""), a2u(""))
		arg_3_0.lbReliveTimeRefresh = zbTimeLabel:create(arg_3_0.lbReliveTime, a2u(""), a2u(""))

		arg_3_0.lbTimeRefresh:setCustomCallback(function()
			g_WsMsgHandler:WS_WorldBoss_GetInfo_Req()
		end)
		arg_3_0.lbReliveTimeRefresh:setCustomCallback(function()
			arg_3_0:refresh()
		end)

		arg_3_0.nodeRule = tolua.cast(var_5_3:getChildByTag(7), "CCNode")
		arg_3_0.btnRule = tolua.cast(arg_3_0.nodeRule:getChildByTag(1), "CCControlButton")
		arg_3_0.btnRank = tolua.cast(arg_3_0.nodeRule:getChildByTag(2), "CCControlButton")

		arg_3_0.btnFight:addHandleOfControlEvent(function()
			arg_3_0:onFight()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnRelive:addHandleOfControlEvent(function()
			arg_3_0:onRelive()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnAward:addHandleOfControlEvent(function()
			arg_3_0:onAward()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnRule:addHandleOfControlEvent(function()
			arg_3_0:onRule()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnRank:addHandleOfControlEvent(function()
			arg_3_0:onRank()
		end, CCControlEventTouchUpInside)

		local var_5_4 = ""

		for iter_5_0, iter_5_1 in ipairs(g_DataConfig.m_kWorldBossCfg.weekday) do
			var_5_4 = var_5_4 .. " " .. zbUtil:getWeekBig(iter_5_1)
		end

		arg_3_0.lbOpenTime:setString(a2u("ÿ\xD6\xDC") .. var_5_4 .. " " .. g_DataConfig.m_kWorldBossCfg.startTime.time .. "-" .. g_DataConfig.m_kWorldBossCfg.endTime.time .. a2u("\xBF\xAA\xC6\xF4"))
		arg_3_0.lbMoney:setString(g_DataConfig.m_kWorldBossCfg.clearCDCostDiamond)
		arg_3_0:addChild(var_5_2)
		arg_3_0:createMoneyPanel(var_5_2, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold
		}, function()
			arg_3_0:hide()
		end)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(handler(arg_3_0, arg_3_0.doShow))
	arg_3_0:setHideCallback(handler(arg_3_0, arg_3_0.doHide))
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refreshDetail()
	end, zbGameEvent.Event_WorldBoss_GetInfo_Ack)
end

function var_0_0.doShow(arg_16_0)
	if g_MainScene.wndWorld then
		g_MainScene.wndWorld.wordMap:setLayerTouchEnabled(false)
	end
end

function var_0_0.doHide(arg_17_0)
	if g_MainScene.wndWorld then
		g_MainScene.wndWorld.wordMap:setLayerTouchEnabled(true)
	end
end

function var_0_0.refresh(arg_18_0)
	arg_18_0:setVisibleFalse()
	g_WsMsgHandler:WS_WorldBoss_GetInfo_Req()
end

function var_0_0.refreshDetail(arg_19_0)
	arg_19_0:setVisibleFalse()

	local var_19_0 = g_Self.kWorldHandler.worldBossInfo
	local var_19_1 = g_Self.kWorldHandler.worldBossSelfInfo

	if zbUtil:isValidTable(var_19_1) == true then
		arg_19_0.nodeRank:setVisible(true)

		if var_19_1.Rank == 0 then
			arg_19_0.lbRank:setString(a2u("δ\xC9ϰ\xF1"))
		else
			arg_19_0.lbRank:setString(var_19_1.Rank)
		end

		arg_19_0.lbDamage:setString(var_19_1.HurtHp)
		arg_19_0.btnAward:setGray(var_19_1.AwardState ~= EWorldBossAwardState.DeadAndPartInAward and var_19_1.AwardState ~= EWorldBossAwardState.OnlyPartInAward)
	end

	if zbUtil:isValidTable(var_19_0) then
		local var_19_2 = zbHeroTable:getRecord(var_19_0.BossId)

		if var_19_2 == nil then
			arg_19_0:hide()

			return
		end

		local var_19_3 = zbIconHelper:getHeroCardIconPath(var_19_0.BossId)

		arg_19_0.spriteAvatar:setTexture(CCTextureCache:sharedTextureCache():addImage(var_19_3))
		arg_19_0.lbName:setString(var_19_2.name)
		arg_19_0.lbBossDesc:setString(var_19_2.description)
		arg_19_0.spriteAvatar:setVisible(true)
		arg_19_0.lbName:setVisible(true)
		arg_19_0.lbBossDesc:setVisible(true)
		arg_19_0.lbProgress:setVisible(true)
		arg_19_0.lbProgress:setString(a2u("ʣ\xD3\xE0Ѫ\xC1\xBF\xA3\xBA") .. var_19_0.HpPercent .. "%")
		arg_19_0.spriteProgress:setPercentage(math.min(var_19_0.HpPercent, 99))

		local var_19_4 = g_Self.kTimeHandler:getServerTime()
		local var_19_5 = false

		for iter_19_0, iter_19_1 in pairs(g_DataConfig.m_kWorldBossCfg.weekday) do
			if tonumber(os.date("%w", var_19_4)) == iter_19_1 or tonumber(os.date("%w", var_19_4)) == iter_19_1 - 7 then
				var_19_5 = true

				break
			end
		end

		if var_19_5 == false or var_19_5 == true and (zbUtil:SprintfHHMMSS(var_19_4 + g_Self.kTimeHandler:getTimeZoneDelt()) < g_DataConfig.m_kWorldBossCfg.showStartTime.time or zbUtil:SprintfHHMMSS(var_19_4 + g_Self.kTimeHandler:getTimeZoneDelt() - var_19_0.AwardTm) >= g_DataConfig.m_kWorldBossCfg.showEndTime.time) then
			arg_19_0.spriteAvatar:setGray(true)
			arg_19_0.spriteProgress:setGray(true)
			arg_19_0.lbOpenTime:setVisible(true)

			if zbUtil:isValidTable(var_19_1) == true then
				arg_19_0.lbFightEnd:setVisible(var_19_1.AwardState == EWorldBossAwardState.DeadAndPartInAward or var_19_1.AwardState == EWorldBossAwardState.OnlyPartInAward)
				arg_19_0.spriteAvatar:setGray(var_19_1.AwardState ~= EWorldBossAwardState.DeadAndPartInAward and var_19_1.AwardState ~= EWorldBossAwardState.OnlyPartInAward)
				arg_19_0.lbOpenTime:setVisible(var_19_1.AwardState ~= EWorldBossAwardState.DeadAndPartInAward and var_19_1.AwardState ~= EWorldBossAwardState.OnlyPartInAward)
				arg_19_0.btnAward:setVisible(var_19_1.AwardState == EWorldBossAwardState.DeadAndPartInAward or var_19_1.AwardState == EWorldBossAwardState.OnlyPartInAward)
			end
		else
			arg_19_0.lbTimeDesc:setVisible(true)

			local var_19_6 = zbUtil:SprintfYYYYMMDD(var_19_4) .. " " .. g_DataConfig.m_kWorldBossCfg.startTime.time
			local var_19_7 = zbUtil:GetTimeByDate(var_19_6)
			local var_19_8 = zbUtil:SprintfYYYYMMDD(var_19_4) .. " " .. g_DataConfig.m_kWorldBossCfg.showEndTime.time
			local var_19_9 = zbUtil:GetTimeByDate(var_19_8)
			local var_19_10 = zbUtil:SprintfYYYYMMDD(var_19_4) .. " " .. g_DataConfig.m_kWorldBossCfg.endTime.time
			local var_19_11 = zbUtil:GetTimeByDate(var_19_10)

			if zbUtil:SprintfHHMMSS(var_19_4 + g_Self.kTimeHandler:getTimeZoneDelt()) >= g_DataConfig.m_kWorldBossCfg.showStartTime.time and zbUtil:SprintfHHMMSS(var_19_4 + g_Self.kTimeHandler:getTimeZoneDelt()) < g_DataConfig.m_kWorldBossCfg.startTime.time then
				arg_19_0.spriteAvatar:setGray(true)
				arg_19_0.spriteProgress:setGray(true)
				arg_19_0.lbOpenTime:setVisible(true)
				arg_19_0.lbTimeDesc:setString(a2u("\xBF\xAA\xC6\xF4\xB5\xB9\xBC\xC6ʱ"))
				arg_19_0.lbTimeRefresh:start(var_19_7 - var_19_4)
				arg_19_0.nodeRank:setVisible(false)
				arg_19_0.lbProgress:setVisible(false)
			elseif var_19_0.DeadTm == 0 and zbUtil:SprintfHHMMSS(var_19_4 + g_Self.kTimeHandler:getTimeZoneDelt()) < g_DataConfig.m_kWorldBossCfg.endTime.time then
				print("BBBBBBBBBBBBBBBBBBBBBBBB")
				arg_19_0.lbTimeDesc:setString(a2u("\xBD\xE1\xCA\xF8\xB5\xB9\xBC\xC6ʱ"))
				arg_19_0.lbTimeRefresh:start(var_19_11 - var_19_4)

				if zbUtil:isValidTable(var_19_1) == true then
					if var_19_1.FightCD == -1 or var_19_4 >= var_19_1.FightCD then
						arg_19_0.btnFight:setVisible(true)
					else
						arg_19_0.nodeRelive:setVisible(true)
						arg_19_0.lbReliveTimeRefresh:start(var_19_1.FightCD - var_19_4)
					end
				else
					arg_19_0.btnFight:setVisible(true)
				end
			elseif var_19_0.DeadTm == 0 and zbUtil:SprintfHHMMSS(var_19_4 + g_Self.kTimeHandler:getTimeZoneDelt()) >= g_DataConfig.m_kWorldBossCfg.endTime.time and var_19_4 < var_19_9 + var_19_0.AwardTm then
				print("CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC")
				arg_19_0.lbTimeDesc:setString(a2u("\xBD\xE1\xCB㵹\xBC\xC6ʱ"))
				arg_19_0.lbTimeRefresh:start(var_19_9 + var_19_0.AwardTm - var_19_4)
				arg_19_0.btnAward:setVisible(true)
				arg_19_0.lbFightEnd:setVisible(true)
				arg_19_0.spriteProgress:setGray(true)
			elseif var_19_0.DeadTm ~= 0 and var_19_4 - var_19_0.DeadTm <= var_19_0.AwardTm then
				print("DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD")
				arg_19_0.lbTimeDesc:setString(a2u("\xBD\xE1\xCB㵹\xBC\xC6ʱ"))
				arg_19_0.lbTimeRefresh:start(var_19_0.DeadTm + var_19_0.AwardTm - var_19_4)
				arg_19_0.btnAward:setVisible(true)
				arg_19_0.lbFightEnd:setVisible(true)
			else
				print("FFFFFFFFFFFFFFFFFFFFFFFFFF")
				arg_19_0.lbTimeDesc:setVisible(false)
				arg_19_0.spriteAvatar:setGray(true)
				arg_19_0.lbOpenTime:setVisible(true)
				arg_19_0.spriteProgress:setGray(true)

				if zbUtil:isValidTable(var_19_1) == true then
					arg_19_0.lbFightEnd:setVisible(var_19_1.AwardState == EWorldBossAwardState.DeadAndPartInAward or var_19_1.AwardState == EWorldBossAwardState.OnlyPartInAward)
					arg_19_0.spriteAvatar:setGray(var_19_1.AwardState ~= EWorldBossAwardState.DeadAndPartInAward and var_19_1.AwardState ~= EWorldBossAwardState.OnlyPartInAward)
					arg_19_0.lbOpenTime:setVisible(var_19_1.AwardState ~= EWorldBossAwardState.DeadAndPartInAward and var_19_1.AwardState ~= EWorldBossAwardState.OnlyPartInAward)
					arg_19_0.btnAward:setVisible(var_19_1.AwardState == EWorldBossAwardState.DeadAndPartInAward or var_19_1.AwardState == EWorldBossAwardState.OnlyPartInAward)
				end
			end
		end
	else
		arg_19_0.spriteAvatar:setColor(ccc3(25, 25, 25))
		arg_19_0.spriteAvatar:setVisible(true)
		arg_19_0.lbName:setVisible(true)
		arg_19_0.lbBossDesc:setVisible(true)
		arg_19_0.spriteAvatar:setGray(true)
		arg_19_0.spriteProgress:setGray(true)
		arg_19_0.lbOpenTime:setVisible(true)
		arg_19_0.spriteProgress:setPercentage(99)
	end
end

function var_0_0.setVisibleFalse(arg_20_0)
	arg_20_0.spriteAvatar:setColor(ccc3(255, 255, 255))
	arg_20_0.spriteAvatar:setVisible(false)
	arg_20_0.lbName:setVisible(false)
	arg_20_0.lbBossDesc:setVisible(false)
	arg_20_0.spriteAvatar:setGray(false)
	arg_20_0.spriteProgress:setGray(false)
	arg_20_0.lbTimeDesc:setVisible(false)
	arg_20_0.lbTimeRefresh:clear()
	arg_20_0.nodeRank:setVisible(false)
	arg_20_0.lbProgress:setVisible(false)
	arg_20_0.lbFightEnd:setVisible(false)
	arg_20_0.lbOpenTime:setVisible(false)
	arg_20_0.btnFight:setVisible(false)
	arg_20_0.nodeRelive:setVisible(false)
	arg_20_0.btnAward:setVisible(false)
	arg_20_0.btnAward:setGray(true)
end

function var_0_0.playEffect(arg_21_0, arg_21_1)
	local function var_21_0()
		if arg_21_1.avatarId then
			local var_22_0 = zbAvatarTable:getAvatarSoundPath(arg_21_1.avatarId, ESoundType.E_PROVOKE)

			g_Audio:playSound(var_22_0)
		end
	end

	local var_21_1 = CCScaleTo:create(0.15, 1.3)
	local var_21_2 = CCScaleTo:create(0.15, 0.8)
	local var_21_3 = CCScaleTo:create(0.3, 1.2)
	local var_21_4 = CCScaleTo:create(0.2, 0.9)
	local var_21_5 = CCCallFuncN:create(var_21_0)
	local var_21_6 = CCArray:create()

	var_21_6:addObject(var_21_1)
	var_21_6:addObject(var_21_2)
	var_21_6:addObject(var_21_5)
	var_21_6:addObject(var_21_3)
	var_21_6:addObject(var_21_4)
	var_21_6:addObject(CCDelayTime:create(1))

	local var_21_7 = CCSequence:create(var_21_6)

	arg_21_0.spriteAvatar:stopAllActions()
	arg_21_0.spriteAvatar:runAction(var_21_7)
end

function var_0_0.playFadeNode(arg_23_0)
	local var_23_0 = 0.4

	local function var_23_1(arg_24_0, arg_24_1)
		local function var_24_0(arg_25_0)
			arg_25_0:setVisible(true)
		end

		local var_24_1 = CCArray:create()

		var_24_1:addObject(CCDelayTime:create(var_23_0))
		var_24_1:addObject(CCCallFuncN:create(var_24_0))
		arg_24_0:setVisible(false)
		arg_24_0:stopAllActions()
		arg_24_0:runAction(CCSequence:create(var_24_1))

		var_23_0 = var_23_0 + arg_24_1
	end

	var_23_1(arg_23_0.lbName, 0)
	var_23_1(arg_23_0.spriteType, 0)
	var_23_1(arg_23_0.lbLocation, 0.4)
	var_23_1(arg_23_0.lbBossDesc, 0)
	var_23_1(arg_23_0.skillframe, 0)
	var_23_1(arg_23_0.spriteSkill, 0)
	var_23_1(arg_23_0.lbSkill, 0)
	var_23_1(arg_23_0.lbSkillDesc, 0.4)
	var_23_1(arg_23_0.lbNotice, 0)
end

function var_0_0.onFight(arg_26_0)
	if table.getn(g_Self.kWorldHandler.worldBossBuffList) ~= 0 then
		arg_26_0:hide()
		g_MainScene:showEmbattleWorldBoss(g_Self.kWorldHandler.worldBossInfo.BossId, g_Self.kWorldHandler.worldBossBuffList)
	else
		g_MainScene:showWorldBossInspire()
	end
end

function var_0_0.onRelive(arg_27_0)
	if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Diamond, g_DataConfig.m_kWorldBossCfg.clearCDCostDiamond) == false then
		g_Bubble:bubbleInfo(a2u("\xD7\xEAʯ\xB2\xBB\xD7\xE3"))

		return
	end

	local function var_27_0()
		g_WsMsgHandler:WS_WorldBoss_ClearCD_Req()
	end

	local var_27_1 = a2u("ȷ\xB6\xA8\xBB\xA8\xB7\xD1") .. g_DataConfig.m_kWorldBossCfg.clearCDCostDiamond .. a2u("\xD7\xEAʯ\xC1\xA2\xBF̸\xB4\xBB\xEE\xC2\xF0?")

	g_MessageBox:showYesNo(var_27_1, var_27_0)
end

function var_0_0.onAward(arg_29_0)
	local var_29_0 = g_Self.kWorldHandler.worldBossSelfInfo

	if zbUtil:isValidTable(var_29_0) == true and (var_29_0.AwardState == EWorldBossAwardState.DeadAndPartInAward or var_29_0.AwardState == EWorldBossAwardState.OnlyPartInAward) then
		g_MainScene:showWorldBossAward()
	elseif zbUtil:isValidTable(var_29_0) == true and var_29_0.AwardState == EWorldBossAwardState.HasDone then
		g_Bubble:bubbleInfo(a2u("\xD2Ѿ\xAD\xC1\xECȡ"))
	elseif zbUtil:isValidTable(var_29_0) == true and var_29_0.AwardState == EWorldBossAwardState.InCD then
		g_Bubble:bubbleInfo(a2u("\xB5\xB9\xBC\xC6ʱ\xD6У\xAC\xB2\xBB\xC4\xDC\xC1\xECȡ"))
	else
		g_Bubble:bubbleInfo(a2u("δ\xB4ﵽҪ\xC7\xF3"))
	end
end

function var_0_0.onRule(arg_30_0)
	g_MainScene:showRuleWnd(RuleType_WorldBoss)
end

function var_0_0.onRank(arg_31_0)
	g_WsMsgHandler:WS_WorldBoss_DamageRank_Req()
end
