require("gamelogic.zbItem")

local var_0_0 = class("zbGmActivityExchangeItem", CCNodeExtend)

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

function createGmActivityExchangeItem(arg_2_0)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.exchangeInfo = nil
		arg_3_0.actId = 0
		arg_3_0.templateId = 0
		arg_3_0.exItemDummy = nil
		arg_3_0.items = {}
		arg_3_0.scrollEffect = {}
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		arg_3_0.spriteBg = tolua.cast(var_5_0:getChildByTag(0), "CCSprite")
		arg_3_0.spriteLine = tolua.cast(var_5_0:getChildByTag(999), "CCLabelTTF")
		arg_3_0.spriteMoney = tolua.cast(var_5_0:getChildByTag(1000), "CCSprite")

		local var_5_1 = tolua.cast(var_5_0:getChildByTag(1001), "CCLabelTTF")

		arg_3_0.lbName = tolua.cast(var_5_0:getChildByTag(1002), "CCLabelTTF")
		arg_3_0.posY = arg_3_0.lbName:getPositionY()

		local var_5_2 = tolua.cast(var_5_0:getChildByTag(1003), "CCLabelTTF")
		local var_5_3 = tolua.cast(var_5_0:getChildByTag(1004), "CCLabelTTF")

		arg_3_0.lbMoney = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_1, arg_3_0.lbMoney)
		arg_3_0.lbMoney:setScale(0.65)

		arg_3_0.lbCount = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_2, arg_3_0.lbCount)
		arg_3_0.lbCount:setScale(0.55)

		arg_3_0.lbExchange = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_3, arg_3_0.lbExchange)
		arg_3_0.lbExchange:setScale(0.65)

		local var_5_4 = tolua.cast(var_5_0:getChildByTag(99), "CCLayerColor")
		local var_5_5 = createItem()

		var_5_5:setPosition(var_5_4:getPosition())
		var_5_5:setSwallowsTouches(false)
		var_5_5:setNeedTip(false)
		var_5_5:setScale(0.4)

		arg_3_0.exItemDummy = var_5_5

		var_5_0:addChild(arg_3_0.exItemDummy)
		var_5_4:removeFromParentAndCleanup(true)

		for iter_5_0 = 1, 3 do
			local var_5_6 = tolua.cast(var_5_0:getChildByTag(iter_5_0), "CCLayerColor")
			local var_5_7 = createItem()

			var_5_7:setPosition(var_5_6:getPosition())
			var_5_7:setSwallowsTouches(false)
			var_5_7:setSupportTouchDownTip(false)
			var_5_7:setSupportTouchTip(true)
			var_5_7:setScale(0.85)
			var_5_0:addChild(var_5_7)

			arg_3_0.items[iter_5_0] = var_5_7

			var_5_6:removeFromParentAndCleanup(true)
		end

		arg_3_0.btnBuy = tolua.cast(var_5_0:getChildByTag(4), "CCControlButton")

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

function var_0_0.refresh(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_1 == nil or arg_7_2 == nil or arg_7_3 == nil then
		return
	end

	arg_7_0.exchangeInfo = arg_7_1
	arg_7_0.actId = arg_7_2
	arg_7_0.templateId = arg_7_3

	local var_7_0, var_7_1 = zbIconHelper:getAwardIconPath(ECommonAwardType.Item, arg_7_3)

	arg_7_0.lbName:setString(var_7_1)
	arg_7_0.exItemDummy:refreshAward(ECommonAwardType.Item, arg_7_3, 0, false, false)
	arg_7_0.spriteLine:setVisible(arg_7_1.CostDiamond ~= 0)
	arg_7_0.spriteMoney:setVisible(arg_7_1.CostDiamond ~= 0)
	arg_7_0.lbMoney:setVisible(arg_7_1.CostDiamond ~= 0)

	if arg_7_1.CostDiamond ~= 0 then
		arg_7_0.lbName:setPositionY(arg_7_0.posY)
		arg_7_0.lbCount:setPositionY(arg_7_0.posY)
		arg_7_0.exItemDummy:setPositionY(arg_7_0.posY - 15)
	else
		arg_7_0.lbName:setPositionY(arg_7_0.posY + 30)
		arg_7_0.lbCount:setPositionY(arg_7_0.posY + 30)
		arg_7_0.exItemDummy:setPositionY(arg_7_0.posY + 15)
	end

	arg_7_0.lbMoney:setString(arg_7_1.CostDiamond)
	arg_7_0.lbCount:setString(arg_7_1.CostNum)
	arg_7_0.lbExchange:setVisible(arg_7_1.LimitNum ~= 0)
	arg_7_0.lbExchange:setString(arg_7_1.LimitNum - arg_7_1.ExchangeNum .. "/" .. arg_7_1.LimitNum)

	for iter_7_0 = 1, 3 do
		arg_7_0.items[iter_7_0]:setVisible(false)
	end

	local var_7_2 = 1

	for iter_7_1, iter_7_2 in pairs(arg_7_1.AwardList) do
		arg_7_0.items[var_7_2]:refreshAward(iter_7_2.Type, iter_7_2.Id, iter_7_2.Count, false)

		if (iter_7_2.Type == ECommonAwardType.HeroFrag or iter_7_2.Type == ECommonAwardType.Hero or iter_7_2.Type == ECommonAwardType.Diamond or iter_7_2.Type == ECommonAwardType.BarMoney or iter_7_2.Type == ECommonAwardType.EquipFrag and zbItemTable:getItemQuality(iter_7_2.Id) > EItemQuality.Golden or iter_7_2.Type == ECommonAwardType.Item and zbItemTable:getItemType(iter_7_2.Id) == EItemType.Equip and zbItemTable:getItemQuality(iter_7_2.Id) > EItemQuality.Purple or zbItemTable:getItemQuality(iter_7_2.Id) > EItemQuality.Golden) and arg_7_0.scrollEffect[var_7_2] == nil then
			arg_7_0.scrollEffect[var_7_2] = g_EffectSystem:creatScrollEffect(arg_7_0.items[var_7_2], iter_7_2.Type)

			arg_7_0.scrollEffect[var_7_2]:setAnimation("animation", true)
		end

		arg_7_0.items[var_7_2]:setVisible(true)

		var_7_2 = var_7_2 + 1
	end

	arg_7_0:setGray(arg_7_1.LimitNum ~= 0 and arg_7_1.LimitNum <= arg_7_1.ExchangeNum)
	arg_7_0.btnBuy:setEnabled(arg_7_1.LimitNum == 0 or arg_7_1.LimitNum > arg_7_1.ExchangeNum)
end

function var_0_0.onBuy(arg_8_0)
	if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Diamond, arg_8_0.exchangeInfo.CostDiamond) == false then
		g_Bubble:bubbleInfo(a2u("\xD7\xEAʯ\xB2\xBB\xD7\xE3"))

		return
	end

	if g_Self.kBagItemHandler:getItemCountByTemplateId(arg_8_0.templateId) < arg_8_0.exchangeInfo.CostNum then
		g_Bubble:bubbleInfo(a2u("\xB5\xC0\xBE\xDF\xCA\xFD\xC1\xBF\xB2\xBB\xD7\xE3"))

		return
	end

	g_WsMsgHandler:WS_ActivityGm_ItemExchange_Req(arg_8_0.actId, arg_8_0.exchangeInfo.Index)
end

function var_0_0.refreshScorllEffect(arg_9_0)
	for iter_9_0 = 1, 3 do
		if arg_9_0.scrollEffect[iter_9_0] then
			arg_9_0.scrollEffect[iter_9_0]:setAnimation("animation", true)
		end
	end
end
