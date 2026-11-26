require("gamelogic.zbItem")

zbHeroCard = class("zbHeroCard", CCNodeExtend)
zbHeroCard.__index = zbHeroCard
HeroCard_Width = 344
HeroCard_Height = 150

function zbHeroCard.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbHeroCard)

	return arg_1_0
end

function zbHeroCard.create(arg_2_0, arg_2_1)
	local var_2_0 = zbHeroCard.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1)

	return var_2_0
end

function zbHeroCard.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.heroDesc = nil
		arg_3_0.parentWnd = arg_3_1
	end

	local function var_3_1()
		CCLabelTTF:beginDelayCreateTexture()

		local var_5_0 = zbUtil:loadCCBNode("ccbi/tb_herocard.ccbi")

		arg_3_0.layerContent = tolua.cast(var_5_0:getChildByTag(1), "CCNode")

		local var_5_1 = tolua.cast(arg_3_0.layerContent:getChildByTag(1), "CCLayerColor")

		arg_3_0.heroIcon = createItem()

		arg_3_0.heroIcon:setPosition(var_5_1:getPosition())
		arg_3_0.heroIcon:setScale(0.9)
		arg_3_0.heroIcon:setNeedTip(false)
		arg_3_0.heroIcon:setSwallowsTouches(false)
		arg_3_0.layerContent:addChild(arg_3_0.heroIcon)
		var_5_1:removeFromParentAndCleanup(true)

		arg_3_0.spriteBg = tolua.cast(arg_3_0.layerContent:getChildByTag(0), "CCSprite")
		arg_3_0.spriteNew = tolua.cast(arg_3_0.layerContent:getChildByTag(8), "CCSprite")
		arg_3_0.lbName = tolua.cast(arg_3_0.layerContent:getChildByTag(2), "CCLabelTTF")
		arg_3_0.spriteType = tolua.cast(arg_3_0.layerContent:getChildByTag(4), "CCSprite")
		arg_3_0.spriteState = tolua.cast(arg_3_0.layerContent:getChildByTag(3), "CCSprite")
		arg_3_0.spriteRarity = tolua.cast(arg_3_0.layerContent:getChildByTag(7), "CCSprite")
		arg_3_0.bmFightDummy = tolua.cast(arg_3_0.layerContent:getChildByTag(1001), "CCLabelTTF")
		arg_3_0.notifyFrame = tolua.cast(arg_3_0.layerContent:getChildByTag(6), "CCSprite")

		arg_3_0.notifyFrame:setZOrder(ZORDER_TOP)
		zbUIEffect:createNotifyTagScaleAction(arg_3_0.notifyFrame)

		arg_3_0.btnTouch = tolua.cast(arg_3_0.layerContent:getChildByTag(101), "CCControlButton")
		arg_3_0.bmFight = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.bmFightDummy, arg_3_0.bmFight)
		arg_3_0.bmFight:setScale(0.55)
		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouchDown()
		end, CCControlEventTouchDown)
		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnTouch:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnTouch:setSwallowsTouches(false)
		arg_3_0.btnTouch:setZoomOnTouchDown(true)
		arg_3_0.btnTouch:setZoomChildNode(arg_3_0.layerContent)
		arg_3_0:addChild(var_5_0)

		arg_3_0.node = var_5_0

		CCLabelTTF:endDelayCreateTexture(var_5_0)
	end

	var_3_0()
	var_3_1()
end

function zbHeroCard.refresh(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0.heroDesc = arg_8_1
	arg_8_0.heroType = arg_8_2
	arg_8_0.heroDescList = arg_8_3

	arg_8_0:refreshHero(arg_8_2)

	if g_Self.kHeroHandler.isNewHero[arg_8_0.heroDesc.HeroBaseInfo.TemplateId] ~= nil then
		arg_8_0.spriteNew:setVisible(true)
	else
		arg_8_0.spriteNew:setVisible(false)
	end
end

function zbHeroCard.refreshHero(arg_9_0, arg_9_1)
	arg_9_0:setVisible(true)

	local var_9_0 = zbHeroTable:getRecord(arg_9_0.heroDesc.HeroBaseInfo.TemplateId)

	if var_9_0 == nil then
		echoInfo("error hero template id: " .. arg_9_0.heroDesc.HeroBaseInfo.TemplateId)

		return
	end

	arg_9_0.spriteType:setTexture(CCTextureCache:sharedTextureCache():addImage(zbIconHelper:getHeroTypeIconPath(var_9_0.heroType)))
	arg_9_0.spriteRarity:setTexture(CCTextureCache:sharedTextureCache():addImage("image/herodetail/herodetail_rarity" .. var_9_0.rarity .. ".png"))
	arg_9_0.spriteState:setVisible(true)

	if arg_9_1 == EHeroTabType.Battle then
		if g_Self.kFormation:isPartner(arg_9_0.heroDesc.HeroBaseInfo.TemplateId) then
			arg_9_0.spriteState:setTexture(CCTextureCache:sharedTextureCache():addImage("image/hero/hero_support.png"))
		else
			arg_9_0.spriteState:setTexture(CCTextureCache:sharedTextureCache():addImage("image/hero/hero_fighting.png"))
		end
	elseif arg_9_1 == EHeroTabType.Entourage then
		arg_9_0.spriteState:setTexture(CCTextureCache:sharedTextureCache():addImage("image/hero/hero_bench.png"))
	elseif arg_9_1 == EHeroTabType.UnUse then
		arg_9_0.spriteState:setTexture(CCTextureCache:sharedTextureCache():addImage("image/hero/hero_unuse.png"))
	else
		arg_9_0.spriteState:setVisible(false)
	end

	exchQuality, exchAdd = zbHeroQualityTable:exchangeHeroQuality(arg_9_0.heroDesc.HeroBaseInfo.Quality)

	arg_9_0.lbName:setString(var_9_0.name)

	if exchAdd ~= 0 then
		arg_9_0.lbName:setString(var_9_0.name .. "+" .. exchAdd)
	end

	local var_9_1 = zbColor:getItemColor(exchQuality)

	arg_9_0.lbName:setColor(var_9_1)
	arg_9_0.heroIcon:refreshHero(arg_9_0.heroDesc.HeroBaseInfo)
	arg_9_0.heroIcon:setNodeStarVisible()
	arg_9_0.bmFight:setString(arg_9_0.heroDesc.HeroBaseInfo.FV)
	arg_9_0.spriteBg:setGray(false)
	arg_9_0.notifyFrame:setVisible(g_Self.kHeroHandler:getHeroNotify(arg_9_0.heroDesc))
end

function zbHeroCard.onTouch(arg_10_0)
	g_MainScene:showHeroDetailWnd(arg_10_0.heroDesc, arg_10_0.heroDescList, arg_10_0.heroType):setPrevWnd(arg_10_0.parentWnd)
end

function zbHeroCard.onTouchDown(arg_11_0)
	arg_11_0.spriteNew:setVisible(false)

	g_Self.kHeroHandler.isNewHero[arg_11_0.heroDesc.HeroBaseInfo.TemplateId] = nil

	arg_11_0.parentWnd:onUpdateNotify()
end
