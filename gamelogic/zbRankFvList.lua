require("gamelogic.zbRankFvItem")

zbRankFvList = class("zbRankFvList")
zbRankFvList.__index = zbRankFvList

function createFvList(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbRankFvList.new()

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2)

	return var_1_0
end

function zbRankFvList.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local function var_2_0()
		arg_2_0.items = {}
		arg_2_0.scrollNode = arg_2_2
		arg_2_0.dirty = true
		arg_2_0.tableView = nil
		arg_2_0.tableViewHelper = nil
		arg_2_0.btnPri = arg_2_3
	end

	local function var_2_1()
		arg_2_0.layer = arg_2_1
	end

	var_2_0()
	var_2_1()
end

function zbRankFvList.refresh(arg_5_0)
	local var_5_0 = g_Self.kRankHandler.PataRankData
	local var_5_1 = table.getn(var_5_0.RankList) - 3

	if var_5_1 <= 0 then
		return
	end

	arg_5_0:confirmCreateView(var_5_1)

	local var_5_2 = 1

	for iter_5_0, iter_5_1 in pairs(var_5_0.RankList) do
		if iter_5_1.Rank >= 3 then
			local var_5_3 = arg_5_0.items[var_5_2]

			if var_5_3 then
				var_5_3:refresh(iter_5_1)

				var_5_2 = var_5_2 + 1
			end
		end
	end
end

function zbRankFvList.confirmCreateView(arg_6_0, arg_6_1)
	local var_6_0 = table.getn(arg_6_0.items)
	local var_6_1 = arg_6_0.layer:getContentSize()
	local var_6_2 = CCSizeMake(var_6_1.width, var_6_1.height)

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
		local var_6_3 = zbTableViewHelper:create()

		var_6_3:loadCCBFile("ccbi/tb_rankfv.ccbi")

		for iter_6_0 = 1, arg_6_1 - var_6_0 do
			local var_6_4 = zbRankFvItem:create(translateAndStrokeHelper(var_6_3:readCCBNode()))

			var_6_4:retain()

			arg_6_0.items[var_6_0 + iter_6_0] = var_6_4
		end
	end

	arg_6_0.tableViewHelper:removeAllCells()

	for iter_6_1 = 1, arg_6_1 do
		local var_6_5 = arg_6_0.items[iter_6_1]

		arg_6_0.tableViewHelper:addCell(var_6_5)
	end

	arg_6_0.tableViewHelper:refreshTabelView()

	arg_6_0.scrollBar = ui:createScrollBarView(arg_6_0.tableView, arg_6_0.scrollNode, 470)

	arg_6_0.tableViewHelper:setTouchPriority(arg_6_0.btnPri:getTouchPriority())
end

function zbRankFvList.onFrame(arg_7_0)
	if arg_7_0.scrollBar then
		arg_7_0.scrollBar:update()
	end
end
