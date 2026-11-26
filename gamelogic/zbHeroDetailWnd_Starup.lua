zbHeroDetailWnd_Starup = class("zbHeroDetailWnd_Starup", CCNodeExtend)
zbHeroDetailWnd_Starup.__index = zbHeroDetailWnd_Starup

function zbHeroDetailWnd_Starup.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbHeroDetailWnd_Starup)

	return arg_1_0
end

function createHeroDetailWnd_StarupPanel(arg_2_0, arg_2_1)
	local var_2_0 = zbHeroDetailWnd_Starup.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0, arg_2_1)

	return var_2_0
end

function zbHeroDetailWnd_Starup.init(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0()
		arg_3_0.dataStar = {}
		arg_3_0.parentWnd = arg_3_2
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		arg_3_0.layer = var_5_0
		arg_3_0.nodeCurr = tolua.cast(arg_3_0.layer:getChildByTag(1), "CCSprite")
		arg_3_0.nodeNext = tolua.cast(arg_3_0.layer:getChildByTag(2), "CCSprite")
		arg_3_0.spriteGoto = tolua.cast(arg_3_0.layer:getChildByTag(3), "CCSprite")
		arg_3_0.currPositionX = arg_3_0.nodeCurr:getPositionX()
		arg_3_0.nextPositionX = arg_3_0.nodeNext:getPositionX()
		arg_3_0.spriteCurrStars = {}
		arg_3_0.spriteNextStars = {}

		for iter_5_0 = 1, 8 do
			arg_3_0.spriteCurrStars[iter_5_0] = arg_3_0.nodeCurr:getChildByTag(iter_5_0)
			arg_3_0.spriteNextStars[iter_5_0] = arg_3_0.nodeNext:getChildByTag(iter_5_0)
		end

		arg_3_0.nodeValue = {}
		arg_3_0.value1 = {}
		arg_3_0.value2 = {}

		for iter_5_1 = 1, 3 do
			arg_3_0.nodeValue[iter_5_1] = tolua.cast(var_5_0:getChildByTag(iter_5_1 + 10), "CCNode")

			local var_5_1 = tolua.cast(arg_3_0.nodeValue[iter_5_1]:getChildByTag(1001), "CCLabelTTF")
			local var_5_2 = tolua.cast(arg_3_0.nodeValue[iter_5_1]:getChildByTag(1002), "CCLabelTTF")

			arg_3_0.value1[iter_5_1] = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

			require("gamebase.zbUI"):replaceCtrl(var_5_1, arg_3_0.value1[iter_5_1])
			arg_3_0.value1[iter_5_1]:setScale(0.55)

			arg_3_0.value2[iter_5_1] = CCLabelAtlas:create("", "font/rank_num_green.png", 26, 42, string.byte("+"))

			require("gamebase.zbUI"):replaceCtrl(var_5_2, arg_3_0.value2[iter_5_1])
			arg_3_0.value2[iter_5_1]:setScale(0.55)
		end

		arg_3_0.nodeuse = {}
		arg_3_0.useItem = {}
		arg_3_0.needItem = {}
		arg_3_0.haveItem = {}

		for iter_5_2 = 1, 3 do
			arg_3_0.nodeuse[iter_5_2] = tolua.cast(var_5_0:getChildByTag(iter_5_2 * 100), "CCNode")

			local var_5_3 = tolua.cast(arg_3_0.nodeuse[iter_5_2]:getChildByTag(1), "CCLayer")

			var_5_3:setVisible(false)

			arg_3_0.useItem[iter_5_2] = createItem()

			local var_5_4 = ccp(var_5_3:getPosition())

			arg_3_0.useItem[iter_5_2]:setPosition(var_5_3:getPosition())
			arg_3_0.useItem[iter_5_2]:setScale(0.75)
			arg_3_0.useItem[iter_5_2]:setNeedTip(true)
			arg_3_0.nodeuse[iter_5_2]:addChild(arg_3_0.useItem[iter_5_2])

			arg_3_0.needItem[iter_5_2] = tolua.cast(arg_3_0.nodeuse[iter_5_2]:getChildByTag(3), "CCLabelTTF")

			if iter_5_2 == 1 then
				arg_3_0.haveItem[iter_5_2] = tolua.cast(arg_3_0.nodeuse[iter_5_2]:getChildByTag(4), "CCLabelTTF")
			end
		end

		arg_3_0.nodeuse[3]:setVisible(false)

		arg_3_0.btnStarup = tolua.cast(var_5_0:getChildByTag(50), "CCControlButton")
		arg_3_0.btnZhuling = tolua.cast(var_5_0:getChildByTag(60), "CCControlButton")
		arg_3_0.lbMaxHint = tolua.cast(var_5_0:getChildByTag(70), "CCLabelTTF")

		arg_3_0.btnStarup:addHandleOfControlEvent(function()
			arg_3_0:onStarUpgrade()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnZhuling:addHandleOfControlEvent(function()
			arg_3_0:onZhuling()
		end, CCControlEventTouchUpInside)
		arg_3_1:setZOrder(ZORDER_TOP)
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function zbHeroDetailWnd_Starup.refresh(arg_8_0, arg_8_1)
	arg_8_0.hero = arg_8_1

	local var_8_0 = zbHeroTable:getRecord(arg_8_1.HeroBaseInfo.TemplateId)

	if var_8_0 == nil then
		echoInfo("error hero template id: " .. arg_8_1.HeroBaseInfo.TemplateId)

		return
	end

	local var_8_1 = arg_8_1.HeroBaseInfo.Star
	local var_8_2 = 0

	if var_8_1 >= var_8_0.startMax then
		var_8_2 = var_8_1

		for iter_8_0 = 1, 2 do
			arg_8_0.nodeuse[iter_8_0]:setVisible(false)
		end

		arg_8_0.btnStarup:setVisible(false)
		arg_8_0.lbMaxHint:setVisible(true)
		arg_8_0.btnZhuling:setVisible(true)
		arg_8_0.nodeNext:setVisible(false)
		arg_8_0.spriteGoto:setVisible(false)
		arg_8_0.nodeCurr:setPositionX((arg_8_0.currPositionX + arg_8_0.nextPositionX) / 2)
	else
		var_8_2 = var_8_1 + 1

		for iter_8_1 = 1, 2 do
			arg_8_0.nodeuse[iter_8_1]:setVisible(true)
		end

		arg_8_0.btnStarup:setVisible(true)
		arg_8_0.lbMaxHint:setVisible(false)
		arg_8_0.btnZhuling:setVisible(false)
		arg_8_0.nodeNext:setVisible(true)
		arg_8_0.spriteGoto:setVisible(true)
		arg_8_0.nodeCurr:setPositionX(arg_8_0.currPositionX)
	end

	zbUIEffect:centerHeroStar(arg_8_0.spriteCurrStars, var_8_1)
	zbUIEffect:centerHeroStar(arg_8_0.spriteNextStars, var_8_2)

	force, intelligence, tili = g_Self.kHeroHandler:getHeroGrow(arg_8_1.HeroBaseInfo.TemplateId, arg_8_1.HeroBaseInfo.Level, arg_8_1.HeroBaseInfo.Star, arg_8_1.HeroBaseInfo.Quality)

	arg_8_0.value1[1]:setString(tonumber(string.format("%.1f", force)))
	arg_8_0.value1[2]:setString(tonumber(string.format("%.1f", intelligence)))
	arg_8_0.value1[3]:setString(tonumber(string.format("%.1f", tili)))

	force, intelligence, tili = g_Self.kHeroHandler:getHeroGrow(arg_8_1.HeroBaseInfo.TemplateId, arg_8_1.HeroBaseInfo.Level, arg_8_1.HeroBaseInfo.Star + 1, arg_8_1.HeroBaseInfo.Quality)

	arg_8_0.value2[1]:setString(tonumber(string.format("%.1f", force)))
	arg_8_0.value2[2]:setString(tonumber(string.format("%.1f", intelligence)))
	arg_8_0.value2[3]:setString(tonumber(string.format("%.1f", tili)))

	local var_8_3 = g_Self.kHeroFragHandler:getHeroComposeNeeds(arg_8_1.HeroBaseInfo.TemplateId)
	local var_8_4 = g_Self.kHeroFragHandler:getHeroFragCount(arg_8_0.hero.HeroBaseInfo.TemplateId)

	arg_8_0.needItem[1]:setString(var_8_4)
	arg_8_0.haveItem[1]:setString(a2u("/") .. var_8_3.needFrag)

	local var_8_5 = zbHeroStarUpgradeTable:getRecord(var_8_1)

	arg_8_0.needItem[2]:setString(var_8_5.gold)

	if var_8_4 < var_8_3.needFrag then
		arg_8_0.needItem[1]:setColor(FONT_COLOR_RED)
	else
		arg_8_0.needItem[1]:setColor(FONT_COLOR_GREEN)
	end

	arg_8_0.useItem[1]:refreshHeroFrag(ECommonAwardType.HeroFrag, arg_8_0.hero.HeroBaseInfo.TemplateId, var_8_4, false, false)
	arg_8_0.useItem[2]:refreshAward(ECommonAwardType.Gold, -1, var_8_5.gold, false, false)

	if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Gold, var_8_5.gold) == false then
		arg_8_0.needItem[2]:setColor(FONT_COLOR_RED)
	else
		arg_8_0.needItem[2]:setColor(FONT_COLOR_GREEN)
	end
end

function zbHeroDetailWnd_Starup.onStarUpgrade(arg_9_0)
	if arg_9_0.hero == nil then
		return
	end

	local var_9_0 = zbHeroTable:getRecord(arg_9_0.hero.HeroBaseInfo.TemplateId)

	if var_9_0 == nil then
		echoInfo("error hero template id: " .. arg_9_0.hero.HeroBaseInfo.TemplateId)

		return
	end

	if arg_9_0.hero.HeroBaseInfo.Star >= var_9_0.startMax then
		g_Bubble:bubbleInfo("\xD2ѵ\xBD\xD7\xEE\xB4\xF3\xD0Ǽ\xB6")

		return
	end

	local var_9_1 = g_Self.kHeroFragHandler:getHeroComposeNeeds(arg_9_0.hero.HeroBaseInfo.TemplateId)

	if g_Self.kHeroFragHandler:getHeroFragCount(arg_9_0.hero.HeroBaseInfo.TemplateId) < var_9_1.needFrag then
		g_MainScene:showHeroGetWay(arg_9_0.hero.HeroBaseInfo.TemplateId)

		return
	end

	local var_9_2 = zbHeroStarUpgradeTable:getRecord(arg_9_0.hero.HeroBaseInfo.Star)

	if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Gold, var_9_2.gold) == false then
		g_Bubble:bubbleInfo(a2u("\xBD\xF0\xDF\xF7\xB1Ҳ\xBB\xD7\xE3"))

		return
	end

	g_WsMsgHandler:WS_Hero_UpgradeStar_Req(arg_9_0.hero.HeroBaseInfo.TemplateId)
end

function zbHeroDetailWnd_Starup.onZhuling(arg_10_0)
	g_MainScene:showHeroExtraAttrWnd(arg_10_0.hero)
end
