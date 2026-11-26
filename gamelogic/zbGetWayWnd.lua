require("gamelogic.zbBaseWnd")
require("gamelogic.zbGetWayItem")
require("gamelogic.zbItem")

zbGetWayWnd = class("zbGetWayWnd", zbBaseWnd)
zbGetWayWnd.__index = zbGetWayWnd

function zbGetWayWnd.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbGetWayWnd)

	return arg_1_0
end

function createGetWayWnd()
	local var_2_0 = zbGetWayWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function zbGetWayWnd.init(arg_3_0)
	local function var_3_0()
		arg_3_0.items = {}
		arg_3_0.tableView = nil
		arg_3_0.tableViewHelper = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/fraggetway.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCLayer")

		var_5_3:setVisible(false)

		arg_3_0.useItem = createItem()

		local var_5_4 = ccp(var_5_3:getPosition())

		arg_3_0.useItem:setPosition(var_5_3:getPosition())
		arg_3_0.useItem:setNeedTip(true)
		arg_3_0.useItem:setScale(0.8)
		var_5_2:addChild(arg_3_0.useItem)

		arg_3_0.lbName = tolua.cast(var_5_2:getChildByTag(2), "CCLabelTTF")
		arg_3_0.lbNum = tolua.cast(var_5_2:getChildByTag(3), "CCLabelTTF")
		arg_3_0.lbTemp = tolua.cast(var_5_2:getChildByTag(1004), "CCLabelTTF")
		arg_3_0.lbZhu = tolua.cast(var_5_2:getChildByTag(5), "CCLabelTTF")
		arg_3_0.lbCi = tolua.cast(var_5_2:getChildByTag(6), "CCLabelTTF")
		arg_3_0.lbEmpty = tolua.cast(var_5_2:getChildByTag(1000), "CCLabelTTF")
		arg_3_0.layerContent = tolua.cast(var_5_2:getChildByTag(7), "CCLayer")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0:addChild(var_5_1)

		arg_3_0.spriteTemp = tolua.cast(var_5_1:getChildByTag(99), "CCLayer")
		arg_3_0.layerTouchTest = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)
	end

	var_3_0()
	var_3_1()
end

function zbGetWayWnd.refresh(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0.parentFromWnd = arg_8_3

	arg_8_0.useItem:refreshAward(arg_8_2, arg_8_1, 0, false, false)

	if arg_8_2 == ECommonAwardType.HeroFrag then
		local var_8_0 = zbHeroTable:getRecord(arg_8_1)

		if var_8_0 == nil then
			echoInfo("error hero template id: " .. arg_8_1)

			return
		end

		exchQuality, exchAdd = zbHeroQualityTable:exchangeHeroQuality(var_8_0.quality)

		arg_8_0.lbName:setString(var_8_0.name)

		if exchAdd ~= 0 then
			arg_8_0.lbName:setString(var_8_0.name .. "+" .. exchAdd)
		end

		local var_8_1 = zbColor:getItemColor(exchQuality)

		arg_8_0.lbName:setColor(var_8_1)
	else
		local var_8_2 = 0
		local var_8_3 = zbItemTable:getRecord(arg_8_1)

		if var_8_3 == nil then
			echoInfo("error item template id: " .. arg_8_1)

			return
		end

		arg_8_0.lbName:setString(var_8_3.name)

		local var_8_4 = zbColor:getItemColor(var_8_3.quality)

		arg_8_0.lbName:setColor(var_8_4)

		local var_8_5 = ""

		for iter_8_0, iter_8_1 in pairs(var_8_3.mainAttrList) do
			local var_8_6 = a2u(getItemPropStr(iter_8_1.AttrType))

			if iter_8_1.AttrAdditionType == EAttrAdditionType.Fixed then
				var_8_5 = var_8_5 .. var_8_6 .. ":" .. iter_8_1.AttrValue .. " "
			else
				var_8_5 = var_8_5 .. var_8_6 .. ":" .. iter_8_1.AttrValue * 100 .. "%" .. " "
			end
		end

		arg_8_0.lbZhu:setString(var_8_5)

		local var_8_7 = ""

		for iter_8_2, iter_8_3 in pairs(var_8_3.subAttrList) do
			local var_8_8 = a2u(getItemPropStr(iter_8_3.AttrType))

			if iter_8_3.AttrAdditionType == EAttrAdditionType.Fixed then
				var_8_7 = var_8_7 .. " " .. var_8_8 .. "+" .. iter_8_3.AttrValue
			else
				var_8_7 = var_8_7 .. " " .. var_8_8 .. "+" .. iter_8_3.AttrValue * 100 .. "%"
			end
		end

		arg_8_0.lbCi:setString(var_8_7)

		local var_8_9, var_8_10 = g_Self.kEquipFragHandler:getEquipFragCount(arg_8_1)

		if var_8_10 == false then
			var_8_9 = g_Self.kBagItemHandler:getItemCountByTemplateId(arg_8_1)
		end

		if var_8_7 == "" then
			arg_8_0.lbTemp:setString(a2u("ӵ\xD3\xD0:"))
		else
			arg_8_0.lbTemp:setString(a2u("\xCB\xE9Ƭ:"))
		end

		arg_8_0.lbNum:setString(var_8_9)
	end

	arg_8_0.templateId = arg_8_1

	if arg_8_0.tableView == nil then
		local var_8_11 = arg_8_0.layerContent:getContentSize()

		arg_8_0.tableViewHelper = zbTableViewHelper:create()
		arg_8_0.tableView = zbTableViewHelper:createTableView(var_8_11, var_8_11, 1, arg_8_0.tableViewHelper)

		arg_8_0.tableView:setPosition(0, 0)
		arg_8_0.tableView:setAnchorPoint(ccp(0, 0))
		arg_8_0.layerContent:addChild(arg_8_0.tableView)
	else
		arg_8_0.tableViewHelper:removeAllCells()
	end

	local var_8_12 = g_Self.kGetWayHandler:getWays(arg_8_0.templateId)

	if var_8_12 == nil then
		return
	end

	local var_8_13 = table.getn(var_8_12.ways)
	local var_8_14 = table.getn(arg_8_0.items)

	for iter_8_4 = 1, var_8_14 do
		if iter_8_4 <= var_8_13 then
			local var_8_15 = arg_8_0.items[iter_8_4]

			arg_8_0.tableViewHelper:addCell(var_8_15)
		end
	end

	if var_8_13 - var_8_14 > 0 then
		for iter_8_5 = 1, var_8_13 - var_8_14 do
			local var_8_16 = zbTableViewHelper:create()

			var_8_16:loadCCBFile("ccbi/tb_getway.ccbi")

			local var_8_17 = zbGetWayItem:create(translateAndStrokeHelper(var_8_16:readCCBNode()), arg_8_0)

			var_8_17:retain()

			arg_8_0.items[var_8_14 + iter_8_5] = var_8_17

			arg_8_0.tableViewHelper:addCell(var_8_17)
			var_8_16:releaseSelf()
		end
	end

	local var_8_18 = 1

	for iter_8_6, iter_8_7 in pairs(var_8_12.ways) do
		arg_8_0.items[var_8_18]:refresh(iter_8_7, arg_8_0.parentFromWnd)

		var_8_18 = var_8_18 + 1
	end

	arg_8_0.tableViewHelper:refreshTabelView()
	arg_8_0.tableViewHelper:setTouchPriority(arg_8_0.btnTouchTest:getTouchPriority())
	arg_8_0.lbEmpty:setVisible(var_8_13 <= 0)
end

function zbGetWayWnd.onTouchTest(arg_9_0)
	local var_9_0 = arg_9_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_9_0.layerTouchTest, var_9_0.x, var_9_0.y) == false then
		arg_9_0:hide()
	end
end
