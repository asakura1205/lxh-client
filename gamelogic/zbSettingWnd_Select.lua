require("gamelogic.zbSettingWnd_SelectItem")

local var_0_0 = class("zbSettingWnd_Select")

var_0_0.__index = var_0_0

function createSettingSelectPanel(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	local function var_2_0()
		arg_2_0.items = {}
		arg_2_0.tableview = nil
		arg_2_0.tableviewHelper = nil
		arg_2_0.parentWnd = arg_2_1
	end

	local function var_2_1()
		arg_2_0.layerSelect = tolua.cast(arg_2_2:getChildByTag(1), "CCLayer")
	end

	var_2_0()
	var_2_1()
	arg_2_0:creatTableView()
end

function var_0_0.creatTableView(arg_5_0)
	for iter_5_0 = 1, EPushType.E_MAX do
		if iter_5_0 ~= EPushType.E_TILI_GET2 and iter_5_0 ~= EPushType.E_TILI_GET3 then
			local var_5_0 = zbTableViewHelper:create()

			var_5_0:loadCCBFile("ccbi/tb_setSelect.ccbi")

			local var_5_1 = createSettingSelectItem(translateAndStrokeHelper(var_5_0:readCCBNode()), iter_5_0)

			var_5_1:retain()
			table.insert(arg_5_0.items, var_5_1)
			var_5_0:releaseSelf()
		end
	end

	local var_5_2 = 90
	local var_5_3 = table.getn(arg_5_0.items)
	local var_5_4 = arg_5_0.layerSelect:getContentSize()
	local var_5_5 = CCSizeMake(var_5_4.width, var_5_2 * var_5_3)
	local var_5_6 = CCSizeMake(var_5_4.width, var_5_4.height)

	arg_5_0.tableViewHelper = zbTableViewHelper:create()
	arg_5_0.tableView = zbTableViewHelper:createTableView(var_5_5, var_5_6, 1, arg_5_0.tableViewHelper)

	arg_5_0.tableView:setPosition(0, 0)
	arg_5_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_5_0.layerSelect:addChild(arg_5_0.tableView)

	for iter_5_1, iter_5_2 in pairs(arg_5_0.items) do
		iter_5_2:refresh()
		arg_5_0.tableViewHelper:addCell(iter_5_2)
	end

	arg_5_0.tableViewHelper:refreshTabelView()
end

function var_0_0.refresh(arg_6_0)
	return
end
