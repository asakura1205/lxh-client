require("gamelogic.zbWordLogItem")

local var_0_0 = class("zbWordLogPnl")

var_0_0.__index = var_0_0

local var_0_1 = 324
local var_0_2 = 100

function createWordLogPanel(arg_1_0)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	local function var_2_0()
		arg_2_0.items = {}
		arg_2_0.tableview = nil
		arg_2_0.tableviewHelper = nil
		arg_2_0.initPos = ccp(0, 0)
		arg_2_0.bshow = false
	end

	local function var_2_1()
		arg_2_0.root = arg_2_1
		arg_2_0.btnTouchTest = tolua.cast(arg_2_1:getChildByTag(1), "CCControlButton")

		local var_4_0 = tolua.cast(arg_2_1:getChildByTag(2), "CCNode")

		arg_2_0.s9bg = tolua.cast(var_4_0:getChildByTag(1), "CCScale9Sprite")
		arg_2_0.mainLayer = tolua.cast(var_4_0:getChildByTag(2), "CCLayer")
		arg_2_0.btnLog = tolua.cast(var_4_0:getChildByTag(3), "CCControlButton")
		arg_2_0.initPos = ccp(-arg_2_0.s9bg:getContentSize().width, 0)

		arg_2_0.btnLog:addHandleOfControlEvent(function()
			arg_2_0:onLog()
		end, CCControlEventTouchUpInside)
		arg_2_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_2_0:onTouchtest()
		end, CCControlEventTouchUpInside)
	end

	var_2_0()
	var_2_1()
	arg_2_0:setShow(false)
end

function var_0_0.setShow(arg_7_0, arg_7_1)
	arg_7_0.bshow = arg_7_1

	arg_7_0.btnTouchTest:setEnabled(arg_7_1)

	if arg_7_1 then
		local function var_7_0()
			arg_7_0:refresh()
		end

		local var_7_1 = CCMoveBy:create(0.2, ccp(arg_7_0.s9bg:getContentSize().width, 0))
		local var_7_2 = CCCallFuncN:create(var_7_0)
		local var_7_3 = CCSequence:createWithTwoActions(var_7_1, var_7_2)

		arg_7_0.root:stopAllActions()
		arg_7_0.root:runAction(var_7_3)
		g_WsMsgHandler:WS_World_GetLog_Req()
	else
		arg_7_0.root:setPosition(arg_7_0.initPos)
	end

	if g_MainScene.wndWorld and g_MainScene.wndWorld.wordMap then
		local var_7_4 = g_MainScene.wndWorld.wordMap

		var_7_4.mapNodeMgr:setLayerVisible(not arg_7_0.bshow)
		var_7_4.mapOpentitleMgr:setLayerVisible(not arg_7_0.bshow)

		local var_7_5 = g_MainScene.wndWorld.wordMap

		var_7_5:setLayerTouchEnabled(not arg_7_0.bshow)
		var_7_5:setScrollEnable(not arg_7_0.bshow)
	end
end

function var_0_0.refresh(arg_9_0)
	arg_9_0:refreshReslut()
end

function var_0_0.onTouchtest(arg_10_0)
	local var_10_0 = arg_10_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_10_0.root, var_10_0.x, var_10_0.y) == false then
		arg_10_0:setShow(false)
	end
end

function var_0_0.refreshReslut(arg_11_0)
	local var_11_0 = g_Self.kWorldHandler.worldLogList

	if zbUtil:isValidTable(var_11_0) then
		arg_11_0:confirmCreateView(var_11_0)
		arg_11_0:refreshItems(var_11_0)
	end
end

function var_0_0.confirmCreateView(arg_12_0, arg_12_1)
	if table.maxn(arg_12_0.items) == table.maxn(arg_12_1) then
		return
	end

	for iter_12_0, iter_12_1 in pairs(arg_12_0.items) do
		iter_12_1:removeFromParentAndCleanup(false)
	end

	arg_12_0.items = {}

	if arg_12_0.tableView ~= nil then
		arg_12_0.tableView:removeFromParentAndCleanup(true)

		arg_12_0.tableView = nil
		arg_12_0.tableViewHelper = nil
	end

	if arg_12_1 == nil then
		arg_12_1 = {}
	end

	local var_12_0 = table.maxn(arg_12_1)
	local var_12_1 = table.maxn(arg_12_0.items)
	local var_12_2 = arg_12_0.mainLayer:getContentSize()
	local var_12_3 = CCSizeMake(var_12_2.width, var_0_2 * var_12_0)
	local var_12_4 = CCSizeMake(var_12_2.width, var_12_2.height)

	arg_12_0.tableViewHelper = zbTableViewHelper:create()
	arg_12_0.tableView = zbTableViewHelper:createTableView(var_12_3, var_12_4, 1, arg_12_0.tableViewHelper)

	arg_12_0.tableView:setPosition(0, 0)
	arg_12_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_12_0.mainLayer:addChild(arg_12_0.tableView)

	if var_12_0 - var_12_1 > 0 then
		for iter_12_2 = 1, var_12_0 - var_12_1 do
			local var_12_5 = zbTableViewHelper:create()

			var_12_5:loadCCBFile("ccbi/tb_world_log.ccbi")

			local var_12_6 = createWordLogItem(arg_12_0, translateAndStrokeHelper(var_12_5:readCCBNode()))

			var_12_6:retain()

			arg_12_0.items[var_12_1 + iter_12_2] = var_12_6

			var_12_5:releaseSelf()
		end
	end

	local var_12_7 = 1

	for iter_12_3, iter_12_4 in pairs(arg_12_1) do
		local var_12_8 = arg_12_0.items[var_12_7]

		arg_12_0.tableViewHelper:addCell(var_12_8)

		var_12_7 = var_12_7 + 1
	end

	arg_12_0.tableViewHelper:refreshTabelView()

	if g_MainScene.wndLegionMem then
		arg_12_0.tableViewHelper:setTouchPriority(arg_12_0.btnLog:getTouchPriority())
	end
end

function var_0_0.refreshItems(arg_13_0, arg_13_1)
	local var_13_0 = 1

	for iter_13_0, iter_13_1 in pairs(arg_13_1) do
		arg_13_0.items[var_13_0]:refresh(iter_13_1)

		var_13_0 = var_13_0 + 1
	end
end

function var_0_0.onLog(arg_14_0)
	arg_14_0:setShow(not arg_14_0.bshow)
end
