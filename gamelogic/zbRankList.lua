require("gamelogic.zbRankItem")
require("gamelogic.zbRankItemSelf")

zbRankList = class("zbRankList")
zbRankList.__index = zbRankList

function createRankList(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = zbRankList.new()

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	return var_1_0
end

function zbRankList.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local function var_2_0()
		arg_2_0.items = {}
		arg_2_0.scrollNode = arg_2_2
		arg_2_0.dirty = true
		arg_2_0.tableView = nil
		arg_2_0.tableViewHelper = nil
		arg_2_0.btnPri = arg_2_3
		arg_2_0.parent = arg_2_4
		arg_2_0.hasSelf = false
	end

	local function var_2_1()
		arg_2_0.layer = arg_2_1
	end

	var_2_0()
	var_2_1()
end

function zbRankList.refresh(arg_5_0, arg_5_1)
	local var_5_0 = {}

	if arg_5_1 == ERankTab.Arena then
		var_5_0 = g_Self.kRankHandler.ArenaRankList
	else
		var_5_0 = g_Self.kRankHandler.FVRankData.RankList
	end

	local var_5_1 = math.max(table.getn(var_5_0) - 3 + 1, 1)

	arg_5_0:confirmCreateView(var_5_1)
	arg_5_0.parent.lbNoRank:setVisible(table.getn(var_5_0) < 1)

	local var_5_2 = arg_5_0.items[1]

	if var_5_2 ~= nil then
		var_5_2:refreshSelfRankInfo(arg_5_1)
	end

	local var_5_3 = 2

	for iter_5_0, iter_5_1 in pairs(var_5_0) do
		if arg_5_1 == ERankTab.Arena or arg_5_1 == ERankTab.FV then
			local var_5_4 = arg_5_0.items[var_5_3]

			if var_5_4 and (arg_5_1 == ERankTab.Arena and iter_5_1.Rank > 3 or arg_5_1 == ERankTab.FV and iter_5_1.RankInfo.Rank > 3) then
				var_5_4:refreshOthersRankInfo(iter_5_1, arg_5_1)

				var_5_3 = var_5_3 + 1
			end
		end
	end
end

function zbRankList.confirmCreateView(arg_6_0, arg_6_1)
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
			local var_6_2

			if iter_6_0 == 1 and arg_6_0.hasSelf == false then
				var_6_2 = createRankItemSelf()
				arg_6_0.hasSelf = true
			else
				var_6_2 = createRankItem()
			end

			if var_6_2 then
				var_6_2:retain()

				arg_6_0.items[var_6_0 + iter_6_0] = var_6_2
			end
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

function zbRankList.onFrame(arg_7_0)
	if arg_7_0.scrollBar then
		arg_7_0.scrollBar:update()
	end
end
