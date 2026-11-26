require("gamelogic.zbBaseWnd")
require("gamelogic.zbItem")

local var_0_0 = class("zbHeroPreviewList")

var_0_0.__index = var_0_0

local var_0_1 = 2
local var_0_2 = 120
local var_0_3 = 130

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	local function var_1_0()
		arg_1_0.lines = {}
		arg_1_0.items = {}
		arg_1_0.tableView = nil
		arg_1_0.tableViewHelper = nil
		arg_1_0.maskPanelLeft = arg_1_3
		arg_1_0.maskPanelRight = arg_1_4
	end

	local function var_1_1()
		arg_1_0.layer = arg_1_1
		arg_1_0.type = arg_1_2
	end

	var_1_0()
	var_1_1()
end

function var_0_0.refresh(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.lines) do
		iter_4_1:removeFromParentAndCleanup(false)
	end

	if arg_4_0.tableView ~= nil then
		arg_4_0.tableView:removeFromParentAndCleanup(true)

		arg_4_0.tableView = nil
		arg_4_0.tableViewHelper = nil
	end

	local var_4_0 = arg_4_0.layer:getContentSize()

	arg_4_0.tableViewHelper = zbTableViewHelper:create()
	arg_4_0.tableView = zbTableViewHelper:createTableView(var_4_0, var_4_0, kCCScrollViewDirectionHorizontal, arg_4_0.tableViewHelper)

	arg_4_0.tableView:setPosition(0, 0)
	arg_4_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_4_0.tableViewHelper:createListView("ccbi/tb_line.ccbi")
	arg_4_0.layer:addChild(arg_4_0.tableView)
	arg_4_0.tableViewHelper:setMaskPanel(arg_4_0.maskPanelLeft, arg_4_0.maskPanelRight, nil, nil)

	local var_4_1 = zbBarRewardTable:getHeroPreViewByRarity(arg_4_0.type)
	local var_4_2 = math.ceil(table.getn(var_4_1) / var_0_1)
	local var_4_3 = table.getn(arg_4_0.lines)

	for iter_4_2 = 1, var_4_3 do
		if iter_4_2 <= var_4_2 then
			local var_4_4 = arg_4_0.lines[iter_4_2]

			arg_4_0.tableViewHelper:addCell(var_4_4)
		end
	end

	if var_4_2 - var_4_3 > 0 then
		for iter_4_3 = 1, var_4_2 - var_4_3 do
			local var_4_5 = arg_4_0.tableViewHelper:addListItem()

			var_4_5:setAnchorPoint(ccp(0, 0))
			var_4_5:setContentSize(CCSizeMake(var_0_2, var_0_3 * var_0_1))

			arg_4_0.lines[var_4_3 + iter_4_3] = var_4_5

			for iter_4_4 = 1, var_0_1 do
				local var_4_6 = createItem()

				var_4_6:setAnchorPoint(ccp(0, 0))
				var_4_6:setScale(0.9)
				var_4_6:setPosition(0, (var_0_1 - iter_4_4) * var_0_3 + 20)
				var_4_6:setSwallowsTouches(false)
				var_4_6:setSupportTouchDownTip(false)
				var_4_6:setSupportTouchTip(true)
				var_4_5:addChild(var_4_6)

				arg_4_0.items[(var_4_3 + iter_4_3 - 1) * var_0_1 + iter_4_4] = var_4_6
			end
		end
	end

	local var_4_7 = 1

	for iter_4_5, iter_4_6 in pairs(var_4_1) do
		arg_4_0.items[var_4_7]:refreshAward(ECommonAwardType.Hero, iter_4_6.id, 1)
		arg_4_0.items[var_4_7]:setStarVisible(ECommonAwardType.Hero, iter_4_6.id)
		arg_4_0.items[var_4_7]:setVisible(true)

		var_4_7 = var_4_7 + 1
	end

	local var_4_8 = table.getn(arg_4_0.items)

	for iter_4_7 = var_4_7, var_4_8 do
		arg_4_0.items[iter_4_7]:setVisible(false)
	end

	arg_4_0.tableViewHelper:refreshTabelView()

	if g_MainScene.wndHeroPreview then
		arg_4_0.tableViewHelper:setTouchPriority(g_MainScene.wndHeroPreview.btnClose:getTouchPriority())
	end
end

function createHeroPreviewList(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = var_0_0.new()

	var_5_0:init(arg_5_0, arg_5_1, arg_5_2, arg_5_3)

	return var_5_0
end
