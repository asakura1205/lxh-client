require("gamelogic.zbBaseWnd")
require("gamelogic.zbEquipSelectItem")
require("gamelogic.zbEquipSelectedItemDetail")

zbEquipSelectWnd = class("zbEquipSelectWnd", zbBaseWnd)
zbEquipSelectWnd.__index = zbEquipSelectWnd

local var_0_0 = 5
local var_0_1 = 120
local var_0_2 = 150

function zbEquipSelectWnd.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbEquipSelectWnd)

	return arg_1_0
end

function createEquipSelectWnd()
	local var_2_0 = zbEquipSelectWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function zbEquipSelectWnd.init(arg_3_0)
	local function var_3_0()
		arg_3_0.tableview = nil
		arg_3_0.tableviewHelper = nil
		arg_3_0.heroTemplateId = -1
		arg_3_0.ItemSubType = -1
		arg_3_0.listEquip = {}
		arg_3_0.lines = {}
		arg_3_0.items = {}
		arg_3_0.hero = nil
		arg_3_0.itemdata = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/hero_equipselect.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCNode")
		local var_5_4 = tolua.cast(var_5_2:getChildByTag(4), "CCNode")

		arg_3_0.layerContent = tolua.cast(var_5_3:getChildByTag(11), "CCNode")
		arg_3_0.panelDetail = createSelectedItemDetail(var_5_4)

		arg_3_0:addChild(var_5_1)
		arg_3_0:createMoneyPanel(var_5_1, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold,
			EMoneyPanelResType.SkillBook
		}, function()
			arg_3_0:hide()
		end)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setHideCallback(function()
		arg_3_0:onHideCallback()
	end)
end

function zbEquipSelectWnd.onHideCallback(arg_8_0)
	arg_8_0.itemdata = nil
end

function zbEquipSelectWnd.refresh(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.heroTemplateId = arg_9_1
	arg_9_0.ItemSubType = arg_9_2

	arg_9_0:refreshList()
end

function zbEquipSelectWnd.doDestroy(arg_10_0)
	if arg_10_0.panelDetail then
		arg_10_0.panelDetail:doFree()
	end
end

function zbEquipSelectWnd.refreshList(arg_11_0)
	if arg_11_0.tableView == nil then
		local var_11_0 = arg_11_0.layerContent:getContentSize()

		arg_11_0.tableViewHelper = zbTableViewHelper:create()
		arg_11_0.tableView = zbTableViewHelper:createTableView(var_11_0, var_11_0, 1, arg_11_0.tableViewHelper)

		arg_11_0.tableView:setPosition(0, 0)
		arg_11_0.tableView:setAnchorPoint(ccp(0, 0))
		arg_11_0.tableViewHelper:createListView("ccbi/tb_line.ccbi")
		arg_11_0.layerContent:addChild(arg_11_0.tableView)
	else
		arg_11_0.tableViewHelper:removeAllCells()
	end

	arg_11_0.listEquip, lineSperatorIndex = arg_11_0:getEquipList()

	local var_11_1 = table.getn(arg_11_0.listEquip)
	local var_11_2 = math.ceil(var_11_1 / var_0_0)
	local var_11_3 = table.getn(arg_11_0.lines)

	for iter_11_0 = 1, var_11_3 do
		if iter_11_0 <= var_11_2 then
			local var_11_4 = arg_11_0.lines[iter_11_0]

			arg_11_0.tableViewHelper:addCell(var_11_4)
		end
	end

	if var_11_2 - var_11_3 > 0 then
		for iter_11_1 = 1, var_11_2 - var_11_3 do
			local var_11_5 = arg_11_0.tableViewHelper:addListItem()

			var_11_5:setAnchorPoint(ccp(0, 0))
			var_11_5:setContentSize(CCSizeMake(var_0_1 * var_0_0, var_0_2))

			arg_11_0.lines[var_11_3 + iter_11_1] = var_11_5

			for iter_11_2 = 1, var_0_0 do
				local var_11_6 = zbTableViewHelper:create()

				var_11_6:loadCCBFile("ccbi/tb_equipitemcard.ccbi")

				local var_11_7 = zbEquipSelectItem:create(translateAndStrokeHelper(var_11_6:readCCBNode()), arg_11_0)

				var_11_7:setAnchorPoint(ccp(0, 0))
				var_11_7:setPosition((iter_11_2 - 1) * var_0_1, 0)
				var_11_5:addChild(var_11_7)

				arg_11_0.items[(var_11_3 + iter_11_1 - 1) * var_0_0 + iter_11_2] = var_11_7

				var_11_6:releaseSelf()
			end
		end
	end

	local var_11_8 = 1

	for iter_11_3, iter_11_4 in pairs(arg_11_0.lines) do
		if var_11_8 == lineSperatorIndex then
			iter_11_4:setContentSize(CCSizeMake(var_0_1 * var_0_0, 5))
		else
			iter_11_4:setContentSize(CCSizeMake(var_0_1 * var_0_0, var_0_2))
		end

		var_11_8 = var_11_8 + 1
	end

	local var_11_9 = 1

	for iter_11_5, iter_11_6 in pairs(arg_11_0.listEquip) do
		arg_11_0.items[var_11_9]:refreshData(arg_11_0.heroTemplateId, iter_11_6)

		var_11_9 = var_11_9 + 1

		if iter_11_6.isEmpty == false and arg_11_0.itemdata == nil then
			arg_11_0.itemdata = iter_11_6
		end
	end

	if arg_11_0.itemdata then
		if arg_11_0.itemdata.equip ~= nil then
			arg_11_0:refreshExistSelectItem(arg_11_0.itemdata.equip.EquipId)
			arg_11_0.panelDetail:refreshByEquip(arg_11_0.heroTemplateId, arg_11_0.itemdata.equip)
		else
			arg_11_0:refreshNonExistSelectItem(arg_11_0.itemdata.templateId)
			arg_11_0.panelDetail:refreshByEquipId(arg_11_0.heroTemplateId, arg_11_0.itemdata.templateId)
		end
	end

	arg_11_0.tableViewHelper:refreshTabelView()
	arg_11_0.tableViewHelper:setTouchPriority(arg_11_0.moneyPanel.btnClose:getTouchPriority())
end

function zbEquipSelectWnd.getEquipList(arg_12_0)
	local var_12_0 = {}
	local var_12_1 = 0
	local var_12_2 = zbHeroTable:getRecord(arg_12_0.heroTemplateId)

	if var_12_2 == nil then
		echoInfo("error hero template id: " .. arg_12_0.heroTemplateId)

		return
	end

	local var_12_3 = -1

	if var_12_2.attackType == EAttackType.Physic then
		var_12_3 = EAttrType.MagicAttack
	else
		var_12_3 = EAttrType.PhysicAttack
	end

	local var_12_4 = g_Self.kBagEquipHandler:getBagEquipByPos(arg_12_0.ItemSubType, var_12_3)
	local var_12_5, var_12_6 = zbItemTable:getNeedShowEquipList(arg_12_0.ItemSubType, var_12_3)

	for iter_12_0, iter_12_1 in pairs(var_12_4) do
		local var_12_7 = {
			equip = iter_12_1
		}

		var_12_7.isEmpty = false
		var_12_7.templateId = -1

		table.insert(var_12_0, var_12_7)
	end

	while table.getn(var_12_0) % var_0_0 ~= 0 do
		local var_12_8 = {}

		var_12_8.isEmpty = true

		table.insert(var_12_0, var_12_8)
	end

	local var_12_9 = table.getn(var_12_0) / var_0_0 + 1
	local var_12_10 = {}

	var_12_10.isSpeartor = true
	var_12_10.isSpeartor2 = false

	table.insert(var_12_0, var_12_10)

	for iter_12_2 = 2, var_0_0 do
		local var_12_11 = {}

		var_12_11.isSpeartor = false
		var_12_11.isSpeartor2 = true

		table.insert(var_12_0, var_12_11)
	end

	for iter_12_3, iter_12_4 in pairs(var_12_5) do
		local var_12_12 = {}

		var_12_12.equip = nil
		var_12_12.isEmpty = false
		var_12_12.templateId = nil

		if iter_12_4 then
			var_12_12.templateId = iter_12_4.id
		end

		table.insert(var_12_0, var_12_12)
	end

	while table.getn(var_12_0) % var_0_0 ~= 0 do
		local var_12_13 = {}

		var_12_13.isEmpty = true

		table.insert(var_12_0, var_12_13)
	end

	return var_12_0, var_12_9
end

function zbEquipSelectWnd.refreshExistSelectItem(arg_13_0, arg_13_1)
	local var_13_0 = 1

	for iter_13_0, iter_13_1 in pairs(arg_13_0.listEquip) do
		arg_13_0.items[var_13_0]:refreshExistSelectItem(arg_13_1)

		var_13_0 = var_13_0 + 1
	end
end

function zbEquipSelectWnd.refreshNonExistSelectItem(arg_14_0, arg_14_1)
	local var_14_0 = 1

	for iter_14_0, iter_14_1 in pairs(arg_14_0.listEquip) do
		arg_14_0.items[var_14_0]:refreshNonExistSelectItem(arg_14_1)

		var_14_0 = var_14_0 + 1
	end
end
