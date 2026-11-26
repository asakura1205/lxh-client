require("gamelogic.zbBaseWnd")
require("gamelogic.zbLegionWarApplyItem")

local var_0_0 = class("zbLegionWarApplyWnd", zbBaseWnd)

var_0_0.__index = var_0_0

local var_0_1 = 130

function createLegionWarApplyWnd()
	local var_1_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_1_0:initBase()
	var_1_0:init()

	return var_1_0
end

function var_0_0.extend(arg_2_0)
	local var_2_0 = tolua.getpeer(arg_2_0)

	if not var_2_0 then
		var_2_0 = {}

		tolua.setpeer(arg_2_0, var_2_0)
	end

	setmetatable(var_2_0, var_0_0)

	return arg_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.items = {}
		arg_3_0.tableview = nil
		arg_3_0.tableviewHelper = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/legionwar_apply.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_3_0.layerContent = tolua.cast(var_5_2:getChildByTag(1), "CCLayer")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_HideAll)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refresh()
	end, zbGameEvent.Event_Update_LegionWarNodeInfo)
end

function var_0_0.refresh(arg_8_0)
	local var_8_0 = g_Self.kLegionHandler:getApplyNodeList()

	arg_8_0:confirmCreateView(var_8_0)
	arg_8_0:refreshItems(var_8_0)
end

function var_0_0.confirmCreateView(arg_9_0, arg_9_1)
	if table.getn(arg_9_0.items) == table.getn(arg_9_1) then
		return
	end

	for iter_9_0, iter_9_1 in pairs(arg_9_0.items) do
		iter_9_1:removeFromParentAndCleanup(false)
	end

	arg_9_0.items = {}

	if arg_9_0.tableView ~= nil then
		arg_9_0.tableView:removeFromParentAndCleanup(true)

		arg_9_0.tableView = nil
		arg_9_0.tableViewHelper = nil
	end

	local var_9_0 = table.getn(arg_9_1)
	local var_9_1 = table.getn(arg_9_0.items)
	local var_9_2 = arg_9_0.layerContent:getContentSize()
	local var_9_3 = CCSizeMake(var_9_2.width, var_0_1 * var_9_0)
	local var_9_4 = CCSizeMake(var_9_2.width, var_9_2.height)

	arg_9_0.tableViewHelper = zbTableViewHelper:create()
	arg_9_0.tableView = zbTableViewHelper:createTableView(var_9_3, var_9_4, 1, arg_9_0.tableViewHelper)

	arg_9_0.tableView:setPosition(0, 0)
	arg_9_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_9_0.layerContent:addChild(arg_9_0.tableView)

	if var_9_0 - var_9_1 > 0 then
		local var_9_5 = zbTableViewHelper:create()

		var_9_5:loadCCBFile("ccbi/tb_legionwar_apply.ccbi")

		for iter_9_2 = 1, var_9_0 - var_9_1 do
			local var_9_6 = createLegionWarApplyItem(translateAndStrokeHelper(var_9_5:readCCBNode()))

			var_9_6:retain()

			arg_9_0.items[var_9_1 + iter_9_2] = var_9_6
		end
	end

	local var_9_7 = 1

	for iter_9_3, iter_9_4 in pairs(arg_9_1) do
		local var_9_8 = arg_9_0.items[var_9_7]

		var_9_8:refresh(iter_9_4)
		arg_9_0.tableViewHelper:addCell(var_9_8)

		var_9_7 = var_9_7 + 1
	end

	arg_9_0.tableViewHelper:refreshTabelView()
	arg_9_0.tableViewHelper:setTouchPriority(arg_9_0.btnClose:getTouchPriority())
end

function var_0_0.refreshItems(arg_10_0, arg_10_1)
	local var_10_0 = 1

	for iter_10_0, iter_10_1 in pairs(arg_10_1) do
		arg_10_0.items[var_10_0]:refresh(iter_10_1)

		var_10_0 = var_10_0 + 1
	end
end
