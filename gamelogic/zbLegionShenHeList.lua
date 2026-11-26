require("gamelogic.zbLegionApplyItem")

local var_0_0 = class("zbLegionShenHeList")

var_0_0.__index = var_0_0

local var_0_1 = 765
local var_0_2 = 110

function createLegionShenHePanel(arg_1_0)
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
		arg_2_0.nodeLayer = tolua.cast(arg_2_1:getChildByTag(1), "CCNode")
		arg_2_0.nodeBottom = tolua.cast(arg_2_1:getChildByTag(2), "CCNode")
		arg_2_0.applyLimit = tolua.cast(arg_2_0.nodeBottom:getChildByTag(1001), "CCLabelTTF")
		arg_2_0.btnSetLimit = tolua.cast(arg_2_0.nodeBottom:getChildByTag(2), "CCControlButton")
		arg_2_0.btnRecruit = tolua.cast(arg_2_0.nodeBottom:getChildByTag(3), "CCControlButton")
		arg_2_0.btnRefuseAll = tolua.cast(arg_2_0.nodeBottom:getChildByTag(4), "CCControlButton")

		arg_2_0.btnSetLimit:addHandleOfControlEvent(function()
			arg_2_0:onSetLimit()
		end, CCControlEventTouchDown)
		arg_2_0.btnRecruit:addHandleOfControlEvent(function()
			arg_2_0:onRecruit()
		end, CCControlEventTouchDown)
		arg_2_0.btnRefuseAll:addHandleOfControlEvent(function()
			arg_2_0:onRefuseAll()
		end, CCControlEventTouchDown)

		arg_2_0.mainLayer = tolua.cast(arg_2_0.nodeLayer:getChildByTag(1), "CCLayer")
	end

	var_2_0()
	var_2_1()
end

function var_0_0.free(arg_8_0)
	return
end

function var_0_0.refresh(arg_9_0)
	g_WsMsgHandler:WS_Legion_GetApply_Req()
	arg_9_0:refreshReslut()
	arg_9_0:refreshSetInfo()

	local var_9_0 = g_Self.kLegionHandler:getOfficeById(g_GameData.BaseInfo.PlayerId)

	arg_9_0.btnSetLimit:setVisible(var_9_0 ~= ELegionOffice.Member)
	arg_9_0.btnRecruit:setVisible(var_9_0 ~= ELegionOffice.Member)
	arg_9_0.btnRefuseAll:setVisible(var_9_0 ~= ELegionOffice.Member)
end

function var_0_0.refreshSetInfo(arg_10_0)
	if g_Self.kLegionHandler.legionDetail and g_Self.kLegionHandler.legionDetail.LegionBaseInfo.Confirm == 1 then
		arg_10_0.applyLimit:setString(a2u("\xD0\xE8Ҫ\xC9\xEA\xC7\xEB"))
	else
		arg_10_0.applyLimit:setString(g_Self.kLegionHandler.legionDetail.LegionBaseInfo.LimitLvl .. a2u("\xBC\xB6\xD2\xD4\xC9\xCF"))
	end
end

function var_0_0.refreshReslut(arg_11_0)
	local var_11_0 = {}

	if LegionGetApplyAckData and zbUtil:isValidTable(LegionGetApplyAckData.LegionApply) then
		var_11_0 = LegionGetApplyAckData.LegionApply
	end

	arg_11_0.nodeLayer:setVisible(table.getn(var_11_0) > 0)
	arg_11_0:confirmCreateView(var_11_0)
	arg_11_0:refreshItems(var_11_0)
end

function var_0_0.confirmCreateView(arg_12_0, arg_12_1)
	if table.maxn(arg_12_0.items) == table.maxn(arg_12_1) then
		return
	end

	for iter_12_0, iter_12_1 in pairs(arg_12_0.items) do
		iter_12_1:removeFromParentAndCleanup(false)
	end

	arg_12_0.items = {}

	if arg_12_0.tableView ~= nil then
		arg_12_0.tableView:removeFromParentAndCleanup(true)

		arg_12_0.tableView = nil
		arg_12_0.tableViewHelper = nil
	end

	if arg_12_1 == nil then
		arg_12_1 = {}
	end

	local var_12_0 = table.maxn(arg_12_1)
	local var_12_1 = table.maxn(arg_12_0.items)
	local var_12_2 = arg_12_0.mainLayer:getContentSize()
	local var_12_3 = CCSizeMake(var_12_2.width, var_0_2 * var_12_0)
	local var_12_4 = CCSizeMake(var_12_2.width, var_12_2.height)

	arg_12_0.tableViewHelper = zbTableViewHelper:create()
	arg_12_0.tableView = zbTableViewHelper:createTableView(var_12_3, var_12_4, 1, arg_12_0.tableViewHelper)

	arg_12_0.tableView:setPosition(0, 0)
	arg_12_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_12_0.mainLayer:addChild(arg_12_0.tableView)

	if var_12_0 - var_12_1 > 0 then
		local var_12_5 = zbTableViewHelper:create()

		var_12_5:loadCCBFile("ccbi/tb_legionapplyitem.ccbi")

		for iter_12_2 = 1, var_12_0 - var_12_1 do
			local var_12_6 = createLegionApplyItem(translateAndStrokeHelper(var_12_5:readCCBNode()))

			var_12_6:retain()

			arg_12_0.items[var_12_1 + iter_12_2] = var_12_6
		end
	end

	local var_12_7 = 1

	for iter_12_3, iter_12_4 in pairs(arg_12_1) do
		local var_12_8 = arg_12_0.items[var_12_7]

		arg_12_0.tableViewHelper:addCell(var_12_8)

		var_12_7 = var_12_7 + 1
	end

	arg_12_0.tableViewHelper:refreshTabelView()

	if g_MainScene.wndLegionMem then
		arg_12_0.tableViewHelper:setTouchPriority(g_MainScene.wndLegionMem.btnClose:getTouchPriority())
	end
end

function var_0_0.refreshItems(arg_13_0, arg_13_1)
	local var_13_0 = 1

	for iter_13_0, iter_13_1 in pairs(arg_13_1) do
		arg_13_0.items[var_13_0]:refresh(iter_13_1)

		var_13_0 = var_13_0 + 1
	end
end

function var_0_0.onSetLimit(arg_14_0)
	g_MainScene:showLegionLimitSetWnd()
end

function var_0_0.onRecruit(arg_15_0)
	local var_15_0 = {}
	local var_15_1 = ""

	if g_Self.kLegionHandler.legionDetail then
		var_15_1 = a2u("\xA1\xBE") .. a2u(g_Self.kLegionHandler.legionDetail.LegionBaseInfo.LegionName) .. a2u("\xA1\xBF\xBB\xE1\xB9\xDD\xD5\xD0ļ\xB3\xC9Ա")
	end

	var_15_0.ChatType = EChatType.EWorld
	var_15_0.ChatMsg = a2u(var_15_1)
	var_15_0.SenderId = g_GameData.BaseInfo.PlayerId
	var_15_0.SenderName = a2u(g_Self:getName())
	var_15_0.SenderHeadId = g_GameData.BaseInfo.HeadId
	var_15_0.IsHorn = 0
	var_15_0.SenderLevel = g_Self:getLevel()
	var_15_0.TargetId = 0
	var_15_0.ChatTm = g_Self.kTimeHandler:getServerTime()
	var_15_0.LinkList = {}

	g_Self.kChatHandler:onNewChatNtf(var_15_0)
	g_WsMsgHandler:WS_Chat_SendReq(var_15_0)
	g_Bubble:bubbleInfo(a2u("\xD5\xD0ļ\xD0\xC5Ϣ\xB7\xA2\xCBͳɹ\xA6"))
end

function var_0_0.onRefuseAll(arg_16_0)
	g_WsMsgHandler:WS_LegionManage_ApplyRefuse_Req(0)
end
