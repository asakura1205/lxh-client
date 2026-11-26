require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbShowFriendBossWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createShowFriendBossWnd()
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
		arg_3_0.items = {}
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
			var_6_1:setPosition(0, 0)
			arg_6_0:addChild(var_6_1)

			return var_6_1
		end

		local var_5_1 = CCBProxy:create()
		local var_5_2 = CCBReaderLoad("ccbi/show_friendboss.ccbi", var_5_1, true, "")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCNode")

		arg_3_0.spriteAvatar = tolua.cast(var_5_3:getChildByTag(1), "CCSprite")

		local var_5_4 = tolua.cast(var_5_3:getChildByTag(2), "CCNode")

		arg_3_0.lbName = tolua.cast(var_5_4:getChildByTag(1), "CCLabelTTF")
		arg_3_0.lbTimeDummy = tolua.cast(var_5_4:getChildByTag(2), "CCLabelTTF")
		arg_3_0.spriteType = tolua.cast(var_5_4:getChildByTag(3), "CCSprite")
		arg_3_0.nodeName = var_5_4
		arg_3_0.lbTime = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbTimeDummy, arg_3_0.lbTime)
		arg_3_0.lbTime:setScale(0.6)

		arg_3_0.lbRefreshTime = zbTimeLabel:create(arg_3_0.lbTime, "", "")

		local var_5_5 = tolua.cast(var_5_3:getChildByTag(3), "CCNode")

		arg_3_0.spriteProBg = tolua.cast(var_5_5:getChildByTag(1), "CCSprite")
		arg_3_0.lbSurPlus = tolua.cast(var_5_5:getChildByTag(2), "CCLabelTTF")
		arg_3_0.progressHP = var_5_0(arg_3_0.spriteProBg, "image/world/boss/boss_progress.png")
		arg_3_0.nodeHP = var_5_5
		arg_3_0.lbLocation = tolua.cast(var_5_3:getChildByTag(4), "CCLabelTTF")

		local var_5_6 = tolua.cast(var_5_3:getChildByTag(5), "CCNode")

		for iter_5_0 = 1, 4 do
			local var_5_7 = tolua.cast(var_5_6:getChildByTag(iter_5_0), "CCLayer")

			var_5_7:setVisible(false)

			local var_5_8 = createItem()

			var_5_8:setPosition(var_5_7:getPosition())
			var_5_8:setScale(0.7)
			var_5_8:setNeedTip(true)
			var_5_8:setSupportTouchDownTip(false)
			var_5_8:setSupportTouchTip(true)
			var_5_6:addChild(var_5_8)

			arg_3_0.items[iter_5_0] = var_5_8
		end

		arg_3_0.nodeAward = var_5_6

		local var_5_9 = tolua.cast(var_5_3:getChildByTag(6), "CCNode")

		arg_3_0.lbFightNum = tolua.cast(var_5_9:getChildByTag(1), "CCLabelTTF")
		arg_3_0.btnFight = tolua.cast(var_5_9:getChildByTag(2), "CCControlButton")
		arg_3_0.nodeFight = var_5_9
		arg_3_0.btnClose = tolua.cast(var_5_3:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:setSoundTag(SOUNDTAG_GUIDE)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:onClose()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnFight:addHandleOfControlEvent(function()
			arg_3_0:onFight()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_2)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_9_0, arg_9_1)
	g_Self.kFriendHandler.haveNewFriendBoss = false
	g_Self.kFriendHandler.curBossInfo = arg_9_1
	arg_9_0.bossInfo = arg_9_1

	local var_9_0 = zbHeroTable:getRecord(arg_9_1.BossTid)

	if var_9_0 == nil then
		arg_9_0:hide()

		return
	end

	local var_9_1 = zbIconHelper:getHeroCardIconPath(arg_9_1.BossTid)

	arg_9_0.spriteAvatar:setTexture(CCTextureCache:sharedTextureCache():addImage(var_9_1))
	arg_9_0.spriteType:setVisible(arg_9_1.BossDegree == 2)
	arg_9_0.lbName:setString(var_9_0.name)
	arg_9_0.lbSurPlus:setString(a2u("ʣ\xD3\xE0Ѫ\xC1\xBF: ") .. arg_9_1.HpPercent .. "%")
	arg_9_0.progressHP:setPercentage(math.min(arg_9_1.HpPercent, 99))
	arg_9_0.lbFightNum:setString(a2u("\xB9\xA5\xBB\xF7\xB4\xCE\xCA\xFD: ") .. arg_9_1.TotalFightCount - arg_9_1.FightCount .. "/" .. arg_9_1.TotalFightCount)
	arg_9_0.lbRefreshTime:start(arg_9_1.EndTm - g_Self.kTimeHandler:getServerTime())

	local var_9_2 = zbFriendBossTable:getRecord(arg_9_1.Level)

	arg_9_0.lbLocation:setString(a2u(var_9_2.bossInfo[arg_9_1.BossDegree].desc))

	for iter_9_0, iter_9_1 in pairs(arg_9_0.items) do
		iter_9_1:setVisible(false)
	end

	local var_9_3 = 1

	for iter_9_2, iter_9_3 in pairs(var_9_2.bossInfo[arg_9_1.BossDegree].killAward) do
		arg_9_0.items[var_9_3]:refreshAward(iter_9_3[1], iter_9_3[2], iter_9_3[3], false, true)
		arg_9_0.items[var_9_3]:setVisible(true)

		var_9_3 = var_9_3 + 1
	end

	arg_9_0:playEffect(var_9_0)
	arg_9_0:playFadeNode()
end

function var_0_0.playEffect(arg_10_0, arg_10_1)
	local function var_10_0()
		if arg_10_1.avatarId then
			local var_11_0 = zbAvatarTable:getAvatarSoundPath(arg_10_1.avatarId, ESoundType.E_PROVOKE)

			g_Audio:playSound(var_11_0)
		end
	end

	local var_10_1 = CCScaleTo:create(0.15, 1.3)
	local var_10_2 = CCScaleTo:create(0.15, 0.8)
	local var_10_3 = CCScaleTo:create(0.3, 1.2)
	local var_10_4 = CCScaleTo:create(0.2, 0.9)
	local var_10_5 = CCCallFuncN:create(var_10_0)
	local var_10_6 = CCArray:create()

	var_10_6:addObject(var_10_1)
	var_10_6:addObject(var_10_2)
	var_10_6:addObject(var_10_5)
	var_10_6:addObject(var_10_3)
	var_10_6:addObject(var_10_4)
	var_10_6:addObject(CCDelayTime:create(1))

	local var_10_7 = CCSequence:create(var_10_6)

	arg_10_0.spriteAvatar:stopAllActions()
	arg_10_0.spriteAvatar:runAction(var_10_7)
end

function var_0_0.playFadeNode(arg_12_0)
	local var_12_0 = 0.4

	local function var_12_1(arg_13_0, arg_13_1)
		local function var_13_0(arg_14_0)
			arg_14_0:setVisible(true)
		end

		local var_13_1 = CCArray:create()

		var_13_1:addObject(CCDelayTime:create(var_12_0))
		var_13_1:addObject(CCCallFuncN:create(var_13_0))
		arg_13_0:setVisible(false)
		arg_13_0:stopAllActions()
		arg_13_0:runAction(CCSequence:create(var_13_1))

		var_12_0 = var_12_0 + arg_13_1
	end

	var_12_1(arg_12_0.nodeName, 0.25)
	var_12_1(arg_12_0.nodeHP, 0.25)
	var_12_1(arg_12_0.lbLocation, 0.25)
	var_12_1(arg_12_0.nodeAward, 0.25)
	var_12_1(arg_12_0.nodeFight, 0.25)
	var_12_1(arg_12_0.btnClose, 0.25)
end

function var_0_0.onClose(arg_15_0)
	arg_15_0:hide()
end

function var_0_0.onFight(arg_16_0)
	if arg_16_0.bossInfo.FightCount >= arg_16_0.bossInfo.TotalFightCount then
		g_Bubble:bubbleInfo(a2u("\xB4\xCE\xCA\xFD\xD2Ѿ\xAD\xD3\xC3\xCD\xEA"))

		return
	end

	g_MainScene:showEmbattleFriendBoss(arg_16_0.bossInfo)
	arg_16_0:hide()

	if g_MainScene.wndFriendBossList then
		g_MainScene.wndFriendBossList:hide()
	end

	if g_MainScene.wndWarForce then
		g_MainScene.wndWarForce:hide()
	end
end
