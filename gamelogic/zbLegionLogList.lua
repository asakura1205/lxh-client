require("gamelogic.zbLegionLogItem")

local var_0_0 = class("zbLegionLogList")

var_0_0.__index = var_0_0

local var_0_1 = 765
local var_0_2 = 110

function createLegionLogPanel(arg_1_0)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	local function var_2_0()
		arg_2_0.items = {}
		arg_2_0.tableview = nil
		arg_2_0.tableviewHelper = nil
	end

	local function var_2_1()
		arg_2_0.layer = arg_2_1
		arg_2_0.mainLayer = tolua.cast(arg_2_0.layer:getChildByTag(1), "CCLayer")
	end

	var_2_0()
	var_2_1()
end

function var_0_0.free(arg_5_0)
	return
end

function var_0_0.refresh(arg_6_0)
	g_WsMsgHandler:WS_Legion_GetLog_Req()
	arg_6_0:refreshReslut()
end

function var_0_0.refreshReslut(arg_7_0)
	local var_7_0 = {}

	if LegionGetLogAckData then
		var_7_0 = LegionGetLogAckData.LogList
	end

	arg_7_0:confirmCreateView(var_7_0)
	arg_7_0:refreshItems(var_7_0)
end

function var_0_0.confirmCreateView(arg_8_0, arg_8_1)
	if table.maxn(arg_8_0.items) == table.maxn(arg_8_1) then
		return
	end

	for iter_8_0, iter_8_1 in pairs(arg_8_0.items) do
		iter_8_1:removeFromParentAndCleanup(false)
	end

	arg_8_0.items = {}

	if arg_8_0.tableView ~= nil then
		arg_8_0.tableView:removeFromParentAndCleanup(true)

		arg_8_0.tableView = nil
		arg_8_0.tableViewHelper = nil
	end

	if arg_8_1 == nil then
		arg_8_1 = {}
	end

	local var_8_0 = table.maxn(arg_8_1)
	local var_8_1 = table.maxn(arg_8_0.items)
	local var_8_2 = arg_8_0.mainLayer:getContentSize()
	local var_8_3 = CCSizeMake(var_8_2.width, var_0_2 * var_8_0)
	local var_8_4 = CCSizeMake(var_8_2.width, var_8_2.height)

	arg_8_0.tableViewHelper = zbTableViewHelper:create()
	arg_8_0.tableView = zbTableViewHelper:createTableView(var_8_3, var_8_4, 1, arg_8_0.tableViewHelper)

	arg_8_0.tableView:setPosition(0, 0)
	arg_8_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_8_0.mainLayer:addChild(arg_8_0.tableView)

	if var_8_0 - var_8_1 > 0 then
		local var_8_5 = zbTableViewHelper:create()

		var_8_5:loadCCBFile("ccbi/tb_legionlogitem.ccbi")

		for iter_8_2 = 1, var_8_0 - var_8_1 do
			local var_8_6 = createLegionLogItem(translateAndStrokeHelper(var_8_5:readCCBNode()))

			var_8_6:retain()

			arg_8_0.items[var_8_1 + iter_8_2] = var_8_6
		end
	end

	local var_8_7 = 1

	for iter_8_3, iter_8_4 in pairs(arg_8_1) do
		local var_8_8 = arg_8_0.items[var_8_7]

		arg_8_0.tableViewHelper:addCell(var_8_8)

		var_8_7 = var_8_7 + 1
	end

	arg_8_0.tableViewHelper:refreshTabelView()

	if g_MainScene.wndLegionMem then
		arg_8_0.tableViewHelper:setTouchPriority(g_MainScene.wndLegionMem.btnClose:getTouchPriority())
	end
end

function var_0_0.refreshItems(arg_9_0, arg_9_1)
	local var_9_0 = 1

	for iter_9_0, iter_9_1 in pairs(arg_9_1) do
		arg_9_0.items[var_9_0]:refresh(iter_9_1)

		var_9_0 = var_9_0 + 1
	end
end
