require("gamelogic.zbLegionRedGainItem")

local var_0_0 = class("zbLegionRedWnd_Gain")

var_0_0.__index = var_0_0
LegionRedItem_Height = 140

function createLegionRedGain(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local function var_2_0()
		arg_2_0.btnPriority = arg_2_2
		arg_2_0.parentWnd = arg_2_3
		arg_2_0.items = {}
		arg_2_0.scrollBar = nil
		arg_2_0.LegionHongbao = nil
	end

	local function var_2_1()
		arg_2_0.layerContent = tolua.cast(arg_2_1:getChildByTag(1), "CCLayer")
		arg_2_0.scrollNode = tolua.cast(arg_2_1:getChildByTag(401), "CCNode")
	end

	var_2_0()
	var_2_1()
end

function var_0_0.refresh(arg_5_0)
	arg_5_0.LegionHongbao = g_Self.kLegionHandler.legionDetail.LegionHongbao

	if arg_5_0.LegionHongbao == nil then
		return
	end

	local function var_5_0(arg_6_0, arg_6_1)
		return arg_6_0.UUID > arg_6_1.UUID
	end

	table.sort(arg_5_0.LegionHongbao, var_5_0)
	arg_5_0:confirmCreateView(arg_5_0.LegionHongbao)
	arg_5_0:refreshItems(arg_5_0.LegionHongbao)
end

function var_0_0.confirmCreateView(arg_7_0, arg_7_1)
	if table.getn(arg_7_0.items) == table.getn(arg_7_1) then
		return
	end

	for iter_7_0, iter_7_1 in pairs(arg_7_0.items) do
		iter_7_1:removeFromParentAndCleanup(false)
	end

	arg_7_0.items = {}

	if arg_7_0.tableView ~= nil then
		arg_7_0.tableView:removeFromParentAndCleanup(true)

		arg_7_0.tableView = nil
		arg_7_0.tableViewHelper = nil
	end

	local var_7_0 = table.getn(arg_7_1)
	local var_7_1 = table.getn(arg_7_0.items)
	local var_7_2 = arg_7_0.layerContent:getContentSize()
	local var_7_3 = CCSizeMake(var_7_2.width, LegionRedItem_Height * var_7_0)
	local var_7_4 = CCSizeMake(var_7_2.width, var_7_2.height)

	arg_7_0.tableViewHelper = zbTableViewHelper:create()
	arg_7_0.tableView = zbTableViewHelper:createTableView(var_7_3, var_7_4, 1, arg_7_0.tableViewHelper)

	arg_7_0.tableView:setPosition(0, 0)
	arg_7_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_7_0.layerContent:addChild(arg_7_0.tableView)

	if var_7_0 - var_7_1 > 0 then
		local var_7_5 = zbTableViewHelper:create()

		var_7_5:loadCCBFile("ccbi/tb_legion_redgain.ccbi")

		for iter_7_2 = 1, var_7_0 - var_7_1 do
			local var_7_6 = createLegionRedGainItem(translateAndStrokeHelper(var_7_5:readCCBNode()), arg_7_0.parentWnd)

			var_7_6:retain()

			arg_7_0.items[var_7_1 + iter_7_2] = var_7_6
		end
	end

	local var_7_7 = 1

	for iter_7_3, iter_7_4 in pairs(arg_7_1) do
		local var_7_8 = arg_7_0.items[var_7_7]

		var_7_8:refresh(iter_7_4)
		arg_7_0.tableViewHelper:addCell(var_7_8)

		var_7_7 = var_7_7 + 1
	end

	arg_7_0.tableViewHelper:refreshTabelView()

	arg_7_0.scrollBar = ui:createScrollBarView(arg_7_0.tableView, arg_7_0.scrollNode, var_7_2.height)

	arg_7_0.tableViewHelper:setTouchPriority(arg_7_0.btnPriority:getTouchPriority())
end

function var_0_0.refreshItems(arg_8_0, arg_8_1)
	local var_8_0 = 1

	for iter_8_0, iter_8_1 in pairs(arg_8_1) do
		arg_8_0.items[var_8_0]:refresh(iter_8_1)

		var_8_0 = var_8_0 + 1
	end
end

function var_0_0.onFrame(arg_9_0)
	if arg_9_0.scrollBar then
		arg_9_0.scrollBar:update()
	end
end
