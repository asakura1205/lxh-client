CCNodeExtend = class("CCNodeExtend")
CCNodeExtend.__index = CCNodeExtend

function CCNodeExtend.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, CCNodeExtend)

	return arg_1_0
end

function CCNodeExtend.align(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0:setAnchorPoint(display.ANCHOR_POINTS[arg_2_1])

	if arg_2_2 and arg_2_3 then
		arg_2_0:setPosition(arg_2_2, arg_2_3)
	end
end

function CCNodeExtend.pixels(arg_3_0, arg_3_1, arg_3_2)
	if not arg_3_1 or not arg_3_2 then
		arg_3_1, arg_3_2 = arg_3_0:getPosition()
	end

	arg_3_1, arg_3_2 = display.pixels(arg_3_1, arg_3_2)

	arg_3_0:setPosition(arg_3_1, arg_3_2)
end

function CCNodeExtend.removeFromParentAndCleanup(arg_4_0, arg_4_1)
	if not tolua.isnull(arg_4_0) then
		if type(arg_4_1) ~= "boolean" then
			arg_4_1 = true
		end

		CCNode.removeFromParentAndCleanup(arg_4_0, arg_4_1)
	end
end

function CCNodeExtend.removeSelf(arg_5_0, arg_5_1)
	arg_5_0:removeFromParentAndCleanup(arg_5_1)
end

function CCNodeExtend.addChild(arg_6_0, arg_6_1)
	if arg_6_1 then
		CCNode.addChild(arg_6_0, arg_6_1)
	end
end

function CCNodeExtend.scheduleUpdate(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0:scheduleUpdateWithPriorityLua(arg_7_1, toint(arg_7_2))
end

function CCNodeExtend.schedule(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = transition.sequence({
		CCDelayTime:create(arg_8_2),
		CCCallFunc:create(arg_8_1)
	})
	local var_8_1 = CCRepeatForever:create(var_8_0)

	arg_8_0:runAction(var_8_1)

	return var_8_1
end

function CCNodeExtend.performWithDelay(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = transition.sequence({
		CCDelayTime:create(arg_9_2),
		CCCallFunc:create(arg_9_1)
	})

	arg_9_0:runAction(var_9_0)

	return var_9_0
end

local var_0_0 = CCDirector:sharedDirector():getActionManager()

function CCNodeExtend.removeAction(arg_10_0, arg_10_1)
	if not tolua.isnull(arg_10_1) then
		var_0_0:removeAction(arg_10_1)
	end
end

function CCNodeExtend.stopAllActions(arg_11_0)
	if not tolua.isnull(arg_11_0) then
		var_0_0:removeAllActionsFromTarget(arg_11_0)
	end
end

function CCNodeExtend.onEnter(arg_12_0)
	return
end

function CCNodeExtend.onExit(arg_13_0)
	return
end

function CCNodeExtend.onEnterTransitionFinish(arg_14_0)
	return
end

function CCNodeExtend.onExitTransitionStart(arg_15_0)
	return
end

function CCNodeExtend.onCleanup(arg_16_0)
	return
end

function CCNodeExtend.registerNodeEvent(arg_17_0, arg_17_1)
	arg_17_1 = arg_17_1 or function(arg_18_0)
		if arg_18_0 == "enter" then
			arg_17_0:onEnter()
		elseif arg_18_0 == "exit" then
			arg_17_0:onExit()
		elseif arg_18_0 == "enterTransitionFinish" then
			arg_17_0:onEnterTransitionFinish()
		elseif arg_18_0 == "exitTransitionStart" then
			arg_17_0:onExitTransitionStart()
		elseif arg_18_0 == "cleanup" then
			arg_17_0:onCleanup()
		end
	end

	arg_17_0:registerScriptHandler(arg_17_1)
end

function CCNodeExtend.unregisterNodeEvent(arg_19_0)
	arg_19_0:unregisterScriptHandler()
end
