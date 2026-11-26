require("gamelogic.zbSevenItem")

local var_0_0 = class("zbSevenWnd_Charge")

var_0_0.__index = var_0_0

function createSevenWnd_Charge(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	(function()
		arg_2_0.items = {}
		arg_2_0.tableView = nil
		arg_2_0.tableViewHelper = nil
		arg_2_0.nodeParent = arg_2_1
		arg_2_0.btnPriority = arg_2_2
	end)()
end

function var_0_0.initItemList(arg_4_0)
	(function()
		if arg_4_0.node ~= nil then
			return
		end

		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/seven_charge.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner", true)
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_4_0.lbTime = tolua.cast(var_5_2:getChildByTag(1), "CCLabelTTF")

		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1002), "CCLabelTTF")

		arg_4_0.layerContent = tolua.cast(var_5_2:getChildByTag(3), "CCLayerColor")
		arg_4_0.lbMoney = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_3, arg_4_0.lbMoney)
		arg_4_0.lbMoney:setScale(0.6)

		arg_4_0.node = var_5_1

		arg_4_0.nodeParent:addChild(var_5_1)
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

	local var_4_1 = table.getn(g_GameData.ActivityOs.RechargeAward)
	local var_4_2 = table.getn(arg_4_0.items)

	for iter_4_0 = 1, var_4_2 do
		if iter_4_0 <= var_4_1 then
			local var_4_3 = arg_4_0.items[iter_4_0]

			arg_4_0.tableViewHelper:addCell(var_4_3)
		end
	end

	if var_4_1 - var_4_2 > 0 then
		for iter_4_1 = 1, var_4_1 - var_4_2 do
			local var_4_4 = createSevenItem(ESevenType.Charge)

			var_4_4:retain()

			arg_4_0.items[var_4_2 + iter_4_1] = var_4_4

			arg_4_0.tableViewHelper:addCell(var_4_4)
		end
	end

	local var_4_5 = 1

	for iter_4_2, iter_4_3 in pairs(g_GameData.ActivityOs.RechargeAward) do
		arg_4_0.items[var_4_5]:refresh(iter_4_3)

		var_4_5 = var_4_5 + 1
	end

	arg_4_0.tableViewHelper:refreshTabelView()
	arg_4_0.tableViewHelper:setTouchPriority(arg_4_0.btnPriority:getTouchPriority())

	if arg_4_0.tableViewHelper.SetLuaEnterHandler ~= nil then
		arg_4_0.tableViewHelper:SetLuaEnterHandler(function()
			arg_4_0:onTBNotifyEnter()
		end)
	end
end

function var_0_0.onTBNotifyEnter(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.items) do
		iter_7_1:refreshScorllEffect()
	end
end

function var_0_0.refresh(arg_8_0)
	if zbUtil:isValidTable(g_GameData.ActivityOs) == false or zbUtil:isValidTable(g_GameData.ActivityOs.RechargeAward) == false then
		return
	end

	if arg_8_0.tableView == nil then
		arg_8_0:initItemList()
	end

	local var_8_0 = 1

	for iter_8_0, iter_8_1 in pairs(g_GameData.ActivityOs.RechargeAward) do
		arg_8_0.items[var_8_0]:refreshState(iter_8_1)

		var_8_0 = var_8_0 + 1
	end

	local var_8_1 = 1

	for iter_8_2, iter_8_3 in pairs(g_GameData.ActivityOs.RechargeAward) do
		if iter_8_3.State == 1 then
			var_8_1 = iter_8_2

			break
		end
	end

	zbUtil:setTableViewOffset(arg_8_0.tableViewHelper, kCCScrollViewDirectionVertical, kCCTableViewFillTopDown, 4, table.getn(g_GameData.ActivityOs.RechargeAward), 110, var_8_1)

	if g_GameData.ActivityOs.OsBaseInfo.Recharge then
		arg_8_0.lbMoney:setString(g_GameData.ActivityOs.OsBaseInfo.Recharge)
	end
end

function var_0_0.onFrame(arg_9_0)
	if g_Self.kSevenHandler:getSevenLessTime() == 0 then
		arg_9_0.lbTime:setString(a2u("\xBB\xD2ѽ\xE1\xCA\xF8"))
	elseif g_Self.kSevenHandler:getSevenLessTime() < 86400 then
		arg_9_0.lbTime:setString(zbUtil:SprintfHHMMSSNo24(g_Self.kSevenHandler:getSevenLessTime()))
	else
		arg_9_0.lbTime:setString(zbUtil:getPassTime2(g_Self.kSevenHandler:getSevenLessTime()))
	end
end
