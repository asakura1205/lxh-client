require("gamelogic.zbLegionHeroTrainSelectItem")

local var_0_0 = 4
local var_0_1 = 120
local var_0_2 = 145
local var_0_3 = class("zbLegionHeroTrainListSelect")

var_0_3.__index = var_0_3

function createHeroTrainListSelect(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_3.new()

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2)

	return var_1_0
end

function var_0_3.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local function var_2_0()
		arg_2_0.heroType = arg_2_3
		arg_2_0.touchPriority = arg_2_2
		arg_2_0.lines = {}
		arg_2_0.items = {}
		arg_2_0.tableView = nil
		arg_2_0.tableViewHelper = nil
	end

	local function var_2_1()
		arg_2_0.layerContent = arg_2_1
	end

	var_2_0()
	var_2_1()
end

function var_0_3.refresh(arg_5_0)
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
		local var_5_5 = zbTableViewHelper:create()

		var_5_5:loadCCBFile("ccbi/tb_herotrain.ccbi")

		for iter_5_1 = 1, var_5_2 - var_5_3 do
			local var_5_6 = arg_5_0.tableViewHelper:addListItem()

			var_5_6:setAnchorPoint(ccp(0, 0))
			var_5_6:setContentSize(CCSizeMake(var_0_1 * var_0_0, var_0_2))

			arg_5_0.lines[var_5_3 + iter_5_1] = var_5_6

			for iter_5_2 = 1, var_0_0 do
				local var_5_7 = createLegionHeroTrainSelectItem(translateAndStrokeHelper(var_5_5:readCCBNode()), arg_5_0.parent)

				var_5_7:setAnchorPoint(ccp(0, 0))
				var_5_7:setPosition((iter_5_2 - 1) * var_0_1, 0)
				var_5_6:addChild(var_5_7)

				arg_5_0.items[(var_5_3 + iter_5_1 - 1) * var_0_0 + iter_5_2] = var_5_7
			end
		end
	end

	for iter_5_3, iter_5_4 in pairs(arg_5_0.items) do
		iter_5_4:setVisible(false)
	end

	local var_5_8 = 1

	for iter_5_5, iter_5_6 in pairs(var_5_1) do
		arg_5_0.items[var_5_8]:refresh(iter_5_6)

		var_5_8 = var_5_8 + 1
	end

	arg_5_0.tableViewHelper:refreshTabelView()
	arg_5_0.tableViewHelper:setTouchPriority(arg_5_0.touchPriority:getTouchPriority())
end

function var_0_3.setSelectCard(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.items) do
		iter_6_1:setSelecteState(arg_6_1)
	end
end

function var_0_3.getHeroList(arg_7_0)
	local var_7_0 = {}

	if arg_7_0.heroType == EHeroTabType.Battle then
		var_7_0 = g_Self.kHeroHandler:getWorkHeros()
	elseif arg_7_0.heroType == EHeroTabType.Entourage then
		var_7_0 = g_Self.kHeroHandler:getEntourageHeros()
	elseif arg_7_0.heroType == EHeroTabType.UnUse then
		var_7_0 = g_Self.kHeroHandler:getNoUseHeros()
	end

	local var_7_1 = {}

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		local var_7_2 = false

		for iter_7_2, iter_7_3 in pairs(g_Self.kLegionHandler.legionDetail.Train) do
			if iter_7_3.TemplateId == iter_7_1.HeroBaseInfo.TemplateId then
				var_7_2 = true
			end
		end

		if var_7_2 == false then
			table.insert(var_7_1, iter_7_1)
		end
	end

	return var_7_1
end
