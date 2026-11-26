require("gamelogic.zbTaskWnd_SuccessItem")

local var_0_0 = class("zbTaskWnd_Success")

var_0_0.__index = var_0_0
TaskItem_Height = 142

function createTaskSuccess(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local function var_2_0()
		arg_2_0.items = {}
		arg_2_0.tableView = nil
		arg_2_0.tableViewHelper = nil
		arg_2_0.scrollBar = nil
		arg_2_0.btnPriority = arg_2_2
		arg_2_0.parentWnd = arg_2_3
	end

	local function var_2_1()
		arg_2_0.spriteLeft = tolua.cast(arg_2_1:getChildByTag(1), "CCSprite")

		local var_4_0 = tolua.cast(arg_2_1:getChildByTag(2), "CCLayer")

		arg_2_0.mainLayer = tolua.cast(var_4_0:getChildByTag(1), "CCLayer")
		arg_2_0.scrollNode = tolua.cast(var_4_0:getChildByTag(401), "CCNode")
	end

	var_2_0()
	var_2_1()
end

function var_0_0.refresh(arg_5_0)
	local var_5_0 = g_GameData.MainTask

	arg_5_0:confirmCreateView(var_5_0)
	arg_5_0:refreshItems(var_5_0)
end

function var_0_0.confirmCreateView(arg_6_0, arg_6_1)
	if table.getn(arg_6_0.items) == table.getn(arg_6_1) then
		return
	end

	for iter_6_0, iter_6_1 in pairs(arg_6_0.items) do
		iter_6_1:removeFromParentAndCleanup(false)
	end

	arg_6_0.items = {}

	if arg_6_0.tableView ~= nil then
		arg_6_0.tableView:removeFromParentAndCleanup(true)

		arg_6_0.tableView = nil
		arg_6_0.tableViewHelper = nil
	end

	local var_6_0 = table.getn(arg_6_1)
	local var_6_1 = table.getn(arg_6_0.items)
	local var_6_2 = arg_6_0.mainLayer:getContentSize()
	local var_6_3 = CCSizeMake(var_6_2.width, TaskItem_Height * var_6_0)
	local var_6_4 = CCSizeMake(var_6_2.width, var_6_2.height)

	arg_6_0.tableViewHelper = zbTableViewHelper:create()
	arg_6_0.tableView = zbTableViewHelper:createTableView(var_6_3, var_6_4, 1, arg_6_0.tableViewHelper)

	arg_6_0.tableView:setPosition(0, 0)
	arg_6_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_6_0.mainLayer:addChild(arg_6_0.tableView)

	if var_6_0 - var_6_1 > 0 then
		for iter_6_2 = 1, var_6_0 - var_6_1 do
			local var_6_5 = createTaskSuccessItem(arg_6_0.parentWnd)

			var_6_5:retain()

			arg_6_0.items[var_6_1 + iter_6_2] = var_6_5
		end
	end

	local var_6_6 = 1

	for iter_6_3, iter_6_4 in pairs(arg_6_1) do
		local var_6_7 = arg_6_0.items[var_6_6]

		var_6_7:refresh(iter_6_4)
		arg_6_0.tableViewHelper:addCell(var_6_7)

		var_6_6 = var_6_6 + 1
	end

	arg_6_0.tableViewHelper:refreshTabelView()

	arg_6_0.scrollBar = ui:createScrollBarView(arg_6_0.tableView, arg_6_0.scrollNode, var_6_2.height)

	arg_6_0.tableViewHelper:setTouchPriority(arg_6_0.btnPriority:getTouchPriority())
end

function var_0_0.refreshItems(arg_7_0, arg_7_1)
	local var_7_0 = 1

	for iter_7_0, iter_7_1 in pairs(arg_7_1) do
		arg_7_0.items[var_7_0]:refresh(iter_7_1)

		var_7_0 = var_7_0 + 1
	end
end

function var_0_0.onFrame(arg_8_0)
	if arg_8_0.scrollBar then
		arg_8_0.scrollBar:update()
	end
end
