require("gamelogic.zbGuideBase")

zbGuideWorld = class("zbGuideWorld", zbGuideBase)
zbGuideWorld.__index = zbGuideWorld

function zbGuideWorld.create(arg_1_0)
	local var_1_0 = zbGuideWorld.new()

	var_1_0:initBase()
	var_1_0:initMy()

	return var_1_0
end

function zbGuideWorld.initMy(arg_2_0)
	return
end

function zbGuideWorld.start(arg_3_0)
	arg_3_0.guildOver = false

	g_MainScene:showGuideWnd()
	g_MainScene:showGuideTalkWnd(1105)
	g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndShowNewFunc.btnGo)
	g_MainScene.wndGuide:setTouchFunction(function()
		g_MainScene:hideGuideWnd()

		arg_3_0.hideStep = 1
	end)
end

function zbGuideWorld.stepNext(arg_5_0)
	g_MainScene:showGuideWnd()

	arg_5_0.resNode = g_MainScene.wndWorld.wordMap.mapNodeMgr:getNodeById(20)

	if arg_5_0.resNode == nil then
		g_Guide:stopCurGuideStep()

		return
	end

	g_MainScene.wndGuide:setFingerPosition(arg_5_0.resNode.resBg)
	g_MainScene.wndGuide:setTouchFunction(function()
		g_MainScene:hideGuideWnd()

		arg_5_0.hideStep = 2
	end)

	local var_5_0 = g_Self.kWorldHandler.worldInfo

	if var_5_0 and zbUtil:isValidTable(var_5_0.HoldNodeList) then
		for iter_5_0, iter_5_1 in pairs(var_5_0.HoldNodeList) do
			if iter_5_1.NodeId == 20 then
				g_Guide:stopCurGuideStep()

				return
			end
		end
	end
end

function zbGuideWorld.startFight(arg_7_0)
	g_WsMsgHandler:WS_WorldRes_FightStart_Req(20)
	g_Guide:stopCurGuideStep()
end

function zbGuideWorld.stop(arg_8_0)
	arg_8_0.guildOver = true
end

function zbGuideWorld.update(arg_9_0, arg_9_1)
	return
end

function zbGuideWorld.onGuideWndHide(arg_10_0)
	if arg_10_0.hideStep == 1 then
		if g_MainScene.wndShowNewFunc then
			g_MainScene.wndShowNewFunc:hide()
		end

		if g_MainScene.wndBalanceWin then
			g_MainScene.wndBalanceWin:hide()
		end

		g_MainScene:showWorld()
		g_MainScene:showGuideTalkWnd(1106, function()
			arg_10_0:stepNext()
		end)
	elseif arg_10_0.hideStep == 2 then
		local var_10_0 = g_Self.kWorldHandler:getWorldNodeResInfoById(arg_10_0.resNode.type, arg_10_0.resNode.record.id)

		g_MainScene:showWorldResInfoWnd(var_10_0.NodeId)
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndWorldResInfo.btnFight)
		g_MainScene.wndGuide:setTouchFunction(function()
			g_MainScene:hideGuideWnd()

			arg_10_0.hideStep = 3
		end)
	elseif arg_10_0.hideStep == 3 then
		if g_MainScene.wndWorldResInfo then
			g_MainScene.wndWorldResInfo:hide()
		end

		local var_10_1 = g_Self.kWorldHandler:getWorldNodeResInfoById(arg_10_0.resNode.type, arg_10_0.resNode.record.id)

		g_Self.kWorldHandler.combatSeceneId = 11
		g_Self.kWorldHandler.fightResNodeId = var_10_1.NodeId

		g_MainScene:showEmbattleWorldRes(var_10_1.NodeId)
		g_MainScene:showGuideWnd()
		g_MainScene.wndGuide:setFingerPosition(g_MainScene.wndEmbattle.btnFight)
		g_MainScene.wndGuide:setTouchFunction(function()
			arg_10_0:startFight()
		end)
	end
end
