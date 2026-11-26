require("gamelogic.zbGmActivityConsumItem")

local var_0_0 = 135
local var_0_1 = class("zbGmActivityWnd_RechargeDailySingle")

var_0_1.__index = var_0_1

function createGmActivityWnd_RechargeDailySingle(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = var_0_1.new()

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	return var_1_0
end

function var_0_1.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	(function()
		arg_2_0.nodeParent = arg_2_1
		arg_2_0.btnPriority = arg_2_2
		arg_2_0.rechargeDailySingleInfo = nil
		arg_2_0.items = {}
		arg_2_0.tableview = nil
		arg_2_0.tableviewHelper = nil
	end)()

	if zbUtil:isValidTable(g_GameData.ActivityGm.RechargeDailySingle) then
		for iter_2_0, iter_2_1 in pairs(g_GameData.ActivityGm.RechargeDailySingle) do
			if iter_2_0 == arg_2_3 + 1 - arg_2_4 then
				arg_2_0.rechargeDailySingleInfo = iter_2_1

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

		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/gmactivity_timeshop.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner", true)
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_4_0.lbTime = tolua.cast(var_5_2:getChildByTag(1001), "CCLabelTTF")
		arg_4_0.lbDesc = tolua.cast(var_5_2:getChildByTag(1002), "CCLabelTTF")
		arg_4_0.layerContent = tolua.cast(var_5_2:getChildByTag(1), "CCLayerColor")
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

	local var_4_1 = table.getn(arg_4_0.rechargeDailySingleInfo.RechargeList)
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

			var_4_4:loadCCBFile("ccbi/tb_gmactivity_consum.ccbi")

			local var_4_5 = createGmActivityConsumItem(translateAndStrokeHelper(var_4_4:readCCBNode()))

			var_4_5:retain()

			arg_4_0.items[var_4_2 + iter_4_1] = var_4_5

			arg_4_0.tableViewHelper:addCell(var_4_5)
			var_4_4:releaseSelf()
		end
	end

	local var_4_6 = 1

	for iter_4_2, iter_4_3 in pairs(arg_4_0.rechargeDailySingleInfo.RechargeList) do
		arg_4_0.items[var_4_6]:refresh(EGmActivityType.RechargeDailySingle, iter_4_3, arg_4_0.rechargeDailySingleInfo.ActId)

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
	if arg_8_0.rechargeDailySingleInfo == nil then
		return
	end

	arg_8_0.rechargeDailySingleInfo = g_Self.kGmActivityHandler:getRechargeDailySingleInfoByActId(arg_8_0.rechargeDailySingleInfo.ActId)

	if arg_8_0.rechargeDailySingleInfo == nil then
		return
	end

	if arg_8_0.tableView == nil then
		arg_8_0:confirmCreateView()
	end

	local var_8_0 = 1

	for iter_8_0, iter_8_1 in pairs(arg_8_0.rechargeDailySingleInfo.RechargeList) do
		arg_8_0.items[var_8_0]:refresh(EGmActivityType.RechargeDailySingle, iter_8_1, arg_8_0.rechargeDailySingleInfo.ActId)

		var_8_0 = var_8_0 + 1
	end

	local var_8_1 = 1

	for iter_8_2, iter_8_3 in pairs(arg_8_0.rechargeDailySingleInfo.RechargeList) do
		if iter_8_3.State == 1 then
			var_8_1 = iter_8_2

			break
		end
	end

	zbUtil:setTableViewOffset(arg_8_0.tableViewHelper, kCCScrollViewDirectionVertical, kCCTableViewFillTopDown, 3, table.getn(arg_8_0.rechargeDailySingleInfo.RechargeList), var_0_0, var_8_1)
	arg_8_0.lbTime:setString(a2u(zbUtil:SprintfMMDDCh(arg_8_0.rechargeDailySingleInfo.GmBaseInfo.ActStart)) .. a2u(zbUtil:SprintfHHCh(arg_8_0.rechargeDailySingleInfo.GmBaseInfo.ActStart)) .. " - " .. a2u(zbUtil:SprintfMMDDCh(arg_8_0.rechargeDailySingleInfo.GmBaseInfo.ActEnd)) .. a2u(zbUtil:SprintfHHCh(arg_8_0.rechargeDailySingleInfo.GmBaseInfo.ActEnd)))
	arg_8_0.lbDesc:setString(arg_8_0.rechargeDailySingleInfo.GmBaseInfo.Content)
end
