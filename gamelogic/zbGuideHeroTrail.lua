require("gamelogic.zbGuideBase")

zbGuideHeroTrail = class("zbGuideHeroTrail", zbGuideBase)
zbGuideHeroTrail.__index = zbGuideHeroTrail

function zbGuideHeroTrail.create(arg_1_0)
	local var_1_0 = zbGuideHeroTrail.new()

	var_1_0:initBase()
	var_1_0:initMy()

	return var_1_0
end

function zbGuideHeroTrail.initMy(arg_2_0)
	return
end

function zbGuideHeroTrail.start(arg_3_0)
	arg_3_0.guildOver = false

	g_MainScene:showGuideWnd()
	g_MainScene:showGuideTalkWnd(1102)
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndShowNewFunc.btnGo)
	g_MainScene.wndGuide:setTouchFunction(function()
		arg_3_0:openHeroTrial()
	end)
end

function zbGuideHeroTrail.openHeroTrial(arg_5_0)
	if g_MainScene.wndShowNewFunc then
		g_MainScene.wndShowNewFunc:hide()
	end

	if g_MainScene.wndBalanceWin then
		g_MainScene.wndBalanceWin:hide()
	end

	g_MainScene:hideGuideWnd()
	g_MainScene:showHeroTrialWnd()
	g_Guide:stopCurGuideStep()
end

function zbGuideHeroTrail.stop(arg_6_0)
	arg_6_0.guildOver = true
end

function zbGuideHeroTrail.update(arg_7_0, arg_7_1)
	return
end
