require("gamelogic.zbEquipItem")

zbEquipList = class("zbEquipList")
zbEquipList.__index = zbEquipList

local var_0_0 = 3
local var_0_1 = 344
local var_0_2 = 150

function createEquipList(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	local var_1_0 = zbEquipList.new()

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)

	return var_1_0
end

function zbEquipList.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7)
	local function var_2_0()
		arg_2_0.lines = {}
		arg_2_0.items = {}
		arg_2_0.tabType = arg_2_2
		arg_2_0.itemType = arg_2_3
		arg_2_0.maskLeft = arg_2_4
		arg_2_0.maskRight = arg_2_5
		arg_2_0.parentWnd = arg_2_7
		arg_2_0.dirty = true
		arg_2_0.tableView = nil
		arg_2_0.tableViewHelper = nil
		arg_2_0.touchPriority = arg_2_6
	end

	local function var_2_1()
		arg_2_0.layerContent = arg_2_1
	end

	var_2_0()
	var_2_1()
end

function zbEquipList.refresh(arg_5_0)
	if arg_5_0.tableView == nil or arg_5_0.dirty == true then
		local var_5_0, var_5_1 = g_Self.kBagEquipHandler:getEquipList(arg_5_0.tabType)

		arg_5_0:confirmCreateView(var_5_0, var_5_1)

		arg_5_0.dirty = false
	end

	arg_5_0.tableViewHelper:refreshTabelView()
	zbUtil:setTableViewOffset(arg_5_0.tableViewHelper, kCCScrollViewDirectionHorizontal, kCCTableViewFillBottomUp, 3, arg_5_0.count, var_0_1, 1)
end

function zbEquipList.refreshDirtyFlag(arg_6_0)
	arg_6_0.dirty = true
end

function zbEquipList.confirmCreateView(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0.tableView == nil then
		local var_7_0 = arg_7_0.layerContent:getContentSize()

		arg_7_0.tableViewHelper = zbTableViewHelper:create()
		arg_7_0.tableView = zbTableViewHelper:createTableView(var_7_0, var_7_0, 1, arg_7_0.tableViewHelper)

		arg_7_0.tableView:setPosition(0, 0)
		arg_7_0.tableView:setAnchorPoint(ccp(0, 0))
		arg_7_0.tableViewHelper:createListView("ccbi/tb_line.ccbi")
		arg_7_0.layerContent:addChild(arg_7_0.tableView)
		arg_7_0.tableViewHelper:setMaskPanel(nil, nil, arg_7_0.maskLeft, arg_7_0.maskRight)
	else
		arg_7_0.tableViewHelper:removeAllCells()
	end

	local var_7_1 = math.ceil(table.getn(arg_7_1) / var_0_0)
	local var_7_2 = table.getn(arg_7_0.lines)

	arg_7_0.count = var_7_1

	for iter_7_0 = 1, var_7_2 do
		if iter_7_0 <= var_7_1 then
			local var_7_3 = arg_7_0.lines[iter_7_0]

			arg_7_0.tableViewHelper:addCell(var_7_3)
		end
	end

	if var_7_1 - var_7_2 > 0 then
		for iter_7_1 = 1, var_7_1 - var_7_2 do
			local var_7_4 = arg_7_0.tableViewHelper:addListItem()

			var_7_4:setAnchorPoint(ccp(0, 0))
			var_7_4:setContentSize(CCSizeMake(var_0_1 * var_0_0, var_0_2))

			arg_7_0.lines[var_7_2 + iter_7_1] = var_7_4

			for iter_7_2 = 1, var_0_0 do
				local var_7_5 = zbTableViewHelper:create()

				var_7_5:loadCCBFile("ccbi/tb_equipcard.ccbi")

				local var_7_6 = zbEquipItem:create(translateAndStrokeHelper(var_7_5:readCCBNode()), arg_7_0.parentWnd)

				var_7_6:setAnchorPoint(ccp(0, 0))
				var_7_6:setPosition((iter_7_2 - 1) * var_0_1 - 10, 0)
				var_7_4:addChild(var_7_6)

				arg_7_0.items[(var_7_2 + iter_7_1 - 1) * var_0_0 + iter_7_2] = var_7_6

				var_7_5:releaseSelf()
			end
		end
	end

	local var_7_7 = 1

	for iter_7_3, iter_7_4 in pairs(arg_7_0.lines) do
		if var_7_7 == arg_7_2 then
			iter_7_4:setContentSize(CCSizeMake(var_0_2 * var_0_0, 5))
		else
			iter_7_4:setContentSize(CCSizeMake(var_0_1 * var_0_0, var_0_2))
		end

		var_7_7 = var_7_7 + 1
	end

	for iter_7_5, iter_7_6 in pairs(arg_7_0.items) do
		iter_7_6:setVisible(false)
	end

	local var_7_8 = 1

	for iter_7_7, iter_7_8 in pairs(arg_7_1) do
		arg_7_0.items[var_7_8]:refreshData(iter_7_8, var_7_8)

		var_7_8 = var_7_8 + 1
	end

	arg_7_0.tableViewHelper:refreshTabelView()
	arg_7_0.tableViewHelper:setTouchPriority(arg_7_0.touchPriority:getTouchPriority())
end
