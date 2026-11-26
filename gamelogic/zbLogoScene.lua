require("gamelogic.zbLogoWnd")

local var_0_0 = class("zbLogoScene", function()
	return display.newScene("zbLogoScene")
end)

var_0_0.__index = var_0_0

function var_0_0.init(arg_2_0)
	arg_2_0.wndLogo = nil

	arg_2_0:showLogo()
	arg_2_0:addUpDownBorder()

	local function var_2_0()
		if arg_2_0.wndLogo:isFadeOver() then
			g_GameStateMachine:setStateImmediate(GameState_Login)
			arg_2_0.nodeFrame:unscheduleUpdate()
		end
	end

	arg_2_0.nodeFrame = CCNode:create()

	arg_2_0:addChild(arg_2_0.nodeFrame)
	arg_2_0.nodeFrame:scheduleUpdateWithPriorityLua(var_2_0, 0)
end

function var_0_0.free(arg_4_0)
	zbUtil:freeWnd(arg_4_0.wndLogo)

	arg_4_0.wndLogo = nil
end

function var_0_0.update(arg_5_0)
	return
end

function var_0_0.showLogo(arg_6_0)
	if arg_6_0.wndLogo == nil then
		arg_6_0.wndLogo = createLogoWnd()

		arg_6_0.wndLogo:retain()
	end

	arg_6_0.wndLogo:show(arg_6_0)
end

function createLogoScene()
	local var_7_0 = var_0_0.new()

	var_7_0:init()

	return var_7_0
end
