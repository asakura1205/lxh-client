require("gamelogic.zbFriendItem")

local var_0_0 = class("zbFriendList")

var_0_0.__index = var_0_0

local var_0_1 = 100

function createFriendList(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	local function var_2_0()
		arg_2_0.btnPri = arg_2_2
		arg_2_0.items = {}
		arg_2_0.tableView = nil
		arg_2_0.tableViewHelper = nil
	end

	local function var_2_1()
		arg_2_0.nodehave = tolua.cast(arg_2_1:getChildByTag(1), "CCNode")
		arg_2_0.layer = tolua.cast(arg_2_0.nodehave:getChildByTag(3), "CCLayer")
		arg_2_0.lblnum = tolua.cast(arg_2_0.nodehave:getChildByTag(2), "CCLabelTTF")
		arg_2_0.lbldelnum = tolua.cast(arg_2_0.nodehave:getChildByTag(4), "CCLabelTTF")
		arg_2_0.lbltili = tolua.cast(arg_2_0.nodehave:getChildByTag(7), "CCLabelTTF")

		local var_4_0 = tolua.cast(arg_2_0.nodehave:getChildByTag(1), "CCNode")

		arg_2_0.btnGiveAll = tolua.cast(var_4_0:getChildByTag(1), "CCControlButton")
		arg_2_0.btnGetAll = tolua.cast(var_4_0:getChildByTag(2), "CCControlButton")

		arg_2_0.btnGetAll:addHandleOfControlEvent(function()
			arg_2_0:onGetTiliAll()
		end, CCControlEventTouchUpInside)
		arg_2_0.btnGiveAll:addHandleOfControlEvent(function()
			arg_2_0:onGiveTiliAll()
		end, CCControlEventTouchUpInside)

		arg_2_0.nodeNone = tolua.cast(arg_2_1:getChildByTag(2), "CCNode")
	end

	var_2_0()
	var_2_1()
end

function var_0_0.onFrame(arg_7_0)
	return
end

function var_0_0.onGetTiliAll(arg_8_0)
	g_WsMsgHandler:WS_Friends_GetTiliAll_Req()
end

function var_0_0.onGiveTiliAll(arg_9_0)
	g_WsMsgHandler:WS_Friends_GiveTiliAll_Req()
end

function var_0_0.refresh(arg_10_0)
	local var_10_0 = {}

	if zbUtil:isValidTable(g_Self.kFriendHandler.frienddata) then
		var_10_0 = g_Self.kFriendHandler.frienddata.FriendsList
	end

	if g_Self.kFriendHandler.frienddata and g_Self.kFriendHandler.frienddata.FriendsBaseInfo then
		local var_10_1 = g_Self.kFriendHandler.frienddata.FriendsBaseInfo.DelCount

		arg_10_0.lbldelnum:setString(var_10_1 .. "/3")

		local var_10_2 = g_Self.kFriendHandler.frienddata.FriendsBaseInfo.TiliCount
		local var_10_3 = g_Self.kFriendHandler.frienddata.FriendsBaseInfo.TiliMax

		arg_10_0.lbltili:setString(var_10_2 .. "/" .. var_10_3)
	end

	arg_10_0.nodeNone:setVisible(table.getn(var_10_0) <= 0)
	arg_10_0.nodehave:setVisible(table.getn(var_10_0) > 0)

	if zbUtil:isValidTable(var_10_0) and table.getn(var_10_0) > 0 then
		local var_10_4 = zbVipTable:getRecord(g_Self:getVipLevel())
		local var_10_5 = 20

		if var_10_4 then
			var_10_5 = var_10_4.friendsNum
		end

		arg_10_0.lblnum:setString(table.getn(var_10_0) .. "/" .. var_10_5)
		arg_10_0:confirmCreateView(var_10_0)
		arg_10_0:refreshItems(var_10_0)
	end
end

function var_0_0.confirmCreateView(arg_11_0, arg_11_1)
	if table.getn(arg_11_0.items) == table.getn(arg_11_1) then
		return
	end

	for iter_11_0, iter_11_1 in pairs(arg_11_0.items) do
		iter_11_1:removeFromParentAndCleanup(false)
	end

	arg_11_0.items = {}

	if arg_11_0.tableView ~= nil then
		arg_11_0.tableView:removeFromParentAndCleanup(true)

		arg_11_0.tableView = nil
		arg_11_0.tableViewHelper = nil
	end

	local var_11_0 = table.getn(arg_11_1)
	local var_11_1 = table.getn(arg_11_0.items)
	local var_11_2 = arg_11_0.layer:getContentSize()
	local var_11_3 = CCSizeMake(var_11_2.width, var_0_1 * var_11_0)
	local var_11_4 = CCSizeMake(var_11_2.width, var_11_2.height)

	arg_11_0.tableViewHelper = zbTableViewHelper:create()
	arg_11_0.tableView = zbTableViewHelper:createTableView(var_11_3, var_11_4, 1, arg_11_0.tableViewHelper)

	arg_11_0.tableView:setPosition(0, 0)
	arg_11_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_11_0.layer:addChild(arg_11_0.tableView)

	if var_11_0 - var_11_1 > 0 then
		for iter_11_2 = 1, var_11_0 - var_11_1 do
			local var_11_5 = zbTableViewHelper:create()

			var_11_5:loadCCBFile("ccbi/tb_friend.ccbi")

			local var_11_6 = createFriendItem(translateAndStrokeHelper(var_11_5:readCCBNode()))

			var_11_6:retain()

			arg_11_0.items[var_11_1 + iter_11_2] = var_11_6

			var_11_5:releaseSelf()
		end
	end

	local var_11_7 = 1

	for iter_11_3, iter_11_4 in pairs(arg_11_1) do
		local var_11_8 = arg_11_0.items[var_11_7]

		arg_11_0.tableViewHelper:addCell(var_11_8)

		var_11_7 = var_11_7 + 1
	end

	arg_11_0.tableViewHelper:refreshTabelView()
	arg_11_0.tableViewHelper:setTouchPriority(arg_11_0.btnPri:getTouchPriority())
end

function var_0_0.refreshItems(arg_12_0, arg_12_1)
	local var_12_0 = 1

	for iter_12_0, iter_12_1 in pairs(arg_12_1) do
		arg_12_0.items[var_12_0]:refresh(iter_12_1)

		var_12_0 = var_12_0 + 1
	end
end
