local var_0_0 = class("zbItem", CCNodeExtend)

var_0_0.__index = var_0_0

function var_0_0.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, var_0_0)

	return arg_1_0
end

function createItem()
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNodeRGBA:create()))

	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.needTip = true
		arg_3_0.needShowGet = false
		arg_3_0.getType = nil
		arg_3_0.tipType = nil
		arg_3_0.heroData = nil
		arg_3_0.itemType = 1
		arg_3_0.itemId = 1
		arg_3_0.supprotTownTip = true
		arg_3_0.supportTouchTip = false
		arg_3_0.lbName = nil
		arg_3_0.spriteStars = nil
		arg_3_0.lbLv = nil
	end

	local function var_3_1()
		CCLabelTTF:beginDelayCreateTexture()

		local var_5_0 = zbUtil:loadCCBNode("ccbi/tb_item.ccbi")

		arg_3_0.layerContent = var_5_0
		arg_3_0.btnFrame = tolua.cast(var_5_0:getChildByTag(1), "CCControlButton")
		arg_3_0.spriteIcon = tolua.cast(var_5_0:getChildByTag(2), "CCSprite")
		arg_3_0.lbNumDummy = tolua.cast(var_5_0:getChildByTag(1005), "CCLabelTTF")
		arg_3_0.nodeStar = tolua.cast(var_5_0:getChildByTag(8), "CCNode")
		arg_3_0.lbNum = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbNumDummy, arg_3_0.lbNum)
		arg_3_0.lbNum:setScale(0.5)
		arg_3_0.btnFrame:addHandleOfControlEvent(function()
			arg_3_0:onTouchDown()
		end, CCControlEventTouchDown)
		arg_3_0.btnFrame:addHandleOfControlEvent(function()
			arg_3_0:onTouchEnd()
		end, CCControlEventTouchEnd)
		arg_3_0.btnFrame:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnFrame:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnFrame:setSwallowsTouches(true)
		arg_3_0:setContentSize(arg_3_0.spriteIcon:getContentSize())
		arg_3_0:addChild(var_5_0)
		zbUtil:setCascadeOpacityEnabled(var_5_0, true)
		CCLabelTTF:endDelayCreateTexture(var_5_0)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.setSwallowsTouches(arg_9_0, arg_9_1)
	arg_9_0.btnFrame:setSwallowsTouches(arg_9_1)
end

function var_0_0.setSupportTouchDownTip(arg_10_0, arg_10_1)
	arg_10_0.supprotTownTip = arg_10_1
end

function var_0_0.setSupportTouchTip(arg_11_0, arg_11_1)
	arg_11_0.supportTouchTip = arg_11_1
end

function var_0_0.setNeedTip(arg_12_0, arg_12_1)
	arg_12_0.needTip = arg_12_1
end

function var_0_0.setItemNumber(arg_13_0, arg_13_1)
	arg_13_0.lbNum:setString(arg_13_1)
	arg_13_0.lbNum:setVisible(true)
end

function var_0_0.setNodeStarVisible(arg_14_0)
	arg_14_0:createStar()
	arg_14_0.nodeStar:setVisible(true)
end

function var_0_0.setStarVisible(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 == ECommonAwardType.Hero or arg_15_1 == ECommonAwardType.HeroFrag then
		arg_15_0:createStar()

		local var_15_0 = zbHeroTable:getRecord(arg_15_2)

		if var_15_0 ~= nil then
			zbUIEffect:centerHeroStar(arg_15_0.spriteStars, var_15_0.star)
		end

		arg_15_0.nodeStar:setVisible(true)
	end
end

function var_0_0.refreshAward(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5)
	arg_16_0.tipType = ETipType.Award
	arg_16_0.itemType = arg_16_1
	arg_16_0.itemId = arg_16_2

	local var_16_0 = true
	local var_16_1 = true

	if arg_16_4 ~= nil then
		var_16_0 = arg_16_4
	end

	if arg_16_5 ~= nil then
		var_16_1 = arg_16_5
	end

	if var_16_0 then
		arg_16_0:createName()
	end

	arg_16_0.nodeStar:setVisible(false)
	zbAwardHelper:refreshAwardItem(arg_16_1, arg_16_2, arg_16_3, arg_16_0.btnFrame, arg_16_0.spriteIcon, arg_16_0.lbName, var_16_0)

	if var_16_1 == true and arg_16_1 ~= ECommonAwardType.Hero and arg_16_3 ~= nil then
		arg_16_0.lbNum:setVisible(true)

		if arg_16_3 > 9999999 then
			local var_16_2 = math.modf(arg_16_3 / 10000)

			arg_16_0.lbNum:setString(var_16_2 .. "<")
		else
			arg_16_0.lbNum:setString(arg_16_3)
		end
	else
		arg_16_0.lbNum:setVisible(false)
	end

	arg_16_0.layerContent:setVisible(true)
end

function var_0_0.refreshHero(arg_17_0, arg_17_1)
	arg_17_0.tipType = ETipType.Hero
	arg_17_0.heroData = arg_17_1

	arg_17_0.lbNum:setVisible(false)
	arg_17_0:createStar()
	arg_17_0:createLevel()
	zbAwardHelper:refreshHeroIcon(arg_17_1, arg_17_0.btnFrame, arg_17_0.spriteIcon, arg_17_0.lbLv, arg_17_0.spriteStars)
	arg_17_0.layerContent:setVisible(true)
end

function var_0_0.refreshBalanceHero(arg_18_0, arg_18_1)
	arg_18_0.tipType = ETipType.Hero
	arg_18_0.heroData = arg_18_1

	arg_18_0.lbNum:setVisible(false)
	arg_18_0:createStar()
	arg_18_0:createLevel()
	zbAwardHelper:refreshBalanceHeroIcon(arg_18_1, arg_18_0.btnFrame, arg_18_0.spriteIcon, arg_18_0.lbLv, arg_18_0.spriteStars)
	arg_18_0.layerContent:setVisible(true)
end

function var_0_0.refreshNpc(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0.tipType = ETipType.Award
	arg_19_0.itemType = ECommonAwardType.Hero
	arg_19_0.itemId = arg_19_1.templateId

	arg_19_0.lbNum:setVisible(false)
	arg_19_0.nodeStar:setVisible(false)
	arg_19_0:createLevel()
	zbAwardHelper:refreshNpcIconAndLevel(arg_19_1, arg_19_2, arg_19_0.btnFrame, arg_19_0.spriteIcon, arg_19_0.lbLv)
	arg_19_0.layerContent:setVisible(true)
end

function var_0_0.refreshHeroFrag(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5)
	arg_20_0.tipType = ETipType.Award
	arg_20_0.itemType = arg_20_1
	arg_20_0.itemId = arg_20_2

	local var_20_0 = true

	if arg_20_5 ~= nil then
		var_20_0 = arg_20_5
	end

	if var_20_0 then
		arg_20_0:createName()
	end

	arg_20_0.lbNum:setVisible(false)
	zbAwardHelper:refreshAwardItem(arg_20_1, arg_20_2, arg_20_3, arg_20_0.btnFrame, arg_20_0.spriteIcon, arg_20_0.lbName, var_20_0)
	arg_20_0.layerContent:setVisible(true)

	if arg_20_4 == false then
		arg_20_0.nodeStar:setVisible(false)
	else
		local var_20_1 = zbHeroTable:getRecord(arg_20_2)

		if var_20_1 ~= nil then
			arg_20_0:createStar()
			zbUIEffect:centerHeroStar(arg_20_0.spriteStars, var_20_1.star)
		end

		arg_20_0.nodeStar:setVisible(true)
	end
end

function var_0_0.refreshEquip(arg_21_0, arg_21_1)
	arg_21_0.lbNum:setVisible(false)
	arg_21_0.nodeStar:setVisible(false)
	arg_21_0:createLevel()
	zbAwardHelper:refreshEquipIcon(arg_21_1, arg_21_0.btnFrame, arg_21_0.spriteIcon, arg_21_0.lbLv)
	arg_21_0.layerContent:setVisible(true)
end

function var_0_0.refreshSkill(arg_22_0, arg_22_1)
	arg_22_0.tipType = ETipType.Skill
	arg_22_0.skillDetail = arg_22_1

	arg_22_0.lbNum:setVisible(false)
	arg_22_0.nodeStar:setVisible(false)
	zbAwardHelper:refreshSkillIcon(arg_22_1, arg_22_0.spriteIcon)
	arg_22_0.layerContent:setVisible(true)
end

function var_0_0.onTouchDown(arg_23_0)
	if arg_23_0.supprotTownTip then
		arg_23_0:showTip()
	end
end

function var_0_0.onTouchEnd(arg_24_0)
	if arg_24_0.supprotTownTip then
		g_MainScene:hideCommonTip()
	end
end

function var_0_0.onTouch(arg_25_0)
	if arg_25_0.supportTouchTip then
		arg_25_0:showTip()
	end
end

function var_0_0.showTip(arg_26_0)
	if arg_26_0.needTip == false or arg_26_0.tipType == nil then
		return
	end

	arg_26_0.lastDownTouch = arg_26_0.btnFrame:getTouch():getLocation()

	local var_26_0 = arg_26_0.btnFrame

	while var_26_0:getParent() ~= nil do
		var_26_0 = var_26_0:getParent()
	end

	local var_26_1 = var_26_0:convertToNodeSpace(arg_26_0.lastDownTouch)

	if arg_26_0.tipType == ETipType.Award then
		g_MainScene:showAwardTip(arg_26_0.itemType, arg_26_0.itemId)
	elseif arg_26_0.tipType == ETipType.Hero then
		g_MainScene:showHeroTip(arg_26_0.heroData)
	elseif arg_26_0.tipType == ETipType.Skill then
		g_MainScene:showSkillTip(arg_26_0.skillDetail.SkillId, arg_26_0.skillDetail.Level)
	end

	g_MainScene.wndCommomTip:refreshPos(var_26_1)
end

function var_0_0.setShowGetWay(arg_27_0, arg_27_1, arg_27_2)
	arg_27_0.needTip = false
	arg_27_0.needShowGet = true

	arg_27_0.btnFrame:addHandleOfControlEvent(function()
		arg_27_0:onShowGetWay(arg_27_1, arg_27_2)
	end, CCControlEventTouchUpInside)
end

function var_0_0.onShowGetWay(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_0.needShowGet == false or arg_29_1 == nil then
		return
	end

	if arg_29_2 == EGetWayType.NormalItem then
		g_MainScene:showGetWayWnd(arg_29_1, ECommonAwardType.Item)
	elseif arg_29_2 == EGetWayType.Hero then
		g_MainScene:showHeroGetWay(arg_29_1)
	end
end

function var_0_0.fadeOut(arg_30_0, arg_30_1)
	local function var_30_0()
		arg_30_0.layerContent:setVisible(false)
	end

	local var_30_1 = CCArray:create()

	var_30_1:addObject(CCDelayTime:create(0.9))
	var_30_1:addObject(CCFadeTo:create(arg_30_1, 0))
	var_30_1:addObject(CCCallFuncN:create(var_30_0))

	local var_30_2 = CCSequence:create(var_30_1)

	arg_30_0:setOpacity(255)
	arg_30_0:stopAllActions()
	arg_30_0:runAction(var_30_2)
end

function var_0_0.createStar(arg_32_0)
	if arg_32_0.spriteStars ~= nil then
		return
	end

	arg_32_0.spriteStars = {}

	for iter_32_0 = 1, 8 do
		local var_32_0 = CCSprite:create("image/star/star_herolist.png")

		var_32_0:setPosition(0, 25)
		arg_32_0.nodeStar:addChild(var_32_0)

		arg_32_0.spriteStars[iter_32_0] = var_32_0
	end
end

function var_0_0.createLevel(arg_33_0)
	if arg_33_0.lbLv ~= nil then
		return
	end

	arg_33_0.lbLv = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

	arg_33_0.lbLv:setScale(0.5)
	arg_33_0.lbLv:setPosition(14, 85)
	arg_33_0.lbLv:setAnchorPoint(ccp(0, 0.5))
	arg_33_0.layerContent:addChild(arg_33_0.lbLv)
end

function var_0_0.createName(arg_34_0)
	if arg_34_0.lbName ~= nil then
		return
	end

	arg_34_0.lbName = CCLabelTTF:create("", DefaultFontName, 20)

	arg_34_0.lbName:setPosition(55, -14)
	arg_34_0.lbName:setAnchorPoint(ccp(0.5, 0.5))
	ui:setTTFStroke(arg_34_0.lbName)
	arg_34_0.layerContent:addChild(arg_34_0.lbName)
end
