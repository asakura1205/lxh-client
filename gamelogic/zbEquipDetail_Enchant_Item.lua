zbEquipDetail_Enchant_Item = class("zbEquipDetail_Enchant_Item", CCNodeExtend)
zbEquipDetail_Enchant_Item.__index = zbEquipDetail_Enchant_Item

local var_0_0 = "image/equip/equip_holestate0.png"
local var_0_1 = "image/equip/equip_holestate1.png"
local var_0_2 = "image/equip/equip_holestate2.png"

function zbEquipDetail_Enchant_Item.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbEquipDetail_Enchant_Item)

	return arg_1_0
end

function zbEquipDetail_Enchant_Item.create(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = zbEquipDetail_Enchant_Item.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1, arg_2_2)

	return var_2_0
end

function zbEquipDetail_Enchant_Item.init(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0()
		arg_3_0.hero = nil
		arg_3_0.equip = nil
		arg_3_0.equipRecord = nil
		arg_3_0.index = nil
	end

	local function var_3_1(arg_5_0)
		local var_5_0 = CCSprite:create(NOTIFY_TAG_PATH)

		var_5_0:setAnchorPoint(ccp(0.5, 0.5))
		var_5_0:setPosition(arg_5_0:getContentSize().width - 25, arg_5_0:getContentSize().height - 25)
		var_5_0:setVisible(false)
		arg_5_0:addChild(var_5_0)
		zbUIEffect:createNotifyTagScaleAction(var_5_0)

		return var_5_0
	end

	local function var_3_2()
		arg_3_0.index = arg_3_2
		arg_3_0.layerContent = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")
		arg_3_0.btn = tolua.cast(arg_3_0.layerContent:getChildByTag(100), "CCControlButton")
		arg_3_0.holeFrame = tolua.cast(arg_3_0.layerContent:getChildByTag(1), "CCSprite")
		arg_3_0.holeLight = tolua.cast(arg_3_0.layerContent:getChildByTag(3), "CCSprite")
		arg_3_0.holeIcon = tolua.cast(arg_3_0.layerContent:getChildByTag(2), "CCSprite")
		arg_3_0.holeName = tolua.cast(arg_3_0.layerContent:getChildByTag(4), "CCLabelTTF")
		arg_3_0.notify = var_3_1(arg_3_0.holeIcon)

		arg_3_0.btn:addHandleOfControlEvent(function()
			arg_3_0:btnGemOpt()
		end, CCControlEventTouchUpInside)
		arg_3_0.btn:setZoomOnTouchDown(false)
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_2()
end

function zbEquipDetail_Enchant_Item.refresh(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0.heroTemplateId = arg_8_2
	arg_8_0.gemSlotDetail = arg_8_1
	arg_8_0.equip = arg_8_3

	local var_8_0 = zbEquipHoleTable:getRecord(arg_8_0.index)

	arg_8_0.holeIcon:setMaskTexture(nil)
	arg_8_0.holeName:setColor(FONT_COLOR_WHITE)
	arg_8_0.holeLight:setVisible(false)

	if arg_8_1 then
		arg_8_0.holeFrame:setVisible(true)
		arg_8_0.holeLight:setVisible(true)
		arg_8_0.holeFrame:setTexture(CCTextureCache:sharedTextureCache():addImage("image/equip/equip_gemframe0" .. arg_8_1.GemShape .. ".png"))
		arg_8_0.holeLight:setTexture(CCTextureCache:sharedTextureCache():addImage("image/equip/equip_gemactivate0" .. arg_8_1.GemShape .. ".png"))

		if arg_8_1.TemplateId == 0 then
			arg_8_0.holeIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_0_2))
			arg_8_0.holeName:setString(a2u("\xBFɸ\xBD\xC1\xE9"))

			local var_8_1 = g_Self.kBagItemHandler:getGemsAtType(arg_8_1.GemShape)

			arg_8_0.notify:setVisible(table.getn(var_8_1) ~= 0)
		else
			local var_8_2 = zbItemTable:getRecord(arg_8_1.TemplateId)

			arg_8_0.holeName:setString(var_8_2.name)

			local var_8_3 = zbColor:getItemColor(var_8_2.quality)

			arg_8_0.holeName:setColor(var_8_3)
			arg_8_0.holeIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(zbIconHelper:getItemIconPath(arg_8_1.TemplateId)))

			local var_8_4 = g_Self.kBagItemHandler:getGemsAtType(arg_8_1.GemShape)
			local var_8_5 = false

			for iter_8_0, iter_8_1 in pairs(var_8_4) do
				if zbItemTable:getRecord(iter_8_1.TemplateId).quality > var_8_2.quality then
					var_8_5 = true

					break
				end
			end

			arg_8_0.notify:setVisible(var_8_5)
		end
	else
		if var_8_0.lvl <= arg_8_0.equip.Level then
			arg_8_0.holeIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_0_1))
			arg_8_0.holeName:setString(a2u("\xBFɽ\xE2ӡ"))

			if arg_8_0.index - table.getn(arg_8_0.equip.GemList) >= 2 then
				arg_8_0.holeIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_0_0))
				arg_8_0.holeName:setString(a2u("(\xCFȽ\xE2ӡ\xB5͵ȼ\xB6\xB2\xDB)"))
			end
		else
			arg_8_0.holeIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_0_0))
			arg_8_0.holeName:setString("(" .. var_8_0.lvl .. a2u("\xBC\xB6\xBD\xE2\xCB\xF8)"))
		end

		arg_8_0.holeFrame:setVisible(false)
		arg_8_0.notify:setVisible(false)
	end
end

function zbEquipDetail_Enchant_Item.refreshTip(arg_9_0, arg_9_1)
	arg_9_0.holeFrame:setVisible(true)

	local var_9_0 = zbItemTable:getRecord(arg_9_1.TemplateId)

	arg_9_0.holeName:setVisible(false)
	arg_9_0.holeLight:setVisible(false)
	arg_9_0.btn:setVisible(false)
	arg_9_0.holeIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(zbIconHelper:getItemIconPath(arg_9_1.TemplateId)))
	arg_9_0.holeFrame:setTexture(CCTextureCache:sharedTextureCache():addImage("image/equip/equip_gemframe0" .. arg_9_1.GemShape .. ".png"))
end

function zbEquipDetail_Enchant_Item.btnGemOpt(arg_10_0)
	local var_10_0 = zbEquipHoleTable:getRecord(arg_10_0.index)
	local var_10_1 = g_Self.kBagItemHandler:getItemCount(EItemType.Material, EMaterialType.GemOpenHole)

	if var_10_0.lvl > arg_10_0.equip.Level then
		g_Bubble:bubbleInfo(a2u("װ\xB1\xB8\xB5ȼ\xB6\xB2\xBB\xD7\xE3"))

		return
	end

	if arg_10_0.index - table.getn(arg_10_0.equip.GemList) >= 2 then
		g_Bubble:bubbleInfo(a2u("\xCFȽ\xE2ӡ\xB5͵ȼ\xB6\xB2\xDB"))

		return
	end

	if arg_10_0.gemSlotDetail == nil then
		g_MainScene:showXilianYesWnd(0, arg_10_0.equip, arg_10_0.heroTemplateId, arg_10_0.index)
	elseif arg_10_0.gemSlotDetail.TemplateId == 0 then
		g_MainScene:showGemsSelect(arg_10_0.gemSlotDetail, arg_10_0.heroTemplateId, arg_10_0.equip, arg_10_0.index)
	else
		local var_10_2 = g_MainScene:showEquipGemTip(arg_10_0.gemSlotDetail, arg_10_0.heroTemplateId, arg_10_0.equip, arg_10_0.index)
		local var_10_3 = arg_10_0.btn

		while var_10_3:getParent() ~= nil do
			var_10_3 = var_10_3:getParent()
		end

		arg_10_0.lastDownTouch = arg_10_0.btn:getTouch():getLocation()

		local var_10_4 = var_10_3:convertToNodeSpace(arg_10_0.lastDownTouch)

		var_10_2:refreshPos(var_10_4)
	end
end

function zbEquipDetail_Enchant_Item.refreshLight(arg_11_0, arg_11_1)
	arg_11_0.holeLight:setVisible(arg_11_1)
end
