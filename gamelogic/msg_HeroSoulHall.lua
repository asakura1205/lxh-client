function zbWsMsgHandler.WS_HeroSoul_Buy_Req(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = WS_HeroSoul_BuyReq

	var_1_0.HallId = arg_1_1
	var_1_0.Position = arg_1_2
	var_1_0.HeroSoulId = arg_1_3

	g_WsMsgHandler:wsPackMsg(var_1_0, MSG_ID.WS_HeroSoul_Buy_Req)
end

function zbWsMsgHandler.WS_HeroSoul_Buy_Ack(arg_2_0, arg_2_1)
	echoInfo("WS_HeroSoul_Buy_Ack")
	g_Self.kDataChange:update(arg_2_1)

	g_GameData.HeroSoulHallInfo = arg_2_1.RetData.HeroSoulHallInfo

	g_MainScene:showEffectUIPlayWnd(UI_EFFECT_JIHUO_SUC)
	g_GameEventMgr:sendEvent(zbGameEvent.Event_HeroSoulHall_Ack)
end

function zbWsMsgHandler.WS_HeroSoul_Exchange_Req(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = WS_HeroSoul_ExchangeReq

	var_3_0.HallId = arg_3_1
	var_3_0.Position = arg_3_2
	var_3_0.ResHeroSoulId = arg_3_3
	var_3_0.DesHeroSoulId = arg_3_4

	g_WsMsgHandler:wsPackMsg(var_3_0, MSG_ID.WS_HeroSoul_Exchange_Req)
end

function zbWsMsgHandler.WS_HeroSoul_Exchange_Ack(arg_4_0, arg_4_1)
	echoInfo("WS_HeroSoul_Exchange_Ack")
	g_Self.kDataChange:update(arg_4_1)

	g_GameData.HeroSoulHallInfo = arg_4_1.RetData.HeroSoulHallInfo

	g_GameEventMgr:sendEvent(zbGameEvent.Event_HeroSoulHall_Ack)
end
