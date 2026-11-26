require("gamebase.zbFramework")
require("gamecore.zbSelfRole")
require("gamelogic.zbMainScene")
require("gamelogic.zbGuide")
require("gamecore.zbCombatSystem")
require("gamecore.zbPushCenter")

zbMainState = class("zbMainState")
zbMainState.__index = zbMainState

function zbMainState.create(arg_1_0)
	return (zbMainState.new())
end

function zbMainState.onEnter(arg_2_0)
	echoInfo("zbMainState.onEnter")
	g_GameStateMachine:freeUnusedMem()

	g_Self = createSelfRole()
	g_CombatSystem = createCombatSystem()
	g_PushCenter = createPushCenter()
	g_Guide = createGuide()
	g_MainScene = zbMainScene:create()

	g_MainScene:showLoadingWnd()
	display.replaceScene(g_MainScene)
end

function zbMainState.onExit(arg_3_0)
	g_MainScene:free()

	g_MainScene = nil

	g_Guide:free()

	g_Guide = nil

	g_PushCenter:free()

	g_PushCenter = nil

	g_Self:free()
	g_GameStateMachine:freeUnusedMem()
end

function zbMainState.onUpdate(arg_4_0, arg_4_1)
	g_Self:update(arg_4_1)
	g_MainScene:update(arg_4_1)
	g_Guide:update(arg_4_1)
end
