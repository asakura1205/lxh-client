require("gamelogic.zbBaseWnd")
require("gamelogic.zbEmbattleLeftItem")
require("gamelogic.zbEmbattleRightItem")
require("gamecore.zbCombatDefine")
require("gamecore.zbCombatScene")
require("gamecore.zbFormationBubble")
require("gamecore.zbHeroHelper")
require("gamecore.zbFormationHelper")
require("gamelogic.zbFormationFateTip")
require("gamelogic.zbFormationSupportTip")
require("gamelogic.zbFormationBlessTip")

zbEmbattleWnd = class("zbEmbattleWnd", zbBaseWnd)
zbEmbattleWnd.__index = zbEmbattleWnd

function zbEmbattleWnd.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbEmbattleWnd)

	return arg_1_0
end

function createEmbattleWnd()
	local var_2_0 = zbEmbattleWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function zbEmbattleWnd.init(arg_3_0)
	local function var_3_0()
		arg_3_0.lastShape = 0
		arg_3_0.battleMode = EMBATTLE_TYPE_LEVEL
		arg_3_0.levelType = -1
		arg_3_0.forceId = -1
		arg_3_0.levelId = -1
		arg_3_0.armyIndex = -1
		arg_3_0.armySubIndex = ARMY_INDEX_MAIN
		arg_3_0.arenaPlayerInfo = nil
		arg_3_0.leftItems = {}
		arg_3_0.rightItems = {}
		arg_3_0.godItems = {}
		arg_3_0.leftPosition = {}
		arg_3_0.rightPosition = {}
		arg_3_0.teamList = {}
		arg_3_0.selectList = {}
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/embattle.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCNode")
		local var_5_4 = tolua.cast(var_5_2:getChildByTag(2), "CCNode")

		arg_3_0.layerGarbages = {}
		arg_3_0.layerGarbages[1] = tolua.cast(var_5_1:getChildByTag(11), "CCNode")
		arg_3_0.layerGarbages[2] = tolua.cast(var_5_1:getChildByTag(12), "CCNode")
		arg_3_0.layerGarbages[3] = tolua.cast(var_5_1:getChildByTag(13), "CCNode")
		arg_3_0.layerGarbages[4] = tolua.cast(var_5_1:getChildByTag(14), "CCNode")
		arg_3_0.editingAnimation = createUIPoolAnimation()

		arg_3_0.editingAnimation:setScale(1)
		arg_3_0.editingAnimation:setRotationY(180)
		arg_3_0.editingAnimation:retain()
		arg_3_0.editingAnimation:setVisible(false)

		arg_3_0.layerAnimation = tolua.cast(var_5_1:getChildByTag(2), "CCNode")

		arg_3_0.layerAnimation:addChild(arg_3_0.editingAnimation)
		arg_3_0.layerAnimation:setVisible(true)

		local var_5_5 = {}

		var_5_5[1] = 1
		var_5_5[2] = 4
		var_5_5[3] = 7
		var_5_5[4] = 2
		var_5_5[5] = 5
		var_5_5[6] = 8
		var_5_5[7] = 3
		var_5_5[8] = 6
		var_5_5[9] = 9

		for iter_5_0 = 1, 9 do
			local var_5_6 = zbTableViewHelper:create()

			var_5_6:loadCCBFile("ccbi/tb_formation_slot2.ccbi")

			local var_5_7 = var_5_5[iter_5_0]
			local var_5_8 = tolua.cast(var_5_3:getChildByTag(var_5_7), "CCLayerColor")
			local var_5_9 = createEmbattleLeftItem(var_5_6:readCCBNode(), var_5_7, arg_3_0.layerGarbages, arg_3_0, var_5_7)

			var_5_9:setAnchorPoint(var_5_8:getAnchorPoint())
			var_5_9:setPosition(var_5_8:getPosition())

			arg_3_0.leftPosition[var_5_7] = ccp(var_5_8:getPosition())

			var_5_3:addChild(var_5_9)
			var_5_8:removeFromParentAndCleanup(true)

			arg_3_0.leftItems[var_5_7] = var_5_9

			var_5_6:releaseSelf()
		end

		for iter_5_1 = 1, 9 do
			local var_5_10 = zbTableViewHelper:create()

			var_5_10:loadCCBFile("ccbi/tb_formation_slot2.ccbi")

			local var_5_11 = var_5_5[iter_5_1]
			local var_5_12 = tolua.cast(var_5_4:getChildByTag(var_5_11), "CCLayerColor")
			local var_5_13 = createEmbattleRightItem(var_5_10:readCCBNode(), var_5_11, arg_3_0)

			var_5_13:setAnchorPoint(var_5_12:getAnchorPoint())
			var_5_13:setPosition(var_5_12:getPosition())

			arg_3_0.rightPosition[var_5_11] = ccp(var_5_12:getPosition())

			var_5_4:addChild(var_5_13)
			var_5_12:removeFromParentAndCleanup(true)

			arg_3_0.rightItems[var_5_11] = var_5_13

			var_5_10:releaseSelf()
		end

		arg_3_0.nodeLeftTalk = tolua.cast(var_5_3:getChildByTag(10), "CCNode")
		arg_3_0.lbLeftTalk = tolua.cast(arg_3_0.nodeLeftTalk:getChildByTag(7), "CCLabelTTF")

		arg_3_0.nodeLeftTalk:setZOrder(ZORDER_TOP)

		arg_3_0.nodeRightTalk = tolua.cast(var_5_4:getChildByTag(10), "CCNode")
		arg_3_0.lbRightTalk = tolua.cast(arg_3_0.nodeRightTalk:getChildByTag(7), "CCLabelTTF")

		arg_3_0.nodeRightTalk:setZOrder(ZORDER_TOP)

		arg_3_0.btnFight = tolua.cast(var_5_2:getChildByTag(4), "CCControlButton")
		arg_3_0.lbFormationDesc = tolua.cast(var_5_2:getChildByTag(5), "CCLabelTTF")
		arg_3_0.btnFormation = tolua.cast(var_5_1:getChildByTag(3):getChildByTag(1), "CCControlButton")
		arg_3_0.lbCombatPowerDummy = tolua.cast(var_5_1:getChildByTag(3):getChildByTag(1002), "CCLabelTTF")
		arg_3_0.nodeCurrFormation = tolua.cast(var_5_1:getChildByTag(3):getChildByTag(3), "CCNode")
		arg_3_0.btnFate = tolua.cast(var_5_1:getChildByTag(3):getChildByTag(6), "CCControlButton")
		arg_3_0.btnSupport = tolua.cast(var_5_1:getChildByTag(3):getChildByTag(7), "CCControlButton")
		arg_3_0.btnBless = tolua.cast(var_5_1:getChildByTag(3):getChildByTag(8), "CCControlButton")
		arg_3_0.lblXXX = tolua.cast(var_5_1:getChildByTag(3):getChildByTag(9), "CCLabelTTF")
		arg_3_0.spriteCurrFormation = tolua.cast(arg_3_0.nodeCurrFormation:getChildByTag(1), "CCSprite")
		arg_3_0.spriteLevel = tolua.cast(arg_3_0.nodeCurrFormation:getChildByTag(2), "CCSprite")
		arg_3_0.lbLevelDummy = tolua.cast(arg_3_0.spriteLevel:getChildByTag(1001), "CCLabelTTF")
		arg_3_0.lbLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbLevelDummy, arg_3_0.lbLevel)
		arg_3_0.lbLevel:setScale(0.55)

		arg_3_0.lbCombatPower = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbCombatPowerDummy, arg_3_0.lbCombatPower)
		arg_3_0.lbCombatPower:setScale(0.55)

		arg_3_0.nodeGod = tolua.cast(var_5_1:getChildByTag(4), "CCNode")
		arg_3_0.btnGodFrame = tolua.cast(arg_3_0.nodeGod:getChildByTag(1), "CCControlButton")
		arg_3_0.spriteGodIcon = tolua.cast(arg_3_0.nodeGod:getChildByTag(2), "CCSprite")
		arg_3_0.lbGodLevelDummy = tolua.cast(arg_3_0.nodeGod:getChildByTag(1003), "CCLabelTTF")
		arg_3_0.lbGodLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbGodLevelDummy, arg_3_0.lbGodLevel)
		arg_3_0.lbGodLevel:setScale(0.55)
		arg_3_0.btnGodFrame:addHandleOfControlEvent(function()
			arg_3_0:onSelectGodEquip()
		end, CCControlEventTouchUpInside)

		arg_3_0.nodeLeftShape = tolua.cast(var_5_1:getChildByTag(5), "CCNode")
		arg_3_0.spriteLeftShape = tolua.cast(arg_3_0.nodeLeftShape:getChildByTag(1), "CCSprite")
		arg_3_0.spriteLeftShapeName = tolua.cast(arg_3_0.spriteLeftShape:getChildByTag(1), "CCSprite")
		arg_3_0.teamHeroHead = {}
		arg_3_0.nodeTeam = tolua.cast(var_5_1:getChildByTag(6), "CCNode")

		for iter_5_2 = 1, 3 do
			local var_5_14 = tolua.cast(arg_3_0.nodeTeam:getChildByTag(iter_5_2), "CCNode")
			local var_5_15 = tolua.cast(var_5_14:getChildByTag(1), "CCControlButton")

			arg_3_0.teamHeroHead[iter_5_2] = tolua.cast(var_5_14:getChildByTag(2), "CCSprite")

			var_5_15:addHandleOfControlEvent(function()
				arg_3_0:onAddHero(iter_5_2)
			end, CCControlEventTouchUpInside)
		end

		arg_3_0.shapeBubble = zbFormationBubble:create()

		arg_3_0.nodeLeftShape:addChild(arg_3_0.shapeBubble)

		arg_3_0.fateTip = zbFormationFateTip:create(tolua.cast(arg_3_0.layerAnimation:getChildByTag(2), "CCNode"))

		arg_3_0.fateTip:hide()

		arg_3_0.supportTip = zbFormationSupportTip:create(tolua.cast(arg_3_0.layerAnimation:getChildByTag(3), "CCNode"))

		arg_3_0.supportTip:hide()

		arg_3_0.blessTip = zbFormationBlessTip:create(tolua.cast(arg_3_0.layerAnimation:getChildByTag(4), "CCLayerColor"))

		arg_3_0.blessTip:hide()
		arg_3_0.btnFight:addHandleOfControlEvent(function()
			arg_3_0:onFight()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnFormation:addHandleOfControlEvent(function()
			arg_3_0:onFormation()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnFate:addHandleOfControlEvent(function()
			arg_3_0:onFateTouchDown()
		end, CCControlEventTouchDown)
		arg_3_0.btnFate:addHandleOfControlEvent(function()
			arg_3_0:onFateTouchEnd()
		end, CCControlEventTouchEnd)
		arg_3_0.btnSupport:addHandleOfControlEvent(function()
			arg_3_0:onSupportTouchDown()
		end, CCControlEventTouchDown)
		arg_3_0.btnSupport:addHandleOfControlEvent(function()
			arg_3_0:onSupportTouchEnd()
		end, CCControlEventTouchEnd)
		arg_3_0.btnBless:addHandleOfControlEvent(function()
			arg_3_0:onBlessTouchDown()
		end, CCControlEventTouchDown)
		arg_3_0.btnBless:addHandleOfControlEvent(function()
			arg_3_0:onBlessTouchEnd()
		end, CCControlEventTouchEnd)

		arg_3_0.btnClose = tolua.cast(var_5_1:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:onClose()
		end, CCControlEventTouchUpInside)

		arg_3_0.layerScene = zbCombatScene:create()

		arg_3_0:addChild(arg_3_0.layerScene)
		arg_3_0:addChild(var_5_1)
		arg_3_0.btnFight:setSoundTag(SOUNDTAG_STARTFIGHT)
	end

	local function var_3_2()
		local function var_17_0(arg_18_0)
			local var_18_0 = CCSprite:create(NOTIFY_TAG_PATH)

			var_18_0:setPosition(135, 67)
			arg_18_0:addChild(var_18_0)
			zbUIEffect:createNotifyTagScaleAction(var_18_0)

			return var_18_0
		end

		arg_3_0.spriteFormationNotify = var_17_0(arg_3_0.btnFormation)
	end

	var_3_0()
	var_3_1()
	var_3_2()
	arg_3_0:setHideCallback(function()
		arg_3_0:onHide()
	end)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:hide()
	end, zbGameEvent.Event_LevelBattleReady_Ack)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:hide()
	end, zbGameEvent.Event_Trial_FightStart_Ack)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:hide()
	end, zbGameEvent.Event_ArenaFight_Ack)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:hide()
	end, zbGameEvent.Event_FriendFight_Ack)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:hide()
	end, zbGameEvent.Event_ChatFight_Ack)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:hide()
	end, zbGameEvent.Event_PataFight_Ack)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:hide()
	end, zbGameEvent.Event_YuanzhengFight_Ack)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:hide()
	end, zbGameEvent.Event_WorldResFight_Ack)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:hide()
	end, zbGameEvent.Event_WorldHorseFight_Ack)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:hide()
	end, zbGameEvent.Event_LegionBossFight_Ack)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:hide()
	end, zbGameEvent.Event_LegionWarFight_Ack)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onFormationChanged()
	end, zbGameEvent.Event_Update_Formation)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refreshGodEquip()
	end, zbGameEvent.Event_Update_GodInfo)
end

function zbEmbattleWnd.doDestroy(arg_33_0)
	arg_33_0.layerScene:free()
end

function zbEmbattleWnd.onShow(arg_34_0)
	arg_34_0.lblXXX:setVisible(false)
	arg_34_0.btnFate:setVisible(false)
	arg_34_0.nodeLeftShape:setVisible(false)
	arg_34_0.btnClose:setVisible(true)

	if g_MainScene:isWndVisible(g_MainScene.wndWorld) then
		g_MainScene.wndWorld:setVisible(false)
		g_MainScene.wndWorld.wordMap:setLayerTouchEnabled(false)
	end

	if g_MainScene:isWndVisible(g_MainScene.wndPata) then
		g_MainScene.wndPata:setVisible(false)
	end

	if g_MainScene:isWndVisible(g_MainScene.wndYuanZheng) then
		g_MainScene.wndYuanZheng:setVisible(false)
	end

	if g_MainScene:isWndVisible(g_MainScene.wndHeroTrial) then
		g_MainScene.wndHeroTrial:setVisible(false)
	end

	if arg_34_0.battleMode == EMBATTLE_TYPE_LEVEL and arg_34_0.levelType == ELevelType.Nightmare then
		arg_34_0.nodeTeam:setVisible(true)
	else
		arg_34_0.nodeTeam:setVisible(false)
	end
end

function zbEmbattleWnd.onHide(arg_35_0)
	arg_35_0.supportTip:hide()
	arg_35_0.fateTip:hide()
	arg_35_0.blessTip:hide()

	for iter_35_0, iter_35_1 in pairs(arg_35_0.leftItems) do
		iter_35_1:free()
	end

	for iter_35_2, iter_35_3 in pairs(arg_35_0.rightItems) do
		iter_35_3:free()
	end

	g_Audio.preLoadMgr:stop()
end

function zbEmbattleWnd.onClose(arg_36_0)
	arg_36_0:hide()
	arg_36_0:gotoPrevWnd()
end

function zbEmbattleWnd.gotoPrevWnd(arg_37_0)
	if g_MainScene.wndWorld and g_MainScene.wndWorld:isVisible() == false then
		g_MainScene.wndWorld:setVisible(true)
		g_MainScene.wndWorld.wordMap:setLayerTouchEnabled(true)
	end

	if g_MainScene.wndPata and g_MainScene.wndPata:isVisible() == false then
		g_MainScene.wndPata:setVisible(true)
	end

	if g_MainScene.wndYuanZheng and g_MainScene.wndYuanZheng:isVisible() == false then
		g_MainScene.wndYuanZheng:setVisible(true)
	end

	if g_MainScene.wndHeroTrial and g_MainScene.wndHeroTrial:isVisible() == false then
		g_MainScene.wndHeroTrial:setVisible(true)
	end

	if arg_37_0.battleMode == EMBATTLE_TYPE_LEVEL then
		local var_37_0

		if g_MainScene.wndWarForce ~= nil then
			var_37_0 = g_MainScene.wndWarForce.enterWay
		end

		g_MainScene:showWarForce(arg_37_0.levelType, arg_37_0.forceId, var_37_0)
	elseif arg_37_0.battleMode == EMBATTLE_TYPE_ARENA then
		g_MainScene:showArenaWnd()
	elseif arg_37_0.battleMode == EMBATTLE_TYPE_CHAT then
		g_MainScene:showChat()
	elseif arg_37_0.battleMode == EMBATTLE_TYPE_FRIEND then
		g_Self.kFriendHandler:openFriend()
	elseif arg_37_0.battleMode == EMBATTLE_TYPE_PATA then
		g_MainScene:showPataWnd()
	elseif arg_37_0.battleMode == EMBATTLE_TYPE_YUANZHENG then
		g_MainScene:showYuanZhengWnd()
	elseif arg_37_0.battleMode == EMBATTLE_TYPE_LEGIONMEM then
		g_MainScene:showLegionSceneWnd()
	elseif arg_37_0.battleMode == EMBATTLE_TYPE_WORLDRES or arg_37_0.battleMode == EMBATTLE_TYPE_WORLDHORSE or arg_37_0.battleMode == EMBATTLE_TYPE_LEGIONWAR then
		g_MainScene:showWorld()
	elseif arg_37_0.battleMode == EMBATTLE_TYPE_LEGIONBOSS then
		g_MainScene:showLegionBoss()
	elseif arg_37_0.battleMode == EMBATTLE_TYPE_WORLDBOSS then
		g_MainScene:showWorldBoss()
	end

	g_GameStateMachine:testFreeUnusedMem()
end

function zbEmbattleWnd.refreshTeamList(arg_38_0)
	local var_38_0 = zbIconHelper:getPlayerHeadIconPath(g_GameData.BaseInfo.HeadId)

	arg_38_0.teamHeroHead[1]:setTexture(CCTextureCache:sharedTextureCache():addImage(var_38_0))

	for iter_38_0 = 2, 3 do
		arg_38_0.teamHeroHead[iter_38_0]:setVisible(false)
	end

	arg_38_0.teamList = {}

	local var_38_1 = 1

	for iter_38_1, iter_38_2 in pairs(arg_38_0.selectList) do
		local var_38_2 = zbIconHelper:getPlayerHeadIconPath(iter_38_2.PlayerBaseInfo.HeadId)

		arg_38_0.teamHeroHead[var_38_1 + 1]:setTexture(CCTextureCache:sharedTextureCache():addImage(var_38_2))
		table.insert(arg_38_0.teamList, iter_38_2.PlayerBaseInfo.PlayerId)
		arg_38_0.teamHeroHead[var_38_1 + 1]:setVisible(true)

		var_38_1 = var_38_1 + 1
	end
end

function zbEmbattleWnd.refreshLevel(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	arg_39_0.selectList = {}
	arg_39_0.battleMode = EMBATTLE_TYPE_LEVEL
	arg_39_0.levelType = arg_39_1
	arg_39_0.forceId = arg_39_2
	arg_39_0.levelId = arg_39_3

	arg_39_0:refreshLeft()
	arg_39_0:refreshRight()
	arg_39_0:refreshTalk()
	arg_39_0:refreshScene()
	arg_39_0:refreshTeamList()
end

function zbEmbattleWnd.refreshArena(arg_40_0, arg_40_1)
	arg_40_0.battleMode = EMBATTLE_TYPE_ARENA
	arg_40_0.arenaPlayerInfo = arg_40_1

	arg_40_0:refreshLeft()
	arg_40_0:refreshRight()
	arg_40_0:refreshTalk()
	arg_40_0:refreshScene()
end

function zbEmbattleWnd.refreshChat(arg_41_0, arg_41_1)
	arg_41_0.battleMode = EMBATTLE_TYPE_CHAT
	arg_41_0.chatPlayerInfo = arg_41_1

	arg_41_0:refreshLeft()
	arg_41_0:refreshRight()
	arg_41_0:refreshTalk()
	arg_41_0:refreshScene()
end

function zbEmbattleWnd.refreshFriend(arg_42_0, arg_42_1)
	arg_42_0.battleMode = EMBATTLE_TYPE_FRIEND
	arg_42_0.friendPlayerInfo = arg_42_1

	arg_42_0:refreshLeft()
	arg_42_0:refreshRight()
	arg_42_0:refreshTalk()
	arg_42_0:refreshScene()
end

function zbEmbattleWnd.refreshFriendBoss(arg_43_0, arg_43_1)
	arg_43_0.battleMode = EMBATTLE_TYPE_FRIENDBOSS
	arg_43_0.friendsBossDetail = arg_43_1

	arg_43_0:refreshLeft()
	arg_43_0:refreshRight()
	arg_43_0:refreshTalk()
	arg_43_0:refreshScene()
end

function zbEmbattleWnd.refreshLegionBoss(arg_44_0, arg_44_1)
	arg_44_0.battleMode = EMBATTLE_TYPE_LEGIONBOSS
	arg_44_0.legionBossDetail = arg_44_1

	arg_44_0:refreshLeft()
	arg_44_0:refreshRight()
	arg_44_0:refreshTalk()
	arg_44_0:refreshScene()
end

function zbEmbattleWnd.refreshLegionWar(arg_45_0, arg_45_1, arg_45_2, arg_45_3, arg_45_4)
	arg_45_0.battleMode = EMBATTLE_TYPE_LEGIONWAR
	arg_45_0.warNode = arg_45_1
	arg_45_0.formaList = arg_45_2
	arg_45_0.stageIndex = arg_45_3
	arg_45_0.playId = arg_45_4

	arg_45_0:refreshLeft()
	arg_45_0:refreshRight()
	arg_45_0:refreshTalk()
	arg_45_0:refreshScene()
end

function zbEmbattleWnd.refreshLegionMem(arg_46_0, arg_46_1)
	arg_46_0.battleMode = EMBATTLE_TYPE_LEGIONMEM
	arg_46_0.legionMemPlayerInfo = arg_46_1

	arg_46_0:refreshLeft()
	arg_46_0:refreshRight()
	arg_46_0:refreshTalk()
	arg_46_0:refreshScene()
end

function zbEmbattleWnd.refreshPata(arg_47_0, arg_47_1, arg_47_2)
	arg_47_0.battleMode = EMBATTLE_TYPE_PATA
	arg_47_0.pataPlayerInfo = arg_47_1
	arg_47_0.layerIndex = arg_47_2

	arg_47_0:refreshLeft()
	arg_47_0:refreshRight()
	arg_47_0:refreshTalk()
	arg_47_0:refreshScene()
end

function zbEmbattleWnd.refreshYuanzheng(arg_48_0, arg_48_1, arg_48_2)
	arg_48_0.battleMode = EMBATTLE_TYPE_YUANZHENG
	arg_48_0.yuanzhengPlayerInfo = arg_48_1
	arg_48_0.currBtnIndex = arg_48_2

	arg_48_0:refreshLeft()
	arg_48_0:refreshRight()
	arg_48_0:refreshTalk()
	arg_48_0:refreshScene()
end

function zbEmbattleWnd.refreshTrial(arg_49_0, arg_49_1, arg_49_2)
	arg_49_0.battleMode = EMBATTLE_TYPE_TRIAL
	arg_49_0.trialType = arg_49_1
	arg_49_0.trialLevel = arg_49_2

	arg_49_0:refreshLeft()
	arg_49_0:refreshRight()
	arg_49_0:refreshTalk()
	arg_49_0:refreshScene()
end

function zbEmbattleWnd.refreshWorldRes(arg_50_0, arg_50_1)
	arg_50_0.battleMode = EMBATTLE_TYPE_WORLDRES
	arg_50_0.nodeId = arg_50_1

	arg_50_0:refreshLeft()
	arg_50_0:refreshRight()
	arg_50_0:refreshTalk()
	arg_50_0:refreshScene()
end

function zbEmbattleWnd.refreshWorldHorse(arg_51_0, arg_51_1, arg_51_2)
	arg_51_0.battleMode = EMBATTLE_TYPE_WORLDHORSE
	arg_51_0.nodeId = arg_51_1
	arg_51_0.worldHorsePlayerInfo = arg_51_2

	arg_51_0:refreshLeft()
	arg_51_0:refreshRight()
	arg_51_0:refreshTalk()
	arg_51_0:refreshScene()
	arg_51_0.btnClose:setVisible(false)
end

function zbEmbattleWnd.refreshWorldBoss(arg_52_0, arg_52_1, arg_52_2)
	arg_52_0.battleMode = EMBATTLE_TYPE_WORLDBOSS
	arg_52_0.worldBossId = arg_52_1

	arg_52_0:refreshLeft()
	arg_52_0:refreshRight()
	arg_52_0:refreshTalk()
	arg_52_0:refreshScene()
	arg_52_0.lblXXX:setVisible(table.getn(arg_52_2) ~= 0)
end

function zbEmbattleWnd.refreshScene(arg_53_0)
	function getSceneId()
		local var_54_0 = 1
		local var_54_1 = 0

		if arg_53_0.battleMode == EMBATTLE_TYPE_LEVEL then
			var_54_0 = zbForceSetTable:getSceneId(arg_53_0.levelId)
			var_54_1 = arg_53_0.levelId
		elseif arg_53_0.battleMode == EMBATTLE_TYPE_ARENA then
			var_54_0 = COMBAT_SCENE_ARENA
		elseif arg_53_0.battleMode == EMBATTLE_TYPE_TRIAL then
			if arg_53_0.trialType == ETrialType.LimitRoundKill then
				var_54_0 = COMBAT_SCENE_PATA_BIDIU
			elseif arg_53_0.trialType == ETrialType.LimitRoundSurvival then
				var_54_0 = COMBAT_SCENE_PATA_MIANMO
			elseif arg_53_0.trialType == ETrialType.ImageFight then
				var_54_0 = COMBAT_SCENE_PATA_MIRROR
			elseif arg_53_0.trialType == ETrialType.NarrowMeet then
				var_54_0 = COMBAT_SCENE_PATA_BRIDGE
			elseif arg_53_0.trialType == ETrialType.GoldCopy then
				var_54_0 = COMBAT_SCENE_PATA_LAOJUN
			end
		elseif arg_53_0.battleMode == EMBATTLE_TYPE_YUANZHENG then
			var_54_0 = COMBAT_SCENE_YUANZHENG
		elseif arg_53_0.battleMode == EMBATTLE_TYPE_WORLDRES or arg_53_0.battleMode == EMBATTLE_TYPE_WORLDHORSE then
			var_54_0 = g_Self.kWorldHandler.combatSeceneId
		end

		return var_54_0, var_54_1
	end

	g_CombatSystem.combatSceneId, g_CombatSystem.combatTalkId = getSceneId()

	arg_53_0.layerScene:load(g_CombatSystem.combatSceneId)
	arg_53_0:onShow()
end

function zbEmbattleWnd.onFight(arg_55_0)
	if g_Self.kFormation:isEmpty() then
		g_Bubble:bubbleInfo("\xC7\xEBѡ\xD4\xF1\xC9\xCF\xD5\xF3\xBB\xEF\xB0\xE9")

		return
	end

	g_Audio.preLoadMgr:stop()

	if arg_55_0.battleMode == EMBATTLE_TYPE_LEVEL then
		local var_55_0 = zbForceTable:getRecord(arg_55_0.forceId)

		if var_55_0.loginLevel > g_Self:getLevel() then
			g_Bubble:bubbleInfo(a2u("\xCD\xE6\xBC\xD2") .. var_55_0.loginLevel .. a2u("\xBC\xB6\xB2\xC5\xC4ܽ\xF8\xC8\xEB\xB8ùؿ\xA8"))

			return
		end

		g_WsMsgHandler:WS_GameLevel_FightStart_Req(arg_55_0.forceId, arg_55_0.levelId, arg_55_0.levelType, arg_55_0.teamList)
	elseif arg_55_0.battleMode == EMBATTLE_TYPE_ARENA then
		g_WsMsgHandler:WS_Arena_FightStart_Req(arg_55_0.arenaPlayerInfo.PlayerTipsInfo.PlayerId)
	elseif arg_55_0.battleMode == EMBATTLE_TYPE_CHAT then
		g_WsMsgHandler:WS_Common_FightStart_Req(arg_55_0.chatPlayerInfo.PlayerTipsInfo.PlayerId)
	elseif arg_55_0.battleMode == EMBATTLE_TYPE_FRIEND then
		g_WsMsgHandler:WS_Friends_FightStart_Req(arg_55_0.friendPlayerInfo.PlayerTipsInfo.PlayerId)
	elseif arg_55_0.battleMode == EMBATTLE_TYPE_PATA then
		g_WsMsgHandler:WS_Pata_FightStart_Req(arg_55_0.layerIndex)
	elseif arg_55_0.battleMode == EMBATTLE_TYPE_YUANZHENG then
		g_WsMsgHandler:WS_Bgz_FightStart_Req(arg_55_0.currBtnIndex)
	elseif arg_55_0.battleMode == EMBATTLE_TYPE_LEGIONMEM then
		g_WsMsgHandler:WS_Friends_FightStart_Req(arg_55_0.legionMemPlayerInfo.PlayerTipsInfo.PlayerId)
	elseif arg_55_0.battleMode == EMBATTLE_TYPE_TRIAL then
		g_WsMsgHandler:WS_Trial_FightStart_Req(arg_55_0.trialType, arg_55_0.trialLevel)
	elseif arg_55_0.battleMode == EMBATTLE_TYPE_WORLDRES then
		g_WsMsgHandler:WS_WorldRes_FightStart_Req(arg_55_0.nodeId)
	elseif arg_55_0.battleMode == EMBATTLE_TYPE_WORLDHORSE then
		g_WsMsgHandler:WS_WorldSpe_HCFightStart_Req(arg_55_0.nodeId)
	elseif arg_55_0.battleMode == EMBATTLE_TYPE_FRIENDBOSS then
		g_Self.kFriendHandler.curBossInfo = arg_55_0.friendsBossDetail

		g_WsMsgHandler:WS_FriendsBoss_FightStart_Req(arg_55_0.friendsBossDetail.BossRoleId, arg_55_0.friendsBossDetail.BossDegree)
	elseif arg_55_0.battleMode == EMBATTLE_TYPE_LEGIONBOSS then
		g_WsMsgHandler:WS_LegionBoss_StartFight_Req(arg_55_0.legionBossDetail.BossId)
	elseif arg_55_0.battleMode == EMBATTLE_TYPE_LEGIONWAR then
		if arg_55_0.stageIndex ~= nil then
			g_WsMsgHandler:WS_LegionWar_BuildFightStart_Req(arg_55_0.warNode, arg_55_0.stageIndex)
		elseif arg_55_0.playId ~= nil then
			g_WsMsgHandler:WS_LegionWar_PlayerFightStart_Req(arg_55_0.warNode, arg_55_0.playId)
		else
			g_WsMsgHandler:WS_LegionWar_DailyFightStart_Req(arg_55_0.warNode, arg_55_0.formaList)
		end
	elseif arg_55_0.battleMode == EMBATTLE_TYPE_WORLDBOSS then
		g_WsMsgHandler:WS_WorldBoss_StartFight_Req()
	end
end

function zbEmbattleWnd.preLoadAudio(arg_56_0)
	for iter_56_0, iter_56_1 in pairs(arg_56_0.leftItems) do
		g_Audio.preLoadMgr:preHero(iter_56_1.heroTemplateId)
	end

	for iter_56_2, iter_56_3 in pairs(arg_56_0.rightItems) do
		g_Audio.preLoadMgr:preHero(iter_56_3.heroTemplateId)
	end
end

function zbEmbattleWnd.onFormation(arg_57_0)
	arg_57_0:hide()

	local var_57_0 = g_MainScene:showFormationWnd()

	if var_57_0 ~= nil then
		var_57_0.formEmbattleWnd = true
	end
end

function zbEmbattleWnd.refreshTalk(arg_58_0)
	arg_58_0.nodeLeftTalk:setVisible(false)
	arg_58_0.nodeRightTalk:setVisible(false)

	local var_58_0 = g_Self.kFormation:getWorkingHeroCount()

	if var_58_0 == 0 then
		var_58_0 = 1
	end

	local var_58_1 = zbUtil:random(1, var_58_0)
	local var_58_2 = 1

	for iter_58_0, iter_58_1 in pairs(arg_58_0.leftItems) do
		local var_58_3 = g_Self.kFormation.slots[iter_58_1.slotIndex]
		local var_58_4 = zbHeroTable:getRecord(var_58_3)

		if var_58_4 ~= nil then
			if var_58_1 == var_58_2 then
				local var_58_5 = 1
				local var_58_6 = table.getn(var_58_4.shortWord2)

				if var_58_6 > 0 then
					local var_58_7 = zbUtil:random(1, var_58_6)

					arg_58_0.lbLeftTalk:setString(var_58_4.shortWord2[var_58_7])
				end

				local var_58_8 = zbAvatarTable:getRecord(var_58_4.avatarId)

				if var_58_8 == nil then
					echoInfo("zbHero:init: monster == nil")

					return
				end

				arg_58_0.nodeLeftTalk:setPosition(arg_58_0.leftPosition[iter_58_1.slotIndex].x, arg_58_0.leftPosition[iter_58_1.slotIndex].y + var_58_8.hudOffset.y)
			end

			var_58_2 = var_58_2 + 1
		end
	end

	local var_58_9 = CCArray:create()

	var_58_9:addObject(CCCallFuncN:create(function()
		arg_58_0.nodeRightTalk:setVisible(true)
	end))
	var_58_9:addObject(CCDelayTime:create(3))
	var_58_9:addObject(CCCallFuncN:create(function()
		arg_58_0.nodeLeftTalk:setVisible(true)
		arg_58_0.nodeRightTalk:setVisible(false)
	end))
	var_58_9:addObject(CCDelayTime:create(3))
	var_58_9:addObject(CCCallFuncN:create(function()
		arg_58_0.nodeLeftTalk:setVisible(false)
	end))

	local var_58_10 = CCSequence:create(var_58_9)

	arg_58_0.nodeLeftTalk:stopAllActions()
	arg_58_0.nodeLeftTalk:runAction(var_58_10)
end

function zbEmbattleWnd.onFormationChanged(arg_62_0)
	arg_62_0:refreshLeft()

	if arg_62_0.battleMode == EMBATTLE_TYPE_TRIAL and arg_62_0.trialType == ETrialType.ImageFight then
		arg_62_0:refreshRight()

		return
	end

	arg_62_0.nodeLeftTalk:setVisible(false)
	arg_62_0.nodeRightTalk:setVisible(false)
	arg_62_0.nodeLeftTalk:stopAllActions()
end

function zbEmbattleWnd.refreshLeft(arg_63_0)
	if arg_63_0.isShow == false or arg_63_0:isVisible() == false then
		arg_63_0.lastShape = g_Self.kFormation.techId

		return
	end

	local function var_63_0(arg_64_0, arg_64_1)
		arg_63_0.lbCombatPower:setString(g_Self.kFormation:getCombatPower())

		local var_64_0 = g_Self.kTechHandler:getStudyedTech(g_Self.kFormation.techId)

		if var_64_0 ~= nil then
			local var_64_1 = zbTechTable:getRecord(g_Self.kFormation.techId)
			local var_64_2 = zbTechTable:getFormationPropertyDesc(g_Self.kFormation.techId, var_64_0.Level)

			arg_64_1:setString(var_64_1.name .. a2u("LV.") .. var_64_0.Level .. "  " .. var_64_2)
			arg_63_0.nodeCurrFormation:setVisible(true)

			local var_64_3 = zbTechTable:getRecord(g_Self.kFormation.techId)
			local var_64_4 = string.format("image/icon/formation/small_formation_%d.png", var_64_3.id)

			arg_63_0.spriteCurrFormation:setTexture(CCTextureCache:sharedTextureCache():addImage(var_64_4))
			arg_63_0.lbLevel:setString(var_64_0.Level)
		else
			arg_63_0.nodeCurrFormation:setVisible(false)
			arg_64_1:setString(a2u("δ\xBC\xA4\xBB\xEE\xD5\xF3\xD0ͣ\xAC\xCE\xDE\xCA\xF4\xD0Լӳ\xC9"))
		end

		arg_64_1:setVisible(false)
	end

	local function var_63_1()
		local var_65_0 = g_Self.kFormation:getWorkingHeroCount()
		local var_65_1 = g_Self.kHeroHandler:getHeroCount()

		arg_63_0.spriteFormationNotify:setVisible(var_65_0 < var_65_1 and var_65_0 < 5 or g_Self.kFormation:hasEmptyParter() and table.getn(g_Self.kHeroHandler:getNoUseHeros()) > 0)
	end

	local function var_63_2()
		if arg_63_0.lastShape == g_Self.kFormation.techId then
			local var_66_0 = g_Self.kTechHandler:getStudyedTech(g_Self.kFormation.techId)

			if var_66_0 == nil or var_66_0.Level == 0 then
				arg_63_0.nodeLeftShape:setVisible(false)
			end

			return
		end

		local var_66_1 = g_Self.kTechHandler:getStudyedTech(g_Self.kFormation.techId)

		if var_66_1 ~= nil and var_66_1.Level > 0 then
			arg_63_0.nodeLeftShape:setVisible(true)
			zbFormationHelper:formationAnimShow(arg_63_0.spriteLeftShape, arg_63_0.spriteLeftShapeName, g_Self.kFormation.techId, var_66_1.Level)
			arg_63_0.shapeBubble:showFormationType(g_Self.kFormation.techId, var_66_1.Level)
		end

		arg_63_0.lastShape = g_Self.kFormation.techId
	end

	for iter_63_0, iter_63_1 in pairs(arg_63_0.leftItems) do
		local var_63_3 = g_Self.kFormation.slots[iter_63_1.slotIndex]

		iter_63_1:refresh(g_Self.kFormation, var_63_3)
	end

	var_63_0(arg_63_0.lbCombatPower, arg_63_0.lbFormationDesc)
	var_63_1()
	var_63_2()
	arg_63_0:refreshGodEquip()
	arg_63_0:preLoadAudio()
end

function zbEmbattleWnd.refreshGodEquip(arg_67_0)
	local var_67_0 = g_GameData.GodInfo

	if var_67_0 ~= nil then
		local var_67_1 = zbGodBaseTable:getRecord(var_67_0.GodId)

		if var_67_1 ~= nil then
			arg_67_0.spriteGodIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_67_1.iconPath))
			arg_67_0.lbGodLevel:setString(var_67_0.Level)
		end
	end
end

function zbEmbattleWnd.refreshHeroTalk(arg_68_0, arg_68_1, arg_68_2)
	local var_68_0 = zbHeroTable:getRecord(arg_68_1)

	if var_68_0 ~= nil and num == index then
		local var_68_1 = 1
		local var_68_2 = table.getn(var_68_0.shortWord1)

		if var_68_2 > 0 then
			local var_68_3 = zbUtil:random(1, var_68_2)

			arg_68_0.lbRightTalk:setString(var_68_0.shortWord1[var_68_3])
		end

		local var_68_4 = zbAvatarTable:getRecord(var_68_0.avatarId)

		if var_68_4 == nil then
			echoInfo("zbHero:init: monster == nil")

			return
		end

		if var_68_4.parentAvatarId == 602 then
			arg_68_0.nodeRightTalk:setPosition(arg_68_0.rightPosition[arg_68_2].x, arg_68_0.rightPosition[arg_68_2].y + var_68_4.hudOffset.y * 0.85)
		else
			arg_68_0.nodeRightTalk:setPosition(arg_68_0.rightPosition[arg_68_2].x, arg_68_0.rightPosition[arg_68_2].y + var_68_4.hudOffset.y)
		end
	end
end

function zbEmbattleWnd.refreshRight(arg_69_0)
	local function var_69_0()
		local function var_70_0()
			return zbForceSetTable:getLevelHeroList(arg_69_0.levelId, arg_69_0.levelType)
		end

		for iter_70_0, iter_70_1 in pairs(arg_69_0.rightItems) do
			iter_70_1:refresh(-1)
		end

		local var_70_1 = var_70_0()
		local var_70_2 = zbUtil:random(1, table.getn(var_70_1))
		local var_70_3 = 1

		for iter_70_2, iter_70_3 in pairs(var_70_1) do
			local var_70_4 = arg_69_0.rightItems[iter_70_3.formationIndex]

			if var_70_4 ~= nil then
				var_70_4:refresh(iter_70_3.templateId)

				if var_70_2 == var_70_3 then
					arg_69_0:refreshHeroTalk(iter_70_3.templateId, var_70_4.slotIndex)
				end

				var_70_3 = var_70_3 + 1
			end
		end
	end

	local function var_69_1(arg_72_0)
		for iter_72_0, iter_72_1 in pairs(arg_69_0.rightItems) do
			iter_72_1:refresh(-1)
		end

		if zbUtil:isValidTable(arg_72_0.HeroList) == false or table.getn(arg_72_0.HeroList) < 1 then
			return
		end

		local var_72_0 = zbUtil:random(1, table.getn(arg_72_0.HeroList))
		local var_72_1 = 1

		for iter_72_2, iter_72_3 in pairs(arg_72_0.HeroList) do
			local var_72_2 = arg_69_0.rightItems[iter_72_3.Index]

			if var_72_2 ~= nil and zbHeroTable:getRecord(iter_72_3.TemplateId) ~= nil then
				if var_72_1 <= 5 then
					var_72_2:refresh(iter_72_3.TemplateId)

					if var_72_0 == var_72_1 then
						arg_69_0:refreshHeroTalk(iter_72_3.TemplateId, var_72_2.slotIndex)
					end

					var_72_1 = var_72_1 + 1
				else
					echo("------warning--------- zbEmbattleWnd:refreshEnemyFormation: " .. var_72_1)
				end
			end
		end
	end

	local function var_69_2()
		for iter_73_0, iter_73_1 in pairs(arg_69_0.rightItems) do
			iter_73_1:refresh(-1)
		end

		if arg_69_0.trialType == ETrialType.ImageFight then
			local var_73_0 = zbUtil:random(1, g_Self.kFormation:getWorkingHeroCount())
			local var_73_1 = 1

			for iter_73_2, iter_73_3 in pairs(arg_69_0.rightItems) do
				local var_73_2 = g_Self.kFormation.slots[iter_73_3.slotIndex]

				iter_73_3:refresh(var_73_2)

				if var_73_2 > 0 then
					if var_73_0 == var_73_1 then
						arg_69_0:refreshHeroTalk(var_73_2, iter_73_3.slotIndex)
					end

					var_73_1 = var_73_1 + 1
				end
			end

			return
		end

		local var_73_3 = zbHeroTrialDegreeTable:getRecord(arg_69_0.trialType, arg_69_0.trialLevel)

		if var_73_3 ~= nil then
			local var_73_4 = zbHeroTrialBossTable:getRecord(var_73_3.formatId)

			if var_73_4 ~= nil then
				local var_73_5 = zbUtil:random(1, table.getn(var_73_4.monsterList))
				local var_73_6 = 1

				for iter_73_4, iter_73_5 in pairs(var_73_4.monsterList) do
					local var_73_7 = arg_69_0.rightItems[iter_73_5.position]

					if var_73_7 ~= nil then
						var_73_7:refresh(iter_73_5.monsterId)

						if var_73_5 == var_73_6 then
							arg_69_0:refreshHeroTalk(iter_73_5.monsterId, var_73_7.slotIndex)
						end

						var_73_6 = var_73_6 + 1
					else
						echo("------warning--------- zbEmbattleWnd:refreshTrailFormation: " .. var_73_6)
					end
				end
			end
		end
	end

	local function var_69_3()
		local function var_74_0()
			return zbWorldNodeTable:getWorldNpcList(arg_69_0.nodeId)
		end

		for iter_74_0, iter_74_1 in pairs(arg_69_0.rightItems) do
			iter_74_1:refresh(-1)
		end

		local var_74_1 = var_74_0()
		local var_74_2 = zbUtil:random(1, table.getn(var_74_1))
		local var_74_3 = 1

		for iter_74_2, iter_74_3 in pairs(var_74_1) do
			local var_74_4 = arg_69_0.rightItems[iter_74_3.formationIndex]

			if var_74_4 ~= nil then
				var_74_4:refresh(iter_74_3.templateId)

				if var_74_2 == var_74_3 then
					arg_69_0:refreshHeroTalk(iter_74_3.templateId, var_74_4.slotIndex)
				end

				var_74_3 = var_74_3 + 1
			end
		end
	end

	local function var_69_4(arg_76_0)
		for iter_76_0, iter_76_1 in pairs(arg_69_0.rightItems) do
			iter_76_1:refresh(-1)
		end

		if zbUtil:isValidTable(arg_69_0.friendsBossDetail) == false then
			return
		end

		arg_69_0:refreshHeroTalk(arg_76_0.BossTid, 6)
		arg_69_0.rightItems[6]:refresh(arg_76_0.BossTid)
	end

	local function var_69_5(arg_77_0)
		for iter_77_0, iter_77_1 in pairs(arg_69_0.rightItems) do
			iter_77_1:refresh(-1)
		end

		if zbUtil:isValidTable(arg_69_0.legionBossDetail) == false then
			return
		end

		local var_77_0 = zbLegionBossTable:getRecord(arg_77_0.BossId)
		local var_77_1 = -1

		if var_77_0 then
			var_77_1 = var_77_0.teampId
		end

		arg_69_0.rightItems[5]:refresh(var_77_1)
		arg_69_0:refreshHeroTalk(var_77_1, 5)
	end

	local function var_69_6(arg_78_0)
		for iter_78_0, iter_78_1 in pairs(arg_69_0.rightItems) do
			iter_78_1:refresh(-1)
		end

		arg_69_0:refreshHeroTalk(arg_78_0, 5)
		arg_69_0.rightItems[5]:refresh(arg_78_0)
	end

	if arg_69_0.battleMode == EMBATTLE_TYPE_LEVEL then
		var_69_0()
	elseif arg_69_0.battleMode == EMBATTLE_TYPE_ARENA then
		var_69_1(arg_69_0.arenaPlayerInfo)
	elseif arg_69_0.battleMode == EMBATTLE_TYPE_CHAT then
		var_69_1(arg_69_0.chatPlayerInfo)
	elseif arg_69_0.battleMode == EMBATTLE_TYPE_FRIEND then
		var_69_1(arg_69_0.friendPlayerInfo)
	elseif arg_69_0.battleMode == EMBATTLE_TYPE_FRIENDBOSS then
		var_69_4(arg_69_0.friendsBossDetail)
	elseif arg_69_0.battleMode == EMBATTLE_TYPE_TRIAL then
		var_69_2()
	elseif arg_69_0.battleMode == EMBATTLE_TYPE_PATA then
		var_69_1(arg_69_0.pataPlayerInfo)
	elseif arg_69_0.battleMode == EMBATTLE_TYPE_YUANZHENG then
		var_69_1(arg_69_0.yuanzhengPlayerInfo)
	elseif arg_69_0.battleMode == EMBATTLE_TYPE_LEGIONMEM then
		var_69_1(arg_69_0.legionMemPlayerInfo)
	elseif arg_69_0.battleMode == EMBATTLE_TYPE_WORLDRES then
		var_69_3()
	elseif arg_69_0.battleMode == EMBATTLE_TYPE_WORLDHORSE then
		var_69_1(arg_69_0.worldHorsePlayerInfo)
	elseif arg_69_0.battleMode == EMBATTLE_TYPE_LEGIONBOSS then
		var_69_5(arg_69_0.legionBossDetail)
	elseif arg_69_0.battleMode == EMBATTLE_TYPE_LEGIONWAR then
		var_69_1(arg_69_0.formaList)
	elseif arg_69_0.battleMode == EMBATTLE_TYPE_WORLDBOSS then
		var_69_6(arg_69_0.worldBossId)
	end

	arg_69_0:preLoadAudio()
end

function zbEmbattleWnd.onSelectGodEquip(arg_79_0)
	g_MainScene:showGodListWnd()
end

function zbEmbattleWnd.getFormationSlots(arg_80_0)
	return arg_80_0.leftItems
end

function zbEmbattleWnd.onFateTouchDown(arg_81_0)
	arg_81_0.fateTip:show()
end

function zbEmbattleWnd.onFateTouchEnd(arg_82_0)
	arg_82_0.fateTip:hide()
end

function zbEmbattleWnd.onSupportTouchDown(arg_83_0)
	arg_83_0.supportTip:show()
end

function zbEmbattleWnd.onSupportTouchEnd(arg_84_0)
	arg_84_0.supportTip:hide()
end

function zbEmbattleWnd.onBlessTouchDown(arg_85_0)
	arg_85_0.blessTip:show()
end

function zbEmbattleWnd.onBlessTouchEnd(arg_86_0)
	arg_86_0.blessTip:hide()
end

function zbEmbattleWnd.onAddHero(arg_87_0, arg_87_1)
	if arg_87_1 == 1 then
		return
	end

	g_MainScene:showTeamForce()
end
