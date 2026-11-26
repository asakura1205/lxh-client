require("gamelogic.zbHeroAvatar")

local var_0_0 = 30
local var_0_1 = class("zbHeroDetailWnd_Avatar")

var_0_1.__index = var_0_1

function createHeroDetailAvatarPanel(arg_1_0, arg_1_1)
	local var_1_0 = var_0_1.new()

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_1.init(arg_2_0, arg_2_1, arg_2_2)
	local function var_2_0()
		arg_2_0.lastHeroData = nil
		arg_2_0.heroNewData = nil
		arg_2_0.lastHeroTemplateId = 0
		arg_2_0.changeData = {}
		arg_2_0.initPos = {}
		arg_2_0.attrLbList = {}
		arg_2_0.lastPower = 0
		arg_2_0.curPower = 0
		arg_2_0.posbtn = {}
	end

	local function var_2_1()
		arg_2_0.layer = arg_2_1
		arg_2_0.wndParent = arg_2_2
		arg_2_0.spriteAttType = tolua.cast(arg_2_1:getChildByTag(2), "CCSprite")
		arg_2_0.spriteRarity = tolua.cast(arg_2_1:getChildByTag(3), "CCSprite")
		arg_2_0.lbName = tolua.cast(arg_2_1:getChildByTag(13), "CCLabelTTF")
		arg_2_0.qualityRoot = tolua.cast(arg_2_1:getChildByTag(14), "CCNode")
		arg_2_0.bmLevelDummy = tolua.cast(arg_2_1:getChildByTag(15), "CCLabelTTF")
		arg_2_0.bmCombatPowerDummy = tolua.cast(arg_2_1:getChildByTag(16):getChildByTag(16), "CCLabelTTF")
		arg_2_0.layerAvatar = tolua.cast(arg_2_1:getChildByTag(17), "CCNode")
		arg_2_0.layerChange = tolua.cast(arg_2_1:getChildByTag(150), "CCNode")
		arg_2_0.btnAvatarTouch = tolua.cast(arg_2_1:getChildByTag(37), "CCControlButton")
		arg_2_0.lbAttr1 = tolua.cast(arg_2_0.layerChange:getChildByTag(1), "CCLabelTTF")
		arg_2_0.lbAttr2 = tolua.cast(arg_2_0.layerChange:getChildByTag(2), "CCLabelTTF")
		arg_2_0.lbAttr3 = tolua.cast(arg_2_0.layerChange:getChildByTag(3), "CCLabelTTF")
		arg_2_0.bmLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_2_0.bmLevelDummy, arg_2_0.bmLevel)

		arg_2_0.bmCombatPower = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_2_0.bmCombatPowerDummy, arg_2_0.bmCombatPower)
		arg_2_0.bmLevel:setScale(0.55)
		arg_2_0.bmCombatPower:setScale(0.55)

		arg_2_0.initPos[1] = ccp(arg_2_0.lbAttr1:getPosition())
		arg_2_0.initPos[2] = ccp(arg_2_0.lbAttr2:getPosition())
		arg_2_0.initPos[3] = ccp(arg_2_0.lbAttr3:getPosition())
		arg_2_0.attrLbList[1] = arg_2_0.lbAttr1
		arg_2_0.attrLbList[2] = arg_2_0.lbAttr2
		arg_2_0.attrLbList[3] = arg_2_0.lbAttr3

		arg_2_0.lbAttr1:setOpacity(0)
		arg_2_0.lbAttr2:setOpacity(0)
		arg_2_0.lbAttr3:setOpacity(0)

		arg_2_0.spriteStars = {}

		for iter_4_0 = 1, 8 do
			arg_2_0.spriteStars[iter_4_0] = arg_2_0.qualityRoot:getChildByTag(iter_4_0)
		end

		arg_2_0.btnAvatarTouch:addHandleOfControlEvent(function()
			arg_2_0:onAvatarTouch()
		end, CCControlEventTouchUpInside)
	end

	local function var_2_2()
		arg_2_0.heroAvatar = createHeroAvatar()

		arg_2_0.heroAvatar:setRotationY(180)
		arg_2_0.heroAvatar:setPosition(arg_2_0.layerAvatar:getContentSize().width / 2 - 30, 35)
		arg_2_0.layerAvatar:addChild(arg_2_0.heroAvatar)
	end

	var_2_0()
	var_2_1()
	var_2_2()
end

function var_0_1.visibleNotify(arg_7_0)
	return
end

function var_0_1.refreshDetail(arg_8_0, arg_8_1)
	if arg_8_1 == nil then
		return
	end

	arg_8_0:compairHeroDataChange(arg_8_1)

	arg_8_0.hero = arg_8_1
	arg_8_0.lastPower = arg_8_0.lastPower, arg_8_0:refresh(arg_8_1)
	arg_8_0.step = math.ceil((arg_8_0.curPower - arg_8_0.lastPower) * 0.05)

	if arg_8_0.step < 1 then
		arg_8_0.step = 1
	end

	if arg_8_0.lastPower >= arg_8_0.curPower then
		arg_8_0.bmCombatPower:setString(arg_8_0.hero.HeroBaseInfo.FV)
	end
end

function var_0_1.compairHeroDataChange(arg_9_0, arg_9_1)
	if arg_9_0.lastHeroTemplateId ~= arg_9_1.HeroBaseInfo.TemplateId then
		arg_9_0.lastHeroTemplateId = arg_9_1.HeroBaseInfo.TemplateId
		arg_9_0.lastHeroData = arg_9_1

		arg_9_0.layerChange:setVisible(false)

		return
	end

	arg_9_0.heroNewData = arg_9_1

	local var_9_0 = zbHeroHelper:getHeroAttributeTable(arg_9_0.lastHeroData)
	local var_9_1 = zbHeroHelper:getHeroAttributeTable(arg_9_1)

	arg_9_0.changeStep = 0
	arg_9_0.changeData = {}

	for iter_9_0, iter_9_1 in pairs(var_9_1) do
		local var_9_2 = zbHeroTable:getRecord(arg_9_1.HeroBaseInfo.TemplateId)

		if var_9_2 == nil then
			echoInfo("error hero template id: " .. arg_9_1.TemplateId)

			return
		end

		if iter_9_0 < EAttrType.HP or var_9_2.attackType == EAttackType.Physic and iter_9_0 == EAttrType.MagicAttack or var_9_2.attackType == EAttackType.Magic and iter_9_0 == EAttrType.PhysicAttack then
			-- block empty
		else
			arg_9_0:putAttrString(iter_9_0, iter_9_1, var_9_0[iter_9_0])
		end
	end

	arg_9_0.lastHeroData = arg_9_0.heroNewData

	arg_9_0:nextChange()
end

function var_0_1.putAttrString(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = math.round(arg_10_2 - arg_10_3)

	if math.abs(var_10_0) > 5 then
		local var_10_1 = {}

		if var_10_0 < 0 then
			var_10_1.color = FONT_COLOR_RED
			var_10_1.attrName = a2u(g_strAttrType[arg_10_1]) .. var_10_0
		else
			var_10_1.color = FONT_COLOR_GREEN
			var_10_1.attrName = a2u(g_strAttrType[arg_10_1]) .. " +" .. var_10_0
		end

		arg_10_0.changeStep = arg_10_0.changeStep + 1
		arg_10_0.changeData[arg_10_0.changeStep] = var_10_1
	end
end

function var_0_1.runFunc(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	arg_11_2:setPosition(arg_11_3)
	arg_11_2:setColor(arg_11_1[arg_11_4].color)
	arg_11_2:setString(arg_11_1[arg_11_4].attrName)
	arg_11_2:setOpacity(0)
end

function var_0_1.nextChange(arg_12_0)
	local var_12_0 = table.getn(arg_12_0.changeData)

	if var_12_0 <= 0 then
		return
	end

	arg_12_0.layerChange:setVisible(true)

	local var_12_1 = {}

	for iter_12_0, iter_12_1 in pairs(arg_12_0.changeData) do
		var_12_1[iter_12_0] = iter_12_1
	end

	for iter_12_2 = 1, 3 do
		local var_12_2 = arg_12_0.attrLbList[iter_12_2]
		local var_12_3 = arg_12_0.initPos[iter_12_2]
		local var_12_4 = CCArray:create()
		local var_12_5 = 0

		for iter_12_3 = iter_12_2, var_12_0, 3 do
			local var_12_6 = math.ceil(zbUtil:random(60, 80))

			var_12_4:addObject(CCDelayTime:create(0.15 * iter_12_2))
			var_12_4:addObject(CCCallFuncN:create(function()
				arg_12_0:runFunc(var_12_1, var_12_2, var_12_3, iter_12_3)
			end))
			var_12_4:addObject(CCFadeIn:create(0.125))
			var_12_4:addObject(CCEaseIn:create(CCMoveTo:create(1 + 0.2 * iter_12_2, ccp(var_12_3.x, var_12_3.y + var_12_6)), 0.8))
			var_12_4:addObject(CCFadeTo:create(0.05, 0))

			var_12_5 = var_12_5 + 1
		end

		if var_12_5 > 0 then
			local var_12_7 = CCSequence:create(var_12_4)

			var_12_2:stopAllActions()
			var_12_2:runAction(var_12_7)
		end
	end
end

function var_0_1.refresh(arg_14_0, arg_14_1)
	if arg_14_1 == nil then
		arg_14_0.hero = nil

		return
	end

	arg_14_0.hero = arg_14_1

	local var_14_0 = zbHeroTable:getRecord(arg_14_0.hero.HeroBaseInfo.TemplateId)

	if var_14_0 == nil then
		echoInfo("error hero template id: " .. arg_14_0.hero.HeroBaseInfo.TemplateId)

		return
	end

	arg_14_0.spriteAttType:setTexture(CCTextureCache:sharedTextureCache():addImage(zbIconHelper:getHeroTypeIconPath(var_14_0.heroType)))
	arg_14_0.spriteRarity:setTexture(CCTextureCache:sharedTextureCache():addImage("image/herodetail/herodetail_rarity" .. var_14_0.rarity .. ".png"))
	arg_14_0:compairHeroDataChange(arg_14_1)
	arg_14_0.bmCombatPower:setString(arg_14_0.hero.HeroBaseInfo.FV)

	arg_14_0.curPower = arg_14_0.hero.HeroBaseInfo.FV
	arg_14_0.lastPower = arg_14_0.hero.HeroBaseInfo.FV
	exchQuality, exchAdd = zbHeroQualityTable:exchangeHeroQuality(arg_14_1.HeroBaseInfo.Quality)

	arg_14_0.lbName:setString(var_14_0.name)

	if exchAdd ~= 0 then
		arg_14_0.lbName:setString(var_14_0.name .. "+" .. exchAdd)
	end

	local var_14_1 = zbColor:getItemColor(exchQuality)

	arg_14_0.lbName:setColor(var_14_1)
	arg_14_0.bmLevel:setString(arg_14_0.hero.HeroBaseInfo.Level)

	local var_14_2 = arg_14_0.hero.HeroBaseInfo.Star

	zbUIEffect:centerHeroStar(arg_14_0.spriteStars, arg_14_0.hero.HeroBaseInfo.Star, nil, nil, 1.8)
	arg_14_0.heroAvatar:refresh(arg_14_0.hero.HeroBaseInfo.TemplateId)
end

function var_0_1.onAvatarTouch(arg_15_0)
	if arg_15_0.heroAvatar:numberOfRunningActions() > 0 then
		return
	end

	local var_15_0 = zbAvatarTable:getAvatarSoundPath(arg_15_0.hero.HeroBaseInfo.TemplateId, ESoundType.E_CLICK)

	g_Audio:playSound(var_15_0)

	local var_15_1 = CCArray:create()

	var_15_1:addObject(CCCallFuncN:create(function()
		arg_15_0.heroAvatar:playRandomAnimation()
	end))
	var_15_1:addObject(CCDelayTime:create(1.5))

	local var_15_2 = CCSequence:create(var_15_1)

	arg_15_0.heroAvatar:stopAllActions()
	arg_15_0.heroAvatar:runAction(var_15_2)
end
