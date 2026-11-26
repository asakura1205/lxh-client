require("gamelogic.zbShopItem")

zbShopList = class("zbShopList")
zbShopList.__index = zbShopList

function createShopList(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbShopList.new()

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2)

	return var_1_0
end

local var_0_0 = 2
local var_0_1 = 190
local var_0_2 = 220

function zbShopList.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local function var_2_0()
		arg_2_0.lines = {}
		arg_2_0.items = {}
		arg_2_0.shopType = arg_2_2
		arg_2_0.touchPriority = arg_2_3
		arg_2_0.tableView = nil
		arg_2_0.tableViewHelper = nil
		arg_2_0.dirty = true
		arg_2_0.itemdata = nil
	end

	local function var_2_1()
		arg_2_0.layer = arg_2_1
	end

	var_2_0()
	var_2_1()
end

function zbShopList.refresh(arg_5_0)
	if arg_5_0.tableView == nil or arg_5_0.dirty == true then
		arg_5_0:confirmCreateView()
	end
end

function zbShopList.refreshDirtyFlag(arg_6_0)
	arg_6_0.dirty = true
end

function zbShopList.confirmCreateView(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.lines) do
		iter_7_1:removeFromParentAndCleanup(false)
	end

	if arg_7_0.tableViewHelper ~= nil and arg_7_0.tableViewHelper.clearLuaEnterHandler ~= nil then
		arg_7_0.tableViewHelper:clearLuaEnterHandler()
	end

	if arg_7_0.tableView ~= nil then
		arg_7_0.tableView:removeFromParentAndCleanup(true)

		arg_7_0.tableView = nil
		arg_7_0.tableViewHelper = nil
	end

	local var_7_0 = arg_7_0.layer:getContentSize()

	arg_7_0.tableViewHelper = zbTableViewHelper:create()
	arg_7_0.tableView = zbTableViewHelper:createTableView(var_7_0, var_7_0, kCCScrollViewDirectionHorizontal, arg_7_0.tableViewHelper)

	arg_7_0.tableView:setPosition(0, 0)
	arg_7_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_7_0.tableViewHelper:createListView("ccbi/tb_line.ccbi")
	arg_7_0.layer:addChild(arg_7_0.tableView)

	local var_7_1 = g_Self.kShopHandler:getShopListByType(arg_7_0.shopType)
	local var_7_2 = math.ceil(table.getn(var_7_1) / var_0_0)
	local var_7_3 = table.getn(arg_7_0.lines)

	for iter_7_2 = 1, var_7_3 do
		if iter_7_2 <= var_7_2 then
			local var_7_4 = arg_7_0.lines[iter_7_2]

			arg_7_0.tableViewHelper:addCell(var_7_4)
		end
	end

	if var_7_2 - var_7_3 > 0 then
		for iter_7_3 = 1, var_7_2 - var_7_3 do
			local var_7_5 = arg_7_0.tableViewHelper:addListItem()

			var_7_5:setAnchorPoint(ccp(0, 0))
			var_7_5:setContentSize(CCSizeMake(var_0_1, var_0_2 * var_0_0))

			arg_7_0.lines[var_7_3 + iter_7_3] = var_7_5

			for iter_7_4 = 1, var_0_0 do
				local var_7_6 = zbShopItem:create(arg_7_0)

				var_7_6:setAnchorPoint(ccp(0, 0))
				var_7_6:setPosition(0, (var_0_0 - iter_7_4) * var_0_2)
				var_7_5:addChild(var_7_6)

				arg_7_0.items[(var_7_3 + iter_7_3 - 1) * var_0_0 + iter_7_4] = var_7_6
			end
		end
	end

	local var_7_7 = 1

	for iter_7_5, iter_7_6 in pairs(var_7_1) do
		arg_7_0.items[var_7_7]:refresh(iter_7_6, arg_7_0.shopType)

		var_7_7 = var_7_7 + 1
	end

	arg_7_0.tableViewHelper:refreshTabelView()
	arg_7_0.tableViewHelper:setTouchPriority(arg_7_0.touchPriority:getTouchPriority())

	if arg_7_0.tableViewHelper.SetLuaEnterHandler ~= nil then
		arg_7_0.tableViewHelper:SetLuaEnterHandler(function()
			arg_7_0:onTBNotifyEnter()
		end)
	end
end

function zbShopList.onTBNotifyEnter(arg_9_0)
	return
end
