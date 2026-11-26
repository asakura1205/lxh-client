require("gamelogic.zbTabWnd")
require("gamelogic.zbShopList")

local var_0_0 = class("zbShopWnd", zbTabWnd)

var_0_0.__index = var_0_0

local var_0_1 = {
	"image/shop/shop_bg1.jpg",
	"image/shop/shop_bg2.jpg",
	"image/shop/shop_bg3.jpg"
}
local var_0_2 = {
	"image/shop/shop_title1.png",
	"image/shop/shop_title2.png",
	"image/shop/shop_title3.png"
}
local var_0_3 = {
	"\xC7\xC6һ\xC7ƿ\xB4һ\xBF\xB4\xC0\xB2\xA3\xA1",
	"\xD7߹\xFD·\xB9\xFD\xB2\xBB\xC8ݴ\xED\xB9\xFD\xA3\xA1",
	"\xBB\xB6ӭ\xB9\xE2\xC1٣\xAC\xB4\xF3\xC0У\xA1"
}
local var_0_4 = {
	"\xB2\xBB\xC2\xF2\xB6\xAB\xCE\xF7\xBEͱ\xF0\xC2ҵ㡣",
	"\xB6\xE0\xC2\xF2\xB5\xE3\xC4\xE3\xBE\xCD\xC4ܱ\xE4\xB5ø\xFCǿ\xA1\xA3",
	"\xD7࿭\xA3\xAC\xD5\xE2\xC0\xEFֻ\xBB\xB6ӭǿ\xD5ߣ\xA1"
}
local var_0_5 = {
	"\xBB\xB6ӭ\xCF´\xCE\xD4\xD9\xC0\xB4\xA1\xA3",
	"\xC5\xC5\xD0а\xF1\xC9\xCFһ\xB6\xA8\xBB\xE1\xD3\xD0\xC4\xE3\xB5\xC4һϯ֮\xB5ء\xA3",
	"\xCE\xD2\xC4ܸо\xF5\xC4\xE3\xD3ֱ\xE4ǿ\xC1ˡ\xA3"
}

function createShopWnd()
	local var_1_0 = var_0_0.extend(zbTabWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create()))))

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
		arg_3_0.actionEnd = false
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/shop.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")

		arg_3_0.node = var_5_1

		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")
		local var_5_3 = tolua.cast(var_5_1:getChildByTag(2), "CCNode")
		local var_5_4 = tolua.cast(var_5_2:getChildByTag(10), "CCNode")
		local var_5_5 = tolua.cast(var_5_2:getChildByTag(20), "CCNode")
		local var_5_6 = tolua.cast(var_5_2:getChildByTag(30), "CCNode")
		local var_5_7 = tolua.cast(var_5_1:getChildByTag(102), "CCSprite")

		arg_3_0.spriteTitle = tolua.cast(var_5_7:getChildByTag(2), "CCSprite")
		arg_3_0.spriteNpc = tolua.cast(var_5_4:getChildByTag(1), "CCSprite")
		arg_3_0.spriteTalk = tolua.cast(var_5_4:getChildByTag(2), "CCSprite")
		arg_3_0.lbTalk = tolua.cast(arg_3_0.spriteTalk:getChildByTag(1001), "CCLabelTTF")
		arg_3_0.btnAvatar = tolua.cast(var_5_4:getChildByTag(3), "CCControlButton")

		arg_3_0.btnAvatar:addHandleOfControlEvent(function()
			arg_3_0:onAvatar()
		end, CCControlEventTouchUpInside)

		arg_3_0.lbRefreshCount = tolua.cast(var_5_6:getChildByTag(1), "CCLabelTTF")
		arg_3_0.btnRefreshShopList = tolua.cast(var_5_6:getChildByTag(2), "CCControlButton")
		arg_3_0.lbRefreshTimeDummy = tolua.cast(var_5_6:getChildByTag(3), "CCLabelTTF")
		arg_3_0.lbRefreshTime = zbTimeLabel:create(arg_3_0.lbRefreshTimeDummy, "", "")

		arg_3_0.lbRefreshTime:setCustomCallback(function()
			arg_3_0:refresh()
		end)
		arg_3_0.btnRefreshShopList:addHandleOfControlEvent(function()
			arg_3_0:onRefreshShopListReq()
		end, CCControlEventTouchUpInside)
		arg_3_0.spriteTalk:setVisible(false)

		local var_5_8 = {
			[EShopTab.Normal] = tolua.cast(var_5_3:getChildByTag(1), "CCControlButton"),
			[EShopTab.Mystery] = tolua.cast(var_5_3:getChildByTag(2), "CCControlButton"),
			[EShopTab.Arena] = tolua.cast(var_5_3:getChildByTag(3), "CCControlButton")
		}
		local var_5_9 = {
			[EShopTab.Normal] = tolua.cast(var_5_5:getChildByTag(11), "CCLayer"),
			[EShopTab.Mystery] = tolua.cast(var_5_5:getChildByTag(12), "CCLayer"),
			[EShopTab.Arena] = tolua.cast(var_5_5:getChildByTag(13), "CCLayer")
		}
		local var_5_10 = {
			[EShopTab.Normal] = "image/tab/tab_shop_normal.png",
			[EShopTab.Mystery] = "image/tab/tab_shop_mystery.png",
			[EShopTab.Arena] = "image/tab/tab_shop_arena.png"
		}

		arg_3_0.module = {}
		arg_3_0.module[EShopTab.Normal] = createShopList(var_5_9[EShopTab.Normal], EShopType.Normal, var_5_8[EShopTab.Normal])
		arg_3_0.module[EShopTab.Mystery] = createShopList(var_5_9[EShopTab.Mystery], EShopType.Mystery, var_5_8[EShopTab.Mystery])
		arg_3_0.module[EShopTab.Arena] = createShopList(var_5_9[EShopTab.Arena], EShopType.Honor, var_5_8[EShopTab.Arena])

		arg_3_0:initTab(var_5_8, var_5_9, var_5_10)
		arg_3_0:addChild(var_5_1)
		arg_3_0:createMoneyPanel(var_5_1, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold
		}, function()
			arg_3_0:hide()
		end)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onDataUpdateAck()
	end, zbGameEvent.Event_Update_Shop)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onShopBuyAck()
	end, zbGameEvent.Event_ShopItemBuySuccess)
end

function var_0_0.onFrameUpdate(arg_12_0, arg_12_1)
	if arg_12_0.lbRefreshTime then
		arg_12_0.lbRefreshTime:update()
	end
end

function var_0_0.refresh(arg_13_0, arg_13_1)
	if arg_13_1 then
		arg_13_0:selectTab(arg_13_1)
	end

	local var_13_0 = 0

	if arg_13_0.currTab == EShopTab.Normal then
		var_13_0 = EShopType.Normal
	elseif arg_13_0.currTab == EShopTab.Mystery then
		var_13_0 = EShopType.Mystery
	elseif arg_13_0.currTab == EShopTab.Arena then
		var_13_0 = EShopType.Honor
	end

	local var_13_1 = g_Self.kShopHandler:needRefreshShop(var_13_0)
	local var_13_2 = g_Self.kShopHandler.AllShopList

	if table.getn(var_13_2) == 0 or var_13_1 == true then
		g_WsMsgHandler:WS_Shop_GetShopItems_Req()
	end
end

function var_0_0.doSelectTab(arg_14_0)
	arg_14_0.module[arg_14_0.currTab]:refresh()
	arg_14_0:refreshCountAndTime()
	arg_14_0.spriteTitle:setTexture(CCTextureCache:sharedTextureCache():addImage(var_0_2[arg_14_0.currTab]))
	arg_14_0.spriteNpc:setTexture(CCTextureCache:sharedTextureCache():addImage(var_0_1[arg_14_0.currTab]))
	arg_14_0:setShopTabMoney(arg_14_0.currTab)
	arg_14_0:performAnimationSay(var_0_3[arg_14_0.currTab])
end

function var_0_0.onDataUpdateAck(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0.module) do
		iter_15_1:refreshDirtyFlag()
	end

	arg_15_0.module[arg_15_0.currTab]:refresh()
	arg_15_0:refreshCountAndTime()
end

function var_0_0.refreshCountAndTime(arg_16_0)
	local var_16_0 = 0

	if arg_16_0.currTab == EShopTab.Normal then
		var_16_0 = EShopType.Normal
	elseif arg_16_0.currTab == EShopTab.Mystery then
		var_16_0 = EShopType.Mystery
	elseif arg_16_0.currTab == EShopTab.Arena then
		var_16_0 = EShopType.Honor
	end

	local var_16_1 = g_Self.kShopHandler:getShopData(var_16_0)

	if var_16_1 ~= nil and type(var_16_1.MaxFlushCount) ~= "userdata" then
		arg_16_0.lbRefreshCount:setString(var_16_1.MaxFlushCount - var_16_1.FlushCount .. "/" .. var_16_1.MaxFlushCount)
	end

	local var_16_2 = g_Self.kShopHandler:getNextRefreshTime(var_16_0)

	arg_16_0.lbRefreshTime:clear()
	arg_16_0.lbRefreshTime:start(var_16_2)
end

function var_0_0.onRefreshShopListReq(arg_17_0)
	local var_17_0 = 100
	local var_17_1 = 0
	local var_17_2 = 0

	if arg_17_0.currTab == EShopTab.Normal then
		var_17_2 = EShopType.Normal
	elseif arg_17_0.currTab == EShopTab.Mystery then
		var_17_2 = EShopType.Mystery
	elseif arg_17_0.currTab == EShopTab.Arena then
		var_17_2 = EShopType.Honor
	end

	local var_17_3 = g_DataConfig.m_kCommonCfg.shops[var_17_2]
	local var_17_4 = g_Self.kShopHandler:getShopData(var_17_2)

	if var_17_4 ~= nil and var_17_3 ~= nil then
		local var_17_5 = var_17_4.FlushCount

		if var_17_5 >= var_17_3.refreshMaxCount then
			g_Bubble:bubbleInfo(a2u("\xBD\xF1\xC8\xD5ˢ\xD0´\xCE\xCA\xFD\xD2\xD1\xD3\xC3\xCD\xEA"))

			return
		end

		local var_17_6 = table.getn(var_17_3.refreshMoney)

		if var_17_5 < var_17_6 then
			var_17_0 = var_17_3.refreshMoney[var_17_5 + 1]
		else
			var_17_0 = var_17_3.refreshMoney[var_17_6]
		end

		local function var_17_7()
			if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Diamond, var_17_0) == false then
				g_Bubble:bubbleInfo(a2u("\xD7\xEAʯ\xB2\xBB\xD7\xE3"))

				return
			end

			g_WsMsgHandler:WS_Shop_Refresh_Req(var_17_2)
		end

		local var_17_8 = a2u("\xBD\xF1\xC8\xD5\xD2\xD1ˢ\xD0\xC2" .. var_17_5 .. "\xB4\xCE,\xB1\xBE\xB4\xCEˢ\xD0\xC2\xD0\xE8Ҫ" .. var_17_0 .. "\xD7\xEAʯ")

		g_MessageBox:showYesNo(var_17_8, var_17_7)
	end
end

function var_0_0.getAutoSaleItemList(arg_19_0)
	local var_19_0 = g_Self.kBagItemHandler:getItemListBySubType(EItemType.Material, EMaterialType.OnlySale)

	if var_19_0 ~= nil and table.getn(var_19_0) > 0 then
		g_MainScene:showShopAutoSell(var_19_0)
	end
end

function var_0_0.onFrameUpdate(arg_20_0)
	arg_20_0:updateBackEffect()
end

function var_0_0.setShopTabMoney(arg_21_0, arg_21_1)
	local var_21_0 = {}

	if arg_21_1 == EShopTab.Normal then
		table.insert(var_21_0, EMoneyPanelResType.Diamond)
		table.insert(var_21_0, EMoneyPanelResType.Gold)
	elseif arg_21_1 == EShopTab.Mystery then
		table.insert(var_21_0, EMoneyPanelResType.Soul)
		table.insert(var_21_0, EMoneyPanelResType.EquipSoul)
	elseif arg_21_1 == EShopTab.Arena then
		table.insert(var_21_0, EMoneyPanelResType.Arena)
		table.insert(var_21_0, EMoneyPanelResType.Legion)
	end

	if arg_21_0.moneyPanel ~= nil then
		arg_21_0.moneyPanel:setMoneyTypeList(var_21_0)
	end

	arg_21_0.spriteTalk:setVisible(false)
end

function var_0_0.onAvatar(arg_22_0)
	arg_22_0:performAnimationSay(var_0_4[arg_22_0.currTab])
end

function var_0_0.performAnimationSay(arg_23_0, arg_23_1)
	local var_23_0 = CCArray:create()

	var_23_0:addObject(CCCallFuncN:create(function()
		arg_23_0.spriteTalk:setVisible(true)
		arg_23_0.lbTalk:setString(a2u(arg_23_1))
		arg_23_0.btnAvatar:setEnabled(false)
	end))
	var_23_0:addObject(CCDelayTime:create(2))
	var_23_0:addObject(CCCallFuncN:create(function()
		arg_23_0.spriteTalk:setVisible(false)
		arg_23_0.btnAvatar:setEnabled(true)
	end))

	local var_23_1 = CCSequence:create(var_23_0)

	arg_23_0.btnAvatar:stopAllActions()
	arg_23_0.btnAvatar:runAction(var_23_1)
end

function var_0_0.onShopBuyAck(arg_26_0)
	arg_26_0:performAnimationSay(var_0_5[arg_26_0.currTab])
end
