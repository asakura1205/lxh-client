require("gamelogic.zbBaseWnd")
require("gamelogic.zbItem")

local var_0_0 = class("zbWorldResInfoWnd", zbBaseWnd)

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

function createWorldResInfoWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNodeRGBA:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.heroItems = {}
		arg_3_0.worldNodeRecord = nil
		arg_3_0.nodeId = 0
		arg_3_0.cooldown = 0
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/world_resinfo.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner", false, false)
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.layer = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.lbTitle = tolua.cast(var_5_2:getChildByTag(1), "CCLabelTTF")
		arg_3_0.lbDesc = tolua.cast(var_5_2:getChildByTag(1002), "CCLabelTTF")
		arg_3_0.lbName = tolua.cast(var_5_2:getChildByTag(3), "CCLabelTTF")
		arg_3_0.spriteHead = tolua.cast(var_5_2:getChildByTag(4), "CCSprite")

		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1003), "CCLabelTTF")
		local var_5_4 = tolua.cast(var_5_2:getChildByTag(1004), "CCLabelTTF")

		arg_3_0.lbLegion = tolua.cast(var_5_2:getChildByTag(1007), "CCLabelTTF")
		arg_3_0.lbFormationLv = tolua.cast(var_5_2:getChildByTag(8), "CCLabelTTF")
		arg_3_0.spriteTalk = tolua.cast(var_5_2:getChildByTag(5), "CCSprite")
		arg_3_0.lbTalk = tolua.cast(arg_3_0.spriteTalk:getChildByTag(4), "CCLabelTTF")

		local var_5_5 = tolua.cast(var_5_2:getChildByTag(9), "CCLayer")

		for iter_5_0 = 1, 5 do
			local var_5_6 = tolua.cast(var_5_5:getChildByTag(iter_5_0), "CCNode")
			local var_5_7 = createItem()

			var_5_7:setPosition(var_5_6:getPosition())
			var_5_7:setScale(0.8)
			var_5_7:setNeedTip(false)

			arg_3_0.heroItems[iter_5_0] = var_5_7

			var_5_5:addChild(var_5_7)
			var_5_6:removeFromParentAndCleanup(true)
		end

		arg_3_0.spriteMoney = tolua.cast(var_5_2:getChildByTag(10), "CCSprite")

		local var_5_8 = tolua.cast(var_5_2:getChildByTag(1011), "CCLabelTTF")

		arg_3_0.btnFight = tolua.cast(var_5_2:getChildByTag(12), "CCControlButton")
		arg_3_0.btnChange = tolua.cast(var_5_2:getChildByTag(13), "CCControlButton")
		arg_3_0.nodeCD = tolua.cast(var_5_2:getChildByTag(14), "CCNode")
		arg_3_0.btnCDClear = tolua.cast(arg_3_0.nodeCD:getChildByTag(1), "CCControlButton")
		arg_3_0.lbCDTime = tolua.cast(arg_3_0.nodeCD:getChildByTag(2), "CCLabelTTF")
		arg_3_0.lbCDTimeDes = tolua.cast(arg_3_0.nodeCD:getChildByTag(1003), "CCLabelTTF")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnFight:addHandleOfControlEvent(function()
			arg_3_0:onFight()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnChange:addHandleOfControlEvent(function()
			arg_3_0:onChange()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnCDClear:addHandleOfControlEvent(function()
			arg_3_0:onCDClear()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)

		arg_3_0.lbMoney = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_8, arg_3_0.lbMoney)
		arg_3_0.lbMoney:setScale(0.6)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refresh()
	end, zbGameEvent.Event_UpdateNodeInfo)
end

function var_0_0.refresh(arg_12_0, arg_12_1)
	if arg_12_1 ~= nil then
		arg_12_0.nodeId = arg_12_1
	end

	local var_12_0 = g_Self.kWorldHandler:getWorldNodeResInfoById(type == EWorldNodeOccupyType.E_LOSE, arg_12_0.nodeId)

	if var_12_0 == nil then
		return
	end

	local var_12_1 = CCArray:create()

	var_12_1:addObject(CCCallFuncN:create(function()
		arg_12_0.spriteTalk:setVisible(true)
	end))
	var_12_1:addObject(CCDelayTime:create(3))
	var_12_1:addObject(CCCallFuncN:create(function()
		arg_12_0.spriteTalk:setVisible(false)
	end))

	local var_12_2 = CCSequence:create(var_12_1)

	arg_12_0.spriteTalk:stopAllActions()
	arg_12_0.spriteTalk:runAction(var_12_2)
	arg_12_0.lbTalk:setString(var_12_0.Taunt)
	arg_12_0.lbName:setString(var_12_0.PlayerName)
	arg_12_0.lbFormationLv:setString(a2u("\xCAػ\xA4\xD5\xF3\xC1еȼ\xB6:") .. var_12_0.NpcLevel .. a2u("\xBC\xB6"))

	if var_12_0.LegionId == 0 then
		arg_12_0.lbLegion:setString(a2u("\xBB\xE1\xB9\xDD:\xCE\xDE"))
	else
		arg_12_0.lbLegion:setString(a2u("\xBB\xE1\xB9\xDD:") .. a2u(var_12_0.LegionName))
	end

	local var_12_3 = zbIconHelper:getPlayerHeadIconPath(var_12_0.HeadId)

	arg_12_0.spriteHead:setTexture(CCTextureCache:sharedTextureCache():addImage(var_12_3))

	arg_12_0.worldNodeRecord = zbWorldNodeTable:getRecord(arg_12_0.nodeId)

	if arg_12_0.worldNodeRecord ~= nil then
		arg_12_0.lbTitle:setString(arg_12_0.worldNodeRecord.name)
		arg_12_0.lbDesc:setString(arg_12_0.worldNodeRecord.desc)
		arg_12_0.lbMoney:setString(arg_12_0.worldNodeRecord.fightneedFood)
	end

	local var_12_4 = math.max(g_Self.kTimeHandler:getServerTime() - var_12_0.RefreshTm, 0)

	arg_12_0.cooldown = math.floor(math.max(g_DataConfig.kWorldBaseTable.res.refreshCD - var_12_4, 0))

	if arg_12_0.cooldown > g_DataConfig.kWorldBaseTable.res.refreshCD or arg_12_0.cooldown <= 1 then
		arg_12_0.nodeCD:setVisible(false)
		arg_12_0.btnChange:setVisible(true)
	else
		arg_12_0.lbCDTime:setString(zbUtil:SprintfHHMMSSNo24(arg_12_0.cooldown))
		arg_12_0.nodeCD:setVisible(true)
		arg_12_0.btnChange:setVisible(false)
	end

	for iter_12_0 = 1, 5 do
		arg_12_0.heroItems[iter_12_0]:setVisible(false)
	end

	local var_12_5 = zbWorldNodeTable:getWorldNpcList(arg_12_0.nodeId)
	local var_12_6 = 1

	for iter_12_1, iter_12_2 in pairs(var_12_5) do
		if var_12_6 <= 5 then
			arg_12_0.heroItems[var_12_6]:refreshNpc(iter_12_2, var_12_0.NpcLevel)
			arg_12_0.heroItems[var_12_6]:setVisible(true)
		end

		var_12_6 = var_12_6 + 1
	end
end

local var_0_1 = os_timenow()

function var_0_0.onFrameUpdate(arg_15_0)
	if arg_15_0.isShow == false then
		return false
	end

	local var_15_0 = os_timenow()
	local var_15_1 = var_15_0 - var_0_1

	if var_15_1 < 1 then
		return
	end

	var_0_1 = var_15_0

	if arg_15_0.cooldown > g_DataConfig.kWorldBaseTable.res.refreshCD or arg_15_0.cooldown <= 1 then
		arg_15_0.btnChange:setVisible(true)
		arg_15_0.nodeCD:setVisible(false)

		return
	end

	arg_15_0.btnChange:setVisible(false)
	arg_15_0.nodeCD:setVisible(true)

	arg_15_0.cooldown = arg_15_0.cooldown - var_15_1

	local var_15_2 = zbUtil:SprintfMMSS(arg_15_0.cooldown)

	arg_15_0.lbCDTime:setString(var_15_2)
end

function var_0_0.onFight(arg_16_0)
	if arg_16_0.worldNodeRecord == nil then
		return
	end

	if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Food, arg_16_0.worldNodeRecord.fightneedFood) == false then
		g_Bubble:bubbleInfo(a2u("è\xB7\xB9"))

		return
	end

	arg_16_0:hide()

	if g_MainScene.wndMain then
		g_MainScene.wndMain:hide()
	end

	g_Self.kWorldHandler.combatSeceneId = arg_16_0.worldNodeRecord.sceneId
	g_Self.kWorldHandler.fightResNodeId = arg_16_0.nodeId

	g_MainScene:showEmbattleWorldRes(arg_16_0.nodeId)
end

function var_0_0.onChange(arg_17_0)
	g_WsMsgHandler:WS_WorldRes_Refresh_Req(arg_17_0.nodeId)
end

function var_0_0.onCDClear(arg_18_0)
	g_MainScene:showCDClearWnd(arg_18_0.nodeId)
end

function var_0_0.onTouchTest(arg_19_0)
	local var_19_0 = arg_19_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_19_0.layer, var_19_0.x, var_19_0.y) == false then
		arg_19_0:hide()
	end
end
