require("gamelogic.zbTaskWnd_DailyItem")

local var_0_0 = class("zbTaskWnd_Daily")

var_0_0.__index = var_0_0
TaskItem_Height = 142

function createTaskDaily(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local function var_2_0()
		arg_2_0.btnPriority = arg_2_2
		arg_2_0.parentWnd = arg_2_3
		arg_2_0.items = {}
		arg_2_0.giftItems = {}
		arg_2_0.effectAward = {}
		arg_2_0.lbActDes = {}
		arg_2_0.lbMoney = {}
		arg_2_0.btnAward = {}
		arg_2_0.spriteGetten = {}
		arg_2_0.scrollBar = nil
		arg_2_0.dailyTask = nil
	end

	local function var_2_1()
		local function var_4_0(arg_5_0)
			local var_5_0 = createUIAnimation()

			var_5_0:refresh("effect/spine/ui_tubiaokuang_03/ui_tubiaokuang_03.json", "effect/spine/ui_tubiaokuang_03/ui_tubiaokuang_03.atlas")
			var_5_0:setAnimation("animation", true, 0.5)
			var_5_0:setAnchorPoint(ccp(0, 0))
			var_5_0:setPosition(0, 0)
			arg_5_0:addChild(var_5_0)
		end

		for iter_4_0 = 1, 4 do
			arg_2_0.giftItems[iter_4_0] = tolua.cast(arg_2_1:getChildByTag(iter_4_0), "CCNode")

			local var_4_1 = tolua.cast(arg_2_0.giftItems[iter_4_0]:getChildByTag(1001), "CCLabelTTF")

			arg_2_0.lbActDes[iter_4_0] = tolua.cast(arg_2_0.giftItems[iter_4_0]:getChildByTag(2), "CCLabelTTF")
			arg_2_0.btnAward[iter_4_0] = tolua.cast(arg_2_0.giftItems[iter_4_0]:getChildByTag(3), "CCControlButton")
			arg_2_0.spriteGetten[iter_4_0] = tolua.cast(arg_2_0.giftItems[iter_4_0]:getChildByTag(5), "CCSprite")

			arg_2_0.btnAward[iter_4_0]:addHandleOfControlEvent(function()
				arg_2_0:onAward(iter_4_0)
			end, CCControlEventTouchUpInside)

			arg_2_0.effectAward[iter_4_0] = tolua.cast(arg_2_0.giftItems[iter_4_0]:getChildByTag(4), "CCNode")

			var_4_0(arg_2_0.effectAward[iter_4_0])

			arg_2_0.lbMoney[iter_4_0] = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

			require("gamebase.zbUI"):replaceCtrl(var_4_1, arg_2_0.lbMoney[iter_4_0])
			arg_2_0.lbMoney[iter_4_0]:setScale(0.6)
			arg_2_0.lbMoney[iter_4_0]:setZOrder(ZORDER_BOTTOM)
		end

		local var_4_2 = tolua.cast(arg_2_1:getChildByTag(5), "CCLabelTTF")

		arg_2_0.lbActAll = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_4_2, arg_2_0.lbActAll)
		arg_2_0.lbActAll:setScale(0.8)

		local var_4_3 = tolua.cast(arg_2_1:getChildByTag(6), "CCLayer")

		arg_2_0.layerContent = tolua.cast(var_4_3:getChildByTag(1), "CCLayer")
		arg_2_0.scrollNode = tolua.cast(var_4_3:getChildByTag(401), "CCNode")
	end

	var_2_0()
	var_2_1()
end

function var_0_0.refresh(arg_7_0)
	arg_7_0.dailyTask = g_GameData.DailyTask

	if arg_7_0.dailyTask == nil then
		return
	end

	local var_7_0 = arg_7_0:getResultList()

	arg_7_0:confirmCreateView(var_7_0)
	arg_7_0:refreshItems()
	arg_7_0:refreshGift()
	arg_7_0.lbActAll:setString(arg_7_0.dailyTask.ActiveCount)
end

function var_0_0.confirmCreateView(arg_8_0, arg_8_1)
	if table.getn(arg_8_0.items) == table.getn(arg_8_1) then
		return
	end

	for iter_8_0, iter_8_1 in pairs(arg_8_0.items) do
		iter_8_1:removeFromParentAndCleanup(false)
	end

	arg_8_0.items = {}

	if arg_8_0.tableView ~= nil then
		arg_8_0.tableView:removeFromParentAndCleanup(true)

		arg_8_0.tableView = nil
		arg_8_0.tableViewHelper = nil
	end

	local var_8_0 = table.getn(arg_8_1)
	local var_8_1 = table.getn(arg_8_0.items)
	local var_8_2 = arg_8_0.layerContent:getContentSize()
	local var_8_3 = CCSizeMake(var_8_2.width, TaskItem_Height * var_8_0)
	local var_8_4 = CCSizeMake(var_8_2.width, var_8_2.height)

	arg_8_0.tableViewHelper = zbTableViewHelper:create()
	arg_8_0.tableView = zbTableViewHelper:createTableView(var_8_3, var_8_4, 1, arg_8_0.tableViewHelper)

	arg_8_0.tableView:setPosition(0, 0)
	arg_8_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_8_0.layerContent:addChild(arg_8_0.tableView)

	if var_8_0 - var_8_1 > 0 then
		for iter_8_2 = 1, var_8_0 - var_8_1 do
			local var_8_5 = createTaskDailyItem(arg_8_0.parentWnd)

			var_8_5:retain()

			arg_8_0.items[var_8_1 + iter_8_2] = var_8_5
		end
	end

	local var_8_6 = 1

	for iter_8_3, iter_8_4 in pairs(arg_8_1) do
		local var_8_7 = arg_8_0.items[var_8_6]

		var_8_7:refresh(iter_8_4)
		arg_8_0.tableViewHelper:addCell(var_8_7)

		var_8_6 = var_8_6 + 1
	end

	arg_8_0.tableViewHelper:refreshTabelView()

	arg_8_0.scrollBar = ui:createScrollBarView(arg_8_0.tableView, arg_8_0.scrollNode, var_8_2.height)

	arg_8_0.tableViewHelper:setTouchPriority(arg_8_0.btnPriority:getTouchPriority())
end

function var_0_0.getResultList(arg_9_0)
	local var_9_0 = arg_9_0.dailyTask.TaskList

	local function var_9_1(arg_10_0, arg_10_1)
		local var_10_0 = arg_10_0.State ~= 2
		local var_10_1 = arg_10_1.State ~= 2

		if var_10_0 and var_10_1 then
			return arg_10_0.State > arg_10_1.State
		elseif var_10_0 == true and var_10_1 == false then
			return true
		elseif var_10_0 == false and var_10_1 == true then
			return false
		else
			return arg_10_0.State > arg_10_1.State
		end
	end

	table.sort(var_9_0, var_9_1)

	return var_9_0
end

function var_0_0.refreshItems(arg_11_0)
	local var_11_0 = 1

	for iter_11_0, iter_11_1 in pairs(arg_11_0.dailyTask.TaskList) do
		arg_11_0.items[var_11_0]:refresh(iter_11_1)

		var_11_0 = var_11_0 + 1
	end
end

function var_0_0.refreshGift(arg_12_0)
	local var_12_0 = 1

	for iter_12_0, iter_12_1 in pairs(arg_12_0.dailyTask.AwardList) do
		if var_12_0 > 4 then
			break
		end

		arg_12_0.lbMoney[var_12_0]:setString(iter_12_1.AwardList[1].Count)
		arg_12_0.lbActDes[var_12_0]:setString(a2u("\xBB\xEEԾ\xB6\xC8") .. iter_12_1.Active)
		arg_12_0.spriteGetten[var_12_0]:setVisible(iter_12_1.State == 2)
		arg_12_0.effectAward[var_12_0]:setVisible(iter_12_1.State == 1)

		var_12_0 = var_12_0 + 1
	end
end

function var_0_0.onAward(arg_13_0, arg_13_1)
	if arg_13_0.dailyTask.AwardList[arg_13_1].State == 2 then
		g_Bubble:bubbleInfo("\xBD\xB1\xC0\xF8\xD2\xD1\xC1\xECȡ")

		return
	end

	if arg_13_0.dailyTask.AwardList[arg_13_1].Active > arg_13_0.dailyTask.ActiveCount then
		g_Bubble:bubbleInfo("\xBB\xEEԾ\xB6Ȳ\xBB\xD7\xE3")

		return
	end

	g_WsMsgHandler:WS_DailyTask_Award_Req(arg_13_0.dailyTask.AwardList[arg_13_1].Active)
end

function var_0_0.onFrame(arg_14_0)
	if arg_14_0.scrollBar then
		arg_14_0.scrollBar:update()
	end
end
