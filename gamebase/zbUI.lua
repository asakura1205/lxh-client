local var_0_0 = {}

TOUCH_EVENT_TYPE_BEGAN = "began"
TOUCH_EVENT_TYPE_MOVED = "moved"
TOUCH_EVENT_TYPE_ENDED = "ended"

function var_0_0.createButton(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = CCSprite:create(arg_1_1)

	var_1_0:setAnchorPoint(ccp(0, 0))

	local var_1_1 = CCSprite:create(arg_1_2)

	var_1_1:setAnchorPoint(ccp(0, 0))

	local var_1_2 = CCControlButton:create(var_1_0)

	var_1_2:setBackgroundSpriteForState(var_1_1, CCControlStateHighlighted)
	var_1_2:setTitleColorForState(ccc3(255, 255, 255), CCControlStateHighlighted)
	var_1_2:setAdjustBackgroundImage(false)

	if arg_1_3 ~= nil then
		var_1_2:addHandleOfControlEvent(arg_1_3, CCControlEventTouchUpInside)
	end

	return var_1_2
end

function var_0_0.setButtonPic(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if arg_2_1 == nil then
		return
	end

	if arg_2_2 then
		local var_2_0 = CCSprite:create(arg_2_2)

		arg_2_1:setBackgroundSpriteForState(var_2_0, CCControlStateNormal)
		arg_2_1:setBackgroundSprite(var_2_0)
	end

	if arg_2_3 then
		local var_2_1 = CCSprite:create(arg_2_3)

		arg_2_1:setBackgroundSpriteForState(var_2_1, CCControlStateHighlighted)
	end

	if arg_2_4 then
		local var_2_2 = CCSprite:create(arg_2_4)

		arg_2_1:setBackgroundSpriteForState(var_2_2, CCControlStateDisabled)
	end
end

function var_0_0.createScrollBarView(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	require("gamebase.CCScrollbar")

	if arg_3_1 == nil then
		return
	end

	return (CCScrollbar:create(arg_3_1, arg_3_2, arg_3_3, arg_3_4))
end

function var_0_0.adjustLableHeightPos(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if zbGlobalUtil:getTargetPlatform() == "android" then
		arg_4_3 = arg_4_3 - 40
	end

	local var_4_0 = 5
	local var_4_1

	var_4_1 = arg_4_2 or 5

	for iter_4_0, iter_4_1 in pairs(arg_4_1) do
		local var_4_2 = iter_4_1:getTxtBound(arg_4_3, 0)

		iter_4_1:setDimensions(var_4_2)

		local var_4_3 = ccp(iter_4_1:getPosition())

		iter_4_1:setPosition(var_4_3.x, var_4_0)

		var_4_0 = var_4_0 + var_4_2.height + 20
	end

	return var_4_0
end

function var_0_0.adjustLableHeightSkill(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if zbGlobalUtil:getTargetPlatform() == "android" then
		arg_5_2 = arg_5_2 - 40
	end

	local var_5_0 = 2

	for iter_5_0, iter_5_1 in pairs(arg_5_1) do
		local var_5_1 = iter_5_1:getTxtBound(arg_5_2, 0)

		iter_5_1:setDimensions(var_5_1)

		local var_5_2 = ccp(iter_5_1:getPosition())

		iter_5_1:setPosition(var_5_2.x, var_5_0)

		var_5_0 = var_5_0 + var_5_1.height + arg_5_3
	end

	return var_5_0
end

function var_0_0.createLabel(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	arg_6_2 = arg_6_2 or "Arial"
	arg_6_3 = arg_6_3 or 24
	arg_6_4 = arg_6_4 or kCCTextAlignmentCenter

	local var_6_0 = CCLabelTTF:create("", arg_6_2, arg_6_3, arg_6_1, arg_6_4)

	if alighCenter == kCCTextAlignmentCenter then
		var_6_0:setVerticalAlignment(kCCVerticalTextAlignmentCenter)
	end

	return var_6_0
end

function var_0_0.setTTFShadow(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	arg_7_1:enableShadow(arg_7_2 or CCSizeMake(2, -1), arg_7_3 or 20, arg_7_4 or 0.1)
end

function var_0_0.setTTFStroke(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if arg_8_3 then
		arg_8_1:setFontSize(arg_8_3)
	end

	if arg_8_2 then
		arg_8_1:setFontFillColor(arg_8_2, true)
	end

	local var_8_0 = arg_8_4 or TITLE_STROKE_COLOR

	arg_8_1:enableStroke(var_8_0, 1.1, true)
end

function var_0_0.setButtonStroke2(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = "font/FZY4JW--GB1-0.ttf"
	local var_9_1 = arg_9_2 or ccc3(255, 255, 255)
	local var_9_2 = arg_9_3
	local var_9_3 = true
	local var_9_4 = arg_9_4 or BTN_YELLOW_STOKE_COLOR
	local var_9_5 = 1.2
	local var_9_6 = false
	local var_9_7 = CCSizeMake(2, -3)
	local var_9_8 = 45
	local var_9_9 = 1

	arg_9_1:setTitleTTFForStateEx(CCControlStateNormal, var_9_0, var_9_1, var_9_2, var_9_3, var_9_5, var_9_4, var_9_6, var_9_7, var_9_8, var_9_9)
	arg_9_1:setTitleTTFForStateEx(CCControlStateHighlighted, var_9_0, var_9_1, var_9_2, var_9_3, var_9_5, var_9_4, var_9_6, var_9_7, var_9_8, var_9_9)
	arg_9_1:setTitleTTFForStateEx(CCControlStateDisabled, var_9_0, var_9_1, var_9_2, var_9_3, var_9_5, var_9_4, var_9_6, var_9_7, var_9_8, var_9_9)
	arg_9_1:setTitleTTFForStateEx(CCControlStateSelected, var_9_0, var_9_1, var_9_2, var_9_3, var_9_5, var_9_4, var_9_6, var_9_7, var_9_8, var_9_9)
end

function var_0_0.setButtonStroke(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
	local var_10_0 = "font/FZY4JW--GB1-0.ttf"
	local var_10_1 = arg_10_2 or ccc3(255, 255, 255)
	local var_10_2 = arg_10_3
	local var_10_3 = true
	local var_10_4 = arg_10_4 or BTN_YELLOW_STOKE_COLOR
	local var_10_5 = 1.2
	local var_10_6 = false
	local var_10_7 = CCSizeMake(2, -3)
	local var_10_8 = 45
	local var_10_9 = 1

	arg_10_1:setTitleTTFForStateEx(CCControlStateNormal, var_10_0, var_10_1, var_10_2, var_10_3, var_10_5, var_10_4, var_10_6, var_10_7, var_10_8, var_10_9)
	arg_10_1:setTitleTTFForStateEx(CCControlStateHighlighted, var_10_0, var_10_1, var_10_2, var_10_3, var_10_5, var_10_4, var_10_6, var_10_7, var_10_8, var_10_9)
	arg_10_1:setTitleTTFForStateEx(CCControlStateDisabled, var_10_0, var_10_1, var_10_2, var_10_3, var_10_5, var_10_4, var_10_6, var_10_7, var_10_8, var_10_9)
	arg_10_1:setTitleTTFForStateEx(CCControlStateSelected, var_10_0, var_10_1, var_10_2, var_10_3, var_10_5, var_10_4, var_10_6, var_10_7, var_10_8, var_10_9)

	if arg_10_5 ~= nil then
		local function var_10_10(arg_11_0)
			local var_11_0 = arg_10_1:getTitleLabelForState(arg_11_0)

			if var_11_0 ~= nil then
				var_11_0:setPosition(arg_10_5)
			end
		end

		var_10_10(CCControlStateNormal)
		var_10_10(CCControlStateHighlighted)
		var_10_10(CCControlStateDisabled)
		var_10_10(CCControlStateSelected)
	end
end

function var_0_0.PointInCtrl(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	arg_12_4 = arg_12_4 or true

	if ignoreVisible == true then
		if arg_12_1 == nil or arg_12_1:isVisible() == false or zbUtil:hasVisibleParent(arg_12_1) == false then
			return false
		end
	elseif arg_12_1 == nil or arg_12_1:getParent() == nil then
		return false
	end

	local var_12_0 = ccp(arg_12_2, arg_12_3)
	local var_12_1 = arg_12_1:getParent():convertToNodeSpace(var_12_0)

	if arg_12_1:boundingBox():containsPoint(var_12_1) then
		return true
	end

	return false
end

function var_0_0.replaceCtrl(arg_13_0, arg_13_1, arg_13_2)
	arg_13_1:getParent():addChild(arg_13_2)
	arg_13_2:setPosition(arg_13_1:getPosition())
	arg_13_2:setAnchorPoint(arg_13_1:getAnchorPoint())
	arg_13_1:removeFromParentAndCleanup(true)
end

return var_0_0
