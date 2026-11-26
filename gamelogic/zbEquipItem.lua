require("gamebase.zbFunctions")
require("gamelogic.zbItem")

zbEquipItem = class("zbEquipItem", CCNodeExtend)
zbEquipItem.__index = zbEquipItem

function zbEquipItem.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbEquipItem)

	return arg_1_0
end

function zbEquipItem.create(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = zbEquipItem.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1, arg_2_2)

	return var_2_0
end

function zbEquipItem.init(arg_3_0, arg_3_1, arg_3_2)
	function initMember()
		arg_3_0.shopItemDummy = nil
		arg_3_0.EquipBaseData = nil
		arg_3_0.heroTemplateId = 0
		arg_3_0.equipTemplateId = 0
		arg_3_0.fragData = nil
		arg_3_0.holeItem = {}
		arg_3_0.dummy = {}
		arg_3_0.parentWnd = arg_3_2
	end

	function initCCB()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCLayer")

		arg_3_0.btn = tolua.cast(var_5_0:getChildByTag(101), "CCControlButton")
		arg_3_0.spriteBg = tolua.cast(var_5_0:getChildByTag(0), "CCSprite")

		local var_5_1 = tolua.cast(var_5_0:getChildByTag(11), "CCLayerColor")
		local var_5_2 = createItem()

		var_5_2:setPosition(var_5_1:getPosition())
		var_5_2:setScale(0.9)
		var_5_2:setSwallowsTouches(false)
		var_5_2:setNeedTip(false)
		var_5_0:addChild(var_5_2)

		arg_3_0.equipItemDummy = var_5_2

		var_5_1:removeFromParentAndCleanup(true)

		arg_3_0.lbName = tolua.cast(var_5_0:getChildByTag(2), "CCLabelTTF")
		arg_3_0.nodeWear = tolua.cast(var_5_0:getChildByTag(3), "CCNode")
		arg_3_0.lbHeroName = tolua.cast(arg_3_0.nodeWear:getChildByTag(1), "CCLabelTTF")
		arg_3_0.notifyFrame = tolua.cast(arg_3_0.nodeWear:getChildByTag(2), "CCSprite")
		arg_3_0.lbFightDummy = tolua.cast(arg_3_0.nodeWear:getChildByTag(1002), "CCLabelTTF")

		arg_3_0.nodeWear:setZOrder(ZORDER_TOP)
		zbUIEffect:createNotifyTagScaleAction(arg_3_0.notifyFrame)

		arg_3_0.fragIcon = tolua.cast(var_5_0:getChildByTag(4), "CCNode")
		arg_3_0.lbFragRate = tolua.cast(arg_3_0.fragIcon:getChildByTag(1), "CCLabelTTF")
		arg_3_0.fragBar = tolua.cast(arg_3_0.fragIcon:getChildByTag(2), "CCSprite")
		arg_3_0.canUp = tolua.cast(arg_3_0.fragIcon:getChildByTag(3), "CCSprite")

		arg_3_0.fragIcon:setZOrder(ZORDER_TOP)

		arg_3_0.fragBarPro = zbUtil:createProgressTimer(arg_3_0.fragBar, "image/common/progress147x25.png")
		arg_3_0.lbFight = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbFightDummy, arg_3_0.lbFight)
		arg_3_0.lbFight:setScale(0.55)
		arg_3_0.btn:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btn:setSwallowsTouches(false)
		arg_3_0.btn:setZoomOnTouchDown(true)
		arg_3_0.btn:setZoomChildNode(var_5_0)
		arg_3_0.btn:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0:addChild(arg_3_1)

		arg_3_0.layerSperator = tolua.cast(arg_3_1:getChildByTag(2), "CCLayer")
		arg_3_0.layerContent = var_5_0
	end

	initMember()
	initCCB()
end

function zbEquipItem.refreshData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0:setVisible(true)

	arg_7_0.data = arg_7_1

	arg_7_0.layerContent:setVisible(false)
	arg_7_0.layerSperator:setVisible(false)

	if arg_7_1.isSpeartor ~= nil and arg_7_1.isSpeartor then
		arg_7_0.layerSperator:setVisible(true)
	elseif arg_7_1.isSpeartor2 ~= nil and arg_7_1.isSpeartor2 then
		arg_7_0:setVisible(false)
	elseif arg_7_1.isSpeartor3 ~= nil and arg_7_1.isSpeartor3 then
		arg_7_0:setVisible(false)
	elseif arg_7_1.isEmpty ~= nil and arg_7_1.isEmpty then
		arg_7_0:setVisible(false)
	elseif arg_7_1.isFrag then
		arg_7_0.layerContent:setVisible(true)
		arg_7_0:refreshFrag(arg_7_1.equip)
	elseif arg_7_1.equip ~= nil then
		arg_7_0.layerContent:setVisible(true)
		arg_7_0:refresh(arg_7_1.equip)
	end
end

function zbEquipItem.refresh(arg_8_0, arg_8_1)
	arg_8_0.EquipBaseData = arg_8_1

	arg_8_0:setVisible(arg_8_0.EquipBaseData ~= nil)
	arg_8_0.nodeWear:setVisible(true)
	arg_8_0.fragIcon:setVisible(false)

	if arg_8_0.EquipBaseData ~= nil then
		arg_8_0.equipItemDummy:refreshEquip(arg_8_1)

		local var_8_0 = zbItemTable:getRecord(arg_8_0.EquipBaseData.TemplateId)

		if var_8_0 ~= nil then
			arg_8_0.lbName:setString(var_8_0.name)

			local var_8_1 = zbColor:getItemColor(var_8_0.quality)

			arg_8_0.lbName:setColor(var_8_1)

			if arg_8_1.CLevel ~= 0 then
				arg_8_0.lbName:setString(var_8_0.name .. "+" .. arg_8_1.CLevel)
			end
		end
	end

	arg_8_0.lbHeroName:setColor(FONT_COLOR_WHITE)
	arg_8_0.lbHeroName:setString(a2u("\xCE\xDE"))

	if arg_8_0.data.heroTemplateId ~= nil and arg_8_0.data.heroTemplateId > 0 then
		local var_8_2 = g_Self.kHeroHandler:getHeroByTemplateId(arg_8_0.data.heroTemplateId)
		local var_8_3 = zbHeroTable:getRecord(arg_8_0.data.heroTemplateId)

		if var_8_3 and var_8_2 then
			arg_8_0.lbHeroName:setString(var_8_3.name)

			local var_8_4 = zbColor:getHeroNameColor(var_8_2.HeroBaseInfo.Quality)

			arg_8_0.lbHeroName:setColor(var_8_4)
		end
	end

	arg_8_0.lbFight:setString(arg_8_0.EquipBaseData.FV)
	arg_8_0.spriteBg:setGray(false)
	arg_8_0.equipItemDummy:setGray(false)
	arg_8_0.notifyFrame:setVisible(g_Self.kBagEquipHandler:getEquipCanEnchant(arg_8_0.EquipBaseData))
end

function zbEquipItem.refreshFrag(arg_9_0, arg_9_1)
	arg_9_0.EquipBaseData = nil
	arg_9_0.fragData = arg_9_1

	arg_9_0:setVisible(arg_9_0.fragData ~= nil)
	arg_9_0.nodeWear:setVisible(false)
	arg_9_0.fragIcon:setVisible(true)

	if arg_9_0.fragData ~= nil then
		arg_9_0.equipItemDummy:refreshAward(ECommonAwardType.EquipFrag, arg_9_1.TemplateId, arg_9_1.Count, false, false)

		local var_9_0 = zbItemTable:getRecord(arg_9_0.fragData.TemplateId)

		if var_9_0 ~= nil then
			arg_9_0.lbName:setString(var_9_0.name)

			local var_9_1, var_9_2 = zbColor:getItemColor(var_9_0.quality)

			arg_9_0.lbName:setColor(var_9_1)
		end

		local var_9_3 = g_Self.kEquipFragHandler:getEquipFragCount(arg_9_0.fragData.TemplateId)
		local var_9_4, var_9_5 = g_Self.kEquipFragHandler:getEquipComposeNeeds(arg_9_0.fragData.TemplateId)
		local var_9_6 = math.min(math.ceil(var_9_3 / var_9_4 * 100), 99)

		arg_9_0.fragBarPro:setPercentage(var_9_6)
		arg_9_0.lbFragRate:setString(var_9_3 .. "/" .. var_9_4)
		arg_9_0.spriteBg:setGray(not (var_9_4 <= var_9_3))
		arg_9_0.canUp:setVisible(var_9_4 <= var_9_3)
	end
end

function zbEquipItem.onTouch(arg_10_0)
	if arg_10_0.EquipBaseData ~= nil then
		if arg_10_0.data.heroTemplateId == nil then
			arg_10_0.data.heroTemplateId = 0
		end

		g_MainScene:showEquipDetailWnd(arg_10_0.EquipBaseData, arg_10_0.data.heroTemplateId):setPrevWnd(arg_10_0.parentWnd)
	elseif arg_10_0.fragData ~= nil then
		local var_10_0 = g_Self.kEquipFragHandler:getEquipFragCount(arg_10_0.fragData.TemplateId)
		local var_10_1, var_10_2 = g_Self.kEquipFragHandler:getEquipComposeNeeds(arg_10_0.fragData.TemplateId)

		if var_10_1 <= var_10_0 then
			g_MainScene:showFragComposeWnd(arg_10_0.fragData, ELinkType.Equip)
		else
			g_MainScene:showGetWayWnd(arg_10_0.fragData.TemplateId, ECommonAwardType.Item)
		end
	end
end
