require("gamelogic.zbItem")

local var_0_0 = class("zbGmActivityTimeShopItem", CCNodeExtend)

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

function createGmActivityTimeShopItem(arg_2_0)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.goodsInfo = nil
		arg_3_0.actId = 0
		arg_3_0.items = {}
		arg_3_0.scrollEffect = {}
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		arg_3_0.spriteBg = tolua.cast(var_5_0:getChildByTag(0), "CCSprite")
		arg_3_0.spriteLine = tolua.cast(var_5_0:getChildByTag(99), "CCSprite")

		arg_3_0.spriteLine:setZOrder(ZORDER_TOP)

		local var_5_1 = tolua.cast(var_5_0:getChildByTag(1001), "CCLabelTTF")
		local var_5_2 = tolua.cast(var_5_0:getChildByTag(1002), "CCLabelTTF")
		local var_5_3 = tolua.cast(var_5_0:getChildByTag(1004), "CCLabelTTF")

		arg_3_0.lbShowPrire = CCLabelAtlas:create("", "font/rank_num_red.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_1, arg_3_0.lbShowPrire)
		arg_3_0.lbShowPrire:setScale(0.55)

		arg_3_0.lbSalePrire = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_2, arg_3_0.lbSalePrire)
		arg_3_0.lbSalePrire:setScale(0.65)

		arg_3_0.lbBuyTime = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_3, arg_3_0.lbBuyTime)
		arg_3_0.lbBuyTime:setScale(0.65)

		for iter_5_0 = 1, 3 do
			local var_5_4 = tolua.cast(var_5_0:getChildByTag(iter_5_0), "CCLayerColor")
			local var_5_5 = createItem()

			var_5_5:setPosition(var_5_4:getPosition())
			var_5_5:setSwallowsTouches(false)
			var_5_5:setSupportTouchDownTip(false)
			var_5_5:setSupportTouchTip(true)
			var_5_5:setScale(0.85)
			var_5_0:addChild(var_5_5)

			arg_3_0.items[iter_5_0] = var_5_5

			var_5_4:removeFromParentAndCleanup(true)
		end

		arg_3_0.btnBuy = tolua.cast(var_5_0:getChildByTag(5), "CCControlButton")

		arg_3_0.btnBuy:addHandleOfControlEvent(function()
			arg_3_0:onBuy()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnBuy:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnBuy:setSwallowsTouches(false)
		arg_3_0:setContentSize(CCSizeMake(700, 135))
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == nil or arg_7_2 == nil then
		return
	end

	arg_7_0.goodsInfo = arg_7_1
	arg_7_0.actId = arg_7_2

	arg_7_0.lbShowPrire:setString(arg_7_1.ShowPrice)
	arg_7_0.lbSalePrire:setString(arg_7_1.SalePrice)
	arg_7_0.lbBuyTime:setVisible(arg_7_1.LimitNum ~= 0)
	arg_7_0.lbBuyTime:setString(arg_7_1.LimitNum - arg_7_1.ExchangeNum .. "/" .. arg_7_1.LimitNum)

	for iter_7_0 = 1, 3 do
		arg_7_0.items[iter_7_0]:setVisible(false)
	end

	local var_7_0 = 1

	for iter_7_1, iter_7_2 in pairs(arg_7_1.AwardList) do
		arg_7_0.items[var_7_0]:refreshAward(iter_7_2.Type, iter_7_2.Id, iter_7_2.Count, false)

		if (iter_7_2.Type == ECommonAwardType.HeroFrag or iter_7_2.Type == ECommonAwardType.Hero or iter_7_2.Type == ECommonAwardType.Diamond or iter_7_2.Type == ECommonAwardType.BarMoney or iter_7_2.Type == ECommonAwardType.EquipFrag and zbItemTable:getItemQuality(iter_7_2.Id) > EItemQuality.Golden or iter_7_2.Type == ECommonAwardType.Item and zbItemTable:getItemType(iter_7_2.Id) == EItemType.Equip and zbItemTable:getItemQuality(iter_7_2.Id) > EItemQuality.Purple or zbItemTable:getItemQuality(iter_7_2.Id) > EItemQuality.Golden) and arg_7_0.scrollEffect[var_7_0] == nil then
			arg_7_0.scrollEffect[var_7_0] = g_EffectSystem:creatScrollEffect(arg_7_0.items[var_7_0], iter_7_2.Type)

			arg_7_0.scrollEffect[var_7_0]:setAnimation("animation", true)
		end

		arg_7_0.items[var_7_0]:setVisible(true)

		var_7_0 = var_7_0 + 1
	end

	arg_7_0:setGray(arg_7_1.LimitNum ~= 0 and arg_7_1.LimitNum <= arg_7_1.ExchangeNum)
	arg_7_0.btnBuy:setEnabled(arg_7_1.LimitNum == 0 or arg_7_1.LimitNum > arg_7_1.ExchangeNum)
end

function var_0_0.onBuy(arg_8_0)
	if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Diamond, arg_8_0.goodsInfo.SalePrice) == false then
		g_Bubble:bubbleInfo(a2u("\xD7\xEAʯ\xB2\xBB\xD7\xE3"))

		return
	end

	g_WsMsgHandler:WS_ActivityGm_LimitTimeShop_Req(arg_8_0.actId, arg_8_0.goodsInfo.Index)
end

function var_0_0.refreshScorllEffect(arg_9_0)
	for iter_9_0 = 1, 3 do
		if arg_9_0.scrollEffect[iter_9_0] then
			arg_9_0.scrollEffect[iter_9_0]:setAnimation("animation", true)
		end
	end
end
