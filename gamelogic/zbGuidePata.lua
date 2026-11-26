require("gamelogic.zbGuideBase")

zbGuidePata = class("zbGuidePata", zbGuideBase)
zbGuidePata.__index = zbGuidePata

function zbGuidePata.create(arg_1_0)
	local var_1_0 = zbGuidePata.new()

	var_1_0:initBase()
	var_1_0:initMy()

	return var_1_0
end

function zbGuidePata.initMy(arg_2_0)
	return
end

function zbGuidePata.start(arg_3_0)
	arg_3_0.guildOver = false

	g_MainScene:showGuideWnd()
	g_MainScene:showGuideTalkWnd(1111)
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndShowNewFunc.btnGo)
	g_MainScene.wndGuide:setTouchFunction(function()
		g_MainScene:hideGuideWnd()

		arg_3_0.hideStep = 1
	end)
end

function zbGuidePata.startFight(arg_5_0)
	g_Guide:stopCurGuideStep()
	g_MainScene.wndPata:onFight()
end

function zbGuidePata.stop(arg_6_0)
	arg_6_0.guildOver = true
end

function zbGuidePata.update(arg_7_0, arg_7_1)
	return
end

function zbGuidePata.onGuideWndHide(arg_8_0)
	if arg_8_0.hideStep == 1 then
		if g_MainScene.wndShowNewFunc then
			g_MainScene.wndShowNewFunc:hide()
		end

		if g_MainScene.wndBalanceWin then
			g_MainScene.wndBalanceWin:hide()
		end

		g_Self.kPataHandler:openPata()
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndPata.btnGoOn)
		g_MainScene.wndGuide:setTouchFunction(function()
			arg_8_0:startFight()
		end)
	end
end
