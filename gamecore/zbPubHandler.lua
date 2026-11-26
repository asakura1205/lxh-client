local var_0_0 = class("zbPubHandler")

var_0_0.__index = var_0_0

function createPubHandler()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	arg_2_0.AwardList = {}
end

function var_0_0.updateBarInfoAwardList(arg_3_0, arg_3_1, arg_3_2)
	if zbUtil:isValidTable(arg_3_1) then
		g_GameData.BarInfo = arg_3_1

		arg_3_0:nextFreeDrawPush()
	end

	if zbUtil:isValidTable(arg_3_2) then
		arg_3_0.AwardList = arg_3_2
	else
		arg_3_0.AwardList = {}
	end

	g_GameEventMgr:sendEvent(zbGameEvent.Event_BarDraw_Ack)
end

function var_0_0.nextFreeDrawPush(arg_4_0)
	g_PushCenter:setPushOff(EPushType.E_PUB_FREE)

	if g_GameData.BarInfo.BarList[EBarDrawType.DiamondSingle] then
		local var_4_0 = g_GameData.BarInfo.BarList[EBarDrawType.DiamondSingle]
		local var_4_1 = math.max(var_4_0.NextFreeTm - g_Self.kTimeHandler:getServerTime() - 5, 0)

		if var_4_0.FreeCount < var_4_0.FreeTotalCount and var_4_0.NextFreeTm > 0 then
			local var_4_2 = g_Self.kTimeHandler:getServerTime() + var_4_1 + g_Self.kTimeHandler:getTimeZoneDelt()
			local var_4_3 = os.date("*t", var_4_2).day
			local var_4_4 = math.floor(var_4_2 / 3600) % 24
			local var_4_5 = math.floor(var_4_2 % 3600 / 60)
			local var_4_6 = string.format("%02d:%02d:%02d", var_4_3, var_4_4, var_4_5)

			echo("......pushtime..................", var_4_6)
			g_PushCenter:pushOnceMessage(EPushType.E_PUB_FREE, var_4_6, a2u(E_DESC[EPushType.E_PUB_FREE]), "")
		end
	end
end

function var_0_0.isCanFreeBarDraw(arg_5_0)
	for iter_5_0 = EBarDrawType.NormalSingle, EBarDrawType.DiamondSingle do
		local var_5_0 = g_GameData.BarInfo.BarList[iter_5_0]
		local var_5_1 = math.max(var_5_0.NextFreeTm - g_Self.kTimeHandler:getServerTime(), 0)

		if (var_5_0.NextFreeTm == 0 or var_5_1 <= 0) and var_5_0.FreeCount < var_5_0.FreeTotalCount then
			return true
		end
	end

	return false
end
