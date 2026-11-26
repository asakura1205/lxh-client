require("gamelogic.zbHeroCard")
require("gamelogic.zbHeroFragCard")

zbHeroList = class("zbHeroList")
zbHeroList.__index = zbHeroList

local var_0_0 = 3

function createHeroListPanel(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	local var_1_0 = zbHeroList.new()

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)

	return var_1_0
end

function zbHeroList.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
	local function var_2_0()
		arg_2_0.heroType = arg_2_2
		arg_2_0.lines = {}
		arg_2_0.items = {}
		arg_2_0.maskLeft = arg_2_3
		arg_2_0.maskRight = arg_2_4
		arg_2_0.touchPriority = arg_2_5
		arg_2_0.parentWnd = arg_2_6
	end

	local function var_2_1()
		arg_2_0.dirty = true
		arg_2_0.layerContent = arg_2_1
		arg_2_0.tableView = nil
		arg_2_0.tableViewHelper = nil
	end

	var_2_0()
	var_2_1()
end

function zbHeroList.refresh(arg_5_0)
	if arg_5_0.tableView == nil or arg_5_0.dirty == true then
		arg_5_0:confirmCreateView()

		arg_5_0.dirty = false
	end

	arg_5_0.tableViewHelper:refreshTabelView()
	zbUtil:setTableViewOffset(arg_5_0.tableViewHelper, kCCScrollViewDirectionHorizontal, kCCTableViewFillBottomUp, 3, arg_5_0.count, HeroCard_Width, 1)
end

function zbHeroList.refreshDirtyFlag(arg_6_0)
	arg_6_0.dirty = true
end

function zbHeroList.confirmCreateView(arg_7_0)
	if arg_7_0.tableView == nil then
		local var_7_0 = arg_7_0.layerContent:getContentSize()

		arg_7_0.tableViewHelper = zbTableViewHelper:create()
		arg_7_0.tableView = zbTableViewHelper:createTableView(var_7_0, var_7_0, 1, arg_7_0.tableViewHelper)

		arg_7_0.tableView:setPosition(0, 0)
		arg_7_0.tableView:setAnchorPoint(ccp(0, 0))
		arg_7_0.tableViewHelper:createListView("ccbi/tb_line.ccbi")
		arg_7_0.layerContent:addChild(arg_7_0.tableView)
		arg_7_0.tableViewHelper:setMaskPanel(nil, nil, arg_7_0.maskLeft, arg_7_0.maskRight)
	else
		arg_7_0.tableViewHelper:removeAllCells()
	end

	local var_7_1 = arg_7_0:getHeroList()
	local var_7_2 = math.ceil(table.getn(var_7_1) / var_0_0)
	local var_7_3 = table.getn(arg_7_0.lines)

	arg_7_0.count = var_7_2

	for iter_7_0 = 1, var_7_3 do
		if iter_7_0 <= var_7_2 then
			local var_7_4 = arg_7_0.lines[iter_7_0]

			arg_7_0.tableViewHelper:addCell(var_7_4)
		end
	end

	if var_7_2 - var_7_3 > 0 then
		for iter_7_1 = 1, var_7_2 - var_7_3 do
			local var_7_5 = arg_7_0.tableViewHelper:addListItem()

			var_7_5:setAnchorPoint(ccp(0, 0))
			var_7_5:setContentSize(CCSizeMake(HeroCard_Width * var_0_0, HeroCard_Height))

			arg_7_0.lines[var_7_3 + iter_7_1] = var_7_5

			for iter_7_2 = 1, var_0_0 do
				local var_7_6

				if arg_7_0.heroType ~= EHeroTabType.UnObtain then
					var_7_6 = zbHeroCard:create(arg_7_0.parentWnd)
				else
					var_7_6 = zbHeroFragCard:create(arg_7_0.parentWnd)
				end

				var_7_6:setAnchorPoint(ccp(0, 0))
				var_7_6:setPosition((iter_7_2 - 1) * HeroCard_Width - 10, 0)
				var_7_5:addChild(var_7_6)

				arg_7_0.items[(var_7_3 + iter_7_1 - 1) * var_0_0 + iter_7_2] = var_7_6
			end
		end
	end

	for iter_7_3, iter_7_4 in pairs(arg_7_0.items) do
		iter_7_4:setVisible(false)
	end

	local var_7_7 = 1

	for iter_7_5, iter_7_6 in pairs(var_7_1) do
		arg_7_0.items[var_7_7]:refresh(iter_7_6, arg_7_0.heroType, var_7_1)

		var_7_7 = var_7_7 + 1
	end

	arg_7_0.tableViewHelper:refreshTabelView()
	arg_7_0.tableViewHelper:setTouchPriority(arg_7_0.touchPriority:getTouchPriority())
end

function zbHeroList.getHeroList(arg_8_0)
	local var_8_0 = {}

	if arg_8_0.heroType == EHeroTabType.Battle then
		var_8_0 = g_Self.kHeroHandler:getWorkHeros()
	elseif arg_8_0.heroType == EHeroTabType.Entourage then
		var_8_0 = g_Self.kHeroHandler:getEntourageHeros()
	elseif arg_8_0.heroType == EHeroTabType.UnUse then
		var_8_0 = g_Self.kHeroHandler:getNoUseHeros()
	elseif arg_8_0.heroType == EHeroTabType.UnObtain then
		var_8_0 = g_Self.kHeroFragHandler:getSortedHeroFragsByType()
	end

	return var_8_0
end
