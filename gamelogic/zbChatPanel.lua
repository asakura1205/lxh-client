require("gamelogic.zbChatContent")
require("gamelogic.zbChatline_world")
require("gamelogic.zbChatline_system")

local var_0_0 = class("zbChatPanel")

var_0_0.__index = var_0_0

function var_0_0.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, var_0_0)

	return arg_1_0
end

function createChatPanel(arg_2_0, arg_2_1)
	local var_2_0 = var_0_0.new()

	var_2_0:init(arg_2_0, arg_2_1)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0()
		arg_3_0.items = {}
		arg_3_0.tableView = nil
		arg_3_0.tableViewHelper = nil
		arg_3_0.currCount = 0
		arg_3_0.chatType = arg_3_2
	end

	local function var_3_1()
		arg_3_0.layerContent = arg_3_1
	end

	var_3_0()
	var_3_1()
	arg_3_0:initTableView()
end

function var_0_0.initTableView(arg_6_0)
	local var_6_0 = arg_6_0.layerContent:getContentSize()
	local var_6_1 = CCSizeMake(var_6_0.width, var_6_0.height)
	local var_6_2 = CCSizeMake(var_6_0.width, var_6_0.height)

	arg_6_0.tableViewHelper = zbTableViewHelper:create()
	arg_6_0.tableView = zbTableViewHelper:createTableView(var_6_1, var_6_2, 1, arg_6_0.tableViewHelper, 0)

	arg_6_0.tableView:setPosition(0, 0)
	arg_6_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_6_0.layerContent:addChild(arg_6_0.tableView)
	arg_6_0.tableViewHelper:refreshTabelView()
	arg_6_0:refresh()
end

function var_0_0.createChatItem(arg_7_0)
	local var_7_0

	if arg_7_0.chatType == EChatType.EWorld then
		local var_7_1 = zbTableViewHelper:create()

		var_7_1:loadCCBFile("ccbi/chatline_world.ccbi")

		var_7_0 = createChatlineWorld(translateAndStrokeHelper(var_7_1:readCCBNode()))

		var_7_1:releaseSelf()
	elseif arg_7_0.chatType == EChatType.ELegion then
		local var_7_2 = zbTableViewHelper:create()

		var_7_2:loadCCBFile("ccbi/chatline_world.ccbi")

		var_7_0 = createChatlineWorld(translateAndStrokeHelper(var_7_2:readCCBNode()))

		var_7_2:releaseSelf()
	elseif arg_7_0.chatType == EChatType.ESystem then
		local var_7_3 = zbTableViewHelper:create()

		var_7_3:loadCCBFile("ccbi/chatline_system.ccbi")

		var_7_0 = createChatlineSystem(translateAndStrokeHelper(var_7_3:readCCBNode()))

		var_7_3:releaseSelf()
	end

	return var_7_0
end

function var_0_0.insertChatItem(arg_8_0, arg_8_1)
	local var_8_0

	arg_8_0.currCount = arg_8_0.currCount + 1

	if arg_8_0.currCount <= CHAT_MAX_LINE then
		var_8_0 = arg_8_0:createChatItem()

		var_8_0:retain()

		arg_8_0.items[arg_8_0.currCount] = var_8_0
	else
		arg_8_0.tableViewHelper:removeCellAtIndex(0, false)

		var_8_0 = arg_8_0:createChatItem()

		var_8_0:retain()

		arg_8_0.items[arg_8_0.currCount] = var_8_0
	end

	var_8_0:refresh(arg_8_1)
	arg_8_0.tableViewHelper:addCell(var_8_0)
	arg_8_0.tableViewHelper:refreshTabelView()
end

function var_0_0.refresh(arg_9_0)
	local var_9_0 = g_Self.kChatHandler:getChatDatasByType(arg_9_0.chatType)

	if var_9_0 == nil then
		echo("warning: can not get chatdata")

		return
	end

	for iter_9_0, iter_9_1 in pairs(var_9_0) do
		arg_9_0:insertChatItem(iter_9_1)
	end

	zbUtil:setTableViewOffset(arg_9_0.tableViewHelper, kCCScrollViewDirectionVertical, kCCTableViewFillTopDown, 5, arg_9_0.currCount, 0, arg_9_0.currCount)
end

function var_0_0.addNewChatItem(arg_10_0, arg_10_1)
	arg_10_0:insertChatItem(arg_10_1)
	zbUtil:setTableViewOffset(arg_10_0.tableViewHelper, kCCScrollViewDirectionVertical, kCCTableViewFillTopDown, 5, arg_10_0.currCount, 0, arg_10_0.currCount)
end
