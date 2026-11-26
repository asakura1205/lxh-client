zbChannelUtil_Pay = {}

local var_0_0 = CCFileUtils:sharedFileUtils():getWritablePath()
local var_0_1 = require("cjson")

function zbChannelUtil_Pay.initTencentPayCallback(arg_1_0)
	local function var_1_0(arg_2_0, arg_2_1)
		local var_2_0 = zbChannelUtil_Pay:getTencentPayOrderList()
		local var_2_1 = {
			goodId = arg_2_0,
			extra = arg_2_1
		}

		table.insert(var_2_0, var_2_1)
		zbChannelUtil_Pay:saveTencentPayOrders(var_2_0)

		if zbUtil:isValidTable(var_2_0) and table.getn(var_2_0) > 0 then
			for iter_2_0, iter_2_1 in pairs(var_2_0) do
				g_WsMsgHandler:WS_Vip_CreateOrder_Req(iter_2_1.goodId, iter_2_1.extra)
			end
		end
	end

	zbNetUtil:Instance():setLuaHandlerTencentPay(var_1_0)
end

function zbChannelUtil_Pay.saveTencentPayOrders(arg_3_0, arg_3_1)
	local var_3_0 = var_0_1.encode(arg_3_1)
	local var_3_1 = 0

	if g_GameData and g_GameData.BaseInfo then
		var_3_1 = g_GameData.BaseInfo.PlayerId
	end

	local var_3_2 = var_0_0 .. "/" .. var_3_1 .. "_tencentpay" .. ".txt"
	local var_3_3 = io.open(var_3_2, "w")

	if var_3_3 then
		var_3_3:write(var_3_0)
		var_3_3:close()
	end
end

function zbChannelUtil_Pay.getTencentPayOrderList(arg_4_0)
	local var_4_0 = {}
	local var_4_1 = 0

	if g_GameData and g_GameData.BaseInfo then
		var_4_1 = g_GameData.BaseInfo.PlayerId
	end

	local var_4_2 = var_0_0 .. "/" .. var_4_1 .. "_tencentpay.txt"
	local var_4_3 = io.open(var_4_2, "r")

	if var_4_3 then
		local var_4_4 = var_4_3:read()

		var_4_0 = var_0_1.decode(var_4_4)

		var_4_3:close()
	end

	return var_4_0
end

function zbChannelUtil_Pay.delTencentPayOrder(arg_5_0, arg_5_1)
	local var_5_0 = zbChannelUtil_Pay:getTencentPayOrderList()

	if zbUtil:isValidTable(var_5_0) and table.getn(var_5_0) > 0 then
		for iter_5_0, iter_5_1 in pairs(var_5_0) do
			local var_5_1 = string.split(iter_5_1.extra, ";")[6]

			if tostring(iter_5_1.goodId) == tostring(arg_5_1.goodId) and tostring(var_5_1) == tostring(arg_5_1.extra) then
				table.remove(var_5_0, iter_5_0)

				break
			end
		end
	end

	zbChannelUtil_Pay:saveTencentPayOrders(var_5_0)
end

local var_0_2 = {}

var_0_2[10060] = "ios.mygame.lxhzj.manya10060"
var_0_2[10300] = "ios.mygame.lxhzj.manya10300"
var_0_2[10680] = "ios.mygame.lxhzj.manya10680"
var_0_2[11980] = "ios.mygame.lxhzj.manya11980"
var_0_2[13280] = "ios.mygame.lxhzj.manya13280"
var_0_2[16480] = "ios.mygame.lxhzj.manya16480"
var_0_2[30001] = "ios.mygame.lxhzj.manya30001"
var_0_2[20001] = "ios.mygame.lxhzj.manya120001"
var_0_2[40001] = "ios.mygame.lxhzj.manya40001"

function zbChannelUtil_Pay.getGoodsIdByIapId(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(var_0_2) do
		if iter_6_1 == arg_6_1 then
			return iter_6_0
		end
	end

	return nil
end

function zbChannelUtil_Pay.sendNextOrderReq(arg_7_0)
	if zbGlobalUtil:getTargetPlatform() == "ios" then
		local var_7_0 = zbChannelUtil_Pay:getIOSPayOrderList()

		if zbUtil:isValidTable(var_7_0) and table.getn(var_7_0) > 0 then
			local var_7_1 = var_7_0[1]

			if zbUtil:isValidTable(var_7_1) then
				local var_7_2 = var_7_1.product_id .. ";" .. var_7_1.transaction_id .. ";" .. var_7_1.order_desc

				g_WsMsgHandler:WS_Vip_CreateOrder_Req(var_7_1.goodId, var_7_2)
			end
		end
	end
end

function zbChannelUtil_Pay.onIOSPayOrderReq(arg_8_0, arg_8_1)
	local var_8_0 = var_0_2[arg_8_1]

	if var_8_0 == nil then
		return
	end

	zbGlobalUtil:payOrderInfoSend(var_8_0, "")
end

function zbChannelUtil_Pay.initIOSPayCallback(arg_9_0)
	local function var_9_0(arg_10_0, arg_10_1)
		local var_10_0 = string.split(arg_10_1, ";")

		if zbUtil:isValidTable(var_10_0) == false or table.getn(var_10_0) < 3 then
			return
		end

		local var_10_1 = zbChannelUtil_Pay:getIOSPayOrderList()
		local var_10_2 = {
			goodId = zbChannelUtil_Pay:getGoodsIdByIapId(arg_10_0),
			product_id = var_10_0[1],
			transaction_id = var_10_0[2],
			order_desc = var_10_0[3]
		}

		table.insert(var_10_1, var_10_2)
		zbChannelUtil_Pay:saveIOSPayOrders(var_10_1)

		local var_10_3 = var_10_2.product_id .. ";" .. var_10_2.transaction_id .. ";" .. var_10_2.order_desc

		g_WsMsgHandler:WS_Vip_CreateOrder_Req(var_10_2.goodId, var_10_3)
	end

	zbNetUtil:Instance():RegisterIapCreateOrderLuaCallback(var_9_0)
end

function zbChannelUtil_Pay.getIOSPayOrderList(arg_11_0)
	local var_11_0 = {}
	local var_11_1 = 0

	if g_GameData and g_GameData.BaseInfo then
		var_11_1 = g_GameData.BaseInfo.PlayerId
	end

	local var_11_2 = var_0_0 .. "/" .. var_11_1 .. "_iospayorders.txt"
	local var_11_3 = io.open(var_11_2, "r")

	if var_11_3 then
		local var_11_4 = var_11_3:read()

		var_11_0 = var_0_1.decode(var_11_4)

		var_11_3:close()
	end

	return var_11_0
end

function zbChannelUtil_Pay.saveIOSPayOrders(arg_12_0, arg_12_1)
	local var_12_0 = var_0_1.encode(arg_12_1)
	local var_12_1 = 0

	if g_GameData and g_GameData.BaseInfo then
		var_12_1 = g_GameData.BaseInfo.PlayerId
	end

	local var_12_2 = var_0_0 .. "/" .. var_12_1 .. "_iospayorders" .. ".txt"
	local var_12_3 = io.open(var_12_2, "w")

	if var_12_3 then
		var_12_3:write(var_12_0)
		var_12_3:close()
	end
end

function zbChannelUtil_Pay.delIOSPayOrder(arg_13_0, arg_13_1)
	local var_13_0 = zbChannelUtil_Pay:getIOSPayOrderList()

	if zbUtil:isValidTable(var_13_0) and table.getn(var_13_0) > 0 then
		for iter_13_0, iter_13_1 in pairs(var_13_0) do
			if tostring(iter_13_1.transaction_id) == tostring(arg_13_1) then
				table.remove(var_13_0, iter_13_0)

				break
			end
		end
	end

	zbChannelUtil_Pay:saveIOSPayOrders(var_13_0)
end

function zbChannelUtil_Pay.onPayOrderInfoReqByChanelType(arg_14_0, arg_14_1)
	local var_14_0 = ""

	if g_Login.channel == EChannelType.zb then
		-- block empty
	elseif g_Login.channel == EChannelType.uc then
		local var_14_1 = arg_14_1.Price
		local var_14_2 = arg_14_1.GameOrderId
		local var_14_3 = arg_14_1.GameOrderId
		local var_14_4 = "MD5"
		local var_14_5 = var_0_1.decode(arg_14_1.Extra)

		if type(var_14_5) ~= "table" then
			return
		end

		local var_14_6 = var_14_5.notifyUrl
		local var_14_7 = var_14_5.accountId
		local var_14_8 = var_14_5.ucSign

		var_14_0 = var_14_1 .. ";" .. var_14_6 .. ";" .. var_14_2 .. ";" .. var_14_7 .. ";" .. var_14_3 .. ";" .. var_14_4 .. ";" .. var_14_8 .. ";"
	elseif g_Login.channel == EChannelType.bilibili then
		local var_14_9 = ""
		local var_14_10 = 0
		local var_14_11 = g_Login:getCurServer()

		if var_14_11 then
			var_14_10 = var_14_11.ServerId
		end

		local var_14_12 = g_GameData.BaseInfo.RoleName
		local var_14_13 = arg_14_1.Price * 100
		local var_14_14 = arg_14_1.Price * 10
		local var_14_15 = arg_14_1.GameOrderId
		local var_14_16 = a2u(zbVipShopTable:getGoodName(arg_14_1.GoodsId))
		local var_14_17 = var_14_16
		local var_14_18 = arg_14_1.GameOrderId

		var_14_0 = var_14_10 .. ";" .. var_14_12 .. ";" .. var_14_13 .. ";" .. var_14_14 .. ";" .. var_14_15 .. ";" .. var_14_16 .. ";" .. var_14_17 .. ";" .. var_14_18 .. ";"
	elseif g_Login.channel == EChannelType.kaopu then
		local var_14_19 = arg_14_1.Price
		local var_14_20 = 0
		local var_14_21 = ""
		local var_14_22 = g_Login:getCurServer()

		if var_14_22 then
			var_14_20 = var_14_22.ServerId
			var_14_21 = var_14_22.ServerName
		end

		local var_14_23 = var_14_20 .. a2u(var_14_21)
		local var_14_24 = g_GameData.BaseInfo.RoleName
		local var_14_25 = arg_14_1.GameOrderId
		local var_14_26 = a2u(zbVipShopTable:getGoodName(arg_14_1.GoodsId))
		local var_14_27 = 10
		local var_14_28 = arg_14_1.GoodsId

		var_14_0 = var_14_19 .. ";" .. var_14_23 .. ";" .. var_14_24 .. ";" .. var_14_25 .. ";" .. var_14_26 .. ";" .. var_14_27 .. ";" .. var_14_28 .. ";"
	elseif g_Login.channel == EChannelType.kpsuper then
		local var_14_29 = arg_14_1.Price
		local var_14_30 = 0
		local var_14_31 = ""
		local var_14_32 = g_Login:getCurServer()

		if var_14_32 then
			var_14_30 = var_14_32.ServerId
			var_14_31 = var_14_32.ServerName
		end

		local var_14_33 = var_14_30 .. a2u(var_14_31)
		local var_14_34 = g_GameData.BaseInfo.RoleName
		local var_14_35 = arg_14_1.GameOrderId
		local var_14_36 = a2u(zbVipShopTable:getGoodName(arg_14_1.GoodsId))
		local var_14_37 = 10
		local var_14_38 = arg_14_1.GoodsId

		var_14_0 = var_14_29 .. ";" .. var_14_33 .. ";" .. var_14_34 .. ";" .. var_14_35 .. ";" .. var_14_36 .. ";" .. var_14_37 .. ";" .. var_14_38 .. ";"
	elseif g_Login.channel == EChannelType.kuaikan then
		local var_14_39 = var_0_1.decode(arg_14_1.Extra)

		if type(var_14_39) ~= "table" then
			return
		end

		local var_14_40 = var_14_39.trans_data
		local var_14_41 = var_14_39.sign
		local var_14_42 = string.urldecode(var_14_41)

		var_14_0 = var_14_40 .. ";" .. var_14_42 .. ";"
	elseif g_Login.channel == EChannelType.m4399 then
		local var_14_43 = arg_14_1.GameOrderId
		local var_14_44 = arg_14_1.Price
		local var_14_45 = a2u(zbVipShopTable:getGoodName(arg_14_1.GoodsId))

		var_14_0 = var_14_43 .. ";" .. var_14_44 .. ";" .. var_14_45 .. ";"
	elseif g_Login.channel == EChannelType.qihoo then
		local var_14_46 = arg_14_1.Price * 100
		local var_14_47 = 10
		local var_14_48 = a2u(zbVipShopTable:getGoodName(arg_14_1.GoodsId))
		local var_14_49 = arg_14_1.GoodsId
		local var_14_50 = g_GameData.BaseInfo.RoleName
		local var_14_51 = g_GameData.BaseInfo.PlayerId
		local var_14_52 = arg_14_1.GameOrderId
		local var_14_53 = arg_14_1.GameOrderId
		local var_14_54 = 0
		local var_14_55 = 0
		local var_14_56 = g_Login:getCurServer()

		if var_14_56 then
			var_14_54 = var_14_56.ServerId
			var_14_55 = var_14_56.ServerName
		end

		local var_14_57 = g_GameData.BaseInfo.Level
		local var_14_58 = g_GameData.Wealth.Diamond
		local var_14_59 = g_GameData.BaseInfo.VipLevel
		local var_14_60 = a2u(g_Self.kLegionHandler:getLegionName())
		local var_14_61 = var_0_1.decode(arg_14_1.Extra)

		if type(var_14_61) ~= "table" then
			return
		end

		local var_14_62 = var_14_61.accountId
		local var_14_63 = var_14_61.notifyUrl

		var_14_0 = var_14_62 .. ";" .. var_14_46 .. ";" .. var_14_47 .. ";" .. var_14_48 .. ";" .. var_14_49 .. ";" .. var_14_63 .. ";" .. var_14_50 .. ";" .. var_14_51 .. ";" .. var_14_52 .. ";" .. var_14_53 .. ";" .. var_14_54 .. ";" .. var_14_55 .. ";" .. var_14_57 .. ";" .. var_14_58 .. ";" .. var_14_59 .. ";" .. var_14_60 .. ";"
	elseif g_Login.channel == EChannelType.qq then
		local var_14_64 = 0

		if curServer then
			var_14_64 = curServer.ServerId
		end

		local var_14_65 = arg_14_1.Price * 10
		local var_14_66 = arg_14_1.GoodsId

		var_14_0 = var_14_64 .. ";" .. var_14_65 .. ";" .. var_14_66 .. ";"
	elseif g_Login.channel == EChannelType.meizu then
		local var_14_67 = arg_14_1.GameOrderId
		local var_14_68 = var_14_67
		local var_14_69 = arg_14_1.Price * 100
		local var_14_70 = arg_14_1.GoodsId
		local var_14_71 = a2u(zbVipShopTable:getGoodName(arg_14_1.GoodsId))
		local var_14_72 = var_14_71
		local var_14_73 = 0

		if curServer then
			var_14_73 = curServer.ServerId
		end

		var_14_0 = var_14_67 .. ";" .. var_14_68 .. ";" .. var_14_69 .. ";" .. var_14_70 .. ";" .. var_14_71 .. ";" .. var_14_72 .. ";" .. var_14_73 .. ";"
	elseif g_Login.channel == EChannelType.xiaomi then
		local var_14_74 = arg_14_1.GameOrderId
		local var_14_75 = var_14_74
		local var_14_76 = arg_14_1.Price
		local var_14_77 = g_GameData.BaseInfo.Level
		local var_14_78 = g_GameData.Wealth.Diamond
		local var_14_79 = g_GameData.BaseInfo.VipLevel
		local var_14_80 = a2u(g_Self.kLegionHandler:getLegionName())
		local var_14_81 = g_GameData.BaseInfo.PlayerId
		local var_14_82 = g_GameData.BaseInfo.RoleName
		local var_14_83 = 0
		local var_14_84 = g_Login:getCurServer()

		if var_14_84 then
			var_14_83 = var_14_84.ServerName
		end

		var_14_0 = var_14_74 .. ";" .. var_14_75 .. ";" .. var_14_76 .. ";" .. var_14_78 .. ";" .. var_14_79 .. ";" .. var_14_77 .. ";" .. var_14_80 .. ";" .. var_14_82 .. ";" .. var_14_81 .. ";" .. var_14_83 .. ";"
	elseif zbChannelUtil:isYijieSdkChannel(g_Login.channel) then
		local var_14_85 = arg_14_1.Price * 100
		local var_14_86 = arg_14_1.GoodsId
		local var_14_87 = a2u(zbVipShopTable:getGoodName(arg_14_1.GoodsId))
		local var_14_88 = arg_14_1.Extra
		local var_14_89 = arg_14_1.GameOrderId

		var_14_0 = var_14_85 .. ";" .. var_14_87 .. ";" .. var_14_88 .. ";" .. var_14_89 .. ";"
	elseif g_Login.channel == EChannelType.vivo then
		local var_14_90 = a2u(zbVipShopTable:getGoodName(arg_14_1.GoodsId))
		local var_14_91 = var_14_90
		local var_14_92 = arg_14_1.Price * 100
		local var_14_93 = arg_14_1.GameOrderId
		local var_14_94 = var_0_1.decode(arg_14_1.Extra)

		if type(var_14_94) ~= "table" then
			return
		end

		local var_14_95 = var_14_94.accessKey

		var_14_0 = var_14_94.orderNumber .. ";" .. var_14_95 .. ";" .. var_14_90 .. ";" .. var_14_91 .. ";" .. var_14_92 .. ";" .. var_14_93 .. ";"
	elseif g_Login.channel == EChannelType.oppo then
		local var_14_96 = arg_14_1.GameOrderId
		local var_14_97 = var_14_96
		local var_14_98 = arg_14_1.Price * 100
		local var_14_99 = a2u(zbVipShopTable:getGoodName(arg_14_1.GoodsId))
		local var_14_100 = var_14_99
		local var_14_101 = arg_14_1.Extra

		var_14_0 = var_14_96 .. ";" .. var_14_97 .. ";" .. var_14_98 .. ";" .. var_14_99 .. ";" .. var_14_100 .. ";" .. var_14_101 .. ";"
	elseif g_Login.channel == EChannelType.huawei then
		local var_14_102 = arg_14_1.GameOrderId
		local var_14_103 = arg_14_1.GameOrderId
		local var_14_104 = arg_14_1.Price .. ".00"
		local var_14_105 = a2u(zbVipShopTable:getGoodName(arg_14_1.GoodsId))
		local var_14_106 = var_14_105
		local var_14_107 = arg_14_1.Extra

		var_14_0 = var_14_102 .. ";" .. var_14_103 .. ";" .. var_14_104 .. ";" .. var_14_105 .. ";" .. var_14_106 .. ";" .. var_14_107 .. ";"
	end

	zbGlobalUtil:payOrderInfoSend(var_14_0, "")
end
