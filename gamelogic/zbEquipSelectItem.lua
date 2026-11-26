require("gamebase.zbFunctions")

zbEquipSelectItem = class("zbEquipSelectItem", CCNodeExtend)
zbEquipSelectItem.__index = zbEquipSelectItem

function zbEquipSelectItem.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbEquipSelectItem)

	return arg_1_0
end

function zbEquipSelectItem.create(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = zbEquipSelectItem.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1, arg_2_2)

	return var_2_0
end

function zbEquipSelectItem.init(arg_3_0, arg_3_1, arg_3_2)
	function initMember()
		arg_3_0.EquipBaseData = nil
		arg_3_0.heroTemplateId = 0
		arg_3_0.equipTemplateId = 0
	end

	function initCCB()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		arg_3_0.layerSperator = tolua.cast(arg_3_1:getChildByTag(2), "CCNode")
		arg_3_0.layerContent = var_5_0
		arg_3_0.btnTouch = tolua.cast(var_5_0:getChildByTag(101), "CCControlButton")
		arg_3_0.spriteSelect = tolua.cast(var_5_0:getChildByTag(2), "CCSprite")
		arg_3_0.spriteFrame = tolua.cast(var_5_0:getChildByTag(1), "CCSprite")
		arg_3_0.spriteIcon = tolua.cast(arg_3_0.spriteFrame:getChildByTag(1), "CCSprite")
		arg_3_0.lbNumDummy = tolua.cast(arg_3_0.spriteFrame:getChildByTag(1002), "CCLabelTTF")
		arg_3_0.lbName = tolua.cast(arg_3_0.spriteFrame:getChildByTag(3), "CCLabelTTF")

		arg_3_0.btnTouch:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnTouch:setSwallowsTouches(false)
		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)

		arg_3_0.lbNum = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbNumDummy, arg_3_0.lbNum)
		arg_3_0.lbNum:setScale(0.55)
		arg_3_0:setContentSize(var_5_0:getContentSize())
		arg_3_0:addChild(arg_3_1)
	end

	initMember()
	initCCB()
end

function zbEquipSelectItem.refreshData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.spriteSelect:setVisible(false)
	arg_7_0:setVisible(true)

	arg_7_0.data = arg_7_2

	arg_7_0.layerContent:setVisible(false)
	arg_7_0.layerSperator:setVisible(false)

	if arg_7_2.isSpeartor ~= nil and arg_7_2.isSpeartor then
		arg_7_0.layerSperator:setVisible(true)
	elseif arg_7_2.isSpeartor2 ~= nil and arg_7_2.isSpeartor2 then
		arg_7_0:setVisible(false)
	elseif arg_7_2.isEmpty ~= nil and arg_7_2.isEmpty then
		arg_7_0:setVisible(false)
	elseif arg_7_2.equip ~= nil then
		arg_7_0.layerContent:setVisible(true)
		arg_7_0:refresh(arg_7_1, arg_7_2.equip)
	elseif arg_7_2.templateId ~= nil and arg_7_2.templateId > 0 then
		arg_7_0.layerContent:setVisible(true)
		arg_7_0:refreshEquipId(arg_7_1, arg_7_2.templateId)
	end
end

function zbEquipSelectItem.refresh(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.heroTemplateId = arg_8_1
	arg_8_0.EquipBaseData = arg_8_2

	arg_8_0:setVisible(arg_8_0.EquipBaseData ~= nil)

	if arg_8_0.EquipBaseData ~= nil then
		arg_8_0.TemplateId = arg_8_0.EquipBaseData.TemplateId

		local var_8_0 = zbItemTable:getRecord(arg_8_0.EquipBaseData.TemplateId)

		if var_8_0 ~= nil then
			arg_8_0.lbNum:setString(arg_8_0.EquipBaseData.Level)
			arg_8_0.lbNum:setVisible(true)

			local var_8_1 = zbIconHelper:getItemIconPath(arg_8_0.EquipBaseData.TemplateId)

			arg_8_0.spriteIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_8_1))
			arg_8_0.lbName:setString(var_8_0.name)

			local var_8_2 = zbColor:getItemColor(var_8_0.quality)
			local var_8_3 = zbColor:getEquipFrameTex(var_8_0.quality)

			arg_8_0.lbName:setColor(var_8_2)
			arg_8_0.spriteFrame:setTexture(CCTextureCache:sharedTextureCache():addImage(var_8_3))
		end
	end
end

function zbEquipSelectItem.refreshEquipId(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.heroTemplateId = arg_9_1
	arg_9_0.equipTemplateId = arg_9_2

	arg_9_0:setVisible(arg_9_0.equipTemplateId ~= nil)

	arg_9_0.EquipBaseData = nil
	arg_9_0.TemplateId = arg_9_2

	if arg_9_0.equipTemplateId ~= nil then
		local var_9_0 = zbItemTable:getRecord(arg_9_0.equipTemplateId)

		if var_9_0 ~= nil then
			arg_9_0.lbNum:setVisible(false)

			local var_9_1 = zbIconHelper:getItemIconPath(arg_9_0.equipTemplateId)

			arg_9_0.spriteIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_9_1))
			arg_9_0.lbName:setString(var_9_0.name)

			local var_9_2 = zbColor:getItemColor(var_9_0.quality)
			local var_9_3 = zbColor:getEquipFragFrameTex(var_9_0.quality)

			arg_9_0.lbName:setColor(var_9_2)
			arg_9_0.spriteFrame:setTexture(CCTextureCache:sharedTextureCache():addImage(var_9_3))
		end
	end
end

function zbEquipSelectItem.onTouch(arg_10_0)
	if arg_10_0.EquipBaseData ~= nil then
		g_MainScene.wndEquipSelect.panelDetail:refreshByEquip(arg_10_0.heroTemplateId, arg_10_0.EquipBaseData)
		g_MainScene.wndEquipSelect:refreshExistSelectItem(arg_10_0.EquipBaseData.EquipId)
	else
		g_MainScene.wndEquipSelect.panelDetail:refreshByEquipId(arg_10_0.heroTemplateId, arg_10_0.equipTemplateId)
		g_MainScene.wndEquipSelect:refreshNonExistSelectItem(arg_10_0.equipTemplateId)
	end
end

function zbEquipSelectItem.refreshExistSelectItem(arg_11_0, arg_11_1)
	if arg_11_0.data.equip then
		if arg_11_1 == arg_11_0.EquipBaseData.EquipId then
			arg_11_0.spriteSelect:setVisible(true)
			arg_11_0.spriteSelect:setTexture(CCTextureCache:sharedTextureCache():addImage("image/frame/itemframe/itemsel.png"))
		else
			arg_11_0.spriteSelect:setVisible(false)
		end
	else
		arg_11_0.spriteSelect:setVisible(false)
	end
end

function zbEquipSelectItem.refreshNonExistSelectItem(arg_12_0, arg_12_1)
	if arg_12_0.data.equip then
		arg_12_0.spriteSelect:setVisible(false)
	elseif arg_12_1 == arg_12_0.equipTemplateId then
		arg_12_0.spriteSelect:setVisible(true)
		arg_12_0.spriteSelect:setTexture(CCTextureCache:sharedTextureCache():addImage("image/frame/itemfragframe/itemfragsel.png"))
	else
		arg_12_0.spriteSelect:setVisible(false)
	end
end
