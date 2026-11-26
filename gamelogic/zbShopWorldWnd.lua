require("gamelogic.zbBaseWnd")
require("gamelogic.zbShopItem")

local var_0_0 = class("zbShopWorldWnd", zbBaseWnd)

var_0_0.__index = var_0_0

local var_0_1 = 2
local var_0_2 = 190
local var_0_3 = 220

function var_0_0.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, var_0_0)

	return arg_1_0
end

function createShopWorldWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.lines = {}
		arg_3_0.items = {}
		arg_3_0.tableView = nil
		arg_3_0.tableViewHelper = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/shop_world.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_3_0.layerShoplist = tolua.cast(var_5_2:getChildByTag(1), "CCLayer")
		arg_3_0.lbLabel = tolua.cast(var_5_2:getChildByTag(3), "CCLabelTTF")
		arg_3_0.lbRefreshTimeDummy = tolua.cast(var_5_2:getChildByTag(2), "CCLabelTTF")
		arg_3_0.lbRefreshTime = zbTimeLabel:create(arg_3_0.lbRefreshTimeDummy, "", "")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	g_WsMsgHandler:WS_Shop_GetShopItems_Req()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refresh()
	end, zbGameEvent.Event_Update_Shop)
end

function var_0_0.onFrameUpdate(arg_8_0, arg_8_1)
	if arg_8_0.lbRefreshTime then
		arg_8_0.lbRefreshTime:update()
	end
end

function var_0_0.refresh(arg_9_0)
	arg_9_0:confirmCreateView()

	local var_9_0 = g_Self.kWorldHandler:getWorldShopLessTimeByNodeId()

	arg_9_0.lbRefreshTime:clear()
	arg_9_0.lbRefreshTime:start(var_9_0)
end

function var_0_0.confirmCreateView(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.lines) do
		iter_10_1:removeFromParentAndCleanup(false)
	end

	if arg_10_0.tableView ~= nil then
		arg_10_0.tableView:removeFromParentAndCleanup(true)

		arg_10_0.tableView = nil
		arg_10_0.tableViewHelper = nil
	end

	local var_10_0 = arg_10_0.layerShoplist:getContentSize()

	arg_10_0.tableViewHelper = zbTableViewHelper:create()
	arg_10_0.tableView = zbTableViewHelper:createTableView(var_10_0, var_10_0, kCCScrollViewDirectionHorizontal, arg_10_0.tableViewHelper)

	arg_10_0.tableView:setPosition(0, 0)
	arg_10_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_10_0.tableViewHelper:createListView("ccbi/tb_line.ccbi")
	arg_10_0.layerShoplist:addChild(arg_10_0.tableView)

	local var_10_1 = g_Self.kShopHandler:getShopListByType(EShopType.World)
	local var_10_2 = math.ceil(table.getn(var_10_1) / var_0_1)
	local var_10_3 = table.getn(arg_10_0.lines)

	for iter_10_2 = 1, var_10_3 do
		if iter_10_2 <= var_10_2 then
			local var_10_4 = arg_10_0.lines[iter_10_2]

			arg_10_0.tableViewHelper:addCell(var_10_4)
		end
	end

	if var_10_2 - var_10_3 > 0 then
		for iter_10_3 = 1, var_10_2 - var_10_3 do
			local var_10_5 = arg_10_0.tableViewHelper:addListItem()

			var_10_5:setAnchorPoint(ccp(0, 0))
			var_10_5:setContentSize(CCSizeMake(var_0_2, var_0_3 * var_0_1))

			arg_10_0.lines[var_10_3 + iter_10_3] = var_10_5

			for iter_10_4 = 1, var_0_1 do
				local var_10_6 = zbShopItem:create(arg_10_0)

				var_10_6:setAnchorPoint(ccp(0, 0))
				var_10_6:setPosition(0, (var_0_1 - iter_10_4) * var_0_3)
				var_10_5:addChild(var_10_6)

				arg_10_0.items[(var_10_3 + iter_10_3 - 1) * var_0_1 + iter_10_4] = var_10_6
			end
		end
	end

	local var_10_7 = 1

	for iter_10_5, iter_10_6 in pairs(var_10_1) do
		arg_10_0.items[var_10_7]:refresh(iter_10_6, EShopType.World)

		var_10_7 = var_10_7 + 1
	end

	arg_10_0.tableViewHelper:refreshTabelView()
	arg_10_0.tableViewHelper:setTouchPriority(arg_10_0.btnClose:getTouchPriority())
end
