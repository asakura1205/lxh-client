require("gamelogic.zbWorldHeroSelectItem")

zbWorldHeroSelectList = class("zbWorldHeroSelectList")
zbWorldHeroSelectList.__index = zbWorldHeroSelectList

local var_0_0 = 4
local var_0_1 = 140
local var_0_2 = 140

function createWorldHeroSelectPanel(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = zbWorldHeroSelectList.new()

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	return var_1_0
end

function zbWorldHeroSelectList.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local function var_2_0()
		arg_2_0.heroType = arg_2_2
		arg_2_0.lines = {}
		arg_2_0.items = {}
		arg_2_0.touchPriority = arg_2_3
	end

	local function var_2_1()
		arg_2_0.layerContent = arg_2_1
		arg_2_0.parentWnd = arg_2_4
		arg_2_0.tableView = nil
		arg_2_0.tableViewHelper = nil
	end

	var_2_0()
	var_2_1()
end

function zbWorldHeroSelectList.refresh(arg_5_0)
	if arg_5_0.tableView == nil then
		local var_5_0 = arg_5_0.layerContent:getContentSize()

		arg_5_0.tableViewHelper = zbTableViewHelper:create()
		arg_5_0.tableView = zbTableViewHelper:createTableView(var_5_0, var_5_0, 1, arg_5_0.tableViewHelper)

		arg_5_0.tableView:setPosition(0, 0)
		arg_5_0.tableView:setAnchorPoint(ccp(0, 0))
		arg_5_0.tableViewHelper:createListView("ccbi/tb_line.ccbi")
		arg_5_0.layerContent:addChild(arg_5_0.tableView)
	else
		arg_5_0.tableViewHelper:removeAllCells()
	end

	local var_5_1 = arg_5_0:getHeroList()
	local var_5_2 = math.ceil(table.getn(var_5_1) / var_0_0)
	local var_5_3 = table.getn(arg_5_0.lines)

	arg_5_0.count = var_5_2

	for iter_5_0 = 1, var_5_3 do
		if iter_5_0 <= var_5_2 then
			local var_5_4 = arg_5_0.lines[iter_5_0]

			arg_5_0.tableViewHelper:addCell(var_5_4)
		end
	end

	if var_5_2 - var_5_3 > 0 then
		for iter_5_1 = 1, var_5_2 - var_5_3 do
			local var_5_5 = arg_5_0.tableViewHelper:addListItem()

			var_5_5:setAnchorPoint(ccp(0, 0))
			var_5_5:setContentSize(CCSizeMake(var_0_1 * var_0_0, var_0_2))

			arg_5_0.lines[var_5_3 + iter_5_1] = var_5_5

			for iter_5_2 = 1, var_0_0 do
				local var_5_6 = zbTableViewHelper:create()

				var_5_6:loadCCBFile("ccbi/tb_world_heroselect.ccbi")

				local var_5_7 = createWorldHeroSelectItem(translateAndStrokeHelper(var_5_6:readCCBNode()), arg_5_0.parent)

				var_5_7:setAnchorPoint(ccp(0, 0))
				var_5_7:setPosition((iter_5_2 - 1) * var_0_1 + 10, -10)
				var_5_5:addChild(var_5_7)

				arg_5_0.items[(var_5_3 + iter_5_1 - 1) * var_0_0 + iter_5_2] = var_5_7

				var_5_6:releaseSelf()
			end
		end
	end

	for iter_5_3, iter_5_4 in pairs(arg_5_0.items) do
		iter_5_4:setVisible(false)
	end

	local var_5_8 = 1

	for iter_5_5, iter_5_6 in pairs(var_5_1) do
		arg_5_0.items[var_5_8]:refresh(iter_5_6, arg_5_0.heroType)
		arg_5_0.items[var_5_8]:setVisible(true)

		var_5_8 = var_5_8 + 1
	end

	arg_5_0.tableViewHelper:refreshTabelView()
	arg_5_0.tableViewHelper:setTouchPriority(arg_5_0.touchPriority:getTouchPriority())
end

function zbWorldHeroSelectList.getHeroList(arg_6_0)
	local var_6_0 = {}
	local var_6_1 = g_Self.kHeroHandler:getHeroByTabType(arg_6_0.heroType)
	local var_6_2 = {}

	local function var_6_3(arg_7_0)
		local var_7_0 = arg_6_0.parentWnd.cannotSelList

		if zbUtil:isValidTable(var_7_0) then
			for iter_7_0, iter_7_1 in pairs(var_7_0) do
				if arg_7_0 == iter_7_1 then
					return true
				end
			end
		end

		return false
	end

	for iter_6_0, iter_6_1 in pairs(var_6_1) do
		if not var_6_3(iter_6_1.HeroBaseInfo.TemplateId) then
			table.insert(var_6_2, iter_6_1)
		end
	end

	local function var_6_4(arg_8_0, arg_8_1)
		return arg_8_0.HeroBaseInfo.FV > arg_8_1.HeroBaseInfo.FV
	end

	table.sort(var_6_2, var_6_4)

	return var_6_2
end
