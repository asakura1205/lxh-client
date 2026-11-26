zbFormationBubble = class("zbFormationBubble", CCNodeExtend)
zbFormationBubble.__index = zbFormationBubble

function zbFormationBubble.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbFormationBubble)

	return arg_1_0
end

function zbFormationBubble.create(arg_2_0)
	local var_2_0 = zbFormationBubble.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init()

	return var_2_0
end

function zbFormationBubble.init(arg_3_0)
	arg_3_0:retain()
end

function zbFormationBubble.showTextAndNumBubble(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = tostring(arg_4_2)

	if arg_4_2 > 0 then
		var_4_0 = "+" .. var_4_0
	end

	local var_4_1 = 390
	local var_4_2 = 42
	local var_4_3 = CCNodeRGBA:create()
	local var_4_4 = CCSprite:create(arg_4_1)
	local var_4_5 = CCLabelAtlas:create(var_4_0, "image/combat/bubble/self_bj_green.png", var_4_1 / 15, var_4_2, string.byte("+"))
	local var_4_6 = 3
	local var_4_7 = var_4_4:getContentSize().width + var_4_6 + var_4_5:getContentSize().width

	var_4_4:setAnchorPoint(ccp(0, 0))
	var_4_4:setPosition(0, 0)
	var_4_5:setAnchorPoint(ccp(0, 0))
	var_4_5:setPosition(var_4_4:getContentSize().width + var_4_6, 0)
	var_4_3:setScale(0.7)
	var_4_3:addChild(var_4_4)
	var_4_3:addChild(var_4_5)

	local var_4_8 = ccp(0, 100)

	var_4_8.x = var_4_8.x - var_4_7 / 2

	if arg_4_3 > 0.1 then
		var_4_8.x = math.random(var_4_8.x - 15, var_4_8.x + 15)
	end

	var_4_3:setAnchorPoint(ccp(0.5, 0))
	var_4_3:setPosition(var_4_8)
	var_4_3:setCascadeOpacityEnabled(true)
	var_4_3:setOpacity(0)
	arg_4_0:addChild(var_4_3)

	local var_4_9 = CCArray:create()

	var_4_9:addObject(CCFadeIn:create(0.125))
	var_4_9:addObject(CCMoveTo:create(0.6, ccp(var_4_8.x, var_4_8.y + 70)))

	local var_4_10 = CCSpawn:create(var_4_9)
	local var_4_11 = CCArray:create()

	var_4_11:addObject(CCMoveTo:create(0.25, ccp(var_4_8.x, var_4_8.y + 90)))
	var_4_11:addObject(CCFadeOut:create(0.2))

	local var_4_12 = CCSpawn:create(var_4_11)
	local var_4_13 = CCArray:create()

	var_4_13:addObject(CCDelayTime:create(arg_4_3))
	var_4_13:addObject(var_4_10)
	var_4_13:addObject(var_4_12)
	var_4_13:addObject(CCCallFuncN:create(handler(arg_4_0, arg_4_0.removeBubble)))
	var_4_3:stopAllActions()
	var_4_3:runAction(CCSequence:create(var_4_13))
end

function zbFormationBubble.removeBubble(arg_5_0, arg_5_1)
	arg_5_0:removeChild(arg_5_1, true)
end

function zbFormationBubble.showFormationType(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_2 < 1 then
		return
	end

	local var_6_0 = zbTechTable:getRecord(arg_6_1)

	if var_6_0 == nil then
		return
	end

	local var_6_1 = ""
	local var_6_2 = ""
	local var_6_3 = 0
	local var_6_4 = 0

	if var_6_0.attrType1 > 0 then
		var_6_1 = "image/combat/bubble_formation/bubble_" .. var_6_0.attrType1 .. ".png"
		var_6_3 = arg_6_2 * var_6_0.attrGrowth1 + var_6_0.attrBase1
	end

	if var_6_0.attrType2 > 0 then
		var_6_2 = "image/combat/bubble_formation/bubble_" .. var_6_0.attrType2 .. ".png"
		var_6_4 = arg_6_2 * var_6_0.attrGrowth2 + var_6_0.attrBase2
	end

	local var_6_5 = 2

	if var_6_3 > 40 then
		var_6_5 = 4
	end

	if var_6_2 ~= "" and var_6_4 > 0 then
		var_6_5 = var_6_5 / 2
	end

	local function var_6_6(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = 0
		local var_7_1 = 0

		for iter_7_0 = 1, var_6_5 do
			if iter_7_0 < var_6_5 then
				local var_7_2 = zbUtil:random(96, 104) / 100

				var_7_1 = arg_7_1 / var_6_5 * var_7_2
				var_7_1 = math.ceil(var_7_1)
				var_7_0 = var_7_0 + var_7_1
			else
				var_7_1 = arg_7_1 - var_7_0
			end

			local var_7_3 = 0.1 + arg_7_2

			arg_6_0:showTextAndNumBubble(arg_7_0, var_7_1, var_7_3 + (iter_7_0 - 1) * 0.3)
		end
	end

	local var_6_7 = 0.15

	if var_6_3 > 0 then
		var_6_6(var_6_1, var_6_3, var_6_7)

		var_6_7 = var_6_7 + 0.5
	end

	if var_6_4 > 0 then
		var_6_6(var_6_2, var_6_4, var_6_7)
	end

	local function var_6_8()
		arg_6_0:setVisible(false)
	end

	local var_6_9 = CCArray:create()

	var_6_9:addObject(CCDelayTime:create(3))
	var_6_9:addObject(CCCallFuncN:create(var_6_8))
	arg_6_0:setVisible(true)
	arg_6_0:stopAllActions()
	arg_6_0:runAction(CCSequence:create(var_6_9))
end
