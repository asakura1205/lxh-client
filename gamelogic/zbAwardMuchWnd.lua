require("gamelogic.zbItem")

local var_0_0 = class("zbAwardMuchWnd", zbBaseWnd)

var_0_0.__index = var_0_0

local var_0_1 = 5
local var_0_2 = 140
local var_0_3 = 100

function createAwardMuchWnd()
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
		arg_3_0.lines = {}
		arg_3_0.items = {}
		arg_3_0.tableView = nil
		arg_3_0.tableViewHelper = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/awardmuchshow.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.testLayer = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.layerContent = tolua.cast(var_5_2:getChildByTag(1), "CCLayer")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark_NoHide)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setZOrder(ZORDER_TOP)
end

function var_0_0.refresh(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.lines) do
		iter_8_1:removeFromParentAndCleanup(false)
	end

	arg_8_0.items = {}
	arg_8_0.lines = {}

	if arg_8_0.tableView ~= nil then
		arg_8_0.tableView:removeFromParentAndCleanup(true)

		arg_8_0.tableView = nil
		arg_8_0.tableViewHelper = nil
	end

	local var_8_0 = arg_8_0.layerContent:getContentSize()

	arg_8_0.tableViewHelper = zbTableViewHelper:create()
	arg_8_0.tableView = zbTableViewHelper:createTableView(var_8_0, var_8_0, 1, arg_8_0.tableViewHelper)

	arg_8_0.tableView:setPosition(0, 0)
	arg_8_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_8_0.tableViewHelper:createListView("ccbi/tb_line.ccbi")
	arg_8_0.layerContent:addChild(arg_8_0.tableView)

	local var_8_1 = math.ceil(table.getn(arg_8_1) / var_0_1)
	local var_8_2 = table.getn(arg_8_0.lines)

	for iter_8_2 = 1, var_8_2 do
		if iter_8_2 <= var_8_1 then
			local var_8_3 = arg_8_0.lines[iter_8_2]

			arg_8_0.tableViewHelper:addCell(var_8_3)
		end
	end

	if var_8_1 - var_8_2 > 0 then
		for iter_8_3 = 1, var_8_1 - var_8_2 do
			local var_8_4 = arg_8_0.tableViewHelper:addListItem()

			var_8_4:setAnchorPoint(ccp(0, 0))
			var_8_4:setScale(0.8)
			var_8_4:setContentSize(CCSizeMake(var_0_2 * var_0_1, var_0_3))

			arg_8_0.lines[var_8_2 + iter_8_3] = var_8_4

			for iter_8_4 = 1, var_0_1 do
				local var_8_5 = createItem()

				var_8_5:setAnchorPoint(ccp(0, 0))
				var_8_5:setPosition((iter_8_4 - 1) * var_0_2 + 20, 0)
				var_8_5:setSwallowsTouches(false)
				var_8_5:setSupportTouchDownTip(false)
				var_8_5:setSupportTouchTip(true)
				var_8_4:addChild(var_8_5)

				arg_8_0.items[(var_8_2 + iter_8_3 - 1) * var_0_1 + iter_8_4] = var_8_5
			end
		end
	end

	local var_8_6 = 1

	for iter_8_5, iter_8_6 in pairs(arg_8_1) do
		arg_8_0.items[var_8_6]:refreshAward(iter_8_6.awardType, iter_8_6.awardId, iter_8_6.awardCount, false)

		var_8_6 = var_8_6 + 1
	end

	local var_8_7 = table.getn(arg_8_0.items)

	for iter_8_7 = var_8_6, var_8_7 do
		arg_8_0.items[iter_8_7]:setVisible(false)
	end

	arg_8_0.tableViewHelper:refreshTabelView()
	arg_8_0.tableViewHelper:setTouchPriority(arg_8_0.btnClose:getTouchPriority())
end

function var_0_0.onTouchTest(arg_9_0)
	local var_9_0 = arg_9_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_9_0.testLayer, var_9_0.x, var_9_0.y) == false and zbUtil:PointInCtrl(arg_9_0.btnClose, var_9_0.x, var_9_0.y) == false then
		arg_9_0:hide()
	end
end
