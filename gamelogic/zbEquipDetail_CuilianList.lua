require("gamelogic.zbBaseWnd")
require("gamelogic.zbEquipDetail_CuilianCard")

local var_0_0 = class("zbEquipDetail_CuilianList")

var_0_0.__index = var_0_0

local var_0_1 = 5
local var_0_2 = 124
local var_0_3 = 120

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	local function var_1_0()
		arg_1_0.lines = {}
		arg_1_0.items = {}
		arg_1_0.tabType = arg_1_2
		arg_1_0.tableView = nil
		arg_1_0.tableViewHelper = nil
	end

	local function var_1_1()
		arg_1_0.layer = arg_1_1
	end

	var_1_0()
	var_1_1()
end

function var_0_0.free(arg_4_0)
	return
end

function var_0_0.refresh(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.lines) do
		iter_5_1:removeFromParentAndCleanup(false)
	end

	if arg_5_0.tableView ~= nil then
		arg_5_0.tableView:removeFromParentAndCleanup(true)

		arg_5_0.tableView = nil
		arg_5_0.tableViewHelper = nil
	end

	local var_5_0 = arg_5_0.layer:getContentSize()

	arg_5_0.tableViewHelper = zbTableViewHelper:create()
	arg_5_0.tableView = zbTableViewHelper:createTableView(var_5_0, var_5_0, 1, arg_5_0.tableViewHelper)

	arg_5_0.tableView:setPosition(0, 0)
	arg_5_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_5_0.tableViewHelper:createListView("ccbi/tb_line.ccbi")
	arg_5_0.layer:addChild(arg_5_0.tableView)

	local var_5_1 = arg_5_0:getBagByType()
	local var_5_2 = math.ceil(table.getn(var_5_1) / var_0_1)
	local var_5_3 = table.getn(arg_5_0.lines)

	for iter_5_2 = 1, var_5_3 do
		if iter_5_2 <= var_5_2 then
			local var_5_4 = arg_5_0.lines[iter_5_2]

			arg_5_0.tableViewHelper:addCell(var_5_4)
		end
	end

	if var_5_2 - var_5_3 > 0 then
		for iter_5_3 = 1, var_5_2 - var_5_3 do
			local var_5_5 = arg_5_0.tableViewHelper:addListItem()

			var_5_5:setAnchorPoint(ccp(0, 0))
			var_5_5:setContentSize(CCSizeMake(var_0_2 * var_0_1, var_0_3))

			arg_5_0.lines[var_5_3 + iter_5_3] = var_5_5

			for iter_5_4 = 1, var_0_1 do
				local var_5_6 = zbTableViewHelper:create()

				var_5_6:loadCCBFile("ccbi/equipcheck_card.ccbi")

				local var_5_7 = createEquipCuilianCard(translateAndStrokeHelper(var_5_6:readCCBNode()), arg_5_0.itemType)

				var_5_7:setAnchorPoint(ccp(0, 0))
				var_5_7:setPosition((iter_5_4 - 1) * var_0_2, 0)
				var_5_5:addChild(var_5_7)

				arg_5_0.items[(var_5_3 + iter_5_3 - 1) * var_0_1 + iter_5_4] = var_5_7

				var_5_6:releaseSelf()
			end
		end
	end

	local var_5_8 = 1

	for iter_5_5, iter_5_6 in pairs(var_5_1) do
		arg_5_0.items[var_5_8]:refresh(iter_5_6)

		var_5_8 = var_5_8 + 1
	end

	local var_5_9 = table.getn(arg_5_0.items)

	for iter_5_7 = var_5_8, var_5_9 do
		arg_5_0.items[iter_5_7]:refresh(nil)
	end

	arg_5_0.tableViewHelper:refreshTabelView()

	if g_MainScene.wndEquipCuilianSelect then
		arg_5_0.tableViewHelper:setTouchPriority(g_MainScene.wndEquipCuilianSelect.btnClose:getTouchPriority())
	end
end

function var_0_0.frame(arg_6_0)
	return
end

function var_0_0.getBagByType(arg_7_0)
	local var_7_0 = {}
	local var_7_1 = g_GameData.BagEquipList
	local var_7_2 = g_GameData.EquipFragList

	if arg_7_0.tabType == EDecomposeBagTab.Equip then
		for iter_7_0, iter_7_1 in pairs(var_7_1) do
			if g_MainScene.wndEquipDetail.module[EEquipForgeTab.Cuilian].equip.EquipId ~= iter_7_1.EquipId then
				local var_7_3 = {
					equip = iter_7_1
				}

				var_7_3.isFrag = false
				var_7_3.count = 1

				table.insert(var_7_0, var_7_3)
			end
		end
	elseif arg_7_0.tabType == EDecomposeBagTab.EquipFrag then
		for iter_7_2, iter_7_3 in pairs(var_7_2) do
			local var_7_4 = {
				equip = iter_7_3
			}

			var_7_4.isFrag = true
			var_7_4.count = iter_7_3.Count

			table.insert(var_7_0, var_7_4)
		end
	end

	return var_7_0
end

function createEquipCuilianList(arg_8_0, arg_8_1)
	local var_8_0 = var_0_0.new()

	var_8_0:init(arg_8_0, arg_8_1)

	return var_8_0
end
