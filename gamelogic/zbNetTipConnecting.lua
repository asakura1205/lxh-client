local var_0_0 = class("zbNetTipConnecting", CCNodeExtend)

var_0_0.__index = var_0_0

function createNetTipConnecting()
	local var_1_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_1_0:init()

	return var_1_0
end

function var_0_0.extend(arg_2_0)
	local var_2_0 = tolua.getpeer(arg_2_0)

	if not var_2_0 then
		var_2_0 = {}

		tolua.setpeer(arg_2_0, var_2_0)
	end

	setmetatable(var_2_0, var_0_0)

	return arg_2_0
end

function var_0_0.init(arg_3_0)
	arg_3_0.m_wnd = CCLayerColor:create(ccc4(75, 75, 75, 0))

	arg_3_0.m_wnd:retain()

	local var_3_0 = CCDirector:sharedDirector():getWinSize()

	arg_3_0.m_sprite = CCSprite:create("image/common/loading.png")

	arg_3_0.m_sprite:setAnchorPoint(ccp(0.5, 0.5))
	arg_3_0.m_sprite:setPosition(var_3_0.width / 2, var_3_0.height / 2)

	local var_3_1 = var_3_0.width / 1136

	arg_3_0.m_sprite:setScaleX(var_3_1)
	arg_3_0.m_sprite:setScaleY(var_3_1)
	arg_3_0.m_wnd:addChild(arg_3_0.m_sprite)
	arg_3_0:addChild(arg_3_0.m_wnd)

	arg_3_0.lastTime = os_timenow()
	arg_3_0.isResponsed = false
end

function var_0_0.free(arg_4_0)
	return
end

function var_0_0.isShow(arg_5_0)
	if arg_5_0.m_wnd:getParent() ~= nil then
		return true
	else
		return false
	end
end

function var_0_0.getRunningSceneByState(arg_6_0)
	if g_GameStateMachine:getCurrStateId() == GameState_Login then
		return g_LoginScene
	elseif g_GameStateMachine:getCurrStateId() == GameState_Login then
		return g_MainScene
	end

	return CCDirector:sharedDirector():getRunningScene()
end

function var_0_0.show(arg_7_0)
	arg_7_0.lastTime = os_timenow()
	arg_7_0.isResponsed = false

	if arg_7_0:getRunningSceneByState() then
		arg_7_0.m_wnd:removeFromParentAndCleanup(false)
		arg_7_0:getRunningSceneByState():addChild(arg_7_0.m_wnd)

		local function var_7_0()
			local var_8_0 = CCRotateBy:create(1, -360)

			arg_7_0.m_sprite:setVisible(true)
			arg_7_0.m_sprite:runAction(CCRepeatForever:create(var_8_0))
		end

		arg_7_0.m_sprite:setVisible(false)

		local var_7_1 = CCArray:create()

		if zbGlobalUtil:getTargetPlatform() == "ios" or zbGlobalUtil:getTargetPlatform() == "android" then
			var_7_1:addObject(CCDelayTime:create(1))
		end

		var_7_1:addObject(CCCallFuncN:create(var_7_0))
		arg_7_0.m_sprite:runAction(CCSequence:create(var_7_1))
		CCDirector:sharedDirector():getTouchDispatcher():setDispatchEvents(false)
	end
end

function var_0_0.hide(arg_9_0)
	arg_9_0.m_sprite:stopAllActions()
	arg_9_0.m_wnd:removeFromParentAndCleanup(false)

	if arg_9_0.isResponsed == false then
		g_Bubble:bubbleInfo(a2u("\xB7\xFE\xCE\xF1\xC6\xF7\xC1\xAC\xBD\xD3ʧ\xB0\xDC"))
	end

	CCDirector:sharedDirector():getTouchDispatcher():setDispatchEvents(true)
end

function var_0_0.update(arg_10_0)
	if arg_10_0:isShow() then
		CCDirector:sharedDirector():getTouchDispatcher():setDispatchEvents(false)

		if os_timenow() - arg_10_0.lastTime > NET_TIMEOUT then
			arg_10_0:hide()

			arg_10_0.lastTime = os_timenow()
		end
	end
end

function var_0_0.setResponsed(arg_11_0, arg_11_1)
	arg_11_0.isResponsed = arg_11_1
end
