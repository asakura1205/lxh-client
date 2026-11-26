require("gamelogic.zbBaseWnd")
require("gamelogic.zbWordLogPnl")
require("gamelogic.zbWorldMap")
require("gamelogic.zbWordHelp")

local var_0_0 = class("zbWorld", zbBaseWnd)

var_0_0.__index = var_0_0

function var_0_0.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, var_0_0)

	return arg_1_0
end

function createWorldWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.firstshow = true
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/word.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")

		arg_3_0.Root = tolua.cast(var_5_1, "CCLayer")

		local var_5_2 = tolua.cast(arg_3_0.Root:getChildByTag(1), "CCNode")
		local var_5_3 = tolua.cast(arg_3_0.Root:getChildByTag(3), "CCLayer")
		local var_5_4 = tolua.cast(arg_3_0.Root:getChildByTag(2), "CCNode")

		arg_3_0.openfogs = {}
		arg_3_0.openfogInitPos = {}

		for iter_5_0 = 1, 4 do
			arg_3_0.openfogs[iter_5_0] = tolua.cast(var_5_4:getChildByTag(iter_5_0), "CCSprite")
			arg_3_0.openfogInitPos[iter_5_0] = ccp(arg_3_0.openfogs[iter_5_0]:getPosition())
		end

		arg_3_0.nodeInfo = tolua.cast(var_5_2:getChildByTag(3), "CCNode")
		arg_3_0.lbloccupyres = tolua.cast(arg_3_0.nodeInfo:getChildByTag(1), "CCLabelTTF")

		local var_5_5 = tolua.cast(var_5_2:getChildByTag(1), "CCNode")

		arg_3_0.loglayer = tolua.cast(arg_3_0.Root:getChildByTag(4), "CCLayer")
		arg_3_0.wordLogPnl = createWordLogPanel(arg_3_0.loglayer)
		arg_3_0.btnRule = tolua.cast(var_5_5:getChildByTag(1), "CCControlButton")
		arg_3_0.btnInfo = tolua.cast(var_5_5:getChildByTag(2), "CCControlButton")

		arg_3_0.btnRule:addHandleOfControlEvent(function()
			arg_3_0:onRule()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnInfo:addHandleOfControlEvent(function()
			arg_3_0:onInfoTouchDown()
		end, CCControlEventTouchDown)
		arg_3_0.btnInfo:addHandleOfControlEvent(function()
			arg_3_0:onInfoTouchEnd()
		end, CCControlEventTouchEnd)
		arg_3_0:addChild(arg_3_0.Root)

		arg_3_0.wordMap = createWordMap()

		var_5_3:addChild(arg_3_0.wordMap)
		arg_3_0:createMoneyPanel(arg_3_0.Root, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold,
			EMoneyPanelResType.Food
		}, function()
			arg_3_0:hide()
		end)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(handler(arg_3_0, arg_3_0.doShow))
	arg_3_0:setHideCallback(handler(arg_3_0, arg_3_0.doHide))
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refresh()
	end, zbGameEvent.Event_UpdateWorldInfo)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refreshNodeInfo()
	end, zbGameEvent.Event_UpdateNodeInfo)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refreshRandNodeInfo()
	end, zbGameEvent.Event_UpdateSpecialInfo)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:worldUnlock()
	end, zbGameEvent.Event_UnlockWorldAck)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:worldLogRefresh()
	end, zbGameEvent.Event_WorldLog_Ack)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onBalanceOverWin()
	end, zbGameEvent.Event_BalanceOver_Win)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onBalanceOverLose()
	end, zbGameEvent.Event_BalanceOver_Lose)
end

function var_0_0.doShow(arg_17_0)
	if g_MainScene.wndMain then
		g_MainScene.wndMain:hide()
	end

	arg_17_0.nodeInfo:setVisible(false)
	arg_17_0.wordMap:doShow()
	arg_17_0:doOpenfogAction()
	arg_17_0:showLeftResWnd()

	if g_Self.kWorldHandler.worldInfo == nil then
		g_WsMsgHandler:WS_World_GetInfo_Req()
	else
		g_WsMsgHandler:WS_WorldSpe_GetInfo_Req()

		if arg_17_0.firstshow then
			arg_17_0:refresh()

			g_Self.kWorldHandler.needRefreshOpenDlg = false
		end

		if g_Self.kWorldHandler.needRefreshOpenDlg then
			g_Self.kWorldHandler.needRefreshOpenDlg = false

			arg_17_0.wordMap.mapOpentitleMgr:refreshInfo()
		end
	end

	arg_17_0.firstshow = false
end

function var_0_0.doOpenfogAction(arg_18_0)
	for iter_18_0 = 1, 4 do
		local var_18_0 = arg_18_0.openfogs[iter_18_0]

		if var_18_0 then
			var_18_0:setPosition(arg_18_0.openfogInitPos[iter_18_0])
		end
	end

	local var_18_1 = CCMoveTo:create(2, ccp(-596, 1195))
	local var_18_2 = CCMoveTo:create(2, ccp(1750, 890))
	local var_18_3 = CCMoveTo:create(2, ccp(-515, -487))
	local var_18_4 = CCMoveTo:create(2, ccp(1750, -487))

	arg_18_0.actions = {}
	arg_18_0.actions[1] = var_18_1
	arg_18_0.actions[2] = var_18_2
	arg_18_0.actions[3] = var_18_3
	arg_18_0.actions[4] = var_18_4

	for iter_18_1 = 1, 4 do
		local var_18_5 = arg_18_0.openfogs[iter_18_1]

		if var_18_5 then
			var_18_5:stopAllActions()
			var_18_5:runAction(arg_18_0.actions[iter_18_1])
		end
	end
end

function var_0_0.showLeftResWnd(arg_19_0)
	local var_19_0 = g_Self.kWorldHandler.worldInfo

	if var_19_0 and zbUtil:isValidTable(var_19_0.SettleList) and table.getn(var_19_0.SettleList) > 0 then
		g_MainScene:showWorldLeftResWnd(var_19_0.SettleList)
	end
end

function var_0_0.doHide(arg_20_0)
	g_MainScene:showMain()
end

function var_0_0.onFrameUpdate(arg_21_0, arg_21_1)
	if arg_21_0.isShow == false or arg_21_0:isVisible() == false then
		return
	end

	arg_21_0.wordMap:update(arg_21_1)
end

function var_0_0.refresh(arg_22_0)
	arg_22_0.wordMap:refresh()
end

function var_0_0.worldUnlock(arg_23_0)
	arg_23_0.wordMap:worldUnlock()
end

function var_0_0.refreshNodeInfo(arg_24_0)
	arg_24_0.wordMap.mapNodeMgr:initNodes()
end

function var_0_0.refreshRandNodeInfo(arg_25_0)
	arg_25_0.wordMap.mapNodeMgr:initRandNodeInfo()
end

function var_0_0.worldLogRefresh(arg_26_0)
	if arg_26_0.wordLogPnl then
		arg_26_0.wordLogPnl:refreshReslut()
	end
end

function var_0_0.foucsNode(arg_27_0, arg_27_1)
	local var_27_0 = zbWorldNodeTable:getRecord(arg_27_1)

	if var_27_0 then
		local var_27_1 = var_27_0.pixelX
		local var_27_2 = WORLD_SCENE_HEIGHT - var_27_0.pixelY

		if arg_27_0.wordMap then
			arg_27_0.wordMap:gotoPositionAndScale(var_27_1, var_27_2, true, nil, 0.9)

			local var_27_3 = arg_27_0.wordMap.mapNodeMgr:getNodeById(arg_27_1)
			local var_27_4 = ccp(var_27_3:getPosition())

			var_27_4.x = var_27_4.x + var_27_3:getContentSize().width / 2
			var_27_4.y = var_27_4.y + var_27_3:getContentSize().height / 3

			arg_27_0.wordMap:playEffectFoucs(var_27_4)
		end
	end
end

function var_0_0.playVictorEffectNode(arg_28_0, arg_28_1)
	if zbWorldNodeTable:getRecord(arg_28_1) and arg_28_0.wordMap then
		local var_28_0 = arg_28_0.wordMap.mapNodeMgr:getNodeById(arg_28_1)
		local var_28_1 = ccp(var_28_0:getPosition())

		var_28_1.x = var_28_1.x + var_28_0:getContentSize().width / 2
		var_28_1.y = var_28_1.y + var_28_0:getContentSize().height / 3

		arg_28_0.wordMap:playEffectVictor(var_28_1)
	end
end

function var_0_0.onRule(arg_29_0)
	g_MainScene:showRuleWnd(RuleType_World)
end

function var_0_0.onInfoTouchDown(arg_30_0)
	arg_30_0.nodeInfo:setVisible(true)

	local var_30_0 = g_Self.kWorldHandler.worldInfo

	if var_30_0 then
		arg_30_0.lbloccupyres:setString(a2u("\xD2\xD1ռ\xC1\xEC\xD7\xCAԴ:") .. table.getn(var_30_0.HoldNodeList))
	end
end

function var_0_0.onInfoTouchEnd(arg_31_0)
	if arg_31_0.nodeInfo:isVisible() then
		arg_31_0.nodeInfo:setVisible(false)
	end
end

function var_0_0.onBalanceOverWin(arg_32_0)
	if g_MainScene.wndEmbattle == nil or g_MainScene.wndEmbattle.battleMode ~= EMBATTLE_TYPE_WORLDHORSE and g_MainScene.wndEmbattle.battleMode ~= EMBATTLE_TYPE_WORLDRES then
		return
	end

	if g_MainScene.wndEmbattle.battleMode == EMBATTLE_TYPE_WORLDHORSE then
		g_Bubble:bubbleInfo("\xB9\xA7ϲ\xC4\xFA\xA3\xA1\xB3ɹ\xA6\xB5Ļ\xF7\xCD\xCB\xC1˴\xB3\xC8\xEB\xD5ߡ\xA3")
	elseif g_MainScene.wndEmbattle.battleMode == EMBATTLE_TYPE_WORLDRES then
		g_Bubble:bubbleInfo("\xB9\xA7ϲ\xC4\xFA\xA3\xA1\xB3ɹ\xA6ռ\xC1\xEC\xB8\xC3\xD7\xCAԴ\xB5㡣")
		arg_32_0:playVictorEffectNode(g_Self.kWorldHandler.fightResNodeId)
	end
end

function var_0_0.onBalanceOverLose(arg_33_0)
	if g_MainScene.wndEmbattle == nil or g_MainScene.wndEmbattle.battleMode ~= EMBATTLE_TYPE_WORLDHORSE and g_MainScene.wndEmbattle.battleMode ~= EMBATTLE_TYPE_WORLDRES then
		return
	end

	if g_MainScene.wndEmbattle.battleMode == EMBATTLE_TYPE_WORLDHORSE then
		g_Bubble:bubbleInfo("\xBA\xDC\xD2ź\xB6\xA3\xA1\xC4\xFAʧ\xB0\xDC\xC1ˣ\xAC\xD4\xDDʱʧȥ\xC1˴\xB3\xC8\xEB\xD5ߵ\xC4\xCF\xFBϢ\xA1\xA3")
	elseif g_MainScene.wndEmbattle.battleMode == EMBATTLE_TYPE_WORLDRES then
		g_Bubble:bubbleInfo("\xBA\xDC\xD2ź\xB6\xA3\xA1\xC7\xC0\xB6\xE1ʧ\xB0ܣ\xAC\xCC\xE1\xC9\xFDս\xC1\xA6\xBA\xF3\xD4\xD9\xC0\xB4\xCA\xD4\xCA԰ɡ\xA3")
	end
end
