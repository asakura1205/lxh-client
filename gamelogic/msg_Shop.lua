function zbWsMsgHandler.WS_Shop_GetShopItems_Req(arg_1_0)
	local var_1_0 = {}

	g_WsMsgHandler:wsPackMsg(var_1_0, MSG_ID.WS_Shop_GetShopItems_Req)
end

function zbWsMsgHandler.WS_Shop_GetShopItems_Ack(arg_2_0, arg_2_1)
	echoInfo("WS_Shop_GetShopItems_Ack")
	g_Self.kShopHandler:updateShopList(arg_2_1.RetData.AllShopInfo)
end

function zbWsMsgHandler.WS_Shop_Refresh_Req(arg_3_0, arg_3_1)
	local var_3_0 = {
		ShopType = arg_3_1
	}

	g_WsMsgHandler:wsPackMsg(var_3_0, MSG_ID.WS_Shop_Refresh_Req)
end

function zbWsMsgHandler.WS_Shop_Refresh_Ack(arg_4_0, arg_4_1)
	echoInfo("WS_Shop_Refresh_Ack")
	g_Self.kShopHandler:updateShopDetail(arg_4_1.RetData.ShopInfo)
	g_Self.kDataChange:update(arg_4_1)
end

function zbWsMsgHandler.WS_Shop_Buy_Req(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = {
		ShopType = arg_5_1,
		ShopItemIndex = arg_5_2
	}

	g_WsMsgHandler:wsPackMsg(var_5_0, MSG_ID.WS_Shop_Buy_Req)
end

function zbWsMsgHandler.WS_Shop_Buy_Ack(arg_6_0, arg_6_1)
	echoInfo("WS_Shop_Buy_Ack")

	if g_MainScene.wndShopBuyConfirm ~= nil then
		g_MainScene.wndShopBuyConfirm:hide()
	end

	g_Self.kShopHandler:updateShopDetail(arg_6_1.RetData.ShopInfo)
	g_Self.kDataChange:update(arg_6_1)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_ShopItemBuySuccess)
end
