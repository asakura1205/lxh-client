require("gamelogic.zbVipshopItem")

local var_0_0 = class("zbVipItemList")

var_0_0.__index = var_0_0

local var_0_1 = 2
local var_0_2 = 320
local var_0_3 = 190

function var_0_0.init(arg_1_0, arg_1_1)
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

function var_0_0.refresh(arg_4_0)
	local var_4_0 = g_GameData.VipInfo.VipShop

	if zbUtil:isValidTable(var_4_0) then
		arg_4_0:confirmCreateView(var_4_0)
		arg_4_0:refreshItems(var_4_0)
	end
end

function var_0_0.confirmCreateView(arg_5_0, arg_5_1)
	if table.getn(arg_5_0.items) == table.getn(arg_5_1) then
		return
	end

	for iter_5_0, iter_5_1 in pairs(arg_5_0.lines) do
		iter_5_1:removeFromParentAndCleanup(false)
	end

	if arg_5_0.tableView ~= nil then
		arg_5_0.tableView:removeFromParentAndCleanup(true)

		arg_5_0.tableView = nil
		arg_5_0.tableViewHelper = nil
	end

	local var_5_0 = arg_5_0.layer:getContentSize()

	arg_5_0.tableViewHelper = zbTableViewHelper:create()
	arg_5_0.tableView = zbTableViewHelper:createTableView(var_5_0, var_5_0, kCCScrollViewDirectionHorizontal, arg_5_0.tableViewHelper)

	arg_5_0.tableView:setPosition(0, 0)
	arg_5_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_5_0.tableViewHelper:createListView("ccbi/tb_line.ccbi")
	arg_5_0.layer:addChild(arg_5_0.tableView)

	local var_5_1 = math.ceil(table.getn(arg_5_1) / var_0_1)
	local var_5_2 = table.getn(arg_5_0.lines)

	for iter_5_2 = 1, var_5_2 do
		if iter_5_2 <= var_5_1 then
			local var_5_3 = arg_5_0.lines[iter_5_2]

			arg_5_0.tableViewHelper:addCell(var_5_3)
		end
	end

	if var_5_1 - var_5_2 > 0 then
		for iter_5_3 = 1, var_5_1 - var_5_2 do
			local var_5_4 = arg_5_0.tableViewHelper:addListItem()

			var_5_4:setAnchorPoint(ccp(0, 0))
			var_5_4:setContentSize(CCSizeMake(var_0_2, var_0_3 * var_0_1))

			arg_5_0.lines[var_5_2 + iter_5_3] = var_5_4

			for iter_5_4 = 1, var_0_1 do
				local var_5_5 = zbTableViewHelper:create()

				var_5_5:loadCCBFile("ccbi/tb_vipshop.ccbi")

				local var_5_6 = createVipShopItem(translateAndStrokeHelper(var_5_5:readCCBNode()))

				var_5_6:setAnchorPoint(ccp(0, 0))
				var_5_6:setPosition(0, (var_0_1 - iter_5_4) * var_0_3)
				var_5_4:addChild(var_5_6)

				arg_5_0.items[(var_5_2 + iter_5_3 - 1) * var_0_1 + iter_5_4] = var_5_6

				var_5_5:releaseSelf()
			end
		end
	end

	local var_5_7 = 1

	for iter_5_5, iter_5_6 in pairs(arg_5_1) do
		arg_5_0.items[var_5_7]:setVisible(true)

		var_5_7 = var_5_7 + 1
	end

	local var_5_8 = table.getn(arg_5_0.items)

	for iter_5_7 = var_5_7, var_5_8 do
		arg_5_0.items[iter_5_7]:setVisible(false)
	end

	arg_5_0.tableViewHelper:refreshTabelView()

	if g_MainScene.wndVip then
		arg_5_0.tableViewHelper:setTouchPriority(g_MainScene.wndVip.btnBuy:getTouchPriority())
	end
end

function var_0_0.refreshItems(arg_6_0, arg_6_1)
	local var_6_0 = 1

	for iter_6_0, iter_6_1 in pairs(arg_6_1) do
		arg_6_0.items[var_6_0]:refresh(iter_6_1)

		var_6_0 = var_6_0 + 1
	end
end

function createVipItemList(arg_7_0)
	local var_7_0 = var_0_0.new()

	var_7_0:init(arg_7_0)

	return var_7_0
end
