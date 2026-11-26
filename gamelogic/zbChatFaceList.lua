require("gamelogic.zbChatFaceItem")

local var_0_0 = class("zbChatFaceList")

var_0_0.__index = var_0_0

function createFaceList(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

local var_0_1 = 12
local var_0_2 = 64
local var_0_3 = 64

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	local function var_2_0()
		arg_2_0.lines = {}
		arg_2_0.items = {}
	end

	local function var_2_1()
		return
	end

	var_2_0()
	var_2_1()
	arg_2_0:createView(arg_2_1, arg_2_2)
end

function var_0_0.createView(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1:getContentSize()

	arg_5_0.tableViewHelper = zbTableViewHelper:create()
	arg_5_0.tableView = zbTableViewHelper:createTableView(var_5_0, var_5_0, kCCScrollViewDirectionVertical, arg_5_0.tableViewHelper)

	arg_5_0.tableView:setPosition(0, 0)
	arg_5_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_5_0.tableViewHelper:createListView("ccbi/tb_line.ccbi")
	arg_5_1:addChild(arg_5_0.tableView)

	local var_5_1 = 24
	local var_5_2 = math.ceil(var_5_1 / var_0_1)

	for iter_5_0 = 1, var_5_2 do
		local var_5_3 = arg_5_0.tableViewHelper:addListItem()

		var_5_3:setAnchorPoint(ccp(0, 0))
		var_5_3:setContentSize(CCSizeMake(var_0_2 * var_0_1, var_0_3))

		arg_5_0.lines[iter_5_0] = var_5_3

		for iter_5_1 = 1, var_0_1 do
			local var_5_4 = zbTableViewHelper:create()

			var_5_4:loadCCBFile("ccbi/tb_chatface.ccbi")

			local var_5_5 = createChatFaceItem(translateAndStrokeHelper(var_5_4:readCCBNode()))

			var_5_5:setAnchorPoint(ccp(0, 0))
			var_5_5:setPosition((iter_5_1 - 1) * var_0_2, 0)
			var_5_3:addChild(var_5_5)

			arg_5_0.items[(iter_5_0 - 1) * var_0_1 + iter_5_1] = var_5_5

			var_5_4:releaseSelf()
		end
	end

	for iter_5_2 = 1, var_5_1 do
		arg_5_0.items[iter_5_2]:refresh(iter_5_2)
	end

	arg_5_0.tableViewHelper:refreshTabelView()
	arg_5_0.tableViewHelper:setTouchPriority(arg_5_2)
end
