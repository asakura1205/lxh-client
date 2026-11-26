require("gamelogic.zbItem")

zbHeroFragCard = class("zbHeroFragCard", CCNodeExtend)
zbHeroFragCard.__index = zbHeroFragCard
HeroCard_Width = 344
HeroCard_Height = 150

function zbHeroFragCard.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbHeroFragCard)

	return arg_1_0
end

function zbHeroFragCard.create(arg_2_0, arg_2_1)
	local var_2_0 = zbHeroFragCard.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1)

	return var_2_0
end

function zbHeroFragCard.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.heroDesc = nil
		arg_3_0.parentWnd = arg_3_1
	end

	local function var_3_1()
		CCLabelTTF:beginDelayCreateTexture()

		local var_5_0 = zbUtil:loadCCBNode("ccbi/tb_herofragcard.ccbi")

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
		arg_3_0.spriteType = tolua.cast(arg_3_0.layerContent:getChildByTag(3), "CCSprite")
		arg_3_0.spriteRarity = tolua.cast(arg_3_0.layerContent:getChildByTag(4), "CCSprite")
		arg_3_0.spriteProgressFragBg = tolua.cast(arg_3_0.layerContent:getChildByTag(5), "CCSprite")
		arg_3_0.bmFragNumDummy = tolua.cast(arg_3_0.layerContent:getChildByTag(1002), "CCLabelTTF")
		arg_3_0.canUp = tolua.cast(arg_3_0.layerContent:getChildByTag(6), "CCSprite")

		arg_3_0.canUp:setZOrder(ZORDER_TOP)

		arg_3_0.btnTouch = tolua.cast(arg_3_0.layerContent:getChildByTag(101), "CCControlButton")
		arg_3_0.bmFragNum = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.bmFragNumDummy, arg_3_0.bmFragNum)
		arg_3_0.bmFragNum:setScale(0.45)

		arg_3_0.progressTimer = zbUtil:createProgressTimer(arg_3_0.spriteProgressFragBg, "image/main/main_exp_progress.png")

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

function zbHeroFragCard.refresh(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0.heroDesc = arg_8_1
	arg_8_0.heroType = arg_8_2
	arg_8_0.heroDescList = arg_8_3

	arg_8_0:refreshHeroFrag()
end

function zbHeroFragCard.refreshHeroFrag(arg_9_0)
	arg_9_0:setVisible(true)

	local var_9_0 = zbHeroTable:getRecord(arg_9_0.heroDesc.TemplateId)

	if var_9_0 == nil then
		echoInfo("error hero template id: " .. arg_9_0.heroDesc.TemplateId)

		return
	end

	arg_9_0.spriteType:setTexture(CCTextureCache:sharedTextureCache():addImage(zbIconHelper:getHeroTypeIconPath(var_9_0.heroType)))
	arg_9_0.spriteRarity:setTexture(CCTextureCache:sharedTextureCache():addImage("image/herodetail/herodetail_rarity" .. var_9_0.rarity .. ".png"))

	exchQuality, exchAdd = zbHeroQualityTable:exchangeHeroQuality(var_9_0.quality)

	arg_9_0.lbName:setString(var_9_0.name)

	if exchAdd ~= 0 then
		arg_9_0.lbName:setString(var_9_0.name .. "+" .. exchAdd)
	end

	local var_9_1 = zbColor:getItemColor(exchQuality)

	arg_9_0.lbName:setColor(var_9_1)

	local var_9_2 = arg_9_0.heroDesc.Count
	local var_9_3 = g_Self.kHeroFragHandler:getHeroComposeNeeds(arg_9_0.heroDesc.TemplateId)

	if var_9_3 ~= nil then
		arg_9_0.bmFragNum:setString(var_9_2 .. "/" .. var_9_3.needFrag)
		arg_9_0.canUp:setVisible(var_9_2 >= var_9_3.needFrag)
		arg_9_0.spriteBg:setGray(false)
	end

	local var_9_4 = math.min(math.ceil(var_9_2 / var_9_3.needFrag * 100), 99)

	arg_9_0.progressTimer:setPercentage(var_9_4)
	arg_9_0.heroIcon:refreshHeroFrag(ECommonAwardType.HeroFrag, arg_9_0.heroDesc.TemplateId, var_9_2, true, false)
end

function zbHeroFragCard.onTouch(arg_10_0)
	local var_10_0 = g_Self.kHeroFragHandler:getHeroComposeNeeds(arg_10_0.heroDesc.TemplateId)

	if arg_10_0.heroDesc.Count >= var_10_0.needFrag then
		g_MainScene:showFragComposeWnd(arg_10_0.heroDesc, ELinkType.Hero)
	else
		g_MainScene:showHeroGetWay(arg_10_0.heroDesc.TemplateId)
	end
end

function zbHeroFragCard.onTouchDown(arg_11_0)
	arg_11_0.parentWnd:onUpdateNotify()
end
