require("gamelogic.zbGmActivityExchangeItem")
require("gamelogic.zbItem")

local var_0_0 = 135
local var_0_1 = class("zbGmActivityWnd_Exchange")

var_0_1.__index = var_0_1

function createGmActivityWnd_Exchange(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = var_0_1.new()

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	return var_1_0
end

function var_0_1.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	(function()
		arg_2_0.nodeParent = arg_2_1
		arg_2_0.btnPriority = arg_2_2
		arg_2_0.exchangeInfo = nil
		arg_2_0.exItem = nil
		arg_2_0.items = {}
		arg_2_0.tableview = nil
		arg_2_0.tableviewHelper = nil
	end)()

	if zbUtil:isValidTable(g_GameData.ActivityGm.ItemExchange) then
		for iter_2_0, iter_2_1 in pairs(g_GameData.ActivityGm.ItemExchange) do
			if iter_2_0 == arg_2_3 + 1 - arg_2_4 then
				arg_2_0.exchangeInfo = iter_2_1

				break
			end
		end
	end
end

function var_0_1.confirmCreateView(arg_4_0)
	(function()
		if arg_4_0.node ~= nil then
			return
		end

		CCLabelTTF:beginDelayCreateTexture()

		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/gmactivity_exchange.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner", true)
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_4_0.lbTime = tolua.cast(var_5_2:getChildByTag(1001), "CCLabelTTF")
		arg_4_0.lbDesc = tolua.cast(var_5_2:getChildByTag(1002), "CCLabelTTF")
		arg_4_0.lbName = tolua.cast(var_5_2:getChildByTag(1), "CCLabelTTF")

		local var_5_3 = tolua.cast(var_5_2:getChildByTag(2), "CCLayerColor")
		local var_5_4 = createItem()

		var_5_4:setPosition(var_5_3:getPosition())
		var_5_4:setScale(0.4)

		arg_4_0.exItem = var_5_4

		var_5_2:addChild(arg_4_0.exItem)
		var_5_3:removeFromParentAndCleanup(true)

		local var_5_5 = tolua.cast(var_5_2:getChildByTag(1003), "CCLabelTTF")

		arg_4_0.lbCount = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_5, arg_4_0.lbCount)
		arg_4_0.lbCount:setScale(0.65)

		arg_4_0.layerContent = tolua.cast(var_5_2:getChildByTag(4), "CCLayerColor")
		arg_4_0.node = var_5_1

		arg_4_0.nodeParent:addChild(var_5_1)
		CCLabelTTF:endDelayCreateTexture(var_5_1)
	end)()

	if arg_4_0.tableViewHelper ~= nil and arg_4_0.tableViewHelper.clearLuaEnterHandler ~= nil then
		arg_4_0.tableViewHelper:clearLuaEnterHandler()
	end

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

	local var_4_1 = table.getn(arg_4_0.exchangeInfo.ExchangeList)
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

			var_4_4:loadCCBFile("ccbi/tb_gmactivity_exchange.ccbi")

			local var_4_5 = createGmActivityExchangeItem(translateAndStrokeHelper(var_4_4:readCCBNode()))

			var_4_5:retain()

			arg_4_0.items[var_4_2 + iter_4_1] = var_4_5

			arg_4_0.tableViewHelper:addCell(var_4_5)
			var_4_4:releaseSelf()
		end
	end

	local var_4_6 = 1

	for iter_4_2, iter_4_3 in pairs(arg_4_0.exchangeInfo.ExchangeList) do
		arg_4_0.items[var_4_6]:refresh(iter_4_3, arg_4_0.exchangeInfo.ActId, arg_4_0.exchangeInfo.TemplateId)

		var_4_6 = var_4_6 + 1
	end

	arg_4_0.tableViewHelper:refreshTabelView()
	arg_4_0.tableViewHelper:setTouchPriority(arg_4_0.btnPriority:getTouchPriority())

	if arg_4_0.tableViewHelper.SetLuaEnterHandler ~= nil then
		arg_4_0.tableViewHelper:SetLuaEnterHandler(function()
			arg_4_0:onTBNotifyEnter()
		end)
	end
end

function var_0_1.onTBNotifyEnter(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.items) do
		iter_7_1:refreshScorllEffect()
	end
end

function var_0_1.refresh(arg_8_0)
	if arg_8_0.exchangeInfo == nil then
		return
	end

	arg_8_0.exchangeInfo = g_Self.kGmActivityHandler:getExchangeInfoByActId(arg_8_0.exchangeInfo.ActId)

	if arg_8_0.exchangeInfo == nil then
		return
	end

	if arg_8_0.tableView == nil then
		arg_8_0:confirmCreateView()
	end

	local var_8_0 = 1

	for iter_8_0, iter_8_1 in pairs(arg_8_0.exchangeInfo.ExchangeList) do
		arg_8_0.items[var_8_0]:refresh(iter_8_1, arg_8_0.exchangeInfo.ActId, arg_8_0.exchangeInfo.TemplateId)

		var_8_0 = var_8_0 + 1
	end

	zbUtil:setTableViewOffset(arg_8_0.tableViewHelper, kCCScrollViewDirectionVertical, kCCTableViewFillTopDown, 3, table.getn(arg_8_0.exchangeInfo.ExchangeList), var_0_0, 1)
	arg_8_0.lbTime:setString(a2u(zbUtil:SprintfMMDDCh(arg_8_0.exchangeInfo.GmBaseInfo.ActStart)) .. a2u(zbUtil:SprintfHHCh(arg_8_0.exchangeInfo.GmBaseInfo.ActStart)) .. " - " .. a2u(zbUtil:SprintfMMDDCh(arg_8_0.exchangeInfo.GmBaseInfo.ActEnd)) .. a2u(zbUtil:SprintfHHCh(arg_8_0.exchangeInfo.GmBaseInfo.ActEnd)))
	arg_8_0.lbDesc:setString(arg_8_0.exchangeInfo.GmBaseInfo.Content)

	local var_8_1, var_8_2 = zbIconHelper:getAwardIconPath(ECommonAwardType.Item, arg_8_0.exchangeInfo.TemplateId)

	arg_8_0.lbName:setString(var_8_2 .. a2u("\xB6һ\xBB\xB5\xC0\xBE\xDF:"))
	arg_8_0.lbCount:setString(g_Self.kBagItemHandler:getItemCountByTemplateId(arg_8_0.exchangeInfo.TemplateId))
	arg_8_0.exItem:refreshAward(ECommonAwardType.Item, arg_8_0.exchangeInfo.TemplateId, 0, false, false)
end
