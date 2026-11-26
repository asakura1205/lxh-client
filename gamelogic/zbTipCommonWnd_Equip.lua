zbTipCommonWnd_Equip = class("zbTipCommonWnd_Equip")
zbTipCommonWnd_Equip.__index = zbTipCommonWnd_Equip

function zbTipCommonWnd_Equip.init(arg_1_0, arg_1_1, arg_1_2)
	local function var_1_0()
		arg_1_0.layerGem = {}
		arg_1_0.lbWuxingAttr = {}
		arg_1_0.spriteWuxing = {}
		arg_1_0.node = arg_1_2
	end

	local function var_1_1()
		arg_1_0.layer = arg_1_1
		arg_1_0.spriteBg = tolua.cast(arg_1_1:getChildByTag(50), "CCScale9Sprite")

		local var_3_0 = tolua.cast(arg_1_1:getChildByTag(1), "CCLayer")

		arg_1_0.spriteFrame = tolua.cast(var_3_0:getChildByTag(1), "CCSprite")
		arg_1_0.spriteIcon = tolua.cast(var_3_0:getChildByTag(2), "CCSprite")
		arg_1_0.spriteLevel = tolua.cast(arg_1_1:getChildByTag(2), "CCSprite")
		arg_1_0.lbLevelDummy = tolua.cast(arg_1_0.spriteLevel:getChildByTag(1), "CCLabelTTF")
		arg_1_0.lbName = tolua.cast(arg_1_1:getChildByTag(3), "CCLabelTTF")
		arg_1_0.lbdesc = tolua.cast(arg_1_1:getChildByTag(4), "CCLabelTTF")
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
		arg_1_0.lbLevel:setScale(0.56)

		arg_1_0.lbFight = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_1_0.lbFightDummy, arg_1_0.lbFight)
		arg_1_0.lbFight:setScale(0.56)

		arg_1_0.contentSizeHeight = arg_1_1:getContentSize().height * arg_1_1:getScaleY() * arg_1_2:getScaleY()
		arg_1_0.contentSizeWidth = arg_1_1:getContentSize().width * arg_1_1:getScaleX() * arg_1_2:getScaleX()
	end

	var_1_0()
	var_1_1()
end

function zbTipCommonWnd_Equip.refresh(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.layer:setVisible(true)

	arg_4_0.equipTemplateId = arg_4_2

	if arg_4_0.equipTemplateId == nil then
		arg_4_0.layer:setVisible(false)

		return
	end

	arg_4_0.layer:setVisible(true)
	arg_4_0.spriteLevel:setVisible(false)

	arg_4_0.equipRecord = nil
	arg_4_0.equipRecord = zbItemTable:getRecord(arg_4_0.equipTemplateId)

	if arg_4_0.equipRecord == nil then
		echoInfo("zbEquipDetail_Detail:refresh invalidId: " .. arg_4_0.equipTemplateId)

		return
	end

	arg_4_0.spriteFrame:setTexture(CCTextureCache:sharedTextureCache():addImage(zbColor:getEquipFrameTex(arg_4_0.equipRecord.quality)))
	arg_4_0.spriteIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(zbIconHelper:getItemIconPath(arg_4_0.equipRecord.id)))
	arg_4_0.lbName:setString(arg_4_0.equipRecord.name)
	arg_4_0.lbdesc:setString(arg_4_0.equipRecord.description)

	local var_4_0 = zbColor:getItemColor(arg_4_0.equipRecord.quality)

	arg_4_0.lbName:setColor(var_4_0)
	arg_4_0.lbFight:setString(g_Self.kBagEquipHandler:getFvBagEquip(arg_4_0.equipTemplateId))

	local var_4_1 = ""

	for iter_4_0, iter_4_1 in pairs(arg_4_0.equipRecord.mainAttrList) do
		local var_4_2 = a2u(getItemPropStr(iter_4_1.AttrType))

		if iter_4_1.AttrAdditionType == EAttrAdditionType.Fixed then
			var_4_1 = var_4_1 .. " " .. var_4_2 .. ":" .. iter_4_1.AttrValue
		else
			var_4_1 = var_4_1 .. " " .. var_4_2 .. ":" .. iter_4_1.AttrValue * 100 .. "%"
		end
	end

	arg_4_0.lbMainAttrName:setString(var_4_1)

	local var_4_3 = ""

	for iter_4_2, iter_4_3 in pairs(arg_4_0.equipRecord.subAttrList) do
		local var_4_4 = a2u(getItemPropStr(iter_4_3.AttrType))

		if iter_4_3.AttrAdditionType == EAttrAdditionType.Fixed then
			var_4_3 = var_4_3 .. " " .. var_4_4 .. ":" .. iter_4_3.AttrValue
		else
			var_4_3 = var_4_3 .. " " .. var_4_4 .. ":" .. iter_4_3.AttrValue * 100 .. "%"
		end
	end

	arg_4_0.lbSubAttr:setString(var_4_3)

	for iter_4_4 = 1, 5 do
		arg_4_0.layerGem[iter_4_4]:setVisible(false)
	end

	arg_4_0.layerAdd:setVisible(false)
	arg_4_0.spriteBg:setContentSize(CCSizeMake(380, 265))

	arg_4_0.contentSizeHeight = arg_4_0.spriteBg:getContentSize().height * arg_4_0.spriteBg:getScaleY() * arg_4_0.node:getScaleY()

	arg_4_0.layer:setPosition(-175, -235)
end

function createTipCommonWndEquip(arg_5_0, arg_5_1)
	local var_5_0 = zbTipCommonWnd_Equip.new()

	var_5_0:init(arg_5_0, arg_5_1)

	return var_5_0
end
