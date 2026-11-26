zbHeroEquipSlot = class("zbHeroEquipSlot", CCNodeExtend)
zbHeroEquipSlot.__index = zbHeroEquipSlot

local var_0_0 = 100

function zbHeroEquipSlot.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbHeroEquipSlot)

	return arg_1_0
end

function zbHeroEquipSlot.create(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = zbHeroEquipSlot.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1, arg_2_2)

	return var_2_0
end

function zbHeroEquipSlot.init(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0()
		arg_3_0.ItemSubType = arg_3_2
		arg_3_0.heroTemplateId = -1
		arg_3_0.ItemTempalteId = -1
		arg_3_0.animationDraging = false
		arg_3_0.showTips = false
		arg_3_0.gemEffect = nil
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCLayer")

		arg_3_0.layerDetail = var_5_0
		arg_3_0.btnFrame = tolua.cast(var_5_0:getChildByTag(1), "CCControlButton")
		arg_3_0.spriteIcon = tolua.cast(var_5_0:getChildByTag(2), "CCSprite")
		arg_3_0.spriteLevel = tolua.cast(var_5_0:getChildByTag(3), "CCSprite")
		arg_3_0.lbLevelDummy = tolua.cast(arg_3_0.spriteLevel:getChildByTag(1), "CCLabelTTF")

		arg_3_0.btnFrame:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnFrame:addHandleOfControlEvent(function()
			arg_3_0:onTouchDown()
		end, CCControlEventTouchDown)
		arg_3_0.btnFrame:addHandleOfControlEvent(function()
			arg_3_0:onTouchMove()
		end, CCControlEventTouchMove)
		arg_3_0.btnFrame:addHandleOfControlEvent(function()
			arg_3_0:onTouchEnd()
		end, CCControlEventTouchEnd)
		arg_3_0:addChild(arg_3_1)
		arg_3_0:setAnchorPoint(ccp(0, 0))
		arg_3_0:setPosition(0, 0)
		arg_3_0:setScale(0.75)

		arg_3_0.lbLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbLevelDummy, arg_3_0.lbLevel)
		arg_3_0.lbLevel:setScale(0.55)

		local function var_5_1(arg_10_0)
			local var_10_0 = CCSprite:create(NOTIFY_TAG_PATH)

			var_10_0:setPosition(100, 100)
			var_10_0:setVisible(true)

			if arg_10_0:getChildByTag(500) == nil then
				arg_10_0:addChild(var_10_0, 1000000, 500)
			end

			zbUIEffect:createNotifyTagScaleAction(var_10_0)

			return var_10_0
		end

		arg_3_0.gemsTag = var_5_1(var_5_0)

		local function var_5_2(arg_11_0)
			local var_11_0 = CCSprite:create("image/common/arrow_up.png")

			var_11_0:setPosition(100, 100)
			var_11_0:setVisible(true)

			if arg_11_0:getChildByTag(600) == nil then
				arg_11_0:addChild(var_11_0, 1000000, 600)
			end

			zbUIEffect:createArrowMoveAction(var_11_0, 5, 1)

			return var_11_0
		end

		arg_3_0.upGradeTag = var_5_2(var_5_0)
	end

	var_3_0()
	var_3_1()
end

function zbHeroEquipSlot.refresh(arg_12_0, arg_12_1)
	arg_12_0.spriteLevel:setVisible(false)

	arg_12_0.hero = arg_12_1

	local var_12_0 = g_Self.kHeroHandler:getHeroEquipByPos(arg_12_1.HeroBaseInfo.TemplateId, arg_12_0.ItemSubType)

	arg_12_0.equip = var_12_0

	if var_12_0 ~= nil then
		if zbItemTable:getRecord(var_12_0.Equip.TemplateId) ~= nil then
			arg_12_0.spriteLevel:setVisible(true)
			arg_12_0.lbLevel:setString(var_12_0.Equip.Level)
			zbAwardHelper:refreshAwardItem(ECommonAwardType.Item, var_12_0.Equip.TemplateId, 1, arg_12_0.btnFrame, arg_12_0.spriteIcon)
		end

		arg_12_0.spriteIcon:setVisible(true)

		local var_12_1 = g_Self.kHeroHandler:hasBestEquipCanChange(arg_12_1, arg_12_0.ItemSubType) or g_Self.kBagEquipHandler:getEquipCanEnchant(arg_12_0.equip.Equip)
		local var_12_2 = g_Self.kHeroHandler:equipCanUpgrade(var_12_0)

		arg_12_0.upGradeTag:setVisible(var_12_2)
		arg_12_0.gemsTag:setVisible(var_12_1)

		if var_12_1 then
			arg_12_0.upGradeTag:setVisible(false)
		end

		local var_12_3 = g_Self.kBagEquipHandler:getEnchantLight(arg_12_0.equip.Equip)

		if var_12_3 ~= 0 and arg_12_0.gemEffect == nil then
			arg_12_0.gemEffect = g_EffectSystem:creatGemEffect(arg_12_0.layerDetail)
		end

		if arg_12_0.gemEffect ~= nil then
			arg_12_0.gemEffect:setAnimation(var_12_3, true)
			arg_12_0.gemEffect:setVisible(var_12_3 ~= 0)
		end
	else
		arg_12_0.spriteLevel:setVisible(false)

		local var_12_4 = "image/frame/itemframe/itemnohave.png"

		require("gamebase.zbUI"):setButtonPic(arg_12_0.btnFrame, var_12_4, var_12_4, var_12_4)
		arg_12_0.spriteIcon:setVisible(false)

		local var_12_5 = zbHeroTable:getRecord(arg_12_1.HeroBaseInfo.TemplateId)

		if var_12_5 == nil then
			echoInfo("error hero template id: " .. arg_12_1.HeroBaseInfo.TemplateId)

			return
		end

		local var_12_6 = -1

		if var_12_5.attackType == EAttackType.Physic then
			var_12_6 = EAttrType.MagicAttack
		else
			var_12_6 = EAttrType.PhysicAttack
		end

		local var_12_7 = g_Self.kBagEquipHandler:getBagEquipByPos(arg_12_0.ItemSubType, var_12_6)
		local var_12_8 = table.getn(var_12_7)

		arg_12_0.gemsTag:setVisible(var_12_8 ~= 0)
		arg_12_0.upGradeTag:setVisible(false)

		if arg_12_0.gemEffect ~= nil then
			arg_12_0.gemEffect:setVisible(false)
		end
	end
end

function zbHeroEquipSlot.onTouch(arg_13_0)
	if arg_13_0.showTips then
		return
	end

	if arg_13_0.animationDraging then
		return
	end

	g_MainScene:showEquipSelectWnd(arg_13_0.hero.HeroBaseInfo.TemplateId, arg_13_0.ItemSubType):setPrevWnd(g_MainScene.wndHeroDetail)
end

function zbHeroEquipSlot.onTouchDown(arg_14_0)
	arg_14_0.animationDraging = false
	arg_14_0.lastDownTouch = arg_14_0.btnFrame:getTouch():getLocation()

	if arg_14_0.equip ~= nil then
		arg_14_0:onShowTips()
	end
end

function zbHeroEquipSlot.onShowTips(arg_15_0)
	local var_15_0 = arg_15_0.layerDetail

	while var_15_0:getParent() ~= nil do
		var_15_0 = var_15_0:getParent()
	end

	arg_15_0.showTips = true

	if arg_15_0.equip ~= nil then
		local var_15_1 = g_MainScene.wndHeroDetail.layer:convertToNodeSpace(arg_15_0.lastDownTouch)

		if g_MainScene.wndHeroDetail then
			g_MainScene.wndHeroDetail.layerTips:refreshEquip(arg_15_0.equip, arg_15_0.hero.HeroBaseInfo.TemplateId, arg_15_0.ItemSubType)
			g_MainScene.wndHeroDetail.layerTips:resetPosition(var_15_1)
		end
	end
end

function zbHeroEquipSlot.onTouchMove(arg_16_0)
	arg_16_0.lastMoveTouch = arg_16_0.btnFrame:getTouch():getLocation()
end

function zbHeroEquipSlot.onTouchEnd(arg_17_0)
	arg_17_0:stopAllActions()

	arg_17_0.showTips = false
	arg_17_0.animationDraging = false
end
