require("gamelogic.zbLegionItem")

local var_0_0 = class("zbLegionNo_Join")

var_0_0.__index = var_0_0

local var_0_1 = 765
local var_0_2 = 110

function createLegionJoinPanel(arg_1_0)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	local function var_2_0()
		arg_2_0.items = {}
		arg_2_0.tableview = nil
		arg_2_0.tableviewHelper = nil
		arg_2_0.bCdEnd = false
		arg_2_0.needTime = 0
	end

	local function var_2_1()
		arg_2_0.layer = arg_2_1
		arg_2_0.nodeNone = tolua.cast(arg_2_1:getChildByTag(1), "CCNode")
		arg_2_0.mainLayer = tolua.cast(arg_2_0.nodeNone:getChildByTag(1), "CCLayer")
		arg_2_0.btnQuickJoin = tolua.cast(arg_2_0.nodeNone:getChildByTag(6), "CCControlButton")
		arg_2_0.btnNext = tolua.cast(arg_2_0.nodeNone:getChildByTag(3), "CCControlButton")
		arg_2_0.btnPre = tolua.cast(arg_2_0.nodeNone:getChildByTag(4), "CCControlButton")
		arg_2_0.lbPage = tolua.cast(arg_2_0.nodeNone:getChildByTag(2), "CCLabelTTF")
		arg_2_0.lbCdTitle = tolua.cast(arg_2_1:getChildByTag(4), "CCLabelTTF")
		arg_2_0.lbCdTime = tolua.cast(arg_2_1:getChildByTag(5), "CCLabelTTF")

		arg_2_0.lbCdTitle:setVisible(false)
		arg_2_0.lbCdTime:setString("")
		arg_2_0.btnNext:addHandleOfControlEvent(function()
			arg_2_0:onNext()
		end, CCControlEventTouchUpInside)
		arg_2_0.btnPre:addHandleOfControlEvent(function()
			arg_2_0:onPre()
		end, CCControlEventTouchUpInside)
		arg_2_0.btnQuickJoin:addHandleOfControlEvent(function()
			arg_2_0:onQuickJoin()
		end, CCControlEventTouchUpInside)
	end

	var_2_0()
	var_2_1()
end

function var_0_0.free(arg_8_0)
	return
end

function var_0_0.onFrame(arg_9_0)
	if g_GameStateMachine:isOneSecondPassed() == false then
		return
	end

	if g_GameData.LegionInfo.LeftTm > 0 then
		local var_9_0 = zbUtil:SprintfHHMMSS(g_GameData.LegionInfo.LeftTm)

		arg_9_0.lbCdTime:setString(var_9_0)

		arg_9_0.bCdEnd = false
		g_GameData.LegionInfo.LeftTm = g_GameData.LegionInfo.LeftTm - 1
		arg_9_0.needTime = g_GameData.LegionInfo.LeftTm
	else
		arg_9_0.lbCdTime:setString("")

		arg_9_0.bCdEnd = true
	end

	arg_9_0.lbCdTitle:setVisible(arg_9_0.bCdEnd == false)
end

function var_0_0.onNext(arg_10_0)
	local var_10_0 = g_Self.kLegionHandler.curPage + 1

	if var_10_0 > g_Self.kLegionHandler.PageCountMax then
		return
	end

	g_WsMsgHandler:WS_Legion_PageList_Req(var_10_0)
end

function var_0_0.onPre(arg_11_0)
	local var_11_0 = g_Self.kLegionHandler.curPage - 1

	if var_11_0 < 1 then
		return
	end

	g_WsMsgHandler:WS_Legion_PageList_Req(var_11_0)
end

function var_0_0.onQuickJoin(arg_12_0)
	if arg_12_0.bCdEnd then
		g_WsMsgHandler:WS_Legion_JoinQuick_Req()
	else
		g_MainScene:showLegionJoinCdClearWnd(arg_12_0.needTime)
	end
end

function var_0_0.refresh(arg_13_0)
	arg_13_0.lbPage:setString(g_Self.kLegionHandler.curPage .. "/" .. g_Self.kLegionHandler.PageCountMax)
	arg_13_0:refreshReslut()
end

function var_0_0.refreshReslut(arg_14_0)
	local var_14_0 = arg_14_0:getLegionList()

	arg_14_0.nodeNone:setVisible(table.getn(var_14_0) > 0)
	arg_14_0:confirmCreateView(var_14_0)
	arg_14_0:refreshItems(var_14_0)
end

function var_0_0.confirmCreateView(arg_15_0, arg_15_1)
	if table.maxn(arg_15_0.items) == table.maxn(arg_15_1) then
		return
	end

	for iter_15_0, iter_15_1 in pairs(arg_15_0.items) do
		iter_15_1:removeFromParentAndCleanup(false)
	end

	arg_15_0.items = {}

	if arg_15_0.tableView ~= nil then
		arg_15_0.tableView:removeFromParentAndCleanup(true)

		arg_15_0.tableView = nil
		arg_15_0.tableViewHelper = nil
	end

	if arg_15_1 == nil then
		arg_15_1 = {}
	end

	local var_15_0 = table.maxn(arg_15_1)
	local var_15_1 = table.maxn(arg_15_0.items)
	local var_15_2 = arg_15_0.mainLayer:getContentSize()
	local var_15_3 = CCSizeMake(var_15_2.width, var_0_2 * var_15_0)
	local var_15_4 = CCSizeMake(var_15_2.width, var_15_2.height)

	arg_15_0.tableViewHelper = zbTableViewHelper:create()
	arg_15_0.tableView = zbTableViewHelper:createTableView(var_15_3, var_15_4, 1, arg_15_0.tableViewHelper)

	arg_15_0.tableView:setPosition(0, 0)
	arg_15_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_15_0.mainLayer:addChild(arg_15_0.tableView)

	if var_15_0 - var_15_1 > 0 then
		local var_15_5 = zbTableViewHelper:create()

		var_15_5:loadCCBFile("ccbi/tb_legionitem.ccbi")

		for iter_15_2 = 1, var_15_0 - var_15_1 do
			local var_15_6 = createLegionItem(translateAndStrokeHelper(var_15_5:readCCBNode()))

			var_15_6:retain()

			arg_15_0.items[var_15_1 + iter_15_2] = var_15_6
		end
	end

	local var_15_7 = 1

	for iter_15_3, iter_15_4 in pairs(arg_15_1) do
		local var_15_8 = arg_15_0.items[var_15_7]

		arg_15_0.tableViewHelper:addCell(var_15_8)

		var_15_7 = var_15_7 + 1
	end

	arg_15_0.tableViewHelper:refreshTabelView()

	if g_MainScene.wndLegionNo then
		arg_15_0.tableViewHelper:setTouchPriority(g_MainScene.wndLegionNo.btnClose:getTouchPriority())
	end
end

function var_0_0.refreshItems(arg_16_0, arg_16_1)
	local var_16_0 = 1

	for iter_16_0, iter_16_1 in pairs(arg_16_1) do
		arg_16_0.items[var_16_0]:refresh(iter_16_1)

		var_16_0 = var_16_0 + 1
	end
end

function var_0_0.getLegionList(arg_17_0)
	return g_Self.kLegionHandler:getLegionList()
end
