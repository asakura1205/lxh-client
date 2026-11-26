require("gamelogic.zbBaseWnd")
require("gamelogic.zbLegionIconitem")

local var_0_0 = class("zbLegionIconSelWnd", zbBaseWnd)

var_0_0.__index = var_0_0

local var_0_1 = 4
local var_0_2 = 120
local var_0_3 = 120

function createLegionIconSelWnd()
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

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.lines = {}
		arg_3_0.items = {}
		arg_3_0.data = arg_3_1
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/iconselwnd.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1, "CCNode")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCLayer")

		arg_3_0.layerTouchTest = var_5_3
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.btnClose = tolua.cast(var_5_3:getChildByTag(2), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)

		arg_3_0.sptitle = tolua.cast(var_5_3:getChildByTag(1), "CCSprite")
		arg_3_0.layer = tolua.cast(var_5_3:getChildByTag(3), "CCLayer")

		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_8_0)
	local var_8_0 = g_DataConfig.m_kLegionBaseCfg.legionhead
	local var_8_1 = arg_8_0.layer:getContentSize()

	arg_8_0.tableViewHelper = zbTableViewHelper:create()
	arg_8_0.tableView = zbTableViewHelper:createTableView(var_8_1, var_8_1, kCCScrollViewDirectionVertical, arg_8_0.tableViewHelper)

	arg_8_0.tableView:setPosition(10, 0)
	arg_8_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_8_0.tableViewHelper:createListView("ccbi/tb_line.ccbi")
	arg_8_0.layer:addChild(arg_8_0.tableView)

	local var_8_2 = table.getn(var_8_0)
	local var_8_3 = math.ceil(var_8_2 / var_0_1)
	local var_8_4 = zbTableViewHelper:create()

	var_8_4:loadCCBFile("ccbi/tb_iconitem.ccbi")

	for iter_8_0 = 1, var_8_3 do
		local var_8_5 = arg_8_0.tableViewHelper:addListItem()

		var_8_5:setAnchorPoint(ccp(0, 0))
		var_8_5:setContentSize(CCSizeMake(var_0_2 * var_0_1, var_0_3))

		arg_8_0.lines[iter_8_0] = var_8_5

		for iter_8_1 = 1, var_0_1 do
			local var_8_6 = createLegionIconItem(translateAndStrokeHelper(var_8_4:readCCBNode()))

			var_8_6:setAnchorPoint(ccp(0, 0))
			var_8_6:setPosition((iter_8_1 - 1) * var_0_2, 0)
			var_8_5:addChild(var_8_6)

			arg_8_0.items[(iter_8_0 - 1) * var_0_1 + iter_8_1] = var_8_6
		end
	end

	local var_8_7 = 1

	for iter_8_2, iter_8_3 in pairs(var_8_0) do
		arg_8_0.items[var_8_7]:refresh(iter_8_3)

		var_8_7 = var_8_7 + 1
	end

	arg_8_0.tableViewHelper:refreshTabelView()
	arg_8_0.tableViewHelper:setTouchPriority(arg_8_0.btnClose:getTouchPriority())
end

function var_0_0.onTouchTest(arg_9_0)
	local var_9_0 = arg_9_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_9_0.layerTouchTest, var_9_0.x, var_9_0.y) == false and zbUtil:PointInCtrl(arg_9_0.btnClose, var_9_0.x, var_9_0.y) == false then
		arg_9_0:hide()
	end
end
