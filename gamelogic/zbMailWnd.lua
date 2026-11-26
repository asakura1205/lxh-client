require("gamelogic.zbBaseWnd")
require("gamelogic.zbMailItem")

local var_0_0 = class("zbMailWnd", zbBaseWnd)

var_0_0.__index = var_0_0

local var_0_1 = 105

function createMailWnd()
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
		arg_3_0.scrollBar = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/maillist.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.layerTouchTest = var_5_2

		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCLayer")

		arg_3_0.layerContent = tolua.cast(var_5_3:getChildByTag(1), "CCLayer")
		arg_3_0.scrollNode = tolua.cast(var_5_3:getChildByTag(401), "CCNode")
		arg_3_0.btnGetAll = tolua.cast(var_5_2:getChildByTag(2), "CCControlButton")
		arg_3_0.txtlbMailCount = tolua.cast(var_5_2:getChildByTag(3), "CCLabelTTF")
		arg_3_0.lbNoMail = tolua.cast(var_5_2:getChildByTag(1006), "CCLabelTTF")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")
		arg_3_0.lbMailCount = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.txtlbMailCount, arg_3_0.lbMailCount)
		arg_3_0.lbMailCount:setScale(0.65)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnGetAll:addHandleOfControlEvent(function()
			arg_3_0:getAllMail()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_HideAll)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:createView()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refresh()
	end, zbGameEvent.Event_Update_MailList)
end

function var_0_0.createView(arg_10_0)
	local var_10_0 = arg_10_0.layerContent:getContentSize()
	local var_10_1 = CCSizeMake(var_10_0.width, var_10_0.height)

	arg_10_0.tableViewHelper = zbTableViewHelper:create()
	arg_10_0.tableView = zbTableViewHelper:createTableView(var_10_1, var_10_1, 1, arg_10_0.tableViewHelper)

	arg_10_0.tableView:setPosition(0, 0)
	arg_10_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_10_0.layerContent:addChild(arg_10_0.tableView)
	arg_10_0.tableViewHelper:refreshTabelView()

	arg_10_0.scrollBar = ui:createScrollBarView(arg_10_0.tableView, arg_10_0.scrollNode, var_10_0.height)

	arg_10_0.tableViewHelper:setTouchPriority(arg_10_0.btnClose:getTouchPriority())
end

function var_0_0.getAllMail(arg_11_0)
	if g_Self.kMailHandler:hasAward() then
		g_WsMsgHandler:WS_Mail_GetAllAward_Req()
	else
		g_Bubble:bubbleInfo("已领取所有奖励邮件")
	end
end

function var_0_0.refresh(arg_12_0)
	arg_12_0:refreshItems()
end

function var_0_0.refreshItems(arg_13_0)
	local var_13_0 = arg_13_0:getMailList()
	local var_13_1 = arg_13_0.tableViewHelper:getCellNum() ~= table.getn(var_13_0)

	if var_13_1 then
		arg_13_0.tableViewHelper:removeAllCells()
	end

	local var_13_2 = table.getn(var_13_0)
	local var_13_3 = table.getn(arg_13_0.items)

	if var_13_2 - var_13_3 > 0 then
		for iter_13_0 = 1, var_13_2 - var_13_3 do
			local var_13_4 = zbTableViewHelper:create()

			var_13_4:loadCCBFile("ccbi/mail_list_item.ccbi")

			local var_13_5 = createMailItem(arg_13_0, translateAndStrokeHelper(var_13_4:readCCBNode()), arg_13_0)

			var_13_5:retain()

			arg_13_0.items[var_13_3 + iter_13_0] = var_13_5

			var_13_4:releaseSelf()
		end
	end

	arg_13_0.lbNoMail:setVisible(var_13_2 == 0)
	arg_13_0.lbMailCount:setString(g_Self.kMailHandler:getUnReadCount() .. "/" .. var_13_2)

	local var_13_6 = 1

	for iter_13_1, iter_13_2 in pairs(var_13_0) do
		local var_13_7 = arg_13_0.items[var_13_6]

		var_13_7:refresh(iter_13_2)

		var_13_6 = var_13_6 + 1

		if var_13_1 then
			arg_13_0.tableViewHelper:addCell(var_13_7)
		end
	end

	if var_13_1 then
		arg_13_0.tableViewHelper:refreshTabelView()
		arg_13_0.tableViewHelper:setTouchPriority(arg_13_0.btnClose:getTouchPriority())
	end
end

function var_0_0.onFrameUpdate(arg_14_0, arg_14_1)
	if arg_14_0.scrollBar then
		arg_14_0.scrollBar:update()
	end
end

function var_0_0.getMailList(arg_15_0)
	local var_15_0 = g_Self.kMailHandler.MailList

	local function var_15_1(arg_16_0, arg_16_1)
		local var_16_0 = table.getn(arg_16_0.AwardList) > 0 and arg_16_0.AwardState == 0 or table.getn(arg_16_0.AwardList) <= 0 and arg_16_0.ReadState == 0
		local var_16_1 = table.getn(arg_16_1.AwardList) > 0 and arg_16_1.AwardState == 0 or table.getn(arg_16_1.AwardList) <= 0 and arg_16_1.ReadState == 0

		if var_16_0 == true and var_16_1 == false then
			return true
		elseif var_16_0 == false and var_16_1 == true then
			return false
		else
			return arg_16_0.MailId > arg_16_1.MailId
		end
	end

	table.sort(var_15_0, var_15_1)

	return var_15_0
end

function var_0_0.onTouchTest(arg_17_0)
	local var_17_0 = arg_17_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_17_0.layerTouchTest, var_17_0.x, var_17_0.y) == false and zbUtil:PointInCtrl(arg_17_0.btnClose, var_17_0.x, var_17_0.y) == false then
		arg_17_0:hide()
	end
end
