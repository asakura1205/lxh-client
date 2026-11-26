require("gamebase.zbFramework")
require("gamelogic.zbLogoScene")

zbLogoState = class("zbLogoState")
zbLogoState.__index = zbLogoState

function zbLogoState.create(arg_1_0)
	return (zbLogoState.new())
end

function zbLogoState.onEnter(arg_2_0)
	g_LogoScene = createLogoScene()

	display.replaceScene(g_LogoScene, "fade", 0.6, display.COLOR_WHITE)
end

function zbLogoState.onExit(arg_3_0)
	g_LogoScene:free()

	g_LogoScene = nil
end

function zbLogoState.onUpdate(arg_4_0, arg_4_1)
	return
end
