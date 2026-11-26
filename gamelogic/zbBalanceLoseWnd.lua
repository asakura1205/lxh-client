require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbBalanceLoseWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function var_0_0.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, var_0_0)

	return arg_1_0
end

function createBalanceLoseWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		return
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
		local var_5_2 = CCBReaderLoad("ccbi/balance_lose.ccbi", var_5_1, true, "")

		arg_3_0.layerDetail = tolua.cast(var_5_2:getChildByTag(1), "CCSprite")
		arg_3_0.btnLinkTech = tolua.cast(arg_3_0.layerDetail:getChildByTag(1), "CCControlButton")
		arg_3_0.btnLinkParter = tolua.cast(arg_3_0.layerDetail:getChildByTag(2), "CCControlButton")
		arg_3_0.btnLinkSkill = tolua.cast(arg_3_0.layerDetail:getChildByTag(3), "CCControlButton")
		arg_3_0.btnLinkEquip = tolua.cast(arg_3_0.layerDetail:getChildByTag(4), "CCControlButton")
		arg_3_0.nodeAward = tolua.cast(arg_3_0.layerDetail:getChildByTag(5), "CCNode")
		arg_3_0.lbAwardDesc = tolua.cast(arg_3_0.nodeAward:getChildByTag(1), "CCLabelTTF")
		arg_3_0.spriteAwardType = tolua.cast(arg_3_0.nodeAward:getChildByTag(2), "CCSprite")
		arg_3_0.lbAwardCount = tolua.cast(arg_3_0.nodeAward:getChildByTag(3), "CCLabelTTF")
		arg_3_0.nodeAnimBottom = tolua.cast(arg_3_0.layerDetail:getChildByTag(11), "CCNode")
		arg_3_0.nodeTop = tolua.cast(arg_3_0.layerDetail:getChildByTag(12), "CCNode")
		arg_3_0.fxYunTopLeft = var_5_0(arg_3_0.nodeTop, "effect/spine/ui_balance_lose/zuoshangyun/zuoshangyun", ccp(0, 0))
		arg_3_0.fxYunTopRight = var_5_0(arg_3_0.nodeTop, "effect/spine/ui_balance_lose/youshangyun/youshangyun", ccp(0, 0))
		arg_3_0.fxYunBottomLeft = var_5_0(arg_3_0.nodeAnimBottom, "effect/spine/ui_balance_lose/zuoxiayun/zuoxiayun", ccp(0, 0))
		arg_3_0.fxYunBottomRight = var_5_0(arg_3_0.nodeAnimBottom, "effect/spine/ui_balance_lose/youxiayun/youxiayun", ccp(0, 0))
		arg_3_0.fxWinStar = var_5_0(arg_3_0.nodeTop, "effect/spine/ui_balance_lose/zhandoujiesuan_shibai/zhandoujiesuan_shibai", ccp(0, 0))

		arg_3_0.fxYunTopLeft:setAnimation("animation", true)
		arg_3_0.fxYunTopRight:setAnimation("animation", true)
		arg_3_0.fxYunBottomLeft:setAnimation("animation", true)
		arg_3_0.fxYunBottomRight:setAnimation("animation", true)

		arg_3_0.btnDamageStat = tolua.cast(var_5_2:getChildByTag(2):getChildByTag(1), "CCControlButton")
		arg_3_0.btnRetry = tolua.cast(var_5_2:getChildByTag(3):getChildByTag(1), "CCControlButton")
		arg_3_0.btnReturn = tolua.cast(var_5_2:getChildByTag(3):getChildByTag(31), "CCControlButton")

		arg_3_0.btnLinkTech:addHandleOfControlEvent(function()
			arg_3_0:onLinkTech()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnLinkParter:addHandleOfControlEvent(function()
			arg_3_0:onLinkParter()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnLinkSkill:addHandleOfControlEvent(function()
			arg_3_0:onLinkSkill()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnLinkEquip:addHandleOfControlEvent(function()
			arg_3_0:onLinkEquip()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnDamageStat:addHandleOfControlEvent(function()
			arg_3_0:onDamageStat()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnRetry:addHandleOfControlEvent(function()
			arg_3_0:onRetry()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnReturn:addHandleOfControlEvent(function()
			arg_3_0:onReturn()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_2)

		arg_3_0.animInitY = arg_3_0.fxWinStar:getPositionY()
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(function(arg_14_0)
		arg_3_0:onShowCallback()
	end)
end

function var_0_0.onShowCallback(arg_15_0)
	g_MainScene.wndCombat:hideUI()
	g_MainScene.wndCombat.layerScene:hideHeros()
	g_GameStateMachine:freeUnusedMem()
end

function var_0_0.refreshResultData(arg_16_0)
	arg_16_0.nodeAward:setVisible(g_CombatSystem.combatData.awardRank > 0)
	arg_16_0.lbAwardCount:setString("+" .. g_CombatSystem.combatData.awardRank)

	if arg_16_0.nodeAward:isVisible() then
		arg_16_0.nodeAward:setPositionY(arg_16_0.animInitY + 20)
	else
		arg_16_0.nodeAward:setPositionY(arg_16_0.animInitY)
	end

	arg_16_0.btnRetry:setVisible(g_CombatSystem.combatType == COMBAT_TYPE_LEVEL)
	arg_16_0:animEffect()
end

function var_0_0.animEffect(arg_17_0)
	local var_17_0 = 0

	local function var_17_1()
		local function var_18_0(arg_19_0)
			arg_17_0.fxWinStar:setVisible(true)
			arg_17_0.fxWinStar:setAnimation("animation01", false)
		end

		local function var_18_1()
			arg_17_0.fxWinStar:setAnimation("animation02", true)
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

		local var_21_1 = CCArray:create()

		var_21_1:addObject(CCDelayTime:create(var_17_0))
		var_21_1:addObject(CCCallFuncN:create(var_21_0))

		if arg_21_1 then
			var_21_1:addObject(CCScaleTo:create(0.1, 0.95))
			var_21_1:addObject(CCScaleTo:create(0.05, 1))
		end

		arg_21_0:setVisible(false)
		arg_21_0:stopAllActions()
		arg_21_0:runAction(CCSequence:create(var_21_1))

		var_17_0 = var_17_0 + arg_21_3
	end

	var_17_1()

	var_17_0 = 0.15

	if arg_17_0.nodeAward:isVisible() then
		var_17_2(arg_17_0.nodeAward, false, false, 0.125, "")
	end

	var_17_2(arg_17_0.btnLinkTech, false, false, 0.125, "")
	var_17_2(arg_17_0.btnLinkParter, false, false, 0.125, "")
	var_17_2(arg_17_0.btnLinkSkill, false, false, 0.125, "")
	var_17_2(arg_17_0.btnLinkEquip, false, false, 0.125, "")
	var_17_2(arg_17_0.btnDamageStat, false, false, 0.125, "")

	if arg_17_0.btnRetry:isVisible() then
		var_17_2(arg_17_0.btnRetry, false, false, 0.125, "")
	end

	var_17_2(arg_17_0.btnReturn, false, false, 0.125, "")
end

function var_0_0.onLinkTech(arg_23_0)
	if zbFunHelper:isBuildingLockAndTip(EBuildingType.Tech) then
		return
	end

	arg_23_0:readyGotoLink()
	g_MainScene:showTechWnd()
end

function var_0_0.onLinkParter(arg_24_0)
	if zbFunHelper:isLockAndTip(EFuncType.Follower) then
		return
	end

	arg_24_0:readyGotoLink()
	g_MainScene:showHeroListWnd()
end

function var_0_0.onLinkSkill(arg_25_0)
	arg_25_0:readyGotoLink()
	g_MainScene:showHeroListWnd()
end

function var_0_0.onLinkEquip(arg_26_0)
	arg_26_0:readyGotoLink()
	g_MainScene:showEquipListWnd()
end

function var_0_0.onDamageStat(arg_27_0)
	g_MainScene:showBalanceData()
end

function var_0_0.onRetry(arg_28_0)
	arg_28_0:hide()
	g_CombatSystem:finish()
	g_MainScene.wndCombat:hide()

	if g_MainScene.wndEmbattle ~= nil then
		g_MainScene.wndEmbattle:gotoPrevWnd()
	end

	local var_28_0 = g_CombatSystem.combatData.levelBattleReadyAckData.LevelType
	local var_28_1 = g_CombatSystem.combatData.levelBattleReadyAckData.ForceId
	local var_28_2 = g_CombatSystem.combatData.levelBattleReadyAckData.LevelId

	g_MainScene:showLevelDialog(var_28_0, var_28_1, var_28_2)
end

function var_0_0.onReturn(arg_29_0)
	arg_29_0:hide()
	g_CombatSystem:finish()
	g_MainScene.wndCombat:hide()

	if g_CombatSystem.combatType == COMBAT_TYPE_ARENARECORD then
		return
	end

	if g_MainScene.wndEmbattle ~= nil then
		g_MainScene.wndEmbattle:gotoPrevWnd()
	end

	g_GameEventMgr:sendEvent(zbGameEvent.Event_BalanceOver_Lose)
end

function var_0_0.readyGotoLink(arg_30_0)
	local function var_30_0(arg_31_0)
		if arg_31_0 then
			arg_31_0:hide()
		end
	end

	arg_30_0:hide()
	g_CombatSystem:finish()
	g_MainScene.wndCombat:hide()
	var_30_0(g_MainScene.wndWarForce)
	var_30_0(g_MainScene.wndWarPath)
	var_30_0(g_MainScene.wndHeroTrialDetail)
	var_30_0(g_MainScene.wndHeroTrial)
	var_30_0(g_MainScene.wndPata)
	var_30_0(g_MainScene.wndYuanZheng)
	var_30_0(g_MainScene.wndWorld)
end
