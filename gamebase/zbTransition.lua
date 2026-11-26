local var_0_0 = {}
local var_0_1 = {
	BACKIN = {
		CCEaseBackIn,
		1
	},
	BACKINOUT = {
		CCEaseBackInOut,
		1
	},
	BACKOUT = {
		CCEaseBackOut,
		1
	},
	BOUNCE = {
		CCEaseBounce,
		1
	},
	BOUNCEIN = {
		CCEaseBounceIn,
		1
	},
	BOUNCEINOUT = {
		CCEaseBounceInOut,
		1
	},
	BOUNCEOUT = {
		CCEaseBounceOut,
		1
	},
	ELASTIC = {
		CCEaseElastic,
		2,
		0.3
	},
	ELASTICIN = {
		CCEaseElasticIn,
		2,
		0.3
	},
	ELASTICINOUT = {
		CCEaseElasticInOut,
		2,
		0.3
	},
	ELASTICOUT = {
		CCEaseElasticOut,
		2,
		0.3
	},
	EXPONENTIALIN = {
		CCEaseExponentialIn,
		1
	},
	EXPONENTIALINOUT = {
		CCEaseExponentialInOut,
		1
	},
	EXPONENTIALOUT = {
		CCEaseExponentialOut,
		1
	},
	IN = {
		CCEaseIn,
		2,
		1
	},
	INOUT = {
		CCEaseInOut,
		2,
		1
	},
	OUT = {
		CCEaseOut,
		2,
		1
	},
	RATEACTION = {
		CCEaseRateAction,
		2,
		1
	},
	SINEIN = {
		CCEaseSineIn,
		1
	},
	SINEINOUT = {
		CCEaseSineInOut,
		1
	},
	SINEOUT = {
		CCEaseSineOut,
		1
	}
}
local var_0_2 = CCDirector:sharedDirector():getActionManager()

local function var_0_3(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = string.upper(tostring(arg_1_1))

	if string.sub(var_1_0, 1, 6) == "CCEASE" then
		var_1_0 = string.sub(var_1_0, 7)
	end

	local var_1_1

	if var_0_1[var_1_0] then
		local var_1_2, var_1_3, var_1_4 = unpack(var_0_1[var_1_0])

		if var_1_3 == 2 then
			var_1_1 = var_1_2:create(arg_1_0, arg_1_2 or var_1_4)
		else
			var_1_1 = var_1_2:create(arg_1_0)
		end
	end

	return var_1_1 or arg_1_0
end

function var_0_0.execute(arg_2_0, arg_2_1, arg_2_2)
	assert(not tolua.isnull(arg_2_0), "transition.execute() - target is not CCNode")

	arg_2_2 = totable(arg_2_2)

	if arg_2_2.easing then
		if type(arg_2_2.easing) == "table" then
			arg_2_1 = var_0_3(arg_2_1, unpack(arg_2_2.easing))
		else
			arg_2_1 = var_0_3(arg_2_1, arg_2_2.easing)
		end
	end

	local var_2_0 = {}
	local var_2_1 = tonumber(arg_2_2.delay)

	if var_2_1 > 0 then
		var_2_0[#var_2_0 + 1] = CCDelayTime:create(var_2_1)
	end

	var_2_0[#var_2_0 + 1] = arg_2_1

	local var_2_2 = arg_2_2.onComplete

	if type(var_2_2) ~= "function" then
		var_2_2 = nil
	end

	if var_2_2 then
		var_2_0[#var_2_0 + 1] = CCCallFunc:create(var_2_2)
	end

	if #var_2_0 > 1 then
		arg_2_1 = var_0_0.sequence(var_2_0)

		arg_2_0:runAction(arg_2_1)
	else
		arg_2_0:runAction(var_2_0[1])
	end

	return arg_2_1
end

function var_0_0.rotateTo(arg_3_0, arg_3_1)
	assert(not tolua.isnull(arg_3_0), "transition.rotateTo() - target is not CCNode")

	local var_3_0 = CCRotateTo:create(arg_3_1.time, arg_3_1.rotate)

	return var_0_0.execute(arg_3_0, var_3_0, arg_3_1)
end

function var_0_0.moveTo(arg_4_0, arg_4_1)
	assert(not tolua.isnull(arg_4_0), "transition.moveTo() - target is not CCNode")

	local var_4_0, var_4_1 = arg_4_0:getPosition()
	local var_4_2 = arg_4_1.x or var_4_0
	local var_4_3 = arg_4_1.y or var_4_1
	local var_4_4 = CCMoveTo:create(arg_4_1.time, ccp(var_4_2, var_4_3))

	return var_0_0.execute(arg_4_0, var_4_4, arg_4_1)
end

function var_0_0.moveBy(arg_5_0, arg_5_1)
	assert(not tolua.isnull(arg_5_0), "transition.moveBy() - target is not CCNode")

	local var_5_0 = arg_5_1.x or 0
	local var_5_1 = arg_5_1.y or 0
	local var_5_2 = CCMoveBy:create(arg_5_1.time, ccp(var_5_0, var_5_1))

	return var_0_0.execute(arg_5_0, var_5_2, arg_5_1)
end

function var_0_0.fadeIn(arg_6_0, arg_6_1)
	assert(not tolua.isnull(arg_6_0), "transition.fadeIn() - target is not CCNode")

	local var_6_0 = CCFadeIn:create(arg_6_1.time)

	arg_6_0:setOpacity(0)

	return var_0_0.execute(arg_6_0, var_6_0, arg_6_1)
end

function var_0_0.fadeOut(arg_7_0, arg_7_1)
	assert(not tolua.isnull(arg_7_0), "transition.fadeOut() - target is not CCNode")

	local var_7_0 = CCFadeOut:create(arg_7_1.time)

	arg_7_0:setOpacity(255)

	return var_0_0.execute(arg_7_0, var_7_0, arg_7_1)
end

function var_0_0.fadeTo(arg_8_0, arg_8_1)
	assert(not tolua.isnull(arg_8_0), "transition.fadeTo() - target is not CCNode")

	local var_8_0 = toint(arg_8_1.opacity)

	if var_8_0 < 0 then
		var_8_0 = 0
	elseif var_8_0 > 255 then
		var_8_0 = 255
	end

	local var_8_1 = CCFadeTo:create(arg_8_1.time, var_8_0)

	return var_0_0.execute(arg_8_0, var_8_1, arg_8_1)
end

function var_0_0.scaleTo(arg_9_0, arg_9_1)
	assert(not tolua.isnull(arg_9_0), "transition.scaleTo() - target is not CCNode")

	local var_9_0

	if arg_9_1.scale then
		var_9_0 = CCScaleTo:create(tonumber(arg_9_1.time), tonumber(arg_9_1.scale))
	elseif arg_9_1.scaleX or arg_9_1.scaleY then
		local var_9_1
		local var_9_2

		if arg_9_1.scaleX then
			var_9_1 = tonumber(arg_9_1.scaleX)
		else
			var_9_1 = arg_9_0:getScaleX()
		end

		if arg_9_1.scaleY then
			var_9_2 = tonumber(arg_9_1.scaleY)
		else
			var_9_2 = arg_9_0:getScaleY()
		end

		var_9_0 = CCScaleTo:create(tonumber(arg_9_1.time), var_9_1, var_9_2)
	end

	return var_0_0.execute(arg_9_0, var_9_0, arg_9_1)
end

function var_0_0.sequence(arg_10_0)
	if #arg_10_0 < 1 then
		return
	end

	if #arg_10_0 < 2 then
		return arg_10_0[1]
	end

	local var_10_0 = arg_10_0[1]

	for iter_10_0 = 2, #arg_10_0 do
		var_10_0 = CCSequence:createWithTwoActions(var_10_0, arg_10_0[iter_10_0])
	end

	return var_10_0
end

function var_0_0.playAnimationOnce(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0 = {}

	if type(arg_11_4) == "number" and arg_11_4 > 0 then
		arg_11_0:setVisible(false)

		var_11_0[#var_11_0 + 1] = CCDelayTime:create(arg_11_4)
		var_11_0[#var_11_0 + 1] = CCShow:create()
	end

	var_11_0[#var_11_0 + 1] = display.newAnimate(arg_11_1)

	if arg_11_2 then
		var_11_0[#var_11_0 + 1] = CCRemoveSelf:create()
	end

	if arg_11_3 then
		var_11_0[#var_11_0 + 1] = CCCallFunc:create(arg_11_3)
	end

	local var_11_1

	if #var_11_0 > 1 then
		var_11_1 = var_0_0.sequence(var_11_0)
	else
		var_11_1 = var_11_0[1]
	end

	arg_11_0:runAction(var_11_1)

	return var_11_1
end

function var_0_0.playAnimationForever(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = display.newAnimate(arg_12_1)
	local var_12_1

	if type(arg_12_2) == "number" and arg_12_2 > 0 then
		arg_12_0:setVisible(false)

		local var_12_2 = var_0_0.sequence({
			CCDelayTime:create(arg_12_2),
			CCShow:create(),
			var_12_0
		})

		var_12_1 = CCRepeatForever:create(var_12_2)
	else
		var_12_1 = CCRepeatForever:create(var_12_0)
	end

	arg_12_0:runAction(var_12_1)

	return var_12_1
end

function var_0_0.removeAction(arg_13_0)
	if not tolua.isnull(arg_13_0) then
		var_0_2:removeAction(arg_13_0)
	end
end

function var_0_0.stopTarget(arg_14_0)
	if not tolua.isnull(arg_14_0) then
		var_0_2:removeAllActionsFromTarget(arg_14_0)
	end
end

function var_0_0.pauseTarget(arg_15_0)
	if not tolua.isnull(arg_15_0) then
		var_0_2:pauseTarget(arg_15_0)
	end
end

function var_0_0.resumeTarget(arg_16_0)
	if not tolua.isnull(arg_16_0) then
		var_0_2:resumeTarget(arg_16_0)
	end
end

return var_0_0
