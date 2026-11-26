require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbWorldBossBalanceWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createWorldBossBalanceWnd()
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
		local function var_5_0(arg_6_0, arg_6_1, arg_6_2)
			local var_6_0 = createUIAnimation()

			var_6_0:refreshBone(arg_6_1)
			var_6_0:setPosition(arg_6_2)
			arg_6_0:addChild(var_6_0)

			return var_6_0
		end

		local var_5_1 = CCBProxy:create()
		local var_5_2 = CCBReaderLoad("ccbi/world_boss_balance.ccbi", var_5_1, true, "")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCNode")
		local var_5_4 = tolua.cast(var_5_2:getChildByTag(3), "CCNode")
		local var_5_5 = tolua.cast(var_5_3:getChildByTag(1001), "CCLabelTTF")
		local var_5_6 = tolua.cast(var_5_3:getChildByTag(1002), "CCLabelTTF")

		arg_3_0.spriteMoney = tolua.cast(var_5_3:getChildByTag(3), "CCSprite")
		arg_3_0.nodeAnimBottom = tolua.cast(var_5_3:getChildByTag(11), "CCNode")
		arg_3_0.nodeTop = tolua.cast(var_5_3:getChildByTag(12), "CCNode")
		arg_3_0.fxYunTopLeft = var_5_0(arg_3_0.nodeTop, "effect/spine/ui_balance_win/zuoshangyun/zuoshangyun", ccp(0, 0))
		arg_3_0.fxYunTopRight = var_5_0(arg_3_0.nodeTop, "effect/spine/ui_balance_win/youshangyun/youshangyun", ccp(0, 0))
		arg_3_0.fxYunBottomLeft = var_5_0(arg_3_0.nodeAnimBottom, "effect/spine/ui_balance_win/zuoxiayun/zuoxiayun", ccp(0, 0))
		arg_3_0.fxYunBottomRight = var_5_0(arg_3_0.nodeAnimBottom, "effect/spine/ui_balance_win/youxiayun/youxiayun", ccp(0, 0))
		arg_3_0.fxWinStar = var_5_0(arg_3_0.nodeTop, "effect/spine/ui_balance_win/zhandoujiesuan_shengli/zhandoujiesuan_shengli", ccp(0, 25))

		arg_3_0.fxYunTopLeft:setAnimation("animation", true)
		arg_3_0.fxYunTopRight:setAnimation("animation", true)
		arg_3_0.fxYunBottomLeft:setAnimation("animation", true)
		arg_3_0.fxYunBottomRight:setAnimation("animation", true)

		arg_3_0.btnReturn = tolua.cast(var_5_4:getChildByTag(31), "CCControlButton")

		arg_3_0.btnReturn:addHandleOfControlEvent(function()
			arg_3_0:onReturn()
		end, CCControlEventTouchUpInside)

		arg_3_0.lbHitStat = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_5, arg_3_0.lbHitStat)
		arg_3_0.lbHitStat:setScale(0.8)

		arg_3_0.lbMoney = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_6, arg_3_0.lbMoney)
		arg_3_0.lbMoney:setScale(0.8)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_2)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(function()
		arg_3_0:onShowCallback()
	end)
end

function var_0_0.onShowCallback(arg_9_0)
	if g_MainScene.wndCombat then
		g_MainScene.wndCombat:hideUI()
		g_MainScene.wndCombat.layerScene:hideHeros()
	end
end

function var_0_0.refreshResultData(arg_10_0)
	arg_10_0.lbHitStat:setString(g_Self.kWorldHandler.worldbossHit)

	if zbUtil:isValidTable(g_CombatSystem.combatData.awardList) then
		local var_10_0 = zbIconHelper:getAwardIconPath(g_CombatSystem.combatData.awardList[1].Type, g_CombatSystem.combatData.awardList[1].Id)

		arg_10_0.spriteMoney:setTexture(CCTextureCache:sharedTextureCache():addImage(var_10_0))
		arg_10_0.lbMoney:setString(g_CombatSystem.combatData.awardList[1].Count)
	end

	arg_10_0:animEffect()
end

function var_0_0.animEffect(arg_11_0)
	local var_11_0 = 0

	local function var_11_1()
		local function var_12_0(arg_13_0)
			arg_11_0.fxWinStar:setVisible(true)
			arg_11_0.fxWinStar:setAnimation("jieshu_01", false)
		end

		local function var_12_1()
			arg_11_0.fxWinStar:setAnimation("jieshu_02", true)
		end

		local var_12_2 = CCArray:create()

		var_12_2:addObject(CCCallFuncN:create(var_12_0))
		var_12_2:addObject(CCDelayTime:create(3))
		var_12_2:addObject(CCCallFuncN:create(var_12_1))
		arg_11_0.fxWinStar:setVisible(false)
		arg_11_0.fxWinStar:stopAllActions()
		arg_11_0.fxWinStar:runAction(CCSequence:create(var_12_2))

		var_11_0 = var_11_0 + 1
	end

	local function var_11_2(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
		local function var_15_0(arg_16_0)
			arg_16_0:setVisible(true)
		end

		local function var_15_1()
			arg_15_0:animHeroExpUp()
			arg_15_0:animSkillExpUp()
		end

		local var_15_2 = CCArray:create()

		var_15_2:addObject(CCDelayTime:create(var_11_0))
		var_15_2:addObject(CCCallFuncN:create(var_15_0))

		if arg_15_1 then
			var_15_2:addObject(CCScaleTo:create(0.1, 0.9))
			var_15_2:addObject(CCScaleTo:create(0.05, 0.95))
		end

		if arg_15_2 then
			var_15_2:addObject(CCCallFuncN:create(var_15_1))
		end

		arg_15_0:setVisible(false)
		arg_15_0:stopAllActions()
		arg_15_0:runAction(CCSequence:create(var_15_2))

		var_11_0 = var_11_0 + arg_15_3
	end

	var_11_1()

	var_11_0 = 0.15

	var_11_2(arg_11_0.btnReturn, false, false, 0.125)
end

function var_0_0.onReturn(arg_18_0)
	arg_18_0:hide()
	g_CombatSystem:finish()
	g_MainScene.wndCombat:hide()
	g_MainScene:showWorldBoss()

	if g_MainScene.wndWorld then
		print("PPPPPPPPPPPPPPPPPP")
		g_MainScene.wndWorld:setVisible(true)
	end
end
