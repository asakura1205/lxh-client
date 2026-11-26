require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbShowHeroStarUpWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createShowHeroStarUpWnd()
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
		local var_5_1 = CCBReaderLoad("ccbi/show_starup.ccbi", var_5_0, true, "")

		arg_3_0.spriteBg = tolua.cast(var_5_1:getChildByTag(1), "CCSprite")
		arg_3_0.nodeEffect = tolua.cast(arg_3_0.spriteBg:getChildByTag(1), "CCNode")
		arg_3_0.spriteTitle = tolua.cast(arg_3_0.spriteBg:getChildByTag(2), "CCSprite")
		arg_3_0.btnFinish = tolua.cast(arg_3_0.spriteBg:getChildByTag(3), "CCControlButton")
		arg_3_0.btnClose = tolua.cast(arg_3_0.spriteBg:getChildByTag(31), "CCControlButton")
		arg_3_0.nodeStar = tolua.cast(arg_3_0.spriteBg:getChildByTag(4), "CCNode")
		arg_3_0.spriteCurrStars = {}

		for iter_5_0 = 1, 8 do
			arg_3_0.spriteCurrStars[iter_5_0] = arg_3_0.nodeStar:getChildByTag(iter_5_0)
		end

		arg_3_0.lbHeroName = tolua.cast(arg_3_0.spriteBg:getChildByTag(5), "CCLabelTTF")
		arg_3_0.nodeForce = tolua.cast(arg_3_0.spriteBg:getChildByTag(21), "CCNode")
		arg_3_0.spriteForce = tolua.cast(arg_3_0.nodeForce:getChildByTag(1), "CCSprite")

		local var_5_2 = tolua.cast(arg_3_0.nodeForce:getChildByTag(2), "CCLabelTTF")
		local var_5_3 = tolua.cast(arg_3_0.nodeForce:getChildByTag(3), "CCLabelTTF")

		arg_3_0.nodeZhili = tolua.cast(arg_3_0.spriteBg:getChildByTag(22), "CCNode")
		arg_3_0.spriteZhili = tolua.cast(arg_3_0.nodeZhili:getChildByTag(1), "CCSprite")

		local var_5_4 = tolua.cast(arg_3_0.nodeZhili:getChildByTag(2), "CCLabelTTF")
		local var_5_5 = tolua.cast(arg_3_0.nodeZhili:getChildByTag(3), "CCLabelTTF")

		arg_3_0.nodeTili = tolua.cast(arg_3_0.spriteBg:getChildByTag(23), "CCNode")
		arg_3_0.spriteTili = tolua.cast(arg_3_0.nodeTili:getChildByTag(1), "CCSprite")

		local var_5_6 = tolua.cast(arg_3_0.nodeTili:getChildByTag(2), "CCLabelTTF")
		local var_5_7 = tolua.cast(arg_3_0.nodeTili:getChildByTag(3), "CCLabelTTF")

		arg_3_0.lbCurForce = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_2, arg_3_0.lbCurForce)
		arg_3_0.lbCurForce:setScale(0.65)

		arg_3_0.lbNextForce = CCLabelAtlas:create("", "font/rank_num_green.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_3, arg_3_0.lbNextForce)
		arg_3_0.lbNextForce:setScale(0.65)

		arg_3_0.lbCurZhili = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_4, arg_3_0.lbCurZhili)
		arg_3_0.lbCurZhili:setScale(0.65)

		arg_3_0.lbNextZhili = CCLabelAtlas:create("", "font/rank_num_green.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_5, arg_3_0.lbNextZhili)
		arg_3_0.lbNextZhili:setScale(0.65)

		arg_3_0.lbCurTili = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_6, arg_3_0.lbCurTili)
		arg_3_0.lbCurTili:setScale(0.65)

		arg_3_0.lbNextTili = CCLabelAtlas:create("", "font/rank_num_green.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_7, arg_3_0.lbNextTili)
		arg_3_0.lbNextTili:setScale(0.65)
		arg_3_0.btnFinish:addHandleOfControlEvent(function()
			arg_3_0:onFinish()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:onFinish()
		end, CCControlEventTouchUpInside)
		createArrowMoveAction(arg_3_0.spriteForce)
		createArrowMoveAction(arg_3_0.spriteZhili)
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

	var_3_0()
	var_3_1()
	var_3_2()
end

function var_0_0.refresh(arg_10_0, arg_10_1)
	arg_10_0.type = arg_10_1

	if g_Self.kHeroHandler.lastTemplateId ~= 0 then
		local var_10_0 = g_Self.kHeroHandler:getHeroByTemplateId(g_Self.kHeroHandler.lastTemplateId)

		if arg_10_1 == EHeroDetailTab.Phase then
			arg_10_0:showPhaseDetails(var_10_0)
		else
			arg_10_0:showStarUpDetails(var_10_0)
		end

		g_Audio:playSound(AudioDefine.UI_NEWHERO)
		arg_10_0:playEffect()

		g_Self.kHeroHandler.lastTemplateId = 0
	else
		arg_10_0:hide()
	end
end

function var_0_0.onFinish(arg_11_0)
	arg_11_0:hide()
end

function var_0_0.showStarUpDetails(arg_12_0, arg_12_1)
	force, intelligence, tili = g_Self.kHeroHandler:getHeroGrow(arg_12_1.HeroBaseInfo.TemplateId, arg_12_1.HeroBaseInfo.Level, arg_12_1.HeroBaseInfo.Star - 1, arg_12_1.HeroBaseInfo.Quality)

	arg_12_0.lbCurForce:setString(tonumber(string.format("%.1f", force)))
	arg_12_0.lbCurZhili:setString(tonumber(string.format("%.1f", intelligence)))
	arg_12_0.lbCurTili:setString(tonumber(string.format("%.1f", tili)))

	force, intelligence, tili = g_Self.kHeroHandler:getHeroGrow(arg_12_1.HeroBaseInfo.TemplateId, arg_12_1.HeroBaseInfo.Level, arg_12_1.HeroBaseInfo.Star, arg_12_1.HeroBaseInfo.Quality)

	arg_12_0.lbNextForce:setString(tonumber(string.format("%.1f", force)))
	arg_12_0.lbNextZhili:setString(tonumber(string.format("%.1f", intelligence)))
	arg_12_0.lbNextTili:setString(tonumber(string.format("%.1f", tili)))
	zbUIEffect:centerHeroStar(arg_12_0.spriteCurrStars, arg_12_1.HeroBaseInfo.Star)
	arg_12_0.nodeStar:setVisible(true)
	arg_12_0.lbHeroName:setVisible(false)
end

function var_0_0.showPhaseDetails(arg_13_0, arg_13_1)
	force, intelligence, tili = g_Self.kHeroHandler:getHeroGrow(arg_13_1.HeroBaseInfo.TemplateId, arg_13_1.HeroBaseInfo.Level, arg_13_1.HeroBaseInfo.Star, arg_13_1.HeroBaseInfo.Quality - 1)

	arg_13_0.lbCurForce:setString(tonumber(string.format("%.1f", force)))
	arg_13_0.lbCurZhili:setString(tonumber(string.format("%.1f", intelligence)))
	arg_13_0.lbCurTili:setString(tonumber(string.format("%.1f", tili)))

	force, intelligence, tili = g_Self.kHeroHandler:getHeroGrow(arg_13_1.HeroBaseInfo.TemplateId, arg_13_1.HeroBaseInfo.Level, arg_13_1.HeroBaseInfo.Star, arg_13_1.HeroBaseInfo.Quality)

	arg_13_0.lbNextForce:setString(tonumber(string.format("%.1f", force)))
	arg_13_0.lbNextZhili:setString(tonumber(string.format("%.1f", intelligence)))
	arg_13_0.lbNextTili:setString(tonumber(string.format("%.1f", tili)))

	local var_13_0 = zbHeroTable:getRecord(arg_13_1.HeroBaseInfo.TemplateId)

	if var_13_0 == nil then
		echoInfo("error hero template id: " .. arg_13_1.HeroBaseInfo.TemplateId)

		return
	end

	exchQuality, exchAdd = zbHeroQualityTable:exchangeHeroQuality(arg_13_1.HeroBaseInfo.Quality)

	arg_13_0.lbHeroName:setString(var_13_0.name)

	if exchAdd ~= 0 then
		arg_13_0.lbHeroName:setString(var_13_0.name .. "+" .. exchAdd)
	end

	local var_13_1 = zbColor:getHeroNameColor(arg_13_1.HeroBaseInfo.Quality)

	arg_13_0.lbHeroName:setColor(var_13_1)
	arg_13_0.nodeStar:setVisible(false)
	arg_13_0.lbHeroName:setVisible(true)
end

function var_0_0.playEffect(arg_14_0)
	local var_14_0 = 0

	local function var_14_1(arg_15_0, arg_15_1)
		local function var_15_0(arg_16_0)
			arg_16_0:setVisible(true)
		end

		local var_15_1 = CCArray:create()

		var_15_1:addObject(CCDelayTime:create(var_14_0))
		var_15_1:addObject(CCCallFuncN:create(var_15_0))
		arg_15_0:setVisible(false)
		arg_15_0:stopAllActions()
		arg_15_0:runAction(CCSequence:create(var_15_1))

		var_14_0 = var_14_0 + arg_15_1
	end

	arg_14_0.effect:playAnimationOnce("starup_1", "starup_2", 0.125)

	var_14_0 = var_14_0 + 0.5

	if arg_14_0.type == EHeroDetailTab.Phase then
		var_14_1(arg_14_0.lbHeroName, 0.25)
		arg_14_0.spriteTitle:setTexture(CCTextureCache:sharedTextureCache():addImage("image/title/title_heroParse.png"))
	else
		var_14_1(arg_14_0.nodeStar, 0.25)
		arg_14_0.spriteTitle:setTexture(CCTextureCache:sharedTextureCache():addImage("image/title/title_herostarup.png"))
	end

	var_14_1(arg_14_0.spriteTitle, 0.25)
	var_14_1(arg_14_0.nodeForce, 0.25)
	var_14_1(arg_14_0.nodeZhili, 0.25)
	var_14_1(arg_14_0.nodeTili, 0.25)
	var_14_1(arg_14_0.btnFinish, 0.25)
	var_14_1(arg_14_0.btnClose, 0.25)
end
