function zbWsMsgHandler.WS_Bar_Draw_Req(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = {
		DrawType = arg_1_1
	}

	g_Self.kPubHandler.callBack = arg_1_2

	g_WsMsgHandler:wsPackMsg(var_1_0, MSG_ID.WS_Bar_Draw_Req)
end

function zbWsMsgHandler.WS_Bar_Draw_Ack(arg_2_0, arg_2_1)
	echoInfo("WS_Bar_Draw_Ack")

	local var_2_0 = arg_2_1.RetData.AwardList

	if zbUtil:isValidTable(var_2_0) then
		for iter_2_0, iter_2_1 in pairs(var_2_0) do
			if iter_2_1.Type == ECommonAwardType.Hero then
				iter_2_1.bHave = g_Self.kHeroHandler:hasHeroByTemplateId(iter_2_1.Id)
			end
		end
	end

	g_Self.kDataChange:update(arg_2_1)
	g_Self.kPubHandler:updateBarInfoAwardList(arg_2_1.RetData.BarInfo, var_2_0)
end
