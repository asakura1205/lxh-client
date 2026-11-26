require("gamelogic.zbItem")

local var_0_0 = class("zbBoxPreViewWnd", zbBaseWnd)

var_0_0.__index = var_0_0

local var_0_1 = 6
local var_0_2 = 125
local var_0_3 = 120

function var_0_0.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, var_0_0)

	return arg_1_0
end

function createBoxPreView()
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
		local var_5_1 = CCBReaderLoad("ccbi/boxpreview.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.testLayer = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.layerFrag = tolua.cast(var_5_2:getChildByTag(1), "CCLayer")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setHideCallback(function()
		arg_3_0:onHideCallback()
	end)
end

function var_0_0.onHideCallback(arg_9_0)
	g_MainScene:hideCommonTip()
end

function var_0_0.refresh(arg_10_0, arg_10_1)
	if not zbUtil:isValidTable(arg_10_1) then
		return
	end

	arg_10_0.contains = arg_10_1

	for iter_10_0, iter_10_1 in pairs(arg_10_0.lines) do
		iter_10_1:removeFromParentAndCleanup(false)
	end

	arg_10_0.items = {}
	arg_10_0.lines = {}

	if arg_10_0.tableView ~= nil then
		arg_10_0.tableView:removeFromParentAndCleanup(true)

		arg_10_0.tableView = nil
		arg_10_0.tableViewHelper = nil
	end

	local var_10_0 = arg_10_0.layerFrag:getContentSize()

	arg_10_0.tableViewHelper = zbTableViewHelper:create()
	arg_10_0.tableView = zbTableViewHelper:createTableView(var_10_0, var_10_0, 1, arg_10_0.tableViewHelper)

	arg_10_0.tableView:setPosition(0, 0)
	arg_10_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_10_0.tableViewHelper:createListView("ccbi/tb_line.ccbi")
	arg_10_0.layerFrag:addChild(arg_10_0.tableView)

	local var_10_1, var_10_2 = arg_10_0:getPreItem()
	local var_10_3 = math.ceil((table.getn(var_10_1) + table.getn(var_10_2)) / var_0_1)
	local var_10_4 = table.getn(arg_10_0.lines)

	for iter_10_2 = 1, var_10_4 do
		if iter_10_2 <= var_10_3 then
			local var_10_5 = arg_10_0.lines[iter_10_2]

			arg_10_0.tableViewHelper:addCell(var_10_5)
		end
	end

	if var_10_3 - var_10_4 > 0 then
		for iter_10_3 = 1, var_10_3 - var_10_4 do
			local var_10_6 = arg_10_0.tableViewHelper:addListItem()

			var_10_6:setAnchorPoint(ccp(0, 0))
			var_10_6:setScale(0.85)
			var_10_6:setContentSize(CCSizeMake(var_0_2 * var_0_1, var_0_3))

			arg_10_0.lines[var_10_4 + iter_10_3] = var_10_6

			for iter_10_4 = 1, var_0_1 do
				local var_10_7 = createItem()

				var_10_7:setAnchorPoint(ccp(0, 0))
				var_10_7:setPosition((iter_10_4 - 1) * var_0_2, 20)
				var_10_7:setSwallowsTouches(false)
				var_10_7:setSupportTouchDownTip(false)
				var_10_7:setSupportTouchTip(true)
				var_10_6:addChild(var_10_7)

				arg_10_0.items[(var_10_4 + iter_10_3 - 1) * var_0_1 + iter_10_4] = var_10_7
			end
		end
	end

	local var_10_8 = 1

	for iter_10_5, iter_10_6 in pairs(var_10_1) do
		arg_10_0.items[var_10_8]:refreshAward(iter_10_6.AwardType, iter_10_6.AwardId, iter_10_6.AwardCount)

		var_10_8 = var_10_8 + 1
	end

	for iter_10_7, iter_10_8 in pairs(var_10_2) do
		arg_10_0.items[var_10_8]:refreshAward(iter_10_8.AwardType, iter_10_8.AwardId, iter_10_8.AwardCount)

		var_10_8 = var_10_8 + 1
	end

	local var_10_9 = table.getn(arg_10_0.items)

	for iter_10_9 = var_10_8, var_10_9 do
		arg_10_0.items[iter_10_9]:setVisible(false)
	end

	arg_10_0.tableViewHelper:refreshTabelView()
	arg_10_0.tableViewHelper:setTouchPriority(arg_10_0.btnClose:getTouchPriority())
end

function var_0_0.getPreItem(arg_11_0)
	local var_11_0 = {}
	local var_11_1 = {}
	local var_11_2 = 1
	local var_11_3 = 1

	for iter_11_0, iter_11_1 in pairs(arg_11_0.contains) do
		local var_11_4 = zbItemBoxTable:getRecord(iter_11_1.itemId)

		if var_11_4 ~= nil then
			for iter_11_2, iter_11_3 in ipairs(var_11_4) do
				if iter_11_3.bPreview == 1 then
					if iter_11_3.awardType == ECommonAwardType.Hero or iter_11_3.awardType == ECommonAwardType.HeroFrag then
						var_11_0[var_11_2] = {
							AwardType = iter_11_3.awardType,
							AwardId = iter_11_3.templateId,
							AwardCount = iter_11_3.count
						}
						var_11_2 = var_11_2 + 1
					else
						var_11_1[var_11_3] = {
							AwardType = iter_11_3.awardType,
							AwardId = iter_11_3.templateId,
							AwardCount = iter_11_3.count
						}
						var_11_3 = var_11_3 + 1
					end
				end
			end
		end
	end

	return var_11_0, var_11_1
end

function var_0_0.onTouchTest(arg_12_0)
	local var_12_0 = arg_12_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_12_0.testLayer, var_12_0.x, var_12_0.y) == false and zbUtil:PointInCtrl(arg_12_0.btnClose, var_12_0.x, var_12_0.y) == false then
		arg_12_0:hide()
	end
end
