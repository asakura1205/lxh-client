require("gamelogic.zbLogoState")
require("gamelogic.zbLoginState")
require("gamelogic.zbMainState")
require("gamebase.zbFramework")

local var_0_0 = class("zbGameStateMachine")

var_0_0.__index = var_0_0
var_0_0.m_eState = 0
var_0_0.m_eNextState = 0
var_0_0.m_kStates = {}
var_0_0.m_freeMem = false
var_0_0.freeMemCurCount = 0
var_0_0.freeMemMaxCount = 4
var_0_0.lastTime = -1
var_0_0.accumTime = 0
var_0_0.oneSecondPassed = false
var_0_0.backgroundState = false
GameState_Invalid = 0
GameState_Logo = 1
GameState_Login = 2
GameState_Scene = 3
GameState_Max = 4

function var_0_0.RegisterState(arg_1_0, arg_1_1, arg_1_2)
	if arg_1_1 < GameState_Max and arg_1_2 ~= nil then
		arg_1_0.m_kStates[arg_1_1] = arg_1_2
	end
end

function var_0_0.SetState(arg_2_0, arg_2_1)
	if arg_2_0.m_eState == arg_2_1 then
		return
	end

	arg_2_0.m_eNextState = arg_2_1
end

function var_0_0.setStateImmediate(arg_3_0, arg_3_1)
	if arg_3_0.m_eState == arg_3_1 then
		return
	end

	arg_3_0.m_eNextState = arg_3_1

	local var_3_0 = arg_3_0.m_kStates[arg_3_0.m_eState]
	local var_3_1 = arg_3_0.m_kStates[arg_3_0.m_eNextState]

	if var_3_0 ~= nil then
		var_3_0:onExit()
	end

	if var_3_1 ~= nil then
		var_3_1:onEnter()

		arg_3_0.m_eState = arg_3_1
		arg_3_0.m_eNextState = GameState_Invalid
	end
end

function var_0_0.getCurrState(arg_4_0)
	return arg_4_0.m_kStates[arg_4_0.m_eState]
end

function var_0_0.getCurrStateId(arg_5_0)
	return arg_5_0.m_eState
end

function var_0_0.findState(arg_6_0, arg_6_1)
	if arg_6_1 < GameState_Max then
		return arg_6_0.m_kStates[arg_6_1]
	else
		return nil
	end
end

function var_0_0.freeUnusedMem(arg_7_0)
	arg_7_0.m_freeMem = true
end

function var_0_0.testFreeUnusedMem(arg_8_0)
	if arg_8_0.freeMemCurCount <= arg_8_0.freeMemMaxCount then
		arg_8_0.freeMemCurCount = arg_8_0.freeMemCurCount + 1

		return
	end

	arg_8_0.freeMemCurCount = 0
	arg_8_0.m_freeMem = true
end

function var_0_0.init(arg_9_0)
	arg_9_0:RegisterState(GameState_Logo, zbLogoState:create())
	arg_9_0:RegisterState(GameState_Login, zbLoginState:create())
	arg_9_0:RegisterState(GameState_Scene, zbMainState:create())

	function preMainLoop()
		return
	end

	function mainLoop()
		arg_9_0:update()
	end

	function postMainLoop()
		return
	end

	function directPause()
		echoInfo("directPause")
	end

	function directResume()
		echoInfo("directResume")
	end

	function appDidEnterBackground()
		arg_9_0.backgroundState = true

		echoInfo("appDidEnterBackground")
	end

	function appWillEnterForeground()
		arg_9_0.backgroundState = false

		echoInfo("appWillEnterForeground")

		if arg_9_0:getCurrStateId() == GameState_Scene and g_WsMsgHandler:isConnected() == false then
			g_WsMsgHandler:popReconnectWnd()
		end
	end

	CCLuaEngine:defaultEngine():setPreMainLoopHandler(preMainLoop)
	CCLuaEngine:defaultEngine():setMainLoopHandler(mainLoop)
	CCLuaEngine:defaultEngine():setPostMainLoopHandler(postMainLoop)
	CCLuaEngine:defaultEngine():setApplicationDidEnterBackground(appDidEnterBackground)
	CCLuaEngine:defaultEngine():setApplicationWillEnterForeground(appWillEnterForeground)

	if zbGameCore:Instance():isAutopatchEnabled() then
		arg_9_0:setStateImmediate(GameState_Login)
	else
		arg_9_0:setStateImmediate(GameState_Logo)
	end

	zbGlobalUtil:setPVRImagesHavePremultipliedAlpha(true)

	arg_9_0.lastTime = -1
	arg_9_0.backgroundState = false

	CCDirector:sharedDirector():setAnimationInterval(0.03333333333333333)
end

function var_0_0.free()
	local var_17_0 = table.getn(self.m_kStates)

	for iter_17_0 = 0, var_17_0 - 1 do
		self.m_kStates = nil
	end
end

function var_0_0.update(arg_18_0)
	if arg_18_0.backgroundState == true then
		return
	end

	local var_18_0 = os_timenow()

	if arg_18_0.lastTime == -1 then
		arg_18_0.lastTime = var_18_0
	end

	local var_18_1 = var_18_0 - arg_18_0.lastTime

	arg_18_0.lastTime = var_18_0
	arg_18_0.accumTime = arg_18_0.accumTime + var_18_1

	if arg_18_0.accumTime >= 1 then
		arg_18_0.accumTime = 0
		arg_18_0.oneSecondPassed = true
	else
		arg_18_0.oneSecondPassed = false
	end

	local var_18_2 = arg_18_0.m_kStates[arg_18_0.m_eState]
	local var_18_3 = arg_18_0.m_kStates[arg_18_0.m_eNextState]

	if var_18_3 ~= nil then
		if var_18_2 ~= nil then
			var_18_2:onExit()
		end

		if var_18_3 ~= nil then
			var_18_3:onEnter()

			var_18_2 = var_18_3
			arg_18_0.m_eState = arg_18_0.m_eNextState
			arg_18_0.m_eNextState = GameState_Invalid

			CCDirector:sharedDirector():getTouchDispatcher():setDispatchEvents(true)
		end
	end

	if var_18_2 ~= nil then
		var_18_2:onUpdate(var_18_1)
	end

	g_HttpMsgHandler:update(var_18_1)
	g_WsMsgHandler:update(var_18_1)
	g_MusicState:update(var_18_1)
	g_Audio:update(var_18_1)

	if arg_18_0.m_freeMem then
		arg_18_0.m_freeMem = false

		echoInfo("clear start " .. collectgarbage("count"))

		if arg_18_0:getCurrStateId() == GameState_Scene and g_MainScene ~= nil then
			g_MainScene:freeWnd()
		end

		clearSpinePoolAnimation()
		zbAnimCacheUtil:SharedAnimCache():FreeAnimCache()
		CCAnimationCache:purgeSharedAnimationCache()
		CCSpriteFrameCache:sharedSpriteFrameCache():removeUnusedSpriteFrames()
		CCTextureCache:sharedTextureCache():removeUnusedTextures()
		collectgarbage("collect")
		echoInfo("clear end " .. collectgarbage("count"))
	end
end

function var_0_0.isOneSecondPassed(arg_19_0)
	return arg_19_0.oneSecondPassed
end

function createStateMachine()
	local var_20_0 = var_0_0.new()

	var_20_0:init()

	return var_20_0
end
