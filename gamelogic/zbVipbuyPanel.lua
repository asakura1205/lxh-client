require("gamelogic.zbVipItemList")

local var_0_0 = class("zbVipbuyPanel")

var_0_0.__index = var_0_0

function var_0_0.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, var_0_0)

	return arg_1_0
end

function createVipBuyPanel(arg_2_0)
	local var_2_0 = var_0_0.new()

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.layer = arg_3_1
	end

	local function var_3_1()
		arg_3_0.layerContent = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")
		arg_3_0.shopList = createVipItemList(arg_3_0.layerContent)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_6_0)
	arg_6_0.shopList:refresh()
end

function var_0_0.setVisible(arg_7_0, arg_7_1)
	arg_7_0.layer:setVisible(arg_7_1)
end
