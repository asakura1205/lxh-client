require("gamelogic.zbBaseWnd")
require("gamelogic.zbGemsDecomposeCard")

zbGemsDecomposeList = class("zbGemsDecomposeList")
zbGemsDecomposeList.__index = zbGemsDecomposeList

local var_0_0 = 5
local var_0_1 = 124
local var_0_2 = 120

function zbGemsDecomposeList.init(arg_1_0, arg_1_1)
	local function var_1_0()
		arg_1_0.lines = {}
		arg_1_0.items = {}
		arg_1_0.tableView = nil
		arg_1_0.tableViewHelper = nil
	end

	local function var_1_1()
		arg_1_0.layer = arg_1_1
	end

	var_1_0()
	var_1_1()
end

function zbGemsDecomposeList.free(arg_4_0)
	return
end

function zbGemsDecomposeList.refresh(arg_5_0)
	if g_MainScene.wndGemsDecompose == nil then
		return
	end

	for iter_5_0, iter_5_1 in pairs(arg_5_0.lines) do
		iter_5_1:removeFromParentAndCleanup(false)
	end

	arg_5_0.lines = {}
	arg_5_0.items = {}

	if arg_5_0.tableView ~= nil then
		arg_5_0.tableView:removeFromParentAndCleanup(true)

		arg_5_0.tableView = nil
		arg_5_0.tableViewHelper = nil
	end

	local var_5_0 = arg_5_0.layer:getContentSize()

	arg_5_0.tableViewHelper = zbTableViewHelper:create()
	arg_5_0.tableView = zbTableViewHelper:createTableView(var_5_0, var_5_0, 1, arg_5_0.tableViewHelper)

	arg_5_0.tableView:setPosition(0, 0)
	arg_5_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_5_0.tableViewHelper:createListView("ccbi/tb_line.ccbi")
	arg_5_0.layer:addChild(arg_5_0.tableView)

	local var_5_1 = g_Self.kBagItemHandler:getComposeGems()
	local var_5_2 = arg_5_0:removeNum0gems(var_5_1)
	local var_5_3 = math.ceil(table.getn(var_5_2) / var_0_0)
	local var_5_4 = table.getn(arg_5_0.lines)

	for iter_5_2 = 1, var_5_4 do
		if iter_5_2 <= var_5_3 then
			local var_5_5 = arg_5_0.lines[iter_5_2]

			arg_5_0.tableViewHelper:addCell(var_5_5)
		end
	end

	if var_5_3 - var_5_4 > 0 then
		for iter_5_3 = 1, var_5_3 - var_5_4 do
			local var_5_6 = arg_5_0.tableViewHelper:addListItem()

			var_5_6:setAnchorPoint(ccp(0, 0))
			var_5_6:setContentSize(CCSizeMake(var_0_1 * var_0_0, var_0_2))

			arg_5_0.lines[var_5_4 + iter_5_3] = var_5_6

			for iter_5_4 = 1, var_0_0 do
				local var_5_7 = zbTableViewHelper:create()

				var_5_7:loadCCBFile("ccbi/gemsSelCard.ccbi")

				local var_5_8 = createGemsDecomposeCard(translateAndStrokeHelper(var_5_7:readCCBNode()))

				var_5_8:setAnchorPoint(ccp(0, 0))
				var_5_8:setPosition((iter_5_4 - 1) * var_0_1, 0)
				var_5_6:addChild(var_5_8)

				arg_5_0.items[(var_5_4 + iter_5_3 - 1) * var_0_0 + iter_5_4] = var_5_8

				var_5_7:releaseSelf()
			end
		end
	end

	local var_5_9 = 1

	for iter_5_5, iter_5_6 in pairs(var_5_2) do
		arg_5_0.items[var_5_9]:refresh(iter_5_6)

		var_5_9 = var_5_9 + 1
	end

	local var_5_10 = table.getn(arg_5_0.items)

	for iter_5_7 = var_5_9, var_5_10 do
		arg_5_0.items[iter_5_7]:refresh(nil)
	end

	arg_5_0.tableViewHelper:refreshTabelView()

	if g_MainScene.wndGemsDecomposeSelect then
		arg_5_0.tableViewHelper:setTouchPriority(g_MainScene.wndGemsDecomposeSelect.btnClose:getTouchPriority())
	end
end

function zbGemsDecomposeList.frame(arg_6_0)
	return
end

function zbGemsDecomposeList.removeNum0gems(arg_7_0, arg_7_1)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(arg_7_1) do
		local var_7_1 = g_MainScene.wndGemsDecomposeSelect:getSelGemsCount(iter_7_1)

		if iter_7_1.Count - var_7_1 > 0 then
			table.insert(var_7_0, iter_7_1)
		end
	end

	return var_7_0
end

function createGemsList(arg_8_0)
	local var_8_0 = zbGemsDecomposeList.new()

	var_8_0:init(arg_8_0)

	return var_8_0
end
