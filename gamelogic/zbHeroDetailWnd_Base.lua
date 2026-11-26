zbHeroDetailWnd_Base = class("zbHeroDetailWnd_Base")
zbHeroDetailWnd_Base.__index = zbHeroDetailWnd_Base

local var_0_0 = 120

function zbHeroDetailWnd_Base.init(arg_1_0, arg_1_1, arg_1_2)
	local function var_1_0()
		arg_1_0.lastHeroData = nil
		arg_1_0.heroNewData = nil
		arg_1_0.lastHeroTemplateId = 0
		arg_1_0.changeData = {}
		arg_1_0.initPos = {}
		arg_1_0.attrLbList = {}
		arg_1_0.changeStep = 0
		arg_1_0.attrIndex = 0
		arg_1_0.dataStar = {}
	end

	local function var_1_1()
		arg_1_0.layer = arg_1_1
		arg_1_0.wndParent = arg_1_2
		arg_1_0.layerEquip = tolua.cast(arg_1_1:getChildByTag(151), "CCNode")

		local var_3_0 = tolua.cast(arg_1_0.layerEquip:getChildByTag(1), "CCNode")
		local var_3_1 = tolua.cast(arg_1_0.layerEquip:getChildByTag(2), "CCNode")
		local var_3_2 = tolua.cast(arg_1_0.layerEquip:getChildByTag(3), "CCNode")
		local var_3_3 = tolua.cast(arg_1_0.layerEquip:getChildByTag(4), "CCNode")
		local var_3_4 = tolua.cast(arg_1_0.layerEquip:getChildByTag(5), "CCNode")
		local var_3_5 = tolua.cast(arg_1_0.layerEquip:getChildByTag(6), "CCNode")

		var_3_0:setVisible(false)
		var_3_1:setVisible(false)
		var_3_2:setVisible(false)
		var_3_3:setVisible(false)
		var_3_4:setVisible(false)
		var_3_5:setVisible(false)

		local var_3_6 = zbTableViewHelper:create()

		var_3_6:loadCCBFile("ccbi/tb_hero_equipslot.ccbi")

		arg_1_0.equipWeapon = zbHeroEquipSlot:create(translateAndStrokeHelper(var_3_6:readCCBNode()), EEquipType.Weapon)
		arg_1_0.equipArmor = zbHeroEquipSlot:create(translateAndStrokeHelper(var_3_6:readCCBNode()), EEquipType.Armor)
		arg_1_0.equipMount = zbHeroEquipSlot:create(translateAndStrokeHelper(var_3_6:readCCBNode()), EEquipType.Mount)
		arg_1_0.equipCloak = zbHeroEquipSlot:create(translateAndStrokeHelper(var_3_6:readCCBNode()), EEquipType.Cloak)
		arg_1_0.equipBook = zbHeroEquipSlot:create(translateAndStrokeHelper(var_3_6:readCCBNode()), EEquipType.Book)
		arg_1_0.equipMagic = zbHeroEquipSlot:create(translateAndStrokeHelper(var_3_6:readCCBNode()), EEquipType.Magic)

		var_3_6:releaseSelf()
		arg_1_0.equipWeapon:setPosition(var_3_0:getPosition())
		arg_1_0.equipArmor:setPosition(var_3_1:getPosition())
		arg_1_0.equipMount:setPosition(var_3_2:getPosition())
		arg_1_0.equipCloak:setPosition(var_3_3:getPosition())
		arg_1_0.equipBook:setPosition(var_3_4:getPosition())
		arg_1_0.equipMagic:setPosition(var_3_5:getPosition())
		arg_1_0.layerEquip:addChild(arg_1_0.equipWeapon)
		arg_1_0.layerEquip:addChild(arg_1_0.equipArmor)
		arg_1_0.layerEquip:addChild(arg_1_0.equipMount)
		arg_1_0.layerEquip:addChild(arg_1_0.equipCloak)
		arg_1_0.layerEquip:addChild(arg_1_0.equipBook)
		arg_1_0.layerEquip:addChild(arg_1_0.equipMagic)

		arg_1_0.spriteProgressExpBg = tolua.cast(arg_1_1:getChildByTag(18), "CCSprite")

		local function var_3_7(arg_4_0, arg_4_1)
			local var_4_0 = CCSprite:create(arg_4_1)

			var_4_0:setAnchorPoint(ccp(0, 0))

			local var_4_1 = CCProgressTimer:create(var_4_0)

			var_4_1:setAnchorPoint(ccp(0, 0))
			var_4_1:setPercentage(100)
			var_4_1:setMidpoint(ccp(0, 1))
			var_4_1:setBarChangeRate(ccp(1, 0))
			var_4_1:setType(kCCProgressTimerTypeBar)
			var_4_1:retain()
			var_4_1:setPosition(1, 0)
			arg_4_0:addChild(var_4_1)

			return var_4_1
		end

		arg_1_0.progressExp = var_3_7(arg_1_0.spriteProgressExpBg, "image/common/progress147x25.png")
		arg_1_0.bmAptitudeDummy = tolua.cast(arg_1_1:getChildByTag(3), "CCLabelTTF")
		arg_1_0.btnAddExp = tolua.cast(arg_1_1:getChildByTag(35), "CCControlButton")
		arg_1_0.btnAuto = tolua.cast(arg_1_1:getChildByTag(1), "CCControlButton")
		arg_1_0.btnSwapAllequip = tolua.cast(arg_1_1:getChildByTag(2), "CCControlButton")
		arg_1_0.btnComment = tolua.cast(arg_1_1:getChildByTag(3), "CCControlButton")

		arg_1_0.btnAddExp:addHandleOfControlEvent(function()
			arg_1_0:onAddExp()
		end, CCControlEventTouchUpInside)
		arg_1_0.btnAuto:addHandleOfControlEvent(function()
			arg_1_0:onAutoForge()
		end, CCControlEventTouchUpInside)
		arg_1_0.btnSwapAllequip:addHandleOfControlEvent(function()
			arg_1_0:onSwapAllequip()
		end, CCControlEventTouchUpInside)
		arg_1_0.btnComment:addHandleOfControlEvent(function()
			arg_1_0:onHeroComment()
		end, CCControlEventTouchUpInside)
	end

	var_1_0()
	var_1_1()
end

function zbHeroDetailWnd_Base.refreshDetail(arg_9_0)
	arg_9_0:refresh(arg_9_0.hero)
end

function zbHeroDetailWnd_Base.refresh(arg_10_0, arg_10_1)
	arg_10_0.hero = arg_10_1

	if arg_10_0.hero == nil then
		return
	end

	if zbHeroTable:getRecord(arg_10_0.hero.HeroBaseInfo.TemplateId) == nil then
		echoInfo("error hero template id: " .. arg_10_0.hero.HeroBaseInfo.TemplateId)

		return
	end

	arg_10_0.equipWeapon:refresh(arg_10_0.hero)
	arg_10_0.equipArmor:refresh(arg_10_0.hero)
	arg_10_0.equipMount:refresh(arg_10_0.hero)
	arg_10_0.equipCloak:refresh(arg_10_0.hero)
	arg_10_0.equipBook:refresh(arg_10_0.hero)
	arg_10_0.equipMagic:refresh(arg_10_0.hero)

	local var_10_0 = zbHeroUpgradeTable:getHeroUpgradeNeedExp(arg_10_0.hero.HeroBaseInfo.Level)
	local var_10_1 = math.min(math.ceil(100 * (arg_10_0.hero.HeroBaseInfo.Exp / var_10_0)), 100)

	arg_10_0.progressExp:runAction(CCProgressTo:create(0, var_10_1))
end

function zbHeroDetailWnd_Base.onAddExp(arg_11_0)
	if arg_11_0.hero then
		g_MainScene:showHeroDetailAddExpWnd(arg_11_0.hero)
	end
end

function zbHeroDetailWnd_Base.onAutoForge(arg_12_0)
	if arg_12_0.hero ~= nil then
		local var_12_0 = arg_12_0.hero.EquipList

		bHaveEquipCanForge, costValue = arg_12_0:hasEquipCanForge(var_12_0)

		if bHaveEquipCanForge == false then
			g_Bubble:bubbleInfo("û\xD3п\xC9\xC9\xFD\xBC\xB6\xB5\xC4װ\xB1\xB8")

			return
		end

		local function var_12_1()
			g_WsMsgHandler:WS_Hero_FastUpgradeEquip_Req(arg_12_0.hero.HeroBaseInfo.TemplateId)
		end

		local var_12_2 = a2u(string.format("ȷ\xB6\xA8\xBB\xA8\xB7\xD1%d\xBD\xF0\xDF\xF7\xB1\xD2\xC9\xFD\xBC\xB6ȫ\xC9\xEDװ\xB1\xB8\xC2\xF0\xA3\xBF", costValue))

		g_MessageBox:showYesNo(var_12_2, var_12_1)
	end
end

function zbHeroDetailWnd_Base.onSwapAllequip(arg_14_0)
	g_MainScene:showHeroSelectWnd():refreshSwapEquip(arg_14_0.hero.HeroBaseInfo.TemplateId)
end

function zbHeroDetailWnd_Base.onHeroComment(arg_15_0)
	if arg_15_0.hero then
		g_Self.kHeroHandler.commentHeroTemlatedId = arg_15_0.hero.HeroBaseInfo.TemplateId

		g_MainScene:showHeroCommentWnd()
	end
end

function zbHeroDetailWnd_Base.hasEquipCanForge(arg_16_0, arg_16_1)
	local var_16_0 = 0
	local var_16_1 = false

	for iter_16_0, iter_16_1 in pairs(arg_16_1) do
		local var_16_2 = g_Self:getLevel()

		if var_16_2 > iter_16_1.Equip.Level then
			var_16_1 = true

			for iter_16_2 = iter_16_1.Equip.Level, var_16_2 - 1 do
				var_16_0 = var_16_0 + zbEquipUpgradeTable:getRecord(iter_16_2).costValue[iter_16_1.Equip.Quality]
			end
		end
	end

	return var_16_1, var_16_0
end

function createHeroDetailBasePanel(arg_17_0, arg_17_1)
	local var_17_0 = zbHeroDetailWnd_Base.new()

	var_17_0:init(arg_17_0, arg_17_1)

	return var_17_0
end
