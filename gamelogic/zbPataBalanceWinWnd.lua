require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbPataBalanceWinWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createPataBalanceWinWnd()
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
		arg_3_0.heros = {}
		arg_3_0.items = {}
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
		local var_5_2 = CCBReaderLoad("ccbi/patabalance_win.ccbi", var_5_1, true, "")

		arg_3_0.layerDetail = tolua.cast(var_5_2:getChildByTag(1), "CCNode")
		arg_3_0.nodeHead = tolua.cast(arg_3_0.layerDetail:getChildByTag(1), "CCNode")

		local var_5_3 = tolua.cast(arg_3_0.nodeHead:getChildByTag(1), "CCLabelTTF")
		local var_5_4 = tolua.cast(arg_3_0.nodeHead:getChildByTag(2), "CCLabelTTF")
		local var_5_5 = tolua.cast(arg_3_0.nodeHead:getChildByTag(3), "CCLabelTTF")

		arg_3_0.lbBaseJifen = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_3, arg_3_0.lbBaseJifen)
		arg_3_0.lbBaseJifen:setScale(1.2)

		arg_3_0.lbStarNum = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_4, arg_3_0.lbStarNum)
		arg_3_0.lbStarNum:setScale(1.2)

		arg_3_0.lbTotalJifen = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_5, arg_3_0.lbTotalJifen)
		arg_3_0.lbTotalJifen:setScale(1.2)

		local var_5_6 = tolua.cast(arg_3_0.layerDetail:getChildByTag(2), "CCNode")

		for iter_5_0 = 1, 3 do
			local var_5_7 = tolua.cast(var_5_6:getChildByTag(iter_5_0), "CCLayerColor")
			local var_5_8 = createItem()

			var_5_8:setPosition(var_5_7:getPosition())
			var_5_8:setScale(var_5_7:getScale())
			var_5_6:addChild(var_5_8)
			var_5_7:removeFromParentAndCleanup(true)

			arg_3_0.items[iter_5_0] = var_5_8
		end

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
		arg_3_0.btnReturn = tolua.cast(var_5_2:getChildByTag(3):getChildByTag(31), "CCControlButton")

		arg_3_0.btnDamageStat:addHandleOfControlEvent(function()
			arg_3_0:onDamageStat()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnReturn:addHandleOfControlEvent(function()
			arg_3_0:onReturn()
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

function var_0_0.onShowCallback(arg_10_0)
	g_MainScene.wndCombat:hideUI()
	g_MainScene.wndCombat.layerScene:hideHeros()
end

function var_0_0.refreshResultData(arg_11_0)
	local var_11_0 = zbPataMatchBossTable:getRecord(g_GameData.PataInfo.BaseInfo.Layer)
	local var_11_1 = 1

	for iter_11_0, iter_11_1 in pairs(g_DataConfig.kPataCommonTable.scoreRate) do
		if g_CombatSystem.combatData.result == iter_11_1.result then
			var_11_1 = iter_11_1.rate

			break
		end
	end

	if var_11_0 ~= nil then
		arg_11_0.lbBaseJifen:setString(var_11_0.baseScore)
		arg_11_0.lbStarNum:setString(var_11_1)
		arg_11_0.lbTotalJifen:setString(var_11_0.baseScore * var_11_1)
	end

	for iter_11_2, iter_11_3 in pairs(arg_11_0.items) do
		iter_11_3:setVisible(false)
	end

	if zbUtil:isValidTable(g_CombatSystem.combatData.awardList) then
		local var_11_2 = 1

		for iter_11_4, iter_11_5 in pairs(g_CombatSystem.combatData.awardList) do
			local var_11_3 = arg_11_0.items[var_11_2]

			if var_11_3 ~= nil then
				var_11_3:refreshAward(iter_11_5.Type, iter_11_5.Id, iter_11_5.Count, false)
				var_11_3:setVisible(true)
			end

			var_11_2 = var_11_2 + 1
		end
	end

	arg_11_0:animEffect()
end

function var_0_0.animEffect(arg_12_0)
	local var_12_0 = 0

	local function var_12_1()
		local function var_13_0(arg_14_0)
			arg_12_0.fxWinStar:setVisible(true)
			arg_12_0.fxWinStar:setAnimation(g_CombatSystem.combatData.result .. "xing_01", false)
		end

		local function var_13_1()
			arg_12_0.fxWinStar:setAnimation(g_CombatSystem.combatData.result .. "xing_02", true)
		end

		local var_13_2 = CCArray:create()

		var_13_2:addObject(CCCallFuncN:create(var_13_0))
		var_13_2:addObject(CCDelayTime:create(3))
		var_13_2:addObject(CCCallFuncN:create(var_13_1))
		arg_12_0.fxWinStar:setVisible(false)
		arg_12_0.fxWinStar:stopAllActions()
		arg_12_0.fxWinStar:runAction(CCSequence:create(var_13_2))

		var_12_0 = var_12_0 + 1
	end

	local function var_12_2(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
		local function var_16_0(arg_17_0)
			arg_17_0:setVisible(true)

			if arg_16_4 ~= "" then
				g_Audio:playSound(arg_16_4)
			end
		end

		local function var_16_1()
			arg_16_0:animHeroExpUp()
			arg_16_0:animSkillExpUp()
		end

		local var_16_2 = CCArray:create()

		var_16_2:addObject(CCDelayTime:create(var_12_0))
		var_16_2:addObject(CCCallFuncN:create(var_16_0))

		if arg_16_1 then
			var_16_2:addObject(CCScaleTo:create(0.1, 0.9))
			var_16_2:addObject(CCScaleTo:create(0.05, 0.95))
		end

		if arg_16_2 then
			var_16_2:addObject(CCCallFuncN:create(var_16_1))
		end

		arg_16_0:setVisible(false)
		arg_16_0:stopAllActions()
		arg_16_0:runAction(CCSequence:create(var_16_2))

		var_12_0 = var_12_0 + arg_16_3
	end

	var_12_1()

	var_12_0 = 0.15

	for iter_12_0, iter_12_1 in pairs(arg_12_0.items) do
		if iter_12_1:isVisible() == true then
			var_12_2(iter_12_1, false, false, 0.125, "")
		end
	end

	var_12_2(arg_12_0.btnReturn, false, false, 0.125, "")
end

function var_0_0.onDamageStat(arg_19_0)
	g_MainScene:showBalanceData()
end

function var_0_0.onReturn(arg_20_0)
	arg_20_0:hide()
	g_CombatSystem:finish()
	g_MainScene.wndCombat:hide()

	if g_MainScene.wndEmbattle ~= nil then
		g_MainScene.wndEmbattle:gotoPrevWnd()
	end

	g_GameEventMgr:sendEvent(zbGameEvent.Event_BalanceOver_Win)
end
