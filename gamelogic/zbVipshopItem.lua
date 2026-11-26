local var_0_0 = class("zbVipshopItem")

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

function createVipShopItem(arg_2_0)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.data = data
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		arg_3_0.layerContent = var_5_0
		arg_3_0.btnTouch = tolua.cast(var_5_0:getChildByTag(100), "CCControlButton")

		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnTouch:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnTouch:setSwallowsTouches(false)

		arg_3_0.bg = tolua.cast(var_5_0:getChildByTag(1), "CCSprite")
		arg_3_0.sp_tuijian = tolua.cast(var_5_0:getChildByTag(2), "CCSprite")
		arg_3_0.sp_first = tolua.cast(var_5_0:getChildByTag(3), "CCSprite")
		arg_3_0.lblprice = tolua.cast(var_5_0:getChildByTag(5), "CCLabelTTF")
		arg_3_0.nodedesc = tolua.cast(var_5_0:getChildByTag(6), "CCNode")
		arg_3_0.lbldesc = tolua.cast(arg_3_0.nodedesc:getChildByTag(1), "CCLabelTTF")
		arg_3_0.nodeGetItems = tolua.cast(var_5_0:getChildByTag(8), "CCNode")
		arg_3_0.getItems = {}

		for iter_5_0 = 1, 2 do
			local var_5_1 = tolua.cast(arg_3_0.nodeGetItems:getChildByTag(iter_5_0), "CCLayerColor")
			local var_5_2 = createItem()
			local var_5_3 = ccp(var_5_1:getPosition())

			var_5_2:setPosition(var_5_3.x, var_5_3.y)
			var_5_2:setScale(0.5)
			arg_3_0.nodeGetItems:addChild(var_5_2)

			arg_3_0.getItems[iter_5_0] = var_5_2

			var_5_1:removeFromParentAndCleanup(true)
		end

		arg_3_0.nodeGetDiamonds = tolua.cast(var_5_0:getChildByTag(7), "CCNode")

		local var_5_4 = tolua.cast(arg_3_0.nodeGetDiamonds:getChildByTag(1007), "CCLabelTTF")

		arg_3_0.lbldiamondsRep = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_4, arg_3_0.lbldiamondsRep)
		arg_3_0.lbldiamondsRep:setScale(0.65)
		arg_3_0:setContentSize(var_5_0:getContentSize())
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_7_0, arg_7_1)
	arg_7_0.layerContent:setVisible(zbUtil:isValidTable(arg_7_1))

	arg_7_0.data = arg_7_1

	if arg_7_1 then
		arg_7_0.sp_first:setVisible(arg_7_1.BuyState == 0 and arg_7_1.GoodsType == EVipGoodsType.Common)

		if arg_7_1.GoodsType == EVipGoodsType.Common then
			arg_7_0.sp_tuijian:setVisible(arg_7_0.sp_first:isVisible() == false and arg_7_1.IsHot == 1)
		else
			arg_7_0.sp_tuijian:setVisible(true)
		end

		arg_7_0.lblprice:setString(arg_7_1.Price)
		arg_7_0.lbldiamondsRep:setString(arg_7_1.Diamond)

		arg_7_0.spriteframeCache = CCSpriteFrameCache:sharedSpriteFrameCache()

		arg_7_0.spriteframeCache:addSpriteFramesWithFile("ui/image/plist/vip.plist")

		local var_7_0 = arg_7_0.spriteframeCache:spriteFrameByName(arg_7_1.Icon)

		if var_7_0 then
			arg_7_0.bg:initWithSpriteFrame(var_7_0)
		end

		arg_7_0.nodeGetDiamonds:setVisible(arg_7_1.GoodsType == EVipGoodsType.Common)

		local var_7_1 = ""
		local var_7_2 = 0

		arg_7_0.nodedesc:setVisible(arg_7_1.GoodsType == EVipGoodsType.Common)
		arg_7_0.nodeGetItems:setVisible(arg_7_1.GoodsType ~= EVipGoodsType.Common)

		if arg_7_1.GoodsType == EVipGoodsType.Common then
			if arg_7_1.BuyState == 0 then
				var_7_2 = arg_7_1.FirstDiamond
			else
				var_7_2 = arg_7_1.FollowDiamond
			end

			local var_7_3 = a2u("\xB6\xEE\xCD\xE2\xD4\xF9\xCB\xCD") .. var_7_2 .. a2u("\xD7\xEA")

			arg_7_0.lbldesc:setString(var_7_3)
		else
			for iter_7_0, iter_7_1 in pairs(arg_7_0.getItems) do
				iter_7_1:setVisible(false)
			end

			if arg_7_1.DailyAwardList then
				local var_7_4 = 1

				for iter_7_2, iter_7_3 in pairs(arg_7_1.DailyAwardList) do
					if arg_7_0.getItems[var_7_4] then
						arg_7_0.getItems[var_7_4]:setVisible(true)
						arg_7_0.getItems[var_7_4]:refreshAward(iter_7_3.Type, iter_7_3.Id, iter_7_3.Count, false)
					end

					var_7_4 = var_7_4 + 1
				end
			end
		end
	end
end

function var_0_0.onTouch(arg_8_0)
	if arg_8_0.data then
		if zbGlobalUtil:getTargetPlatform() == "ios" then
			zbChannelUtil_Pay:onIOSPayOrderReq(arg_8_0.data.GoodsId)
			zbGlobalUtil:setPayOrderState(100)
			g_MainScene:showWaitMomentWnd()
		else
			if g_Login.channel == EChannelType.qq then
				local var_8_0 = {
					Price = arg_8_0.data.Price,
					GoodsId = arg_8_0.data.GoodsId
				}

				zbChannelUtil_Pay:onPayOrderInfoReqByChanelType(var_8_0)

				return
			end

			g_WsMsgHandler:WS_Vip_CreateOrder_Req(arg_8_0.data.GoodsId, "")
		end
	end
end
