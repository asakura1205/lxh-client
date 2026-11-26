require("gamebase.zbFramework")
require("gamelogic.zbLoginScene")

zbLoginState = class("zbLoginState")
zbLoginState.__index = zbLoginState

function zbLoginState.create(arg_1_0)
	return (zbLoginState.new())
end

function zbLoginState.onEnter(arg_2_0)
	g_LoginScene = createLoginScene()

	display.replaceScene(g_LoginScene, "fade", 0.6, display.COLOR_WHITE)
end

function zbLoginState.onExit(arg_3_0)
	g_LoginScene:free()
end

function zbLoginState.onUpdate(arg_4_0, arg_4_1)
	g_LoginScene:update(arg_4_1)
end
