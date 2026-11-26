require("gamelogic.zbBaseWnd")
require("gamelogic.zbItem")
require("gamelogic.zbLegionWarLevelPanel")

local var_0_0 = class("zbLegionWar_PositionWnd", zbBaseWnd)

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

function createLegionWarPositionWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNodeRGBA:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.lbPlayName = {}
		arg_3_0.nodeHeroList = {}
		arg_3_0.btnHero = {}
		arg_3_0.nodeOccupy = {}
		arg_3_0.nodeReport = {}
		arg_3_0.lbLegion = {}
		arg_3_0.lbCount = {}
		arg_3_0.lbScore = {}
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/legionwar_position.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner", false, false)
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.lbTitle = tolua.cast(var_5_1:getChildByTag(102):getChildByTag(1), "CCLabelTTF")
		arg_3_0.layer = var_5_2
		arg_3_0.nodeLeft = tolua.cast(arg_3_0.layer:getChildByTag(11), "CCNode")

		for iter_5_0 = 1, 6 do
			arg_3_0.nodeHeroList[iter_5_0] = tolua.cast(arg_3_0.nodeLeft:getChildByTag(iter_5_0), "CCNode")
			arg_3_0.btnHero[iter_5_0] = tolua.cast(arg_3_0.nodeHeroList[iter_5_0]:getChildByTag(1), "CCControlButton")
			arg_3_0.lbPlayName[iter_5_0] = tolua.cast(arg_3_0.nodeHeroList[iter_5_0]:getChildByTag(2), "CCLabelTTF")

			arg_3_0.btnHero[iter_5_0]:addHandleOfControlEvent(function()
				arg_3_0:onHero(iter_5_0)
			end, CCControlEventTouchUpInside)
		end

		arg_3_0.lbCDTimeTemp = tolua.cast(arg_3_0.nodeLeft:getChildByTag(11), "CCLabelTTF")
		arg_3_0.lbCDTimeDummy = tolua.cast(arg_3_0.nodeLeft:getChildByTag(12), "CCLabelTTF")
		arg_3_0.lbCDTime = zbTimeLabel:create(arg_3_0.lbCDTimeDummy, "", "")
		arg_3_0.nodeForce = tolua.cast(var_5_2:getChildByTag(100), "CCNode")
		arg_3_0.pnlForce = createLegionWarLevelPanel()

		arg_3_0.nodeForce:addChild(arg_3_0.pnlForce)

		arg_3_0.btnReport = tolua.cast(var_5_2:getChildByTag(12), "CCControlButton")

		arg_3_0.btnReport:addHandleOfControlEvent(function()
			arg_3_0:onReport()
		end, CCControlEventTouchUpInside)

		arg_3_0.btnLog = tolua.cast(var_5_2:getChildByTag(13), "CCControlButton")

		arg_3_0.btnLog:addHandleOfControlEvent(function()
			arg_3_0:onLog()
		end, CCControlEventTouchUpInside)

		arg_3_0.lbJiaCheng1 = tolua.cast(var_5_2:getChildByTag(50), "CCLabelTTF")
		arg_3_0.lbJiaCheng2 = tolua.cast(var_5_2:getChildByTag(51), "CCLabelTTF")
		arg_3_0.layerOccupy = tolua.cast(var_5_1:getChildByTag(101), "CCLayer")
		arg_3_0.spriteHead = tolua.cast(arg_3_0.layerOccupy:getChildByTag(2), "CCSprite")
		arg_3_0.lbname = tolua.cast(arg_3_0.spriteHead:getChildByTag(1), "CCLabelTTF")
		arg_3_0.lbLegionName = tolua.cast(arg_3_0.layerOccupy:getChildByTag(1), "CCLabelTTF")

		for iter_5_1 = 1, 3 do
			arg_3_0.nodeOccupy[iter_5_1] = tolua.cast(arg_3_0.layerOccupy:getChildByTag(iter_5_1 + 10), "CCNode")
			arg_3_0.lbLegion[iter_5_1] = tolua.cast(arg_3_0.nodeOccupy[iter_5_1]:getChildByTag(1), "CCLabelTTF")

			local var_5_3 = tolua.cast(arg_3_0.nodeOccupy[iter_5_1]:getChildByTag(1001), "CCLabelTTF")
			local var_5_4 = tolua.cast(arg_3_0.nodeOccupy[iter_5_1]:getChildByTag(1002), "CCLabelTTF")

			arg_3_0.lbScore[iter_5_1] = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

			require("gamebase.zbUI"):replaceCtrl(var_5_4, arg_3_0.lbScore[iter_5_1])
			arg_3_0.lbScore[iter_5_1]:setScale(0.5)
		end

		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
		arg_3_0:createMoneyPanel(var_5_1, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold
		}, function()
			arg_3_0:hide()
		end)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refresh()
	end, zbGameEvent.Event_Update_LegionWarNodeInfo)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:hide()
	end, zbGameEvent.Event_LegionWarFight_Ack)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refreshOccupy()
	end, zbGameEvent.Event_LegionWarReport)
end

function var_0_0.gotoForce(arg_13_0, arg_13_1)
	arg_13_0.nodeId = arg_13_1
	arg_13_0.warNode = nil

	for iter_13_0 = 1, 6 do
		arg_13_0.nodeHeroList[iter_13_0]:setVisible(false)
	end

	arg_13_0.lbJiaCheng1:setVisible(true)
	arg_13_0.lbJiaCheng2:setVisible(true)

	for iter_13_1, iter_13_2 in pairs(g_Self.kLegionHandler.legionWarNodeList) do
		if arg_13_1 == iter_13_2.NodeId then
			arg_13_0.pnlForce:gotoForce(iter_13_2)

			arg_13_0.warNode = iter_13_2
		end
	end

	arg_13_0:refresh()

	local var_13_0 = zbWarNodeTable:getRecord(arg_13_0.warNode.NodeId)

	if var_13_0 == nil then
		return
	end

	local var_13_1 = zbBuffTable:getRecord(var_13_0.buildNode[2].buildBuff)

	if var_13_1 ~= nil then
		arg_13_0.lbJiaCheng1:setString(var_13_0.buildNode[2].buildName .. a2u("Ϊ\xCB\xF9\xD3з\xC0\xCA\xD8") .. var_13_1.description)
	end

	local var_13_2 = zbBuffTable:getRecord(var_13_0.buildNode[3].buildBuff)

	if var_13_2 ~= nil then
		arg_13_0.lbJiaCheng2:setString(var_13_0.buildNode[3].buildName .. a2u("Ϊ\xCB\xF9\xD3з\xC0\xCA\xD8") .. var_13_2.description)
	end
end

function var_0_0.onFrameUpdate(arg_14_0)
	if arg_14_0.lbCDTime == nil then
		return
	end

	if string.trim(arg_14_0.lbCDTime.label:getString()) == "" then
		arg_14_0.lbCDTimeTemp:setVisible(false)
	else
		arg_14_0.lbCDTimeTemp:setVisible(true)
	end
end

function var_0_0.refresh(arg_15_0)
	local var_15_0 = zbWorldNodeTable:getRecord(arg_15_0.warNode.NodeId)

	if var_15_0 then
		arg_15_0.lbTitle:setString(var_15_0.name)
	end

	if zbUtil:isValidTable(g_Self.kLegionHandler.legionWarPlayerList) == false or zbUtil:isValidTable(arg_15_0.warNode) == false then
		return
	end

	local var_15_1 = 1

	for iter_15_0, iter_15_1 in pairs(g_Self.kLegionHandler.legionWarPlayerList) do
		local var_15_2 = zbIconHelper:getPlayerHeadIconPath(iter_15_1.PlayerTipsInfo.HeadId)

		require("gamebase.zbUI"):setButtonPic(arg_15_0.btnHero[var_15_1], var_15_2, var_15_2, var_15_2)
		zbUtil:setHighlightSprite(arg_15_0.btnHero[var_15_1], var_15_2)
		arg_15_0.lbPlayName[var_15_1]:setString(iter_15_1.PlayerTipsInfo.RoleName)
		arg_15_0.nodeHeroList[var_15_1]:setVisible(true)

		var_15_1 = var_15_1 + 1
	end

	arg_15_0.lbCDTime:clear()
	arg_15_0.lbCDTime:start(arg_15_0.warNode.CD)

	if arg_15_0.warNode.CDState == 0 then
		arg_15_0.lbCDTime.label:setColor(FONT_COLOR_WHITE)
	else
		arg_15_0.lbCDTime.label:setColor(FONT_COLOR_RED)
	end

	arg_15_0.layerOccupy:setVisible(arg_15_0.warNode.NodeState == ELegionWarNodeState.Occupy)

	if arg_15_0.warNode.NodeState == ELegionWarNodeState.Occupy then
		arg_15_0.lbname:setString(var_15_0.name)

		local var_15_3 = CCSpriteFrameCache:sharedSpriteFrameCache():spriteFrameByName(var_15_0.texPath)

		if var_15_3 then
			arg_15_0.spriteHead:initWithSpriteFrame(var_15_3)
		end

		if arg_15_0.warNode.Legion and arg_15_0.warNode.Legion.LegionName and arg_15_0.warNode.Legion.LegionName ~= "" then
			arg_15_0.lbLegionName:setString(a2u(arg_15_0.warNode.Legion.LegionName))
		else
			arg_15_0.lbLegionName:setString("")
		end

		arg_15_0.showReportWnd = false

		g_WsMsgHandler:WS_LegionWar_Report_Req(arg_15_0.nodeId)
	end
end

function var_0_0.refreshOccupy(arg_16_0)
	local var_16_0 = g_Self.kLegionHandler.legionWarReport

	if zbUtil:isValidTable(var_16_0) == false or zbUtil:isValidTable(var_16_0.LegionWarReport) == false then
		return
	end

	if arg_16_0.showReportWnd == true then
		g_MainScene:showLegionWarReportWnd(var_16_0)
	else
		for iter_16_0 = 1, 3 do
			arg_16_0.nodeOccupy[iter_16_0]:setVisible(false)
		end

		local var_16_1 = 1

		for iter_16_1, iter_16_2 in pairs(var_16_0.LegionWarReport) do
			if var_16_1 > 3 then
				break
			end

			arg_16_0.nodeOccupy[var_16_1]:setVisible(true)
			arg_16_0.lbLegion[var_16_1]:setString(a2u(iter_16_2.Legion.LegionName))
			arg_16_0.lbScore[var_16_1]:setString(iter_16_2.Score)

			var_16_1 = var_16_1 + 1
		end
	end
end

function var_0_0.onHero(arg_17_0, arg_17_1)
	local var_17_0 = 1

	for iter_17_0, iter_17_1 in pairs(g_Self.kLegionHandler.legionWarPlayerList) do
		if var_17_0 == arg_17_1 then
			g_MainScene:showLegionWarPlayerWnd(arg_17_0.warNode, iter_17_1)

			return
		end

		var_17_0 = var_17_0 + 1
	end
end

function var_0_0.onReport(arg_18_0)
	arg_18_0.showReportWnd = true

	g_WsMsgHandler:WS_LegionWar_Report_Req(arg_18_0.nodeId)
end

function var_0_0.onLog(arg_19_0)
	g_WsMsgHandler:WS_LegionWar_Log_Req(arg_19_0.nodeId)
end
