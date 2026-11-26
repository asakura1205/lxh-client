require("gamelogic.zbGuideBase")

zbGuideHeroXiuLian = class("zbGuideHeroXiuLian", zbGuideBase)
zbGuideHeroXiuLian.__index = zbGuideHeroXiuLian

function zbGuideHeroXiuLian.create(arg_1_0)
	local var_1_0 = zbGuideHeroXiuLian.new()

	var_1_0:initBase()
	var_1_0:initMy()

	return var_1_0
end

function zbGuideHeroXiuLian.initMy(arg_2_0)
	return
end

function zbGuideHeroXiuLian.start(arg_3_0)
	arg_3_0.guildOver = false

	g_MainScene:showGuideWnd()
	g_MainScene:showGuideTalkWnd(1104)
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndShowNewFunc.btnGo)
	g_MainScene.wndGuide:setTouchFunction(function()
		g_MainScene:hideGuideWnd()

		arg_3_0.hideStep = 1
	end)
end

function zbGuideHeroXiuLian.stepNext(arg_5_0)
	g_MainScene.wndHeroDetail:onTouch(EHeroDetailTab.XiLian)
	g_MainScene:showGuideWnd()
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndHeroDetail.module[EHeroDetailTab.XiLian].btnXiulian[1])
	g_MainScene.wndGuide:setTouchFunction(function()
		arg_5_0:stepNext2()
	end)
end

function zbGuideHeroXiuLian.stepNext2(arg_7_0)
	g_Guide:stopCurGuideStep()

	if g_Self.kBagItemHandler:getItemCount(EItemType.Material, EMaterialType.HeroXilian) >= 1 then
		g_WsMsgHandler:WS_Hero_Xilian_Req(arg_7_0.heroTemplateId, 1)
	end
end

function zbGuideHeroXiuLian.stop(arg_8_0)
	arg_8_0.guildOver = true
end

function zbGuideHeroXiuLian.update(arg_9_0, arg_9_1)
	return
end

function zbGuideHeroXiuLian.onGuideWndHide(arg_10_0)
	if arg_10_0.hideStep == 1 then
		if g_MainScene.wndShowNewFunc then
			g_MainScene.wndShowNewFunc:hide()
		end

		if g_MainScene.wndBalanceWin then
			g_MainScene.wndBalanceWin:hide()
		end

		local var_10_0 = g_Self.kHeroHandler:getWorkHeros()

		g_MainScene:showHeroDetailWnd(var_10_0[1], var_10_0, EHeroTabType.Battle)

		arg_10_0.heroTemplateId = var_10_0[1].HeroBaseInfo.TemplateId

		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndHeroDetail.tabButtons[EHeroDetailTab.XiLian], g_MainScene.wndHeroDetail)
		g_MainScene.wndGuide:setTouchFunction(function()
			arg_10_0:stepNext()
		end)
	end
end
