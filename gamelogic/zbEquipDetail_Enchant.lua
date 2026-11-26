require("gamelogic.zbEquipDetail_Enchant_Item")

zbEquipDetail_Enchant = class("zbEquipDetail_Enchant")
zbEquipDetail_Enchant.__index = zbEquipDetail_Enchant

function zbEquipDetail_Enchant.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.layer = arg_1_1

	local function var_1_0()
		arg_1_0.hero = nil
		arg_1_0.equip = nil
		arg_1_0.equipRecord = nil
	end

	local function var_1_1()
		arg_1_0.enableLayer = arg_1_1
		arg_1_0.parent = arg_1_2
		arg_1_0.holeItem = {}
		arg_1_0.highLight = {}
		arg_1_0.spriteActivate = tolua.cast(arg_1_0.enableLayer:getChildByTag(0), "CCLayerColor")

		for iter_3_0 = 1, 6 do
			arg_1_0.highLight[iter_3_0] = tolua.cast(arg_1_0.spriteActivate:getChildByTag(iter_3_0), "CCSprite")
		end

		arg_1_0.holeRoot = tolua.cast(arg_1_0.enableLayer:getChildByTag(1), "CCLayerColor")

		for iter_3_1 = 1, 5 do
			local var_3_0 = zbTableViewHelper:create()

			var_3_0:loadCCBFile("ccbi/tb_equip_gem.ccbi")

			local var_3_1 = tolua.cast(arg_1_0.holeRoot:getChildByTag(iter_3_1), "CCLayerColor")
			local var_3_2 = zbEquipDetail_Enchant_Item:create(translateAndStrokeHelper(var_3_0:readCCBNode()), iter_3_1)
			local var_3_3 = ccp(var_3_1:getPosition())

			var_3_2:setPosition(var_3_3.x, var_3_3.y)
			arg_1_0.holeRoot:addChild(var_3_2)
			var_3_1:removeFromParentAndCleanup(true)

			arg_1_0.holeItem[iter_3_1] = var_3_2

			var_3_0:releaseSelf()
		end

		arg_1_0.layerAttr = tolua.cast(arg_1_0.holeRoot:getChildByTag(6), "CCLayer")
		arg_1_0.lbAttrAdd = tolua.cast(arg_1_0.layerAttr:getChildByTag(1), "CCLabelTTF")
		arg_1_0.spriteMoney = tolua.cast(arg_1_0.enableLayer:getChildByTag(2), "CCSprite")
		arg_1_0.lbMoney = tolua.cast(arg_1_0.enableLayer:getChildByTag(3), "CCLabelTTF")
		arg_1_0.btnRule = tolua.cast(arg_1_0.enableLayer:getChildByTag(4), "CCControlButton")
		arg_1_0.btnXilian = tolua.cast(arg_1_0.enableLayer:getChildByTag(5), "CCControlButton")
		arg_1_0.lbHave = tolua.cast(arg_1_0.enableLayer:getChildByTag(6), "CCLabelTTF")

		arg_1_0.btnRule:addHandleOfControlEvent(function()
			arg_1_0:onRule()
		end, CCControlEventTouchUpInside)
		arg_1_0.btnXilian:addHandleOfControlEvent(function()
			arg_1_0:onXiLian()
		end, CCControlEventTouchUpInside)
	end

	var_1_0()
	var_1_1()
end

function zbEquipDetail_Enchant.refresh(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.heroTemplateId = arg_6_1
	arg_6_0.equip = arg_6_2

	if arg_6_2 == nil then
		return
	end

	if zbItemTable:getRecord(arg_6_2.TemplateId) == nil then
		echoInfo("fail to get item record: " .. tostring(equp.TemplateId))

		return
	end

	arg_6_0.lbHave:setString(g_Self.kBagItemHandler:getItemCount(EItemType.Material, EMaterialType.GemOpenHole))
	arg_6_0.lbMoney:setString(5)

	local var_6_0 = table.getn(arg_6_2.GemList)

	if var_6_0 > 0 then
		arg_6_0.spriteMoney:setVisible(true)
		arg_6_0.lbMoney:setVisible(true)
		arg_6_0.btnXilian:setVisible(true)
	else
		arg_6_0.spriteMoney:setVisible(false)
		arg_6_0.lbMoney:setVisible(false)
		arg_6_0.btnXilian:setVisible(false)
	end

	arg_6_0:processHole(var_6_0)

	if arg_6_2.AttrInfo.Addition == 0 then
		arg_6_0.layerAttr:setVisible(false)
	else
		arg_6_0.layerAttr:setVisible(true)
		arg_6_0.lbAttrAdd:setString(a2u("\xD6\xF7\xCA\xF4\xD0\xD4+") .. arg_6_0.equip.AttrInfo.Addition * 100 .. "%")
	end
end

function zbEquipDetail_Enchant.processHole(arg_7_0, arg_7_1)
	for iter_7_0 = 1, 6 do
		arg_7_0.highLight[iter_7_0]:setVisible(false)

		local var_7_0 = arg_7_0.holeItem[iter_7_0]

		if var_7_0 then
			var_7_0:refreshLight(false)
		end
	end

	local var_7_1 = 1

	for iter_7_1, iter_7_2 in pairs(arg_7_0.equip.GemList) do
		local var_7_2 = var_7_1 + 1

		if var_7_1 == 5 then
			var_7_2 = 1
		end

		local var_7_3 = arg_7_0.holeItem[var_7_1]

		var_7_3:refresh(iter_7_2, arg_7_0.heroTemplateId, arg_7_0.equip)

		if arg_7_0.equip.GemList[var_7_2] ~= nil and arg_7_0.equip.GemList[var_7_2].GemShape == g_Self.kBagEquipHandler.activateOrder[iter_7_2.GemShape] then
			arg_7_0.highLight[var_7_1]:setVisible(true)
			arg_7_0.highLight[6]:setVisible(true)
			var_7_3:refreshLight(true)
			arg_7_0.holeItem[var_7_2]:refreshLight(true)
		end

		var_7_1 = var_7_1 + 1
	end

	for iter_7_3 = arg_7_1 + 1, 5 do
		arg_7_0.holeItem[iter_7_3]:refresh(nil, arg_7_0.heroTemplateId, arg_7_0.equip)
	end
end

function zbEquipDetail_Enchant.onRule(arg_8_0)
	g_MainScene:showRuleEquipWuXingWnd()
end

function zbEquipDetail_Enchant.onXiLian(arg_9_0)
	g_MainScene:showXilianYesWnd(1, arg_9_0.equip, arg_9_0.heroTemplateId)
end

function createEquipDetail_Enchant(arg_10_0, arg_10_1)
	local var_10_0 = zbEquipDetail_Enchant.new()

	var_10_0:init(arg_10_0, arg_10_1)

	return var_10_0
end
