require("gamelogic.zbBaseWnd")
require("gamelogic.zbLegionRedRankItem")

local var_0_0 = class("zbLegionRedRankWnd", zbBaseWnd)

var_0_0.__index = var_0_0

local var_0_1 = 100

function createLegionRedRankWnd()
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
		arg_3_0.hongbaoType = 1
		arg_3_0.items = {}
		arg_3_0.tableView = nil
		arg_3_0.tableViewHelper = nil
		arg_3_0.scrollBar = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/legion_redrank.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayerColor")

		arg_3_0.layer = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.layerContent = tolua.cast(var_5_2:getChildByTag(1), "CCLayerColor")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refresh()
	end, zbGameEvent.Event_LegionHongbao_Ack)
end

function var_0_0.refresh(arg_9_0, arg_9_1)
	if arg_9_1 ~= nil then
		arg_9_0.hongbaoType = arg_9_1
	end

	local var_9_0 = g_Self.kLegionHandler.legionHongbaoLogList

	if var_9_0 == nil then
		return
	end

	arg_9_0:confirmCreateView(var_9_0)
	arg_9_0:refreshItems(var_9_0)
end

function var_0_0.confirmCreateView(arg_10_0, arg_10_1)
	if table.maxn(arg_10_0.items) == table.maxn(arg_10_1) then
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

	if arg_10_1 == nil then
		arg_10_1 = {}
	end

	local var_10_0 = table.maxn(arg_10_1)
	local var_10_1 = table.maxn(arg_10_0.items)
	local var_10_2 = arg_10_0.layerContent:getContentSize()
	local var_10_3 = CCSizeMake(var_10_2.width, var_0_1 * var_10_0)
	local var_10_4 = CCSizeMake(var_10_2.width, var_10_2.height)

	arg_10_0.tableViewHelper = zbTableViewHelper:create()
	arg_10_0.tableView = zbTableViewHelper:createTableView(var_10_3, var_10_4, 1, arg_10_0.tableViewHelper)

	arg_10_0.tableView:setPosition(ccp(0, 0))
	arg_10_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_10_0.layerContent:addChild(arg_10_0.tableView)

	if var_10_0 - var_10_1 > 0 then
		local var_10_5 = zbTableViewHelper:create()

		var_10_5:loadCCBFile("ccbi/tb_legion_redrank.ccbi")

		for iter_10_2 = 1, var_10_0 - var_10_1 do
			local var_10_6 = createLegionRedRankItem(translateAndStrokeHelper(var_10_5:readCCBNode()))

			var_10_6:retain()

			arg_10_0.items[var_10_1 + iter_10_2] = var_10_6
		end
	end

	local var_10_7 = 1

	for iter_10_3, iter_10_4 in pairs(arg_10_1) do
		local var_10_8 = arg_10_0.items[var_10_7]

		var_10_8:refresh(iter_10_4, arg_10_0.hongbaoType, var_10_7)
		arg_10_0.tableViewHelper:addCell(var_10_8)

		var_10_7 = var_10_7 + 1
	end

	arg_10_0.tableViewHelper:refreshTabelView()
	arg_10_0.tableViewHelper:setTouchPriority(arg_10_0.btnClose:getTouchPriority())
end

function var_0_0.refreshItems(arg_11_0, arg_11_1)
	local var_11_0 = 1

	for iter_11_0, iter_11_1 in pairs(arg_11_1) do
		arg_11_0.items[var_11_0]:refresh(iter_11_1, arg_11_0.hongbaoType, var_11_0)

		var_11_0 = var_11_0 + 1
	end
end

function var_0_0.onTouchTest(arg_12_0)
	local var_12_0 = arg_12_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_12_0.layer, var_12_0.x, var_12_0.y) == false and zbUtil:PointInCtrl(arg_12_0.btnClose, var_12_0.x, var_12_0.y) == false then
		arg_12_0:hide()
	end
end
