zbHeroEquipSlotTips = class("zbHeroEquipSlotTips", CCNodeExtend)
zbHeroEquipSlotTips.__index = zbHeroEquipSlotTips

function zbHeroEquipSlotTips.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbHeroEquipSlotTips)

	return arg_1_0
end

function zbHeroEquipSlotTips.init(arg_2_0, arg_2_1)
	local function var_2_0()
		arg_2_0.contentSizeHeight = 0
		arg_2_0.contentSizeWidth = 0
		arg_2_0.layerGem = {}
		arg_2_0.lbWuxingAttr = {}
		arg_2_0.spriteWuxing = {}
		arg_2_0.node = arg_2_1
	end

	local function var_2_1()
		local function var_4_0(arg_5_0)
			local var_5_0 = CCSprite:create(NOTIFY_TAG_PATH)

			var_5_0:setPosition(arg_5_0:getContentSize().width - 20, arg_5_0:getContentSize().height / 2 + 20)
			arg_5_0:addChild(var_5_0)
			zbUIEffect:createNotifyTagScaleAction(var_5_0)

			return var_5_0
		end

		local function var_4_1(arg_6_0)
			local var_6_0 = CCSprite:create("image/common/arrow_up.png")

			var_6_0:setPosition(100, 50)
			var_6_0:setVisible(true)

			if arg_6_0:getChildByTag(500) == nil then
				arg_6_0:addChild(var_6_0, 1000000, 500)
			end

			zbUIEffect:createArrowMoveAction(var_6_0, 5, 1)

			return var_6_0
		end

		local var_4_2 = tolua.cast(arg_2_1:getChildByTag(99), "CCLayer")

		arg_2_0.btnTouch = tolua.cast(arg_2_1:getChildByTag(98), "CCControlButton")
		arg_2_0.layer = var_4_2
		arg_2_0.spriteBg = tolua.cast(var_4_2:getChildByTag(50), "CCScale9Sprite")

		local var_4_3 = tolua.cast(var_4_2:getChildByTag(4), "CCLayer")
		local var_4_4 = tolua.cast(var_4_3:getChildByTag(1), "CCLayer")

		arg_2_0.spriteFrame = tolua.cast(var_4_4:getChildByTag(1), "CCSprite")
		arg_2_0.spriteIcon = tolua.cast(var_4_4:getChildByTag(2), "CCSprite")
		arg_2_0.spriteLevel = tolua.cast(var_4_3:getChildByTag(2), "CCSprite")
		arg_2_0.lbLevelDummy = tolua.cast(arg_2_0.spriteLevel:getChildByTag(1), "CCLabelTTF")
		arg_2_0.lbName = tolua.cast(var_4_3:getChildByTag(3), "CCLabelTTF")
		arg_2_0.lbdesc = tolua.cast(var_4_3:getChildByTag(4), "CCLabelTTF")
		arg_2_0.lbFightDummy = tolua.cast(var_4_3:getChildByTag(6), "CCLabelTTF")
		arg_2_0.sv = tolua.cast(var_4_3:getChildByTag(13), "CCScrollView")
		arg_2_0.layerEquip = tolua.cast(var_4_3:getChildByTag(14), "CCLayer")
		arg_2_0.lbMainAttrName = tolua.cast(arg_2_0.layerEquip:getChildByTag(1), "CCLabelTTF")
		arg_2_0.lbMainAttrValue = tolua.cast(arg_2_0.layerEquip:getChildByTag(2), "CCLabelTTF")
		arg_2_0.lbSubAttr = tolua.cast(arg_2_0.layerEquip:getChildByTag(3), "CCLabelTTF")

		for iter_4_0 = 11, 15 do
			arg_2_0.layerGem[iter_4_0 - 10] = tolua.cast(arg_2_0.layerEquip:getChildByTag(iter_4_0), "CCLayer")
			arg_2_0.lbWuxingAttr[iter_4_0 - 10] = tolua.cast(arg_2_0.layerGem[iter_4_0 - 10]:getChildByTag(1), "CCLabelTTF")
			arg_2_0.spriteWuxing[iter_4_0 - 10] = tolua.cast(arg_2_0.layerGem[iter_4_0 - 10]:getChildByTag(2), "CCSprite")
		end

		arg_2_0.layerAdd = tolua.cast(arg_2_0.layerEquip:getChildByTag(4), "CCLayer")
		arg_2_0.lbWuxingAdd = tolua.cast(arg_2_0.layerAdd:getChildByTag(1), "CCLabelTTF")
		arg_2_0.lbLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_2_0.lbLevelDummy, arg_2_0.lbLevel)
		arg_2_0.lbLevel:setScale(0.55)

		arg_2_0.lbFight = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_2_0.lbFightDummy, arg_2_0.lbFight)
		arg_2_0.lbFight:setScale(0.55)

		arg_2_0.layerTouchTest = tolua.cast(var_4_2:getChildByTag(40), "CCLayer")
		arg_2_0.btnChange = tolua.cast(var_4_2:getChildByTag(41), "CCControlButton")
		arg_2_0.btnUpgrade = tolua.cast(var_4_2:getChildByTag(42), "CCControlButton")
		arg_2_0.btnUnload = tolua.cast(var_4_2:getChildByTag(43), "CCControlButton")
		arg_2_0.btnChange_Tag = var_4_0(arg_2_0.btnChange)
		arg_2_0.btnGem_Tag = var_4_0(arg_2_0.btnUpgrade)
		arg_2_0.btnUpgrade_Tag = var_4_1(arg_2_0.btnUpgrade)

		arg_2_0.btnChange:addHandleOfControlEvent(function()
			arg_2_0:onChange()
		end, CCControlEventTouchUpInside)
		arg_2_0.btnUpgrade:addHandleOfControlEvent(function()
			arg_2_0:onUpgrade()
		end, CCControlEventTouchUpInside)
		arg_2_0.btnUnload:addHandleOfControlEvent(function()
			arg_2_0:onUnload()
		end, CCControlEventTouchUpInside)
		arg_2_0.btnTouch:addHandleOfControlEvent(function()
			arg_2_0:onTouchTest()
		end, CCControlEventTouchUpInside)
	end

	var_2_0()
	var_2_1()
end

function zbHeroEquipSlotTips.onTouchTest(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.btnTouch:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_11_0.layerTouchTest, var_11_0.x, var_11_0.y) == false then
		arg_11_0.node:setVisible(false)
	end
end

function zbHeroEquipSlotTips.refreshEquip(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_0.heroTemplateId = arg_12_2

	if arg_12_1 == nil then
		arg_12_0.node:setVisible(false)

		return
	end

	arg_12_0.node:setVisible(true)
	arg_12_0.spriteLevel:setVisible(true)

	arg_12_0.equipRecord = nil
	arg_12_0.equip = arg_12_1.Equip
	arg_12_0.ItemSubType = arg_12_3
	arg_12_0.equipRecord = zbItemTable:getRecord(arg_12_0.equip.TemplateId)

	if arg_12_0.equipRecord == nil then
		echoInfo("zbEquipDetail_Detail:refresh invalidId: " .. arg_12_0.equip.TemplateId)

		return
	end

	arg_12_0.spriteFrame:setTexture(CCTextureCache:sharedTextureCache():addImage(zbColor:getEquipFrameTex(arg_12_0.equip.Quality)))
	arg_12_0.spriteIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(zbIconHelper:getItemIconPath(arg_12_0.equip.TemplateId)))
	arg_12_0.lbLevel:setString(arg_12_0.equip.Level)
	arg_12_0.lbdesc:setString(arg_12_0.equipRecord.description)
	arg_12_0.lbName:setString(arg_12_0.equipRecord.name)

	local var_12_0 = zbColor:getItemColor(arg_12_0.equip.Quality)

	arg_12_0.lbName:setColor(var_12_0)

	if arg_12_0.equip.CLevel ~= 0 then
		arg_12_0.lbName:setString(arg_12_0.equipRecord.name .. "+" .. arg_12_0.equip.CLevel)
	end

	arg_12_0.lbFight:setString(arg_12_0.equip.FV)

	local var_12_1 = g_Self.kBagEquipHandler:getBagEquipMain(arg_12_0.equipRecord, arg_12_0.equip)

	arg_12_0.lbMainAttrName:setString(var_12_1)

	local var_12_2 = ""

	for iter_12_0, iter_12_1 in pairs(arg_12_0.equipRecord.subAttrList) do
		local var_12_3 = a2u(getItemPropStr(iter_12_1.AttrType))

		if iter_12_1.AttrAdditionType == EAttrAdditionType.Fixed then
			var_12_2 = var_12_2 .. " " .. var_12_3 .. ":" .. iter_12_1.AttrValue + arg_12_0.equip.CLevel * iter_12_1.AttrValueGrow
		else
			var_12_2 = var_12_2 .. " " .. var_12_3 .. ":" .. (iter_12_1.AttrValue + arg_12_0.equip.CLevel * iter_12_1.AttrValueGrow) * 100 .. "%"
		end
	end

	arg_12_0.lbSubAttr:setString(var_12_2)

	for iter_12_2 = 1, 5 do
		arg_12_0.layerGem[iter_12_2]:setVisible(false)
	end

	arg_12_0.layerAdd:setVisible(false)
	arg_12_0.spriteBg:setContentSize(CCSizeMake(400, 265))

	local var_12_4 = g_Self.kHeroHandler:getHeroByTemplateId(arg_12_2)

	arg_12_0.btnChange_Tag:setVisible(g_Self.kHeroHandler:hasBestEquipCanChange(var_12_4, arg_12_0.ItemSubType))

	local var_12_5 = g_Self.kBagEquipHandler:getEquipCanEnchant(arg_12_0.equip)
	local var_12_6 = g_Self.kHeroHandler:equipCanUpgrade(arg_12_1)

	arg_12_0.btnGem_Tag:setVisible(var_12_5)
	arg_12_0.btnUpgrade_Tag:setVisible(var_12_6)

	if var_12_5 then
		arg_12_0.btnUpgrade_Tag:setVisible(false)
	end
end

function zbHeroEquipSlotTips.resetPosition(arg_13_0, arg_13_1)
	arg_13_1.x = arg_13_1.x + 10

	local var_13_0 = arg_13_1

	if arg_13_1.y - arg_13_0.contentSizeHeight < 0 then
		var_13_0 = ccp(arg_13_1.x, 20)
	else
		var_13_0 = ccp(arg_13_1.x, arg_13_1.y - 450)
	end

	arg_13_0.layer:setPosition(var_13_0)
end

function zbHeroEquipSlotTips.onChange(arg_14_0)
	if arg_14_0.equip == nil then
		return
	end

	g_MainScene:showEquipSelectWnd(arg_14_0.heroTemplateId, arg_14_0.ItemSubType):setPrevWnd(g_MainScene.wndHeroDetail)
	arg_14_0.node:setVisible(false)
end

function zbHeroEquipSlotTips.onUpgrade(arg_15_0)
	if arg_15_0.equip == nil then
		return
	end

	g_MainScene:showEquipDetailWnd(arg_15_0.equip, arg_15_0.heroTemplateId):setPrevWnd(g_MainScene.wndHeroDetail)
	arg_15_0.node:setVisible(false)
end

function zbHeroEquipSlotTips.onUnload(arg_16_0)
	if arg_16_0.equip == nil then
		return
	end

	local var_16_0 = zbItemTable:getRecord(arg_16_0.equip.TemplateId)
	local var_16_1 = {
		SlotType = EEquipSlotType.Hero,
		HeroTid = arg_16_0.heroTemplateId,
		EquipId = arg_16_0.equip.EquipId
	}
	local var_16_2 = {
		SlotType = EEquipSlotType.Bag
	}

	var_16_2.HeroTid = 0
	var_16_2.EquipId = nil

	g_WsMsgHandler:WS_Hero_WearEquip_Req(var_16_1, var_16_2)
	arg_16_0.node:setVisible(false)
end

function createHeroEquipSlotTipsPanel(arg_17_0)
	local var_17_0 = zbHeroEquipSlotTips.new()

	var_17_0:init(arg_17_0)

	return var_17_0
end
