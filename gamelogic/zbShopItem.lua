require("gamelogic.zbItem")

zbShopItem = class("zbShopItem", CCNodeExtend)
zbShopItem.__index = zbShopItem

function zbShopItem.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbShopItem)

	return arg_1_0
end

function zbShopItem.create(arg_2_0)
	local var_2_0 = zbShopItem.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init()

	return var_2_0
end

function zbShopItem.init(arg_3_0)
	local function var_3_0()
		arg_3_0.shopItemDummy = nil
		arg_3_0.shopItemDetail = nil
		arg_3_0.shopType = 0
		arg_3_0.scrollEffect = nil
	end

	local function var_3_1()
		CCLabelTTF:beginDelayCreateTexture()

		local var_5_0 = zbUtil:loadCCBNode("ccbi/tb_shopitem.ccbi")
		local var_5_1 = tolua.cast(var_5_0:getChildByTag(1), "CCNode")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCSprite")

		arg_3_0.layerContent = var_5_2

		local var_5_3 = tolua.cast(arg_3_0.layerContent:getChildByTag(1), "CCLayerColor")
		local var_5_4 = createItem()

		var_5_4:setPosition(var_5_3:getPosition())
		var_5_4:setSwallowsTouches(false)
		var_5_4:setNeedTip(false)

		arg_3_0.shopItemDummy = var_5_4

		arg_3_0.layerContent:addChild(arg_3_0.shopItemDummy)
		var_5_3:removeFromParentAndCleanup(true)

		arg_3_0.spritePayType = tolua.cast(var_5_2:getChildByTag(2), "CCSprite")
		arg_3_0.lbPriceDummy = tolua.cast(var_5_2:getChildByTag(1003), "CCLabelTTF")
		arg_3_0.bmSalePrice = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbPriceDummy, arg_3_0.bmSalePrice)
		arg_3_0.bmSalePrice:setScale(0.5)

		arg_3_0.spriteSaleOut = tolua.cast(var_5_1:getChildByTag(5), "CCSprite")
		arg_3_0.spriteDiscount = tolua.cast(var_5_1:getChildByTag(6), "CCSprite")
		arg_3_0.btnTouch = tolua.cast(var_5_2:getChildByTag(4), "CCControlButton")

		arg_3_0.btnTouch:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnTouch:setSwallowsTouches(false)
		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnTouch:setZoomChildNode(var_5_1)
		arg_3_0.btnTouch:setZoomScaleInner(true)
		arg_3_0.btnTouch:setZoomOnTouchDown(true)
		arg_3_0:addChild(var_5_0)
		CCLabelTTF:endDelayCreateTexture(var_5_0)
	end

	var_3_0()
	var_3_1()
end

function zbShopItem.refresh(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.shopItemDetail = arg_7_1
	arg_7_0.shopType = arg_7_2

	if arg_7_0.shopItemDetail == nil then
		return
	end

	if arg_7_1.SaleState ~= EShopItemState.Saleout then
		if (arg_7_1.ItemType == ECommonAwardType.HeroFrag or arg_7_1.ItemType == ECommonAwardType.Hero or arg_7_1.ItemType == ECommonAwardType.Diamond or arg_7_1.ItemType == ECommonAwardType.BarMoney or arg_7_1.ItemType == ECommonAwardType.EquipFrag and zbItemTable:getItemQuality(arg_7_1.TemplateId) > EItemQuality.Golden or arg_7_1.ItemType == ECommonAwardType.Item and zbItemTable:getItemType(arg_7_1.TemplateId) == EItemType.Equip and zbItemTable:getItemQuality(arg_7_1.TemplateId) > EItemQuality.Purple or zbItemTable:getItemQuality(arg_7_1.TemplateId) > EItemQuality.Golden) and arg_7_0.scrollEffect == nil then
			arg_7_0.scrollEffect = g_EffectSystem:creatScrollEffect(arg_7_0.shopItemDummy, arg_7_1.ItemType)

			arg_7_0.scrollEffect:setAnimation("animation", true)
		end
	elseif arg_7_0.scrollEffect ~= nil then
		arg_7_0.scrollEffect:removeFromParentAndCleanup(true)

		arg_7_0.scrollEffect = nil
	end

	local var_7_0 = zbIconHelper:getMoneyPanelIconPath(arg_7_1.MoneyType)

	arg_7_0.spritePayType:setTexture(CCTextureCache:sharedTextureCache():addImage(var_7_0))
	arg_7_0.spriteSaleOut:setVisible(arg_7_1.SaleState == EShopItemState.Saleout)
	arg_7_0.spriteDiscount:setVisible(arg_7_1.Price ~= arg_7_1.DiscountPrice)
	arg_7_0.shopItemDummy:refreshAward(arg_7_1.ItemType, arg_7_1.TemplateId, arg_7_1.Count)
	arg_7_0.layerContent:setGray(arg_7_1.SaleState == EShopItemState.Saleout)
	arg_7_0.spriteDiscount:setGray(arg_7_1.SaleState == EShopItemState.Saleout)
	arg_7_0.bmSalePrice:setString(arg_7_1.DiscountPrice)

	local var_7_1 = 1

	if arg_7_1.ItemType == ECommonAwardType.Hero or arg_7_1.ItemType == ECommonAwardType.HeroFrag then
		local var_7_2 = zbHeroTable:getRecord(arg_7_1.TemplateId)

		if var_7_2 ~= nil and var_7_2.quality ~= nil then
			var_7_1, exchAdd = zbHeroQualityTable:exchangeHeroQuality(var_7_2.quality)
		end
	elseif arg_7_1.ItemType == ECommonAwardType.Item or arg_7_1.ItemType == ECommonAwardType.EquipFrag then
		local var_7_3 = zbItemTable:getRecord(arg_7_1.TemplateId)

		if var_7_3 ~= nil and var_7_3.quality ~= nil then
			var_7_1 = var_7_3.quality
		end
	end

	local var_7_4 = zbColor:getShopItemFrameTex(var_7_1)

	arg_7_0.layerContent:setTexture(CCTextureCache:sharedTextureCache():addImage(var_7_4))
end

function zbShopItem.onTouch(arg_8_0)
	if g_Self.kShopHandler:needRefreshShop(arg_8_0.shopType) == true then
		g_WsMsgHandler:WS_Shop_GetShopItems_Req(arg_8_0.shopType)

		return
	end

	if arg_8_0.shopItemDetail.SaleState ~= EShopItemState.Saleout then
		g_MainScene:showShopBuyConfirm(arg_8_0.shopItemDetail, arg_8_0.shopType)
	else
		g_Bubble:bubbleInfo(a2u("\xB8\xC3\xC9\xCCƷ\xD2\xD1\xCA\xDB\xF3\xC0"))
	end
end
