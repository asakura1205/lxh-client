require("gamelogic.zbBaseWnd")
require("gamelogic.zbVipbuyPanel")
require("gamelogic.zbVipTequanPanel")

local var_0_0 = class("zbVipWnd", zbBaseWnd)

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

function createVipWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.curPage = 1
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/vip.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(102), "CCNode")

		arg_3_0.title1 = tolua.cast(var_5_2:getChildByTag(2), "CCSprite")
		arg_3_0.title2 = tolua.cast(var_5_2:getChildByTag(1), "CCSprite")

		local var_5_3 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")
		local var_5_4 = tolua.cast(var_5_3:getChildByTag(1), "CCNode")
		local var_5_5 = tolua.cast(var_5_4:getChildByTag(1001), "CCLabelTTF")

		arg_3_0.curViplvRep = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_5, arg_3_0.curViplvRep)
		arg_3_0.curViplvRep:setScale(0.7)

		arg_3_0.nodeNextVipInfo = tolua.cast(var_5_4:getChildByTag(2), "CCNode")

		local var_5_6 = tolua.cast(arg_3_0.nodeNextVipInfo:getChildByTag(1003), "CCLabelTTF")

		arg_3_0.nextViplvRep = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_6, arg_3_0.nextViplvRep)
		arg_3_0.nextViplvRep:setScale(0.65)

		local var_5_7 = tolua.cast(arg_3_0.nodeNextVipInfo:getChildByTag(1002), "CCLabelTTF")

		arg_3_0.needBuyRep = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_7, arg_3_0.needBuyRep)
		arg_3_0.needBuyRep:setScale(0.65)

		arg_3_0.spriteBarBg = tolua.cast(var_5_4:getChildByTag(4), "CCSprite")

		local function var_5_8(arg_6_0, arg_6_1)
			local var_6_0 = CCSprite:create(arg_6_1)

			var_6_0:setAnchorPoint(ccp(0, 0))

			local var_6_1 = CCProgressTimer:create(var_6_0)

			var_6_1:setAnchorPoint(ccp(0, 0))
			var_6_1:setPercentage(0)
			var_6_1:setMidpoint(ccp(0, 1))
			var_6_1:setBarChangeRate(ccp(1, 0))
			var_6_1:setType(kCCProgressTimerTypeBar)
			var_6_1:retain()
			arg_6_0:addChild(var_6_1)

			return var_6_1
		end

		arg_3_0.spriteBar = var_5_8(arg_3_0.spriteBarBg, "image/vip/vip_progress2.png")
		arg_3_0.vipDots = tolua.cast(var_5_4:getChildByTag(6), "CCLabelTTF")
		arg_3_0.btnBuy = tolua.cast(var_5_4:getChildByTag(5), "CCControlButton")

		arg_3_0.btnBuy:addHandleOfControlEvent(function()
			arg_3_0:onBuy()
		end, CCControlEventTouchUpInside)

		local var_5_9 = tolua.cast(var_5_3:getChildByTag(2), "CCNode")
		local var_5_10 = tolua.cast(var_5_3:getChildByTag(3), "CCNode")

		arg_3_0.buyPnl = createVipBuyPanel(var_5_9)
		arg_3_0.tequanPnl = createVipTequanPanel(var_5_10)

		arg_3_0:createMoneyPanel(var_5_1, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold
		}, function()
			arg_3_0:hide()
		end)
		arg_3_0:addChild(var_5_1)
	end

	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refresh()
	end, zbGameEvent.Event_Update_Diamond)
	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(function()
		arg_3_0:doShow()
	end)
end

function var_0_0.doShow(arg_11_0)
	zbChannelUtil_Pay:sendNextOrderReq()
end

function var_0_0.refresh(arg_12_0)
	local var_12_0 = g_GameData.BaseInfo.VipLevel

	arg_12_0.curViplvRep:setString(var_12_0)

	if var_12_0 >= MAX_VIPLEVEL then
		arg_12_0.nodeNextVipInfo:setVisible(false)
	else
		arg_12_0.nextViplvRep:setString(var_12_0 + 1)
	end

	if g_GameData.VipInfo then
		arg_12_0.needBuyRep:setString(g_GameData.VipInfo.VipBaseInfo.NextTotalExp - g_GameData.VipInfo.VipBaseInfo.Exp)

		local var_12_1 = g_GameData.VipInfo.VipBaseInfo.Exp
		local var_12_2 = 100 * var_12_1 / g_GameData.VipInfo.VipBaseInfo.NextTotalExp

		arg_12_0.vipDots:setString(var_12_1 .. "/" .. g_GameData.VipInfo.VipBaseInfo.NextTotalExp)

		if var_12_0 >= MAX_VIPLEVEL then
			arg_12_0.vipDots:setString(a2u("\xD2Ѵ\xEF\xD7\xEE\xB4\xF3\xB5ȼ\xB6"))
		end

		arg_12_0.spriteBar:runAction(CCProgressTo:create(0.1, var_12_2))
	end

	arg_12_0.tequanPnl:refresh()
end

function var_0_0.setCommonInfo(arg_13_0)
	if arg_13_0.curPage == 1 then
		zbUtil:setButtonTitle(arg_13_0.btnBuy, a2u("\xB2鿴\xCC\xD8Ȩ"))
	else
		zbUtil:setButtonTitle(arg_13_0.btnBuy, a2u("ȥ\xB3\xE4ֵ"))
	end

	arg_13_0.buyPnl:setVisible(arg_13_0.curPage == 1)
	arg_13_0.tequanPnl:setVisible(arg_13_0.curPage == 2)
	arg_13_0.title1:setVisible(arg_13_0.curPage == 1)
	arg_13_0.title2:setVisible(arg_13_0.curPage == 2)
end

function var_0_0.showVipBuy(arg_14_0)
	arg_14_0.curPage = 1

	arg_14_0:setCommonInfo()
	arg_14_0.buyPnl:refresh()
end

function var_0_0.showVipTequan(arg_15_0)
	arg_15_0.curPage = 2

	arg_15_0:setCommonInfo()
	arg_15_0.tequanPnl:refresh()
end

function var_0_0.onBuy(arg_16_0)
	if arg_16_0.curPage == 1 then
		arg_16_0:showVipTequan()
	else
		arg_16_0:showVipBuy()
	end
end

function var_0_0.onFrameUpdate(arg_17_0)
	arg_17_0:updateBackEffect()
end
