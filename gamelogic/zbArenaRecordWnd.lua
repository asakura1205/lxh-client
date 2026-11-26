require("gamelogic.zbBaseWnd")
require("gamelogic.zbArenaRecordItem")

local var_0_0 = class("zbArenaRecordWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createArenaRecordWnd()
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
		arg_3_0.items = {}
		arg_3_0.tableview = nil
		arg_3_0.tableviewHelper = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/arena_record.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.layerContent = tolua.cast(var_5_2:getChildByTag(1), "CCLayer")
		arg_3_0.lbHint = tolua.cast(var_5_2:getChildByTag(1002), "CCLabelTTF")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)

		arg_3_0.layerTouchTest = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:confirmCreateView()
	end, zbGameEvent.Event_ArenaRecord_Ack)
end

function var_0_0.refresh(arg_9_0)
	g_WsMsgHandler:WS_Arena_RecordList_Req()
end

function var_0_0.confirmCreateView(arg_10_0)
	local var_10_0 = arg_10_0:getRecordList()

	if var_10_0 == nil then
		return
	end

	for iter_10_0, iter_10_1 in pairs(arg_10_0.items) do
		iter_10_1:removeFromParentAndCleanup(false)
	end

	arg_10_0.items = {}

	if arg_10_0.tableView ~= nil then
		arg_10_0.tableView:removeFromParentAndCleanup(true)

		arg_10_0.tableView = nil
		arg_10_0.tableViewHelper = nil
	end

	local var_10_1 = table.getn(var_10_0)

	arg_10_0.lbHint:setVisible(var_10_1 == 0)

	local var_10_2 = table.getn(arg_10_0.items)
	local var_10_3 = arg_10_0.layerContent:getContentSize()
	local var_10_4 = CCSizeMake(ArenaRecordItem_Width, ArenaRecordItem_Height * var_10_1)
	local var_10_5 = CCSizeMake(var_10_3.width, var_10_3.height)

	arg_10_0.tableViewHelper = zbTableViewHelper:create()
	arg_10_0.tableView = zbTableViewHelper:createTableView(var_10_4, var_10_5, 1, arg_10_0.tableViewHelper)

	arg_10_0.tableView:setPosition(0, 0)
	arg_10_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_10_0.layerContent:addChild(arg_10_0.tableView)

	if var_10_1 - var_10_2 > 0 then
		for iter_10_2 = 1, var_10_1 - var_10_2 do
			local var_10_6 = zbTableViewHelper:create()

			var_10_6:loadCCBFile("ccbi/tb_arena_record.ccbi")

			local var_10_7 = createArenaRecordItem(translateAndStrokeHelper(var_10_6:readCCBNode()))

			var_10_7:retain()

			arg_10_0.items[var_10_2 + iter_10_2] = var_10_7

			var_10_6:releaseSelf()
		end
	end

	local var_10_8 = 1

	for iter_10_3, iter_10_4 in pairs(var_10_0) do
		local var_10_9 = arg_10_0.items[var_10_8]

		var_10_9:refresh(iter_10_4)
		arg_10_0.tableViewHelper:addCell(var_10_9)

		var_10_8 = var_10_8 + 1
	end

	arg_10_0.tableViewHelper:refreshTabelView()
	arg_10_0.tableViewHelper:setTouchPriority(arg_10_0.btnClose:getTouchPriority())
end

function var_0_0.getRecordList(arg_11_0)
	local var_11_0 = g_Self.kArenaHandler.RecordList

	local function var_11_1(arg_12_0, arg_12_1)
		return arg_12_0.RecordTm > arg_12_1.RecordTm
	end

	table.sort(var_11_0, var_11_1)

	return var_11_0
end

function var_0_0.onTouchTest(arg_13_0)
	local var_13_0 = arg_13_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_13_0.layerTouchTest, var_13_0.x, var_13_0.y) == false and zbUtil:PointInCtrl(arg_13_0.btnClose, var_13_0.x, var_13_0.y) == false then
		arg_13_0:hide()
	end
end
