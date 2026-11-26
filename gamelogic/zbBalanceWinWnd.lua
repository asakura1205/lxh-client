require("gamelogic.zbBaseWnd")
require("gamelogic.zbBalanceHero")
require("gamelogic.zbBulletScreenFace")

local var_0_0 = 8
local var_0_1 = 64
local var_0_2 = 64
local var_0_3 = class("zbBalanceWinWnd", zbBaseWnd)

var_0_3.__index = var_0_3

function createBalanceWinWnd()
	local var_1_0 = var_0_3.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_1_0:initBase()
	var_1_0:init()

	return var_1_0
end

function var_0_3.extend(arg_2_0)
	local var_2_0 = tolua.getpeer(arg_2_0)

	if not var_2_0 then
		var_2_0 = {}

		tolua.setpeer(arg_2_0, var_2_0)
	end

	setmetatable(var_2_0, var_0_3)

	return arg_2_0
end

function var_0_3.init(arg_3_0)
	local function var_3_0()
		arg_3_0.heros = {}
		arg_3_0.items = {}
		arg_3_0.lines = {}
		arg_3_0.faceItems = {}
		arg_3_0.checkedLevelUp = false
	end

	local function var_3_1()
		local function var_5_0(arg_6_0, arg_6_1, arg_6_2)
			local var_6_0 = createUIAnimation()

			var_6_0:refreshBone(arg_6_1)
			var_6_0:setPosition(arg_6_2)
			arg_6_0:addChild(var_6_0)

			return var_6_0
		end

		local var_5_1 = CCBProxy:create()
		local var_5_2 = CCBReaderLoad("ccbi/balance_win.ccbi", var_5_1, true, "")

		arg_3_0.layerDetail = tolua.cast(var_5_2:getChildByTag(1), "CCNode")
		arg_3_0.nodeHead = tolua.cast(arg_3_0.layerDetail:getChildByTag(1), "CCNode")
		arg_3_0.spriteHeadIcon = tolua.cast(arg_3_0.nodeHead:getChildByTag(1), "CCSprite")
		arg_3_0.spriteRoleExpProgressBg = tolua.cast(arg_3_0.nodeHead:getChildByTag(2), "CCSprite")
		arg_3_0.lbRoleExpNum = tolua.cast(arg_3_0.nodeHead:getChildByTag(3), "CCLabelTTF")
		arg_3_0.lbRoleLevel = tolua.cast(arg_3_0.nodeHead:getChildByTag(4), "CCLabelTTF")
		arg_3_0.spriteTalk = tolua.cast(arg_3_0.nodeHead:getChildByTag(5), "CCSprite")
		arg_3_0.btnTalk = tolua.cast(arg_3_0.spriteTalk:getChildByTag(0), "CCControlButton")
		arg_3_0.lbTalk = tolua.cast(arg_3_0.spriteTalk:getChildByTag(4), "CCLabelTTF")
		arg_3_0.progressRoleExp = zbUtil:createProgressTimer(arg_3_0.spriteRoleExpProgressBg, "image/herodetail/herodetail_progress.png")

		local var_5_3 = tolua.cast(arg_3_0.layerDetail:getChildByTag(2), "CCNode")

		for iter_5_0 = 1, 5 do
			local var_5_4 = zbTableViewHelper:create()

			var_5_4:loadCCBFile("ccbi/tb_balance_hero.ccbi")

			local var_5_5 = tolua.cast(var_5_3:getChildByTag(iter_5_0), "CCLayerColor")
			local var_5_6 = createBalanceHero(translateAndStrokeHelper(var_5_4:readCCBNode()), iter_5_0)

			var_5_6:setPosition(var_5_5:getPosition())
			var_5_3:addChild(var_5_6)
			var_5_5:removeFromParentAndCleanup(true)

			arg_3_0.heros[iter_5_0] = var_5_6

			var_5_4:releaseSelf()
		end

		var_5_3:setZOrder(ZORDER_TOP)

		local var_5_7 = tolua.cast(arg_3_0.layerDetail:getChildByTag(3), "CCNode")

		for iter_5_1 = 1, 6 do
			local var_5_8 = tolua.cast(var_5_7:getChildByTag(iter_5_1), "CCLayerColor")
			local var_5_9 = createItem()

			var_5_9:setPosition(var_5_8:getPosition())
			var_5_9:setScale(var_5_8:getScale())
			var_5_7:addChild(var_5_9)
			var_5_8:removeFromParentAndCleanup(true)

			arg_3_0.items[iter_5_1] = var_5_9
		end

		arg_3_0.nodeTalk = tolua.cast(arg_3_0.layerDetail:getChildByTag(4), "CCNode")

		local var_5_10 = tolua.cast(arg_3_0.nodeTalk:getChildByTag(6), "CCControlButton")
		local var_5_11 = tolua.cast(arg_3_0.nodeTalk:getChildByTag(3), "CCLayer")
		local var_5_12 = tolua.cast(arg_3_0.nodeTalk:getChildByTag(4), "CCScrollView")
		local var_5_13 = ccc3(184, 167, 144)

		arg_3_0.inputBox = zbUtil:createEditBox(var_5_11, a2u("\xC7\xEB\xD4ڴ\xCB\xCA\xE4\xC8\xEBʤ\xC0\xFB\xB8\xD0\xD1԰ɣ\xA1"), 15, "image/common/button_transparent.png", 20, var_5_13)

		var_5_12:addChild(arg_3_0.inputBox)
		var_5_12:setCanMove(false)

		arg_3_0.nodeAnimBottom = tolua.cast(arg_3_0.layerDetail:getChildByTag(11), "CCNode")
		arg_3_0.nodeTop = tolua.cast(arg_3_0.layerDetail:getChildByTag(12), "CCNode")
		arg_3_0.fxYunTopLeft = var_5_0(arg_3_0.nodeTop, "effect/spine/ui_balance_win/zuoshangyun/zuoshangyun", ccp(0, 0))
		arg_3_0.fxYunTopRight = var_5_0(arg_3_0.nodeTop, "effect/spine/ui_balance_win/youshangyun/youshangyun", ccp(0, 0))
		arg_3_0.fxYunBottomLeft = var_5_0(arg_3_0.nodeAnimBottom, "effect/spine/ui_balance_win/zuoxiayun/zuoxiayun", ccp(0, 0))
		arg_3_0.fxYunBottomRight = var_5_0(arg_3_0.nodeAnimBottom, "effect/spine/ui_balance_win/youxiayun/youxiayun", ccp(0, 0))
		arg_3_0.fxWinStar = var_5_0(arg_3_0.nodeTop, "effect/spine/ui_balance_win/zhandoujiesuan_shengli/zhandoujiesuan_shengli", ccp(0, 25))

		arg_3_0.fxYunTopLeft:setAnimation("animation", true)
		arg_3_0.fxYunTopRight:setAnimation("animation", true)
		arg_3_0.fxYunBottomLeft:setAnimation("animation", true)
		arg_3_0.fxYunBottomRight:setAnimation("animation", true)

		arg_3_0.btnDamageStat = tolua.cast(var_5_2:getChildByTag(2):getChildByTag(1), "CCControlButton")
		arg_3_0.btnShare = tolua.cast(var_5_2:getChildByTag(2):getChildByTag(2), "CCControlButton")

		arg_3_0.btnShare:setVisible(false)

		arg_3_0.btnNext = tolua.cast(var_5_2:getChildByTag(3):getChildByTag(1), "CCControlButton")
		arg_3_0.btnReturn = tolua.cast(var_5_2:getChildByTag(3):getChildByTag(31), "CCControlButton")

		arg_3_0.btnDamageStat:addHandleOfControlEvent(function()
			arg_3_0:onDamageStat()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnNext:addHandleOfControlEvent(function()
			arg_3_0:onNext()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnReturn:addHandleOfControlEvent(function()
			arg_3_0:onReturn()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnTalk:addHandleOfControlEvent(function()
			arg_3_0:onShowTalk()
		end, CCControlEventTouchUpInside)
		var_5_10:addHandleOfControlEvent(function()
			arg_3_0:onSend()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_2)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(function()
		arg_3_0:onShowCallback()
	end)
end

function var_0_3.onShowCallback(arg_13_0)
	g_MainScene.wndCombat:hideUI()
	g_MainScene.wndCombat.layerScene:hideHeros()
	arg_13_0.btnShare:setVisible(false)

	if g_MainScene.wndLoading then
		zbUtil:freeWnd(g_MainScene.wndLoading)

		g_MainScene.wndLoading = nil
	end

	g_GameStateMachine:freeUnusedMem()
end

function var_0_3.refreshResultData(arg_14_0, arg_14_1)
	if arg_14_1 == nil then
		arg_14_1 = false
	end

	arg_14_0.spriteTalk:setVisible(arg_14_1)
	arg_14_0.nodeTalk:setVisible(arg_14_1)

	local var_14_0 = g_CombatSystem.combatType == COMBAT_TYPE_LEVEL

	if var_14_0 then
		var_14_0 = g_Self.kWarPathHandler.levelModes[g_CombatSystem.combatData.balanceAckData.LevelType].curLevelId - g_CombatSystem.combatData.balanceAckData.LevelId == 1
		var_14_0 = var_14_0 or g_CombatSystem.combatData.balanceAckData.LevelType == ELevelType.Elite and g_Self.kWarPathHandler.levelModes[g_CombatSystem.combatData.balanceAckData.LevelType].curLevelId - g_CombatSystem.combatData.levelBattleReadyAckData.LevelId == 3

		if (g_CombatSystem.combatData.balanceAckData.LevelType == ELevelType.Normal or g_CombatSystem.combatData.balanceAckData.LevelType == ELevelType.Elite) and zbForceSetTable:getLastLevelId(g_CombatSystem.combatData.balanceAckData.ForceId) == zbForceSetTable:getLastLevelId(g_CombatSystem.combatData.balanceAckData.ForceId) and g_Self.kWarPathHandler:isVisibleForce(g_CombatSystem.combatData.balanceAckData.LevelType, g_CombatSystem.combatData.balanceAckData.ForceId + 1) and g_Self.kWarPathHandler:getForceStarCount(g_CombatSystem.combatData.balanceAckData.LevelType, g_CombatSystem.combatData.balanceAckData.ForceId + 1) == 0 then
			var_14_0 = true
		end
	end

	arg_14_0.btnNext:setVisible(var_14_0)

	local var_14_1 = zbIconHelper:getPlayerHeadIconPath(g_GameData.BaseInfo.HeadId)

	arg_14_0.spriteHeadIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_14_1))

	function animRoleExpUp(arg_15_0)
		local function var_15_0()
			arg_14_0.progressRoleExp:setPercentage(0)
		end

		local var_15_1 = CCArray:create()

		for iter_15_0 = g_CombatSystem.combatData.backupRoleLevel, g_GameData.BaseInfo.Level - 1 do
			var_15_1:addObject(CCProgressTo:create(1, 100))
			var_15_1:addObject(CCCallFuncN:create(var_15_0))
		end

		local var_15_2 = g_GameData.BaseInfo.Exp / zbPlayerUpgradeTable:getExpNeed(g_GameData.BaseInfo.Level) * 100

		var_15_1:addObject(CCProgressTo:create(arg_15_0, var_15_2))

		local var_15_3 = CCSequence:create(var_15_1)

		arg_14_0.progressRoleExp:setPercentage(0)
		arg_14_0.progressRoleExp:stopAllActions()
		arg_14_0.progressRoleExp:runAction(var_15_3)
	end

	local var_14_2 = 0

	if g_CombatSystem.combatData.balanceAckData.RoleExp then
		var_14_2 = g_CombatSystem.combatData.balanceAckData.RoleExp
	end

	arg_14_0.lbRoleLevel:setString(g_Self:getLevel())
	arg_14_0.lbRoleExpNum:setString(a2u("\xBE\xAD\xD1\xE9+") .. var_14_2)
	arg_14_0.lbRoleExpNum:setVisible(var_14_2 > 0)
	arg_14_0.progressRoleExp:setPercentage(0)

	if var_14_2 > 0 then
		animRoleExpUp(1)
	else
		animRoleExpUp(0.01)
	end

	for iter_14_0, iter_14_1 in pairs(arg_14_0.heros) do
		iter_14_1:setVisible(false)
	end

	local var_14_3 = g_CombatSystem:getHeros(ForceType.Left)
	local var_14_4 = table.getn(var_14_3)

	for iter_14_2, iter_14_3 in pairs(var_14_3) do
		arg_14_0.heros[var_14_4]:refresh(iter_14_3:getTemplateId())

		var_14_4 = var_14_4 - 1
	end

	for iter_14_4, iter_14_5 in pairs(arg_14_0.items) do
		iter_14_5:setVisible(false)
	end

	if zbUtil:isValidTable(g_CombatSystem.combatData.awardList) then
		local var_14_5 = 1

		for iter_14_6, iter_14_7 in pairs(g_CombatSystem.combatData.awardList) do
			local var_14_6 = arg_14_0.items[var_14_5]

			if var_14_6 ~= nil then
				var_14_6:refreshAward(iter_14_7.Type, iter_14_7.Id, iter_14_7.Count)
				var_14_6:setVisible(true)
			end

			var_14_5 = var_14_5 + 1
		end
	end

	arg_14_0:animEffect()

	arg_14_0.checkedLevelUp = false

	g_Self:setFirstPassForce(g_CombatSystem.combatData:getLastLevelStar() == 0)
end

function var_0_3.animEffect(arg_17_0)
	local var_17_0 = 0

	local function var_17_1()
		local function var_18_0(arg_19_0)
			arg_17_0.fxWinStar:setVisible(true)
			arg_17_0.fxWinStar:setAnimation(g_CombatSystem.combatData.result .. "xing_01", false)
		end

		local function var_18_1()
			arg_17_0.fxWinStar:setAnimation(g_CombatSystem.combatData.result .. "xing_02", true)
		end

		local var_18_2 = CCArray:create()

		var_18_2:addObject(CCCallFuncN:create(var_18_0))
		var_18_2:addObject(CCDelayTime:create(3))
		var_18_2:addObject(CCCallFuncN:create(var_18_1))
		arg_17_0.fxWinStar:setVisible(false)
		arg_17_0.fxWinStar:stopAllActions()
		arg_17_0.fxWinStar:runAction(CCSequence:create(var_18_2))

		var_17_0 = var_17_0 + 1
	end

	local function var_17_2(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
		local function var_21_0(arg_22_0)
			arg_22_0:setVisible(true)

			if arg_21_4 ~= "" then
				g_Audio:playSound(arg_21_4)
			end
		end

		local function var_21_1()
			arg_21_0:animHeroExpUp()
			arg_21_0:animSkillExpUp()
		end

		local var_21_2 = CCArray:create()

		var_21_2:addObject(CCDelayTime:create(var_17_0))
		var_21_2:addObject(CCCallFuncN:create(var_21_0))

		if arg_21_1 then
			var_21_2:addObject(CCScaleTo:create(0.1, 0.9))
			var_21_2:addObject(CCScaleTo:create(0.05, 0.95))
		end

		if arg_21_2 then
			var_21_2:addObject(CCCallFuncN:create(var_21_1))
		end

		arg_21_0:setVisible(false)
		arg_21_0:stopAllActions()
		arg_21_0:runAction(CCSequence:create(var_21_2))

		var_17_0 = var_17_0 + arg_21_3
	end

	var_17_1()

	var_17_0 = 0.15

	for iter_17_0, iter_17_1 in pairs(arg_17_0.heros) do
		if iter_17_1:isVisible() == true then
			var_17_2(iter_17_1, false, true, 0.125, "")
		end
	end

	for iter_17_2, iter_17_3 in pairs(arg_17_0.items) do
		if iter_17_3:isVisible() == true then
			var_17_2(iter_17_3, false, false, 0.125, "")
		end
	end

	var_17_2(arg_17_0.btnDamageStat, false, false, 0.125, "")

	if arg_17_0.btnNext:isVisible() then
		var_17_2(arg_17_0.btnNext, false, false, 0.125, "")
	end

	var_17_2(arg_17_0.btnReturn, false, false, 0.125, "")
end

function var_0_3.onDamageStat(arg_24_0)
	g_MainScene:showBalanceData()
end

function var_0_3.onNext(arg_25_0)
	arg_25_0:hide()
	g_CombatSystem:finish()
	g_MainScene.wndCombat:hide()

	if g_Self.kFriendHandler:haveNewBoss() == true then
		g_MainScene:showFriendBossWnd(g_Self.kFriendHandler.newBossInfo)

		return
	end

	local var_25_0 = true

	if g_MainScene.wndEmbattle ~= nil then
		g_MainScene.wndEmbattle:gotoPrevWnd()

		if (g_CombatSystem.combatData.balanceAckData.LevelType == ELevelType.Normal or g_CombatSystem.combatData.balanceAckData.LevelType == ELevelType.Elite) and zbForceSetTable:getLastLevelId(g_CombatSystem.combatData.balanceAckData.ForceId) == zbForceSetTable:getLastLevelId(g_CombatSystem.combatData.balanceAckData.ForceId) and g_Self.kWarPathHandler:isVisibleForce(g_CombatSystem.combatData.balanceAckData.LevelType, g_CombatSystem.combatData.balanceAckData.ForceId + 1) and g_Self.kWarPathHandler:getForceStarCount(g_CombatSystem.combatData.balanceAckData.LevelType, g_CombatSystem.combatData.balanceAckData.ForceId + 1) == 0 then
			local var_25_1

			if g_MainScene.wndWarForce ~= nil then
				var_25_1 = g_MainScene.wndWarForce.enterWay
			end

			g_MainScene:showWarForce(g_CombatSystem.combatData.balanceAckData.LevelType, g_CombatSystem.combatData.balanceAckData.ForceId + 1, var_25_1)

			var_25_0 = false
		end
	end

	if var_25_0 then
		local var_25_2 = g_CombatSystem.combatData.levelBattleReadyAckData.LevelType
		local var_25_3 = g_CombatSystem.combatData.levelBattleReadyAckData.ForceId
		local var_25_4 = g_Self.kWarPathHandler.levelModes[var_25_2].curLevelId

		g_MainScene:showLevelDialog(var_25_2, var_25_3, var_25_4)
	end

	g_GameEventMgr:sendEvent(zbGameEvent.Event_BalanceOver_Win)
end

function var_0_3.onReturn(arg_26_0)
	arg_26_0:hide()
	g_CombatSystem:finish()
	g_MainScene.wndCombat:hide()

	if g_CombatSystem.combatType == COMBAT_TYPE_ARENARECORD then
		return
	end

	if g_MainScene.wndEmbattle ~= nil then
		g_MainScene.wndEmbattle:gotoPrevWnd()
	end

	g_GameEventMgr:sendEvent(zbGameEvent.Event_BalanceOver_Win)

	if g_Self.kFriendHandler:haveNewBoss() == true then
		g_MainScene:showFriendBossWnd(g_Self.kFriendHandler.newBossInfo)

		return
	end
end

function var_0_3.onFrameUpdate(arg_27_0)
	if arg_27_0.checkedLevelUp == false and (arg_27_0.btnNext:isVisible() or arg_27_0.btnReturn:isVisible()) then
		arg_27_0.checkedLevelUp = true

		if g_MainScene:checkShowLevelUpWnd() == false then
			g_MainScene:checkShowNewFuncWnd(false)

			if g_Self.kGodHandler.getnewGodId ~= nil then
				g_MainScene:showNewGodWnd(g_Self.kGodHandler.getnewGodId)

				g_Self.kGodHandler.getnewGodId = nil
			end
		end
	end
end

function var_0_3.onShowTalk(arg_28_0)
	arg_28_0.nodeTalk:setVisible(true)
end

function var_0_3.onSend(arg_29_0)
	local var_29_0 = string.trim(arg_29_0.inputBox:getText())

	if var_29_0 == "" then
		g_Bubble:bubbleInfo(a2u("\xC7\xEB\xCA\xE4\xC8뷢\xCB\xCD\xC4\xDA\xC8\xDD"))

		return
	end

	local var_29_1 = zbUtil:repValidText(var_29_0)

	g_WsMsgHandler:WS_WorldRes_Taunt_Req(g_CombatSystem.combatData.balanceAckData.NodeId, a2u(var_29_1))
	arg_29_0.lbTalk:setString(a2u(var_29_1))
	arg_29_0.nodeTalk:setVisible(false)
end

function var_0_3.setInputBoxStr(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_0.inputBox:getText() .. arg_30_1

	arg_30_0.inputBox:setText(a2u(var_30_0))
end
