require("gamelogic.zbMapNodeBase")

local var_0_0 = class("zbMapNodeRes", zbMapNodeBase)

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

function createMapNodeRes(arg_2_0)
	local var_2_0 = var_0_0.extend(zbMapNodeBase.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.record = arg_3_1
		arg_3_0.type = EWorldNodeOccupyType.E_HOLD
		arg_3_0.data = nil
		arg_3_0.resOutPer = 0
		arg_3_0.holdTime = 0
	end

	local var_3_1 = CCBProxy:create()
	local var_3_2 = CCBReaderLoad("ccbi/tb_worldnode.ccbi", var_3_1, true, "HelloCocosBuilderLayerOwner")
	local var_3_3 = tolua.cast(var_3_2:getChildByTag(1), "CCLayerColor")

	var_3_3:removeFromParentAndCleanup(false)

	arg_3_0.layer = var_3_3
	arg_3_0.resBg = tolua.cast(var_3_3:getChildByTag(1), "CCSprite")
	arg_3_0.holdHud = tolua.cast(var_3_3:getChildByTag(5), "CCSprite")

	zbUIEffect:runMoveByAction(arg_3_0.holdHud, 25)

	arg_3_0.hud = tolua.cast(var_3_3:getChildByTag(3), "CCNode")

	tolua.cast(var_3_3:getChildByTag(4), "CCSprite"):setVisible(false)

	arg_3_0.resArrowUp = tolua.cast(var_3_3:getChildByTag(6), "CCSprite")
	arg_3_0.hudbg = tolua.cast(arg_3_0.hud:getChildByTag(1), "CCSprite")
	arg_3_0.nodelv = tolua.cast(arg_3_0.hud:getChildByTag(2), "CCNode")

	local var_3_4 = tolua.cast(arg_3_0.nodelv:getChildByTag(1001), "CCLabelTTF")

	arg_3_0.lbLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

	require("gamebase.zbUI"):replaceCtrl(var_3_4, arg_3_0.lbLevel)
	arg_3_0.lbLevel:setScale(0.45)

	arg_3_0.nodebottom = tolua.cast(var_3_3:getChildByTag(2), "CCNode")
	arg_3_0.nodeName = tolua.cast(arg_3_0.nodebottom:getChildByTag(1003), "CCLabelTTF")

	arg_3_0:setContentSize(CCSizeMake(100, 150))
	arg_3_0:setAnchorPoint(ccp(0, 0))

	arg_3_0.notifyTag = (function(arg_5_0)
		local var_5_0 = CCSprite:create(NOTIFY_TAG_PATH)

		var_5_0:setPosition(90, 15)
		var_5_0:setVisible(false)
		arg_5_0:addChild(var_5_0)
		zbUIEffect:createNotifyTagScaleAction(var_5_0)

		return var_5_0
	end)(var_3_3)

	arg_3_0:addChild(var_3_3)
	var_3_0()
	arg_3_0:initBaseInfo()
end

function var_0_0.initBaseInfo(arg_6_0)
	if arg_6_0.record then
		local var_6_0 = arg_6_0.record.pixelX
		local var_6_1 = WORLD_SCENE_HEIGHT - arg_6_0.record.pixelY

		arg_6_0:setPosition(var_6_0 - arg_6_0:getContentSize().width / 2, var_6_1 - arg_6_0:getContentSize().height / 2)
		arg_6_0.nodeName:setString(arg_6_0.record.name)

		local var_6_2 = arg_6_0.record.texPath
		local var_6_3 = CCSpriteFrameCache:sharedSpriteFrameCache():spriteFrameByName(var_6_2)

		if var_6_3 then
			arg_6_0.resBg:initWithSpriteFrame(var_6_3)
		end
	end
end

function var_0_0.setlayerVisible(arg_7_0, arg_7_1)
	arg_7_0.layer:setVisible(arg_7_1)
end

function var_0_0.refresh(arg_8_0, arg_8_1)
	arg_8_0.type = arg_8_1

	if arg_8_0.record == nil then
		return
	end

	arg_8_0.data = g_Self.kWorldHandler:getWorldNodeResInfoById(arg_8_1, arg_8_0.record.id)

	arg_8_0:setlayerVisible(true)
	arg_8_0.nodelv:setVisible(arg_8_1 == EWorldNodeOccupyType.E_LOSE)
	arg_8_0.holdHud:setVisible(arg_8_1 == EWorldNodeOccupyType.E_HOLD)
	arg_8_0.hud:setVisible(arg_8_1 == EWorldNodeOccupyType.E_LOSE)

	if arg_8_0.data then
		if arg_8_1 == EWorldNodeOccupyType.E_LOSE then
			local var_8_0 = CCSpriteFrameCache:sharedSpriteFrameCache():spriteFrameByName("world_pop4.png")

			if var_8_0 then
				arg_8_0.hudbg:initWithSpriteFrame(var_8_0)
			end

			arg_8_0.lbLevel:setString(arg_8_0.data.NpcLevel)
		else
			zbWordHelp:setResIconByResType(arg_8_0.holdHud, arg_8_0.record)

			arg_8_0.curOut = 0

			local var_8_1 = g_Self.kWorldHandler:getWorldNodeResInfoById(EWorldNodeOccupyType.E_HOLD, arg_8_0.record.id)

			arg_8_0.holdTime = g_Self.kWorldHandler:getHoldAndFullSecondsByNodeId(arg_8_0.record.id)

			if var_8_1 then
				arg_8_0.resOutPer = var_8_1.Output
			end

			arg_8_0.curOut = arg_8_0.holdTime / 3600 * tonumber(arg_8_0.resOutPer)

			if arg_8_0.curOut / arg_8_0.record.maxOut > 0.05 then
				arg_8_0.holdHud:setVisible(true)
			else
				arg_8_0.holdHud:setVisible(false)
			end
		end
	end

	local var_8_2 = 0

	for iter_8_0, iter_8_1 in pairs(zbWorldNodeTable.records) do
		if arg_8_0.record.areaId == iter_8_1.areaId and EWorldNodeType.GodDomain == iter_8_1.nodeType then
			var_8_2 = iter_8_1.id

			break
		end
	end

	local var_8_3

	if zbUtil:isValidTable(g_Self.kLegionHandler.legionWarNodeList) == true then
		for iter_8_2, iter_8_3 in pairs(g_Self.kLegionHandler.legionWarNodeList) do
			if var_8_2 == iter_8_3.NodeId then
				var_8_3 = iter_8_3
			end
		end
	end

	if var_8_3 and arg_8_1 == EWorldNodeOccupyType.E_HOLD and g_GameData.LegionInfo.LegionId ~= 0 and var_8_3.Legion.LegionId == g_GameData.LegionInfo.LegionId then
		arg_8_0.resArrowUp:setVisible(true)
		zbUIEffect:runMoveByAction(arg_8_0.resArrowUp, 20)
	else
		arg_8_0.resArrowUp:setVisible(false)
	end
end

function var_0_0.refreshInfo(arg_9_0)
	return
end

function var_0_0.onClick(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	local var_10_0 = g_Self.kWorldHandler:getWorldNodeResInfoById(arg_10_0.type, arg_10_0.record.id)

	if var_10_0 == nil then
		return
	end

	if arg_10_0.record.id == g_Self.kWorldHandler.changeNodeId then
		g_Self.kWorldHandler.changeNodeId = 0
	end

	if arg_10_0.type == EWorldNodeOccupyType.E_HOLD then
		if arg_10_0.holdHud:isVisible() then
			g_WsMsgHandler:WS_WorldRes_Gain_Req(var_10_0.NodeId)
		else
			g_MainScene:showWorldResWnd(var_10_0.NodeId)
		end
	elseif arg_10_0.type == EWorldNodeOccupyType.E_LOSE then
		g_MainScene:showWorldResInfoWnd(var_10_0.NodeId)

		local var_10_1 = tonumber(string.format("2%d", zbWorldNodeTable:getGuideTalkId(var_10_0.NodeId)))

		arg_10_0.guideTalkKey = g_Login.account .. "_" .. g_Login.lastServerId .. "_world" .. var_10_1

		local var_10_2 = zbGameCore:Instance():getConfigValue(arg_10_0.guideTalkKey)

		if g_Guide:isGuiding() == false and (var_10_2 == nil or var_10_2 == "") then
			g_MainScene:showGuideTalkWnd(var_10_1, function()
				arg_10_0:saveGuideTalkConfig()
			end, true)
		end

		arg_10_0:saveGuideTalkConfig()
	end
end

function var_0_0.saveGuideTalkConfig(arg_12_0)
	zbGameCore:Instance():setConfigValue(arg_12_0.guideTalkKey, 1)
	zbGameCore:Instance():saveConfig()
end

function var_0_0.update(arg_13_0)
	if arg_13_0.data == nil or arg_13_0.record == nil then
		return
	end

	if g_GameStateMachine:isOneSecondPassed() == false then
		return
	end

	if arg_13_0.type == EWorldNodeOccupyType.E_HOLD and arg_13_0:isVisible() then
		arg_13_0.holdTime = g_Self.kWorldHandler:getHoldAndFullSecondsByNodeId(arg_13_0.record.id)
		arg_13_0.curOut = arg_13_0.holdTime / 3600 * tonumber(arg_13_0.resOutPer)

		arg_13_0.notifyTag:setVisible(arg_13_0.curOut / arg_13_0.record.maxOut >= 1)

		if arg_13_0.curOut / arg_13_0.record.maxOut > 0.05 then
			arg_13_0.holdHud:setVisible(true)
		else
			arg_13_0.holdHud:setVisible(false)
		end
	elseif arg_13_0.type == EWorldNodeOccupyType.E_LOSE and arg_13_0:isVisible() then
		local var_13_0 = false

		if arg_13_0.record.id == g_Self.kWorldHandler.changeNodeId then
			var_13_0 = true
		end

		arg_13_0.notifyTag:setVisible(var_13_0)
	end
end
