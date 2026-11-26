require("gamelogic.zbLegionWarItem")
require("gamelogic.zbLegionWarHoldItem")

local var_0_0 = class("zbLegionWarWnd", zbBaseWnd)

var_0_0.__index = var_0_0

local var_0_1 = 4
local var_0_2 = 165
local var_0_3 = 160
local var_0_4 = 2
local var_0_5 = 330
local var_0_6 = 130

function createLegionWarWnd()
	local var_1_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

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
		arg_3_0.lines = {}
		arg_3_0.items = {}
		arg_3_0.tableview = nil
		arg_3_0.tableviewHelper = nil
		arg_3_0.lines1 = {}
		arg_3_0.items1 = {}
		arg_3_0.tableview1 = nil
		arg_3_0.tableviewHelper1 = nil
		arg_3_0.lines2 = {}
		arg_3_0.items2 = {}
		arg_3_0.tableview2 = nil
		arg_3_0.tableviewHelper2 = nil
		arg_3_0.refreshEndTm = 0
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/legionwar.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_3_0.lbTimeDesc = tolua.cast(var_5_2:getChildByTag(0), "CCLabelTTF")
		arg_3_0.lbRefreshTime = tolua.cast(var_5_2:getChildByTag(1), "CCLabelTTF")
		arg_3_0.spriteTalk = tolua.cast(var_5_2:getChildByTag(4), "CCSprite")
		arg_3_0.lbTalk1 = tolua.cast(arg_3_0.spriteTalk:getChildByTag(1001), "CCLabelTTF")
		arg_3_0.lbTalk2 = tolua.cast(arg_3_0.spriteTalk:getChildByTag(1002), "CCLabelTTF")

		arg_3_0.spriteTalk:setZOrder(ZORDER_TOP)

		arg_3_0.btnApply = tolua.cast(var_5_2:getChildByTag(5), "CCControlButton")

		arg_3_0.btnApply:addHandleOfControlEvent(function()
			arg_3_0:onApply()
		end, CCControlEventTouchUpInside)

		arg_3_0.layerNoHold = tolua.cast(var_5_2:getChildByTag(6), "CCLayer")
		arg_3_0.layerNoContent = tolua.cast(arg_3_0.layerNoHold:getChildByTag(1), "CCLayer")
		arg_3_0.layerHold = tolua.cast(var_5_2:getChildByTag(7), "CCLayer")
		arg_3_0.layerContent1 = tolua.cast(arg_3_0.layerHold:getChildByTag(1), "CCLayer")
		arg_3_0.layerContent2 = tolua.cast(arg_3_0.layerHold:getChildByTag(2), "CCLayer")
		arg_3_0.lbDesc = tolua.cast(arg_3_0.layerHold:getChildByTag(1001), "CCLabelTTF")
		arg_3_0.btnRule = tolua.cast(var_5_2:getChildByTag(8), "CCControlButton")

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
		arg_3_0:refresh()
	end, zbGameEvent.Event_Update_LegionWarNodeInfo)
end

function var_0_0.refresh(arg_10_0)
	if g_Self.kLegionHandler.legionWarNodeList == nil then
		return
	end

	local var_10_0, var_10_1 = g_Self.kLegionHandler:getHoldNodeList()

	if table.getn(var_10_0) == 0 then
		arg_10_0.layerNoHold:setVisible(true)
		arg_10_0.layerHold:setVisible(false)
		arg_10_0:confirmCreateView(var_10_1)
		arg_10_0:refreshItems(var_10_1)
	else
		arg_10_0.layerNoHold:setVisible(false)
		arg_10_0.layerHold:setVisible(true)
		arg_10_0:confirmCreateView1(var_10_0)
		arg_10_0:confirmCreateView2(var_10_1)
		arg_10_0:refreshItems1(var_10_0)
		arg_10_0:refreshItems2(var_10_1)
	end

	arg_10_0:refreshDetail()
end

function var_0_0.refreshDetail(arg_11_0)
	if g_Self.kLegionHandler.legionWarBaseInfo == nil then
		return
	end

	local var_11_0 = g_Self.kLegionHandler.legionWarBaseInfo
	local var_11_1 = ""
	local var_11_2 = ""
	local var_11_3 = ""
	local var_11_4 = ""

	if var_11_0.State == ELegionWarState.Normal then
		var_11_1 = "下一次会馆之战报名时间为："
		var_11_2 = "请大家速度筹备！"
		var_11_4 = "报名开始倒计时"
		var_11_3 = zbUtil:getDateBySecond(var_11_0.ApplyStartTm) .. " " .. zbUtil:SprintfHHMM(var_11_0.ApplyStartTm + g_Self.kTimeHandler:getTimeZoneDelt())
		arg_11_0.refreshEndTm = var_11_0.ApplyStartTm
	elseif var_11_0.State == ELegionWarState.Apply then
		var_11_1 = "本次会馆之战报名截止时间为："
		var_11_2 = "现为报名会馆之战时间，请未报名馆长前去报名！"
		var_11_4 = "报名截至倒计时"
		var_11_3 = zbUtil:getDateBySecond(var_11_0.ApplyEndTm) .. " " .. zbUtil:SprintfHHMM(var_11_0.ApplyEndTm + g_Self.kTimeHandler:getTimeZoneDelt())
		arg_11_0.refreshEndTm = var_11_0.ApplyEndTm
	elseif var_11_0.State == ELegionWarState.BeforeWar then
		var_11_1 = "本次会馆之战开战时间为："
		var_11_2 = "现为开战前状态,请大家速度筹备！"
		var_11_4 = "开战倒计时"
		var_11_3 = zbUtil:getDateBySecond(var_11_0.FightStartTm) .. " " .. zbUtil:SprintfHHMM(var_11_0.FightStartTm + g_Self.kTimeHandler:getTimeZoneDelt())
		arg_11_0.refreshEndTm = var_11_0.FightStartTm
	elseif var_11_0.State == ELegionWarState.Fighting then
		var_11_1 = "会馆之战正在进行中，请馆员速度支援！"
		var_11_2 = "战斗进行中……"
		var_11_4 = "结束倒计时"
		arg_11_0.refreshEndTm = var_11_0.FightEndTm
	end

	arg_11_0.lbTalk1:setString(a2u(var_11_1 .. var_11_3))
	arg_11_0.lbTalk2:setString(a2u(var_11_2))
	arg_11_0.lbTimeDesc:setString(a2u(var_11_4))

	local var_11_5 = g_Self.kLegionHandler:getOfficeById(g_Self:getPlayerId())

	arg_11_0.btnApply:setGray(var_11_5 ~= ELegionOffice.Leader)
	arg_11_0.btnApply:setVisible(var_11_0.State == ELegionWarState.Apply)
end

function var_0_0.confirmCreateView(arg_12_0, arg_12_1)
	if arg_12_0.tableView == nil then
		local var_12_0 = arg_12_0.layerNoContent:getContentSize()

		arg_12_0.tableViewHelper = zbTableViewHelper:create()
		arg_12_0.tableView = zbTableViewHelper:createTableView(var_12_0, var_12_0, 1, arg_12_0.tableViewHelper)

		arg_12_0.tableView:setPosition(0, 0)
		arg_12_0.tableView:setAnchorPoint(ccp(0, 0))
		arg_12_0.tableViewHelper:createListView("ccbi/tb_line.ccbi")
		arg_12_0.layerNoContent:addChild(arg_12_0.tableView)
	else
		arg_12_0.tableViewHelper:removeAllCells()
	end

	local var_12_1 = math.ceil(table.getn(arg_12_1) / var_0_1)
	local var_12_2 = table.getn(arg_12_0.lines)

	for iter_12_0 = 1, var_12_2 do
		if iter_12_0 <= var_12_1 then
			local var_12_3 = arg_12_0.lines[iter_12_0]

			arg_12_0.tableViewHelper:addCell(var_12_3)
		end
	end

	if var_12_1 - var_12_2 > 0 then
		local var_12_4 = zbTableViewHelper:create()

		var_12_4:loadCCBFile("ccbi/tb_legionwar.ccbi")

		for iter_12_1 = 1, var_12_1 - var_12_2 do
			local var_12_5 = arg_12_0.tableViewHelper:addListItem()

			var_12_5:setAnchorPoint(ccp(0, 0))
			var_12_5:setContentSize(CCSizeMake(var_0_2 * var_0_1, var_0_3))

			arg_12_0.lines[var_12_2 + iter_12_1] = var_12_5

			for iter_12_2 = 1, var_0_1 do
				local var_12_6 = createLegionWarItem(translateAndStrokeHelper(var_12_4:readCCBNode()), arg_12_0)

				var_12_6:setAnchorPoint(ccp(0, 0))
				var_12_6:setPosition((iter_12_2 - 1) * var_0_2, 0)
				var_12_5:addChild(var_12_6)

				arg_12_0.items[(var_12_2 + iter_12_1 - 1) * var_0_1 + iter_12_2] = var_12_6
			end
		end
	end

	for iter_12_3, iter_12_4 in pairs(arg_12_0.items) do
		iter_12_4:setVisible(false)
	end

	local var_12_7 = 1

	for iter_12_5, iter_12_6 in pairs(arg_12_1) do
		arg_12_0.items[var_12_7]:refresh(iter_12_6)
		arg_12_0.items[var_12_7]:setVisible(true)

		var_12_7 = var_12_7 + 1
	end

	arg_12_0.tableViewHelper:refreshTabelView()
	arg_12_0.tableViewHelper:setTouchPriority(arg_12_0.btnApply:getTouchPriority())
end

function var_0_0.refreshItems(arg_13_0, arg_13_1)
	local var_13_0 = 1

	for iter_13_0, iter_13_1 in pairs(arg_13_1) do
		arg_13_0.items[var_13_0]:refresh(iter_13_1)

		var_13_0 = var_13_0 + 1
	end
end

function var_0_0.onApply(arg_14_0)
	if g_Self.kLegionHandler.legionWarBaseInfo ~= nil then
		g_MainScene:showLegionWarApplyWnd()

		return
	end
end

function var_0_0.onRule(arg_15_0)
	g_MainScene:showRuleWnd(RuleType_LegionWar)
end

function var_0_0.onFrameUpdate(arg_16_0)
	if g_GameStateMachine:isOneSecondPassed() == false then
		return
	end

	if arg_16_0.refreshEndTm - g_Self.kTimeHandler:getServerTime() > 86400 then
		arg_16_0.lbRefreshTime:setString(zbUtil:getPassTime2(arg_16_0.refreshEndTm - g_Self.kTimeHandler:getServerTime()))
	elseif g_Self.kTimeHandler:getServerTime() >= arg_16_0.refreshEndTm then
		g_WsMsgHandler:WS_LegionWar_GetData_Req()
	else
		arg_16_0.lbRefreshTime:setString(zbUtil:SprintfHHMMSSNo24(arg_16_0.refreshEndTm - g_Self.kTimeHandler:getServerTime()))
	end
end

function var_0_0.confirmCreateView1(arg_17_0, arg_17_1)
	if arg_17_0.tableView1 == nil then
		local var_17_0 = arg_17_0.layerContent1:getContentSize()

		arg_17_0.tableViewHelper1 = zbTableViewHelper:create()
		arg_17_0.tableView1 = zbTableViewHelper:createTableView(var_17_0, var_17_0, 1, arg_17_0.tableViewHelper1)

		arg_17_0.tableView1:setPosition(0, 0)
		arg_17_0.tableView1:setAnchorPoint(ccp(0, 0))
		arg_17_0.tableViewHelper1:createListView("ccbi/tb_line.ccbi")
		arg_17_0.layerContent1:addChild(arg_17_0.tableView1)
	else
		arg_17_0.tableViewHelper1:removeAllCells()
	end

	local var_17_1 = math.ceil(table.getn(arg_17_1) / var_0_4)
	local var_17_2 = table.getn(arg_17_0.lines1)

	for iter_17_0 = 1, var_17_2 do
		if iter_17_0 <= var_17_1 then
			local var_17_3 = arg_17_0.lines1[iter_17_0]

			arg_17_0.tableViewHelper1:addCell(var_17_3)
		end
	end

	if var_17_1 - var_17_2 > 0 then
		local var_17_4 = zbTableViewHelper:create()

		var_17_4:loadCCBFile("ccbi/tb_legionwarhold.ccbi")

		for iter_17_1 = 1, var_17_1 - var_17_2 do
			local var_17_5 = arg_17_0.tableViewHelper1:addListItem()

			var_17_5:setAnchorPoint(ccp(0, 0))
			var_17_5:setContentSize(CCSizeMake(var_0_5 * var_0_4, var_0_6))

			arg_17_0.lines1[var_17_2 + iter_17_1] = var_17_5

			for iter_17_2 = 1, var_0_4 do
				local var_17_6 = createLegionWarHoldItem(translateAndStrokeHelper(var_17_4:readCCBNode()), arg_17_0)

				var_17_6:setAnchorPoint(ccp(0, 0))
				var_17_6:setPosition((iter_17_2 - 1) * var_0_5, 0)
				var_17_5:addChild(var_17_6)

				arg_17_0.items1[(var_17_2 + iter_17_1 - 1) * var_0_4 + iter_17_2] = var_17_6
			end
		end
	end

	for iter_17_3, iter_17_4 in pairs(arg_17_0.items1) do
		iter_17_4:setVisible(false)
	end

	local var_17_7 = 1

	for iter_17_5, iter_17_6 in pairs(arg_17_1) do
		arg_17_0.items1[var_17_7]:refresh(iter_17_6)
		arg_17_0.items1[var_17_7]:setVisible(true)

		var_17_7 = var_17_7 + 1
	end

	arg_17_0.tableViewHelper1:refreshTabelView()
	arg_17_0.tableViewHelper1:setTouchPriority(arg_17_0.btnApply:getTouchPriority())
end

function var_0_0.refreshItems1(arg_18_0, arg_18_1)
	local var_18_0 = 1

	for iter_18_0, iter_18_1 in pairs(arg_18_1) do
		arg_18_0.items1[var_18_0]:refresh(iter_18_1)

		var_18_0 = var_18_0 + 1
	end
end

function var_0_0.confirmCreateView2(arg_19_0, arg_19_1)
	if arg_19_0.tableView2 == nil then
		local var_19_0 = arg_19_0.layerContent2:getContentSize()

		arg_19_0.tableViewHelper2 = zbTableViewHelper:create()
		arg_19_0.tableView2 = zbTableViewHelper:createTableView(var_19_0, var_19_0, 1, arg_19_0.tableViewHelper2)

		arg_19_0.tableView2:setPosition(0, 0)
		arg_19_0.tableView2:setAnchorPoint(ccp(0, 0))
		arg_19_0.tableViewHelper2:createListView("ccbi/tb_line.ccbi")
		arg_19_0.layerContent2:addChild(arg_19_0.tableView2)
	else
		arg_19_0.tableViewHelper2:removeAllCells()
	end

	local var_19_1 = math.ceil(table.getn(arg_19_1) / var_0_1)
	local var_19_2 = table.getn(arg_19_0.lines2)

	for iter_19_0 = 1, var_19_2 do
		if iter_19_0 <= var_19_1 then
			local var_19_3 = arg_19_0.lines2[iter_19_0]

			arg_19_0.tableViewHelper2:addCell(var_19_3)
		end
	end

	if var_19_1 - var_19_2 > 0 then
		local var_19_4 = zbTableViewHelper:create()

		var_19_4:loadCCBFile("ccbi/tb_legionwar.ccbi")

		for iter_19_1 = 1, var_19_1 - var_19_2 do
			local var_19_5 = arg_19_0.tableViewHelper2:addListItem()

			var_19_5:setAnchorPoint(ccp(0, 0))
			var_19_5:setContentSize(CCSizeMake(var_0_2 * var_0_1, var_0_3))

			arg_19_0.lines2[var_19_2 + iter_19_1] = var_19_5

			for iter_19_2 = 1, var_0_1 do
				local var_19_6 = createLegionWarItem(translateAndStrokeHelper(var_19_4:readCCBNode()), arg_19_0)

				var_19_6:setAnchorPoint(ccp(0, 0))
				var_19_6:setPosition((iter_19_2 - 1) * var_0_2, 0)
				var_19_5:addChild(var_19_6)

				arg_19_0.items2[(var_19_2 + iter_19_1 - 1) * var_0_1 + iter_19_2] = var_19_6
			end
		end
	end

	for iter_19_3, iter_19_4 in pairs(arg_19_0.items2) do
		iter_19_4:setVisible(false)
	end

	local var_19_7 = 1

	for iter_19_5, iter_19_6 in pairs(arg_19_1) do
		arg_19_0.items2[var_19_7]:refresh(iter_19_6)
		arg_19_0.items2[var_19_7]:setVisible(true)

		var_19_7 = var_19_7 + 1
	end

	arg_19_0.tableViewHelper2:refreshTabelView()
	arg_19_0.tableViewHelper2:setTouchPriority(arg_19_0.btnApply:getTouchPriority())
end

function var_0_0.refreshItems2(arg_20_0, arg_20_1)
	local var_20_0 = 1

	for iter_20_0, iter_20_1 in pairs(arg_20_1) do
		arg_20_0.items2[var_20_0]:refresh(iter_20_1)

		var_20_0 = var_20_0 + 1
	end
end
