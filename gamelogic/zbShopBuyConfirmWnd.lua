require("gamelogic.zbBaseWnd")
require("gamelogic.zbItem")

local var_0_0 = class("zbShopBuyConfirmWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createShopBuyConfirmWnd()
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
		arg_3_0.shopItemDummy = nil
		arg_3_0.shopItemDetail = nil
		arg_3_0.shopType = 1
		arg_3_0.lastBuyType = -1
		arg_3_0.lastBuyIndex = -1
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/shopbuyconfirm.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_3_0.layerTouchTest = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCLayerColor")
		local var_5_4 = createItem()

		var_5_4:setPosition(var_5_3:getPosition())
		var_5_2:addChild(var_5_4)

		arg_3_0.shopItemDummy = var_5_4

		var_5_3:removeFromParentAndCleanup(true)

		arg_3_0.lbName = tolua.cast(var_5_2:getChildByTag(5), "CCLabelTTF")
		arg_3_0.lbOwnNum = tolua.cast(var_5_2:getChildByTag(6), "CCLabelTTF")
		arg_3_0.lbSaleNum = tolua.cast(var_5_2:getChildByTag(7), "CCLabelTTF")
		arg_3_0.lbDesc = tolua.cast(var_5_2:getChildByTag(1008), "CCLabelTTF")
		arg_3_0.spritePayType = tolua.cast(var_5_2:getChildByTag(9), "CCSprite")
		arg_3_0.lbPriceDummy = tolua.cast(var_5_2:getChildByTag(1010), "CCLabelTTF")
		arg_3_0.lbSalePrice = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbPriceDummy, arg_3_0.lbSalePrice)
		arg_3_0.lbSalePrice:setScale(0.5)

		arg_3_0.fate = tolua.cast(var_5_2:getChildByTag(11), "CCLabelTTF")
		arg_3_0.fateName = tolua.cast(var_5_2:getChildByTag(12), "CCLabelTTF")
		arg_3_0.lbAttribue1 = tolua.cast(var_5_2:getChildByTag(41), "CCLabelTTF")
		arg_3_0.lbAttribue2 = tolua.cast(var_5_2:getChildByTag(42), "CCLabelTTF")
		arg_3_0.lbNeedLable = tolua.cast(var_5_2:getChildByTag(1051), "CCLabelTTF")
		arg_3_0.lbNeedCount = tolua.cast(var_5_2:getChildByTag(52), "CCLabelTTF")
		arg_3_0.spriteRarity = tolua.cast(var_5_2:getChildByTag(13), "CCSprite")
		arg_3_0.btnBuy = tolua.cast(var_5_2:getChildByTag(21), "CCControlButton")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnBuy:addHandleOfControlEvent(function()
			arg_3_0:onBuy()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.lbAttribue1:setVisible(false)
	arg_9_0.lbAttribue2:setVisible(false)
	arg_9_0.lbNeedLable:setVisible(false)
	arg_9_0.lbNeedCount:setVisible(false)
	arg_9_0.fate:setVisible(false)
	arg_9_0.fateName:setVisible(false)

	arg_9_0.shopItemDetail = arg_9_1
	arg_9_0.shopType = arg_9_2

	if arg_9_0.shopItemDetail == nil then
		return
	end

	arg_9_0.lbSalePrice:setString(arg_9_1.DiscountPrice)
	arg_9_0.lbSaleNum:setString(arg_9_1.Count)

	local var_9_0 = ""
	local var_9_1 = ""

	if arg_9_1.ItemType == ECommonAwardType.Hero or arg_9_1.ItemType == ECommonAwardType.HeroFrag then
		local var_9_2 = zbHeroTable:getRecord(arg_9_1.TemplateId)

		if var_9_2 == nil then
			return
		end

		var_9_0 = var_9_2.name
		var_9_1 = var_9_2.description

		arg_9_0.spriteRarity:setVisible(true)
		arg_9_0.spriteRarity:setTexture(CCTextureCache:sharedTextureCache():addImage("image/herodetail/herodetail_rarity" .. var_9_2.rarity .. ".png"))
	elseif arg_9_1.ItemType == ECommonAwardType.Item or arg_9_1.ItemType == ECommonAwardType.EquipFrag then
		local var_9_3 = zbItemTable:getRecord(arg_9_1.TemplateId)

		if var_9_3 == nil then
			return
		end

		var_9_0 = var_9_3.name
		var_9_1 = var_9_3.description

		arg_9_0.spriteRarity:setVisible(false)

		if zbItemTable:isEquip(arg_9_1.TemplateId) then
			for iter_9_0, iter_9_1 in pairs(var_9_3.mainAttrList) do
				local var_9_4 = iter_9_1.AttrValue + iter_9_1.AttrValueGrow

				if iter_9_1.AttrAdditionType == EAttrAdditionType.Percent then
					var_9_4 = var_9_4 * 100 .. "%"
				end

				arg_9_0.lbAttribue1:setString(a2u(getItemPropStr(iter_9_1.AttrType) .. "+" .. var_9_4))
			end

			for iter_9_2, iter_9_3 in pairs(var_9_3.subAttrList) do
				local var_9_5 = iter_9_3.AttrValue + iter_9_3.AttrValueGrow

				if iter_9_3.AttrAdditionType == EAttrAdditionType.Percent then
					var_9_5 = var_9_5 * 100 .. "%"
				end

				arg_9_0.lbAttribue2:setString(a2u(getItemPropStr(iter_9_3.AttrType) .. "+" .. var_9_5))
			end

			arg_9_0.fate:setVisible(true)
			arg_9_0.fateName:setVisible(true)
			arg_9_0.fateName:setString(zbFateTable:getFateName(arg_9_1.TemplateId))
			arg_9_0.lbAttribue1:setVisible(true)
			arg_9_0.lbAttribue2:setVisible(true)
		end
	else
		icon, var_9_0, var_9_1 = zbIconHelper:getMoneyPanelIconPath(arg_9_1.ItemType)

		arg_9_0.spriteRarity:setVisible(false)
	end

	if arg_9_1.ItemType == ECommonAwardType.EquipFrag or arg_9_1.ItemType == ECommonAwardType.HeroFrag then
		arg_9_0.lbNeedLable:setVisible(true)
		arg_9_0.lbNeedCount:setVisible(true)

		local var_9_6 = 0

		if arg_9_1.ItemType == ECommonAwardType.EquipFrag then
			var_9_6 = g_Self.kEquipFragHandler:getEquipComposeNeeds(arg_9_1.TemplateId)
		else
			var_9_6 = g_Self.kHeroFragHandler:getHeroComposeNeeds(arg_9_1.TemplateId).needFrag
		end

		arg_9_0.lbNeedCount:setString(var_9_6)

		local var_9_7 = g_Self.kHeroHandler:getHeroByTemplateId(arg_9_1.TemplateId)

		if arg_9_1.ItemType == ECommonAwardType.HeroFrag and var_9_7 ~= nil then
			arg_9_0.lbNeedLable:setString(a2u("\xC9\xFD\xD0\xC7\xD0\xE8Ҫ:"))
		else
			arg_9_0.lbNeedLable:setString(a2u("\xBAϳ\xC9\xD0\xE8Ҫ:"))
		end
	end

	arg_9_0.lbName:setString(var_9_0)
	arg_9_0.lbDesc:setString(var_9_1)
	arg_9_0.shopItemDummy:refreshAward(arg_9_1.ItemType, arg_9_1.TemplateId, arg_9_1.Count, false)

	local var_9_8 = g_Self.kShopHandler:gethaveShopItem(arg_9_1.ItemType, arg_9_1.TemplateId)

	arg_9_0.lbOwnNum:setString(var_9_8)

	local var_9_9 = zbIconHelper:getMoneyPanelIconPath(arg_9_1.MoneyType)

	arg_9_0.spritePayType:setTexture(CCTextureCache:sharedTextureCache():addImage(var_9_9))
end

function var_0_0.onBuy(arg_10_0)
	local var_10_0 = g_Self.kWealthHandler:getWealthMoneyByType(arg_10_0.shopItemDetail.MoneyType)
	local var_10_1, var_10_2, var_10_3 = zbIconHelper:getMoneyPanelIconPath(arg_10_0.shopItemDetail.MoneyType)

	if var_10_0 < arg_10_0.shopItemDetail.DiscountPrice then
		g_Bubble:bubbleInfo(a2u(var_10_2) .. a2u("\xCA\xFD\xC1\xBF\xB2\xBB\xD7\xE3"))

		return
	end

	g_WsMsgHandler:WS_Shop_Buy_Req(arg_10_0.shopType, arg_10_0.shopItemDetail.ShopIndex)
end

function var_0_0.onTouchTest(arg_11_0)
	local var_11_0 = arg_11_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_11_0.layerTouchTest, var_11_0.x, var_11_0.y) == false and zbUtil:PointInCtrl(arg_11_0.btnClose, var_11_0.x, var_11_0.y) == false then
		arg_11_0:hide()
	end
end
