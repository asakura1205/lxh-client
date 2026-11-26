require("gamelogic.zbGuideBase")

zbGuideLevel002 = class("zbGuideLevel002", zbGuideBase)
zbGuideLevel002.__index = zbGuideLevel002

function zbGuideLevel002.create(arg_1_0)
	local var_1_0 = zbGuideLevel002.new()

	var_1_0:initBase()
	var_1_0:initMy()

	return var_1_0
end

function zbGuideLevel002.initMy(arg_2_0)
	arg_2_0.hideStep = 0
	arg_2_0.starGuide = false
	arg_2_0.starBalance = false
end

function zbGuideLevel002.isCanExec(arg_3_0)
	return arg_3_0.guildOver ~= false
end

function zbGuideLevel002.start(arg_4_0)
	arg_4_0.guildOver = false
	arg_4_0.starGuide = true
	arg_4_0.starBalance = true
end

function zbGuideLevel002.startGuide(arg_5_0)
	if g_MainScene.wndWarForce and g_MainScene.wndWarForce.isShow then
		arg_5_0.hideStep = 5

		if g_MainScene.wndLevel and g_MainScene.wndLevel.isShow then
			arg_5_0.hideStep = 6
		end

		arg_5_0:onGuideWndHide()
	else
		arg_5_0:continueWarpath()
	end
end

function zbGuideLevel002.continueWarpath(arg_6_0)
	if g_MainScene.wndHeroDetail then
		g_MainScene.wndHeroDetail:hide()
	end

	g_MainScene:showGuideWnd()
	g_MainScene:showGuideTalkWnd(705)
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndMain.mainMenu.menuFight)
	g_MainScene.wndGuide:setTouchFunction(function()
		g_MainScene:hideGuideWnd()

		arg_6_0.hideStep = 4
	end)
end

function zbGuideLevel002.startFight(arg_8_0)
	local var_8_0 = {}

	g_WsMsgHandler:WS_GameLevel_FightStart_Req(1, 10002, ELevelType.Normal, var_8_0)
end

function zbGuideLevel002.stop(arg_9_0)
	arg_9_0.guildOver = true
end

function zbGuideLevel002.continueNext(arg_10_0)
	g_MainScene:showGuideWnd()
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndBalanceWin.btnNext)
	g_MainScene.wndGuide:setTouchFunction(function()
		g_MainScene:hideGuideWnd()
		g_MainScene.wndBalanceWin:onNext()
	end)
end

function zbGuideLevel002.update(arg_12_0, arg_12_1)
	if arg_12_0.starGuide == true and (g_MainScene.wndWarForce and g_MainScene.wndWarForce.isShow or g_MainScene:isCanSeeMain()) then
		arg_12_0:startGuide()

		arg_12_0.starGuide = false
	end

	if arg_12_0.starBalance == true and g_MainScene.wndBalanceWin and g_MainScene.wndBalanceWin.isShow then
		arg_12_0:continueNext()

		arg_12_0.starBalance = false
	end
end

function zbGuideLevel002.onGuideWndHide(arg_13_0)
	if arg_13_0.hideStep == 4 then
		g_MainScene:showWarPath(nil)
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndWarPath.items[1].spriteLock, g_MainScene.wndWarPath)
		g_MainScene.wndGuide:setTouchFunction(function()
			g_MainScene:hideGuideWnd()

			arg_13_0.hideStep = 5
		end)
	elseif arg_13_0.hideStep == 5 then
		if g_MainScene.wndWarPath then
			g_MainScene.wndWarPath:hide(false)
		end

		g_MainScene:showWarForce(ELevelType.Normal, 1, EForceEnterWay.Normal)
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndWarForce.pnlForce.stages[2].btnSoliderStage)
		g_MainScene.wndGuide:setTouchFunction(function()
			g_MainScene:hideGuideWnd()

			arg_13_0.hideStep = 6
		end)
	elseif arg_13_0.hideStep == 6 then
		g_MainScene:showLevelDialog(ELevelType.Normal, 1, 10002)
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndLevel.btnAttack)
		g_MainScene.wndGuide:setTouchFunction(function()
			g_MainScene:hideGuideWnd()

			arg_13_0.hideStep = 7
		end)
	elseif arg_13_0.hideStep == 7 then
		if g_MainScene.wndLevel then
			g_MainScene.wndLevel:hide(false)
		end

		if g_MainScene.wndWarForce then
			g_MainScene.wndWarForce:hide()
		end

		g_MainScene:showEmbattleLevel(ELevelType.Normal, 1, 10002)
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndEmbattle.btnFight)
		g_MainScene.wndGuide:setTouchFunction(function()
			arg_13_0:startFight()
		end)
	end

	arg_13_0.hideStep = 0
end

function zbGuideLevel002.checkEvent(arg_18_0, arg_18_1)
	if arg_18_1 == zbGameEvent.Event_LevelBattleResultSyn_Ack then
		g_Guide:stopCurGuideStep()
		g_Guide:execGuide(GUIDE_STEP_LEVEL003)
	end
end
