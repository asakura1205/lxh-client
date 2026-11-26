require("gamelogic.zbFormationItem")

local var_0_0 = class("zbFormationListPanel")

var_0_0.__index = var_0_0

function createFormationListPanel(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	local function var_2_0()
		arg_2_0.showFlag = false
		arg_2_0.wndParent = arg_2_2
		arg_2_0.lines = {}
		arg_2_0.items = {}
		arg_2_0.tableview = nil
		arg_2_0.tableviewHelper = nil
		arg_2_0.sortedFormationRecords = {}
	end

	local function var_2_1(arg_4_0)
		local var_4_0 = arg_4_0:getContentSize()

		arg_2_0.tableviewHelper = zbTableViewHelper:create()

		local var_4_1 = zbTableViewHelper:createTableView(var_4_0, var_4_0, kCCScrollViewDirectionVertical, arg_2_0.tableviewHelper)

		var_4_1:setPosition(0, 0)
		var_4_1:setAnchorPoint(ccp(0, 0))
		arg_2_0.tableviewHelper:createListView("ccbi/tb_line.ccbi")
		arg_4_0:addChild(var_4_1)

		for iter_4_0 = 1, 4 do
			local var_4_2 = arg_2_0.tableviewHelper:addListItem()

			var_4_2:setAnchorPoint(ccp(0, 0))
			var_4_2:setContentSize(CCSizeMake(240, 80))
			table.insert(arg_2_0.lines, var_4_2)

			for iter_4_1 = 1, 2 do
				local var_4_3 = zbTableViewHelper:create()

				var_4_3:loadCCBFile("ccbi/tb_formation2.ccbi")

				local var_4_4 = zbFormationItem:create(translateAndStrokeHelper(var_4_3:readCCBNode()), arg_2_0.wndParent)

				var_4_4:setAnchorPoint(ccp(0, 0))
				var_4_4:setPosition((iter_4_1 - 1) * 120 + 20, 0)
				var_4_2:addChild(var_4_4)
				table.insert(arg_2_0.items, var_4_4)
				var_4_4:setVisible(false)
				var_4_3:releaseSelf()
			end
		end

		arg_2_0.tableviewHelper:refreshTabelView()
	end

	local function var_2_2()
		arg_2_0.layerList = tolua.cast(arg_2_1:getChildByTag(1), "CCNode")
		arg_2_0.btnTouch = tolua.cast(arg_2_1:getChildByTag(2), "CCControlButton")
		arg_2_0.spriteBg = tolua.cast(arg_2_1:getChildByTag(99), "CCSprite")

		arg_2_0.btnTouch:addHandleOfControlEvent(function()
			arg_2_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_2_0.layerList:setVisible(false)
		arg_2_0.spriteBg:setVisible(false)

		arg_2_0.btnTouchTest = tolua.cast(arg_2_0.layerList:getChildByTag(0), "CCControlButton")

		arg_2_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_2_0:onTouchTest()
		end, CCControlEventTouchUpInside)
		var_2_1(arg_2_0.layerList)
	end

	var_2_0()
	var_2_2()
end

function var_0_0.onTouchTest(arg_8_0)
	local var_8_0 = arg_8_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_8_0.layerList, var_8_0.x, var_8_0.y) == false then
		arg_8_0.layerList:setVisible(false)
		arg_8_0.spriteBg:setVisible(false)
	end
end

function var_0_0.refresh(arg_9_0)
	arg_9_0.btnTouch:setVisible(g_Self:getLevel() >= 15)

	arg_9_0.sortedFormationRecords = g_Self.kTechHandler:sortFormationList()

	local var_9_0 = table.getn(arg_9_0.sortedFormationRecords)
	local var_9_1 = 1

	for iter_9_0, iter_9_1 in pairs(arg_9_0.sortedFormationRecords) do
		local var_9_2 = arg_9_0.items[var_9_1]

		if var_9_2 ~= nil then
			var_9_2:refresh(iter_9_1)
			var_9_2:setVisible(true)
		end

		var_9_1 = var_9_1 + 1
	end
end

function var_0_0.onTouch(arg_10_0)
	arg_10_0.showFlag = not arg_10_0.showFlag

	arg_10_0.layerList:setVisible(arg_10_0.showFlag)
	arg_10_0.spriteBg:setVisible(arg_10_0.showFlag)
end
