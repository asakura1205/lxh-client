require("gamecore.zbUIAnimation")
require("gamelogic.zbFormationHeroListCard")

local var_0_0 = class("zbFormationHeroListPanel")

var_0_0.__index = var_0_0

function createFormationHeroListPanel(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.items = {}
	arg_2_0.tableview = nil
	arg_2_0.tableviewHelper = nil
	arg_2_0.wndParent = arg_2_1
	arg_2_0.layerContent = arg_2_2
	arg_2_0.btnClose = arg_2_3
	arg_2_0.panelMaskUp = tolua.cast(arg_2_2:getChildByTag(1), "CCSprite")
	arg_2_0.panelMaskDown = tolua.cast(arg_2_2:getChildByTag(2), "CCSprite")

	zbUIEffect:runFadeToAction(arg_2_0.panelMaskUp)
	zbUIEffect:runFadeToAction(arg_2_0.panelMaskDown)
end

function var_0_0.refresh(arg_3_0)
	arg_3_0:refreshHeroCardList()
end

function var_0_0.refreshHeroCardList(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.items) do
		iter_4_1:removeFromParentAndCleanup(false)
	end

	if arg_4_0.tableView ~= nil then
		arg_4_0.tableView:removeFromParentAndCleanup(true)

		arg_4_0.tableView = nil
		arg_4_0.tableViewHelper = nil
	end

	local var_4_0 = g_Self.kHeroHandler:getSortedHeros()
	local var_4_1 = table.getn(var_4_0)
	local var_4_2 = table.getn(arg_4_0.items)

	echo("zbFormationHeroListPanel:refreshHeroCardList: 1: " .. var_4_1)

	local var_4_3 = arg_4_0.layerContent:getContentSize()
	local var_4_4 = CCSizeMake(var_4_3.width, var_4_3.height)

	arg_4_0.tableViewHelper = zbTableViewHelper:create()
	arg_4_0.tableView = zbTableViewHelper:createTableView(var_4_3, var_4_3, kCCScrollViewDirectionHorizontal, arg_4_0.tableViewHelper)

	arg_4_0.tableView:setPosition(0, 0)
	arg_4_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_4_0.layerContent:addChild(arg_4_0.tableView)

	if var_4_1 - var_4_2 > 0 then
		for iter_4_2 = 1, var_4_1 - var_4_2 do
			local var_4_5 = zbTableViewHelper:create()

			var_4_5:loadCCBFile("ccbi/tb_formation_herocard.ccbi")

			local var_4_6 = zbFormationHeroListCard:create(translateAndStrokeHelper(var_4_5:readCCBNode()), arg_4_0.layerContent, arg_4_0.wndParent)

			var_4_6:setScale(0.85)
			var_4_6:retain()
			table.insert(arg_4_0.items, var_4_6)
			var_4_5:releaseSelf()
		end
	end

	local var_4_7 = 1

	for iter_4_3, iter_4_4 in pairs(var_4_0) do
		local var_4_8 = arg_4_0.items[var_4_7]

		var_4_8:refresh(iter_4_4, arg_4_0.tableViewHelper)
		arg_4_0.tableViewHelper:addCell(var_4_8)

		var_4_7 = var_4_7 + 1
	end

	arg_4_0.tableViewHelper:refreshTabelView()
	arg_4_0.tableViewHelper:setTouchPriority(arg_4_0.btnClose:getTouchPriority())
	arg_4_0.tableViewHelper:setMaskPanel(arg_4_0.panelMaskUp, arg_4_0.panelMaskDown, nil, nil)
end
