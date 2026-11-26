require("gamelogic.zbGuideBase")

zbGuideLevel001 = class("zbGuideLevel001", zbGuideBase)
zbGuideLevel001.__index = zbGuideLevel001

function zbGuideLevel001.create(arg_1_0)
	local var_1_0 = zbGuideLevel001.new()

	var_1_0:initBase()
	var_1_0:initMy()

	return var_1_0
end

function zbGuideLevel001.initMy(arg_2_0)
	arg_2_0.hideStep = 0
	arg_2_0.formationStep = 0
end

function zbGuideLevel001.start(arg_3_0)
	arg_3_0.guildOver = false

	if g_Self.kHeroHandler:getHeroCount() == 1 then
		g_MainScene:showGuideTalkWnd(601, function()
			arg_3_0:onTalkOver_601()
		end)
	elseif table.getn(g_Self.kHeroHandler:getWorkHeros()) >= 2 then
		arg_3_0:onTalkOver_604()
	else
		arg_3_0:onTalkOver_602()
	end
end

function zbGuideLevel001.onTalkOver_601(arg_5_0)
	g_MainScene:showGuideWnd()

	local var_5_0 = g_MainScene.wndMain.mainScene.buildingHandler:getBuldNode(EBuildingType.Pub)

	g_MainScene.wndGuide:setFingerPosition(var_5_0)
	g_MainScene.wndGuide:setTouchFunction(function()
		g_MainScene:hideGuideWnd()

		arg_5_0.hideStep = 1
	end)
end

function zbGuideLevel001.stepFreeBuy(arg_7_0)
	g_WsMsgHandler:WS_Bar_Draw_Req(2, function()
		arg_7_0:onClosePub()
	end)
	g_MainScene.wndPub.moneyPanel.layer:setVisible(false)
	g_MainScene.wndPub.btnPreView:setVisible(false)

	if g_MainScene.wndPub.btnChat then
		g_MainScene.wndPub.btnChat:setVisible(false)
	end

	g_MainScene:hideGuideWnd()
end

function zbGuideLevel001.onClosePub(arg_9_0)
	g_MainScene:showGuideWnd()
	g_MainScene.wndPub.moneyPanel.layer:setVisible(true)
	g_MainScene.wndPub.btnPreView:setVisible(true)

	if g_MainScene.wndPub.btnChat then
		g_MainScene.wndPub.btnChat:setVisible(true)
	end

	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndPub.moneyPanel.btnClose)
	g_MainScene.wndGuide:setTouchFunction(function()
		arg_9_0:onTalkOver_602()
	end)
end

function zbGuideLevel001.onTalkOver_602(arg_11_0)
	if g_MainScene.wndPub then
		g_MainScene.wndPub:hide()
	end

	g_MainScene:showGuideWnd()
	g_MainScene:showGuideTalkWnd(602)
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndMain.mainMenu.menuFormation)
	g_MainScene.wndGuide:setTouchFunction(function()
		g_MainScene:hideGuideWnd()

		arg_11_0.hideStep = 2
	end)
end

function zbGuideLevel001.openPickUpHero(arg_13_0)
	arg_13_0.formationStep = 1

	local var_13_0 = g_Self.kHeroHandler:getSortedHeros()
	local var_13_1 = 1
	local var_13_2 = 1041

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		if iter_13_1.HeroBaseInfo.TemplateId ~= 1041 then
			var_13_2 = iter_13_1.HeroBaseInfo.TemplateId

			break
		end

		var_13_1 = var_13_1 + 1
	end

	g_MainScene.wndGuide:setHeroMove()
	g_MainScene.wndGuide.editingAnimation:refreshHeroTemplateId(var_13_2)
	g_MainScene.wndGuide.editingAnimation:setAnimation(ANIMATION_SEQUENCE_PICKUP, true)
	g_MainScene.wndGuide.editingAnimation.skeleton:setOpacity(160)

	local var_13_3 = zbUtil:getGuidePos(g_MainScene.wndFormation.panelHeroList.items[1].btnTouch)

	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndFormation.panelHeroList.items[1].btnTouch)
	g_MainScene.wndGuide.effectLayer:setPosition(var_13_3.x, var_13_3.y)
	g_MainScene.wndGuide:adapterFlip(g_MainScene.wndGuide.effectLayer)
	g_MainScene.wndGuide:setTouchFunction(nil)

	local var_13_4 = g_MainScene.wndFormation.panelFormationSlots.slots[5]:getParent():convertToWorldSpace(ccp(g_MainScene.wndFormation.panelFormationSlots.slots[5]:getPosition()))

	var_13_4.x = var_13_4.x / g_MainScene.wndGuide.node:getScaleX() - g_MainScene.wndGuide.node:getPositionX()
	var_13_4.y = var_13_4.y / g_MainScene.wndGuide.node:getScaleY() - g_MainScene.wndGuide.node:getPositionY()

	local var_13_5 = CCArray:create()

	var_13_5:addObject(CCCallFuncN:create(function()
		g_MainScene.wndGuide.layerFinger:runAction(CCMoveTo:create(2, var_13_4))
	end))
	var_13_5:addObject(CCMoveTo:create(2, var_13_4))
	var_13_5:addObject(CCDelayTime:create(1))
	var_13_5:addObject(CCCallFuncN:create(function()
		g_MainScene:hideGuideWnd()
		g_MainScene.wndGuide.effectLayer:setVisible(false)
	end))

	local var_13_6 = CCSequence:create(var_13_5)

	g_MainScene.wndGuide.effectLayer:stopAllActions()
	g_MainScene.wndGuide.effectLayer:runAction(var_13_6)
end

function zbGuideLevel001.onTalkOver_604(arg_16_0)
	if g_MainScene.wndFormation then
		g_MainScene.wndFormation:hide()
	end

	g_MainScene:showGuideWnd()
	g_MainScene:showGuideTalkWnd(604)
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndMain.mainMenu.menuFight)
	g_MainScene.wndGuide:setTouchFunction(function()
		g_MainScene:hideGuideWnd()

		arg_16_0.hideStep = 3
	end)
end

function zbGuideLevel001.continueWarPath(arg_18_0)
	if g_MainScene.wndWarPath then
		g_MainScene.wndWarPath:hide(false)
	end

	g_MainScene:hideGuideWnd()
	g_MainScene:showWarForce(ELevelType.Normal, 1, EForceEnterWay.Normal)
	g_MainScene:showGuideTalkWnd(10001, function()
		arg_18_0:onTalkOver_10001()
	end, true)
end

function zbGuideLevel001.onTalkOver_10001(arg_20_0)
	g_MainScene:showGuideWnd()
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndWarForce.pnlForce.stages[1].btnSoliderStage)
	g_MainScene.wndGuide:setTouchFunction(function()
		g_MainScene:hideGuideWnd()

		arg_20_0.hideStep = 4
	end)
end

function zbGuideLevel001.startFight(arg_22_0)
	local var_22_0 = {}

	g_WsMsgHandler:WS_GameLevel_FightStart_Req(1, 10001, ELevelType.Normal, var_22_0)
end

function zbGuideLevel001.stop(arg_23_0)
	arg_23_0.guildOver = true
end

function zbGuideLevel001.update(arg_24_0, arg_24_1)
	if arg_24_0.formationStep == 1 and table.getn(g_Self.kHeroHandler:getWorkHeros()) >= 2 then
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndFormation.btnClose)
		g_MainScene.wndGuide:setTouchFunction(function()
			arg_24_0:onTalkOver_604()
		end)

		arg_24_0.formationStep = 0
	end
end

function zbGuideLevel001.onGuideWndHide(arg_26_0)
	if arg_26_0.hideStep == 1 then
		g_MainScene:showPubWnd()
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndPub.btnPub[2])
		g_MainScene.wndGuide:setTouchFunction(function()
			arg_26_0:stepFreeBuy()
		end)
	elseif arg_26_0.hideStep == 2 then
		g_MainScene:showFormationWnd()
		g_MainScene:showGuideWnd()
		g_MainScene:showGuideTalkWnd(603, function()
			arg_26_0:openPickUpHero()
		end)
	elseif arg_26_0.hideStep == 3 then
		g_MainScene:showWarPath(nil)
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndWarPath.items[1].spriteLock, g_MainScene.wndWarPath)
		g_MainScene.wndGuide:setTouchFunction(function()
			arg_26_0:continueWarPath()
		end)
	elseif arg_26_0.hideStep == 4 then
		g_MainScene:showLevelDialog(ELevelType.Normal, 1, 10001)
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndLevel.btnAttack)
		g_MainScene.wndGuide:setTouchFunction(function()
			g_MainScene:hideGuideWnd()

			arg_26_0.hideStep = 5
		end)
	elseif arg_26_0.hideStep == 5 then
		if g_MainScene.wndLevel then
			g_MainScene.wndLevel:hide(false)
		end

		if g_MainScene.wndWarForce then
			g_MainScene.wndWarForce:hide()
		end

		g_MainScene:showEmbattleLevel(ELevelType.Normal, 1, 10001)
		g_MainScene:showGuideWnd()

		local var_26_0 = zbUtil:getGuidePos(g_MainScene.wndEmbattle.btnFight)

		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndEmbattle.btnFight)
		g_MainScene.wndGuide:setTouchFunction(function()
			arg_26_0:startFight()
		end)
	end

	arg_26_0.hideStep = 0
end

function zbGuideLevel001.checkEvent(arg_32_0, arg_32_1)
	if arg_32_1 == zbGameEvent.Event_LevelBattleResultSyn_Ack then
		g_Guide:stopCurGuideStep()
		g_Guide:execGuide(GUIDE_STEP_LEVEL002)
	end
end
