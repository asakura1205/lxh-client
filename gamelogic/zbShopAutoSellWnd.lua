require("gamelogic.zbBaseWnd")
require("gamelogic.zbItem")

local var_0_0 = class("zbShopAutoSellWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createShopAutoSellWnd()
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
		arg_3_0.sellItems = {}
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/shop_sell.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_3_0.layer = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		for iter_5_0 = 1, 3 do
			local var_5_3 = tolua.cast(var_5_2:getChildByTag(iter_5_0), "CCLayerColor")
			local var_5_4 = createItem()

			var_5_4:setPosition(var_5_3:getPosition())
			var_5_2:addChild(var_5_4)
			var_5_3:removeFromParentAndCleanup(true)

			arg_3_0.sellItems[iter_5_0] = var_5_4
		end

		arg_3_0.spriteMoney = tolua.cast(var_5_2:getChildByTag(4), "CCSprite")

		local var_5_5 = tolua.cast(var_5_2:getChildByTag(1005), "CCLabelTTF")

		arg_3_0.btnSell = tolua.cast(var_5_2:getChildByTag(6), "CCControlButton")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")
		arg_3_0.lbMoney = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_5, arg_3_0.lbMoney)
		arg_3_0.lbMoney:setScale(0.6)
		arg_3_0.btnSell:addHandleOfControlEvent(function()
			arg_3_0:onSell()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)

		arg_3_0.centerPositionX = arg_3_0.sellItems[2]:getPositionX()

		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_9_0, arg_9_1)
	for iter_9_0 = 1, 3 do
		arg_9_0.sellItems[iter_9_0]:setVisible(false)
	end

	arg_9_0.itemList = arg_9_1

	local var_9_0 = 0
	local var_9_1 = 1

	for iter_9_1, iter_9_2 in pairs(arg_9_1) do
		if var_9_1 <= 3 then
			local var_9_2 = zbItemTable:getRecord(iter_9_2.TemplateId)

			arg_9_0.sellItems[var_9_1]:refreshAward(ECommonAwardType.Item, iter_9_2.TemplateId, iter_9_2.Count)
			arg_9_0.sellItems[var_9_1]:setVisible(true)

			var_9_0 = var_9_0 + var_9_2.sellPrice * iter_9_2.Count
			var_9_1 = var_9_1 + 1
		end
	end

	zbUIEffect:centerStar(arg_9_0.sellItems, arg_9_0.centerPositionX)
	arg_9_0.lbMoney:setString(var_9_0)
end

function var_0_0.onSell(arg_10_0)
	if arg_10_0.itemList == nil then
		return
	end

	local var_10_0 = 1
	local var_10_1 = {}

	for iter_10_0, iter_10_1 in pairs(arg_10_0.itemList) do
		if var_10_0 <= 3 then
			var_10_1[var_10_0] = {
				iter_10_1.TemplateId,
				iter_10_1.Count
			}
			var_10_0 = var_10_0 + 1
		end
	end

	g_WsMsgHandler:WS_Bag_SaleItem_Req(itemList)
	arg_10_0:hide()
end

function var_0_0.onTouchTest(arg_11_0)
	local var_11_0 = arg_11_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_11_0.layer, var_11_0.x, var_11_0.y) == false and zbUtil:PointInCtrl(arg_11_0.btnClose, var_11_0.x, var_11_0.y) == false then
		arg_11_0:hide()
	end
end
