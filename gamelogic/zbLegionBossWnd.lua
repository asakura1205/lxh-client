require("gamelogic.zbBaseWnd")
require("gamelogic.zbLegionBossItem")
require("gamelogic.zbItem")

local var_0_0 = class("zbLegionBoss", zbBaseWnd)

var_0_0.__index = var_0_0
LegionBossItem_Width = 260

function createLegionBossWnd()
	local var_1_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNodeRGBA:create())))

	var_1_0:initBase()
	var_1_0:init()

	return var_1_0
end

function var_0_0.extend(arg_2_0)
	local var_2_0 = tolua.getpeer(arg_2_0)

	if not var_2_0 then
		var_2_0 = {}

		tolua.setpeer(arg_2_0, var_2_0)
	end

	setmetatable(var_2_0, var_0_0)

	return arg_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.items = {}
		arg_3_0.awardItems = {}
		arg_3_0.tableView = nil
		arg_3_0.tableViewHelper = nil
		arg_3_0.curBoss = nil
		arg_3_0.leftFighttimes = 0
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/legion_boss.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.left_arrow = tolua.cast(var_5_2:getChildByTag(1), "CCSprite")
		arg_3_0.right_arrow = tolua.cast(var_5_2:getChildByTag(2), "CCSprite")
		arg_3_0.mainLayer = tolua.cast(var_5_2:getChildByTag(3), "CCLayerColor")
		arg_3_0.awardNode = tolua.cast(var_5_2:getChildByTag(4), "CCNode")
		arg_3_0.btnRank = tolua.cast(var_5_2:getChildByTag(5), "CCControlButton")
		arg_3_0.btnFight = tolua.cast(var_5_2:getChildByTag(6), "CCControlButton")
		arg_3_0.lbTime = tolua.cast(var_5_2:getChildByTag(7), "CCLabelTTF")
		arg_3_0.btnRule = tolua.cast(var_5_2:getChildByTag(8), "CCControlButton")

		for iter_5_0 = 1, 3 do
			local var_5_3 = tolua.cast(arg_3_0.awardNode:getChildByTag(iter_5_0), "CCLayerColor")
			local var_5_4 = createItem()

			var_5_4:setPosition(var_5_3:getPosition())
			var_5_4:setScale(0.8)
			arg_3_0.awardNode:addChild(var_5_4)

			arg_3_0.awardItems[iter_5_0] = var_5_4

			var_5_3:removeFromParentAndCleanup(true)
		end

		arg_3_0.centerPositionX = arg_3_0.awardItems[2]:getPositionX()

		zbUIEffect:runFadeToAction(arg_3_0.left_arrow)
		zbUIEffect:runFadeToAction(arg_3_0.right_arrow)

		local function var_5_5(arg_6_0)
			local var_6_0 = CCSprite:create(NOTIFY_TAG_PATH)

			var_6_0:setPosition(140, 65)
			var_6_0:setVisible(false)
			arg_6_0:addChild(var_6_0)
			zbUIEffect:createNotifyTagScaleAction(var_6_0)

			return var_6_0
		end

		arg_3_0.notifyGet = var_5_5(arg_3_0.btnFight)

		arg_3_0.btnRank:addHandleOfControlEvent(function()
			arg_3_0:onRank()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnFight:addHandleOfControlEvent(function()
			arg_3_0:onFight()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnRule:addHandleOfControlEvent(function()
			arg_3_0:onRule()
		end, CCControlEventTouchUpInside)
		arg_3_0:addChild(var_5_1)
		arg_3_0:createMoneyPanel(var_5_1, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold,
			EMoneyPanelResType.Legion
		}, function()
			arg_3_0:hide()
		end)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refreshDetail()
	end, zbGameEvent.Event_LegionBoss_GetInfo_Ack)
end

function var_0_0.refresh(arg_12_0)
	if g_Self.kLegionHandler.legionDetail == nil then
		return
	end

	local var_12_0 = g_Self.kLegionHandler.legionDetail.BossInfoList

	if zbUtil:isValidTable(var_12_0) then
		arg_12_0:refreshDetail()
	else
		g_WsMsgHandler:WS_LegionBoss_GetInfo_Req()
	end
end

function var_0_0.refreshDetail(arg_13_0)
	if g_Self.kLegionHandler.legionDetail == nil then
		return
	end

	if g_GameData.LegionInfo then
		local var_13_0 = g_GameData.LegionInfo.LegionBoss

		if var_13_0 then
			arg_13_0.leftFighttimes = math.max(0, var_13_0.FightMax - var_13_0.FightCount)

			arg_13_0.lbTime:setString(arg_13_0.leftFighttimes .. "/" .. var_13_0.FightMax)
		end
	end

	arg_13_0.curBoss = g_Self.kLegionHandler:getFightingLegionBoss()

	if arg_13_0.curBoss == nil then
		local var_13_1 = g_Self.kLegionHandler.legionDetail.BossInfoList

		if zbUtil:isValidTable(var_13_1) then
			arg_13_0.curBoss = var_13_1[1]
		end
	end

	arg_13_0:refreshAward()

	local var_13_2 = g_Self.kLegionHandler.legionDetail.BossInfoList

	if zbUtil:isValidTable(var_13_2) then
		arg_13_0:createList(var_13_2)
		arg_13_0:refreshItems(var_13_2)
		arg_13_0:setSelBoss()
	end
end

function var_0_0.refreshAward(arg_14_0)
	arg_14_0.notifyGet:setVisible(false)
	arg_14_0.lbTime:setVisible(false)

	if arg_14_0.curBoss then
		zbUtil:setButtonTitle(arg_14_0.btnFight, a2u("\xCC\xF4ս"))

		if arg_14_0.curBoss.State == ELegionBossState.Fighting then
			zbUtil:setBtnEnable(arg_14_0.btnFight, true)
			arg_14_0.lbTime:setVisible(true)
		elseif arg_14_0.curBoss.State == ELegionBossState.PassNotGetAward then
			zbUtil:setBtnEnable(arg_14_0.btnFight, true)
			zbUtil:setButtonTitle(arg_14_0.btnFight, a2u("\xC1\xECȡ"))
			arg_14_0.notifyGet:setVisible(true)
		elseif arg_14_0.curBoss.State == ELegionBossState.PassHasGetAward then
			zbUtil:setBtnEnable(arg_14_0.btnFight, false)
			zbUtil:setButtonTitle(arg_14_0.btnFight, a2u("\xD2\xD1\xC1\xECȡ"))
		else
			zbUtil:setBtnEnable(arg_14_0.btnFight, false)
			arg_14_0.lbTime:setVisible(true)
		end

		for iter_14_0 = 1, 3 do
			arg_14_0.awardItems[iter_14_0]:setVisible(false)
		end

		local var_14_0 = zbLegionBossTable:getRecord(arg_14_0.curBoss.BossId)

		if var_14_0 then
			local var_14_1 = 1

			for iter_14_1, iter_14_2 in pairs(var_14_0.passAward) do
				arg_14_0.awardItems[var_14_1]:refreshAward(iter_14_2.awardType, iter_14_2.awardId, iter_14_2.awardNum, false)
				arg_14_0.awardItems[var_14_1]:setVisible(true)

				var_14_1 = var_14_1 + 1
			end

			zbUIEffect:centerStar(arg_14_0.awardItems, arg_14_0.centerPositionX)
		end
	end
end

function var_0_0.setSelBoss(arg_15_0)
	if arg_15_0.curBoss == nil then
		return
	end

	for iter_15_0, iter_15_1 in pairs(arg_15_0.items) do
		iter_15_1:setCurSel(arg_15_0.curBoss.BossId)
	end
end

function var_0_0.createList(arg_16_0, arg_16_1)
	if table.getn(arg_16_0.items) == table.getn(arg_16_1) then
		return
	end

	local var_16_0 = arg_16_1
	local var_16_1 = table.getn(var_16_0)

	for iter_16_0, iter_16_1 in pairs(arg_16_0.items) do
		iter_16_1:removeFromParentAndCleanup(true)
	end

	arg_16_0.items = {}

	if arg_16_0.tableView ~= nil then
		arg_16_0.tableView:removeFromParentAndCleanup(true)

		arg_16_0.tableView = nil
		arg_16_0.tableViewHelper = nil
	end

	local var_16_2 = arg_16_0.mainLayer:getContentSize()
	local var_16_3 = CCSizeMake(LegionBossItem_Width * var_16_1, var_16_2.height)
	local var_16_4 = CCSizeMake(var_16_2.width, var_16_2.height)

	arg_16_0.tableViewHelper = zbTableViewHelper:create()
	arg_16_0.tableView = zbTableViewHelper:createTableView(var_16_3, var_16_4, 0, arg_16_0.tableViewHelper)

	arg_16_0.tableView:setPosition(0, 0)
	arg_16_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_16_0.mainLayer:addChild(arg_16_0.tableView)
	arg_16_0.tableViewHelper:setMaskPanel(arg_16_0.left_arrow, arg_16_0.right_arrow, nil, nil)

	if var_16_1 > 0 then
		local var_16_5 = zbTableViewHelper:create()

		var_16_5:loadCCBFile("ccbi/tb_legionboss.ccbi")

		for iter_16_2 = 1, var_16_1 do
			local var_16_6 = zbLegionBossItem:create(translateAndStrokeHelper(var_16_5:readCCBNode()))

			var_16_6:retain()

			arg_16_0.items[iter_16_2] = var_16_6
		end
	end

	local var_16_7 = 1

	for iter_16_3, iter_16_4 in pairs(var_16_0) do
		local var_16_8 = arg_16_0.items[var_16_7]

		arg_16_0.tableViewHelper:addCell(var_16_8)

		var_16_7 = var_16_7 + 1
	end

	arg_16_0.tableViewHelper:refreshTabelView()
	arg_16_0.tableViewHelper:setTouchPriority(arg_16_0.btnRule:getTouchPriority())
end

function var_0_0.refreshItems(arg_17_0, arg_17_1)
	local var_17_0 = 1

	for iter_17_0, iter_17_1 in pairs(arg_17_1) do
		arg_17_0.items[var_17_0]:refresh(iter_17_1)

		var_17_0 = var_17_0 + 1
	end
end

function var_0_0.onRank(arg_18_0)
	if arg_18_0.curBoss == nil then
		return
	end

	if arg_18_0.curBoss.State == ELegionBossState.Locked then
		g_Bubble:bubbleInfo(a2u("BOSSδ\xBD\xE2\xCB\xF8"))

		return
	end

	g_MainScene:showLegionBossDamageRank(arg_18_0.curBoss.BossId)
end

function var_0_0.onFight(arg_19_0)
	if arg_19_0.curBoss == nil then
		return
	end

	if arg_19_0.curBoss.State == ELegionBossState.PassNotGetAward then
		g_WsMsgHandler:WS_LegionBoss_GetAward_Req(arg_19_0.curBoss.BossId)

		return
	end

	if arg_19_0.leftFighttimes == 0 then
		g_Bubble:bubbleInfo(a2u("\xB4\xCE\xCA\xFD\xD2Ѿ\xAD\xD3\xC3\xCD\xEA"))

		return
	end

	if arg_19_0.curBoss.State == ELegionBossState.PreLevelNotPass or arg_19_0.curBoss.State == ELegionBossState.Locked then
		g_Bubble:bubbleInfo(a2u("BOSSδ\xBD\xE2\xCB\xF8"))

		return
	end

	g_Self.kLegionHandler.fightBossInfo = arg_19_0.curBoss

	g_MainScene:showLegionBossHalo()
end

function var_0_0.onRule(arg_20_0)
	g_MainScene:showRuleWnd(RuleType_LegionBoss)
end
