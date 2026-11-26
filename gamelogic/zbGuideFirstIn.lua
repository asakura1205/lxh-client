require("gamelogic.zbGuideBase")

zbGuideFirstIn = class("zbGuideFirstIn", zbGuideBase)
zbGuideFirstIn.__index = zbGuideFirstIn

function zbGuideFirstIn.create(arg_1_0)
	local var_1_0 = zbGuideFirstIn.new()

	var_1_0:initBase()
	var_1_0:initMy()

	return var_1_0
end

function zbGuideFirstIn.initMy(arg_2_0)
	return
end

function zbGuideFirstIn.start(arg_3_0)
	arg_3_0.guildOver = false

	if g_Self.kHeroHandler:getHeroCount() == 1 then
		g_MainScene:showGuideTalkWnd(601, function()
			arg_3_0:onTalkOver_601()
		end)
	elseif table.getn(g_Self.kHeroHandler:getWorkHeros()) >= 2 then
		g_Guide:execGuide(GUIDE_STEP_WARPATH1_1)
	else
		g_MainScene:showGuideTalkWnd(602, function()
			arg_3_0:onTalkOver_602()
		end)
	end
end

function zbGuideFirstIn.onTalkOver_601(arg_6_0)
	g_MainScene:showGuideWnd()
	g_MainScene.wndGuide:setFingerVisible(false)

	local var_6_0 = g_MainScene.wndMain.mainScene.buildingHandler:getBuldWorldPos(EBuildingType.Pub)

	g_MainScene.wndGuide:setFingerPosition(var_6_0.x, var_6_0.y)
	g_MainScene.wndGuide:setTouchFunction(function()
		arg_6_0:stepActive()
	end)
end

function zbGuideFirstIn.onTalkOver_602(arg_8_0)
	g_Guide:execGuide(GUIDE_STEP_FORMATION_FD)
end

function zbGuideFirstIn.stop(arg_9_0)
	arg_9_0.guildOver = true
end

function zbGuideFirstIn.update(arg_10_0, arg_10_1)
	return
end

function zbGuideFirstIn.stepActive(arg_11_0)
	g_Guide:execGuide(GUIDE_STEP_BUILDING_BAR)
end
