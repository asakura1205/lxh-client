local var_0_0 = class("zbLegionWarHoldItem")

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

function createLegionWarHoldItem(arg_2_0, arg_2_1)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0, arg_2_1)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0()
		arg_3_0.nodeInfo = nil
		arg_3_0.parentWnd = arg_3_2
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		arg_3_0.spriteNode = tolua.cast(var_5_0:getChildByTag(1), "CCSprite")
		arg_3_0.lbName = tolua.cast(var_5_0:getChildByTag(2), "CCLabelTTF")
		arg_3_0.lbNum = tolua.cast(var_5_0:getChildByTag(3), "CCLabelTTF")
		arg_3_0.btnDefend = tolua.cast(var_5_0:getChildByTag(4), "CCControlButton")
		arg_3_0.btnAward = tolua.cast(var_5_0:getChildByTag(5), "CCControlButton")
		arg_3_0.btnGoto = tolua.cast(var_5_0:getChildByTag(6), "CCControlButton")

		arg_3_0.btnDefend:addHandleOfControlEvent(function()
			arg_3_0:onDefend()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnAward:addHandleOfControlEvent(function()
			arg_3_0:onAward()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnGoto:addHandleOfControlEvent(function()
			arg_3_0:onGoto()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnDefend:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnAward:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnGoto:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnDefend:setSwallowsTouches(false)
		arg_3_0.btnAward:setSwallowsTouches(false)
		arg_3_0.btnGoto:setSwallowsTouches(false)
		arg_3_0:setContentSize(var_5_0:getContentSize())
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_9_0, arg_9_1)
	if arg_9_1 == nil then
		return
	end

	arg_9_0.nodeInfo = arg_9_1

	local var_9_0 = zbWorldNodeTable:getRecord(arg_9_1.NodeId)

	if var_9_0 ~= nil then
		local var_9_1 = CCSpriteFrameCache:sharedSpriteFrameCache():spriteFrameByName(var_9_0.texPath)

		if var_9_1 then
			arg_9_0.spriteNode:initWithSpriteFrame(var_9_1)
		end

		arg_9_0.lbName:setString(var_9_0.name)
	end

	if arg_9_1.Legion and arg_9_1.Legion.LegionId == g_GameData.LegionInfo.LegionId then
		local var_9_2, var_9_3 = g_Self.kLegionHandler:getDenfendbyNodeId(arg_9_1.NodeId)

		arg_9_0.lbNum:setString(var_9_2 .. "/" .. var_9_3)
	end
end

function var_0_0.onDefend(arg_10_0)
	if g_Self.kLegionHandler.legionWarBaseInfo == nil then
		return
	end

	if g_Self.kLegionHandler.legionWarBaseInfo.State == ELegionWarState.Fighting then
		g_Bubble:bubbleInfo("\xBB\xE1\xB9\xDDս\xBF\xAAս\xC6ڼ䲻\xC4ܲ鿴\xC9\xE8\xD6þ\xABӢ\xBD\xB1\xC0\xF8\xA1\xA2\xB7\xC0\xCA\xD8\xD5\xF3\xC8\xDD")

		return
	end

	g_WsMsgHandler:WS_Legion_GetMembers_Req()
	g_MainScene:showLegionWarAssignWnd(arg_10_0.nodeInfo.NodeId):setPrevWnd(arg_10_0.parentWnd)
end

function var_0_0.onAward(arg_11_0)
	if g_Self.kLegionHandler.legionWarBaseInfo == nil then
		return
	end

	if g_Self.kLegionHandler.legionWarBaseInfo.State == ELegionWarState.Fighting then
		g_Bubble:bubbleInfo("\xBB\xE1\xB9\xDDս\xBF\xAAս\xC6ڼ䲻\xC4ܲ鿴\xC9\xE8\xD6þ\xABӢ\xBD\xB1\xC0\xF8\xA1\xA2\xB7\xC0\xCA\xD8\xD5\xF3\xC8\xDD")

		return
	end

	if arg_11_0.nodeInfo ~= nil then
		g_WsMsgHandler:WS_Legion_GetMembers_Req()
		g_MainScene:showLegionWarEliteSetWnd(arg_11_0.nodeInfo.NodeId)
	end
end

function var_0_0.onGoto(arg_12_0)
	if arg_12_0.nodeInfo == nil then
		return
	end

	if g_Self.kWorldHandler:isNodeOpenById(arg_12_0.nodeInfo.NodeId) == false then
		g_Bubble:bubbleInfo(a2u("\xCA\xC0\xBD\xE7\xD4\xC6δ\xBF\xAA\xC6\xF4"))

		return
	end

	g_MainScene:showWorld()
	arg_12_0.parentWnd:hide()

	if g_MainScene.wndLegionScene then
		g_MainScene.wndLegionScene:hide()
	end

	local var_12_0 = g_Self.kTimeHandler:getServerTime()
	local var_12_1 = g_Self.kLegionHandler.legionWarBaseInfo

	if var_12_1 == nil then
		return
	end

	if var_12_0 >= var_12_1.FightStartTm and var_12_0 < var_12_1.FightEndTm then
		g_WsMsgHandler:WS_LegionWar_GetFightNode_Req(arg_12_0.nodeInfo.NodeId)
	else
		g_WsMsgHandler:WS_LegionWar_GetDailyNode_Req(arg_12_0.nodeInfo.NodeId)
	end
end
