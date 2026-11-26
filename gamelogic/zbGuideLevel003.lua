require("gamelogic.zbGuideBase")
require("gamelogic.zbGuideWearEquip")

zbGuideLevel003 = class("zbGuideLevel003", zbGuideBase)
zbGuideLevel003.__index = zbGuideLevel003

function zbGuideLevel003.create(arg_1_0)
	local var_1_0 = zbGuideLevel003.new()

	var_1_0:initBase()
	var_1_0:initMy()

	return var_1_0
end

function zbGuideLevel003.initMy(arg_2_0)
	arg_2_0.starGuide = false
	arg_2_0.starBalance = false
	arg_2_0.wearEquipFlag = false
end

function zbGuideLevel003.start(arg_3_0)
	arg_3_0.guildOver = false
	arg_3_0.starGuide = true
	arg_3_0.starBalance = true

	if g_MainScene.wndHeroDetail then
		g_MainScene.wndHeroDetail:hide()
	end
end

function zbGuideLevel003.startGuide(arg_4_0)
	if g_MainScene.wndTreasure then
		g_MainScene.wndTreasure:hide(false)
	end

	local var_4_0 = g_Self.kHeroHandler:getHeroEquipByPos(1043, EEquipType.Weapon)

	if g_Self.kWarPathHandler.levelModes[ELevelType.Normal].curLevelId == 10003 then
		arg_4_0.curLevelId = 3

		if g_MainScene.wndWarForce and g_MainScene.wndWarForce.isShow then
			arg_4_0.hideStep = 2

			if g_MainScene.wndLevel and g_MainScene.wndLevel.isShow then
				arg_4_0.hideStep = 3
			end

			arg_4_0:onGuideWndHide()
		else
			arg_4_0:stepWarpath()
		end
	elseif g_Self.kWarPathHandler:isGetForceAward(ELevelType.Normal, 1, 2) == false then
		arg_4_0.curLevelId = 4

		if g_MainScene.wndWarForce and g_MainScene.wndWarForce.isShow then
			arg_4_0.hideStep = 11

			arg_4_0:onGuideWndHide()
		else
			arg_4_0:stepWarpath()
		end
	elseif var_4_0 == nil and arg_4_0.wearEquipFlag == false then
		arg_4_0.wearEquipFlag = true

		g_Guide:execGuide(GUIDE_STEP_WEAREQUIP)
	elseif g_Self.kHeroHandler:getHeroCount() < 3 then
		if g_MainScene.wndWarForce and g_MainScene.wndWarForce.isShow then
			g_MainScene:showGuideTalkWnd(801, function()
				arg_4_0:onTalkOver_801_1()
			end)
		else
			g_MainScene:showGuideTalkWnd(801, function()
				arg_4_0:onTalkOver_801_2()
			end)
		end
	else
		g_Guide:stopCurGuideStep()
	end
end

function zbGuideLevel003.stepWarpath(arg_7_0)
	if g_MainScene.wndHeroDetail then
		g_MainScene.wndHeroDetail:hide()
	end

	g_MainScene:showGuideWnd()
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndMain.mainMenu.menuFight)
	g_MainScene.wndGuide:setTouchFunction(function()
		g_MainScene:hideGuideWnd()

		arg_7_0.hideStep = 1
	end)
end

function zbGuideLevel003.startFight(arg_9_0)
	arg_9_0.starBalance = true

	local var_9_0 = {}

	g_WsMsgHandler:WS_GameLevel_FightStart_Req(1, arg_9_0.curLevelId + 10000, ELevelType.Normal, var_9_0)
end

function zbGuideLevel003.onTalkOver_801_1(arg_10_0)
	g_MainScene:showGuideWnd()
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndWarForce.moneyPanel.btnClose)
	g_MainScene.wndGuide:setTouchFunction(function()
		arg_10_0:onTalkOver_801_2()
	end)
end

function zbGuideLevel003.onTalkOver_801_2(arg_12_0)
	if g_MainScene.wndWarForce then
		g_MainScene.wndWarForce:hide()
	end

	g_MainScene:showGuideWnd()
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndMain.mainMenu.menuHero)
	g_MainScene.wndGuide:setTouchFunction(function()
		g_MainScene:hideGuideWnd()

		arg_12_0.hideStep = 5
	end)
end

function zbGuideLevel003.conNextStep(arg_14_0, arg_14_1)
	if arg_14_1 == 6 then
		g_MainScene.wndHeroListWnd:selectTab(4)
	else
		g_MainScene.wndHeroListWnd:selectTab(3)
	end

	g_MainScene:showGuideWnd()
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndHeroListWnd.module[EHeroTabType.UnObtain].items[1].btnTouch)
	g_MainScene.wndGuide:setTouchFunction(function()
		g_MainScene:hideGuideWnd()

		arg_14_0.hideStep = arg_14_1
	end)
end

function zbGuideLevel003.onCloseHeroList(arg_16_0)
	g_MainScene:showGuideWnd()
	g_MainScene:showGuideTalkWnd(802)
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndHeroListWnd.tabButtons[EHeroTabType.UnUse])
	g_MainScene.wndGuide:setTouchFunction(function()
		g_MainScene:hideGuideWnd()
		arg_16_0:conNextStep(7)
	end)
end

function zbGuideLevel003.onCloseHeroDetail(arg_18_0)
	if g_MainScene.wndHeroDetailAddExp then
		g_MainScene.wndHeroDetailAddExp:hide()
	end

	g_WsMsgHandler:WS_Hero_Upgrade_Req(1091, 2020301, 1)
	g_MainScene:showGuideWnd()

	arg_18_0.curLevelId = 4

	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndHeroDetail.moneyPanel.btnClose)
	g_MainScene.wndGuide:setTouchFunction(function()
		arg_18_0:stepWarpath()
	end)
end

function zbGuideLevel003.onAutoFormation(arg_20_0)
	g_MainScene.wndFormation:onAutoFormation()
	g_MainScene:showGuideWnd()
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndFormation.btnClose)
	g_MainScene.wndGuide:setTouchFunction(function()
		arg_20_0:onFight()
	end)
end

function zbGuideLevel003.onFight(arg_22_0)
	if g_MainScene.wndFormation then
		g_MainScene.wndFormation:hide()
	end

	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndEmbattle.btnFight)
	g_MainScene.wndGuide:setTouchFunction(function()
		arg_22_0:startFight()
	end)
end

function zbGuideLevel003.stop(arg_24_0)
	arg_24_0.guildOver = true
end

function zbGuideLevel003.onOpenTreaSure(arg_25_0)
	g_MainScene:showGuideWnd()
	g_MainScene:showGuideTalkWnd(805)
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndWarForce.pnlForce.treaSureTag.sptag)
	g_MainScene.wndGuide:setTouchFunction(function()
		g_MainScene:hideGuideWnd()

		arg_25_0.hideStep = 10
	end)
end

function zbGuideLevel003.onGoTreaSure(arg_27_0)
	local var_27_0 = zbItemTable:getMagnifierInfo()

	if var_27_0 and var_27_0.Count > 0 then
		g_MainScene.wndTreasure:onTreasure(1)
		g_MainScene.wndTreasure.moneyPanel.layer:setVisible(false)
		g_MainScene:hideGuideWnd()

		return
	else
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndTreasure.moneyPanel.btnClose)
		g_MainScene.wndGuide:setTouchFunction(function()
			arg_27_0:startGuide()
		end)
	end
end

function zbGuideLevel003.onOpenLevel04(arg_29_0)
	if g_MainScene.wndWarPath then
		g_MainScene.wndWarPath:hide(false)
	end

	g_MainScene:showWarForce(ELevelType.Normal, 1, EForceEnterWay.Normal)
	g_MainScene:showGuideWnd()
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndWarForce.pnlForce.stages[4].btnSoliderStage)
	g_MainScene.wndGuide:setTouchFunction(function()
		g_MainScene:hideGuideWnd()

		arg_29_0.hideStep = 3
	end)
end

function zbGuideLevel003.continueNext(arg_31_0)
	g_MainScene:showGuideWnd()

	if g_Self.kWarPathHandler.levelModes[ELevelType.Normal].curLevelId == 10003 then
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndBalanceWin.btnNext)
		g_MainScene.wndGuide:setTouchFunction(function()
			g_MainScene:hideGuideWnd()
			g_MainScene.wndBalanceWin:onNext()
		end)
	else
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndBalanceWin.btnReturn)
		g_MainScene.wndGuide:setTouchFunction(function()
			g_MainScene:hideGuideWnd()
			g_MainScene.wndBalanceWin:onReturn()
		end)
	end
end

function zbGuideLevel003.update(arg_34_0, arg_34_1)
	if arg_34_0.starGuide == true and (g_MainScene.wndWarForce and g_MainScene.wndWarForce.isShow or g_MainScene:isCanSeeMain()) then
		arg_34_0:startGuide()

		arg_34_0.starGuide = false

		return
	end

	if arg_34_0.starBalance == true and g_MainScene.wndBalanceWin and g_MainScene.wndBalanceWin.isShow then
		arg_34_0:continueNext()

		arg_34_0.starBalance = false
	end
end

function zbGuideLevel003.onGuideWndHide(arg_35_0)
	if arg_35_0.hideStep == 1 then
		g_MainScene:showWarPath(nil)
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndWarPath.items[1].spriteLock, g_MainScene.wndWarPath)
		g_MainScene.wndGuide:setTouchFunction(function()
			g_MainScene:hideGuideWnd()

			arg_35_0.hideStep = 2
		end)
	elseif arg_35_0.hideStep == 2 then
		if g_MainScene.wndWarPath then
			g_MainScene.wndWarPath:hide(false)
		end

		g_MainScene:showWarForce(ELevelType.Normal, 1, EForceEnterWay.Normal)
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndWarForce.pnlForce.stages[arg_35_0.curLevelId].btnSoliderStage)
		g_MainScene.wndGuide:setTouchFunction(function()
			g_MainScene:hideGuideWnd()

			arg_35_0.hideStep = 3
		end)
	elseif arg_35_0.hideStep == 3 then
		g_MainScene:showLevelDialog(ELevelType.Normal, 1, arg_35_0.curLevelId + 10000)
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndLevel.btnAttack)
		g_MainScene.wndGuide:setTouchFunction(function()
			g_MainScene:hideGuideWnd()

			arg_35_0.hideStep = 4
		end)
	elseif arg_35_0.hideStep == 4 then
		if g_MainScene.wndLevel then
			g_MainScene.wndLevel:hide(false)
		end

		if g_MainScene.wndWarForce then
			g_MainScene.wndWarForce:hide()
		end

		g_MainScene:showEmbattleLevel(ELevelType.Normal, 1, arg_35_0.curLevelId + 10000)
		g_MainScene:showGuideWnd()

		if arg_35_0.curLevelId == 3 then
			g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndEmbattle.btnFight)
			g_MainScene.wndGuide:setTouchFunction(function()
				arg_35_0:startFight()
			end)
		else
			g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndEmbattle.btnFormation)
			g_MainScene.wndGuide:setTouchFunction(function()
				g_MainScene:hideGuideWnd()

				arg_35_0.hideStep = 9
			end)
		end
	elseif arg_35_0.hideStep == 5 then
		g_MainScene:showHeroListWnd()
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndHeroListWnd.tabButtons[EHeroTabType.UnObtain], g_MainScene.wndHeroListWnd)
		g_MainScene.wndGuide:setTouchFunction(function()
			arg_35_0:conNextStep(6)
		end)
	elseif arg_35_0.hideStep == 6 then
		g_WsMsgHandler:WS_HeroFrag_Compose_Req(1091, arg_35_0:onCloseHeroList())
	elseif arg_35_0.hideStep == 7 then
		arg_35_0.heroDetail = g_Self.kHeroHandler:getHeroByTemplateId(1091)

		g_MainScene:showHeroDetailWnd(arg_35_0.heroDetail, heroList, EHeroTabType.UnUse)

		if g_MainScene.wndHeroListWnd then
			g_MainScene.wndHeroListWnd:hide()
		end

		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndHeroDetail.layerBase.btnAddExp, g_MainScene.wndHeroDetail)
		g_MainScene.wndGuide:setTouchFunction(function()
			g_MainScene:hideGuideWnd()

			arg_35_0.hideStep = 8
		end)
	elseif arg_35_0.hideStep == 8 then
		g_MainScene:showHeroDetailAddExpWnd(arg_35_0.heroDetail)
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndHeroDetailAddExp.btnFrame[1])
		g_MainScene.wndGuide:setTouchFunction(function()
			arg_35_0:onCloseHeroDetail()
		end)
	elseif arg_35_0.hideStep == 9 then
		g_MainScene:showFormationWnd()
		g_MainScene:showGuideWnd()
		g_MainScene:showGuideTalkWnd(803)
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndFormation.btnAutoFormation)
		g_MainScene.wndGuide:setTouchFunction(function()
			arg_35_0:onAutoFormation()
		end)
	elseif arg_35_0.hideStep == 10 then
		g_MainScene:showTreasureWnd(1, ELevelType.Normal)
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndTreasure.btnGo)
		g_MainScene.wndGuide:setTouchFunction(function()
			arg_35_0:onGoTreaSure()
		end)
	elseif arg_35_0.hideStep == 11 then
		if g_MainScene.wndWarPath then
			g_MainScene.wndWarPath:hide(false)
		end

		g_MainScene:showWarForce(ELevelType.Normal, 1, EForceEnterWay.Normal)
		g_MainScene:showGuideWnd()
		g_MainScene:showGuideTalkWnd(804)
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndWarForce.forceStarAward1.spriteEffect)
		g_MainScene.wndGuide:setTouchFunction(function()
			g_WsMsgHandler:WS_GameLevel_StarAward_Req(1, ELevelType.Normal, 2)
			arg_35_0:onOpenTreaSure()
		end)
	end

	arg_35_0.hideStep = 0
end

function zbGuideLevel003.checkEvent(arg_47_0, arg_47_1)
	if arg_47_1 == zbGameEvent.Event_LevelBattleResultSyn_Ack then
		if g_Self:getLevel() == 3 then
			arg_47_0.starGuide = true
		else
			g_Guide:stopCurGuideStep()
			g_Guide:execGuide(GUIDE_STEP_LEVEL004)
		end
	elseif arg_47_1 == zbGameEvent.Event_TreaSure_Ack then
		g_MainScene:showGuideWnd()
		g_MainScene.wndTreasure.moneyPanel.layer:setVisible(true)
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndTreasure.moneyPanel.btnClose)
		g_MainScene.wndGuide:setTouchFunction(function()
			arg_47_0:startGuide()
		end)
	end
end
