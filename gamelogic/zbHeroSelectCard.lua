require("gamelogic.zbItem")

zbHeroSelectCard = class("zbHeroSelectCard", CCNodeExtend)
zbHeroSelectCard.__index = zbHeroSelectCard

function zbHeroSelectCard.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbHeroSelectCard)

	return arg_1_0
end

function createHeroSelectCard(arg_2_0, arg_2_1)
	local var_2_0 = zbHeroSelectCard.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0, arg_2_1)

	return var_2_0
end

function zbHeroSelectCard.init(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0()
		arg_3_0.heroDesc = nil
	end

	local function var_3_1()
		arg_3_0.layerContent = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		local var_5_0 = tolua.cast(arg_3_0.layerContent:getChildByTag(1), "CCLayerColor")

		arg_3_0.heroIcon = createItem()

		arg_3_0.heroIcon:setPosition(var_5_0:getPosition())
		arg_3_0.heroIcon:setScale(0.9)
		arg_3_0.heroIcon:setNeedTip(false)
		arg_3_0.heroIcon:setSwallowsTouches(false)
		arg_3_0.layerContent:addChild(arg_3_0.heroIcon)
		var_5_0:removeFromParentAndCleanup(true)

		arg_3_0.spriteBg = tolua.cast(arg_3_0.layerContent:getChildByTag(0), "CCSprite")
		arg_3_0.spriteNew = tolua.cast(arg_3_0.layerContent:getChildByTag(8), "CCSprite")
		arg_3_0.lbName = tolua.cast(arg_3_0.layerContent:getChildByTag(2), "CCLabelTTF")
		arg_3_0.spriteType = tolua.cast(arg_3_0.layerContent:getChildByTag(3), "CCSprite")
		arg_3_0.spriteAttType = tolua.cast(arg_3_0.layerContent:getChildByTag(4), "CCSprite")
		arg_3_0.spriteRarity = tolua.cast(arg_3_0.layerContent:getChildByTag(7), "CCSprite")
		arg_3_0.bmFightDummy = tolua.cast(arg_3_0.layerContent:getChildByTag(1001), "CCLabelTTF")
		arg_3_0.notifyFrame = tolua.cast(arg_3_0.layerContent:getChildByTag(6), "CCSprite")
		arg_3_0.btnTouch = tolua.cast(arg_3_0.layerContent:getChildByTag(101), "CCControlButton")
		arg_3_0.bmFight = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.bmFightDummy, arg_3_0.bmFight)
		arg_3_0.bmFight:setScale(0.55)
		arg_3_0.spriteNew:setVisible(false)
		arg_3_0.notifyFrame:setVisible(false)
		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnTouch:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnTouch:setSwallowsTouches(false)
		arg_3_0.btnTouch:setZoomOnTouchDown(true)
		arg_3_0.btnTouch:setZoomChildNode(arg_3_0.layerContent)
		arg_3_0:addChild(arg_3_1)

		arg_3_0.node = arg_3_1
	end

	var_3_0()
	var_3_1()
end

function zbHeroSelectCard.refresh(arg_7_0, arg_7_1)
	arg_7_0.heroDesc = arg_7_1
	arg_7_0.heroType = heroType

	arg_7_0:setVisible(true)

	local var_7_0 = zbHeroTable:getRecord(arg_7_0.heroDesc.HeroBaseInfo.TemplateId)

	if var_7_0 == nil then
		echoInfo("error hero template id: " .. arg_7_0.heroDesc.HeroBaseInfo.TemplateId)

		return
	end

	arg_7_0.spriteAttType:setTexture(CCTextureCache:sharedTextureCache():addImage(zbIconHelper:getHeroTypeIconPath(var_7_0.heroType)))
	arg_7_0.spriteRarity:setTexture(CCTextureCache:sharedTextureCache():addImage("image/herodetail/herodetail_rarity" .. var_7_0.rarity .. ".png"))
	arg_7_0.spriteType:setVisible(true)

	if heroType == EHeroTabType.Battle then
		arg_7_0.spriteType:setTexture(CCTextureCache:sharedTextureCache():addImage("image/hero/hero_fighting.png"))
	elseif heroType == EHeroTabType.Entourage then
		arg_7_0.spriteType:setTexture(CCTextureCache:sharedTextureCache():addImage("image/hero/hero_bench.png"))
	elseif heroType == EHeroTabType.UnUse then
		arg_7_0.spriteType:setTexture(CCTextureCache:sharedTextureCache():addImage("image/hero/hero_unuse.png"))
	else
		arg_7_0.spriteType:setVisible(false)
	end

	exchQuality, exchAdd = zbHeroQualityTable:exchangeHeroQuality(arg_7_0.heroDesc.HeroBaseInfo.Quality)

	arg_7_0.lbName:setString(var_7_0.name)

	if exchAdd ~= 0 then
		arg_7_0.lbName:setString(var_7_0.name .. "+" .. exchAdd)
	end

	local var_7_1 = zbColor:getItemColor(exchQuality)

	arg_7_0.lbName:setColor(var_7_1)
	arg_7_0.heroIcon:refreshHero(arg_7_0.heroDesc.HeroBaseInfo)
	arg_7_0.heroIcon:setNodeStarVisible()
	arg_7_0.bmFight:setString(arg_7_0.heroDesc.HeroBaseInfo.FV)
	arg_7_0.spriteBg:setGray(false)
end

function zbHeroSelectCard.onTouch(arg_8_0)
	if g_MainScene.wndHeroSelect and g_MainScene.wndHeroSelect.usefor then
		if g_MainScene.wndHeroSelect.usefor == E_HeroSelWnd_usefor.E_SwapEquip then
			g_WsMsgHandler:WS_Hero_SwapEquip_Req(arg_8_0.heroDesc.HeroBaseInfo.TemplateId, g_MainScene.wndHeroSelect.templateid)
		elseif g_MainScene.wndHeroSelect.usefor == E_HeroSelWnd_usefor.E_Partner then
			g_WsMsgHandler:WS_Hero_PutOnPartner_Req(g_MainScene.wndHeroSelect.partnerIndex, g_MainScene.wndHeroSelect.templateid, arg_8_0.heroDesc.HeroBaseInfo.TemplateId)
		elseif g_MainScene.wndHeroSelect.usefor == E_HeroSelWnd_usefor.E_SelHero and g_MainScene.wndHeroSelect.callback then
			if arg_8_0.heroDesc.HeroBaseInfo.Level < 10 then
				g_Bubble:bubbleInfo(a2u("\xBB\xEF\xB0\xE9\xB4ﵽ10\xBC\xB6\xD2\xD4\xC9ϲſɻ\xD8¯"))

				return
			end

			g_MainScene.wndHeroSelect.callback(arg_8_0.heroDesc)
			arg_8_0.layerContent:setScale(1)
			g_MainScene.wndHeroSelect:hide()
		end
	end
end
