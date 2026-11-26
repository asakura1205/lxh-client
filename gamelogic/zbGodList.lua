require("gamelogic.zbGodListItem")

local var_0_0 = class("zbGodList")

var_0_0.__index = var_0_0

local var_0_1 = 156

function createGodList(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	local function var_2_0()
		arg_2_0.items = {}
		arg_2_0.tableView = nil
		arg_2_0.tableViewHelper = nil
		arg_2_0.btnPriority = arg_2_2
	end

	local function var_2_1()
		arg_2_0.layer = arg_2_1
	end

	var_2_0()
	var_2_1()
end

function var_0_0.refresh(arg_5_0)
	arg_5_0:confirmCreateView()
end

function var_0_0.confirmCreateView(arg_6_0)
	local var_6_0 = zbGodBaseTable.records

	for iter_6_0, iter_6_1 in pairs(arg_6_0.items) do
		iter_6_1:removeFromParentAndCleanup(false)
	end

	arg_6_0.items = {}

	if arg_6_0.tableView ~= nil then
		arg_6_0.tableView:removeFromParentAndCleanup(true)

		arg_6_0.tableView = nil
		arg_6_0.tableViewHelper = nil
	end

	local var_6_1 = table.getn(var_6_0)
	local var_6_2 = table.getn(arg_6_0.items)
	local var_6_3 = arg_6_0.layer:getContentSize()
	local var_6_4 = CCSizeMake(var_0_1 * var_6_1, var_6_3.height)
	local var_6_5 = CCSizeMake(var_6_3.width, var_6_3.height)

	arg_6_0.tableViewHelper = zbTableViewHelper:create()
	arg_6_0.tableView = zbTableViewHelper:createTableView(var_6_4, var_6_5, 0, arg_6_0.tableViewHelper)

	arg_6_0.tableView:setPosition(0, 0)
	arg_6_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_6_0.layer:addChild(arg_6_0.tableView)

	if var_6_1 - var_6_2 > 0 then
		for iter_6_2 = 1, var_6_1 - var_6_2 do
			local var_6_6 = zbTableViewHelper:create()

			var_6_6:loadCCBFile("ccbi/tb_godequipitem.ccbi")

			local var_6_7 = createGodListItem(translateAndStrokeHelper(var_6_6:readCCBNode()))

			var_6_7:retain()

			arg_6_0.items[var_6_2 + iter_6_2] = var_6_7

			var_6_6:releaseSelf()
		end
	end

	local var_6_8 = 1

	for iter_6_3, iter_6_4 in pairs(var_6_0) do
		local var_6_9 = arg_6_0.items[var_6_8]

		var_6_9:refresh(iter_6_4)
		arg_6_0.tableViewHelper:addCell(var_6_9)

		var_6_8 = var_6_8 + 1
	end

	arg_6_0.tableViewHelper:refreshTabelView()
	arg_6_0.tableViewHelper:setTouchPriority(arg_6_0.btnPriority:getTouchPriority())
end
