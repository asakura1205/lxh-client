require("gamelogic.zbActivityAccumLine")

zbActivityWnd_Upgrade = class("zbActivityWnd_Upgrade")
zbActivityWnd_Upgrade.__index = zbActivityWnd_Upgrade

function zbActivityWnd_Upgrade.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbActivityWnd_Upgrade)

	return arg_1_0
end

function zbActivityWnd_Upgrade.create(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = zbActivityWnd_Upgrade.new()

	var_2_0:init(arg_2_1, arg_2_2)

	return var_2_0
end

function zbActivityWnd_Upgrade.init(arg_3_0, arg_3_1, arg_3_2)
	(function()
		arg_3_0.items = {}
		arg_3_0.tableView = nil
		arg_3_0.tableViewHelper = nil
		arg_3_0.nodeParent = arg_3_1
		arg_3_0.btnPriority = arg_3_2
	end)()
end

function zbActivityWnd_Upgrade.initUpgradeList(arg_5_0)
	(function()
		if arg_5_0.node ~= nil then
			return
		end

		local var_6_0 = CCBProxy:create()
		local var_6_1 = CCBReaderLoad("ccbi/activity_upgrade.ccbi", var_6_0, true, "HelloCocosBuilderLayerOwner", true)
		local var_6_2 = tolua.cast(var_6_1:getChildByTag(1), "CCNode")

		arg_5_0.layerContent = tolua.cast(var_6_2:getChildByTag(2), "CCLayerColor")
		arg_5_0.node = var_6_1

		arg_5_0.nodeParent:addChild(var_6_1)
	end)()

	if arg_5_0.tableViewHelper ~= nil and arg_5_0.tableViewHelper.clearLuaEnterHandler ~= nil then
		arg_5_0.tableViewHelper:clearLuaEnterHandler()
	end

	if arg_5_0.tableView == nil then
		local var_5_0 = arg_5_0.layerContent:getContentSize()

		arg_5_0.tableViewHelper = zbTableViewHelper:create()
		arg_5_0.tableView = zbTableViewHelper:createTableView(var_5_0, var_5_0, 1, arg_5_0.tableViewHelper)

		arg_5_0.tableView:setPosition(0, 0)
		arg_5_0.tableView:setAnchorPoint(ccp(0, 0))
		arg_5_0.layerContent:addChild(arg_5_0.tableView)
	else
		arg_5_0.tableViewHelper:removeAllCells()
	end

	local var_5_1 = zbActCrazyUpgradeTable.number
	local var_5_2 = table.getn(arg_5_0.items)

	for iter_5_0 = 1, var_5_2 do
		if iter_5_0 <= var_5_1 then
			local var_5_3 = arg_5_0.items[iter_5_0]

			arg_5_0.tableViewHelper:addCell(var_5_3)
		end
	end

	if var_5_1 - var_5_2 > 0 then
		for iter_5_1 = 1, var_5_1 - var_5_2 do
			local var_5_4 = createActivityAccumLine(EActivityType.Upgrade, iter_5_1)

			var_5_4:retain()

			arg_5_0.items[var_5_2 + iter_5_1] = var_5_4

			arg_5_0.tableViewHelper:addCell(var_5_4)
		end
	end

	local var_5_5 = 1

	for iter_5_2, iter_5_3 in pairs(zbActCrazyUpgradeTable.records) do
		local var_5_6 = arg_5_0.items[var_5_5]

		if var_5_6 ~= nil then
			var_5_6:refreshUpgrade(iter_5_3)
		end

		var_5_5 = var_5_5 + 1
	end

	arg_5_0.tableViewHelper:refreshTabelView()
	arg_5_0.tableViewHelper:setTouchPriority(arg_5_0.btnPriority:getTouchPriority())

	if arg_5_0.tableViewHelper.SetLuaEnterHandler ~= nil then
		arg_5_0.tableViewHelper:SetLuaEnterHandler(function()
			arg_5_0:onTBNotifyEnter()
		end)
	end
end

function zbActivityWnd_Upgrade.onTBNotifyEnter(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.items) do
		iter_8_1:refreshScorllEffect()
	end
end

function zbActivityWnd_Upgrade.refresh(arg_9_0)
	if zbUtil:isValidTable(g_GameData.ActivityAct) == false or zbUtil:isValidTable(g_GameData.ActivityAct.CrazyUpgrade) == false then
		return
	end

	if arg_9_0.tableView == nil then
		arg_9_0:initUpgradeList()
	end

	local var_9_0 = 1

	for iter_9_0, iter_9_1 in pairs(zbActCrazyUpgradeTable.records) do
		local var_9_1 = arg_9_0.items[var_9_0]

		if var_9_1 ~= nil then
			var_9_1:refreshUpgradeState(iter_9_1)
		end

		var_9_0 = var_9_0 + 1
	end

	local var_9_2 = table.getn(g_GameData.ActivityAct.CrazyUpgrade)

	zbUtil:setTableViewOffset(arg_9_0.tableViewHelper, kCCScrollViewDirectionVertical, kCCTableViewFillTopDown, 4, zbActCrazyUpgradeTable.number, 110, var_9_2 + 1)
end
