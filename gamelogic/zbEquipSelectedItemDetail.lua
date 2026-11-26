zbEquipSelectedItemDetail = class("zbEquipSelectedItemDetail")
zbEquipSelectedItemDetail.__index = zbEquipSelectedItemDetail

function zbEquipSelectedItemDetail.init(arg_1_0, arg_1_1)
	local function var_1_0()
		arg_1_0.EquipBaseData = nil
		arg_1_0.selectedEquip = nil
		arg_1_0.heroTemplateId = 0
		arg_1_0.initPos = ccp(arg_1_1:getPosition())
		arg_1_0.layerGem = {}
		arg_1_0.lbWuxingAttr = {}
		arg_1_0.spriteWuxing = {}
		arg_1_0.items = {}
		arg_1_0.tableView = nil
		arg_1_0.tableViewHelper = nil
	end

	local function var_1_1()
		arg_1_0.layer = arg_1_1

		local var_3_0 = tolua.cast(arg_1_1:getChildByTag(1), "CCLayer")

		arg_1_0.spriteFrame = tolua.cast(var_3_0:getChildByTag(1), "CCSprite")
		arg_1_0.spriteIcon = tolua.cast(var_3_0:getChildByTag(2), "CCSprite")
		arg_1_0.lbLevelDummy = tolua.cast(arg_1_1:getChildByTag(2), "CCLabelTTF")
		arg_1_0.lbName = tolua.cast(arg_1_1:getChildByTag(3), "CCLabelTTF")
		arg_1_0.lbdesc = tolua.cast(arg_1_1:getChildByTag(1004), "CCLabelTTF")
		arg_1_0.lbHeroName = tolua.cast(arg_1_1:getChildByTag(5), "CCLabelTTF")
		arg_1_0.lbFightDummy = tolua.cast(arg_1_1:getChildByTag(6), "CCLabelTTF")
		arg_1_0.sv = tolua.cast(arg_1_1:getChildByTag(13), "CCScrollView")
		arg_1_0.layerEquip = tolua.cast(arg_1_1:getChildByTag(14), "CCLayer")
		arg_1_0.lbMainAttrName = tolua.cast(arg_1_0.layerEquip:getChildByTag(1), "CCLabelTTF")
		arg_1_0.lbMainAttrValue = tolua.cast(arg_1_0.layerEquip:getChildByTag(2), "CCLabelTTF")
		arg_1_0.lbSubAttr = tolua.cast(arg_1_0.layerEquip:getChildByTag(3), "CCLabelTTF")

		for iter_3_0 = 11, 15 do
			arg_1_0.layerGem[iter_3_0 - 10] = tolua.cast(arg_1_0.layerEquip:getChildByTag(iter_3_0), "CCLayer")
			arg_1_0.lbWuxingAttr[iter_3_0 - 10] = tolua.cast(arg_1_0.layerGem[iter_3_0 - 10]:getChildByTag(1), "CCLabelTTF")
			arg_1_0.spriteWuxing[iter_3_0 - 10] = tolua.cast(arg_1_0.layerGem[iter_3_0 - 10]:getChildByTag(2), "CCSprite")
		end

		arg_1_0.layerAdd = tolua.cast(arg_1_0.layerEquip:getChildByTag(4), "CCLayer")
		arg_1_0.lbWuxingAdd = tolua.cast(arg_1_0.layerAdd:getChildByTag(1), "CCLabelTTF")
		arg_1_0.lbLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_1_0.lbLevelDummy, arg_1_0.lbLevel)
		arg_1_0.lbLevel:setScale(0.55)

		arg_1_0.lbFight = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_1_0.lbFightDummy, arg_1_0.lbFight)
		arg_1_0.lbFight:setScale(0.55)

		arg_1_0.btnWear = tolua.cast(arg_1_1:getChildByTag(11), "CCControlButton")
		arg_1_0.btnGetWay = tolua.cast(arg_1_1:getChildByTag(12), "CCControlButton")

		arg_1_0.btnWear:addHandleOfControlEvent(function()
			arg_1_0:onEquipUp()
		end, CCControlEventTouchUpInside)
		arg_1_0.btnGetWay:addHandleOfControlEvent(function()
			arg_1_0:onGetWay()
		end, CCControlEventTouchUpInside)
	end

	var_1_0()
	var_1_1()
end

function zbEquipSelectedItemDetail.doFree(arg_6_0)
	return
end

function zbEquipSelectedItemDetail.refreshByEquip(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.heroTemplateId = arg_7_1

	if arg_7_2 == nil then
		arg_7_0.layer:setVisible(false)

		return
	end

	arg_7_0.layer:setVisible(true)
	arg_7_0.lbLevel:setVisible(true)
	arg_7_0.btnWear:setVisible(true)
	arg_7_0.btnGetWay:setVisible(false)

	arg_7_0.equipRecord = nil
	arg_7_0.equip = arg_7_2
	arg_7_0.equipRecord = zbItemTable:getRecord(arg_7_0.equip.TemplateId)

	if arg_7_0.equipRecord == nil then
		echoInfo("zbEquipDetail_Detail:refresh invalidId: " .. arg_7_0.equip.TemplateId)

		return
	end

	arg_7_0.spriteFrame:setTexture(CCTextureCache:sharedTextureCache():addImage(zbColor:getEquipFrameTex(arg_7_2.Quality)))
	arg_7_0.spriteIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(zbIconHelper:getItemIconPath(arg_7_2.TemplateId)))
	arg_7_0.lbLevel:setString(arg_7_2.Level)
	arg_7_0.lbdesc:setString(arg_7_0.equipRecord.description)
	arg_7_0.lbName:setString(arg_7_0.equipRecord.name)

	local var_7_0 = zbColor:getItemColor(arg_7_2.Quality)

	arg_7_0.lbName:setColor(var_7_0)

	if arg_7_2.CLevel ~= 0 then
		arg_7_0.lbName:setString(arg_7_0.equipRecord.name .. "+" .. arg_7_2.CLevel)
	end

	arg_7_0.lbFight:setString(arg_7_0.equip.FV)

	local var_7_1 = g_Self.kBagEquipHandler:getBagEquipMain(arg_7_0.equipRecord, arg_7_0.equip)

	arg_7_0.lbMainAttrName:setString(var_7_1)

	local var_7_2 = ""

	for iter_7_0, iter_7_1 in pairs(arg_7_0.equipRecord.subAttrList) do
		local var_7_3 = a2u(getItemPropStr(iter_7_1.AttrType))

		if iter_7_1.AttrAdditionType == EAttrAdditionType.Fixed then
			var_7_2 = var_7_2 .. " " .. var_7_3 .. ":" .. iter_7_1.AttrValue + arg_7_0.equip.CLevel * iter_7_1.AttrValueGrow
		else
			var_7_2 = var_7_2 .. " " .. var_7_3 .. ":" .. (iter_7_1.AttrValue + arg_7_0.equip.CLevel * iter_7_1.AttrValueGrow) * 100 .. "%"
		end
	end

	arg_7_0.lbSubAttr:setString(var_7_2)

	for iter_7_2 = 1, 5 do
		arg_7_0.layerGem[iter_7_2]:setVisible(false)
	end

	local var_7_4 = 1

	for iter_7_3, iter_7_4 in pairs(arg_7_0.equip.AttrInfo.GemAttr) do
		local var_7_5 = zbItemTable:getRecord(iter_7_4.TemplateId)

		if var_7_5 ~= nil then
			arg_7_0.spriteWuxing[var_7_4]:setTexture(CCTextureCache:sharedTextureCache():addImage("image/common/comm_wuxing0" .. var_7_5.gemShape .. ".png"))
		end

		arg_7_0.layerGem[var_7_4]:setVisible(true)

		local var_7_6 = ""

		for iter_7_5, iter_7_6 in pairs(iter_7_4.AttrList) do
			var_7_6 = var_7_6 .. " " .. a2u(getItemPropStr(iter_7_6[1])) .. "+" .. iter_7_6[3]
		end

		arg_7_0.lbWuxingAttr[var_7_4]:setString(var_7_6)

		var_7_4 = var_7_4 + 1
	end

	if arg_7_0.equip.AttrInfo.Addition ~= 0 then
		arg_7_0.layerAdd:setVisible(true)
		arg_7_0.lbWuxingAdd:setString(a2u("\xD6\xF7\xCA\xF4\xD0\xD4+") .. arg_7_0.equip.AttrInfo.Addition * 100 .. "%")
	else
		arg_7_0.layerAdd:setVisible(false)
	end
end

function zbEquipSelectedItemDetail.refreshByEquipId(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.selectedEquip = nil
	arg_8_0.EquipBaseData = nil
	arg_8_0.equipTemplateId = arg_8_2
	arg_8_0.heroTemplateId = arg_8_1

	if arg_8_2 == nil then
		arg_8_0.layer:setVisible(false)

		return
	end

	arg_8_0.layer:setVisible(true)
	arg_8_0.lbLevel:setVisible(false)
	arg_8_0.btnWear:setVisible(false)
	arg_8_0.btnGetWay:setVisible(true)

	arg_8_0.equipRecord = nil
	arg_8_0.equipRecord = zbItemTable:getRecord(arg_8_0.equipTemplateId)

	if arg_8_0.equipRecord == nil then
		echoInfo("zbEquipDetail_Detail:refresh invalidId: " .. arg_8_0.equipTemplateId)

		return
	end

	arg_8_0.spriteFrame:setTexture(CCTextureCache:sharedTextureCache():addImage(zbColor:getEquipFrameTex(arg_8_0.equipRecord.quality)))
	arg_8_0.spriteIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(zbIconHelper:getItemIconPath(arg_8_0.equipRecord.id)))
	arg_8_0.lbName:setString(arg_8_0.equipRecord.name)
	arg_8_0.lbdesc:setString(arg_8_0.equipRecord.description)

	local var_8_0 = zbColor:getItemColor(arg_8_0.equipRecord.quality)

	arg_8_0.lbName:setColor(var_8_0)
	arg_8_0.lbFight:setString(g_Self.kBagEquipHandler:getFvBagEquip(arg_8_2))

	local var_8_1 = ""

	for iter_8_0, iter_8_1 in pairs(arg_8_0.equipRecord.mainAttrList) do
		local var_8_2 = a2u(getItemPropStr(iter_8_1.AttrType))

		if iter_8_1.AttrAdditionType == EAttrAdditionType.Fixed then
			var_8_1 = var_8_1 .. " " .. var_8_2 .. ":" .. iter_8_1.AttrValue
		else
			var_8_1 = var_8_1 .. " " .. var_8_2 .. ":" .. iter_8_1.AttrValue * 100 .. "%"
		end
	end

	arg_8_0.lbMainAttrName:setString(var_8_1)

	local var_8_3 = ""

	for iter_8_2, iter_8_3 in pairs(arg_8_0.equipRecord.subAttrList) do
		local var_8_4 = a2u(getItemPropStr(iter_8_3.AttrType))

		if iter_8_3.AttrAdditionType == EAttrAdditionType.Fixed then
			var_8_3 = var_8_3 .. " " .. var_8_4 .. ":" .. iter_8_3.AttrValue
		else
			var_8_3 = var_8_3 .. " " .. var_8_4 .. ":" .. iter_8_3.AttrValue * 100 .. "%"
		end
	end

	arg_8_0.lbSubAttr:setString(var_8_3)

	for iter_8_4 = 1, 5 do
		arg_8_0.layerGem[iter_8_4]:setVisible(false)
	end

	arg_8_0.layerAdd:setVisible(false)
end

function zbEquipSelectedItemDetail.onHide(arg_9_0)
	return
end

function zbEquipSelectedItemDetail.onEquipUp(arg_10_0)
	if arg_10_0.equip == nil then
		return
	end

	local var_10_0 = zbItemTable:getRecord(arg_10_0.equip.TemplateId)
	local var_10_1 = {
		SlotType = EEquipSlotType.Bag
	}

	var_10_1.HeroTid = 0
	var_10_1.EquipId = arg_10_0.equip.EquipId

	echoInfo("self.heroTemplateId: " .. arg_10_0.heroTemplateId)

	local var_10_2 = {}
	local var_10_3 = g_Self.kHeroHandler:getHeroEquipByPos(arg_10_0.heroTemplateId, g_MainScene.wndEquipSelect.ItemSubType)

	if var_10_3 ~= nil then
		var_10_2.SlotType = EEquipSlotType.Hero
		var_10_2.HeroTid = arg_10_0.heroTemplateId
		var_10_2.EquipId = var_10_3.Equip.EquipId
	else
		var_10_2.SlotType = EEquipSlotType.Hero
		var_10_2.HeroTid = arg_10_0.heroTemplateId
		var_10_2.EquipId = 0
	end

	g_WsMsgHandler:WS_Hero_WearEquip_Req(var_10_1, var_10_2)
	arg_10_0.layer:setVisible(false)

	if g_MainScene.wndEquipSelect then
		g_MainScene.wndEquipSelect:hide()
	end
end

function zbEquipSelectedItemDetail.onGetWay(arg_11_0)
	g_MainScene:showGetWayWnd(arg_11_0.equipTemplateId, ECommonAwardType.Item)
end

function createSelectedItemDetail(arg_12_0)
	local var_12_0 = zbEquipSelectedItemDetail.new()

	var_12_0:init(arg_12_0)

	return var_12_0
end
