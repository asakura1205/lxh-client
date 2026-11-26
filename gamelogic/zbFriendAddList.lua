require("gamelogic.zbFriendTuijianItem")

local var_0_0 = class("zbFriendAddList")

var_0_0.__index = var_0_0

local var_0_1 = 100

function createFriendAddList(arg_1_0, arg_1_1)
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
		arg_2_0.nodeInput = tolua.cast(arg_2_1:getChildByTag(2), "CCNode")

		local var_4_0 = tolua.cast(arg_2_0.nodeInput:getChildByTag(1), "CCLayer")
		local var_4_1 = ccc3(184, 167, 144)

		arg_2_0.inputBox = zbUtil:createEditBox(var_4_0, "", 8, "image/common/button_transparent.png", 22, var_4_1)

		var_4_0:addChild(arg_2_0.inputBox)

		arg_2_0.btnSearch = tolua.cast(arg_2_0.nodeInput:getChildByTag(2), "CCControlButton")

		arg_2_0.btnSearch:addHandleOfControlEvent(function()
			arg_2_0:onSearch()
		end, CCControlEventTouchUpInside)
	end

	var_2_0()
	var_2_1()
end

function var_0_0.onFrame(arg_6_0)
	return
end

function var_0_0.refresh(arg_7_0)
	FriendsSearchAckData = nil

	local var_7_0 = string.trim(arg_7_0.inputBox:getText())

	if var_7_0 ~= "" then
		g_WsMsgHandler:WS_Friends_Search_Req(var_7_0)
	end
end

function var_0_0.refreshList(arg_8_0)
	if FriendsSearchAckData == nil then
		return
	end

	local var_8_0 = FriendsSearchAckData.SearchList

	arg_8_0.nodehave:setVisible(table.getn(var_8_0) > 0)

	if zbUtil:isValidTable(var_8_0) and table.getn(var_8_0) > 0 then
		arg_8_0:confirmCreateView(var_8_0)
		arg_8_0:refreshItems(var_8_0)
	end
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
	local var_9_2 = arg_9_0.layer:getContentSize()
	local var_9_3 = CCSizeMake(var_9_2.width, var_0_1 * var_9_0)
	local var_9_4 = CCSizeMake(var_9_2.width, var_9_2.height)

	arg_9_0.tableViewHelper = zbTableViewHelper:create()
	arg_9_0.tableView = zbTableViewHelper:createTableView(var_9_3, var_9_4, 1, arg_9_0.tableViewHelper)

	arg_9_0.tableView:setPosition(0, 0)
	arg_9_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_9_0.layer:addChild(arg_9_0.tableView)

	if var_9_0 - var_9_1 > 0 then
		for iter_9_2 = 1, var_9_0 - var_9_1 do
			local var_9_5 = zbTableViewHelper:create()

			var_9_5:loadCCBFile("ccbi/tb_friendtuijian_item.ccbi")

			local var_9_6 = createFriendTuijianItem(translateAndStrokeHelper(var_9_5:readCCBNode()))

			var_9_6:retain()

			arg_9_0.items[var_9_1 + iter_9_2] = var_9_6

			var_9_5:releaseSelf()
		end
	end

	local var_9_7 = 1

	for iter_9_3, iter_9_4 in pairs(arg_9_1) do
		local var_9_8 = arg_9_0.items[var_9_7]

		arg_9_0.tableViewHelper:addCell(var_9_8)

		var_9_7 = var_9_7 + 1
	end

	arg_9_0.tableViewHelper:refreshTabelView()
	arg_9_0.tableViewHelper:setTouchPriority(arg_9_0.btnPri:getTouchPriority())
end

function var_0_0.refreshItems(arg_10_0, arg_10_1)
	local var_10_0 = 1

	for iter_10_0, iter_10_1 in pairs(arg_10_1) do
		arg_10_0.items[var_10_0]:refresh(iter_10_1)

		var_10_0 = var_10_0 + 1
	end
end

function var_0_0.onSearch(arg_11_0)
	FriendsSearchAckData = nil

	local var_11_0 = string.trim(arg_11_0.inputBox:getText())

	if var_11_0 ~= "" then
		g_WsMsgHandler:WS_Friends_Search_Req(var_11_0)
	end
end
