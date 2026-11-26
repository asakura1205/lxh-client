require("gamebase.zbLoadCSV")

zbShopTable = {}
zbShopTable.record = {}

function zbShopTable.load(arg_1_0, arg_1_1)
	local var_1_0 = require(arg_1_1)

	if var_1_0 == nil then
		return
	end

	if type(var_1_0) == "table" then
		for iter_1_0, iter_1_1 in pairs(var_1_0) do
			if iter_1_0 == 1 or iter_1_0 == 2 or iter_1_1[1] == "" then
				-- block empty
			else
				local var_1_1 = {
					index = tonumber(iter_1_1[1]),
					shoptype = tonumber(iter_1_1[2]),
					awardType = tonumber(iter_1_1[3]),
					templateId = tonumber(iter_1_1[4]),
					isSale = tonumber(iter_1_1[11])
				}
				local var_1_2 = EItemGetWayType.GetWay_ShopNormal

				if var_1_1.shoptype == EShopType.Normal then
					var_1_2 = EItemGetWayType.GetWay_ShopNormal
				elseif var_1_1.shoptype == EShopType.Mystery then
					var_1_2 = EItemGetWayType.GetWay_ShopShenMi
				elseif var_1_1.shoptype == EShopType.Honor then
					var_1_2 = EItemGetWayType.GetWay_ShopHonor
				end

				if var_1_1.isSale ~= 0 then
					zbGetWayItemTable:addItemNewWaysShop(var_1_1.templateId, var_1_2, var_1_1.awardType)
				end

				table.insert(arg_1_0.record, var_1_1)
			end
		end
	end

	return arg_1_0
end
