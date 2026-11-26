require("gamelogic.zbFriendJhItem")

local var_0_0 = class("zbFriendJhList")

var_0_0.__index = var_0_0

local var_0_1 = 100

function createFriendJhList(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	local function var_2_0()
		arg_2_0.btnPri = arg_2_2
		arg_2_0.items = {}
		arg_2_0.tableView = nil
		arg_2_0.tableViewHelper = nil
	end

	local function var_2_1()
		arg_2_0.nodehave = tolua.cast(arg_2_1:getChildByTag(1), "CCNode")
		arg_2_0.layer = tolua.cast(arg_2_0.nodehave:getChildByTag(3), "CCLayer")
	end

	var_2_0()
	var_2_1()
end

function var_0_0.onFrame(arg_5_0)
	return
end

function var_0_0.refresh(arg_6_0)
	local var_6_0 = g_Self.kFriendHandler:getFriendJhList()

	arg_6_0.nodehave:setVisible(table.getn(var_6_0) > 0)

	if zbUtil:isValidTable(var_6_0) and table.getn(var_6_0) > 0 then
		arg_6_0:confirmCreateView(var_6_0)
		arg_6_0:refreshItems(var_6_0)
	end
end

function var_0_0.confirmCreateView(arg_7_0, arg_7_1)
	if table.getn(arg_7_0.items) == table.getn(arg_7_1) then
		return
	end

	for iter_7_0, iter_7_1 in pairs(arg_7_0.items) do
		iter_7_1:removeFromParentAndCleanup(false)
	end

	arg_7_0.items = {}

	if arg_7_0.tableView ~= nil then
		arg_7_0.tableView:removeFromParentAndCleanup(true)

		arg_7_0.tableView = nil
		arg_7_0.tableViewHelper = nil
	end

	local var_7_0 = table.getn(arg_7_1)
	local var_7_1 = table.getn(arg_7_0.items)
	local var_7_2 = arg_7_0.layer:getContentSize()
	local var_7_3 = CCSizeMake(var_7_2.width, var_0_1 * var_7_0)
	local var_7_4 = CCSizeMake(var_7_2.width, var_7_2.height)

	arg_7_0.tableViewHelper = zbTableViewHelper:create()
	arg_7_0.tableView = zbTableViewHelper:createTableView(var_7_3, var_7_4, 1, arg_7_0.tableViewHelper)

	arg_7_0.tableView:setPosition(0, 0)
	arg_7_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_7_0.layer:addChild(arg_7_0.tableView)

	if var_7_0 - var_7_1 > 0 then
		for iter_7_2 = 1, var_7_0 - var_7_1 do
			local var_7_5 = zbTableViewHelper:create()

			var_7_5:loadCCBFile("ccbi/tb_friendjh_item.ccbi")

			local var_7_6 = createFriendJhItem(translateAndStrokeHelper(var_7_5:readCCBNode()))

			var_7_6:retain()

			arg_7_0.items[var_7_1 + iter_7_2] = var_7_6

			var_7_5:releaseSelf()
		end
	end

	local var_7_7 = 1

	for iter_7_3, iter_7_4 in pairs(arg_7_1) do
		local var_7_8 = arg_7_0.items[var_7_7]

		arg_7_0.tableViewHelper:addCell(var_7_8)

		var_7_7 = var_7_7 + 1
	end

	arg_7_0.tableViewHelper:refreshTabelView()
	arg_7_0.tableViewHelper:setTouchPriority(arg_7_0.btnPri:getTouchPriority())
end

function var_0_0.refreshItems(arg_8_0, arg_8_1)
	local var_8_0 = 1

	for iter_8_0, iter_8_1 in pairs(arg_8_1) do
		arg_8_0.items[var_8_0]:refresh(iter_8_1)

		var_8_0 = var_8_0 + 1
	end
end
