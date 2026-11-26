require("gamelogic.zbChatContent")
require("gamelogic.zbChatObjectList")
require("gamelogic.zbChatline_private")

local var_0_0 = class("zbChatPrivatePanel")

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

function createChatPrivatePanel(arg_2_0)
	local var_2_0 = var_0_0.new()

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.items = {}
		arg_3_0.tableView = nil
		arg_3_0.tableViewHelper = nil
		arg_3_0.currCount = 0
		arg_3_0.curChatId = -1
	end

	local function var_3_1()
		arg_3_0.layerContent = tolua.cast(arg_3_1:getChildByTag(1), "CCLayer")

		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(2), "CCNode")

		arg_3_0.btnSend = tolua.cast(var_5_0:getChildByTag(1), "CCControlButton")
		arg_3_0.btnDel = tolua.cast(var_5_0:getChildByTag(2), "CCControlButton")
		arg_3_0.btnFace = tolua.cast(var_5_0:getChildByTag(6), "CCControlButton")

		arg_3_0.btnDel:addHandleOfControlEvent(function()
			arg_3_0:onDel()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnSend:addHandleOfControlEvent(function()
			arg_3_0:onSend()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnFace:addHandleOfControlEvent(function()
			arg_3_0:onFace()
		end, CCControlEventTouchUpInside)

		local var_5_1 = tolua.cast(var_5_0:getChildByTag(9), "CCLayer")
		local var_5_2 = tolua.cast(var_5_0:getChildByTag(10), "CCScrollView")
		local var_5_3 = ccc3(184, 167, 144)

		arg_3_0.inputBox = zbUtil:createEditBox(var_5_1, "", MAX_CHAT_LEN, "image/common/button_transparent.png", 22, var_5_3)

		var_5_2:addChild(arg_3_0.inputBox)
		var_5_2:setCanMove(false)

		local var_5_4 = tolua.cast(arg_3_1:getChildByTag(3), "CCLayer")

		arg_3_0.chatObjPnl = createChatObjlist(var_5_4, arg_3_0.btnSend)
	end

	var_3_0()
	var_3_1()
	arg_3_0:initTableView()
end

function var_0_0.initTableView(arg_9_0)
	arg_9_0.currCount = 0

	local var_9_0 = arg_9_0.layerContent:getContentSize()
	local var_9_1 = CCSizeMake(var_9_0.width, var_9_0.height)
	local var_9_2 = CCSizeMake(var_9_0.width, var_9_0.height)

	arg_9_0.tableViewHelper = zbTableViewHelper:create()
	arg_9_0.tableView = zbTableViewHelper:createTableView(var_9_1, var_9_2, 1, arg_9_0.tableViewHelper, 0)

	arg_9_0.tableView:setPosition(0, 0)
	arg_9_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_9_0.layerContent:addChild(arg_9_0.tableView)
	arg_9_0.tableViewHelper:refreshTabelView()
	arg_9_0.tableViewHelper:setTouchPriority(arg_9_0.btnSend:getTouchPriority())
end

function var_0_0.createChatItem(arg_10_0)
	local var_10_0
	local var_10_1 = zbTableViewHelper:create()

	var_10_1:loadCCBFile("ccbi/chatline_private.ccbi")

	local var_10_2 = createChatlinePrivate(var_10_1:readCCBNode(), arg_10_0.btnSend:getTouchPriority())

	var_10_1:releaseSelf()

	return var_10_2
end

function var_0_0.insertChatItem(arg_11_0, arg_11_1)
	local var_11_0

	arg_11_0.currCount = arg_11_0.currCount + 1

	if arg_11_0.currCount <= CHAT_MAX_LINE then
		var_11_0 = arg_11_0:createChatItem()

		var_11_0:retain()

		arg_11_0.items[arg_11_0.currCount] = var_11_0
	else
		arg_11_0.tableViewHelper:removeCellAtIndex(0, false)

		var_11_0 = arg_11_0:createChatItem()

		var_11_0:retain()

		arg_11_0.items[arg_11_0.currCount] = var_11_0
	end

	var_11_0:refresh(arg_11_1)
	arg_11_0.tableViewHelper:addCell(var_11_0)
	arg_11_0.tableViewHelper:refreshTabelView()
end

function var_0_0.refresh(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.items) do
		iter_12_1:removeFromParentAndCleanup(false)
	end

	arg_12_0.items = {}

	if arg_12_0.tableView ~= nil then
		arg_12_0.tableView:removeFromParentAndCleanup(true)

		arg_12_0.tableView = nil
		arg_12_0.tableViewHelper = nil
	end

	arg_12_0:initTableView()

	if g_Self.kChatHandler.curPrivateChatPlayerInfo then
		local var_12_0 = g_Self.kChatHandler:getPrivateChatData(g_Self.kChatHandler.curPrivateChatPlayerInfo.playerId)

		if zbUtil:isValidTable(var_12_0) then
			for iter_12_2, iter_12_3 in pairs(var_12_0) do
				arg_12_0:insertChatItem(iter_12_3)
			end
		end
	end

	zbUtil:setTableViewOffset(arg_12_0.tableViewHelper, kCCScrollViewDirectionVertical, kCCTableViewFillTopDown, 4, arg_12_0.currCount, 0, arg_12_0.currCount)
end

function var_0_0.addNewChatItem(arg_13_0, arg_13_1)
	if arg_13_1.SenderId == g_GameData.BaseInfo.PlayerId or arg_13_1.SenderId == g_Self.kChatHandler.curPrivateChatPlayerInfo.playerId then
		arg_13_0:insertChatItem(arg_13_1)
		zbUtil:setTableViewOffset(arg_13_0.tableViewHelper, kCCScrollViewDirectionVertical, kCCTableViewFillTopDown, 4, arg_13_0.currCount, 0, arg_13_0.currCount)
	end
end

function var_0_0.privateChatSel(arg_14_0)
	arg_14_0.chatObjPnl:refresh()

	if arg_14_0.chatObjPnl then
		arg_14_0.chatObjPnl:setCurObjectSel()
	end

	arg_14_0:refresh()
end

function var_0_0.refreshObjPnl(arg_15_0)
	arg_15_0.chatObjPnl:refresh()
end

function var_0_0.setInputBoxStr(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.inputBox:getText() .. arg_16_1

	arg_16_0.inputBox:setText(a2u(var_16_0))
end

function var_0_0.onDel(arg_17_0)
	if g_Self.kChatHandler.curPrivateChatPlayerInfo == nil then
		return
	end

	g_Self.kChatHandler:delChatObjList(g_Self.kChatHandler.curPrivateChatPlayerInfo.playerId)
	g_Self.kChatHandler:delPrivateRecord(g_Self.kChatHandler.curPrivateChatPlayerInfo.playerId)

	if g_MainScene.wndChat then
		g_Self.kChatHandler.curPrivateChatPlayerInfo = nil

		g_MainScene.wndChat:selectTab(EChatType.EPrivate)
	end
end

function var_0_0.onSend(arg_18_0)
	if g_Self.kChatHandler.curPrivateChatPlayerInfo == nil then
		return
	end

	local var_18_0 = arg_18_0.inputBox:getText()

	if g_Self.kChatHandler:isCdEnd(EChatType.EPrivate) == false then
		g_Bubble:bubbleInfo(a2u("\xB7\xA2\xD1\xD4Ƶ\xB7\xB1"))

		return
	end

	if var_18_0 == "" then
		g_Bubble:bubbleInfo(a2u("\xC7\xEB\xCA\xE4\xC8\xEB\xC1\xC4\xCC\xEC\xC4\xDA\xC8\xDD"))

		return
	end

	local var_18_1 = zbUtil:repValidText(var_18_0)

	arg_18_0.inputBox:setText("")
	arg_18_0.inputBox:setPlaceHolder(a2u("\xC7\xEB\xCA\xE4\xC8\xEB..."))

	local var_18_2 = {
		ChatType = EChatType.EPrivate,
		ChatMsg = a2u(var_18_1),
		SenderId = g_GameData.BaseInfo.PlayerId,
		SenderName = a2u(g_Self:getName())
	}

	var_18_2.IsHorn = 0
	var_18_2.SenderHeadId = g_GameData.BaseInfo.HeadId
	var_18_2.SenderLevel = g_Self:getLevel()
	var_18_2.TargetId = g_Self.kChatHandler.curPrivateChatPlayerInfo.playerId
	var_18_2.ChatTm = g_Self.kTimeHandler:getServerTime()
	var_18_2.SenderVipLevel = g_GameData.BaseInfo.VipLevel
	var_18_2.LinkList = {}

	g_Self.kChatHandler:onNewChatNtf(var_18_2)
	g_WsMsgHandler:WS_Chat_SendReq(var_18_2)
end

function var_0_0.onFace(arg_19_0)
	g_Self.kChatHandler.isPrivateChatFace = true

	g_MainScene:showChatFaceWnd()
end

function var_0_0.update(arg_20_0)
	if arg_20_0.chatObjPnl then
		arg_20_0.chatObjPnl:update()
	end
end
