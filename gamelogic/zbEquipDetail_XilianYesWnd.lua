require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbEquipDetail_XilianYesWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createEquipXilianYesWnd()
	local var_1_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_1_0:initBase()
	var_1_0:init()

	return var_1_0
end

function var_0_0.extend(arg_2_0)
	local var_2_0 = tolua.getpeer(arg_2_0)

	if not var_2_0 then
		var_2_0 = {}

		tolua.setpeer(arg_2_0, var_2_0)
	end

	setmetatable(var_2_0, var_0_0)

	return arg_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.optType = EExchangeType.Gold
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/equip_xilian.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")
		arg_3_0.spriteTitle = tolua.cast(var_5_2:getChildByTag(1), "CCSprite")
		arg_3_0.lbDesc1 = tolua.cast(var_5_2:getChildByTag(2), "CCLabelTTF")
		arg_3_0.btnYes = tolua.cast(var_5_2:getChildByTag(4), "CCControlButton")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnYes:addHandleOfControlEvent(function()
			arg_3_0:onYes()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	arg_8_0.optType = arg_8_1
	arg_8_0.heroTemplateId = arg_8_3
	arg_8_0.equip = arg_8_2
	arg_8_0.index = arg_8_4

	if arg_8_0.optType == 1 then
		arg_8_0.spriteTitle:setTexture(CCTextureCache:sharedTextureCache():addImage("image/equip/equip_cuilianyes.png"))
		arg_8_0.lbDesc1:setString(a2u("\xC1\xE9\xB2\xDBϴ\xC1\xB7\xD0\xE8Ҫ\xBB\xA8\xB7\xD15\xB8\xF6\xBD\xE2ӡ\xB7\xFB\xA3\xAC\xCAǷ\xF1\xBD\xF8\xD0\xD0ϴ\xC1\xB7\xA3\xBF"))
	else
		local var_8_0 = zbEquipHoleTable:getRecord(arg_8_0.index)

		arg_8_0.spriteTitle:setTexture(CCTextureCache:sharedTextureCache():addImage("image/equip/equip_kaikongyes.png"))
		arg_8_0.lbDesc1:setString(a2u("\xC1\xE9\xB2ۿ\xAA\xBF\xD7\xD0\xE8Ҫ\xBB\xA8\xB7\xD1") .. var_8_0.cost .. a2u("\xB8\xF6\xBD\xE2ӡ\xB7\xFB\xA3\xAC\xCAǷ\xF1\xBD\xF8\xD0п\xAA\xBFף\xBF"))
	end
end

function var_0_0.onYes(arg_9_0)
	local var_9_0 = g_Self.kBagItemHandler:getItemCount(EItemType.Material, EMaterialType.GemOpenHole)

	if arg_9_0.heroTemplateId and arg_9_0.heroTemplateId > 0 then
		if arg_9_0.equip then
			equipSlot = {}
			equipSlot.SlotType = EEquipSlotType.Hero
			equipSlot.HeroTid = arg_9_0.heroTemplateId
			equipSlot.EquipId = arg_9_0.equip.EquipId
		end
	elseif arg_9_0.equip then
		equipSlot = {}
		equipSlot.SlotType = EEquipSlotType.Bag
		equipSlot.HeroTid = 0
		equipSlot.EquipId = arg_9_0.equip.EquipId
	end

	if arg_9_0.optType == 1 then
		if var_9_0 < 5 then
			g_Bubble:bubbleInfo(a2u("\xBD\xE2ӡ\xB7\xFB\xB2\xBB\xD7\xE3"))

			return
		end

		g_WsMsgHandler:WS_Equip_RefreshHole_Req(equipSlot)
		arg_9_0:hide()
	else
		if var_9_0 < zbEquipHoleTable:getRecord(arg_9_0.index).cost then
			g_Bubble:bubbleInfo(a2u("\xBD\xE2ӡ\xB7\xFB\xB2\xBB\xD7\xE3"))

			return
		end

		g_WsMsgHandler:WS_Equip_OpenHole_Req(equipSlot)
		arg_9_0:hide()
	end
end
