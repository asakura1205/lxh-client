require("gamelogic.zbGuideBase")

zbGuideTuanShu = class("zbGuideTuanShu", zbGuideBase)
zbGuideTuanShu.__index = zbGuideTuanShu

function zbGuideTuanShu.create(arg_1_0)
	local var_1_0 = zbGuideTuanShu.new()

	var_1_0:initBase()
	var_1_0:initMy()

	return var_1_0
end

function zbGuideTuanShu.initMy(arg_2_0)
	return
end

function zbGuideTuanShu.start(arg_3_0)
	arg_3_0.guildOver = false

	g_MainScene:showGuideWnd()
	g_MainScene:showGuideTalkWnd(1108)
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndShowNewFunc.btnGo)
	g_MainScene.wndGuide:setTouchFunction(function()
		g_MainScene:hideGuideWnd()

		arg_3_0.hideStep = 1
	end)

	if g_MainScene.wndGuide.touchFunction == nil then
		g_Guide:stopCurGuideStep()
	end
end

function zbGuideTuanShu.stepNext(arg_5_0)
	g_MainScene.wndYuanZheng:onWorld()
	g_MainScene:showGuideTalkWnd(1110, function()
		arg_5_0:stepWorld()
	end)
end

function zbGuideTuanShu.stepWorld(arg_7_0)
	arg_7_0.resNode = g_MainScene.wndWorld.wordMap.mapNodeMgr.randNodelist[48]

	if arg_7_0.resNode then
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(arg_7_0.resNode.resBg)
		g_MainScene.wndGuide:setTouchFunction(function()
			arg_7_0:stepOpenTask()
		end)
	else
		g_Guide:stopCurGuideStep()
	end
end

function zbGuideTuanShu.stepOpenTask(arg_9_0)
	g_WsMsgHandler:WS_WorldSpe_Open_Req(48)
	g_Guide:stopCurGuideStep()
end

function zbGuideTuanShu.stop(arg_10_0)
	arg_10_0.guildOver = true
end

function zbGuideTuanShu.update(arg_11_0, arg_11_1)
	return
end

function zbGuideTuanShu.onGuideWndHide(arg_12_0)
	if arg_12_0.hideStep == 1 then
		if g_MainScene.wndShowNewFunc then
			g_MainScene.wndShowNewFunc:hide()
		end

		if g_MainScene.wndBalanceWin then
			g_MainScene.wndBalanceWin:hide()
		end

		g_Self.kYuanzhengHandler:openYuanzheng()
		g_MainScene:showGuideWnd()
		g_MainScene:showGuideTalkWnd(1109)
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndYuanZheng.btnTask)
		g_MainScene.wndGuide:setTouchFunction(function()
			g_MainScene:hideGuideWnd()

			arg_12_0.hideStep = 0

			arg_12_0:stepNext()
		end)
	end
end
