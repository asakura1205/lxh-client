require("gamelogic.zbBaseWnd")
require("gamelogic.zbFormationHeroListPanel")
require("gamelogic.zbFormationListPanel")
require("gamelogic.zbFormationSlotPanel")
require("gamelogic.zbFormationFateTip")
require("gamelogic.zbFormationSupportTip")
require("gamelogic.zbFormationBlessTip")
require("gamecore.zbFormationBubble")
require("gamecore.zbFormationHelper")
require("gamecore.zbCombatScene")

zbFormationWnd = class("zbFormationWnd", zbBaseWnd)
zbFormationWnd.__index = zbFormationWnd

function createFormationWnd()
	local var_1_0 = zbFormationWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_1_0:initBase()
	var_1_0:init()

	return var_1_0
end

function zbFormationWnd.extend(arg_2_0)
	local var_2_0 = tolua.getpeer(arg_2_0)

	if not var_2_0 then
		var_2_0 = {}

		tolua.setpeer(arg_2_0, var_2_0)
	end

	setmetatable(var_2_0, zbFormationWnd)

	return arg_2_0
end

function zbFormationWnd.init(arg_3_0)
	local function var_3_0()
		arg_3_0.lastTechId = 0
		arg_3_0.btnCount = 1
		arg_3_0.autoFormation = false
		arg_3_0.formEmbattleWnd = false
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/formation.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")

		arg_3_0.btnAutoFormation = tolua.cast(var_5_1:getChildByTag(30), "CCControlButton")
		arg_3_0.btnClose = tolua.cast(var_5_1:getChildByTag(31), "CCControlButton")
		arg_3_0.panelHeroList = createFormationHeroListPanel(arg_3_0, tolua.cast(var_5_1:getChildByTag(1), "CCNode"), arg_3_0.btnClose)
		arg_3_0.panelFormationSlots = createFormationSlotPanel(arg_3_0, var_5_1)
		arg_3_0.nodeGod = tolua.cast(var_5_1:getChildByTag(3), "CCNode")
		arg_3_0.btnGodFrame = tolua.cast(arg_3_0.nodeGod:getChildByTag(1), "CCControlButton")
		arg_3_0.spriteGodIcon = tolua.cast(arg_3_0.nodeGod:getChildByTag(2), "CCSprite")
		arg_3_0.lbGodLevelDummy = tolua.cast(arg_3_0.nodeGod:getChildByTag(3), "CCLabelTTF")
		arg_3_0.lbGodLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbGodLevelDummy, arg_3_0.lbGodLevel)
		arg_3_0.lbGodLevel:setScale(0.55)

		arg_3_0.spriteTech = tolua.cast(var_5_1:getChildByTag(4), "CCSprite")

		local var_5_2 = tolua.cast(arg_3_0.spriteTech:getChildByTag(1), "CCSprite")

		arg_3_0.lbTechLevelDummy = tolua.cast(arg_3_0.spriteTech:getChildByTag(1), "CCLabelTTF")
		arg_3_0.btnTech = tolua.cast(arg_3_0.spriteTech:getChildByTag(2), "CCControlButton")
		arg_3_0.lbTechLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		arg_3_0.lbTechLevel:setScale(0.55)
		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbTechLevelDummy, arg_3_0.lbTechLevel)

		arg_3_0.nodeShapeTip = tolua.cast(var_5_1:getChildByTag(5), "CCNode")
		arg_3_0.spriteShape = tolua.cast(arg_3_0.nodeShapeTip:getChildByTag(1), "CCSprite")
		arg_3_0.spriteShapeName = tolua.cast(arg_3_0.spriteShape:getChildByTag(1), "CCSprite")
		arg_3_0.shapeBubble = zbFormationBubble:create()

		arg_3_0.nodeShapeTip:addChild(arg_3_0.shapeBubble)

		arg_3_0.panelFormationListTip = createFormationListPanel(tolua.cast(var_5_1:getChildByTag(6), "CCNode"), arg_3_0)
		arg_3_0.nodeFate = tolua.cast(var_5_1:getChildByTag(11), "CCNode")
		arg_3_0.btnFate = tolua.cast(arg_3_0.nodeFate:getChildByTag(2), "CCControlButton")
		arg_3_0.btnSupport = tolua.cast(arg_3_0.nodeFate:getChildByTag(3), "CCControlButton")
		arg_3_0.btnBless = tolua.cast(arg_3_0.nodeFate:getChildByTag(4), "CCControlButton")
		arg_3_0.lbCombatPowerDummy = tolua.cast(arg_3_0.nodeFate:getChildByTag(1), "CCLabelTTF")
		arg_3_0.lbCombatPower = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbCombatPowerDummy, arg_3_0.lbCombatPower)
		arg_3_0.lbCombatPower:setScale(0.55)

		arg_3_0.editingAnimation = createUIPoolAnimation()

		arg_3_0.editingAnimation:setScale(1)
		arg_3_0.editingAnimation:setRotationY(180)
		arg_3_0.editingAnimation:retain()
		arg_3_0.editingAnimation:setVisible(false)

		arg_3_0.layerAnimation = tolua.cast(var_5_1:getChildByTag(12), "CCNode")

		arg_3_0.layerAnimation:addChild(arg_3_0.editingAnimation)
		arg_3_0.layerAnimation:setPosition(0, 0)

		arg_3_0.fateTip = zbFormationFateTip:create(tolua.cast(arg_3_0.layerAnimation:getChildByTag(1), "CCNode"))
		arg_3_0.supportTip = zbFormationSupportTip:create(tolua.cast(arg_3_0.layerAnimation:getChildByTag(2), "CCNode"))
		arg_3_0.blessTip = zbFormationBlessTip:create(tolua.cast(arg_3_0.layerAnimation:getChildByTag(4), "CCLayerColor"))

		arg_3_0.blessTip:hide()
		arg_3_0.fateTip:hide()
		arg_3_0.supportTip:hide()
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:onClose()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnAutoFormation:addHandleOfControlEvent(function()
			arg_3_0:onAutoFormation()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnGodFrame:addHandleOfControlEvent(function()
			arg_3_0:onSelectGodEquip()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnFate:addHandleOfControlEvent(function()
			arg_3_0:onFateTouchDown()
		end, CCControlEventTouchDown)
		arg_3_0.btnFate:addHandleOfControlEvent(function()
			arg_3_0:onFateTouchEnd()
		end, CCControlEventTouchEnd)
		arg_3_0.btnSupport:addHandleOfControlEvent(function()
			arg_3_0:onSupportTouchDown()
		end, CCControlEventTouchDown)
		arg_3_0.btnSupport:addHandleOfControlEvent(function()
			arg_3_0:onSupportTouchEnd()
		end, CCControlEventTouchEnd)
		arg_3_0.btnBless:addHandleOfControlEvent(function()
			arg_3_0:onBlessTouchDown()
		end, CCControlEventTouchDown)
		arg_3_0.btnBless:addHandleOfControlEvent(function()
			arg_3_0:onBlessTouchEnd()
		end, CCControlEventTouchEnd)
		arg_3_0.btnTech:addHandleOfControlEvent(function()
			arg_3_0:onTechTouchDown()
		end, CCControlEventTouchDown)
		arg_3_0.btnTech:addHandleOfControlEvent(function()
			arg_3_0:onTechTouchEnd()
		end, CCControlEventTouchEnd)
		arg_3_0:addChild(var_5_1)
		arg_3_0:createMoneyPanel(var_5_1, nil, function()
			arg_3_0:onClose()
		end)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(function()
		arg_3_0:onShow()
	end)
	arg_3_0:setHideCallback(function()
		arg_3_0:onHide()
	end)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onFormationChanged()
	end, zbGameEvent.Event_Update_Formation)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refreshGodEquip()
	end, zbGameEvent.Event_Update_GodInfo)
end

function zbFormationWnd.doDestroy(arg_22_0)
	arg_22_0.panelFormationSlots:free()
	arg_22_0.editingAnimation:free()
end

function zbFormationWnd.onClose(arg_23_0)
	if g_Guide:isGuiding() == true and table.getn(g_Self.kHeroHandler:getWorkHeros()) < 2 then
		g_Bubble:bubbleInfo("\xC7\xEB\xB0\xD1\xCB\xF9\xD3л\xEF\xB0\xE9\xCD\xD0\xC9\xCF\xD5\xF3")

		return
	end

	arg_23_0:hide()
end

function zbFormationWnd.onShow(arg_24_0)
	arg_24_0.formEmbattleWnd = false
end

function zbFormationWnd.onHide(arg_25_0)
	arg_25_0.supportTip:hide()
	arg_25_0.fateTip:hide()
	arg_25_0.blessTip:hide()
	arg_25_0.panelFormationSlots:free()
	arg_25_0.editingAnimation:free()

	if arg_25_0.formEmbattleWnd then
		g_MainScene:showEmbattleAndRefreshItems()
	end
end

function zbFormationWnd.refresh(arg_26_0)
	arg_26_0.btnFate:setVisible(false)

	arg_26_0.autoFormation = false
	arg_26_0.lastTechId = g_Self.kFormation.techId

	arg_26_0:onFormationChanged()
end

function zbFormationWnd.refreshTech(arg_27_0)
	local var_27_0 = g_Self.kTechHandler:getStudyedTech(g_Self.kFormation.techId)

	if var_27_0 ~= nil then
		local var_27_1 = zbTechTable:getRecord(g_Self.kFormation.techId)
		local var_27_2 = zbTechTable:getFormationPropertyDesc(g_Self.kFormation.techId, var_27_0.Level)
		local var_27_3 = string.format("image/icon/formation/small_formation_%d.png", var_27_1.id)

		arg_27_0.spriteTech:setTexture(CCTextureCache:sharedTextureCache():addImage(var_27_3))
		arg_27_0.lbTechLevel:setString(var_27_0.Level)
	end

	arg_27_0.spriteTech:setVisible(var_27_0 ~= nil)
end

function zbFormationWnd.refreshGodEquip(arg_28_0)
	local var_28_0 = g_GameData.GodInfo

	if var_28_0 ~= nil then
		local var_28_1 = zbGodBaseTable:getRecord(var_28_0.GodId)

		if var_28_1 ~= nil then
			arg_28_0.spriteGodIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_28_1.iconPath))
			arg_28_0.lbGodLevel:setString(var_28_0.Level)
		end
	end
end

function zbFormationWnd.onFormationChanged(arg_29_0)
	if arg_29_0.isShow == false or arg_29_0:isVisible() == false then
		return
	end

	arg_29_0.panelHeroList:refresh()
	arg_29_0.panelFormationListTip:refresh()
	arg_29_0:refreshGodEquip()
	arg_29_0:refreshTech()
	arg_29_0.panelFormationSlots:refresh(arg_29_0.autoFormation)
	arg_29_0:animTechShape()
	arg_29_0.lbCombatPower:setString(g_Self.kFormation:getCombatPower())

	arg_29_0.autoFormation = false
end

function zbFormationWnd.animTechShape(arg_30_0)
	local function var_30_0()
		if arg_30_0.lastTechId == g_Self.kFormation.techId then
			return
		end

		local var_31_0 = g_Self.kTechHandler:getStudyedTech(g_Self.kFormation.techId)

		if var_31_0 ~= nil and var_31_0.Level > 0 then
			arg_30_0.nodeShapeTip:setVisible(true)
			zbFormationHelper:formationAnimShow(arg_30_0.spriteShape, arg_30_0.spriteShapeName, g_Self.kFormation.techId, var_31_0.Level)
			arg_30_0.shapeBubble:showFormationType(g_Self.kFormation.techId, var_31_0.Level)
		end

		arg_30_0.lastTechId = g_Self.kFormation.techId
	end

	local var_30_1 = CCArray:create()

	var_30_1:addObject(CCDelayTime:create(1))
	var_30_1:addObject(CCCallFuncN:create(var_30_0))

	local var_30_2 = CCSequence:create(var_30_1)

	arg_30_0.nodeShapeTip:setVisible(false)
	arg_30_0.nodeShapeTip:stopAllActions()
	arg_30_0.nodeShapeTip:runAction(var_30_2)
end

function zbFormationWnd.getFormationSlots(arg_32_0)
	return arg_32_0.panelFormationSlots.slots
end

function zbFormationWnd.onAutoFormation(arg_33_0)
	if table.getn(arg_33_0.panelFormationListTip.sortedFormationRecords) < arg_33_0.btnCount then
		arg_33_0.btnCount = 1
	end

	local var_33_0 = 1
	local var_33_1

	for iter_33_0, iter_33_1 in pairs(arg_33_0.panelFormationListTip.sortedFormationRecords) do
		if var_33_0 == arg_33_0.btnCount then
			var_33_1 = iter_33_1
		end

		var_33_0 = var_33_0 + 1
	end

	g_Self.kFormation:reset()

	local var_33_2 = g_Self.kHeroHandler:getSortedHeros()
	local var_33_3 = 1
	local var_33_4 = {}
	local var_33_5 = {}

	for iter_33_2, iter_33_3 in pairs(var_33_2) do
		if var_33_3 <= 5 then
			table.insert(var_33_4, iter_33_3)
		else
			table.insert(var_33_5, iter_33_3)
		end

		var_33_3 = var_33_3 + 1
	end

	local var_33_6 = arg_33_0:sortHeroType(var_33_4)
	local var_33_7

	if var_33_1 then
		var_33_7 = FormationSlots[var_33_1.TechId]
	else
		var_33_7 = {
			0,
			1,
			0,
			1,
			1,
			1,
			0,
			1,
			0
		}
	end

	local var_33_8 = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	local var_33_9 = 1
	local var_33_10 = 1

	for iter_33_4, iter_33_5 in pairs(var_33_7) do
		if iter_33_5 ~= 0 and var_33_10 <= 5 then
			local var_33_11 = var_33_6[var_33_10]

			if var_33_11 == nil then
				break
			end

			var_33_8[var_33_9] = var_33_11.HeroBaseInfo.TemplateId
			var_33_10 = var_33_10 + 1
		end

		var_33_9 = var_33_9 + 1
	end

	local var_33_12 = 1

	for iter_33_6 = EParterAttrType.Attack, EParterAttrType.HP do
		if g_Self.kTechHandler:parterEnableByPos(iter_33_6) and var_33_5[var_33_12] ~= nil then
			var_33_8[iter_33_6 + 9] = var_33_5[var_33_12].HeroBaseInfo.TemplateId
			var_33_12 = var_33_12 + 1
		end
	end

	g_Self.kFormation:replaceSlots(var_33_8)
	g_Self.kFormation:save()
	g_Self.kFormation:print()

	arg_33_0.btnCount = arg_33_0.btnCount + 1
	arg_33_0.autoFormation = true
end

function zbFormationWnd.sortHeroType(arg_34_0, arg_34_1)
	local var_34_0 = {}

	for iter_34_0, iter_34_1 in pairs(arg_34_1) do
		local var_34_1 = zbHeroTable:getRecord(iter_34_1.HeroBaseInfo.TemplateId)

		if var_34_1 and var_34_1.heroType == EHeroType.Tili then
			table.insert(var_34_0, iter_34_1)
		end
	end

	for iter_34_2, iter_34_3 in pairs(arg_34_1) do
		local var_34_2 = zbHeroTable:getRecord(iter_34_3.HeroBaseInfo.TemplateId)

		if var_34_2 and var_34_2.heroType == EHeroType.Force then
			table.insert(var_34_0, iter_34_3)
		end
	end

	for iter_34_4, iter_34_5 in pairs(arg_34_1) do
		local var_34_3 = zbHeroTable:getRecord(iter_34_5.HeroBaseInfo.TemplateId)

		if var_34_3 and var_34_3.heroType == EHeroType.Intelligence then
			table.insert(var_34_0, iter_34_5)
		end
	end

	return var_34_0
end

function zbFormationWnd.onFateTouchDown(arg_35_0)
	arg_35_0.fateTip:show()
end

function zbFormationWnd.onFateTouchEnd(arg_36_0)
	arg_36_0.fateTip:hide()
end

function zbFormationWnd.onSupportTouchDown(arg_37_0)
	arg_37_0.supportTip:show()
end

function zbFormationWnd.onSupportTouchEnd(arg_38_0)
	arg_38_0.supportTip:hide()
end

function zbFormationWnd.onBlessTouchDown(arg_39_0)
	arg_39_0.blessTip:show()
end

function zbFormationWnd.onBlessTouchEnd(arg_40_0)
	arg_40_0.blessTip:hide()
end

function zbFormationWnd.onTechTouchDown(arg_41_0)
	local var_41_0 = zbTechTable:getRecord(g_Self.kFormation.techId)

	if var_41_0 ~= nil then
		g_MainScene:showFormationTip(var_41_0)
	end
end

function zbFormationWnd.onTechTouchEnd(arg_42_0)
	g_MainScene:hideFormationTip()
end

function zbFormationWnd.onSelectGodEquip(arg_43_0)
	g_MainScene:showGodListWnd()
end
