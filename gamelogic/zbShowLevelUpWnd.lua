require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbShowLevelUpWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createShowLevelUpWnd()
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
		function createArrowMoveAction(arg_6_0)
			local var_6_0 = 1.1
			local var_6_1 = 10
			local var_6_2 = ccp(arg_6_0:getPosition())

			var_6_2.x = var_6_2.x - 3

			local var_6_3 = CCMoveTo:create(var_6_0, var_6_2)

			var_6_2.x = var_6_2.x + 6

			local var_6_4 = CCMoveTo:create(var_6_0, var_6_2)
			local var_6_5 = CCArray:create()

			var_6_5:addObject(var_6_3)
			var_6_5:addObject(var_6_4)

			local var_6_6 = CCSequence:create(var_6_5)

			arg_6_0:stopAllActions()
			arg_6_0:runAction(CCRepeatForever:create(var_6_6))
		end

		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/show_celebrate.ccbi", var_5_0, true, "")

		arg_3_0.spriteBg = tolua.cast(var_5_1:getChildByTag(1), "CCSprite")
		arg_3_0.nodeEffect = tolua.cast(arg_3_0.spriteBg:getChildByTag(1), "CCNode")
		arg_3_0.spriteTitle = tolua.cast(arg_3_0.spriteBg:getChildByTag(2), "CCSprite")
		arg_3_0.btnFinish = tolua.cast(arg_3_0.spriteBg:getChildByTag(3), "CCControlButton")
		arg_3_0.btnClose = tolua.cast(arg_3_0.spriteBg:getChildByTag(31), "CCControlButton")
		arg_3_0.nodeLevel = tolua.cast(arg_3_0.spriteBg:getChildByTag(11), "CCNode")
		arg_3_0.spriteLevel = tolua.cast(arg_3_0.nodeLevel:getChildByTag(1), "CCSprite")

		local var_5_2 = tolua.cast(arg_3_0.nodeLevel:getChildByTag(2), "CCLabelTTF")
		local var_5_3 = tolua.cast(arg_3_0.nodeLevel:getChildByTag(3), "CCLabelTTF")

		arg_3_0.nodeTili = tolua.cast(arg_3_0.spriteBg:getChildByTag(12), "CCNode")
		arg_3_0.spriteTili = tolua.cast(arg_3_0.nodeTili:getChildByTag(1), "CCSprite")

		local var_5_4 = tolua.cast(arg_3_0.nodeTili:getChildByTag(2), "CCLabelTTF")
		local var_5_5 = tolua.cast(arg_3_0.nodeTili:getChildByTag(3), "CCLabelTTF")

		arg_3_0.nodeAward = tolua.cast(arg_3_0.spriteBg:getChildByTag(13), "CCNode")

		local var_5_6 = tolua.cast(arg_3_0.nodeAward:getChildByTag(2), "CCLabelTTF")

		arg_3_0.lbCurLv = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_2, arg_3_0.lbCurLv)
		arg_3_0.lbCurLv:setScale(0.9)

		arg_3_0.lbNextLv = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_3, arg_3_0.lbNextLv)
		arg_3_0.lbNextLv:setScale(0.9)

		arg_3_0.lbCurTili = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_4, arg_3_0.lbCurTili)
		arg_3_0.lbCurTili:setScale(0.8)

		arg_3_0.lbNextTili = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_5, arg_3_0.lbNextTili)
		arg_3_0.lbNextTili:setScale(0.8)

		arg_3_0.lbAwardCount = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_6, arg_3_0.lbAwardCount)
		arg_3_0.lbAwardCount:setScale(0.8)
		arg_3_0.btnFinish:addHandleOfControlEvent(function()
			arg_3_0:onFinish()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:onFinish()
		end, CCControlEventTouchUpInside)
		createArrowMoveAction(arg_3_0.spriteLevel)
		createArrowMoveAction(arg_3_0.spriteTili)
		arg_3_0:setWinType(EWinType.Pop_HideAll)
		arg_3_0:addChild(var_5_1)
	end

	local function var_3_2()
		arg_3_0.effect = createUIAnimation()

		arg_3_0.effect:refresh("effect/spine/zhanshi/zhanshi.json", "effect/spine/zhanshi/zhanshi.atlas")
		arg_3_0.effect:setPosition(0, 85)
		arg_3_0.nodeEffect:addChild(arg_3_0.effect)
	end

	local function var_3_3()
		arg_3_0.animation = createUIAnimation()

		arg_3_0.animation:setRotationY(180)
		arg_3_0.animation:setPosition(-120, -20)
		arg_3_0.animation:setScale(1.5)
		arg_3_0.nodeEffect:addChild(arg_3_0.animation)
	end

	var_3_0()
	var_3_1()
	var_3_2()
	var_3_3()
end

function var_0_0.refresh(arg_11_0)
	local var_11_0 = 0

	if g_GameData and g_GameData.BaseInfo then
		var_11_0 = g_GameData.BaseInfo.AvatarId
	end

	arg_11_0.animation:refreshAvatarId(var_11_0)
	g_Self:setNeedShowLevelUp(false)
	g_Audio:playSound(AudioDefine.UI_NEWHERO)
	arg_11_0:showDetails()
	arg_11_0:playEffect()

	local var_11_1 = zbFunctionUnlockTable:getCurNewFunction(true)

	if var_11_1 ~= nil then
		g_MainScene:setNewFunLocalFlag(var_11_1, 1)
	end

	zbChannelUtil_Report:submitRoleInfoByChannel(ESubRoleInfoType.E_LVUP)
end

function var_0_0.onFinish(arg_12_0)
	if arg_12_0.btnClose:isVisible() == false then
		return
	end

	arg_12_0:hide()
	g_MainScene:checkShowNewFuncWnd(true)

	if g_Self.kGodHandler.getnewGodId ~= nil then
		g_MainScene:showNewGodWnd(g_Self.kGodHandler.getnewGodId)

		g_Self.kGodHandler.getnewGodId = nil
	end
end

function var_0_0.showDetails(arg_13_0)
	arg_13_0.lbCurLv:setString(g_Self:getLevel() - 1)
	arg_13_0.lbNextLv:setString(g_Self:getLevel())

	local var_13_0 = zbPlayerUpgradeTable:getLevelAward(g_Self:getLevel() - 1)

	arg_13_0.lbAwardCount:setString("+" .. var_13_0)

	if g_Self:getLevel() <= 51 then
		arg_13_0.nodeTili:setVisible(true)
		arg_13_0.nodeAward:setPositionY(arg_13_0.nodeTili:getPositionY() - 75)
		arg_13_0.lbCurTili:setString(g_Self:getLevel() + 98)
		arg_13_0.lbNextTili:setString(g_Self:getLevel() + 99)
	else
		arg_13_0.nodeTili:setVisible(false)
		arg_13_0.nodeAward:setPositionY(arg_13_0.nodeTili:getPositionY())
	end
end

function var_0_0.playEffect(arg_14_0)
	local var_14_0 = 0

	local function var_14_1(arg_15_0, arg_15_1)
		local function var_15_0()
			arg_15_0:setVisible(true)
			arg_15_0:playAnimationOnce(ANIMATION_SEQUENCE_WIN, ANIMATION_SEQUENCE_IDLE, 0.2)
		end

		local var_15_1 = CCArray:create()

		var_15_1:addObject(CCDelayTime:create(var_14_0))
		var_15_1:addObject(CCCallFuncN:create(var_15_0))
		arg_15_0:setVisible(false)
		arg_15_0:stopAllActions()
		arg_15_0:runAction(CCSequence:create(var_15_1))

		var_14_0 = var_14_0 + arg_15_1
	end

	local function var_14_2(arg_17_0, arg_17_1, arg_17_2)
		local function var_17_0(arg_18_0)
			arg_18_0:setVisible(true)
		end

		local var_17_1 = CCArray:create()

		var_17_1:addObject(CCDelayTime:create(var_14_0))
		var_17_1:addObject(CCCallFuncN:create(var_17_0))
		arg_17_0:setVisible(false)
		arg_17_0:stopAllActions()
		arg_17_0:runAction(CCSequence:create(var_17_1))

		var_14_0 = var_14_0 + arg_17_1
	end

	arg_14_0.effect:playAnimationOnce("levelup_1", "levelup_2", 0.125)

	var_14_0 = var_14_0 + 0.5

	var_14_2(arg_14_0.spriteTitle, 0.25)
	var_14_1(arg_14_0.animation, 0.25)
	var_14_2(arg_14_0.nodeLevel, 0.25)

	if arg_14_0.nodeTili:isVisible() then
		var_14_2(arg_14_0.nodeTili, 0.25)
	end

	var_14_2(arg_14_0.nodeAward, 0.25)
	var_14_2(arg_14_0.btnFinish, 0.25)
	var_14_2(arg_14_0.btnClose, 0.25)
end
