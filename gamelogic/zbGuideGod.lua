require("gamelogic.zbGuideBase")

zbGuideGod = class("zbGuideGod", zbGuideBase)
zbGuideGod.__index = zbGuideGod

function zbGuideGod.create(arg_1_0)
	local var_1_0 = zbGuideGod.new()

	var_1_0:initBase()
	var_1_0:initMy()

	return var_1_0
end

function zbGuideGod.initMy(arg_2_0)
	return
end

function zbGuideGod.start(arg_3_0)
	arg_3_0.guildOver = false

	g_MainScene:showGuideWnd()
	g_MainScene:showGuideTalkWnd(902)
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndShowNewFunc.btnGo)
	g_MainScene.wndGuide:setTouchFunction(function()
		g_MainScene:hideGuideWnd()

		arg_3_0.hideStep = 1
	end)
end

function zbGuideGod.onCloseGodLevelUp(arg_5_0)
	g_Guide:stopCurGuideStep()

	if g_MainScene.wndGodLevelUp then
		g_MainScene.wndGodLevelUp:hide()
	end

	g_WsMsgHandler:WS_God_Upgrade_Req(2022101, 1)
end

function zbGuideGod.stop(arg_6_0)
	arg_6_0.guildOver = true
end

function zbGuideGod.update(arg_7_0, arg_7_1)
	return
end

function zbGuideGod.onGuideWndHide(arg_8_0)
	if arg_8_0.hideStep == 1 then
		if g_MainScene.wndShowNewFunc then
			g_MainScene.wndShowNewFunc:hide()
		end

		if g_MainScene.wndBalanceWin then
			g_MainScene.wndBalanceWin:hide()
		end

		g_MainScene:showGodWnd()
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndGod.btnLvUp)
		g_MainScene.wndGuide:setTouchFunction(function()
			g_MainScene:hideGuideWnd()

			arg_8_0.hideStep = 2
		end)
	elseif arg_8_0.hideStep == 2 then
		g_MainScene:showGodLevelUpWnd()
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndGodLevelUp.btnFrame[1])
		g_MainScene.wndGuide:setTouchFunction(function()
			arg_8_0:onCloseGodLevelUp()
		end)
	end
end
