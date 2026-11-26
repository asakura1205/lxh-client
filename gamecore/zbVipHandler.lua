local var_0_0 = class("zbVipHandler")

var_0_0.__index = var_0_0

function createVipHandler()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	return
end

function var_0_0.getVipGiftDetailByLevel(arg_3_0, arg_3_1)
	if g_GameData.VipInfo and zbUtil:isValidTable(g_GameData.VipInfo.VipGift) then
		for iter_3_0, iter_3_1 in pairs(g_GameData.VipInfo.VipGift) do
			if iter_3_1.Level == arg_3_1 then
				return iter_3_1
			end
		end
	end

	return nil
end
