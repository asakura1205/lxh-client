require("gamelogic.zbBaseWnd")
require("gamelogic.zbServerListItem")

local var_0_0 = class("zbServerListWnd", zbBaseWnd)

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

function var_0_0.init(arg_2_0)
	local function var_2_0()
		arg_2_0.lastServer1 = nil
		arg_2_0.lastServer2 = nil
	end

	local function var_2_1()
		local var_4_0 = CCBProxy:create()
		local var_4_1 = CCBReaderLoad("ccbi/serverlist.ccbi", var_4_0, true, "HelloCocosBuilderLayerOwner")
		local var_4_2 = tolua.cast(var_4_1, "CCNode")
		local var_4_3 = tolua.cast(var_4_2:getChildByTag(1), "CCNode")
		local var_4_4 = tolua.cast(var_4_3:getChildByTag(1), "CCNode")

		arg_2_0.btnback = tolua.cast(var_4_4:getChildByTag(2), "CCControlButton")

		arg_2_0.btnback:addHandleOfControlEvent(function()
			arg_2_0:hide()
		end, CCControlEventTouchUpInside)

		local var_4_5 = tolua.cast(var_4_3:getChildByTag(100), "CCLayerColor")
		local var_4_6 = tolua.cast(var_4_3:getChildByTag(200), "CCLayerColor")
		local var_4_7 = tolua.cast(var_4_3:getChildByTag(300), "CCLayerColor")

		arg_2_0.allServerLayer = tolua.cast(var_4_5:getChildByTag(100), "CCNode")
		arg_2_0.lastServerLayer = tolua.cast(var_4_6:getChildByTag(200), "CCNode")
		arg_2_0.curServerLayer = tolua.cast(var_4_7:getChildByTag(300), "CCNode")

		arg_2_0:setWinType(EWinType.Pop_OnlyDark)
		arg_2_0:addChild(var_4_1)
	end

	local function var_2_2()
		arg_2_0.listViewRoot = tolua.cast(arg_2_0.allServerLayer:getChildByTag(1), "CCLayerColor")

		arg_2_0.listViewRoot:setOpacity(0)

		arg_2_0.allServerList_item = {}
	end

	local function var_2_3()
		arg_2_0.lastLoginTitle = tolua.cast(arg_2_0.lastServerLayer:getChildByTag(2), "CCLabelTTF")
		arg_2_0.lastLoginServerIndex = tolua.cast(arg_2_0.lastServerLayer:getChildByTag(3), "CCLabelTTF")
		arg_2_0.lastLoginServerName = tolua.cast(arg_2_0.lastServerLayer:getChildByTag(4), "CCLabelTTF")
		arg_2_0.lastLoginServerState = tolua.cast(arg_2_0.lastServerLayer:getChildByTag(5), "CCSprite")
		arg_2_0.lastLoginServerBtn = tolua.cast(arg_2_0.lastServerLayer:getChildByTag(6), "CCControlButton")

		arg_2_0.lastLoginServerBtn:addHandleOfControlEvent(function()
			arg_2_0:onLastServer()
		end, CCControlEventTouchUpInside)
	end

	local function var_2_4()
		arg_2_0.serverRoot = {}
		arg_2_0.serverName = {}
		arg_2_0.serverState = {}
		arg_2_0.serverRoleBtn = {}
		arg_2_0.s_roleNode = {}
		arg_2_0.s_roleLv = {}

		local var_9_0 = tolua.cast(arg_2_0.curServerLayer:getChildByTag(100), "CCNode")

		for iter_9_0 = 1, 10 do
			arg_2_0.serverRoot[iter_9_0] = tolua.cast(var_9_0:getChildByTag(iter_9_0), "CCNode")
			arg_2_0.serverName[iter_9_0] = tolua.cast(arg_2_0.serverRoot[iter_9_0]:getChildByTag(3), "CCLabelTTF")
			arg_2_0.serverState[iter_9_0] = tolua.cast(arg_2_0.serverRoot[iter_9_0]:getChildByTag(5), "CCSprite")
			arg_2_0.serverRoleBtn[iter_9_0] = tolua.cast(arg_2_0.serverRoot[iter_9_0]:getChildByTag(10), "CCControlButton")

			arg_2_0.serverRoleBtn[iter_9_0]:addHandleOfControlEvent(function()
				arg_2_0:onSelCurServerList(arg_2_0.serverRoleBtn[iter_9_0])
			end, CCControlEventTouchUpInside)

			arg_2_0.s_roleNode[iter_9_0] = tolua.cast(arg_2_0.serverRoot[iter_9_0]:getChildByTag(1), "CCNode")

			local var_9_1 = tolua.cast(arg_2_0.s_roleNode[iter_9_0]:getChildByTag(1), "CCLabelTTF")

			arg_2_0.s_roleLv[iter_9_0] = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

			require("gamebase.zbUI"):replaceCtrl(var_9_1, arg_2_0.s_roleLv[iter_9_0])
			arg_2_0.s_roleLv[iter_9_0]:setScale(0.4)
		end
	end

	var_2_0()
	var_2_1()
	var_2_2()
	var_2_3()
	var_2_4()
	arg_2_0:setShowCallback(function()
		arg_2_0:doShow()
	end)
	arg_2_0:registerEvent(arg_2_0, function()
		arg_2_0:refresh()
	end, zbGameEvent.Event_Refresh_ServerList)
	arg_2_0:registerEvent(arg_2_0, function()
		arg_2_0:refreshServerRole()
	end, zbGameEvent.Event_Server_Role)
end

function var_0_0.cleanupAllServerList(arg_14_0)
	for iter_14_0 = 1, 10 do
		arg_14_0.serverRoot[iter_14_0]:setVisible(false)
	end

	arg_14_0.lastLoginServerIndex:setVisible(false)
	arg_14_0.lastLoginServerName:setVisible(false)
	arg_14_0.lastLoginServerState:setVisible(false)
end

function var_0_0.doShow(arg_15_0)
	arg_15_0:cleanupAllServerList()
	g_Login:reqAreaList()
end

function var_0_0.refresh(arg_16_0)
	if g_Login.areaInfo == nil then
		return
	end

	local var_16_0 = table.getn(g_Login.areaInfo.ServerList)

	if var_16_0 < 1 then
		return
	end

	local var_16_1 = math.mod(var_16_0, 10)
	local var_16_2 = (var_16_0 - var_16_1) / 10
	local var_16_3 = 154
	local var_16_4 = 70

	for iter_16_0, iter_16_1 in pairs(arg_16_0.allServerList_item) do
		iter_16_1:removeFromParentAndCleanup(false)
	end

	if arg_16_0.m_tableView ~= nil then
		arg_16_0.m_tableView:removeFromParentAndCleanup(true)

		arg_16_0.m_tableView = nil
		arg_16_0.m_tableViewHelper = nil
	end

	local var_16_5 = arg_16_0.listViewRoot:getContentSize()
	local var_16_6 = zbTableViewHelper:create()
	local var_16_7 = zbTableViewHelper:createTableView(var_16_5, var_16_5, 1, var_16_6)

	var_16_7:setPosition(0, 0)
	var_16_7:setAnchorPoint(ccp(0, 0))
	arg_16_0.listViewRoot:addChild(var_16_7)
	var_16_6:setMaskPanel(nil, nil, arg_16_0.upMaskPanel, arg_16_0.downMaskPanel)

	arg_16_0.m_tableViewHelper = var_16_6
	arg_16_0.m_tableView = var_16_7

	local var_16_8 = zbTableViewHelper:create()

	var_16_8:loadCCBFile("ccbi/tb_server_index.ccbi")

	for iter_16_2 = 1, var_16_2 do
		local var_16_9 = createServerListItem(translateAndStrokeHelper(var_16_8:readCCBNode()), iter_16_2)

		arg_16_0.allServerList_item[iter_16_2] = var_16_9

		arg_16_0.m_tableViewHelper:addCell(var_16_9)
	end

	if var_16_1 > 0 then
		local var_16_10 = createServerListItem(translateAndStrokeHelper(var_16_8:readCCBNode()), var_16_2 + 1)

		arg_16_0.allServerList_item[var_16_2 + 1] = var_16_10

		var_16_10:setAreaTitle(var_16_1)
		arg_16_0.m_tableViewHelper:addCell(var_16_10)
	end

	arg_16_0.m_tableViewHelper:refreshTabelView()
	arg_16_0.m_tableViewHelper:setTouchPriority(arg_16_0.lastLoginServerBtn:getTouchPriority())
	arg_16_0.lastLoginServerIndex:setVisible(true)
	arg_16_0.lastLoginServerName:setVisible(true)
	arg_16_0.lastLoginServerState:setVisible(true)

	local var_16_11 = g_Login:getServerById(g_Login.lastServerId)

	if var_16_11 then
		arg_16_0.lastLoginTitle:setString(a2u("\xC9ϴε\xC7¼"))

		local var_16_12 = math.floor(g_Login.lastServerId / 11)

		arg_16_0:onSelAllServerList(var_16_12 + 1)
	else
		var_16_11 = g_Login:getServerById(g_Login.areaInfo.DefaultSid)

		arg_16_0.lastLoginTitle:setString(a2u("\xCDƼ\xF6\xB7\xFE\xCE\xF1\xC6\xF7"))

		local var_16_13 = math.floor(g_Login.areaInfo.DefaultSid / 11)

		arg_16_0:onSelAllServerList(var_16_13 + 1)
	end

	if var_16_11 then
		local var_16_14 = ccc3(255, 255, 255)

		if var_16_11.ServerStatus == 0 then
			arg_16_0.lastLoginServerState:setTexture(CCTextureCache:sharedTextureCache():addImage(EServerStateTex[4]))
		else
			var_16_14 = EServerStateColor[var_16_11.ServerStatus]

			arg_16_0.lastLoginServerState:setTexture(CCTextureCache:sharedTextureCache():addImage(EServerStateTex[var_16_11.ServerStatus]))
		end

		arg_16_0.lastLoginServerIndex:setString(var_16_11.SortId .. a2u("\xC7\xF8"))
		arg_16_0.lastLoginServerIndex:setFontFillColor(var_16_14, true)
		arg_16_0.lastLoginServerName:setString(a2u(var_16_11.ServerName))
		arg_16_0.lastLoginServerName:setFontFillColor(var_16_14, true)
	else
		arg_16_0.lastLoginTitle:setString(a2u("\xCE޷\xFE\xCE\xF1\xC6\xF7\xBC\xC7¼"))
		arg_16_0.lastLoginServerIndex:setVisible(false)
		arg_16_0.lastLoginServerName:setVisible(false)
		arg_16_0.lastLoginServerState:setVisible(false)
	end

	g_Login:reqAreaRoleInfo()
end

function var_0_0.refreshCurServers(arg_17_0, arg_17_1)
	for iter_17_0 = 1, 10 do
		arg_17_0.serverRoot[iter_17_0]:setVisible(false)
		arg_17_0.s_roleNode[iter_17_0]:setVisible(false)
	end

	local var_17_0 = table.getn(g_Login.areaInfo.ServerList)
	local var_17_1 = (arg_17_1 - 1) * 10
	local var_17_2 = 0

	for iter_17_1 = 1, 10 do
		local var_17_3 = var_17_1 + iter_17_1

		if var_17_3 <= var_17_0 then
			arg_17_0.serverRoot[iter_17_1]:setVisible(true)

			local var_17_4 = g_Login.areaInfo.ServerList[var_17_3]

			arg_17_0.serverRoleBtn[iter_17_1]:setTag(var_17_4.ServerId)

			local var_17_5 = ccc3(255, 255, 255)

			if var_17_4.ServerStatus == 0 then
				-- block empty
			else
				var_17_5 = EServerStateColor[var_17_4.ServerStatus]
			end

			arg_17_0.serverName[iter_17_1]:setString(a2u(var_17_4.SortId .. a2u("\xC7\xF8 ") .. var_17_4.ServerName))
			arg_17_0.serverName[iter_17_1]:setFontFillColor(var_17_5, true)
			arg_17_0.serverState[iter_17_1]:setVisible(true)

			if var_17_4.ServerStatus == 0 then
				arg_17_0.serverState[iter_17_1]:setTexture(CCTextureCache:sharedTextureCache():addImage(EServerStateTex[4]))
			else
				arg_17_0.serverState[iter_17_1]:setTexture(CCTextureCache:sharedTextureCache():addImage(EServerStateTex[var_17_4.ServerStatus]))
			end

			arg_17_0.serverName[iter_17_1]:setGray(var_17_4.ServerStatus == 0)
			arg_17_0.serverRoot[iter_17_1]:setGray(var_17_4.ServerStatus == 0)

			var_17_2 = var_17_2 + 1
		else
			arg_17_0.serverRoot[iter_17_1]:setVisible(false)
		end
	end

	arg_17_0:refreshServerRole()
end

function var_0_0.refreshServerRole(arg_18_0)
	if g_Login.areaRoleInfo == nil then
		return
	end

	local function var_18_0(arg_19_0)
		for iter_19_0, iter_19_1 in pairs(g_Login.areaRoleInfo.RoleList) do
			if iter_19_1.ServerId == arg_19_0 then
				return iter_19_1
			end
		end

		return nil
	end

	for iter_18_0 = 1, 10 do
		if arg_18_0.serverRoot[iter_18_0]:isVisible() then
			local var_18_1 = var_18_0(arg_18_0.serverRoleBtn[iter_18_0]:getTag())

			if var_18_1 == nil then
				arg_18_0.s_roleNode[iter_18_0]:setVisible(false)
			else
				arg_18_0.s_roleNode[iter_18_0]:setVisible(true)
				arg_18_0.s_roleLv[iter_18_0]:setString(var_18_1.Level)
			end
		end
	end
end

function var_0_0.onSelectLastServer1(arg_20_0)
	g_LoginScene:hideServerList()
end

function var_0_0.onSelAllServerList(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1

	if var_21_0 > table.getn(arg_21_0.allServerList_item) then
		var_21_0 = 1
	end

	for iter_21_0, iter_21_1 in pairs(arg_21_0.allServerList_item) do
		if iter_21_0 == var_21_0 then
			iter_21_1:setItemSelected(true)
			arg_21_0:refreshCurServers(var_21_0)
		else
			iter_21_1:setItemSelected(false)
		end
	end
end

function var_0_0.onSelCurServerList(arg_22_0, arg_22_1)
	g_Login.selectServerId = arg_22_1:getTag()

	arg_22_0:hide()
	g_GameEventMgr:sendEvent(zbGameEvent.Event_Select_Server)
end

function var_0_0.onLastServer(arg_23_0)
	g_Login.selectServerId = g_Login.lastServerId

	arg_23_0:hide()
	g_GameEventMgr:sendEvent(zbGameEvent.Event_Select_Server)
end

function createServerListWnd()
	local var_24_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_24_0:initBase()
	var_24_0:init()

	return var_24_0
end
