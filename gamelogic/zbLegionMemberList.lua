require("gamelogic.zbLegionMemItem")

local var_0_0 = class("zbLegionMemberList")

var_0_0.__index = var_0_0

local var_0_1 = 765
local var_0_2 = 110

function createLegionMemPanel(arg_1_0)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	local function var_2_0()
		arg_2_0.items = {}
		arg_2_0.tableview = nil
		arg_2_0.tableviewHelper = nil
	end

	local function var_2_1()
		arg_2_0.layer = arg_2_1
		arg_2_0.btnQuit = tolua.cast(arg_2_1:getChildByTag(1), "CCControlButton")

		arg_2_0.btnQuit:addHandleOfControlEvent(function()
			arg_2_0:onQuitLegion()
		end, CCControlEventTouchUpInside)

		arg_2_0.nodeInfo = tolua.cast(arg_2_1:getChildByTag(2), "CCNode")
		arg_2_0.legionIcon = tolua.cast(arg_2_0.nodeInfo:getChildByTag(1), "CCSprite")
		arg_2_0.legionName = tolua.cast(arg_2_0.nodeInfo:getChildByTag(2), "CCLabelTTF")
		arg_2_0.legionLv = tolua.cast(arg_2_0.nodeInfo:getChildByTag(3), "CCSprite")
		arg_2_0.lblMemberNum = tolua.cast(arg_2_0.nodeInfo:getChildByTag(4), "CCLabelTTF")
		arg_2_0.nodeMember = tolua.cast(arg_2_1:getChildByTag(3), "CCNode")
		arg_2_0.mainLayer = tolua.cast(arg_2_0.nodeMember:getChildByTag(1), "CCLayer")
	end

	var_2_0()
	var_2_1()
end

function var_0_0.free(arg_6_0)
	return
end

function var_0_0.refresh(arg_7_0)
	local var_7_0 = g_Self.kLegionHandler.legionDetail

	if var_7_0 then
		local var_7_1 = zbIconHelper:getLegionIconPath(var_7_0.LegionBaseInfo.IconId)

		arg_7_0.legionIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_7_1))
		arg_7_0.legionName:setString(a2u(var_7_0.LegionBaseInfo.LegionName))
		zbLegionHelp:setLegionLvTexture(arg_7_0.legionLv, var_7_0.LegionBaseInfo.Level)
		arg_7_0.lblMemberNum:setString(var_7_0.LegionBaseInfo.MemberCount .. "/" .. var_7_0.LegionBaseInfo.MaxMemberCount)
	end

	g_WsMsgHandler:WS_Legion_GetMembers_Req()
	arg_7_0:refreshReslut()
end

function var_0_0.refreshReslut(arg_8_0)
	local var_8_0 = {}

	if g_Self.kLegionHandler.legionMemberDetail then
		var_8_0 = g_Self.kLegionHandler.legionMemberDetail.MemberList
	end

	local var_8_1 = g_Self.kLegionHandler.legionDetail

	if var_8_1 then
		arg_8_0.lblMemberNum:setString(table.getn(var_8_0) .. "/" .. var_8_1.LegionBaseInfo.MaxMemberCount)
	end

	arg_8_0.nodeMember:setVisible(table.getn(var_8_0) > 0)
	arg_8_0:confirmCreateView(var_8_0)
	arg_8_0:refreshItems(var_8_0)
end

function var_0_0.confirmCreateView(arg_9_0, arg_9_1)
	if table.maxn(arg_9_0.items) == table.maxn(arg_9_1) then
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

	if arg_9_1 == nil then
		arg_9_1 = {}
	end

	local var_9_0 = table.maxn(arg_9_1)
	local var_9_1 = table.maxn(arg_9_0.items)
	local var_9_2 = arg_9_0.mainLayer:getContentSize()
	local var_9_3 = CCSizeMake(var_9_2.width, var_0_2 * var_9_0)
	local var_9_4 = CCSizeMake(var_9_2.width, var_9_2.height)

	arg_9_0.tableViewHelper = zbTableViewHelper:create()
	arg_9_0.tableView = zbTableViewHelper:createTableView(var_9_3, var_9_4, 1, arg_9_0.tableViewHelper)

	arg_9_0.tableView:setPosition(0, 0)
	arg_9_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_9_0.mainLayer:addChild(arg_9_0.tableView)

	if var_9_0 - var_9_1 > 0 then
		local var_9_5 = zbTableViewHelper:create()

		var_9_5:loadCCBFile("ccbi/tb_legionmemitem.ccbi")

		for iter_9_2 = 1, var_9_0 - var_9_1 do
			local var_9_6 = createLegionMemItem(translateAndStrokeHelper(var_9_5:readCCBNode()))

			var_9_6:retain()

			arg_9_0.items[var_9_1 + iter_9_2] = var_9_6
		end
	end

	local var_9_7 = 1

	for iter_9_3, iter_9_4 in pairs(arg_9_1) do
		local var_9_8 = arg_9_0.items[var_9_7]

		arg_9_0.tableViewHelper:addCell(var_9_8)

		var_9_7 = var_9_7 + 1
	end

	arg_9_0.tableViewHelper:refreshTabelView()

	if g_MainScene.wndLegionMem then
		arg_9_0.tableViewHelper:setTouchPriority(g_MainScene.wndLegionMem.btnClose:getTouchPriority())
	end
end

function var_0_0.refreshItems(arg_10_0, arg_10_1)
	local var_10_0 = 1

	for iter_10_0, iter_10_1 in pairs(arg_10_1) do
		arg_10_0.items[var_10_0]:refresh(iter_10_1)

		var_10_0 = var_10_0 + 1
	end
end

function var_0_0.onQuitLegion(arg_11_0)
	local function var_11_0()
		g_WsMsgHandler:WS_Legion_Quit_Req()
	end

	local var_11_1 = a2u("ȷ\xB6\xA8Ҫ\xCD˳\xF6\xBB\xE1\xB9\xDD\xC2\xF0?")

	g_MessageBox:showYesNo(var_11_1, var_11_0)
end
