require("gamelogic.zbBaseWnd")
require("gamelogic.zbYuanZhengNode")

zbYuanZhengWnd = class("zbYuanZhengWnd", zbBaseWnd)
zbYuanZhengWnd.__index = zbYuanZhengWnd

function zbYuanZhengWnd.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbYuanZhengWnd)

	return arg_1_0
end

function createYuanZhengWnd(arg_2_0)
	local var_2_0 = zbYuanZhengWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init(arg_2_0)

	return var_2_0
end

function zbYuanZhengWnd.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.sprite = {}
		arg_3_0.layerNum = 1
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/yuanzheng.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_3_0.layer = var_5_2
		arg_3_0.bgSprite = tolua.cast(var_5_1:getChildByTag(0), "CCSprite")
		arg_3_0.nodeTitle = tolua.cast(var_5_2:getChildByTag(0), "CCSprite")

		local var_5_3 = tolua.cast(arg_3_0.nodeTitle:getChildByTag(1), "CCLabelTTF")
		local var_5_4 = tolua.cast(arg_3_0.nodeTitle:getChildByTag(2), "CCLabelTTF")
		local var_5_5 = tolua.cast(arg_3_0.nodeTitle:getChildByTag(3), "CCLabelTTF")
		local var_5_6 = tolua.cast(arg_3_0.nodeTitle:getChildByTag(8), "CCLabelTTF")
		local var_5_7 = tolua.cast(var_5_2:getChildByTag(2), "CCNode")

		for iter_5_0 = 1, 8 do
			arg_3_0.sprite[iter_5_0] = tolua.cast(var_5_7:getChildByTag(iter_5_0), "CCSprite")
		end

		arg_3_0.btnTask = tolua.cast(var_5_7:getChildByTag(10), "CCControlButton")

		local var_5_8 = tolua.cast(var_5_2:getChildByTag(1), "CCNode")

		arg_3_0.layerNum = zbUtil:random(1, 8)
		arg_3_0.pnlBaGua = zbYuanZhengNode:create()

		var_5_8:addChild(arg_3_0.pnlBaGua)

		arg_3_0.ruleRoot = tolua.cast(var_5_2:getChildByTag(8), "CCNode")
		arg_3_0.btnRule = tolua.cast(arg_3_0.ruleRoot:getChildByTag(1), "CCControlButton")
		arg_3_0.btnJiFen = tolua.cast(arg_3_0.ruleRoot:getChildByTag(3), "CCControlButton")
		arg_3_0.btnRank = tolua.cast(arg_3_0.ruleRoot:getChildByTag(2), "CCControlButton")

		local var_5_9 = tolua.cast(var_5_2:getChildByTag(3), "CCNode")

		arg_3_0.btnReset = tolua.cast(var_5_9:getChildByTag(31), "CCControlButton")
		arg_3_0.lblReset = tolua.cast(var_5_9:getChildByTag(1), "CCLabelTTF")
		arg_3_0.rootNodex = var_5_9

		arg_3_0.rootNodex:setVisible(not g_IOSTSCheck)

		arg_3_0.lastFloor = tolua.cast(var_5_2:getChildByTag(4), "CCNode")
		arg_3_0.layerLastBox = tolua.cast(arg_3_0.lastFloor:getChildByTag(1), "CCNode")
		arg_3_0.btnBox = tolua.cast(arg_3_0.layerLastBox:getChildByTag(1), "CCControlButton")
		arg_3_0.layerLastHint = tolua.cast(arg_3_0.lastFloor:getChildByTag(2), "CCNode")

		arg_3_0.btnReset:addHandleOfControlEvent(function()
			arg_3_0:onReset()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnTask:addHandleOfControlEvent(function()
			arg_3_0:onWorld()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnRule:addHandleOfControlEvent(function()
			arg_3_0:onRule()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnRank:addHandleOfControlEvent(function()
			arg_3_0:onRank()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnJiFen:addHandleOfControlEvent(function()
			arg_3_0:onJiFen()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnBox:addHandleOfControlEvent(function()
			arg_3_0:onBox()
		end, CCControlEventTouchUpInside)

		arg_3_0.lbFloor = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_3, arg_3_0.lbFloor)
		arg_3_0.lbFloor:setScale(1)

		arg_3_0.lbTodayScore = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_4, arg_3_0.lbTodayScore)
		arg_3_0.lbTodayScore:setScale(0.65)

		arg_3_0.lbCurrScore = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_5, arg_3_0.lbCurrScore)
		arg_3_0.lbCurrScore:setScale(0.65)

		arg_3_0.lbFightCnt = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_6, arg_3_0.lbFightCnt)
		arg_3_0.lbFightCnt:setScale(0.65)

		local function var_5_10(arg_12_0)
			local var_12_0 = CCSprite:create(NOTIFY_TAG_PATH)

			var_12_0:setAnchorPoint(ccp(0.5, 0.5))
			var_12_0:setPosition(70, 70)
			var_12_0:setVisible(false)
			arg_12_0:addChild(var_12_0)
			zbUIEffect:createNotifyTagScaleAction(var_12_0)

			return var_12_0
		end

		arg_3_0.notifyScore = var_5_10(arg_3_0.btnJiFen)

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
		arg_3_0:onOpenPlayer()
	end, zbGameEvent.Event_Bgz_GetBossInfo_Ack)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refresh()
	end, zbGameEvent.Event_Bgz_RefreshInfo_Ack)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onBalanceOverWin()
	end, zbGameEvent.Event_BalanceOver_Win)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onBalanceOverLose()
	end, zbGameEvent.Event_BalanceOver_Lose)
end

function zbYuanZhengWnd.refresh(arg_18_0, arg_18_1)
	arg_18_0.bgzInfo = g_GameData.BgzInfo

	arg_18_0.layer:setVisible(true)

	if arg_18_0.bgzInfo == nil then
		return
	end

	arg_18_0.pnlBaGua:gotoYuanZheng(arg_18_0.layerNum, arg_18_0.bgzInfo)

	local var_18_0 = arg_18_0.bgzInfo.CurLevel

	if arg_18_0.bgzInfo.CurLevel > 8 then
		var_18_0 = 8
	end

	arg_18_0.lbFloor:setString(var_18_0)
	arg_18_0.lbTodayScore:setString(arg_18_0.bgzInfo.DayScore)
	arg_18_0.notifyScore:setVisible(g_Self.kYuanzhengHandler:getJiFenNotify())

	for iter_18_0, iter_18_1 in pairs(g_DataConfig.kBgzCommonTable.levelList) do
		if iter_18_1.level == var_18_0 then
			arg_18_0.lbCurrScore:setString(iter_18_1.score)
		end
	end

	arg_18_0.lblReset:setVisible(g_Self:getVipLevel() < 11)
	arg_18_0.btnReset:setGray(arg_18_0.bgzInfo.TotalResetCount - arg_18_0.bgzInfo.ResetCount <= 0 or g_Self:getVipLevel() < 11)

	arg_18_0.spriteframeCache = CCSpriteFrameCache:sharedSpriteFrameCache()

	arg_18_0.spriteframeCache:addSpriteFramesWithFile("ui/image/plist/bgz.plist")

	for iter_18_2 = 1, 8 do
		local var_18_1 = arg_18_0.spriteframeCache:spriteFrameByName("bgz_wenhao.png")

		arg_18_0.sprite[iter_18_2]:setGray(false)

		if var_18_1 then
			arg_18_0.sprite[iter_18_2]:initWithSpriteFrame(var_18_1)
		end
	end

	local var_18_2 = 1

	for iter_18_3, iter_18_4 in pairs(arg_18_0.bgzInfo.LineList) do
		local var_18_3 = arg_18_0.spriteframeCache:spriteFrameByName("bgz_num" .. iter_18_4.Index .. ".png")

		if arg_18_0.bgzInfo.CurLevel > iter_18_4.Level then
			arg_18_0.sprite[iter_18_4.Level]:setGray(true)

			if var_18_3 then
				arg_18_0.sprite[iter_18_4.Level]:initWithSpriteFrame(var_18_3)
			end
		else
			arg_18_0.sprite[iter_18_4.Level]:setGray(false)
		end
	end

	if g_Self.kWorldHandler.worldInfo then
		local var_18_4 = g_Self.kWorldHandler.worldInfo.BgzInfo
		local var_18_5 = 1

		for iter_18_5, iter_18_6 in pairs(var_18_4.BgzClue) do
			if iter_18_6 ~= 0 then
				local var_18_6 = arg_18_0.spriteframeCache:spriteFrameByName("bgz_num" .. iter_18_6 .. ".png")

				if var_18_6 then
					arg_18_0.sprite[var_18_5]:initWithSpriteFrame(var_18_6)
				end
			end

			var_18_5 = var_18_5 + 1
		end
	end

	arg_18_0.lastFloor:setVisible(arg_18_0.bgzInfo.CurLevel > 8)

	if arg_18_0.bgzInfo.CurLevel > 8 then
		if g_GameData.BgzInfo.State == 1 then
			arg_18_0.layerLastBox:setVisible(true)
			arg_18_0.layerLastHint:setVisible(false)
		else
			arg_18_0.layerLastBox:setVisible(false)
			arg_18_0.layerLastHint:setVisible(true)
		end

		return
	end

	arg_18_0.lbFightCnt:setString(arg_18_0.bgzInfo.TotalFightCnt - arg_18_0.bgzInfo.DayFightCnt .. "/" .. arg_18_0.bgzInfo.TotalFightCnt)

	if arg_18_1 then
		arg_18_0:playEffect()
	end
end

function zbYuanZhengWnd.playEffect(arg_19_0)
	local var_19_0 = 0.1

	local function var_19_1(arg_20_0, arg_20_1)
		local function var_20_0(arg_21_0)
			arg_21_0:setVisible(true)
		end

		local var_20_1 = CCArray:create()

		var_20_1:addObject(CCDelayTime:create(var_19_0))
		var_20_1:addObject(CCCallFuncN:create(var_20_0))
		arg_20_0:setVisible(false)
		arg_20_0:stopAllActions()
		arg_20_0:runAction(CCSequence:create(var_20_1))

		var_19_0 = var_19_0 + arg_20_1
	end

	arg_19_0.bgSprite:setPosition(568, -100)

	for iter_19_0 = 1, 5 do
		var_19_1(arg_19_0.pnlBaGua.itemBgz[iter_19_0].ccNode, 0.1)
	end
end

function zbYuanZhengWnd.goToNextLayer(arg_22_0)
	local var_22_0 = arg_22_0.layerNum

	while var_22_0 == arg_22_0.layerNum do
		arg_22_0.layerNum = zbUtil:random(1, 8)
	end

	arg_22_0.pnlBaGua:gotoYuanZheng(arg_22_0.layerNum, arg_22_0.bgzInfo)

	local var_22_1 = CCArray:create()

	var_22_1:addObject(CCCallFuncN:create(function()
		arg_22_0.layer:setVisible(false)
		arg_22_0.moneyPanel.node:setVisible(false)
	end))
	var_22_1:addObject(CCMoveTo:create(1, ccp(568, 640)))
	var_22_1:addObject(CCCallFuncN:create(function()
		arg_22_0.layer:setVisible(true)
		arg_22_0.moneyPanel.node:setVisible(true)
		arg_22_0:playEffect()
		arg_22_0.bgSprite:setPosition(568, -100)
	end))

	local var_22_2 = CCSequence:create(var_22_1)

	arg_22_0.bgSprite:stopAllActions()
	arg_22_0.bgSprite:runAction(var_22_2)
end

function zbYuanZhengWnd.onRule(arg_25_0)
	g_MainScene:showRuleWnd(RuleType_Yuanzheng)
end

function zbYuanZhengWnd.onRank(arg_26_0)
	if zbFunHelper:isBuildingLockAndTip(EBuildingType.Rank) then
		return
	end

	g_MainScene:showRankListWnd(ERankTab.Bgz)
	g_MainScene.wndRankList:setPrevWnd(arg_26_0)
end

function zbYuanZhengWnd.onWorld(arg_27_0)
	g_MainScene:showWorld()
	arg_27_0:hide()
end

function zbYuanZhengWnd.onJiFen(arg_28_0)
	g_MainScene:showYuanzhengScoreAwardWnd()
end

function zbYuanZhengWnd.onReset(arg_29_0)
	if g_Self:getVipLevel() < 11 then
		g_Bubble:bubbleInfo("VIP\xB5ȼ\xB6\xB2\xBB\xD7\xE3")

		return
	end

	if arg_29_0.bgzInfo.TotalResetCount - arg_29_0.bgzInfo.ResetCount <= 0 then
		g_Bubble:bubbleInfo("\xD2Ѿ\xAD\xD6\xD8\xD6ù\xFD")

		return
	end

	local function var_29_0()
		g_WsMsgHandler:WS_Bgz_Reset_Req()
	end

	g_MessageBox:showYesNo(a2u("ȷ\xB6\xA8\xD6\xD8\xD6\xC3\xCD\xC5\xCA\xF3\xB4\xF3\xD7\xF7ս\xC2\xF0"), var_29_0)
end

function zbYuanZhengWnd.onOpenPlayer(arg_31_0)
	g_MainScene:showYuanzhengPlayerWnd(arg_31_0.bgzInfo)
end

function zbYuanZhengWnd.onBox(arg_32_0)
	if g_GameData.BgzInfo.State == 1 then
		g_WsMsgHandler:WS_Bgz_GetAward_Req()
	end
end

function zbYuanZhengWnd.onBalanceOverWin(arg_33_0)
	if g_MainScene.wndEmbattle == nil or g_MainScene.wndEmbattle.battleMode ~= EMBATTLE_TYPE_YUANZHENG then
		return
	end

	if g_GameData.BgzInfo.State == 1 then
		g_Bubble:bubbleInfo("\xB9\xA7ϲ\xC4\xFA\xA3\xA1\xB3ɹ\xA6\xB5\xC4ץס\xCD\xC5\xCA󣬿\xECȥ\xC1\xECȡ\xC4\xFA\xB5Ľ\xB1Ʒ\xA1\xA3")
		arg_33_0:goToNextLayer()
	else
		g_Bubble:bubbleInfo("\xB1\xA7Ǹ\xA3\xA1\xC4\xFAѡ\xD4\xF1\xB4\xED\xCE\xF3\xA3\xAC\xCD\xC5\xCA\xF3\xD2Ѿ\xAD\xC5ܵ\xBD\xC6\xE4\xCB\xFB\xB6\xB4\xC0\xEF\xC1ˣ\xAC\xBF\xECȥץס\xCB\xFC\xA1\xA3")
	end
end

function zbYuanZhengWnd.onBalanceOverLose(arg_34_0)
	if g_MainScene.wndEmbattle == nil or g_MainScene.wndEmbattle.battleMode ~= EMBATTLE_TYPE_YUANZHENG then
		return
	end

	g_Bubble:bubbleInfo("\xBA\xDC\xD2ź\xB6\xA3\xA1\xC4\xFAʧ\xB0\xDC\xC1ˣ\xAC\xBF\xECȥ\xCC\xE1\xC9\xFDս\xC1\xA6\xD4\xD9\xC0\xB4\xCA\xD4\xCAԡ\xA3")
end
