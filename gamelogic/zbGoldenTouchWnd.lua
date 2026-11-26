require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbGoldenTouchWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createGoldenTouchWnd()
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
		arg_3_0.optType = EExchangeType.Gold
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/goldentouch.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.spriteTitle = tolua.cast(var_5_2:getChildByTag(1), "CCSprite")
		arg_3_0.layerOperate = tolua.cast(var_5_2:getChildByTag(2), "CCNode")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		local var_5_3 = tolua.cast(arg_3_0.layerOperate:getChildByTag(0), "CCSprite")

		arg_3_0.lbOperateDesc = tolua.cast(arg_3_0.layerOperate:getChildByTag(1001), "CCLabelTTF")
		arg_3_0.lbUsedCount = tolua.cast(arg_3_0.layerOperate:getChildByTag(1002), "CCLabelTTF")
		arg_3_0.spriteSrcIcon = tolua.cast(arg_3_0.layerOperate:getChildByTag(3), "CCSprite")
		arg_3_0.lbSrcValue = tolua.cast(arg_3_0.layerOperate:getChildByTag(4), "CCLabelTTF")
		arg_3_0.spriteDstIcon = tolua.cast(arg_3_0.layerOperate:getChildByTag(5), "CCSprite")
		arg_3_0.lbDstValue = tolua.cast(arg_3_0.layerOperate:getChildByTag(6), "CCLabelTTF")
		arg_3_0.btnUse = tolua.cast(arg_3_0.layerOperate:getChildByTag(7), "CCControlButton")

		zbUIEffect:runFadeToAction(var_5_3)

		arg_3_0.lbRate = tolua.cast(arg_3_0.layerOperate:getChildByTag(10), "CCLabelTTF")

		arg_3_0.lbRate:setVisible(false)
		arg_3_0.btnUse:addHandleOfControlEvent(function()
			arg_3_0:onUse()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)

		arg_3_0.layerTouchTest = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_Has_MoneyPanel_HeadPanel)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:setOptType()
	end, zbGameEvent.Event_GoldTouch_Ack)
end

function var_0_0.refresh(arg_10_0, arg_10_1)
	arg_10_0.optType = arg_10_1

	arg_10_0:setOptType()
end

function var_0_0.getCountInfo(arg_11_0)
	local var_11_0 = 1
	local var_11_1 = 5
	local var_11_2 = zbVipTable:getRecord(g_GameData.BaseInfo.VipLevel)

	if arg_11_0.optType == EExchangeType.Gold then
		var_11_0 = g_GameData.ExchangeInfo.GoldCount
		var_11_1 = var_11_2.exchangeGoldNum
	elseif arg_11_0.optType == EExchangeType.Food then
		var_11_0 = g_GameData.ExchangeInfo.FoodCount
		var_11_1 = var_11_2.exchangeFoodNum
	elseif arg_11_0.optType == EExchangeType.SkillBook then
		var_11_0 = g_GameData.ExchangeInfo.SkillBookCount
		var_11_1 = var_11_2.exchangeSkillBookNum
	elseif arg_11_0.optType == EExchangeType.Tili then
		var_11_0 = g_GameData.ExchangeInfo.TiliCount
		var_11_1 = var_11_2.exchangeTiliNum
	elseif arg_11_0.optType == EExchangeType.GemOpenHole then
		var_11_0 = g_GameData.ExchangeInfo.GemOpenHoleCount
		var_11_1 = var_11_2.exchangeGemOpenHoleNum
	elseif arg_11_0.optType == EExchangeType.DollsMoney then
		var_11_0 = g_GameData.ExchangeInfo.DollsMoneyCount
		var_11_1 = var_11_2.exchangeDollsMoneyNum
	end

	return var_11_0, var_11_1
end

function var_0_0.setOptType(arg_12_0)
	local var_12_0, var_12_1 = arg_12_0:getCountInfo()

	arg_12_0.lbUsedCount:setString(a2u("(\xBD\xF1\xC8տ\xC9\xD3\xC3") .. var_12_1 - var_12_0 .. "/" .. var_12_1 .. a2u(")"))
	arg_12_0:setDetailValue()

	local var_12_2, var_12_3 = arg_12_0:getDiamondAndExchange()

	arg_12_0.lbSrcValue:setString(var_12_2)
	arg_12_0.lbDstValue:setString(var_12_3)
	arg_12_0.lbSrcValue:setColor(var_12_2 <= g_GameData.Wealth.Diamond and display.COLOR_COMMON or display.COLOR_RED)
end

function var_0_0.getDiamondAndExchange(arg_13_0)
	local var_13_0 = 0
	local var_13_1 = 0
	local var_13_2 = 1

	if arg_13_0.optType == EExchangeType.Gold then
		var_13_1 = g_DataConfig.m_kCommonCfg.diamondExchange.gold.exchange

		local var_13_3 = g_GameData.ExchangeInfo.GoldCount
		local var_13_4 = table.getn(g_DataConfig.m_kCommonCfg.diamondExchange.gold.diamond)

		if var_13_4 <= var_13_3 then
			var_13_0 = g_DataConfig.m_kCommonCfg.diamondExchange.gold.diamond[var_13_4]
		else
			var_13_0 = g_DataConfig.m_kCommonCfg.diamondExchange.gold.diamond[var_13_3 + 1]
		end
	elseif arg_13_0.optType == EExchangeType.Food then
		var_13_1 = g_DataConfig.m_kCommonCfg.diamondExchange.food.exchange

		local var_13_5 = g_GameData.ExchangeInfo.FoodCount
		local var_13_6 = table.getn(g_DataConfig.m_kCommonCfg.diamondExchange.food.diamond)

		if var_13_6 <= var_13_5 then
			var_13_0 = g_DataConfig.m_kCommonCfg.diamondExchange.food.diamond[var_13_6]
		else
			var_13_0 = g_DataConfig.m_kCommonCfg.diamondExchange.food.diamond[var_13_5 + 1]
		end
	elseif arg_13_0.optType == EExchangeType.Tili then
		var_13_1 = g_DataConfig.m_kCommonCfg.diamondExchange.tili.exchange

		local var_13_7 = g_GameData.ExchangeInfo.TiliCount
		local var_13_8 = table.getn(g_DataConfig.m_kCommonCfg.diamondExchange.tili.diamond)

		if var_13_8 <= var_13_7 then
			var_13_0 = g_DataConfig.m_kCommonCfg.diamondExchange.tili.diamond[var_13_8]
		else
			var_13_0 = g_DataConfig.m_kCommonCfg.diamondExchange.tili.diamond[var_13_7 + 1]
		end
	elseif arg_13_0.optType == EExchangeType.SkillBook then
		var_13_1 = g_DataConfig.m_kCommonCfg.diamondExchange.skillBook.exchange

		local var_13_9 = g_GameData.ExchangeInfo.SkillBookCount
		local var_13_10 = table.getn(g_DataConfig.m_kCommonCfg.diamondExchange.skillBook.diamond)

		if var_13_10 <= var_13_9 then
			var_13_0 = g_DataConfig.m_kCommonCfg.diamondExchange.skillBook.diamond[var_13_10]
		else
			var_13_0 = g_DataConfig.m_kCommonCfg.diamondExchange.skillBook.diamond[var_13_9 + 1]
		end
	elseif arg_13_0.optType == EExchangeType.GemOpenHole then
		var_13_1 = g_DataConfig.m_kCommonCfg.diamondExchange.gemOpenHole.exchange

		local var_13_11 = g_GameData.ExchangeInfo.GemOpenHoleCount
		local var_13_12 = table.getn(g_DataConfig.m_kCommonCfg.diamondExchange.gemOpenHole.diamond)

		if var_13_12 <= var_13_11 then
			var_13_0 = g_DataConfig.m_kCommonCfg.diamondExchange.gemOpenHole.diamond[var_13_12]
		else
			var_13_0 = g_DataConfig.m_kCommonCfg.diamondExchange.gemOpenHole.diamond[var_13_11 + 1]
		end
	elseif arg_13_0.optType == EExchangeType.DollsMoney then
		var_13_1 = g_DataConfig.m_kCommonCfg.diamondExchange.dollsMoney.exchange

		local var_13_13 = g_GameData.ExchangeInfo.DollsMoneyCount
		local var_13_14 = table.getn(g_DataConfig.m_kCommonCfg.diamondExchange.dollsMoney.diamond)

		if var_13_14 <= var_13_13 then
			var_13_0 = g_DataConfig.m_kCommonCfg.diamondExchange.dollsMoney.diamond[var_13_14]
		else
			var_13_0 = g_DataConfig.m_kCommonCfg.diamondExchange.dollsMoney.diamond[var_13_13 + 1]
		end
	end

	return var_13_0, var_13_1
end

function var_0_0.setDetailValue(arg_14_0)
	local var_14_0, var_14_1, var_14_2 = zbIconHelper:getExchangeValue(arg_14_0.optType)

	arg_14_0.spriteDstIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_14_0))
	arg_14_0.spriteTitle:setTexture(CCTextureCache:sharedTextureCache():addImage(var_14_1))
	arg_14_0.lbOperateDesc:setString(var_14_2)
end

function var_0_0.onUse(arg_15_0)
	local var_15_0, var_15_1 = arg_15_0:getCountInfo()

	if var_15_1 <= var_15_0 then
		g_Bubble:bubbleInfo(a2u("\xBD\xF1\xC8նһ\xBB\xB4\xCE\xCA\xFD\xD2\xD1\xD3\xC3\xCD\xEA"))

		return
	end

	local var_15_2, var_15_3 = arg_15_0:getDiamondAndExchange()

	if var_15_2 > g_GameData.Wealth.Diamond then
		g_Bubble:bubbleInfo("\xD7\xEAʯ\xB2\xBB\xD7\xE3")

		return
	end

	g_WsMsgHandler:WS_Common_DiamondExchange_Req(arg_15_0.optType)
end

function var_0_0.onTouchTest(arg_16_0)
	local var_16_0 = arg_16_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_16_0.layerTouchTest, var_16_0.x, var_16_0.y) == false and zbUtil:PointInCtrl(arg_16_0.btnClose, var_16_0.x, var_16_0.y) == false then
		arg_16_0:hide()
	end
end
