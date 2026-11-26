require("gamebase.zbFunctions")
require("gamelogic.zbItem")

local var_0_0 = class("zbAwardPreviewPop", CCNodeExtend)

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

function createAwardPrviewPop()
	return (var_0_0.extend(CCNodeExtend.extend(CCNode:create())))
end

function var_0_0.refresh(arg_3_0, arg_3_1)
	arg_3_0:removeAllChildrenWithCleanup(true)

	arg_3_0.s9bg = CCScale9Sprite:create("image/common/tips_bg.png")

	arg_3_0.s9bg:setAnchorPoint(ccp(0, 0))
	arg_3_0:addChild(arg_3_0.s9bg)

	arg_3_0.awardItems = {}

	local var_3_0 = 0
	local var_3_1 = 120
	local var_3_2 = 20

	if zbUtil:isValidTable(arg_3_1) then
		for iter_3_0, iter_3_1 in pairs(arg_3_1) do
			local var_3_3 = createItem()

			var_3_3:setPosition(ccp(var_3_2, 25))
			var_3_3:setScale(0.8)
			var_3_3:setSupportTouchTip(false)
			arg_3_0:addChild(var_3_3)
			var_3_3:refreshAward(iter_3_1.Type, iter_3_1.Id, iter_3_1.Count)

			var_3_2 = var_3_2 + var_3_3:getContentSize().width
		end
	end

	local var_3_4 = var_3_2
	local var_3_5 = CCSizeMake(var_3_4, var_3_1)

	arg_3_0.s9bg:setPreferredSize(var_3_5)
	arg_3_0:setContentSize(var_3_5)
end
