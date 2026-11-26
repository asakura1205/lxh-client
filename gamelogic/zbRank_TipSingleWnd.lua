require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbRank_TipSingleWnd", zbBaseWnd)

var_0_0.__index = var_0_0

local var_0_1 = {}
local var_0_2 = 10
local var_0_3 = 2

var_0_1[var_0_3] = EAttrType.PhysicDefend

local var_0_4 = var_0_3 + 1

var_0_1[var_0_4] = EAttrType.Violent

local var_0_5 = var_0_4 + 1

var_0_1[var_0_5] = EAttrType.Hit

local var_0_6 = var_0_5 + 1

var_0_1[var_0_6] = EAttrType.PierceDamage

local var_0_7 = var_0_6 + 1

var_0_1[var_0_7] = EAttrType.HP

local var_0_8 = var_0_7 + 1

var_0_1[var_0_8] = EAttrType.MagicDefend

local var_0_9 = var_0_8 + 1

var_0_1[var_0_9] = EAttrType.Tough

local var_0_10 = var_0_9 + 1

var_0_1[var_0_10] = EAttrType.Dodge

local var_0_11 = var_0_10 + 1

var_0_1[var_0_11] = EAttrType.Block

local var_0_12 = var_0_11 + 1

function createRankTipSingleWnd()
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
		arg_3_0.headDummy = nil
		arg_3_0.items = {}
		arg_3_0.skillItems = {}
		arg_3_0.equipItems = {}
		arg_3_0.heroDetail = nil
		arg_3_0.fateNode = {}
		arg_3_0.fateType = {}
		arg_3_0.fateTitle = {}
		arg_3_0.fateHero = {}
		arg_3_0.servantNode = {}
		arg_3_0.servantTitle = {}
		arg_3_0.servantHero = {}
		arg_3_0.baseAttr = {}
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/rank_tipsingle.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.layer = var_5_2

		local var_5_3 = tolua.cast(arg_3_0.layer:getChildByTag(1), "CCLayerColor")
		local var_5_4 = createItem()

		var_5_4:setPosition(var_5_3:getPosition())
		var_5_4:setNeedTip(false)
		var_5_4:setNodeStarVisible()

		arg_3_0.headDummy = var_5_4

		arg_3_0.layer:addChild(arg_3_0.headDummy)
		var_5_3:removeFromParentAndCleanup(true)

		arg_3_0.lbName = tolua.cast(var_5_2:getChildByTag(2), "CCLabelTTF")

		local var_5_5 = tolua.cast(var_5_2:getChildByTag(3), "CCSprite")
		local var_5_6 = tolua.cast(var_5_5:getChildByTag(1), "CCLabelTTF")

		arg_3_0.btnFate = tolua.cast(var_5_2:getChildByTag(4), "CCControlButton")
		arg_3_0.btnServant = tolua.cast(var_5_2:getChildByTag(5), "CCControlButton")
		arg_3_0.spriteRarity = tolua.cast(var_5_2:getChildByTag(9), "CCSprite")

		arg_3_0.btnFate:setVisible(false)

		local var_5_7 = tolua.cast(var_5_2:getChildByTag(6), "CCNode")

		for iter_5_0 = 1, 5 do
			local var_5_8 = tolua.cast(var_5_7:getChildByTag(iter_5_0), "CCNode")

			var_5_8:setVisible(false)

			local var_5_9 = createItem()

			var_5_9:setPosition(var_5_8:getPosition())
			var_5_9:setScale(0.4)

			arg_3_0.skillItems[iter_5_0] = var_5_9

			var_5_7:addChild(var_5_9)
			var_5_8:removeFromParentAndCleanup(true)
		end

		local var_5_10 = tolua.cast(var_5_2:getChildByTag(7), "CCNode")

		for iter_5_1 = 1, 6 do
			local var_5_11 = tolua.cast(var_5_10:getChildByTag(iter_5_1), "CCNode")

			var_5_11:setVisible(false)

			local var_5_12 = createItem()

			var_5_12:setPosition(var_5_11:getPosition())
			var_5_12:setScale(0.55)

			arg_3_0.equipItems[iter_5_1] = var_5_12

			var_5_10:addChild(var_5_12)
			var_5_11:removeFromParentAndCleanup(true)
		end

		local var_5_13 = tolua.cast(var_5_2:getChildByTag(8), "CCNode")

		arg_3_0.layerGrowDetail = tolua.cast(var_5_13:getChildByTag(1), "CCNode")

		local var_5_14 = tolua.cast(arg_3_0.layerGrowDetail:getChildByTag(1), "CCLabelTTF")
		local var_5_15 = tolua.cast(arg_3_0.layerGrowDetail:getChildByTag(2), "CCLabelTTF")
		local var_5_16 = tolua.cast(arg_3_0.layerGrowDetail:getChildByTag(3), "CCLabelTTF")

		arg_3_0.baseAttr[EAttrType.Force] = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_14, arg_3_0.baseAttr[EAttrType.Force])
		arg_3_0.baseAttr[EAttrType.Force]:setScale(0.5)

		arg_3_0.baseAttr[EAttrType.Intelligence] = CCLabelAtlas:create("", "font/rank_num_purple.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_15, arg_3_0.baseAttr[EAttrType.Intelligence])
		arg_3_0.baseAttr[EAttrType.Intelligence]:setScale(0.5)

		arg_3_0.baseAttr[EAttrType.Tili] = CCLabelAtlas:create("", "font/rank_num_green.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_16, arg_3_0.baseAttr[EAttrType.Tili])
		arg_3_0.baseAttr[EAttrType.Tili]:setScale(0.5)

		arg_3_0.layerDetail = tolua.cast(var_5_13:getChildByTag(2), "CCNode")
		arg_3_0.attackname = tolua.cast(arg_3_0.layerDetail:getChildByTag(100), "CCLabelTTF")

		for iter_5_2 = 1, var_0_2 do
			arg_3_0.items[iter_5_2] = tolua.cast(arg_3_0.layerDetail:getChildByTag(iter_5_2), "CCLabelTTF")
		end

		arg_3_0.lbFight = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_6, arg_3_0.lbFight)
		arg_3_0.lbFight:setScale(0.6)
		arg_3_0.btnFate:addHandleOfControlEvent(function()
			arg_3_0:onTouchFateDown()
		end, CCControlEventTouchDown)
		arg_3_0.btnFate:addHandleOfControlEvent(function()
			arg_3_0:onTouchFateEnd()
		end, CCControlEventTouchEnd)
		arg_3_0.btnServant:addHandleOfControlEvent(function()
			arg_3_0:onTouchServantDown()
		end, CCControlEventTouchDown)
		arg_3_0.btnServant:addHandleOfControlEvent(function()
			arg_3_0:onTouchServantEnd()
		end, CCControlEventTouchEnd)

		arg_3_0.layerFate = tolua.cast(var_5_1:getChildByTag(2), "CCNode")

		arg_3_0.layerFate:setVisible(false)

		arg_3_0.lbFateHint = tolua.cast(arg_3_0.layerFate:getChildByTag(0), "CCLabelTTF")
		arg_3_0.spriteFateBg = tolua.cast(arg_3_0.layerFate:getChildByTag(50), "CCScale9Sprite")

		for iter_5_3 = 1, 10 do
			arg_3_0.fateNode[iter_5_3] = tolua.cast(arg_3_0.layerFate:getChildByTag(iter_5_3), "CCNode")
			arg_3_0.fateType[iter_5_3] = tolua.cast(arg_3_0.fateNode[iter_5_3]:getChildByTag(1), "CCSprite")
			arg_3_0.fateHero[iter_5_3] = tolua.cast(arg_3_0.fateNode[iter_5_3]:getChildByTag(2), "CCLabelTTF")
			arg_3_0.fateTitle[iter_5_3] = tolua.cast(arg_3_0.fateNode[iter_5_3]:getChildByTag(3), "CCLabelTTF")
		end

		arg_3_0.layerServant = tolua.cast(var_5_1:getChildByTag(3), "CCNode")

		arg_3_0.layerServant:setVisible(false)

		arg_3_0.lbServantHint = tolua.cast(arg_3_0.layerServant:getChildByTag(0), "CCLabelTTF")

		for iter_5_4 = 1, 3 do
			arg_3_0.servantNode[iter_5_4] = tolua.cast(arg_3_0.layerServant:getChildByTag(iter_5_4), "CCNode")
			arg_3_0.servantHero[iter_5_4] = tolua.cast(arg_3_0.servantNode[iter_5_4]:getChildByTag(2), "CCLabelTTF")
			arg_3_0.servantTitle[iter_5_4] = tolua.cast(arg_3_0.servantNode[iter_5_4]:getChildByTag(3), "CCLabelTTF")
		end

		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_11_0, arg_11_1)
	arg_11_0.heroDetail = arg_11_1

	if arg_11_1 == nil then
		return
	end

	if arg_11_1.HeroBaseInfo ~= nil then
		arg_11_0.headDummy:refreshHero(arg_11_1.HeroBaseInfo)
		arg_11_0.lbFight:setString(arg_11_1.HeroBaseInfo.FV)

		local var_11_0 = zbHeroTable:getRecord(arg_11_1.HeroBaseInfo.TemplateId)

		if var_11_0 ~= nil then
			arg_11_0.lbName:setString(var_11_0.name)
			arg_11_0.spriteRarity:setTexture(CCTextureCache:sharedTextureCache():addImage("image/herodetail/herodetail_rarity" .. var_11_0.rarity .. ".png"))
		end
	end

	for iter_11_0 = 1, 5 do
		arg_11_0.skillItems[iter_11_0]:setVisible(false)
	end

	local var_11_1 = arg_11_1.SkillList
	local var_11_2 = 1

	for iter_11_1, iter_11_2 in pairs(var_11_1) do
		if var_11_2 <= 5 then
			arg_11_0.skillItems[var_11_2]:refreshSkill(iter_11_2)
			arg_11_0.skillItems[var_11_2]:setVisible(true)
		end

		var_11_2 = var_11_2 + 1
	end

	for iter_11_3 = 1, 6 do
		arg_11_0.equipItems[iter_11_3]:setVisible(false)
	end

	local var_11_3 = arg_11_1.EquipList
	local var_11_4 = 1

	for iter_11_4, iter_11_5 in pairs(var_11_3) do
		if var_11_4 <= 6 then
			arg_11_0.equipItems[var_11_4]:refreshEquip(iter_11_5.Equip)
			arg_11_0.equipItems[var_11_4]:setVisible(true)
		end

		var_11_4 = var_11_4 + 1
	end

	local var_11_5 = zbHeroHelper:getHeroAttributeTable(arg_11_1)

	for iter_11_6 = EAttrType.Force, EAttrType.Tili do
		local var_11_6 = 0

		for iter_11_7, iter_11_8 in pairs(arg_11_1.WashInfo.MAttr) do
			if iter_11_8[1] == iter_11_6 then
				var_11_6 = var_11_6 + iter_11_8[3]
			end
		end

		for iter_11_9, iter_11_10 in pairs(arg_11_1.PartnerInfo.PartnerAttr) do
			if iter_11_10[1] == iter_11_6 then
				var_11_6 = var_11_6 + iter_11_10[3]
			end
		end

		if var_11_6 > 0 then
			arg_11_0.baseAttr[iter_11_6]:setString(var_11_5[iter_11_6] - var_11_6 .. "+" .. var_11_6)
		else
			arg_11_0.baseAttr[iter_11_6]:setString(var_11_5[iter_11_6] - var_11_6)
		end
	end

	local var_11_7 = zbHeroTable:getRecord(arg_11_1.HeroBaseInfo.TemplateId)

	if var_11_7 == nil then
		echoInfo("error hero template id: " .. arg_11_1.HeroBaseInfo.TemplateId)

		return
	end

	if var_11_7.attackType == EAttackType.Magic then
		arg_11_0.attackname:setString(a2u("\xB7\xA8\xB9\xA5:"))
		arg_11_0.items[1]:setString(var_11_5[EAttrType.MagicAttack])
	elseif var_11_7.attackType == EAttackType.Physic then
		arg_11_0.attackname:setString(a2u("\xCE﹥:"))
		arg_11_0.items[1]:setString(var_11_5[EAttrType.PhysicAttack])
	end

	for iter_11_11 = 2, var_0_2 do
		arg_11_0.items[iter_11_11]:setString(var_11_5[var_0_1[iter_11_11]])
	end
end

function var_0_0.onTouchFateDown(arg_12_0)
	arg_12_0:refreshFate(arg_12_0.heroDetail.HeroBaseInfo.TemplateId)
	arg_12_0.layerFate:setVisible(true)
end

function var_0_0.onTouchFateEnd(arg_13_0)
	arg_13_0.layerFate:setVisible(false)
end

function var_0_0.refreshFate(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in pairs(arg_14_0.fateNode) do
		iter_14_1:setVisible(false)
	end

	arg_14_0.lbFateHint:setVisible(false)

	local var_14_0 = arg_14_0:getFateList(arg_14_1)

	if table.getn(var_14_0) <= 0 then
		arg_14_0.lbFateHint:setVisible(true)
		arg_14_0.spriteFateBg:setContentSize(CCSizeMake(450, 140))

		return
	else
		for iter_14_2 = 1, table.getn(var_14_0) do
			arg_14_0.fateNode[iter_14_2]:setVisible(true)

			local var_14_1 = var_14_0[iter_14_2]

			if var_14_1.fateType == EFateType.Hero then
				arg_14_0.fateType[iter_14_2]:setTexture(CCTextureCache:sharedTextureCache():addImage("image/rank/rank_fategreen.png"))

				local var_14_2, var_14_3 = zbIconHelper:getAwardIconPath(ECommonAwardType.Hero, var_14_1.fateCondition[1])

				arg_14_0.fateHero[iter_14_2]:setString(var_14_3)
			else
				arg_14_0.fateType[iter_14_2]:setTexture(CCTextureCache:sharedTextureCache():addImage("image/rank/rank_fatered.png"))

				local var_14_4, var_14_5 = zbIconHelper:getAwardIconPath(ECommonAwardType.Item, var_14_1.fateCondition[1])

				arg_14_0.fateHero[iter_14_2]:setString(var_14_5)
			end

			if var_14_1.growthPercent == 0 then
				arg_14_0.fateTitle[iter_14_2]:setString(a2u(getItemPropStr(var_14_1.fateAttr)) .. "+" .. growthValue)
			else
				arg_14_0.fateTitle[iter_14_2]:setString(a2u(getItemPropStr(var_14_1.fateAttr) .. "+" .. var_14_1.growthPercent * 100 .. "%"))
			end
		end
	end

	arg_14_0.spriteFateBg:setContentSize(CCSizeMake(450, 45 * table.getn(var_14_0)))
end

function var_0_0.getFateList(arg_15_0, arg_15_1)
	local var_15_0 = {}
	local var_15_1 = zbFateTable:getRecordTemplateId(arg_15_1)

	if var_15_1 ~= nil then
		for iter_15_0, iter_15_1 in ipairs(var_15_1) do
			if iter_15_1.fateType == EFateType.Hero then
				for iter_15_2, iter_15_3 in pairs(iter_15_1.fateCondition) do
					arg_15_0.haveHero = false

					for iter_15_4, iter_15_5 in pairs(g_GameData.HeroList) do
						if iter_15_5.HeroBaseInfo.TemplateId == iter_15_3 then
							arg_15_0.haveHero = true

							break
						end
					end

					if arg_15_0.haveHero then
						table.insert(var_15_0, iter_15_1)
					end
				end
			else
				for iter_15_6, iter_15_7 in pairs(iter_15_1.fateCondition) do
					arg_15_0.wearEquip = false

					for iter_15_8, iter_15_9 in pairs(arg_15_0.heroDetail.EquipList) do
						if iter_15_9.Equip.TemplateId == iter_15_7 then
							arg_15_0.wearEquip = true

							break
						end
					end

					if arg_15_0.wearEquip then
						table.insert(var_15_0, iter_15_1)
					end
				end
			end
		end
	end

	local function var_15_2(arg_16_0, arg_16_1)
		if arg_16_0.fateType == arg_16_1.fateType then
			return arg_16_0.id > arg_16_1.id
		end

		return arg_16_0.fateType > arg_16_1.fateType
	end

	table.sort(var_15_0, var_15_2)

	return var_15_0
end

function var_0_0.onTouchServantDown(arg_17_0)
	arg_17_0:refreshServant()
	arg_17_0.layerServant:setVisible(true)
end

function var_0_0.onTouchServantEnd(arg_18_0)
	arg_18_0.layerServant:setVisible(false)
end

local var_0_13 = {}

var_0_13[1] = "\xC1\xA6\xC1\xBF"
var_0_13[2] = "\xD6\xC7\xC1\xA6"
var_0_13[3] = "\xCC\xE5\xC1\xA6"

function var_0_0.refreshServant(arg_19_0, arg_19_1)
	local var_19_0 = zbHeroServantTable:getRecord(arg_19_0.heroDetail.HeroBaseInfo.TemplateId)

	if var_19_0 == nil then
		echoInfo("error hero template id: " .. arg_19_0.heroDetail.HeroBaseInfo.TemplateId)

		for iter_19_0 = 1, 3 do
			arg_19_0.servantNode[iter_19_0]:setVisible(false)
		end

		return
	end

	local var_19_1 = 0

	for iter_19_1 = 1, 3 do
		if arg_19_0.heroDetail.PartnerInfo.PartnerList[iter_19_1] > 0 then
			var_19_1 = var_19_1 + 1

			arg_19_0.servantNode[iter_19_1]:setVisible(true)

			local var_19_2 = g_Self.kHeroHandler:getHeroByTemplateId(arg_19_0.heroDetail.PartnerInfo.PartnerList[iter_19_1])
			local var_19_3 = zbHeroTable:getRecord(arg_19_0.heroDetail.PartnerInfo.PartnerList[iter_19_1])

			if arg_19_0.heroDetail.PartnerInfo.PartnerList[iter_19_1] == var_19_0.heroId[iter_19_1] then
				arg_19_0.servantHero[iter_19_1]:setString(var_19_3.name .. a2u("(\xCC\xD8\xCA\xE2)"))
				arg_19_0.servantTitle[iter_19_1]:setString(a2u(var_0_13[var_19_0.attrType[iter_19_1]]) .. " +" .. var_19_2.HeroBaseInfo.FV * var_19_0.specialPercent[iter_19_1])
			else
				arg_19_0.servantHero[iter_19_1]:setString(var_19_3.name)
				arg_19_0.servantTitle[iter_19_1]:setString(a2u(var_0_13[var_19_0.attrType[iter_19_1]]) .. " +" .. var_19_2.HeroBaseInfo.FV * var_19_0.percent[iter_19_1])
			end
		else
			arg_19_0.servantNode[iter_19_1]:setVisible(false)
		end
	end

	arg_19_0.lbServantHint:setVisible(var_19_1 == 0)
end

function var_0_0.refreshRichText(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_2 ~= nil then
		arg_20_2:removeFromParentAndCleanup(true)

		arg_20_2 = nil
	end

	local var_20_0 = arg_20_1:getTxtBound().width
	local var_20_1 = arg_20_1:getContentSize()

	arg_20_2 = CCRichLabelTTF:create(var_20_1.width, var_20_1.height, arg_20_1:getFontSize(), arg_20_1:getFontName(), ccc3(255, 255, 255), false)

	arg_20_2:setVisible(true)

	local var_20_2 = ccp(arg_20_1:getPosition())

	arg_20_2:setPosition(var_20_2.x, var_20_2.y)

	return arg_20_2
end

function var_0_0.onTouchTest(arg_21_0)
	local var_21_0 = arg_21_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_21_0.layer, var_21_0.x, var_21_0.y) == false then
		arg_21_0:hide()
	end
end
