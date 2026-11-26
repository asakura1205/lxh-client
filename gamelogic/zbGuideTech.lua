require("gamelogic.zbGuideBase")

zbGuideTech = class("zbGuideTech", zbGuideBase)
zbGuideTech.__index = zbGuideTech

function zbGuideTech.create(arg_1_0)
	local var_1_0 = zbGuideTech.new()

	var_1_0:initBase()
	var_1_0:initMy()

	return var_1_0
end

function zbGuideTech.initMy(arg_2_0)
	return
end

function zbGuideTech.start(arg_3_0)
	arg_3_0.guildOver = false

	g_MainScene:showGuideWnd()
	g_MainScene:showGuideTalkWnd(1103)
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndShowNewFunc.btnGo)
	g_MainScene.wndGuide:setTouchFunction(function()
		g_MainScene:hideGuideWnd()

		arg_3_0.hideStep = 1
	end)
end

function zbGuideTech.stepNext(arg_5_0)
	g_Guide:stopCurGuideStep()

	if g_MainScene.wndTech ~= nil then
		g_MainScene.wndTech.techItemDetail:onLevelUp()
	end
end

function zbGuideTech.stop(arg_6_0)
	arg_6_0.guildOver = true
end

function zbGuideTech.update(arg_7_0, arg_7_1)
	return
end

function zbGuideTech.onGuideWndHide(arg_8_0)
	if arg_8_0.hideStep == 1 then
		if g_MainScene.wndShowNewFunc then
			g_MainScene.wndShowNewFunc:hide()
		end

		if g_MainScene.wndBalanceWin then
			g_MainScene.wndBalanceWin:hide()
		end

		g_MainScene:showTechWnd()
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndTech.techItemDetail.btnUp, g_MainScene.wndTech)
		g_MainScene.wndGuide:setTouchFunction(function()
			arg_8_0:stepNext()
		end)
	end
end
