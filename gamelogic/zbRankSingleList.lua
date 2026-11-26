require("gamelogic.zbRankSingleItem")

zbRankSingleList = class("zbRankSingleList")
zbRankSingleList.__index = zbRankSingleList

function createRankSingleList(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = zbRankSingleList.new()

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	return var_1_0
end

function zbRankSingleList.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local function var_2_0()
		arg_2_0.items = {}
		arg_2_0.scrollNode = arg_2_2
		arg_2_0.dirty = true
		arg_2_0.tableView = nil
		arg_2_0.tableViewHelper = nil
		arg_2_0.btnPri = arg_2_3
		arg_2_0.parent = arg_2_4
	end

	local function var_2_1()
		arg_2_0.layer = arg_2_1
	end

	var_2_0()
	var_2_1()
end

function zbRankSingleList.refresh(arg_5_0)
	local var_5_0 = g_Self.kRankHandler.HeroRankList
	local var_5_1 = table.getn(var_5_0) - 3

	arg_5_0:confirmCreateView(var_5_1)
	arg_5_0.parent.lbNoRank:setVisible(table.getn(var_5_0) < 1)

	local var_5_2 = 1

	for iter_5_0, iter_5_1 in pairs(var_5_0) do
		local var_5_3 = arg_5_0.items[var_5_2]

		if var_5_3 and iter_5_1.Rank > 3 then
			var_5_3:refresh(iter_5_1)

			var_5_2 = var_5_2 + 1
		end
	end
end

function zbRankSingleList.confirmCreateView(arg_6_0, arg_6_1)
	local var_6_0 = table.getn(arg_6_0.items)
	local var_6_1 = arg_6_0.layer:getContentSize()

	if arg_6_0.tableViewHelper == nil then
		arg_6_0.tableViewHelper = zbTableViewHelper:create()
	end

	if arg_6_0.tableView == nil then
		arg_6_0.tableView = zbTableViewHelper:createTableView(var_6_1, var_6_1, 1, arg_6_0.tableViewHelper)

		arg_6_0.tableView:setPosition(0, 0)
		arg_6_0.tableView:setAnchorPoint(ccp(0, 0))
		arg_6_0.layer:addChild(arg_6_0.tableView)
	end

	if arg_6_1 - var_6_0 > 0 then
		for iter_6_0 = 1, arg_6_1 - var_6_0 do
			local var_6_2 = createRankSingleItem()

			var_6_2:retain()

			arg_6_0.items[var_6_0 + iter_6_0] = var_6_2
		end
	end

	arg_6_0.tableViewHelper:removeAllCells()

	for iter_6_1 = 1, arg_6_1 do
		local var_6_3 = arg_6_0.items[iter_6_1]

		arg_6_0.tableViewHelper:addCell(var_6_3)
	end

	arg_6_0.tableViewHelper:refreshTabelView()

	arg_6_0.scrollBar = ui:createScrollBarView(arg_6_0.tableView, arg_6_0.scrollNode, var_6_1.height)

	arg_6_0.tableViewHelper:setTouchPriority(arg_6_0.btnPri:getTouchPriority())
end

function zbRankSingleList.onFrame(arg_7_0)
	if arg_7_0.scrollBar then
		arg_7_0.scrollBar:update()
	end
end
