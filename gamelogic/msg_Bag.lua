function zbWsMsgHandler.WS_Bag_SaleItem_Req(arg_1_0, arg_1_1)
	local var_1_0 = {
		ItemList = arg_1_1
	}

	g_WsMsgHandler:wsPackMsg(var_1_0, MSG_ID.WS_Bag_SaleItem_Req)
end

function zbWsMsgHandler.WS_Bag_SaleItem_Ack(arg_2_0, arg_2_1)
	echoInfo("WS_Bag_SaleItem_Ack")
	g_Self.kDataChange:update(arg_2_1)
end

function zbWsMsgHandler.WS_Bag_OpenBox_Req(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = {
		TemplateId = arg_3_1,
		Count = arg_3_2
	}

	g_WsMsgHandler:wsPackMsg(var_3_0, MSG_ID.WS_Bag_OpenBox_Req)
end

function zbWsMsgHandler.WS_Bag_OpenBox_Ack(arg_4_0, arg_4_1)
	echoInfo("WS_Bag_OpenBox_Ack")
	g_Self.kDataChange:update(arg_4_1)

	if zbUtil:isValidTable(arg_4_1.RetData.AwardList) == true then
		local var_4_0 = {}

		for iter_4_0, iter_4_1 in pairs(arg_4_1.RetData.AwardList) do
			local var_4_1 = {
				awardType = iter_4_1.Type,
				awardId = iter_4_1.Id,
				awardCount = iter_4_1.Count
			}

			table.insert(var_4_0, var_4_1)
		end

		if table.getn(var_4_0) > 0 then
			if table.getn(var_4_0) > 5 then
				g_MainScene:showAwardMuchWnd(var_4_0)
			else
				g_MainScene:showAwardWnd(var_4_0)
			end
		end
	end
end
