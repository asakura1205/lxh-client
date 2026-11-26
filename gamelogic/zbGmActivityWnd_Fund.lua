require("gamelogic.zbGmActivityFundItem")

local var_0_0 = 105
local var_0_1 = class("zbGmActivityWnd_Fund")

var_0_1.__index = var_0_1

function createGmActivityWnd_Fund(arg_1_0, arg_1_1)
	local var_1_0 = var_0_1.new()

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_1.init(arg_2_0, arg_2_1, arg_2_2)
	(function()
		arg_2_0.nodeParent = arg_2_1
		arg_2_0.btnPriority = arg_2_2
		arg_2_0.items = {}
		arg_2_0.tableview = nil
		arg_2_0.tableviewHelper = nil
	end)()
end

function var_0_1.confirmCreateView(arg_4_0)
	(function()
		if arg_4_0.node ~= nil then
			return
		end

		CCLabelTTF:beginDelayCreateTexture()

		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/gmactivity_fund.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner", true)
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_4_0.lbTime = tolua.cast(var_5_2:getChildByTag(1001), "CCLabelTTF")
		arg_4_0.lbDesc = tolua.cast(var_5_2:getChildByTag(1002), "CCLabelTTF")

		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1003), "CCLabelTTF")

		arg_4_0.btnBuy = tolua.cast(var_5_2:getChildByTag(2), "CCControlButton")
		arg_4_0.layerContent = tolua.cast(var_5_2:getChildByTag(3), "CCLayerColor")
		arg_4_0.lbVip = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_3, arg_4_0.lbVip)
		arg_4_0.lbVip:setScale(0.55)
		arg_4_0.btnBuy:addHandleOfControlEvent(function()
			arg_4_0:onBuy()
		end, CCControlEventTouchUpInside)
		arg_4_0.btnBuy:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_4_0.btnBuy:setSwallowsTouches(false)
		arg_4_0.btnBuy:setTouchPriority(arg_4_0.btnPriority:getTouchPriority())

		arg_4_0.node = var_5_1

		arg_4_0.nodeParent:addChild(var_5_1)
		CCLabelTTF:endDelayCreateTexture(var_5_1)
	end)()

	if arg_4_0.tableView == nil then
		local var_4_0 = arg_4_0.layerContent:getContentSize()

		arg_4_0.tableViewHelper = zbTableViewHelper:create()
		arg_4_0.tableView = zbTableViewHelper:createTableView(var_4_0, var_4_0, 1, arg_4_0.tableViewHelper)

		arg_4_0.tableView:setPosition(0, 0)
		arg_4_0.tableView:setAnchorPoint(ccp(0, 0))
		arg_4_0.layerContent:addChild(arg_4_0.tableView)
	else
		arg_4_0.tableViewHelper:removeAllCells()
	end

	local var_4_1 = table.getn(g_GameData.ActivityGm.Fund.IncomeList)
	local var_4_2 = table.getn(arg_4_0.items)

	for iter_4_0 = 1, var_4_2 do
		if iter_4_0 <= var_4_1 then
			local var_4_3 = arg_4_0.items[iter_4_0]

			arg_4_0.tableViewHelper:addCell(var_4_3)
		end
	end

	if var_4_1 - var_4_2 > 0 then
		for iter_4_1 = 1, var_4_1 - var_4_2 do
			local var_4_4 = zbTableViewHelper:create()

			var_4_4:loadCCBFile("ccbi/tb_gmactivity_fund.ccbi")

			local var_4_5 = createGmActivityFundItem(translateAndStrokeHelper(var_4_4:readCCBNode()))

			var_4_5:retain()

			arg_4_0.items[var_4_2 + iter_4_1] = var_4_5

			arg_4_0.tableViewHelper:addCell(var_4_5)
			var_4_4:releaseSelf()
		end
	end

	local var_4_6 = 1

	for iter_4_2, iter_4_3 in pairs(g_GameData.ActivityGm.Fund.IncomeList) do
		arg_4_0.items[var_4_6]:refresh(iter_4_3, g_GameData.ActivityGm.Fund.BuyState)

		var_4_6 = var_4_6 + 1
	end
end

function var_0_1.refresh(arg_7_0)
	if zbUtil:isValidTable(g_GameData.ActivityGm.Fund) == false then
		return
	end

	if arg_7_0.tableView == nil then
		arg_7_0:confirmCreateView()
	end

	local var_7_0 = 1

	for iter_7_0, iter_7_1 in pairs(g_GameData.ActivityGm.Fund.IncomeList) do
		arg_7_0.items[var_7_0]:refresh(iter_7_1, g_GameData.ActivityGm.Fund.BuyState)

		var_7_0 = var_7_0 + 1
	end

	arg_7_0.tableViewHelper:refreshTabelView()
	arg_7_0.tableViewHelper:setTouchPriority(arg_7_0.btnPriority:getTouchPriority())

	local var_7_1 = 1

	for iter_7_2, iter_7_3 in pairs(g_GameData.ActivityGm.Fund.IncomeList) do
		if iter_7_3.State == 0 and g_Self:getLevel() >= iter_7_3.Level then
			var_7_1 = iter_7_2

			break
		end
	end

	zbUtil:setTableViewOffset(arg_7_0.tableViewHelper, kCCScrollViewDirectionVertical, kCCTableViewFillTopDown, 3, table.getn(g_GameData.ActivityGm.Fund.IncomeList), var_0_0, var_7_1)

	if g_GameData.ActivityGm.Fund.GmBaseInfo.ActStart == 0 and g_GameData.ActivityGm.Fund.GmBaseInfo.ActEnd == 0 then
		arg_7_0.lbTime:setString(a2u("\xD3\xC0\xBE\xC3"))
	else
		arg_7_0.lbTime:setString(a2u(zbUtil:SprintfMMDDCh(g_GameData.ActivityGm.Fund.GmBaseInfo.ActStart)) .. a2u(zbUtil:SprintfHHCh(g_GameData.ActivityGm.Fund.GmBaseInfo.ActStart)) .. " - " .. a2u(zbUtil:SprintfMMDDCh(g_GameData.ActivityGm.Fund.GmBaseInfo.ActEnd)) .. a2u(zbUtil:SprintfHHCh(g_GameData.ActivityGm.Fund.GmBaseInfo.ActEnd)))
	end

	arg_7_0.lbDesc:setString(g_GameData.ActivityGm.Fund.GmBaseInfo.Content)
	arg_7_0.lbVip:setString(g_Self:getVipLevel())
	arg_7_0.btnBuy:setVisible(g_GameData.ActivityGm.Fund.BuyState ~= 1)
end

function var_0_1.onBuy(arg_8_0)
	if g_Self:getVipLevel() < g_GameData.ActivityGm.Fund.NeedVip then
		g_Bubble:bubbleInfo(a2u("VIP") .. g_GameData.ActivityGm.Fund.NeedVip .. a2u("\xBC\xB0\xD2\xD4\xC9Ͽ\xC9\xD2Թ\xBA\xC2\xF2\xA3\xA1"))

		return
	end

	if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Diamond, g_GameData.ActivityGm.Fund.DiamondCost) == false then
		g_Bubble:bubbleInfo(a2u("\xD7\xEAʯ\xB2\xBB\xD7\xE3"))

		return
	end

	g_WsMsgHandler:WS_ActivityGm_FundBuy_Req()
end
