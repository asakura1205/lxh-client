function zbWsMsgHandler.WS_Vip_CreateOrder_Req(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = {
		GoodsId = arg_1_1,
		Extra = arg_1_2
	}
	local var_1_1 = g_GameData.BaseInfo.PlayerId .. ":" .. arg_1_1

	var_1_0.Sign = zbGlobalUtil:getMd5(var_1_1, true)

	g_WsMsgHandler:wsPackMsg(var_1_0, MSG_ID.WS_Vip_CreateOrder_Req)
end

function zbWsMsgHandler.WS_Vip_CreateOrder_Ack(arg_2_0, arg_2_1)
	echoInfo("WS_Vip_CreateOrder_Ack")

	local var_2_0 = g_GameData.BaseInfo.PlayerId
	local var_2_1 = arg_2_1.RetData.GameOrderId
	local var_2_2 = arg_2_1.RetData.GoodsId
	local var_2_3 = arg_2_1.RetData.Price
	local var_2_4 = arg_2_1.RetData.CCY
	local var_2_5 = var_2_0 .. ":" .. var_2_1 .. ":" .. var_2_2 .. ":" .. var_2_3 .. ":" .. var_2_4

	if zbGlobalUtil:getMd5(var_2_5, true) ~= arg_2_1.RetData.Sign then
		g_Bubble:bubbleInfo(a2u("ǩ\xC3\xFB\xB4\xED\xCE\xF3"))

		return
	end

	if zbGlobalUtil:getTargetPlatform() == "ios" then
		zbChannelUtil_Pay:delIOSPayOrder(arg_2_1.RetData.Extra)
		zbChannelUtil_Pay:sendNextOrderReq()

		return
	end

	zbChannelUtil_Pay:onPayOrderInfoReqByChanelType(arg_2_1.RetData)
end

function zbWsMsgHandler.WS_Vip_SuccessOrder_Req(arg_3_0)
	echoInfo("WS_Vip_SuccessOrder_Req")

	local var_3_0 = {}

	g_WsMsgHandler:wsPackMsg(var_3_0, MSG_ID.WS_Vip_SuccessOrder_Req)
end

function zbWsMsgHandler.WS_Vip_SuccessOrder_Ack(arg_4_0, arg_4_1)
	echoInfo("WS_Vip_SuccessOrder_Ack")
	g_Bubble:bubbleInfo(a2u("\xB3\xE4ֵ\xB3ɹ\xA6"))

	g_GameData.VipInfo = arg_4_1.RetData.VipInfo

	g_Self:updateBaseInfo(arg_4_1.RetData.BaseInfo)
	g_Self.kWealthHandler:updateWealth(arg_4_1.RetData.Wealth)
	g_Self.kDataChange:update(arg_4_1)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_Diamond)
end

function zbWsMsgHandler.WS_Vip_VipGiftBuy_Req(arg_5_0, arg_5_1)
	echoInfo("WS_Vip_VipGiftBuy_Req")

	local var_5_0 = {
		VipLevel = arg_5_1
	}

	g_WsMsgHandler:wsPackMsg(var_5_0, MSG_ID.WS_Vip_VipGiftBuy_Req)
end

function zbWsMsgHandler.WS_Vip_VipGiftBuy_Ack(arg_6_0, arg_6_1)
	echoInfo("WS_Vip_VipGiftBuy_Ack")

	g_GameData.VipInfo = arg_6_1.RetData.VipInfo

	g_Self.kDataChange:update(arg_6_1)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_Update_Diamond)
end
