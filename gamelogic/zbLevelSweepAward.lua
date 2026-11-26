zbLevelSweepAward = class("zbLevelSweepAward", CCNodeExtend)
zbLevelSweepAward.__index = zbLevelSweepAward

function zbLevelSweepAward.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbLevelSweepAward)

	return arg_1_0
end

function zbLevelSweepAward.create(arg_2_0, arg_2_1)
	local var_2_0 = zbLevelSweepAward.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1)

	return var_2_0
end

function zbLevelSweepAward.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.items = {}
		arg_3_0.itemsExtra = {}
	end

	local function var_3_1()
		arg_3_0.layerAward = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")
		arg_3_0.layerAwardExtra = tolua.cast(arg_3_1:getChildByTag(2), "CCNode")
		arg_3_0.lbAwardTitle = tolua.cast(arg_3_0.layerAward:getChildByTag(1001), "CCLabelTTF")
		arg_3_0.layerAwardContainer = tolua.cast(arg_3_0.layerAward:getChildByTag(2), "CCNode")
		arg_3_0.lbNoAward = tolua.cast(arg_3_0.layerAward:getChildByTag(1003), "CCLabelTTF")

		for iter_5_0 = 1, 5 do
			local var_5_0 = tolua.cast(arg_3_0.layerAwardContainer:getChildByTag(iter_5_0), "CCLayerColor")
			local var_5_1 = createItem()

			var_5_1:setPosition(var_5_0:getPosition())
			var_5_1:setScale(0.9)
			var_5_1:setSupportTouchDownTip(false)
			var_5_1:setSupportTouchTip(true)
			var_5_1:setSwallowsTouches(false)
			arg_3_0.layerAwardContainer:addChild(var_5_1)

			arg_3_0.items[iter_5_0] = var_5_1

			var_5_0:removeFromParentAndCleanup(true)
		end

		arg_3_0.lbAwardExtraTitle = tolua.cast(arg_3_0.layerAwardExtra:getChildByTag(1001), "CCLabelTTF")
		arg_3_0.layerAwardExtraContainer = tolua.cast(arg_3_0.layerAwardExtra:getChildByTag(2), "CCNode")

		for iter_5_1 = 1, 5 do
			local var_5_2 = tolua.cast(arg_3_0.layerAwardExtraContainer:getChildByTag(iter_5_1), "CCLayerColor")
			local var_5_3 = createItem()

			var_5_3:setPosition(var_5_2:getPosition())
			var_5_3:setScale(0.9)
			var_5_3:setSupportTouchDownTip(false)
			var_5_3:setSupportTouchTip(true)
			var_5_3:setSwallowsTouches(false)
			arg_3_0.layerAwardExtraContainer:addChild(var_5_3)

			arg_3_0.itemsExtra[iter_5_1] = var_5_3

			var_5_2:removeFromParentAndCleanup(true)
		end

		arg_3_0:addChild(arg_3_1)
		arg_3_0:setContentSize(arg_3_0.layerAward:getContentSize())
	end

	var_3_0()
	var_3_1()
end

function zbLevelSweepAward.refresh(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.layerAward:setVisible(true)
	arg_6_0.layerAwardExtra:setVisible(false)

	if arg_6_3 == true then
		arg_6_0.lbAwardTitle:setString(a2u("\xB1\xBE\xB4\xCEɨ\xB5\xB4"))
	else
		arg_6_0.lbAwardTitle:setString(a2u(string.format("\xB5\xDA%d\xB4\xCEɨ\xB5\xB4", arg_6_2)))
	end

	for iter_6_0, iter_6_1 in pairs(arg_6_0.items) do
		iter_6_1:setVisible(false)
	end

	local var_6_0 = 1

	for iter_6_2, iter_6_3 in pairs(arg_6_1) do
		local var_6_1 = arg_6_0.items[var_6_0]

		if var_6_1 then
			var_6_1:refreshAward(iter_6_3.Type, iter_6_3.Id, iter_6_3.Count)
			var_6_1:setVisible(true)
		end

		var_6_0 = var_6_0 + 1
	end

	arg_6_0.lbNoAward:setVisible(var_6_0 == 1)
end

function zbLevelSweepAward.refreshExtra(arg_7_0, arg_7_1)
	arg_7_0.layerAward:setVisible(false)
	arg_7_0.layerAwardExtra:setVisible(true)

	for iter_7_0, iter_7_1 in pairs(arg_7_0.itemsExtra) do
		iter_7_1:setVisible(false)
	end

	local var_7_0 = 1

	for iter_7_2, iter_7_3 in pairs(arg_7_1) do
		local var_7_1 = arg_7_0.itemsExtra[var_7_0]

		if var_7_1 then
			var_7_1:refreshAward(iter_7_3.Type, iter_7_3.Id, iter_7_3.Count)
			var_7_1:setVisible(true)
		end

		var_7_0 = var_7_0 + 1
	end
end
