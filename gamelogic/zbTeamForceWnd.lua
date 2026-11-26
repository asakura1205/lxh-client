require("gamelogic.zbTabWnd")
require("gamelogic.zbTeamForceItem")

local var_0_0 = class("zbTeamForceWnd", zbTabWnd)

var_0_0.__index = var_0_0

function createTeamForceWnd()
	local var_1_0 = var_0_0.extend(zbTabWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create()))))

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
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/teamforce.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1, "CCNode")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCLayer")

		arg_3_0.layerTouchTest = var_5_3
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.nodeFrind = tolua.cast(var_5_3:getChildByTag(1), "CCNode")
		arg_3_0.btnClose = tolua.cast(var_5_3:getChildByTag(10), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:onClose()
		end, CCControlEventTouchUpInside)

		local var_5_4 = {
			tolua.cast(var_5_3:getChildByTag(11), "CCControlButton"),
			(tolua.cast(var_5_3:getChildByTag(12), "CCControlButton"))
		}
		local var_5_5 = {
			tolua.cast(arg_3_0.nodeFrind, "CCNode"),
			(tolua.cast(arg_3_0.nodeFrind, "CCNode"))
		}
		local var_5_6 = {}

		var_5_6[1] = "image/tab/tab_friend_friendList.png"
		var_5_6[2] = "image/tab/tab_chat_eLegion.png"

		local var_5_7 = tolua.cast(arg_3_0.nodeFrind:getChildByTag(1), "CCNode")
		local var_5_8 = tolua.cast(var_5_7:getChildByTag(1):getChildByTag(1), "CCControlButton")
		local var_5_9 = tolua.cast(var_5_7:getChildByTag(1):getChildByTag(2), "CCControlButton")

		arg_3_0.mainLayer = tolua.cast(var_5_7:getChildByTag(3), "CCLayer")

		var_5_8:addHandleOfControlEvent(function()
			arg_3_0:onClear()
		end, CCControlEventTouchUpInside)
		var_5_9:addHandleOfControlEvent(function()
			arg_3_0:onAuto()
		end, CCControlEventTouchUpInside)
		arg_3_0:initTab(var_5_4, var_5_5, var_5_6)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(function()
		arg_3_0:onShowCallback()
	end)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refreshList()
	end, zbGameEvent.Event_TeamForce)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refreshList()
	end, zbGameEvent.Event_LegionMemberDetailAck)
end

function var_0_0.onClose(arg_13_0)
	arg_13_0:hide()
	g_MainScene.wndEmbattle:refreshTeamList()
end

function var_0_0.refresh(arg_14_0)
	return
end

function var_0_0.onShowCallback(arg_15_0)
	arg_15_0:selectTab(1)
end

function var_0_0.doSelectTab(arg_16_0)
	for iter_16_0 = 1, table.getn(arg_16_0.tabButtons) do
		if arg_16_0.tabButtons[iter_16_0] then
			if iter_16_0 == arg_16_0.currTab then
				arg_16_0.tabButtons[iter_16_0]:setZOrder(ZORDER_TOP)
			else
				arg_16_0.tabButtons[iter_16_0]:setZOrder(ZORDER_BOTTOM)
			end
		end
	end

	if arg_16_0.currTab == 1 then
		g_WsMsgHandler:WS_Friends_GetData_Req()
	elseif g_GameData.LegionInfo and g_GameData.LegionInfo.LegionId > 0 then
		g_WsMsgHandler:WS_Legion_GetMembers_Req()

		return
	else
		local var_16_0 = {}

		arg_16_0:confirmCreateView(var_16_0)
	end
end

local function var_0_1(arg_17_0, arg_17_1)
	return arg_17_0.PlayerBaseInfo.FV >= arg_17_1.PlayerBaseInfo.FV
end

function var_0_0.refreshList(arg_18_0)
	local var_18_0 = {}

	if arg_18_0.currTab == 1 then
		var_18_0 = g_Self.kFriendHandler.frienddata.FriendsList
	else
		var_18_0 = g_Self.kLegionHandler.legionMemberDetail.MemberList
	end

	table.sort(var_18_0, var_0_1)
	arg_18_0:confirmCreateView(var_18_0)
end

function var_0_0.confirmCreateView(arg_19_0, arg_19_1)
	if arg_19_0.tableViewHelper == nil then
		arg_19_0.tableViewHelper = zbTableViewHelper:create()
	end

	if arg_19_0.tableView == nil then
		local var_19_0 = arg_19_0.mainLayer:getContentSize()

		arg_19_0.tableView = zbTableViewHelper:createTableView(var_19_0, var_19_0, 1, arg_19_0.tableViewHelper)

		arg_19_0.tableView:setPosition(0, 0)
		arg_19_0.tableView:setAnchorPoint(ccp(0, 0))
		arg_19_0.mainLayer:addChild(arg_19_0.tableView)
	end

	local var_19_1 = table.getn(arg_19_1)

	if arg_19_0.currTab == 2 then
		var_19_1 = var_19_1 - 1
	end

	local var_19_2 = table.getn(arg_19_0.items)

	if var_19_1 - var_19_2 > 0 then
		for iter_19_0 = 1, var_19_1 - var_19_2 do
			local var_19_3 = zbTableViewHelper:create()

			var_19_3:loadCCBFile("ccbi/tb_teamforceitem.ccbi")

			local var_19_4 = createTeamForceItem(translateAndStrokeHelper(var_19_3:readCCBNode()), arg_19_0)

			var_19_4:retain()

			arg_19_0.items[var_19_2 + iter_19_0] = var_19_4

			var_19_3:releaseSelf()
		end
	end

	arg_19_0.tableViewHelper:removeAllCells()

	local var_19_5 = 1

	for iter_19_1, iter_19_2 in pairs(arg_19_1) do
		if iter_19_2.PlayerBaseInfo.PlayerId ~= g_Self:getPlayerId() then
			local var_19_6 = arg_19_0.items[var_19_5]

			var_19_6:refresh(iter_19_2)
			arg_19_0.tableViewHelper:addCell(var_19_6)

			var_19_5 = var_19_5 + 1
		end
	end

	arg_19_0.tableViewHelper:refreshTabelView()
	arg_19_0.tableViewHelper:setTouchPriority(arg_19_0.btnClose:getTouchPriority())
end

function var_0_0.onTouchTest(arg_20_0)
	local var_20_0 = arg_20_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_20_0.layerTouchTest, var_20_0.x, var_20_0.y) == false and zbUtil:PointInCtrl(arg_20_0.btnClose, var_20_0.x, var_20_0.y) == false then
		arg_20_0:hide()
	end
end

function var_0_0.onClear(arg_21_0)
	g_MainScene.wndEmbattle.selectList = {}

	arg_21_0:refreshList()
end

function var_0_0.onAuto(arg_22_0)
	g_MainScene.wndEmbattle.selectList = {}

	local var_22_0 = {}

	if arg_22_0.currTab == 1 then
		var_22_0 = g_Self.kFriendHandler.frienddata.FriendsList
	elseif g_GameData.LegionInfo and g_GameData.LegionInfo.LegionId > 0 then
		var_22_0 = g_Self.kLegionHandler.legionMemberDetail.MemberList
	end

	local var_22_1 = {}
	local var_22_2 = 1

	for iter_22_0, iter_22_1 in pairs(var_22_0) do
		local var_22_3 = true

		for iter_22_2, iter_22_3 in pairs(g_GameData.TeamHire.HireList) do
			if iter_22_1.PlayerBaseInfo.PlayerId == iter_22_3 then
				var_22_3 = false

				break
			end
		end

		if var_22_3 == true and iter_22_1.PlayerBaseInfo.PlayerId ~= g_Self:getPlayerId() then
			table.insert(var_22_1, iter_22_1)
		end
	end

	table.sort(var_22_1, var_0_1)

	local var_22_4 = 1

	for iter_22_4, iter_22_5 in pairs(var_22_1) do
		if var_22_4 >= 3 then
			break
		end

		table.insert(g_MainScene.wndEmbattle.selectList, iter_22_5)

		var_22_4 = var_22_4 + 1
	end

	arg_22_0:refreshList()
end
