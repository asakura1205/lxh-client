require("gamelogic.zbItem")

local var_0_0 = class("zbVipGiftItem", CCNodeExtend)

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

function createVipGiftItem(arg_2_0)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNodeRGBA:create()))

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		return
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		arg_3_0.items = {}

		for iter_5_0 = 1, 4 do
			local var_5_1 = tolua.cast(var_5_0:getChildByTag(iter_5_0), "CCLayerColor")
			local var_5_2 = createItem()
			local var_5_3 = ccp(var_5_1:getPosition())

			var_5_2:setPosition(var_5_3.x - 5, var_5_3.y - 10)
			var_5_2:setScale(0.9)
			var_5_0:addChild(var_5_2)

			arg_3_0.items[iter_5_0] = var_5_2

			var_5_1:removeFromParentAndCleanup(true)
		end

		arg_3_0:setContentSize(var_5_0:getContentSize())
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_6_0, arg_6_1)
	for iter_6_0 = 1, 4 do
		arg_6_0.items[iter_6_0]:setVisible(false)
	end

	local var_6_0 = 1

	if zbUtil:isValidTable(arg_6_1) then
		for iter_6_1, iter_6_2 in pairs(arg_6_1) do
			if var_6_0 <= 4 then
				arg_6_0.items[var_6_0]:setVisible(true)
				arg_6_0.items[var_6_0]:refreshAward(iter_6_2.Type, iter_6_2.Id, iter_6_2.Count, false)
			end

			var_6_0 = var_6_0 + 1
		end
	end
end
