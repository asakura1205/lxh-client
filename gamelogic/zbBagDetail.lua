require("gamelogic.zbBagDetailItem")
require("gamelogic.zbAttributeLine")

local var_0_0 = class("zbBagDetail")

var_0_0.__index = var_0_0

function var_0_0.init(arg_1_0, arg_1_1)
	local function var_1_0()
		arg_1_0.lastUseItemId = nil
		arg_1_0.itemdata = nil
		arg_1_0.itemRecord = nil
		arg_1_0.initPos = ccp(arg_1_1:getPosition())
		arg_1_0.btnsellPos = nil
		arg_1_0.btndetailPos = nil
		arg_1_0.items = {}
		arg_1_0.tableView = nil
		arg_1_0.tableViewHelper = nil
	end

	local function var_1_1()
		arg_1_0.layer = arg_1_1

		arg_1_0.layer:setVisible(false)

		arg_1_0.detailItem = createBagDetailItem(tolua.cast(arg_1_1:getChildByTag(1), "CCNode"))
		arg_1_0.lbName = tolua.cast(arg_1_1:getChildByTag(2), "CCLabelTTF")
		arg_1_0.bmOwnerUseNum = tolua.cast(arg_1_1:getChildByTag(3), "CCLabelTTF")
		arg_1_0.layPrice = tolua.cast(arg_1_1:getChildByTag(5), "CCNode")
		arg_1_0.lbPrice = tolua.cast(arg_1_0.layPrice:getChildByTag(1), "CCLabelTTF")
		arg_1_0.btnSell = tolua.cast(arg_1_1:getChildByTag(6), "CCControlButton")
		arg_1_0.btnUse = tolua.cast(arg_1_1:getChildByTag(7), "CCControlButton")
		arg_1_0.btnsellInitPos = ccp(arg_1_0.btnSell:getPosition())
		arg_1_0.centerPos = ccp(206, 113)
		arg_1_0.btnPreShow = tolua.cast(arg_1_1:getChildByTag(14), "CCControlButton")
		arg_1_0.layerKey = tolua.cast(arg_1_1:getChildByTag(15), "CCNode")
		arg_1_0.spriteKey = tolua.cast(arg_1_0.layerKey:getChildByTag(2), "CCSprite")
		arg_1_0.bmKeyNeed = tolua.cast(arg_1_0.layerKey:getChildByTag(1), "CCLabelTTF")
		arg_1_0.LayerUse = tolua.cast(arg_1_1:getChildByTag(11), "CCNode")
		arg_1_0.bmUseEffect = tolua.cast(arg_1_0.LayerUse:getChildByTag(1003), "CCLabelTTF")
		arg_1_0.lbUseWay = tolua.cast(arg_1_0.LayerUse:getChildByTag(2), "CCLabelTTF")
		arg_1_0.lbDescUse = tolua.cast(arg_1_0.LayerUse:getChildByTag(3), "CCLabelTTF")
		arg_1_0.lbluseTitle = tolua.cast(arg_1_0.LayerUse:getChildByTag(1004), "CCLabelTTF")
		arg_1_0.layerGems = tolua.cast(arg_1_1:getChildByTag(12), "CCNode")
		arg_1_0.bmOtherEffect = tolua.cast(arg_1_0.layerGems:getChildByTag(1), "CCLabelTTF")
		arg_1_0.layerAttributeList = tolua.cast(arg_1_0.layerGems:getChildByTag(2), "CCNode")
		arg_1_0.lbOtherWay = tolua.cast(arg_1_0.layerGems:getChildByTag(3), "CCLabelTTF")
		arg_1_0.spriteTemp = tolua.cast(arg_1_0.layerGems:getChildByTag(4), "CCSprite")
		arg_1_0.lbUnSell = tolua.cast(arg_1_1:getChildByTag(1002), "CCLabelTTF")

		arg_1_0.lbUnSell:setVisible(false)
		arg_1_0.btnSell:addHandleOfControlEvent(function()
			arg_1_0:onSell()
		end, CCControlEventTouchUpInside)
		arg_1_0.btnUse:addHandleOfControlEvent(function()
			arg_1_0:onUse()
		end, CCControlEventTouchUpInside)
		arg_1_0.btnPreShow:addHandleOfControlEvent(function()
			arg_1_0:onPreShow()
		end, CCControlEventTouchUpInside)
	end

	var_1_0()
	var_1_1()
end

function var_0_0.refreshByEquipId(arg_7_0, arg_7_1)
	arg_7_0.itemRecord = nil
	arg_7_0.itemdata = arg_7_1

	if arg_7_1 == nil then
		if g_MainScene.wndBag then
			g_MainScene.wndBag:refreshSelectItem(-1)
		end

		arg_7_0.layer:setVisible(false)

		return
	end

	arg_7_0.btnUse:setVisible(false)
	arg_7_0.btnSell:setVisible(false)
	arg_7_0.btnPreShow:setVisible(false)

	arg_7_0.itemRecord = zbItemTable:getRecord(arg_7_0.itemdata.TemplateId)

	if arg_7_0.itemRecord == nil then
		echoInfo("zbBagDetail:refresh invalidId: " .. arg_7_0.itemdata.TemplateId)

		return
	end

	if g_MainScene.wndBag then
		g_MainScene.wndBag:refreshSelectItem(arg_7_0.itemdata.TemplateId)
	end

	arg_7_0.detailItem:refreshItemData(arg_7_0.itemdata)
	arg_7_0.lbName:setString(arg_7_0.itemRecord.name)

	local var_7_0 = zbColor:getItemColor(arg_7_0.itemRecord.quality)

	arg_7_0.lbName:setColor(var_7_0)
	arg_7_0.bmOwnerUseNum:setString(arg_7_0.itemdata.Count)

	local var_7_1 = g_Self.kBagItemHandler:getItemRealPrice(arg_7_1)

	arg_7_0.lbPrice:setString(var_7_1)
	arg_7_0.layer:setVisible(true)
	arg_7_0.layerKey:setVisible(false)
	arg_7_0.LayerUse:setVisible(arg_7_0.itemRecord.type ~= EItemType.Gem)
	arg_7_0.layerGems:setVisible(arg_7_0.itemRecord.type == EItemType.Gem)

	local function var_7_2()
		arg_7_0.bmUseEffect:setString(arg_7_0.itemRecord.description)
		arg_7_0.lbDescUse:setString(a2u("\xB1\xA6\xCF\xE4,\xBF\xC9\xD2\xD4ʹ\xD3\xC3Կ\xB3״\xF2\xBF\xAA"))
		arg_7_0.lbUseWay:setString(a2u("\xB5\xE3\xBB\xF7\xB4\xF2\xBF\xAA"))
		arg_7_0.btnPreShow:setVisible(true)
		arg_7_0.layerKey:setVisible(true)

		if arg_7_0.itemRecord.key == 0 then
			arg_7_0.layerKey:setVisible(false)
		else
			local var_8_0 = zbItemTable:getRecord(arg_7_0.itemRecord.key)

			if var_8_0 then
				arg_7_0.spriteKey:setTexture(CCTextureCache:sharedTextureCache():addImage("image/common/money_key0" .. var_8_0.quality .. ".png"))
				arg_7_0.bmKeyNeed:setString(1)
			end
		end

		arg_7_0.bmKeyNeed:setString(1)
		arg_7_0.layPrice:setVisible(true)
	end

	local function var_7_3()
		arg_7_0.bmUseEffect:setString(arg_7_0.itemRecord.description)
		arg_7_0.lbDescUse:setString(a2u("\xCF\xFB\xBA\xC4\xC0\xE0\xCE\xEFƷ,\xBF\xC9\xD2\xD4ʹ\xD3\xC3"))

		if arg_7_0.itemRecord.subType == EMaterialType.HeroSkillBook then
			arg_7_0.lbUseWay:setString(a2u("\xBC\xBC\xC4\xDC\xCA\xE9ʹ\xD3÷\xBD\xB7\xA8?????"))
		elseif arg_7_0.itemRecord.subType == EMaterialType.TiliPill then
			arg_7_0.lbUseWay:setString(a2u("\xD3\xE3\xB8\xC9.........."))
		end
	end

	local function var_7_4()
		arg_7_0.bmUseEffect:setString(arg_7_0.itemRecord.description)
		arg_7_0.lbDescUse:setString(a2u("Կ\xB3\xD7,\xBF\xC9\xD2Դ򿪱\xA6\xCF\xE4"))
		arg_7_0.lbUseWay:setString(a2u("\xB2\xBB\xBF\xC9ʹ\xD3\xC3"))
	end

	arg_7_0.lbluseTitle:setVisible(true)
	arg_7_0.lbUseWay:setVisible(true)

	if arg_7_0.itemRecord.type == EItemType.Gem then
		arg_7_0.btnSell:setVisible(true)
		arg_7_0.btnSell:setPosition(arg_7_0.centerPos)
		arg_7_0.bmOtherEffect:setString(arg_7_0.itemRecord.description)
		arg_7_0:refreshAtrribute()
	elseif arg_7_0.itemRecord.type == EItemType.Material then
		arg_7_0.btnSell:setVisible(true)
		arg_7_0.lbluseTitle:setVisible(false)
		arg_7_0.lbUseWay:setVisible(false)
		arg_7_0.btnSell:setPosition(arg_7_0.centerPos)
		var_7_3()
	elseif arg_7_0.itemRecord.type == EItemType.Box then
		arg_7_0.btnUse:setVisible(true)
		arg_7_0.btnSell:setVisible(false)
		arg_7_0.btnUse:setPosition(arg_7_0.centerPos)
		zbUtil:setButtonTitle(arg_7_0.btnUse, a2u("\xB4\xF2 \xBF\xAA"))
		var_7_2()
	elseif arg_7_0.itemRecord.type == EItemType.Key then
		arg_7_0.btnSell:setVisible(true)
		arg_7_0.btnSell:setPosition(arg_7_0.centerPos)
		var_7_4()
	end
end

function var_0_0.refreshAtrribute(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.items) do
		iter_11_1:removeFromParentAndCleanup(false)
	end

	if arg_11_0.tableView ~= nil then
		arg_11_0.tableView:removeFromParentAndCleanup(true)

		arg_11_0.tableView = nil
		arg_11_0.tableViewHelper = nil
	end

	local var_11_0 = arg_11_0.layerAttributeList:getContentSize()
	local var_11_1 = CCSizeMake(var_11_0.width, var_11_0.height)
	local var_11_2 = CCSizeMake(var_11_0.width, var_11_0.height)

	arg_11_0.tableViewHelper = zbTableViewHelper:create()
	arg_11_0.tableView = zbTableViewHelper:createTableView(var_11_1, var_11_2, 1, arg_11_0.tableViewHelper, 0)

	arg_11_0.tableView:setPosition(0, 0)
	arg_11_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_11_0.layerAttributeList:addChild(arg_11_0.tableView)
	arg_11_0.tableViewHelper:refreshTabelView()

	local var_11_3 = arg_11_0:getAtrributeList()
	local var_11_4 = table.getn(var_11_3)

	for iter_11_2 = 1, var_11_4 do
		local var_11_5 = table.getn(arg_11_0.items)
		local var_11_6

		if var_11_5 < iter_11_2 then
			local var_11_7 = zbTableViewHelper:create()

			var_11_7:loadCCBFile("ccbi/commonTextLine.ccbi")

			var_11_6 = createAttributeLine(translateAndStrokeHelper(var_11_7:readCCBNode()))

			var_11_6:retain()

			arg_11_0.items[iter_11_2] = var_11_6

			var_11_7:releaseSelf()
		else
			var_11_6 = arg_11_0.items[iter_11_2]
		end

		if var_11_6 ~= nil then
			local var_11_8 = var_11_3[iter_11_2]

			if var_11_8 then
				var_11_6:refreshLable(var_11_8.attribut, var_11_8.tagType, var_11_8.color)
				arg_11_0.tableViewHelper:addCell(var_11_6)
			end
		end
	end

	arg_11_0.tableViewHelper:refreshTabelView()

	if g_MainScene.wndBag then
		local var_11_9 = g_MainScene.wndBag.tabButtons[EBagTab.Consumables]

		arg_11_0.tableViewHelper:setTouchPriority(var_11_9:getTouchPriority())
	end
end

function var_0_0.getAtrributeList(arg_12_0)
	local var_12_0 = {}

	if arg_12_0.itemRecord == nil then
		return var_12_0
	end

	for iter_12_0, iter_12_1 in pairs(arg_12_0.itemRecord.mainAttrList) do
		local var_12_1 = {}

		var_12_1.type = 0
		var_12_1.color = FONT_COLOR_GREEN

		if iter_12_1.AttrAdditionType == EAttrAdditionType.Percent then
			var_12_1.attribut = a2u(getItemPropStr(iter_12_1.AttrType) .. iter_12_1.AttrValue * 100 .. "%")
		else
			var_12_1.attribut = a2u(getItemPropStr(iter_12_1.AttrType) .. iter_12_1.AttrValue)
		end

		table.insert(var_12_0, var_12_1)
	end

	for iter_12_2, iter_12_3 in pairs(arg_12_0.itemRecord.subAttrList) do
		local var_12_2 = {}

		var_12_2.type = 0
		var_12_2.color = FONT_COLOR_WHITE

		if iter_12_3.AttrAdditionType == EAttrAdditionType.Percent then
			var_12_2.attribut = a2u(getItemPropStr(iter_12_3.AttrType) .. iter_12_3.AttrValue * 100 .. "%")
		else
			var_12_2.attribut = a2u(getItemPropStr(iter_12_3.AttrType) .. iter_12_3.AttrValue)
		end

		table.insert(var_12_0, var_12_2)
	end

	return var_12_0
end

function var_0_0.onSell(arg_13_0)
	if arg_13_0.itemdata == nil then
		return
	end

	if arg_13_0.itemdata.Count > 1 then
		g_MainScene:showItemCountSelcetWnd(arg_13_0.itemdata, EBagItemOption.E_SALE)
	else
		local var_13_0 = {}
		local var_13_1 = {
			arg_13_0.itemdata.TemplateId,
			arg_13_0.itemdata.Count
		}

		table.insert(var_13_0, var_13_1)

		local function var_13_2()
			g_WsMsgHandler:WS_Bag_SaleItem_Req(var_13_0)
		end

		local var_13_3 = ""

		if arg_13_0.itemRecord then
			var_13_3 = arg_13_0.itemRecord.name
		end

		local var_13_4 = a2u("ȷ\xB6\xA8\xB3\xF6\xCA\xDB") .. a2u(var_13_3) .. a2u("\xC2\xF0\xA3\xBF")

		g_MessageBox:showYesNo(var_13_4, var_13_2)
	end
end

function var_0_0.onUse(arg_15_0)
	if arg_15_0.itemdata == nil then
		return
	end

	if arg_15_0.itemRecord.type == EItemType.Gem then
		-- block empty
	elseif arg_15_0.itemRecord.type == EItemType.Box then
		local var_15_0 = 0

		if arg_15_0.itemRecord.key ~= 0 and g_Self.kBagItemHandler:getItemCountByTemplateId(arg_15_0.itemRecord.key) <= 0 then
			g_Bubble:bubbleInfo(a2u("û\xD3\xD0Կ\xB3\xD7"))

			return
		end

		if arg_15_0.itemdata.Count == 1 then
			g_WsMsgHandler:WS_Bag_OpenBox_Req(arg_15_0.itemdata.TemplateId, 1)
		else
			g_MainScene:showItemCountSelcetWnd(arg_15_0.itemdata, EBagItemOption.E_OPEN)
		end
	end
end

function var_0_0.onPreShow(arg_16_0)
	g_MainScene:showBoxPreViewWnd(arg_16_0.itemRecord.box)
end

function createBagDetail(arg_17_0)
	local var_17_0 = var_0_0.new()

	var_17_0:init(arg_17_0)

	return var_17_0
end
