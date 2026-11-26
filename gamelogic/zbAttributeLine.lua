require("gamebase.zbFunctions")

local var_0_0 = class("zbAttributeLine", CCNodeExtend)

var_0_0.__index = var_0_0
AttributeText_Height = 30

function var_0_0.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, var_0_0)

	return arg_1_0
end

function createAttributeLine(arg_2_0)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.name = nil
		arg_3_0.value = nil
		arg_3_0.type = 0
		arg_3_0.defaultColor = ccc3(255, 255, 255)
	end

	local function var_3_1()
		arg_3_0.layer = arg_3_1
		arg_3_0.lbAttributName = tolua.cast(arg_3_1:getChildByTag(1), "CCLabelTTF")
		arg_3_0.lbAttributValue = tolua.cast(arg_3_1:getChildByTag(2), "CCLabelTTF")
		arg_3_0.lbAddAttributValue = tolua.cast(arg_3_1:getChildByTag(4), "CCLabelTTF")
		arg_3_0.btnTouch = tolua.cast(arg_3_1:getChildByTag(3), "CCControlButton")
		arg_3_0.tagAttribute = tolua.cast(arg_3_1:getChildByTag(5), "CCSprite")

		arg_3_0.lbAttributName:setVisible(false)
		arg_3_0.lbAttributValue:setVisible(false)
		arg_3_0.lbAddAttributValue:setVisible(false)
		arg_3_0.tagAttribute:setVisible(false)
		arg_3_0:addChild(arg_3_1)
		arg_3_0:setAnchorPoint(ccp(0, 0))
		arg_3_0:setPosition(0, 0)
		arg_3_0:setContentSize(CCSizeMake(arg_3_1:getContentSize().width, AttributeText_Height))
		arg_3_0.btnTouch:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnTouch:setSwallowsTouches(false)
	end

	var_3_0()
	var_3_1()
end

local function var_0_1(arg_6_0)
	local var_6_0 = string.gsub(arg_6_0, "%[color=0x[%a%d]+%]", "")

	return (string.gsub(var_6_0, "%[/color%]", ""))
end

function var_0_0.refresh(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0.richText ~= nil then
		arg_7_0.richText:removeFromParentAndCleanup(true)

		arg_7_0.richText = nil
	end

	local var_7_0 = 0

	if arg_7_2 == 1 then
		arg_7_0.tagAttribute:setVisible(true)

		var_7_0 = 25
	else
		arg_7_0.tagAttribute:setVisible(false)
	end

	arg_7_0.lbAttributName:setString(var_0_1(arg_7_1))

	local var_7_1 = arg_7_0.lbAttributName:getTxtBound()
	local var_7_2 = var_7_1.width

	arg_7_0.richText = CCRichLabelTTF:create(var_7_1.width, var_7_1.height, arg_7_0.lbAttributName:getFontSize(), arg_7_0.lbAttributName:getFontName(), arg_7_0.defaultColor, false)

	arg_7_0.richText:setRichString(arg_7_1)
	arg_7_0.richText:setPosition(var_7_0, 0)
	arg_7_0.layer:addChild(arg_7_0.richText)
	arg_7_0.btnTouch:setContentSize(CCSize(arg_7_0.richText:getContentSize().width, arg_7_0.btnTouch:getContentSize().height))
	arg_7_0:setVisible(true)

	return var_7_2
end

function var_0_0.refreshLable(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_0.richText ~= nil then
		arg_8_0.richText:removeFromParentAndCleanup(true)

		arg_8_0.richText = nil
	end

	local var_8_0 = 0

	if arg_8_2 == 1 then
		arg_8_0.tagAttribute:setVisible(true)

		var_8_0 = 25
	else
		arg_8_0.tagAttribute:setVisible(false)
	end

	arg_8_0.lbAttributName:setString(arg_8_1)
	arg_8_0.lbAttributName:setColor(arg_8_3)
	arg_8_0.lbAttributName:setVisible(true)
	arg_8_0.lbAttributName:setPosition(var_8_0, 0)
	arg_8_0:setVisible(true)

	return width
end

function var_0_0.setDefaultColor(arg_9_0, arg_9_1)
	arg_9_0.defaultColor = arg_9_1
end
