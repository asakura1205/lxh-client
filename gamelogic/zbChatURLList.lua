require("gamelogic.zbChatURLItem")

zbChatURLList = class("zbChatURLList")
zbChatURLList.__index = zbChatURLList

local var_0_0 = 7
local var_0_1 = 110
local var_0_2 = 110

function createChatURLList(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbChatURLList.new()

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2)

	return var_1_0
end

function zbChatURLList.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local function var_2_0()
		arg_2_0.lines = {}
		arg_2_0.items = {}
		arg_2_0.urlType = arg_2_2
		arg_2_0.touchPriority = arg_2_3
	end

	local function var_2_1()
		arg_2_0.layer = arg_2_1
		arg_2_0.tableView = nil
		arg_2_0.tableViewHelper = nil
	end

	var_2_0()
	var_2_1()
end

function zbChatURLList.refresh(arg_5_0)
	local var_5_0 = arg_5_0:GetItemsList()

	arg_5_0:confirmCreateView(var_5_0)
end

function zbChatURLList.GetItemsList(arg_6_0)
	local var_6_0 = {}

	if arg_6_0.urlType == EChatURLTab.Equip then
		var_6_0 = g_GameData.BagEquipList
	elseif arg_6_0.urlType == EChatURLTab.Hero then
		var_6_0 = g_GameData.HeroList
	end

	return var_6_0
end

function zbChatURLList.confirmCreateView(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.lines) do
		iter_7_1:removeFromParentAndCleanup(false)
	end

	if arg_7_0.tableView ~= nil then
		arg_7_0.tableViewHelper:clear()

		arg_7_0.tableViewHelper = nil

		arg_7_0.tableView:removeFromParentAndCleanup(true)

		arg_7_0.tableView = nil
	end

	if arg_7_0.tableView == nil then
		local var_7_0 = arg_7_0.layer:getContentSize()

		arg_7_0.tableViewHelper = zbTableViewHelper:create()
		arg_7_0.tableView = zbTableViewHelper:createTableView(var_7_0, var_7_0, 1, arg_7_0.tableViewHelper)

		arg_7_0.tableView:setPosition(0, 0)
		arg_7_0.tableView:setAnchorPoint(ccp(0, 0))
		arg_7_0.tableViewHelper:createListView("ccbi/tb_line.ccbi")
		arg_7_0.layer:addChild(arg_7_0.tableView)
	end

	local var_7_1 = math.ceil(table.getn(arg_7_1) / var_0_0)
	local var_7_2 = table.getn(arg_7_0.lines)

	for iter_7_2 = 1, var_7_2 do
		if iter_7_2 <= var_7_1 then
			local var_7_3 = arg_7_0.lines[iter_7_2]

			arg_7_0.tableViewHelper:addCell(var_7_3)
		end
	end

	if var_7_1 - var_7_2 > 0 then
		for iter_7_3 = 1, var_7_1 - var_7_2 do
			local var_7_4 = arg_7_0.tableViewHelper:addListItem()

			var_7_4:setAnchorPoint(ccp(0, 0))
			var_7_4:setContentSize(CCSizeMake(var_0_1 * var_0_0, var_0_2))

			arg_7_0.lines[var_7_2 + iter_7_3] = var_7_4

			for iter_7_4 = 1, var_0_0 do
				local var_7_5 = zbTableViewHelper:create()

				var_7_5:loadCCBFile("ccbi/tb_heroShow.ccbi")

				local var_7_6 = zbChatURLItem:create(translateAndStrokeHelper(var_7_5:readCCBNode()))

				var_7_6:setAnchorPoint(ccp(0, 0))
				var_7_6:setPosition((iter_7_4 - 1) * var_0_1, 10)
				var_7_6:setScale(0.85)
				var_7_4:addChild(var_7_6)

				arg_7_0.items[(var_7_2 + iter_7_3 - 1) * var_0_0 + iter_7_4] = var_7_6

				var_7_5:releaseSelf()
			end
		end
	end

	local var_7_7 = 1

	for iter_7_5, iter_7_6 in pairs(arg_7_0.lines) do
		iter_7_6:setContentSize(CCSizeMake(var_0_1 * var_0_0, var_0_2))

		var_7_7 = var_7_7 + 1
	end

	for iter_7_7, iter_7_8 in pairs(arg_7_0.items) do
		iter_7_8:setVisible(false)
	end

	local var_7_8 = 1

	for iter_7_9, iter_7_10 in pairs(arg_7_1) do
		arg_7_0.items[var_7_8]:refresh(arg_7_0.urlType, iter_7_10)

		var_7_8 = var_7_8 + 1
	end

	arg_7_0.tableViewHelper:refreshTabelView()
	arg_7_0.tableViewHelper:setTouchPriority(arg_7_0.touchPriority:getTouchPriority())
end
