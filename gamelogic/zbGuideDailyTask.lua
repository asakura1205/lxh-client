require("gamelogic.zbGuideBase")

zbGuideDailyTask = class("zbGuideDailyTask", zbGuideBase)
zbGuideDailyTask.__index = zbGuideDailyTask

function zbGuideDailyTask.create(arg_1_0)
	local var_1_0 = zbGuideDailyTask.new()

	var_1_0:initBase()
	var_1_0:initMy()

	return var_1_0
end

function zbGuideDailyTask.initMy(arg_2_0)
	return
end

function zbGuideDailyTask.start(arg_3_0)
	arg_3_0.guildOver = false

	g_MainScene:showGuideWnd()
	g_MainScene:showGuideTalkWnd(1101)
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndShowNewFunc.btnGo)
	g_MainScene.wndGuide:setTouchFunction(function()
		g_MainScene:hideGuideWnd()

		arg_3_0.hideStep = 1
	end)
end

function zbGuideDailyTask.closeMainTask(arg_5_0)
	g_WsMsgHandler:WS_DailyTask_Complete_Req(EDailyTaskType.DailyAward)
	g_Guide:stopCurGuideStep()
end

function zbGuideDailyTask.stop(arg_6_0)
	arg_6_0.guildOver = true
end

function zbGuideDailyTask.update(arg_7_0, arg_7_1)
	return
end

function zbGuideDailyTask.onGuideWndHide(arg_8_0)
	if arg_8_0.hideStep == 1 then
		if g_MainScene.wndShowNewFunc then
			g_MainScene.wndShowNewFunc:hide()
		end

		if g_MainScene.wndBalanceWin then
			g_MainScene.wndBalanceWin:hide()
		end

		g_MainScene:showTaskWnd(ETaskType.Daily)
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndTask.module[ETaskType.Daily].items[1].btnGetAward, g_MainScene.wndTask)
		g_MainScene.wndGuide:setTouchFunction(function()
			arg_8_0:closeMainTask()
		end)
	end
end
