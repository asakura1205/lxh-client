require("gamebase.zbLoadCSV")

local var_0_0 = class("wzVipShopRecord")

var_0_0.__index = var_0_0

function createwzVipShopRecord()
	return (var_0_0.new())
end

zbVipShopTable = {}
zbVipShopTable.records = {}

function zbVipShopTable.load(arg_2_0, arg_2_1)
	local var_2_0 = require(arg_2_1)

	if var_2_0 == nil then
		return
	end

	if type(var_2_0) == "table" then
		for iter_2_0, iter_2_1 in pairs(var_2_0) do
			if iter_2_0 == 1 or iter_2_0 == 2 or iter_2_1[1] == "" then
				-- block empty
			else
				local var_2_1 = createwzVipShopRecord()
				local var_2_2 = 1

				var_2_1.id = tonumber(iter_2_1[var_2_2])

				local var_2_3 = var_2_2 + 1

				var_2_1.channel = tonumber(iter_2_1[var_2_3])

				local var_2_4 = var_2_3 + 1

				var_2_1.goodsName = iter_2_1[var_2_4]

				local var_2_5 = var_2_4 + 1

				var_2_1.goodsType = tonumber(iter_2_1[var_2_5])

				local var_2_6 = var_2_5 + 1

				var_2_1.ccy = tonumber(iter_2_1[var_2_6])

				local var_2_7 = var_2_6 + 1

				var_2_1.price = tonumber(iter_2_1[var_2_7])

				local var_2_8 = var_2_7 + 1

				var_2_1.exp = tonumber(iter_2_1[var_2_8])

				local var_2_9 = var_2_8 + 1

				var_2_1.diamond = tonumber(iter_2_1[var_2_9])

				local var_2_10 = var_2_9 + 1

				var_2_1.firstDiamond = tonumber(iter_2_1[var_2_10])

				local var_2_11 = var_2_10 + 1

				var_2_1.followDiamond = tonumber(iter_2_1[var_2_11])

				local var_2_12 = var_2_11 + 1

				var_2_1.dailyDiamond = tonumber(iter_2_1[var_2_12])

				local var_2_13 = var_2_12 + 1

				var_2_1.isHot = tonumber(iter_2_1[var_2_13])

				local var_2_14 = var_2_13 + 1

				var_2_1.icon = tonumber(iter_2_1[var_2_14])

				local var_2_15 = var_2_14 + 1

				arg_2_0.records[var_2_1.id] = var_2_1
			end
		end
	end

	return arg_2_0
end

function zbVipShopTable.getRecord(arg_3_0, arg_3_1)
	return arg_3_0.records[arg_3_1]
end

function zbVipShopTable.getGoodName(arg_4_0, arg_4_1)
	if arg_4_0.records[arg_4_1] then
		return arg_4_0.records[arg_4_1].goodsName
	end

	return "钻石"
end
