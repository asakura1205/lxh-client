require("gamelogic.zbGuideBase")

zbGuideLevel006 = class("zbGuideLevel006", zbGuideBase)
zbGuideLevel006.__index = zbGuideLevel006

function zbGuideLevel006.create(arg_1_0)
	local var_1_0 = zbGuideLevel006.new()

	var_1_0:initBase()
	var_1_0:initMy()

	return var_1_0
end

function zbGuideLevel006.initMy(arg_2_0)
	arg_2_0.starGuide = false
end

function zbGuideLevel006.start(arg_3_0)
	arg_3_0.guildOver = false
	arg_3_0.starGuide = true

	g_CombatSystem:pause()
	g_MainScene:showGuideTalkWnd(1001, function()
		arg_3_0:stepMuilt()
	end)
end

function zbGuideLevel006.stepMuilt(arg_5_0)
	g_MainScene:showGuideWnd()
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndCombat.btnMuilt)
	g_MainScene.wndGuide:setTouchFunction(function()
		arg_5_0:stepNext()
	end)
end

function zbGuideLevel006.stepNext(arg_7_0)
	g_MainScene:hideGuideWnd()
	g_MainScene.wndCombat:onSpeed()
	g_MainScene:showGuideTalkWnd(1002, function()
		arg_7_0:stepAuto()
	end)
end

function zbGuideLevel006.stepAuto(arg_9_0)
	g_MainScene:showGuideWnd()
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndCombat.btnAuto)
	g_MainScene.wndGuide:setTouchFunction(function()
		arg_9_0:closeGuide()
	end)
end

function zbGuideLevel006.closeGuide(arg_11_0)
	g_MainScene.wndCombat:onAuto()

	local var_11_0 = "GuideAuto_" .. g_GameData.BaseInfo.PlayerId

	zbGameCore:Instance():setConfigValue(var_11_0, 1)
	g_Guide:stopCurGuideStep()
	g_MainScene:hideGuideWnd()
	g_CombatSystem:resume()
end

function zbGuideLevel006.stop(arg_12_0)
	arg_12_0.guildOver = true
end

function zbGuideLevel006.update(arg_13_0, arg_13_1)
	return
end
