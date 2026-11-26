require("gamelogic.zbGuideBase")

zbGuideLevel004 = class("zbGuideLevel004", zbGuideBase)
zbGuideLevel004.__index = zbGuideLevel004

function zbGuideLevel004.create(arg_1_0)
	local var_1_0 = zbGuideLevel004.new()

	var_1_0:initBase()
	var_1_0:initMy()

	return var_1_0
end

function zbGuideLevel004.initMy(arg_2_0)
	arg_2_0.starGuide = false
	arg_2_0.starBalance = false
end

function zbGuideLevel004.start(arg_3_0)
	arg_3_0.guildOver = false
	arg_3_0.starGuide = true
	arg_3_0.starBalance = true
end

function zbGuideLevel004.startGuide(arg_4_0)
	local var_4_0 = g_Self.kWarPathHandler.levelModes[ELevelType.Normal].curLevelId

	if var_4_0 == 10005 then
		arg_4_0.curLevelId = 5

		if g_MainScene.wndWarForce and g_MainScene.wndWarForce.isShow then
			arg_4_0.hideStep = 2

			if g_MainScene.wndLevel and g_MainScene.wndLevel.isShow then
				arg_4_0.hideStep = 3
			end

			arg_4_0:onGuideWndHide()
		else
			arg_4_0:stepWarpath()
		end
	elseif var_4_0 == 10006 then
		arg_4_0.curLevelId = 6

		if g_MainScene.wndWarForce and g_MainScene.wndWarForce.isShow then
			arg_4_0.hideStep = 2

			if g_MainScene.wndLevel and g_MainScene.wndLevel.isShow then
				arg_4_0.hideStep = 3
			end

			arg_4_0:onGuideWndHide()
		else
			arg_4_0:stepWarpath()
		end
	else
		g_Guide:stopCurGuideStep()
	end
end

function zbGuideLevel004.stepWarpath(arg_5_0)
	g_MainScene:showGuideWnd()
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndMain.mainMenu.menuFight)
	g_MainScene.wndGuide:setTouchFunction(function()
		g_MainScene:hideGuideWnd()

		arg_5_0.hideStep = 1
	end)
end

function zbGuideLevel004.startFight(arg_7_0)
	arg_7_0.starBalance = true

	local var_7_0 = {}

	g_WsMsgHandler:WS_GameLevel_FightStart_Req(1, arg_7_0.curLevelId + 10000, ELevelType.Normal, var_7_0)
end

function zbGuideLevel004.continueNext(arg_8_0)
	g_MainScene:showGuideWnd()
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndBalanceWin.btnNext)

	if arg_8_0.curLevelId == 6 then
		g_MainScene.wndGuide:setTouchFunction(function()
			g_Guide:stopCurGuideStep()
			g_MainScene.wndBalanceWin:onNext()
		end)
	else
		g_MainScene.wndGuide:setTouchFunction(function()
			g_MainScene:hideGuideWnd()
			g_MainScene.wndBalanceWin:onNext()
		end)
	end
end

function zbGuideLevel004.stop(arg_11_0)
	arg_11_0.guildOver = true
end

function zbGuideLevel004.update(arg_12_0, arg_12_1)
	if arg_12_0.starGuide == true and (g_MainScene.wndWarForce and g_MainScene.wndWarForce.isShow or g_MainScene:isCanSeeMain()) then
		arg_12_0:startGuide()

		arg_12_0.starGuide = false
	end

	if arg_12_0.starBalance == true and g_MainScene.wndBalanceWin and g_MainScene.wndBalanceWin.isShow then
		arg_12_0:continueNext()

		arg_12_0.starBalance = false
	end
end

function zbGuideLevel004.onGuideWndHide(arg_13_0)
	if arg_13_0.hideStep == 1 then
		g_MainScene:showWarPath(nil)
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndWarPath.items[1].spriteLock, g_MainScene.wndWarPath)
		g_MainScene.wndGuide:setTouchFunction(function()
			g_MainScene:hideGuideWnd()

			arg_13_0.hideStep = 2
		end)
	elseif arg_13_0.hideStep == 2 then
		if g_MainScene.wndWarPath then
			g_MainScene.wndWarPath:hide(false)
		end

		g_MainScene:showWarForce(ELevelType.Normal, 1, EForceEnterWay.Normal)
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndWarForce.pnlForce.stages[arg_13_0.curLevelId].btnSoliderStage)
		g_MainScene.wndGuide:setTouchFunction(function()
			g_MainScene:hideGuideWnd()

			arg_13_0.hideStep = 3
		end)
	elseif arg_13_0.hideStep == 3 then
		g_MainScene:showLevelDialog(ELevelType.Normal, 1, arg_13_0.curLevelId + 10000)
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndLevel.btnAttack)
		g_MainScene.wndGuide:setTouchFunction(function()
			g_MainScene:hideGuideWnd()

			arg_13_0.hideStep = 4
		end)
	elseif arg_13_0.hideStep == 4 then
		if g_MainScene.wndLevel then
			g_MainScene.wndLevel:hide(false)
		end

		if g_MainScene.wndWarForce then
			g_MainScene.wndWarForce:hide()
		end

		g_MainScene:showEmbattleLevel(ELevelType.Normal, 1, arg_13_0.curLevelId + 10000)
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndEmbattle.btnFight)
		g_MainScene.wndGuide:setTouchFunction(function()
			arg_13_0:startFight()
		end)
	end

	arg_13_0.hideStep = 0
end

function zbGuideLevel004.checkEvent(arg_18_0, arg_18_1)
	if arg_18_1 == zbGameEvent.Event_LevelBattleResultSyn_Ack and g_Self:getLevel() == 4 then
		arg_18_0.starGuide = true
	end
end
