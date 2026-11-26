require("gamelogic.zbGuideBase")

zbGuideWearEquip = class("zbGuideWearEquip", zbGuideBase)
zbGuideWearEquip.__index = zbGuideWearEquip

function zbGuideWearEquip.create(arg_1_0)
	local var_1_0 = zbGuideWearEquip.new()

	var_1_0:initBase()
	var_1_0:initMy()

	return var_1_0
end

function zbGuideWearEquip.initMy(arg_2_0)
	arg_2_0.hideStep = 0
	arg_2_0.starGuide = false
end

function zbGuideWearEquip.isCanExec(arg_3_0)
	return arg_3_0.guildOver ~= false
end

function zbGuideWearEquip.start(arg_4_0)
	arg_4_0.guildOver = false
	arg_4_0.starGuide = true
	arg_4_0.initheroId = 1041
end

function zbGuideWearEquip.startGuide(arg_5_0)
	if g_Self.kHeroHandler:getHeroEquipByPos(1043, EEquipType.Weapon) == nil then
		if g_MainScene.wndWarForce and g_MainScene.wndWarForce.isShow then
			g_MainScene:showGuideTalkWnd(701, function()
				arg_5_0:onTalkOver_701_1()
			end)
		else
			g_MainScene:showGuideTalkWnd(701, function()
				arg_5_0:onTalkOver_701_2()
			end)
		end
	end
end

function zbGuideWearEquip.onTalkOver_701_1(arg_8_0)
	g_MainScene:showGuideWnd()
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndWarForce.moneyPanel.btnClose)
	g_MainScene.wndGuide:setTouchFunction(function()
		arg_8_0:onTalkOver_701_2()
	end)
end

function zbGuideWearEquip.onTalkOver_701_2(arg_10_0)
	if g_MainScene.wndWarForce then
		g_MainScene.wndWarForce:hide()
	end

	g_MainScene:showGuideWnd()
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndMain.mainMenu.menuHero)
	g_MainScene.wndGuide:setTouchFunction(function()
		g_MainScene:hideGuideWnd()

		arg_10_0.hideStep = 1
	end)
end

function zbGuideWearEquip.stepEquipUpgrade(arg_12_0)
	g_MainScene.wndEquipSelect.panelDetail:onEquipUp()
	g_MainScene:hideGuideWnd()
	g_MainScene:showGuideTalkWnd(702, function()
		arg_12_0:onTalkOver_702()
	end)
end

function zbGuideWearEquip.onTalkOver_702(arg_14_0)
	g_MainScene:showGuideWnd()
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndHeroDetail.layerBase.btnAuto)
	g_MainScene.wndGuide:setTouchFunction(function()
		arg_14_0:onTalkOver_703()
	end)
end

function zbGuideWearEquip.onTalkOver_703(arg_16_0)
	g_MainScene:showGuideTalkWnd(703)
	g_WsMsgHandler:WS_Hero_FastUpgradeEquip_Req(arg_16_0.heroTemplateId)
	g_MainScene:showGuideWnd()
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndHeroDetail.tabButtons[EHeroDetailTab.Skill])
	g_MainScene.wndGuide:setTouchFunction(function()
		arg_16_0:stepSkillUp()
	end)
end

function zbGuideWearEquip.stepSkillUp(arg_18_0)
	g_MainScene.wndHeroDetail:onTouch(EHeroDetailTab.Skill)
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndHeroDetail.module[EHeroDetailTab.Skill].skill[1].btnAddUp)
	g_MainScene.wndGuide:setTouchFunction(function()
		arg_18_0:continuePhase()
	end)
end

function zbGuideWearEquip.continuePhase(arg_20_0)
	g_WsMsgHandler:WS_Hero_UpgradeSkill_Req(arg_20_0.heroTemplateId, 1, 2)
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndHeroDetail.btnRight)
	g_MainScene.wndGuide:setTouchFunction(function()
		arg_20_0:nextHeroDetail()
	end)
end

function zbGuideWearEquip.nextHeroDetail(arg_22_0)
	g_MainScene.wndHeroDetail:onRight()
	g_MainScene:showGuideWnd()
	g_MainScene:showGuideTalkWnd(704)
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndHeroDetail.tabButtons[EHeroDetailTab.Phase])
	g_MainScene.wndGuide:setTouchFunction(function()
		arg_22_0:stepPhase()
	end)
end

function zbGuideWearEquip.stepPhase(arg_24_0)
	g_MainScene.wndHeroDetail:onTouch(EHeroDetailTab.Phase)
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndHeroDetail.module[EHeroDetailTab.Phase].btnStarup)
	g_MainScene.wndGuide:setTouchFunction(function()
		arg_24_0:stepPhase2()
	end)
end

function zbGuideWearEquip.stepPhase2(arg_26_0)
	g_WsMsgHandler:WS_Hero_UpgradeQuality_Req(arg_26_0.initheroId)
	g_MainScene:showGuideTalkWnd(801)
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndHeroDetail.moneyPanel.btnClose)
	g_MainScene.wndGuide:setTouchFunction(function()
		g_MainScene:hideGuideWnd()

		arg_26_0.hideStep = 5
	end)
end

function zbGuideWearEquip.conNextStep(arg_28_0, arg_28_1)
	g_MainScene:showHeroListWnd()

	if arg_28_1 == 6 then
		g_MainScene.wndHeroListWnd:selectTab(4)
	else
		g_MainScene.wndHeroListWnd:selectTab(3)
	end

	g_MainScene:showGuideWnd()
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndHeroListWnd.module[EHeroTabType.UnObtain].items[1].btnTouch)
	g_MainScene.wndGuide:setTouchFunction(function()
		g_MainScene:hideGuideWnd()

		arg_28_0.hideStep = arg_28_1
	end)
end

function zbGuideWearEquip.onCloseHeroList(arg_30_0)
	g_MainScene:showGuideWnd()
	g_MainScene:showGuideTalkWnd(802)
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndHeroListWnd.tabButtons[EHeroTabType.UnUse])
	g_MainScene.wndGuide:setTouchFunction(function()
		g_MainScene:hideGuideWnd()
		arg_30_0:conNextStep(7)
	end)
end

function zbGuideWearEquip.onCloseHeroDetail(arg_32_0)
	if g_MainScene.wndHeroDetailAddExp then
		g_MainScene.wndHeroDetailAddExp:hide()
	end

	g_WsMsgHandler:WS_Hero_Upgrade_Req(1091, 2020301, 1)
	g_MainScene:showGuideWnd()

	arg_32_0.curLevelId = 4

	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndHeroDetail.moneyPanel.btnClose)
	g_MainScene.wndGuide:setTouchFunction(function()
		arg_32_0:stepWarpath()
	end)
end

function zbGuideWearEquip.stepWarpath(arg_34_0)
	if g_MainScene.wndHeroDetail then
		g_MainScene.wndHeroDetail:hide()
	end

	g_MainScene:showGuideWnd()
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndMain.mainMenu.menuFight)
	g_MainScene.wndGuide:setTouchFunction(function()
		g_MainScene:hideGuideWnd()

		arg_34_0.hideStep = 9
	end)
end

function zbGuideWearEquip.stop(arg_36_0)
	arg_36_0.guildOver = true
end

function zbGuideWearEquip.update(arg_37_0, arg_37_1)
	if arg_37_0.starGuide == true and (g_MainScene.wndWarForce and g_MainScene.wndWarForce.isShow or g_MainScene:isCanSeeMain()) then
		if g_MainScene.wndLevel then
			g_MainScene.wndLevel:hide(false)
		end

		arg_37_0:startGuide()

		arg_37_0.starGuide = false
	end
end

function zbGuideWearEquip.onGuideWndHide(arg_38_0)
	if arg_38_0.hideStep == 1 then
		g_MainScene:showHeroListWnd()
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndHeroListWnd.module[EHeroTabType.Battle].items[1].btnTouch, g_MainScene.wndHeroListWnd)
		g_MainScene.wndGuide:setTouchFunction(function()
			g_MainScene:hideGuideWnd()

			arg_38_0.hideStep = 2
		end)
	elseif arg_38_0.hideStep == 2 then
		local var_38_0 = g_Self.kHeroHandler:getWorkHeros()

		arg_38_0.heroTemplateId = arg_38_0.initheroId

		for iter_38_0, iter_38_1 in pairs(var_38_0) do
			if iter_38_1.HeroBaseInfo.TemplateId ~= arg_38_0.initheroId then
				arg_38_0.heroTemplateId = iter_38_1.HeroBaseInfo.TemplateId

				break
			end
		end

		local var_38_1 = g_Self.kHeroHandler:getHeroByTemplateId(arg_38_0.heroTemplateId)

		g_MainScene:showHeroDetailWnd(var_38_1, var_38_0, EHeroTabType.Battle)

		if g_MainScene.wndHeroListWnd then
			g_MainScene.wndHeroListWnd:hide()
		end

		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndHeroDetail.layerBase.equipWeapon.btnFrame, g_MainScene.wndHeroDetail)
		g_MainScene.wndGuide:setTouchFunction(function()
			g_MainScene:hideGuideWnd()

			arg_38_0.hideStep = 3
		end)
	elseif arg_38_0.hideStep == 3 then
		g_MainScene:showEquipSelectWnd(arg_38_0.heroTemplateId, EEquipType.Weapon)
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndEquipSelect.panelDetail.btnWear)
		g_MainScene.wndGuide:setTouchFunction(function()
			arg_38_0:stepEquipUpgrade()
		end)
	elseif arg_38_0.hideStep == 4 then
		g_MainScene:showEquipSelectWnd(arg_38_0.initheroId, EEquipType.Armor)
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndEquipSelect.panelDetail.btnWear)
		g_MainScene.wndGuide:setTouchFunction(function()
			arg_38_0:step1041EquipUpgrade()
		end)
	elseif arg_38_0.hideStep == 5 then
		if g_MainScene.wndHeroDetail then
			g_MainScene.wndHeroDetail:hide()
		end

		g_MainScene:showHeroListWnd()
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndHeroListWnd.tabButtons[EHeroTabType.UnObtain], g_MainScene.wndHeroListWnd)
		g_MainScene.wndGuide:setTouchFunction(function()
			arg_38_0:conNextStep(6)
		end)
	elseif arg_38_0.hideStep == 6 then
		g_WsMsgHandler:WS_HeroFrag_Compose_Req(1091, arg_38_0:onCloseHeroList())
	elseif arg_38_0.hideStep == 7 then
		arg_38_0.heroDetail = g_Self.kHeroHandler:getHeroByTemplateId(1091)

		g_MainScene:showHeroDetailWnd(arg_38_0.heroDetail, heroList, EHeroTabType.UnUse)

		if g_MainScene.wndHeroListWnd then
			g_MainScene.wndHeroListWnd:hide()
		end

		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndHeroDetail.layerBase.btnAddExp, g_MainScene.wndHeroDetail)
		g_MainScene.wndGuide:setTouchFunction(function()
			g_MainScene:hideGuideWnd()

			arg_38_0.hideStep = 8
		end)
	elseif arg_38_0.hideStep == 8 then
		g_MainScene:showHeroDetailAddExpWnd(arg_38_0.heroDetail)
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndHeroDetailAddExp.btnFrame[1])
		g_MainScene.wndGuide:setTouchFunction(function()
			arg_38_0:onCloseHeroDetail()
		end)
	elseif arg_38_0.hideStep == 9 then
		g_MainScene:showWarPath(nil)
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndWarPath.items[1].spriteLock, g_MainScene.wndWarPath)
		g_MainScene.wndGuide:setTouchFunction(function()
			g_MainScene:hideGuideWnd()

			arg_38_0.hideStep = 10
		end)
	elseif arg_38_0.hideStep == 10 then
		if g_MainScene.wndWarPath then
			g_MainScene.wndWarPath:hide(false)
		end

		g_MainScene:showWarForce(ELevelType.Normal, 1, EForceEnterWay.Normal)
		g_Guide:stopCurGuideStep()
	end

	arg_38_0.hideStep = 0
end

function zbGuideWearEquip.checkEvent(arg_47_0, arg_47_1)
	return
end
