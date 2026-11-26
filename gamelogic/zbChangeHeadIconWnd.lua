require("gamelogic.zbChangeHeadIconItem")

local var_0_0 = class("zbChangeHeadIconWnd", zbBaseWnd)

var_0_0.__index = var_0_0

local var_0_1 = 4
local var_0_2 = 130
local var_0_3 = 130

function var_0_0.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, var_0_0)

	return arg_1_0
end

function createChangHeadIconWnd()
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
		local var_5_1 = CCBReaderLoad("ccbi/head_icon.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(100), "CCLayer")

		arg_3_0.testLayer = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.lbDesc = tolua.cast(var_5_2:getChildByTag(1001), "CCLabelTTF")
		arg_3_0.layerHead = tolua.cast(var_5_2:getChildByTag(2), "CCLayer")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_8_0)
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

	local var_8_0 = arg_8_0.layerHead:getContentSize()

	arg_8_0.tableViewHelper = zbTableViewHelper:create()
	arg_8_0.tableView = zbTableViewHelper:createTableView(var_8_0, var_8_0, 1, arg_8_0.tableViewHelper)

	arg_8_0.tableView:setPosition(0, 0)
	arg_8_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_8_0.tableViewHelper:createListView("ccbi/tb_line.ccbi")
	arg_8_0.layerHead:addChild(arg_8_0.tableView)

	local var_8_1 = arg_8_0:getSortedHerosByType()
	local var_8_2 = math.ceil(table.getn(var_8_1) / var_0_1)
	local var_8_3 = table.getn(arg_8_0.lines)

	for iter_8_2 = 1, var_8_3 do
		if iter_8_2 <= var_8_2 then
			local var_8_4 = arg_8_0.lines[iter_8_2]

			arg_8_0.tableViewHelper:addCell(var_8_4)
		end
	end

	if var_8_2 - var_8_3 > 0 then
		for iter_8_3 = 1, var_8_2 - var_8_3 do
			local var_8_5 = arg_8_0.tableViewHelper:addListItem()

			var_8_5:setAnchorPoint(ccp(0, 0))
			var_8_5:setScale(0.9)
			var_8_5:setContentSize(CCSizeMake(var_0_2 * var_0_1, var_0_3))

			arg_8_0.lines[var_8_3 + iter_8_3] = var_8_5

			for iter_8_4 = 1, var_0_1 do
				local var_8_6 = zbTableViewHelper:create()

				var_8_6:loadCCBFile("ccbi/tb_head_icon.ccbi")

				local var_8_7 = zbChangeHeadIconItem:create(translateAndStrokeHelper(var_8_6:readCCBNode()))

				var_8_7:setAnchorPoint(ccp(0, 0))
				var_8_7:setPosition((iter_8_4 - 1) * var_0_2 + 20, 0)
				var_8_5:addChild(var_8_7)

				arg_8_0.items[(var_8_3 + iter_8_3 - 1) * var_0_1 + iter_8_4] = var_8_7

				var_8_6:releaseSelf()
			end
		end
	end

	for iter_8_5, iter_8_6 in pairs(arg_8_0.items) do
		iter_8_6:setVisible(false)
	end

	local var_8_8 = 1

	for iter_8_7, iter_8_8 in pairs(var_8_1) do
		arg_8_0.items[var_8_8]:refresh(iter_8_8.HeroBaseInfo)

		var_8_8 = var_8_8 + 1
	end

	arg_8_0.tableViewHelper:refreshTabelView()
	arg_8_0.tableViewHelper:setTouchPriority(arg_8_0.btnClose:getTouchPriority())
end

function var_0_0.getSortedHerosByType(arg_9_0)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(g_GameData.HeroList) do
		table.insert(var_9_0, iter_9_1)
	end

	local function var_9_1(arg_10_0, arg_10_1)
		if arg_10_0.HeroBaseInfo.Star == arg_10_1.HeroBaseInfo.Star then
			return arg_10_0.HeroBaseInfo.Quality > arg_10_1.HeroBaseInfo.Quality
		end

		return arg_10_0.HeroBaseInfo.Star > arg_10_1.HeroBaseInfo.Star
	end

	table.sort(var_9_0, var_9_1)

	return var_9_0
end

function var_0_0.onTouchTest(arg_11_0)
	local var_11_0 = arg_11_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_11_0.testLayer, var_11_0.x, var_11_0.y) == false and zbUtil:PointInCtrl(arg_11_0.btnClose, var_11_0.x, var_11_0.y) == false then
		arg_11_0:hide()
	end
end
