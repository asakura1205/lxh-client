require("gamelogic.zbGuideBase")

zbGuideArena = class("zbGuideArena", zbGuideBase)
zbGuideArena.__index = zbGuideArena

function zbGuideArena.create(arg_1_0)
	local var_1_0 = zbGuideArena.new()

	var_1_0:initBase()
	var_1_0:initMy()

	return var_1_0
end

function zbGuideArena.initMy(arg_2_0)
	return
end

function zbGuideArena.start(arg_3_0)
	arg_3_0.guildOver = false

	g_MainScene:showGuideWnd()
	g_MainScene:showGuideTalkWnd(1107)
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndShowNewFunc.btnGo)
	g_MainScene.wndGuide:setTouchFunction(function()
		g_MainScene:hideGuideWnd()

		arg_3_0.hideStep = 1
	end)
end

function zbGuideArena.startFight(arg_5_0)
	g_Guide:stopCurGuideStep()
	g_MainScene.wndEmbattle:onFight()
end

function zbGuideArena.stop(arg_6_0)
	arg_6_0.guildOver = true
end

function zbGuideArena.update(arg_7_0, arg_7_1)
	return
end

function zbGuideArena.onGuideWndHide(arg_8_0)
	if arg_8_0.hideStep == 1 then
		if g_MainScene.wndShowNewFunc then
			g_MainScene.wndShowNewFunc:hide()
		end

		if g_MainScene.wndBalanceWin then
			g_MainScene.wndBalanceWin:hide()
		end

		g_MainScene:showArenaWnd()
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndArena.playerItems[1].btnFight, g_MainScene.wndArena)
		g_MainScene.wndGuide:setTouchFunction(function()
			g_MainScene:hideGuideWnd()

			arg_8_0.hideStep = 2
		end)
	elseif arg_8_0.hideStep == 2 then
		g_MainScene.wndArena.playerItems[1]:onFight()
		g_MainScene:showGuideWnd()

		if g_MainScene.wndArenaPlayer == nil then
			g_Guide:stopCurGuideStep()

			return
		end

		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndArenaPlayer.btnFight)
		g_MainScene.wndGuide:setTouchFunction(function()
			g_MainScene:hideGuideWnd()

			arg_8_0.hideStep = 3
		end)

		local var_8_0 = g_Self.kArenaHandler.ArenaCombatInfo

		if var_8_0 == nil or var_8_0.CombatCount >= var_8_0.MaxCombatCount then
			g_Guide:stopCurGuideStep()
		end
	elseif arg_8_0.hideStep == 3 then
		g_MainScene.wndArenaPlayer:onFight()
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndEmbattle.btnFight)
		g_MainScene.wndGuide:setTouchFunction(function()
			arg_8_0:startFight()
		end)
	end
end
