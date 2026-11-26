require("gamelogic.zbGuideBase")

zbGuideEliteLevel = class("zbGuideEliteLevel", zbGuideBase)
zbGuideEliteLevel.__index = zbGuideEliteLevel

function zbGuideEliteLevel.create(arg_1_0)
	local var_1_0 = zbGuideEliteLevel.new()

	var_1_0:initBase()
	var_1_0:initMy()

	return var_1_0
end

function zbGuideEliteLevel.initMy(arg_2_0)
	return
end

function zbGuideEliteLevel.start(arg_3_0)
	arg_3_0.guildOver = false

	if g_MainScene:isCanSeeMain() == false then
		g_Guide:stopCurGuideStep()

		return
	end

	g_MainScene:showGuideWnd()
	g_MainScene:showGuideTalkWnd(1112)
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndMain.mainMenu.menuHero)
	g_MainScene.wndGuide:setTouchFunction(function()
		g_MainScene:hideGuideWnd()

		arg_3_0.hideStep = 1
	end)
end

function zbGuideEliteLevel.stepPhase(arg_5_0)
	g_MainScene.wndHeroDetail:onTouch(EHeroDetailTab.Phase)
	g_MainScene:showGuideTalkWnd(1113)
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndHeroDetail.module[EHeroDetailTab.Phase].useItem[1].btnFrame)
	g_MainScene.wndGuide:setTouchFunction(function()
		g_MainScene:hideGuideWnd()

		arg_5_0.hideStep = 2
	end)
end

function zbGuideEliteLevel.gotoForce(arg_7_0)
	g_Guide:stopCurGuideStep()

	if g_MainScene.wndHeroDetail then
		g_MainScene.wndHeroDetail:hide()
	end

	if g_MainScene.wndGetWay then
		g_MainScene.wndGetWay:hide()
	end

	g_curFragLevelMode = ELevelType.Elite
	g_curFragForceId = 1
	g_curFragLevelId = 10003

	g_MainScene:showWarForce(ELevelType.Elite, 1, EForceEnterWay.FragWay)
end

function zbGuideEliteLevel.stop(arg_8_0)
	arg_8_0.guildOver = true
end

function zbGuideEliteLevel.update(arg_9_0, arg_9_1)
	return
end

function zbGuideEliteLevel.onGuideWndHide(arg_10_0)
	if arg_10_0.hideStep == 1 then
		local var_10_0 = g_Self.kHeroHandler:getHeroByTemplateId(1043)

		g_MainScene:showHeroDetailWnd(var_10_0, nil, EHeroTabType.Battle)
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndHeroDetail.tabButtons[EHeroDetailTab.Phase], g_MainScene.wndHeroDetail)
		g_MainScene.wndGuide:setTouchFunction(function()
			arg_10_0:stepPhase()
		end)
	elseif arg_10_0.hideStep == 2 then
		g_MainScene:showGetWayWnd(2040601, ECommonAwardType.Item)

		local var_10_1 = g_Self.kGetWayHandler:getWays(2040601)

		if var_10_1 == nil then
			g_Guide:stopCurGuideStep()

			return
		end

		local var_10_2 = 1

		for iter_10_0, iter_10_1 in pairs(var_10_1.ways) do
			if iter_10_1.wayType == EItemGetWayType.GetWay_ForceAward and iter_10_1.levelId == 10003 and iter_10_1.levelType == ELevelType.Elite then
				break
			end

			var_10_2 = var_10_2 + 1
		end

		zbUtil:setTableViewOffset(g_MainScene.wndGetWay.tableViewHelper, kCCScrollViewDirectionVertical, kCCTableViewFillTopDown, 3, 16, 92, var_10_2)
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndGetWay.spriteTemp)
		g_MainScene.wndGuide:setTouchFunction(function()
			arg_10_0:gotoForce()
		end)
	end
end
