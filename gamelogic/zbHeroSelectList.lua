require("gamelogic.zbHeroSelectCard")

zbHeroSelectList = class("zbHeroSelectList")
zbHeroSelectList.__index = zbHeroSelectList

local var_0_0 = 2
local var_0_1 = 320
local var_0_2 = 150

function createHeroListSelectPanel(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = zbHeroSelectList.new()

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	return var_1_0
end

function zbHeroSelectList.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local function var_2_0()
		arg_2_0.heroType = arg_2_2
		arg_2_0.lines = {}
		arg_2_0.items = {}
		arg_2_0.backlines = {}
		arg_2_0.heroCount = 0
		arg_2_0.heroList = {}
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

function zbHeroSelectList.refresh(arg_5_0)
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

				var_5_6:loadCCBFile("ccbi/tb_herocard.ccbi")

				local var_5_7 = createHeroSelectCard(translateAndStrokeHelper(var_5_6:readCCBNode()), arg_5_0.parent)

				var_5_7:setAnchorPoint(ccp(0, 0))
				var_5_7:setPosition((iter_5_2 - 1) * var_0_1 - 20, 0)
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

		var_5_8 = var_5_8 + 1
	end

	arg_5_0.tableViewHelper:refreshTabelView()
	arg_5_0.tableViewHelper:setTouchPriority(arg_5_0.touchPriority:getTouchPriority())
end

function zbHeroSelectList.getHeroList(arg_6_0)
	local var_6_0 = {}

	if arg_6_0.heroType == EHeroTabType.Battle then
		var_6_0 = g_Self.kHeroHandler:getWorkHeros()
	elseif arg_6_0.heroType == EHeroTabType.Entourage then
		var_6_0 = g_Self.kHeroHandler:getEntourageHeros()
	elseif arg_6_0.heroType == EHeroTabType.UnUse then
		var_6_0 = g_Self.kHeroHandler:getNoUseHeros()
	end

	local function var_6_1(arg_7_0, arg_7_1)
		local var_7_0 = zbHeroTable:getRecord(arg_7_0.HeroBaseInfo.TemplateId)
		local var_7_1 = zbHeroTable:getRecord(arg_7_1.HeroBaseInfo.TemplateId)

		if arg_7_0.HeroBaseInfo.FV == arg_7_1.HeroBaseInfo.FV then
			if var_7_0.rarity == var_7_1.rarity then
				return arg_7_0.HeroBaseInfo.Level > arg_7_1.HeroBaseInfo.Level
			else
				return var_7_0.rarity > var_7_1.rarity
			end
		else
			return arg_7_0.HeroBaseInfo.FV > arg_7_1.HeroBaseInfo.FV
		end
	end

	if arg_6_0.parentWnd.usefor == E_HeroSelWnd_usefor.E_SelHero then
		local var_6_2 = {}

		local function var_6_3(arg_8_0)
			local var_8_0 = arg_6_0.parentWnd.cannotSelList

			if zbUtil:isValidTable(var_8_0) then
				for iter_8_0, iter_8_1 in pairs(var_8_0) do
					if arg_8_0 == iter_8_1 then
						return true
					end
				end
			end

			return false
		end

		for iter_6_0, iter_6_1 in pairs(var_6_0) do
			if not var_6_3(iter_6_1.HeroBaseInfo.TemplateId) then
				table.insert(var_6_2, iter_6_1)
			end
		end

		return var_6_2
	else
		for iter_6_2, iter_6_3 in pairs(var_6_0) do
			if arg_6_0.parentWnd.templateid == iter_6_3.HeroBaseInfo.TemplateId then
				table.remove(var_6_0, iter_6_2)

				break
			end
		end
	end

	table.sort(var_6_0, var_6_1)

	return var_6_0
end
