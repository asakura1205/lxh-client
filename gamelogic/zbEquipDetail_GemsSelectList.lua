require("gamelogic.zbBaseWnd")
require("gamelogic.zbEquipDetail_GemsSelectCard")

zbEquipDetail_GemsSelectList = class("zbEquipDetail_GemsSelectList")
zbEquipDetail_GemsSelectList.__index = zbEquipDetail_GemsSelectList

local var_0_0 = 4
local var_0_1 = 140
local var_0_2 = 120

function zbEquipDetail_GemsSelectList.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	local function var_1_0()
		arg_1_0.lines = {}
		arg_1_0.items = {}
		arg_1_0.gemType = arg_1_2
		arg_1_0.tableView = nil
		arg_1_0.tableViewHelper = nil
		arg_1_0.btnPriority = arg_1_3
		arg_1_0.parent = arg_1_4
	end

	local function var_1_1()
		arg_1_0.layerContent = arg_1_1
	end

	var_1_0()
	var_1_1()
end

function zbEquipDetail_GemsSelectList.refresh(arg_4_0)
	if arg_4_0.tableView == nil then
		local var_4_0 = arg_4_0.layerContent:getContentSize()

		arg_4_0.tableViewHelper = zbTableViewHelper:create()
		arg_4_0.tableView = zbTableViewHelper:createTableView(var_4_0, var_4_0, 1, arg_4_0.tableViewHelper)

		arg_4_0.tableView:setPosition(0, 0)
		arg_4_0.tableView:setAnchorPoint(ccp(0, 0))
		arg_4_0.tableViewHelper:createListView("ccbi/tb_line.ccbi")
		arg_4_0.layerContent:addChild(arg_4_0.tableView)
	else
		arg_4_0.tableViewHelper:removeAllCells()
	end

	local var_4_1 = g_Self.kBagItemHandler:getGemsAtType(arg_4_0.gemType)
	local var_4_2 = math.ceil(table.getn(var_4_1) / var_0_0)
	local var_4_3 = table.getn(arg_4_0.lines)

	print(table.getn(var_4_1))

	for iter_4_0 = 1, var_4_3 do
		if iter_4_0 <= var_4_2 then
			local var_4_4 = arg_4_0.lines[iter_4_0]

			arg_4_0.tableViewHelper:addCell(var_4_4)
		end
	end

	if var_4_2 - var_4_3 > 0 then
		for iter_4_1 = 1, var_4_2 - var_4_3 do
			local var_4_5 = arg_4_0.tableViewHelper:addListItem()

			var_4_5:setAnchorPoint(ccp(0, 0))
			var_4_5:setContentSize(CCSizeMake(var_0_1 * var_0_0, var_0_2))

			arg_4_0.lines[var_4_3 + iter_4_1] = var_4_5

			for iter_4_2 = 1, var_0_0 do
				local var_4_6 = zbTableViewHelper:create()

				var_4_6:loadCCBFile("ccbi/gemsSelCard.ccbi")

				local var_4_7 = createGemsSelectCard(translateAndStrokeHelper(var_4_6:readCCBNode()), arg_4_0.parent)

				var_4_7:setAnchorPoint(ccp(0, 0))
				var_4_7:setPosition((iter_4_2 - 1) * var_0_1, 0)
				var_4_5:addChild(var_4_7)

				arg_4_0.items[(var_4_3 + iter_4_1 - 1) * var_0_0 + iter_4_2] = var_4_7

				var_4_6:releaseSelf()
			end
		end
	end

	local var_4_8 = 1

	for iter_4_3, iter_4_4 in pairs(var_4_1) do
		arg_4_0.items[var_4_8]:refresh(iter_4_4)

		var_4_8 = var_4_8 + 1
	end

	if g_MainScene.wndGemsSelect then
		if var_4_8 == 1 then
			g_MainScene.wndGemsSelect.layerTishi:setVisible(true)
		else
			g_MainScene.wndGemsSelect.layerTishi:setVisible(false)
		end
	end

	local var_4_9 = table.getn(arg_4_0.items)

	for iter_4_5 = var_4_8, var_4_9 do
		arg_4_0.items[iter_4_5]:refresh(nil)
	end

	arg_4_0.tableViewHelper:refreshTabelView()
	arg_4_0.tableViewHelper:setTouchPriority(arg_4_0.btnPriority:getTouchPriority())

	if g_MainScene.wndGemsSelect then
		arg_4_0.tableViewHelper:setTouchPriority(g_MainScene.wndGemsSelect.btnClose:getTouchPriority())
	end
end

function createGemsSelectList(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = zbEquipDetail_GemsSelectList.new()

	var_5_0:init(arg_5_0, arg_5_1, arg_5_2, arg_5_3)

	return var_5_0
end
