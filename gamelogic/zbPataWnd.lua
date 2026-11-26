require("gamelogic.zbBaseWnd")
require("gamelogic.zbPataWnd_Fight")
require("gamelogic.zbPataWnd_Buff")
require("gamelogic.zbPataWnd_Award")
require("gamelogic.zbPataBuffTxt")

local var_0_0 = class("zbPataWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createPataWnd()
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
		arg_3_0.tableView = nil
		arg_3_0.tableViewHelper = nil
		arg_3_0.isMove = false
		arg_3_0.spriteBgItem = {}
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/pata.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")

		arg_3_0.spriteBg = tolua.cast(var_5_1:getChildByTag(0), "CCSprite")

		for iter_5_0 = 1, 5 do
			arg_3_0.spriteBgItem[iter_5_0] = tolua.cast(arg_3_0.spriteBg:getChildByTag(iter_5_0), "CCSprite")
		end

		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_3_0.spriteStop = tolua.cast(var_5_2:getChildByTag(10), "CCSprite")
		arg_3_0.lbStopHint = tolua.cast(var_5_2:getChildByTag(100), "CCLabelTTF")
		arg_3_0.positionStop = ccp(arg_3_0.spriteStop:getPosition())
		arg_3_0.nodeTitle = tolua.cast(var_5_2:getChildByTag(0), "CCSprite")

		local var_5_3 = tolua.cast(arg_3_0.nodeTitle:getChildByTag(1), "CCLabelTTF")
		local var_5_4 = tolua.cast(arg_3_0.nodeTitle:getChildByTag(2), "CCLabelTTF")

		function initAvatar(arg_6_0)
			local var_6_0
			local var_6_1 = CCSprite:create("image/combat/yingzi.png")

			var_6_1:setPosition(0, 5)
			var_6_1:setFlipX(true)
			arg_6_0:addChild(var_6_1)

			local var_6_2 = createUIAnimation()

			var_6_2:setPosition(0, 0)
			arg_6_0:addChild(var_6_2)

			return var_6_2
		end

		arg_3_0.nodeHero = tolua.cast(var_5_2:getChildByTag(11), "CCNode")
		arg_3_0.positionHero = ccp(arg_3_0.nodeHero:getPosition())
		arg_3_0.heroAvatar = initAvatar(arg_3_0.nodeHero)

		local var_5_5 = tolua.cast(var_5_2:getChildByTag(12), "CCNode")
		local var_5_6 = tolua.cast(var_5_5:getChildByTag(0), "CCLabelTTF")

		arg_3_0.lbBaseScore = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_6, arg_3_0.lbBaseScore)
		arg_3_0.lbBaseScore:setScale(0.6)

		arg_3_0.positionEnemy = ccp(var_5_5:getPosition())
		arg_3_0.enemyAvatar = initAvatar(var_5_5)
		arg_3_0.nodeInfo = tolua.cast(var_5_2:getChildByTag(13), "CCNode")
		arg_3_0.lbName = tolua.cast(arg_3_0.nodeInfo:getChildByTag(8), "CCLabelTTF")

		local var_5_7 = tolua.cast(arg_3_0.nodeInfo:getChildByTag(9), "CCLabelTTF")
		local var_5_8 = tolua.cast(arg_3_0.nodeInfo:getChildByTag(10):getChildByTag(1), "CCLabelTTF")

		arg_3_0.nodeEnemy = var_5_5

		arg_3_0.nodeInfo:setVisible(true)

		arg_3_0.btnFight = tolua.cast(var_5_5:getChildByTag(1), "CCControlButton")

		arg_3_0.btnFight:addHandleOfControlEvent(function()
			arg_3_0:onFight()
		end, CCControlEventTouchUpInside)

		local var_5_9 = tolua.cast(var_5_2:getChildByTag(14), "CCNode")

		arg_3_0.positionEnemyTemp = ccp(var_5_9:getPosition())
		arg_3_0.lbLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_7, arg_3_0.lbLevel)
		arg_3_0.lbLevel:setScale(0.6)

		arg_3_0.lbPower = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_8, arg_3_0.lbPower)
		arg_3_0.lbPower:setScale(0.6)

		arg_3_0.btnGoOn = tolua.cast(var_5_2:getChildByTag(6), "CCControlButton")

		local var_5_10 = tolua.cast(var_5_2:getChildByTag(9), "CCNode")

		arg_3_0.layerBuff = tolua.cast(var_5_10:getChildByTag(1), "CCNode")
		arg_3_0.btnBuffList = tolua.cast(var_5_10:getChildByTag(2), "CCControlButton")
		arg_3_0.spritebuffBg = tolua.cast(var_5_10:getChildByTag(99), "CCSprite")
		arg_3_0.btnTouchTest = tolua.cast(arg_3_0.layerBuff:getChildByTag(0), "CCControlButton")
		arg_3_0.lbBuffHint = tolua.cast(arg_3_0.layerBuff:getChildByTag(1), "CCLabelTTF")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.nodeBtn = tolua.cast(var_5_2:getChildByTag(8), "CCNode")
		arg_3_0.btnRule = tolua.cast(arg_3_0.nodeBtn:getChildByTag(1), "CCControlButton")
		arg_3_0.btnScoreAward = tolua.cast(arg_3_0.nodeBtn:getChildByTag(3), "CCControlButton")
		arg_3_0.btnRank = tolua.cast(arg_3_0.nodeBtn:getChildByTag(2), "CCControlButton")
		arg_3_0.nodeBuff = createPataWnd_Buff(tolua.cast(var_5_2:getChildByTag(3), "CCNode"), arg_3_0)
		arg_3_0.nodeFight = createPataWnd_Fight(tolua.cast(var_5_2:getChildByTag(4), "CCNode"), arg_3_0)
		arg_3_0.nodeAward = createPataWnd_Award(tolua.cast(var_5_2:getChildByTag(5), "CCNode"), arg_3_0)
		arg_3_0.lbFloor = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_3, arg_3_0.lbFloor)
		arg_3_0.lbFloor:setScale(1)

		arg_3_0.lbScore = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_4, arg_3_0.lbScore)
		arg_3_0.lbScore:setScale(0.7)
		arg_3_0.btnBuffList:addHandleOfControlEvent(function()
			arg_3_0:onBuffList()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnGoOn:addHandleOfControlEvent(function()
			arg_3_0:onGoOn()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnRule:addHandleOfControlEvent(function()
			arg_3_0:onRule()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnScoreAward:addHandleOfControlEvent(function()
			arg_3_0:onScoreAward()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnRank:addHandleOfControlEvent(function()
			arg_3_0:onRank()
		end, CCControlEventTouchUpInside)

		local function var_5_11(arg_14_0)
			local var_14_0 = CCSprite:create(NOTIFY_TAG_PATH)

			var_14_0:setAnchorPoint(ccp(0.5, 0.5))
			var_14_0:setPosition(70, 70)
			var_14_0:setVisible(false)
			arg_14_0:addChild(var_14_0)
			zbUIEffect:createNotifyTagScaleAction(var_14_0)

			return var_14_0
		end

		arg_3_0.notifyScore = var_5_11(arg_3_0.btnScoreAward)

		arg_3_0:addChild(var_5_1)
		arg_3_0:addBtnChat(var_5_1)
		arg_3_0:createMoneyPanel(var_5_1, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold
		}, function()
			arg_3_0:hide()
		end)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refresh()
	end, zbGameEvent.Event_PataRefreshAck)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refresh()
	end, zbGameEvent.Event_Pata_FightResult_Ack)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onGoOnResult()
	end, zbGameEvent.Event_Pata_NextLayerAck)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onBalanceOverWin()
	end, zbGameEvent.Event_BalanceOver_Win)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onBalanceOverLose()
	end, zbGameEvent.Event_BalanceOver_Lose)
end

function var_0_0.onTouchTest(arg_21_0)
	local var_21_0 = arg_21_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_21_0.layerBuff, var_21_0.x, var_21_0.y) == false then
		arg_21_0.layerBuff:setVisible(false)
		arg_21_0.spritebuffBg:setVisible(false)
	end
end

function var_0_0.onFight(arg_22_0)
	if arg_22_0.PataInfo.FightLayerInfo.FightResultState == 1 then
		return
	end

	arg_22_0.nodeFight:onFight()
end

function var_0_0.hideNode(arg_23_0)
	arg_23_0.nodeFight.layer:setVisible(false)
	arg_23_0.nodeBuff.layer:setVisible(false)
	arg_23_0.nodeAward.layer:setVisible(false)
	arg_23_0.nodeEnemy:setVisible(false)
	arg_23_0.nodeInfo:setVisible(false)
	arg_23_0.btnGoOn:setVisible(false)
	arg_23_0.layerBuff:setVisible(false)
	arg_23_0.spritebuffBg:setVisible(false)
	arg_23_0.lbStopHint:setVisible(false)
	arg_23_0.spriteStop:setVisible(false)
	arg_23_0.nodeHero:stopAllActions()
	arg_23_0.spriteBg:stopAllActions()
end

function var_0_0.refresh(arg_24_0)
	arg_24_0.PataInfo = g_GameData.PataInfo

	arg_24_0.moneyPanel.btnClose:setVisible(true)

	arg_24_0.isMove = false

	if arg_24_0.PataInfo == nil then
		return
	end

	arg_24_0:hideNode()
	arg_24_0:refreshPoint()
	arg_24_0.heroAvatar:refreshAvatarId(g_GameData.BaseInfo.AvatarId)
	arg_24_0.heroAvatar:setAnimation(ANIMATION_SEQUENCE_IDLE, true)
	arg_24_0:refreshBuffList()
	arg_24_0:showNode()
end

function var_0_0.refreshPoint(arg_25_0)
	if arg_25_0.PataInfo.BaseInfo.Layer % 2 == 1 then
		arg_25_0.spriteBg:setPosition(568, 320)
		arg_25_0.nodeHero:setPosition(100, 100)
		arg_25_0.heroAvatar:setRotationY(180)
	else
		arg_25_0.spriteBg:setPosition(568, 0)
		arg_25_0.nodeHero:setPosition(1000, 100)
		arg_25_0.heroAvatar:setRotationY(0)
	end

	local var_25_0 = zbPataLayerBaseTable.number
	local var_25_1 = math.floor(var_25_0 / 4)

	for iter_25_0 = 1, 5 do
		local var_25_2 = math.ceil((arg_25_0.PataInfo.BaseInfo.Layer + iter_25_0 - 1) / var_25_1)

		if var_25_2 > 4 then
			var_25_2 = 4
		end

		arg_25_0.spriteBgItem[iter_25_0]:setTexture(CCTextureCache:sharedTextureCache():addImage("image/background/pata_bg_0" .. var_25_2 .. ".png"))
	end
end

function var_0_0.showFightNode(arg_26_0)
	arg_26_0:hideNode()
	arg_26_0.btnGoOn:setVisible(false)
	arg_26_0.nodeEnemy:setVisible(true)
	arg_26_0.nodeInfo:setVisible(true)
	arg_26_0.nodeFight:refresh(arg_26_0.PataInfo)

	if arg_26_0.PataInfo.FightLayerInfo.FightResultState == 0 then
		arg_26_0.btnFight:setVisible(true)
	else
		arg_26_0.btnFight:setVisible(false)
	end
end

function var_0_0.showBuffNode(arg_27_0)
	arg_27_0:hideNode()
	arg_27_0.btnGoOn:setVisible(true)
	arg_27_0.nodeEnemy:setVisible(false)
	arg_27_0.nodeInfo:setVisible(false)
	arg_27_0.nodeBuff:refresh(arg_27_0.PataInfo)
end

function var_0_0.showAwardNode(arg_28_0)
	arg_28_0:hideNode()
	arg_28_0.btnGoOn:setVisible(true)
	arg_28_0.nodeEnemy:setVisible(false)
	arg_28_0.nodeInfo:setVisible(false)
	arg_28_0.nodeAward:refresh(arg_28_0.PataInfo)
end

function var_0_0.refreshBuffList(arg_29_0)
	if arg_29_0.tableView == nil then
		local var_29_0 = arg_29_0.layerBuff:getContentSize()

		arg_29_0.tableViewHelper = zbTableViewHelper:create()
		arg_29_0.tableView = zbTableViewHelper:createTableView(var_29_0, var_29_0, 1, arg_29_0.tableViewHelper)

		arg_29_0.tableView:setPosition(0, 0)
		arg_29_0.tableView:setAnchorPoint(ccp(0, 0))
		arg_29_0.layerBuff:addChild(arg_29_0.tableView)
	else
		arg_29_0.tableViewHelper:removeAllCells()
	end

	local var_29_1 = table.getn(arg_29_0.PataInfo.BaseInfo.BuffList)
	local var_29_2 = table.getn(arg_29_0.items)

	arg_29_0.lbBuffHint:setVisible(var_29_1 <= 0)

	for iter_29_0 = 1, var_29_2 do
		if iter_29_0 <= var_29_1 then
			local var_29_3 = arg_29_0.items[iter_29_0]

			arg_29_0.tableViewHelper:addCell(var_29_3)
		end
	end

	if var_29_1 - var_29_2 > 0 then
		for iter_29_1 = 1, var_29_1 - var_29_2 do
			local var_29_4 = zbTableViewHelper:create()

			var_29_4:loadCCBFile("ccbi/tb_patabuff_txt.ccbi")

			local var_29_5 = zbPataBuffTxt:create(translateAndStrokeHelper(var_29_4:readCCBNode()), var_29_2 + iter_29_1)

			var_29_5:retain()

			arg_29_0.items[var_29_2 + iter_29_1] = var_29_5

			arg_29_0.tableViewHelper:addCell(var_29_5)
			var_29_4:releaseSelf()
		end
	end

	local var_29_6 = 1

	for iter_29_2, iter_29_3 in pairs(arg_29_0.PataInfo.BaseInfo.BuffList) do
		arg_29_0.items[var_29_6]:refresh(iter_29_3)

		var_29_6 = var_29_6 + 1
	end

	arg_29_0.tableViewHelper:refreshTabelView()
	arg_29_0.tableViewHelper:setTouchPriority(arg_29_0.btnRule:getTouchPriority())
end

function var_0_0.onGoOn(arg_30_0)
	if arg_30_0.isMove == true then
		return
	end

	if g_Self.kPataHandler:getLayerType(arg_30_0.PataInfo.BaseInfo.Layer) == EPataLayerType.Award and table.getn(arg_30_0.PataInfo.AwardLayerInfo.AwardLayerInfo.BrandList) == 0 then
		g_Bubble:bubbleInfo("\xC4\xFA\xD3н\xB1\xC0\xF8δ\xC1\xECȡ\xA1\xA3")

		return
	end

	g_WsMsgHandler:WS_Pata_NextLayer_Req()
end

function var_0_0.showNode(arg_31_0)
	arg_31_0.PataInfo = g_GameData.PataInfo

	arg_31_0.lbFloor:setString(arg_31_0.PataInfo.BaseInfo.Layer)
	arg_31_0.lbScore:setString(arg_31_0.PataInfo.BaseInfo.DayScore)
	arg_31_0.notifyScore:setVisible(g_Self.kPataHandler:getJiFenNotify())

	if arg_31_0.PataInfo.BaseInfo.Mode == EPataStateType.Normal then
		local var_31_0 = g_Self.kPataHandler:getLayerType(arg_31_0.PataInfo.BaseInfo.Layer)

		if var_31_0 == EPataLayerType.Fight then
			arg_31_0:showFightNode()
		elseif var_31_0 == EPataLayerType.Buff then
			arg_31_0:showBuffNode()
		else
			arg_31_0:showAwardNode()
		end
	elseif arg_31_0.PataInfo.SaoDangInfo.SaoDangInfo.Index == EPataSaoDangStateType.GetAward then
		g_MainScene:showPataSaoDangAwardWnd(arg_31_0.PataInfo.SaoDangInfo.SaoDangInfo.AwardList)
	else
		g_MainScene:showPataSaoDangBuyWnd(arg_31_0.PataInfo.SaoDangInfo.SaoDangInfo)
	end

	if arg_31_0.PataInfo.BaseInfo.Layer >= zbPataLayerBaseTable.number then
		if g_GameData.PataInfo.BaseInfo.Layer % 2 == 1 then
			arg_31_0.spriteStop:setPosition(arg_31_0.positionEnemy.x + 190, arg_31_0.positionEnemy.y + 100)
			arg_31_0.spriteStop:setFlipX(false)
		else
			arg_31_0.spriteStop:setPosition(arg_31_0.positionEnemyTemp.x - 190, arg_31_0.positionEnemyTemp.y + 100)
			arg_31_0.spriteStop:setFlipX(true)
		end

		arg_31_0.lbStopHint:setVisible(true)
		arg_31_0.spriteStop:setVisible(true)
		arg_31_0.btnGoOn:setVisible(false)
	end
end

function var_0_0.onGoOnResult(arg_32_0)
	arg_32_0.isMove = true

	if g_GameData.PataInfo.BaseInfo.Layer % 2 == 1 then
		arg_32_0:onRightToLeft()
	else
		arg_32_0:onLeftToRight()
	end
end

function var_0_0.onLeftToRight(arg_33_0)
	arg_33_0:hideNode()
	arg_33_0.heroAvatar:setAnimation(ANIMATION_SEQUENCE_MOVE, true)

	local var_33_0 = CCArray:create()

	var_33_0:addObject(CCMoveTo:create(4, ccp(1400, 100)))
	var_33_0:addObject(CCCallFuncN:create(function()
		arg_33_0.heroAvatar:setRotationY(0)
	end))
	var_33_0:addObject(CCMoveTo:create(1, ccp(1000, 100)))
	var_33_0:addObject(CCCallFuncN:create(function()
		arg_33_0.heroAvatar:setAnimation(ANIMATION_SEQUENCE_IDLE, true)

		arg_33_0.isMove = false

		arg_33_0:showNode()
	end))

	local var_33_1 = CCSequence:create(var_33_0)

	arg_33_0.nodeHero:stopAllActions()
	arg_33_0.nodeHero:runAction(var_33_1)
	arg_33_0.spriteBg:stopAllActions()
	arg_33_0.spriteBg:runAction(CCMoveTo:create(5, ccp(568, 0)))
end

function var_0_0.onRightToLeft(arg_36_0)
	arg_36_0:hideNode()
	arg_36_0.heroAvatar:setAnimation(ANIMATION_SEQUENCE_MOVE, true)

	local var_36_0 = CCArray:create()

	var_36_0:addObject(CCMoveTo:create(4, ccp(-250, 100)))
	var_36_0:addObject(CCCallFuncN:create(function()
		arg_36_0.spriteStop:setVisible(false)
		arg_36_0.heroAvatar:setRotationY(180)
	end))
	var_36_0:addObject(CCMoveTo:create(1, ccp(100, 100)))
	var_36_0:addObject(CCCallFuncN:create(function()
		arg_36_0.heroAvatar:setAnimation(ANIMATION_SEQUENCE_IDLE, true)

		arg_36_0.isMove = false

		arg_36_0:showNode()
	end))

	local var_36_1 = CCSequence:create(var_36_0)

	arg_36_0.nodeHero:stopAllActions()
	arg_36_0.nodeHero:runAction(var_36_1)

	local var_36_2 = CCArray:create()

	var_36_2:addObject(CCMoveTo:create(5, ccp(568, -320)))
	var_36_2:addObject(CCCallFuncN:create(function()
		arg_36_0.spriteBg:setPosition(568, 320)
	end))

	local var_36_3 = CCSequence:create(var_36_2)

	arg_36_0.spriteBg:stopAllActions()
	arg_36_0.spriteBg:runAction(var_36_3)
end

function var_0_0.onRule(arg_40_0)
	g_MainScene:showRuleWnd(RuleType_DailyFuben_Pata)
end

function var_0_0.onScoreAward(arg_41_0)
	g_MainScene:showPataScoreAwardWnd()
end

function var_0_0.onRank(arg_42_0)
	if zbFunHelper:isBuildingLockAndTip(EBuildingType.Rank) then
		return
	end

	g_MainScene:showRankListWnd(ERankTab.Pata)
	g_MainScene.wndRankList:setPrevWnd(arg_42_0)
end

function var_0_0.onBuffList(arg_43_0)
	arg_43_0.layerBuff:setVisible(true)
	arg_43_0.spritebuffBg:setVisible(true)
end

function var_0_0.onBalanceOverWin(arg_44_0)
	if g_MainScene.wndEmbattle == nil or g_MainScene.wndEmbattle.battleMode ~= EMBATTLE_TYPE_PATA then
		return
	end

	g_Bubble:bubbleInfo("\xB9\xA7ϲ\xC4\xFA\xBB\xF1\xB5\xC3ʤ\xC0\xFB\xA3\xA1\xB2\xBBҪͣ\xCF½Ų\xBD\xA3\xAC\xBA\xF3\xC3滹\xD3и\xFC\xB6ཱ\xC0\xF8\xB5ȴ\xFD\xD7\xC5\xC4\xFA\xA1\xA3")
end

function var_0_0.onBalanceOverLose(arg_45_0)
	if g_MainScene.wndEmbattle == nil or g_MainScene.wndEmbattle.battleMode ~= EMBATTLE_TYPE_PATA then
		return
	end

	g_Bubble:bubbleInfo("\xBA\xDC\xD2ź\xB6\xA3\xA1\xC4\xFAʧ\xB0\xDC\xC1ˣ\xAC\xB2\xBBҪ\xBB\xD2\xD0ģ\xAC\xCC\xE1\xC9\xFDս\xC1\xA6\xBA\xF3\xD4\xD9\xC0\xB4\xCC\xF4ս\xA1\xA3")
end
