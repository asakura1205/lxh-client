require("gamelogic.zbGuideBase")

zbGuideLevel005 = class("zbGuideLevel005", zbGuideBase)
zbGuideLevel005.__index = zbGuideLevel005

function zbGuideLevel005.create(arg_1_0)
	local var_1_0 = zbGuideLevel005.new()

	var_1_0:initBase()
	var_1_0:initMy()

	return var_1_0
end

function zbGuideLevel005.initMy(arg_2_0)
	arg_2_0.starGuide = false
	arg_2_0.starBalance = false
end

function zbGuideLevel005.start(arg_3_0)
	arg_3_0.guildOver = false
	arg_3_0.starGuide = true
	arg_3_0.getNum = 1
	arg_3_0.starBalance = true
	arg_3_0.taskId = {
		300001,
		210103,
		210106
	}
end

function zbGuideLevel005.startGuide(arg_4_0)
	local var_4_0 = false

	for iter_4_0, iter_4_1 in pairs(g_GameData.MainTask) do
		if iter_4_1.TaskType == EMainTaskType.RoleLevel and iter_4_1.State == 1 then
			if g_MainScene.wndWarForce and g_MainScene.wndWarForce.isShow then
				arg_4_0:stepMainTask_1()
			else
				arg_4_0:stepMainTask_2()
			end

			var_4_0 = true

			break
		end
	end

	if var_4_0 == false then
		arg_4_0.guildOver = true
	end
end

function zbGuideLevel005.stepMainTask_1(arg_5_0)
	g_MainScene:showGuideWnd()
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndWarForce.moneyPanel.btnClose)
	g_MainScene.wndGuide:setTouchFunction(function()
		arg_5_0:stepMainTask_2()
	end)
end

function zbGuideLevel005.stepMainTask_2(arg_7_0)
	if g_MainScene.wndWarForce then
		g_MainScene.wndWarForce:hide()
	end

	g_MainScene:showGuideWnd()
	g_MainScene:showGuideTalkWnd(901)
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndMain.mainMenu.menuTask)
	g_MainScene.wndGuide:setTouchFunction(function()
		g_MainScene:hideGuideWnd()

		arg_7_0.hideStep = 1
	end)
end

function zbGuideLevel005.closeMainTask(arg_9_0)
	g_WsMsgHandler:WS_MainTask_Award_Req(arg_9_0.taskId[arg_9_0.getNum])
	g_MainScene:showGuideWnd()

	arg_9_0.getNum = arg_9_0.getNum + 1

	if arg_9_0.getNum > 3 then
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndTask.moneyPanel.btnClose)
		g_MainScene.wndGuide:setTouchFunction(function()
			arg_9_0:stepGod()
		end)
	else
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndTask.module[ETaskType.Success].items[1].btnGetAward, g_MainScene.wndTask)
		g_MainScene.wndGuide:setTouchFunction(function()
			arg_9_0:closeMainTask()
		end)
	end
end

function zbGuideLevel005.stepGod(arg_12_0)
	if g_MainScene.wndTask then
		g_MainScene.wndTask:hide()
	end

	g_MainScene:showGuideWnd()
	g_MainScene:showGuideTalkWnd(902)
	g_MainScene.wndMain.mainScene:rotateScene(buildingConfig[EBuildingType.God].rotate)

	local var_12_0 = g_MainScene.wndMain.mainScene.buildingHandler:getBuldNode(EBuildingType.God)

	g_MainScene.wndGuide:setFingerPosition(var_12_0)
	g_MainScene.wndGuide:setTouchFunction(function()
		g_MainScene:hideGuideWnd()

		arg_12_0.hideStep = 2
	end)
end

function zbGuideLevel005.onCloseGodLevelUp(arg_14_0)
	if g_MainScene.wndGodLevelUp then
		g_MainScene.wndGodLevelUp:hide()
	end

	g_WsMsgHandler:WS_God_Upgrade_Req(2022101, 1)
	g_MainScene:showGuideWnd()
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndGod.moneyPanel.btnClose)
	g_MainScene.wndGuide:setTouchFunction(function()
		arg_14_0:stepFarm()
	end)
end

function zbGuideLevel005.stepFarm(arg_16_0)
	if g_MainScene.wndGod then
		g_MainScene.wndGod:hide()
	end

	g_MainScene:showGuideWnd()
	g_MainScene:showGuideTalkWnd(903)
	g_MainScene.wndMain.mainScene:rotateScene(buildingConfig[EBuildingType.Farm].rotate)

	local var_16_0 = g_MainScene.wndMain.mainScene.buildingHandler:getBuldNode(EBuildingType.Farm)

	g_MainScene.wndGuide:setFingerPosition(var_16_0)
	g_MainScene.wndGuide:setTouchFunction(function()
		arg_16_0:stepFarmIncome()
	end)
end

function zbGuideLevel005.stepFarmIncome(arg_18_0)
	g_WsMsgHandler:WS_Building_Income_Req()
	g_MainScene:showGuideWnd()
	g_MainScene:showGuideTalkWnd(904)

	local var_18_0 = g_MainScene.wndMain.mainScene.buildingHandler:getBuldNode(EBuildingType.Farm)

	g_MainScene.wndGuide:setFingerPosition(var_18_0)
	g_MainScene.wndGuide:setTouchFunction(function()
		g_MainScene:hideGuideWnd()

		arg_18_0.hideStep = 4
	end)
end

function zbGuideLevel005.stepFarmUp(arg_20_0)
	g_WsMsgHandler:WS_Building_Upgrade_Req()
	g_MainScene:showGuideTalkWnd(905)
	g_Guide:stopCurGuideStep()
	g_MainScene:hideGuideWnd()
end

function zbGuideLevel005.stop(arg_21_0)
	arg_21_0.guildOver = true
end

function zbGuideLevel005.continueNext(arg_22_0)
	g_MainScene:showGuideWnd()
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndBalanceWin.btnNext)
	g_MainScene.wndGuide:setTouchFunction(function()
		g_Guide:stopCurGuideStep()
		g_MainScene.wndBalanceWin:onNext()
	end)
end

function zbGuideLevel005.update(arg_24_0, arg_24_1)
	if arg_24_0.starGuide == true and (g_MainScene.wndWarForce and g_MainScene.wndWarForce.isShow or g_MainScene:isCanSeeMain()) then
		if g_MainScene.wndLevel then
			g_MainScene.wndLevel:hide(false)
		end

		arg_24_0:startGuide()

		arg_24_0.starGuide = false
	end

	if arg_24_0.starBalance == true and g_MainScene.wndBalanceWin and g_MainScene.wndBalanceWin.isShow then
		arg_24_0:continueNext()

		arg_24_0.starBalance = false
	end
end

function zbGuideLevel005.onGuideWndHide(arg_25_0)
	if arg_25_0.hideStep == 1 then
		g_MainScene:showTaskWnd(ETaskType.Success)
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndTask.module[ETaskType.Success].items[1].btnGetAward, g_MainScene.wndTask)
		g_MainScene.wndGuide:setTouchFunction(function()
			arg_25_0:closeMainTask()
		end)
	elseif arg_25_0.hideStep == 2 then
		g_MainScene:showGodWnd()
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndGod.btnLvUp)
		g_MainScene.wndGuide:setTouchFunction(function()
			g_MainScene:hideGuideWnd()

			arg_25_0.hideStep = 3
		end)
	elseif arg_25_0.hideStep == 3 then
		g_MainScene:showGodLevelUpWnd()
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndGodLevelUp.btnFrame[1])
		g_MainScene.wndGuide:setTouchFunction(function()
			arg_25_0:onCloseGodLevelUp()
		end)
	elseif arg_25_0.hideStep == 4 then
		g_MainScene:showFarmWnd()
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndFarm.miLevelUp)
		g_MainScene.wndGuide:setTouchFunction(function()
			arg_25_0:stepFarmUp()
		end)
	end

	arg_25_0.hideStep = 0
end
