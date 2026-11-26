zbEquipDetail_Upgrade = class("zbEquipDetail_Upgrade")
zbEquipDetail_Upgrade.__index = zbEquipDetail_Upgrade

local var_0_0 = 100

function zbEquipDetail_Upgrade.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.layer = arg_1_1

	local function var_1_0()
		arg_1_0.equip = nil
		arg_1_0.hero = nil
	end

	local function var_1_1()
		arg_1_0.parent = arg_1_2

		local var_3_0 = tolua.cast(arg_1_0.layer:getChildByTag(9), "CCNode")

		arg_1_0.name = tolua.cast(var_3_0:getChildByTag(4), "CCLabelTTF")
		arg_1_0.spriteIcon = tolua.cast(var_3_0:getChildByTag(2), "CCSprite")
		arg_1_0.spriteFrame = tolua.cast(var_3_0:getChildByTag(1), "CCSprite")

		local var_3_1 = tolua.cast(var_3_0:getChildByTag(3), "CCSprite")

		arg_1_0.headLevelDummy = tolua.cast(var_3_1:getChildByTag(1), "CCLabelTTF")
		arg_1_0.headLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_1_0.headLevelDummy, arg_1_0.headLevel)
		arg_1_0.headLevel:setScale(0.55)

		local var_3_2 = tolua.cast(arg_1_0.layer:getChildByTag(2), "CCSprite")

		arg_1_0.curLevelDummy = tolua.cast(var_3_2:getChildByTag(1), "CCLabelTTF")

		local var_3_3 = tolua.cast(arg_1_0.layer:getChildByTag(3), "CCSprite")

		arg_1_0.nextLevelDummy = tolua.cast(var_3_3:getChildByTag(1), "CCLabelTTF")
		arg_1_0.curMainPropName = tolua.cast(arg_1_0.layer:getChildByTag(4), "CCLabelTTF")
		arg_1_0.curMainPropDummy = tolua.cast(arg_1_0.layer:getChildByTag(5), "CCLabelTTF")
		arg_1_0.nextMainPropDummy = tolua.cast(arg_1_0.layer:getChildByTag(6), "CCLabelTTF")

		local var_3_4 = tolua.cast(arg_1_0.layer:getChildByTag(10), "CCNode")

		arg_1_0.cost1Dummy = tolua.cast(var_3_4:getChildByTag(3), "CCLabelTTF")
		arg_1_0.costIcon1 = tolua.cast(var_3_4:getChildByTag(2), "CCSprite")

		local var_3_5 = tolua.cast(arg_1_0.layer:getChildByTag(11), "CCNode")

		arg_1_0.cost10Dummy = tolua.cast(var_3_5:getChildByTag(3), "CCLabelTTF")
		arg_1_0.costIcon10 = tolua.cast(var_3_5:getChildByTag(2), "CCSprite")
		arg_1_0.btnOpt1 = tolua.cast(arg_1_0.layer:getChildByTag(7), "CCControlButton")
		arg_1_0.btnOpt10 = tolua.cast(arg_1_0.layer:getChildByTag(8), "CCControlButton")
		arg_1_0.curLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_1_0.curLevelDummy, arg_1_0.curLevel)
		arg_1_0.curLevel:setScale(0.55)

		arg_1_0.nextLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_1_0.nextLevelDummy, arg_1_0.nextLevel)
		arg_1_0.nextLevel:setScale(0.55)

		arg_1_0.curMainProp = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_1_0.curMainPropDummy, arg_1_0.curMainProp)
		arg_1_0.curMainProp:setScale(0.55)

		arg_1_0.nextMainProp = CCLabelAtlas:create("", "font/rank_num_green.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_1_0.nextMainPropDummy, arg_1_0.nextMainProp)
		arg_1_0.nextMainProp:setScale(0.55)

		arg_1_0.cost1 = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_1_0.cost1Dummy, arg_1_0.cost1)
		arg_1_0.cost1:setScale(0.55)

		arg_1_0.cost10 = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_1_0.cost10Dummy, arg_1_0.cost10)
		arg_1_0.cost10:setScale(0.55)
		arg_1_0.btnOpt1:addHandleOfControlEvent(handler(arg_1_0, arg_1_0.onUpgrade), CCControlEventTouchUpInside)
		arg_1_0.btnOpt10:addHandleOfControlEvent(handler(arg_1_0, arg_1_0.onUpgradeSuper), CCControlEventTouchUpInside)
	end

	var_1_0()
	var_1_1()
end

function zbEquipDetail_Upgrade.refresh(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.equip = arg_4_2
	arg_4_0.heroTemplateId = arg_4_1

	if arg_4_2 == nil then
		return
	end

	local var_4_0 = zbItemTable:getRecord(arg_4_2.TemplateId)

	if var_4_0 == nil then
		echoInfo("fail to get item record: " .. tostring(arg_4_2.TemplateId))

		return
	end

	arg_4_0.equipRecord = var_4_0

	arg_4_0.spriteFrame:setTexture(CCTextureCache:sharedTextureCache():addImage(zbColor:getEquipFrameTex(arg_4_2.Quality)))
	arg_4_0.spriteIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(zbIconHelper:getItemIconPath(arg_4_2.TemplateId)))
	arg_4_0.layer:setVisible(true)
	arg_4_0.name:setString(var_4_0.name)

	local var_4_1 = zbColor:getItemColor(arg_4_2.Quality)

	arg_4_0.name:setColor(var_4_1)
	arg_4_0.curLevel:setString(arg_4_2.Level)
	arg_4_0.headLevel:setString(arg_4_2.Level)

	if arg_4_2.CLevel == nil then
		arg_4_2.CLevel = 0
	end

	if arg_4_2.CLevel ~= 0 then
		arg_4_0.name:setString(var_4_0.name .. "+" .. arg_4_2.CLevel)
	end

	local var_4_2 = arg_4_0.equip.AttrInfo.MAttr[1]
	local var_4_3 = a2u(getItemPropStr(var_4_2[1]))

	arg_4_0.curMainPropName:setString(var_4_3)
	arg_4_0.curMainProp:setString(var_4_2[3])

	local var_4_4 = 0
	local var_4_5 = var_4_0.mainAttrList[1]

	if var_4_5.AttrAdditionType == EAttrAdditionType.Fixed then
		var_4_4 = (var_4_5.AttrValue + var_4_5.AttrValueGrow * arg_4_2.Level) * (1 + arg_4_0.equip.AttrInfo.Addition)
	else
		var_4_4 = (var_4_5.AttrValue + var_4_5.AttrValueGrow * arg_4_2.Level) * (1 + arg_4_0.equip.AttrInfo.Addition) * 100 .. "%"
	end

	arg_4_0.nextMainProp:setString(var_4_4)
	arg_4_0.nextLevel:setString(arg_4_2.Level + 1)

	local var_4_6 = arg_4_0:getCostFoOnce(arg_4_2, var_4_0)

	arg_4_0.cost1:setString(var_4_6)

	local var_4_7 = arg_4_0:getCostFoTenTimes(arg_4_2, var_4_0)

	arg_4_0.cost10:setString(var_4_7)
	arg_4_0.btnOpt1:setVisible(true)
	arg_4_0.btnOpt10:setVisible(true)
end

function zbEquipDetail_Upgrade.onUpgrade(arg_5_0)
	local var_5_0 = arg_5_0.heroTemplateId
	local var_5_1 = arg_5_0.equip

	if var_5_1 == nil then
		return
	end

	if var_5_1.Level >= g_Self:getLevel() then
		g_Bubble:bubbleInfo(a2u("\xB2\xBB\xC4ܳ\xAC\xB9\xFD\xCD\xE6\xBCҵĵȼ\xB6"))

		return
	end

	local var_5_2 = tonumber(arg_5_0.cost1:getString())

	if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Gold, var_5_2) == false then
		g_Bubble:bubbleInfo(a2u("\xBD\xF0\xDF\xF7\xB1Ҳ\xBB\xD7\xE3"))

		return
	end

	local var_5_3 = {}

	if arg_5_0.heroTemplateId and arg_5_0.heroTemplateId > 0 then
		if var_5_1 then
			var_5_3.SlotType = EEquipSlotType.Hero
			var_5_3.HeroTid = var_5_0
			var_5_3.EquipId = var_5_1.EquipId
		end
	elseif var_5_1 then
		var_5_3.SlotType = EEquipSlotType.Bag
		var_5_3.HeroTid = 0
		var_5_3.EquipId = var_5_1.EquipId
	end

	if var_5_3 then
		g_WsMsgHandler:WS_Equip_Upgrade_Req(var_5_3, var_5_1.Level + 1)
	end
end

function zbEquipDetail_Upgrade.onUpgradeSuper(arg_6_0)
	local var_6_0 = arg_6_0.heroTemplateId
	local var_6_1 = arg_6_0.equip

	if var_6_1 == nil then
		g_Bubble:bubbleInfo(a2u(""))

		return
	end

	if var_6_1.Level >= g_Self:getLevel() then
		g_Bubble:bubbleInfo(a2u("\xB2\xBB\xC4ܳ\xAC\xB9\xFD\xCD\xE6\xBCҵĵȼ\xB6"))

		return
	end

	local var_6_2 = tonumber(arg_6_0.cost10:getString())

	if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Gold, var_6_2) == false then
		g_Bubble:bubbleInfo(a2u("\xBD\xF0\xDF\xF7\xB1Ҳ\xBB\xD7\xE3"))

		return
	end

	local var_6_3

	if arg_6_0.heroTemplateId and arg_6_0.heroTemplateId > 0 then
		if var_6_1 then
			var_6_3 = {
				SlotType = EEquipSlotType.Hero,
				HeroTid = var_6_0,
				EquipId = var_6_1.EquipId
			}
		end
	elseif var_6_1 then
		var_6_3 = {
			SlotType = EEquipSlotType.Bag
		}
		var_6_3.HeroTid = 0
		var_6_3.EquipId = var_6_1.EquipId
	end

	local var_6_4 = var_6_1.Level + 10

	if var_6_4 > g_Self:getLevel() then
		var_6_4 = g_Self:getLevel()
	end

	if var_6_3 then
		g_WsMsgHandler:WS_Equip_Upgrade_Req(var_6_3, var_6_4)
	end
end

function zbEquipDetail_Upgrade.getCostFoOnce(arg_7_0, arg_7_1, arg_7_2)
	return zbEquipUpgradeTable:getRecord(arg_7_1.Level).costValue[arg_7_2.quality]
end

function zbEquipDetail_Upgrade.getCostFoTenTimes(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1.Level + 9

	if var_8_0 > g_Self:getLevel() then
		var_8_0 = g_Self:getLevel()
	end

	local var_8_1 = 0

	for iter_8_0 = arg_8_1.Level, var_8_0 do
		local var_8_2 = zbEquipUpgradeTable:getRecord(iter_8_0)

		if var_8_2 ~= nil then
			var_8_1 = var_8_1 + var_8_2.costValue[arg_8_2.quality]
		end
	end

	return var_8_1
end

function createEquipDetail_Upgrade(arg_9_0, arg_9_1)
	local var_9_0 = zbEquipDetail_Upgrade.new()

	var_9_0:init(arg_9_0, arg_9_1)

	return var_9_0
end
