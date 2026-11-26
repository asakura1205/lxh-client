require("gamelogic.zbBaseWnd")
require("gamelogic.zbFriendBossItem")

local var_0_0 = class("zbFriendBossListWnd", zbBaseWnd)

var_0_0.__index = var_0_0

local var_0_1 = 105

function createFriendBossListWnd()
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
		local var_5_1 = CCBReaderLoad("ccbi/friendbosslist.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.layerTouchTest = var_5_2

		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCLayer")

		arg_3_0.nodeList = tolua.cast(var_5_3:getChildByTag(1), "CCLayer")
		arg_3_0.layerContent = tolua.cast(arg_3_0.nodeList:getChildByTag(3), "CCLayer")
		arg_3_0.nodeEmpty = tolua.cast(var_5_3:getChildByTag(2), "CCLayer")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(10), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_HideAll)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:createView()
end

function var_0_0.createView(arg_8_0)
	local var_8_0 = arg_8_0.layerContent:getContentSize()
	local var_8_1 = CCSizeMake(var_8_0.width, var_8_0.height)

	arg_8_0.tableViewHelper = zbTableViewHelper:create()
	arg_8_0.tableView = zbTableViewHelper:createTableView(var_8_1, var_8_1, 1, arg_8_0.tableViewHelper)

	arg_8_0.tableView:setPosition(0, 0)
	arg_8_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_8_0.layerContent:addChild(arg_8_0.tableView)
	arg_8_0.tableViewHelper:refreshTabelView()
	arg_8_0.tableViewHelper:setTouchPriority(arg_8_0.btnClose:getTouchPriority())
end

function var_0_0.refresh(arg_9_0)
	g_Self.kFriendHandler.haveNewFriendBoss = false

	arg_9_0:refreshItems()
end

function var_0_0.refreshItems(arg_10_0)
	local var_10_0 = g_Self.kFriendHandler.bossList

	if zbUtil:isValidTable(var_10_0) == false then
		return
	end

	local var_10_1 = arg_10_0.tableViewHelper:getCellNum() ~= table.getn(var_10_0)

	if var_10_1 then
		arg_10_0.tableViewHelper:removeAllCells()
	end

	local var_10_2 = table.getn(var_10_0)
	local var_10_3 = table.getn(arg_10_0.items)

	if var_10_2 - var_10_3 > 0 then
		for iter_10_0 = 1, var_10_2 - var_10_3 do
			local var_10_4 = zbTableViewHelper:create()

			var_10_4:loadCCBFile("ccbi/tb_friendboss_item.ccbi")

			local var_10_5 = createFriendBossItem(translateAndStrokeHelper(var_10_4:readCCBNode()), arg_10_0)

			var_10_5:retain()

			arg_10_0.items[var_10_3 + iter_10_0] = var_10_5

			var_10_4:releaseSelf()
		end
	end

	arg_10_0.nodeEmpty:setVisible(var_10_2 == 0)
	arg_10_0.nodeList:setVisible(var_10_2 ~= 0)

	local var_10_6 = 1

	for iter_10_1, iter_10_2 in pairs(var_10_0) do
		local var_10_7 = arg_10_0.items[var_10_6]

		var_10_7:refresh(iter_10_2)

		var_10_6 = var_10_6 + 1

		if var_10_1 then
			arg_10_0.tableViewHelper:addCell(var_10_7)
		end
	end

	if var_10_1 then
		arg_10_0.tableViewHelper:refreshTabelView()
		arg_10_0.tableViewHelper:setTouchPriority(arg_10_0.btnClose:getTouchPriority())
	end
end

function var_0_0.onTouchTest(arg_11_0)
	local var_11_0 = arg_11_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_11_0.layerTouchTest, var_11_0.x, var_11_0.y) == false then
		arg_11_0:hide()
	end
end
