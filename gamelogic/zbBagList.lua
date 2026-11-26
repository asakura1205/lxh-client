require("gamelogic.zbBagItem")

local var_0_0 = class("zbBagList")

var_0_0.__index = var_0_0

function createBagList(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	return var_1_0
end

local var_0_1 = 5
local var_0_2 = 120
local var_0_3 = 150

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local function var_2_0()
		arg_2_0.lines = {}
		arg_2_0.items = {}
		arg_2_0.tabType = arg_2_2
		arg_2_0.tableView = nil
		arg_2_0.tableViewHelper = nil
		arg_2_0.dirty = true
		arg_2_0.itemdata = nil
		arg_2_0.touchPriority = arg_2_3
	end

	local function var_2_1()
		arg_2_0.layer = arg_2_1
	end

	var_2_0()
	var_2_1()
end

function var_0_0.refresh(arg_5_0)
	if arg_5_0.tableView == nil or arg_5_0.dirty == true then
		arg_5_0:confirmCreateView()

		arg_5_0.dirty = false
	end

	arg_5_0.tableViewHelper:refreshTabelView()
	zbUtil:setTableViewOffset(arg_5_0.tableViewHelper, kCCScrollViewDirectionHorizontal, kCCTableViewFillBottomUp, 3, arg_5_0.count, 120, 1)
end

function var_0_0.refreshDirtyFlag(arg_6_0)
	arg_6_0.dirty = true
end

function var_0_0.confirmCreateView(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.lines) do
		iter_7_1:removeFromParentAndCleanup(false)
	end

	arg_7_0.lines = {}
	arg_7_0.items = {}

	if arg_7_0.tableView ~= nil then
		arg_7_0.tableView:removeFromParentAndCleanup(true)

		arg_7_0.tableView = nil
		arg_7_0.tableViewHelper = nil
	end

	local var_7_0 = arg_7_0.layer:getContentSize()

	arg_7_0.tableViewHelper = zbTableViewHelper:create()
	arg_7_0.tableView = zbTableViewHelper:createTableView(var_7_0, var_7_0, kCCScrollViewDirectionVertical, arg_7_0.tableViewHelper)

	arg_7_0.tableView:setPosition(0, 0)
	arg_7_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_7_0.tableViewHelper:createListView("ccbi/tb_line.ccbi")
	arg_7_0.layer:addChild(arg_7_0.tableView)

	local var_7_1 = g_Self.kBagItemHandler:getBagByType(arg_7_0.tabType)
	local var_7_2 = math.ceil(table.getn(var_7_1) / var_0_1)
	local var_7_3 = table.getn(arg_7_0.lines)

	arg_7_0.count = var_7_2

	for iter_7_2 = 1, var_7_3 do
		if iter_7_2 <= var_7_2 then
			local var_7_4 = arg_7_0.lines[iter_7_2]

			arg_7_0.tableViewHelper:addCell(var_7_4)
		end
	end

	if var_7_2 - var_7_3 > 0 then
		for iter_7_3 = 1, var_7_2 - var_7_3 do
			local var_7_5 = arg_7_0.tableViewHelper:addListItem()

			var_7_5:setAnchorPoint(ccp(0, 0))
			var_7_5:setContentSize(CCSizeMake(var_0_2 * var_0_1, var_0_3))

			arg_7_0.lines[var_7_3 + iter_7_3] = var_7_5

			for iter_7_4 = 1, var_0_1 do
				local var_7_6 = zbTableViewHelper:create()

				var_7_6:loadCCBFile("ccbi/tb_bagitemcard.ccbi")

				local var_7_7 = createBagItem(translateAndStrokeHelper(var_7_6:readCCBNode()))

				var_7_7:setAnchorPoint(ccp(0, 0))
				var_7_7:setPosition((iter_7_4 - 1) * var_0_2, 0)
				var_7_5:addChild(var_7_7)

				arg_7_0.items[(var_7_3 + iter_7_3 - 1) * var_0_1 + iter_7_4] = var_7_7

				var_7_6:releaseSelf()
			end
		end
	end

	local var_7_8 = 1

	for iter_7_5, iter_7_6 in pairs(var_7_1) do
		arg_7_0.items[var_7_8]:refresh(iter_7_6)

		var_7_8 = var_7_8 + 1
	end

	if arg_7_0.itemdata == nil then
		arg_7_0.itemdata = var_7_1[1]
	elseif arg_7_0.dirty and arg_7_0.itemdata and g_Self.kBagItemHandler:getItemCountByTemplateId(arg_7_0.itemdata.TemplateId) <= 0 then
		arg_7_0.itemdata = var_7_1[1]
	end

	if arg_7_0.itemdata then
		arg_7_0:refreshSelectItem(arg_7_0.itemdata.TemplateId)
	end

	local var_7_9 = table.getn(arg_7_0.items)

	for iter_7_7 = var_7_8, var_7_9 do
		arg_7_0.items[iter_7_7]:refresh(nil)
	end

	arg_7_0.tableViewHelper:refreshTabelView()
	arg_7_0.tableViewHelper:setTouchPriority(arg_7_0.touchPriority:getTouchPriority())
end

function var_0_0.refreshSelectItem(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.items) do
		if iter_8_1 then
			iter_8_1:refreshSelectItem(arg_8_1)
		end
	end

	arg_8_0.itemdata = g_Self.kBagItemHandler:getItemDataByTemplateId(arg_8_1)
end
