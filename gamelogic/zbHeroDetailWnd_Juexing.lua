zbHeroDetailWnd_Juexing = class("zbHeroDetailWnd_Juexing", CCNodeExtend)
zbHeroDetailWnd_Juexing.__index = zbHeroDetailWnd_Juexing

function zbHeroDetailWnd_Juexing.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbHeroDetailWnd_Juexing)

	return arg_1_0
end

function zbHeroDetailWnd_Juexing.init(arg_2_0, arg_2_1)
	local function var_2_0()
		arg_2_0.dataStar = {}
	end

	local function var_2_1()
		local var_4_0 = tolua.cast(arg_2_1:getChildByTag(1), "CCNode")

		arg_2_0.layer = var_4_0
		arg_2_0.currName = tolua.cast(var_4_0:getChildByTag(1), "CCLabelTTF")
		arg_2_0.nextName = tolua.cast(var_4_0:getChildByTag(2), "CCLabelTTF")
		arg_2_0.lbLimitLevel = tolua.cast(var_4_0:getChildByTag(3), "CCLabelTTF")
		arg_2_0.nodeValue = {}
		arg_2_0.value1 = {}
		arg_2_0.value2 = {}

		for iter_4_0 = 1, 3 do
			arg_2_0.nodeValue[iter_4_0] = tolua.cast(var_4_0:getChildByTag(iter_4_0 + 10), "CCNode")

			local var_4_1 = tolua.cast(arg_2_0.nodeValue[iter_4_0]:getChildByTag(1001), "CCLabelTTF")
			local var_4_2 = tolua.cast(arg_2_0.nodeValue[iter_4_0]:getChildByTag(1002), "CCLabelTTF")

			arg_2_0.value1[iter_4_0] = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

			require("gamebase.zbUI"):replaceCtrl(var_4_1, arg_2_0.value1[iter_4_0])
			arg_2_0.value1[iter_4_0]:setScale(0.55)

			arg_2_0.value2[iter_4_0] = CCLabelAtlas:create("", "font/rank_num_green.png", 26, 42, string.byte("+"))

			require("gamebase.zbUI"):replaceCtrl(var_4_2, arg_2_0.value2[iter_4_0])
			arg_2_0.value2[iter_4_0]:setScale(0.55)
		end

		arg_2_0.nodeuse = {}
		arg_2_0.useItem = {}
		arg_2_0.needItem = {}
		arg_2_0.haveItem = {}

		for iter_4_1 = 1, 5 do
			arg_2_0.nodeuse[iter_4_1] = tolua.cast(var_4_0:getChildByTag(iter_4_1 * 100), "CCNode")

			local var_4_3 = tolua.cast(arg_2_0.nodeuse[iter_4_1]:getChildByTag(1), "CCLayer")

			var_4_3:setVisible(false)

			arg_2_0.useItem[iter_4_1] = createItem()

			local var_4_4 = ccp(var_4_3:getPosition())

			arg_2_0.useItem[iter_4_1]:setPosition(var_4_3:getPosition())
			arg_2_0.useItem[iter_4_1]:setScale(0.8)
			arg_2_0.useItem[iter_4_1]:setNeedTip(true)
			arg_2_0.nodeuse[iter_4_1]:addChild(arg_2_0.useItem[iter_4_1])

			arg_2_0.needItem[iter_4_1] = tolua.cast(arg_2_0.nodeuse[iter_4_1]:getChildByTag(3), "CCLabelTTF")
			arg_2_0.haveItem[iter_4_1] = tolua.cast(arg_2_0.nodeuse[iter_4_1]:getChildByTag(4), "CCLabelTTF")
		end

		arg_2_0.btnStarup = tolua.cast(var_4_0:getChildByTag(50), "CCControlButton")

		arg_2_0.btnStarup:addHandleOfControlEvent(function()
			arg_2_0:onStarUpgrade()
		end, CCControlEventTouchUpInside)
		arg_2_1:setZOrder(ZORDER_TOP)
		arg_2_0:addChild(arg_2_1)
	end

	var_2_0()
	var_2_1()
end

function zbHeroDetailWnd_Juexing.refresh(arg_6_0, arg_6_1)
	arg_6_0.hero = arg_6_1

	local var_6_0 = zbHeroTable:getRecord(arg_6_1.HeroBaseInfo.TemplateId)

	if var_6_0 == nil then
		echoInfo("error hero template id: " .. arg_6_1.HeroBaseInfo.TemplateId)

		return
	end

	arg_6_0.heroRecord = var_6_0

	local var_6_1 = arg_6_1.HeroBaseInfo.Quality + 1

	if var_6_1 >= var_6_0.qualityMax then
		var_6_1 = var_6_0.qualityMax
	end

	local var_6_2, var_6_3 = zbHeroQualityTable:exchangeHeroQuality(arg_6_1.HeroBaseInfo.Quality)

	arg_6_0.currName:setString(var_6_0.name)

	if var_6_3 ~= 0 then
		arg_6_0.currName:setString(var_6_0.name .. "+" .. var_6_3)
	end

	local var_6_4 = zbColor:getHeroNameColor(arg_6_1.HeroBaseInfo.Quality)

	arg_6_0.currName:setColor(var_6_4)

	local var_6_5, var_6_6 = zbHeroQualityTable:exchangeHeroQuality(var_6_1)

	arg_6_0.nextName:setString(var_6_0.name)

	if var_6_6 ~= 0 then
		arg_6_0.nextName:setString(var_6_0.name .. "+" .. var_6_6)
	end

	local var_6_7 = zbColor:getHeroNameColor(var_6_1)

	arg_6_0.nextName:setColor(var_6_7)

	local var_6_8, var_6_9, var_6_10 = g_Self.kHeroHandler:getHeroGrow(arg_6_1.HeroBaseInfo.TemplateId, arg_6_1.HeroBaseInfo.Level, arg_6_1.HeroBaseInfo.Star, arg_6_1.HeroBaseInfo.Quality)

	arg_6_0.value1[1]:setString(tonumber(string.format("%.1f", var_6_8)))
	arg_6_0.value1[2]:setString(tonumber(string.format("%.1f", var_6_9)))
	arg_6_0.value1[3]:setString(tonumber(string.format("%.1f", var_6_10)))

	local var_6_11, var_6_12, var_6_13 = g_Self.kHeroHandler:getHeroGrow(arg_6_1.HeroBaseInfo.TemplateId, arg_6_1.HeroBaseInfo.Level, arg_6_1.HeroBaseInfo.Star, var_6_1)

	arg_6_0.value2[1]:setString(tonumber(string.format("%.1f", var_6_11)))
	arg_6_0.value2[2]:setString(tonumber(string.format("%.1f", var_6_12)))
	arg_6_0.value2[3]:setString(tonumber(string.format("%.1f", var_6_13)))

	for iter_6_0 = 1, 5 do
		arg_6_0.nodeuse[iter_6_0]:setVisible(false)
	end

	if arg_6_1.HeroBaseInfo.Quality >= var_6_0.qualityMax then
		arg_6_0.lbLimitLevel:setVisible(false)
		arg_6_0.btnStarup:setVisible(false)

		return
	end

	local var_6_14 = zbHeroQualityUpgradeTable:getRecord(var_6_0.qualityUpId, arg_6_1.HeroBaseInfo.Quality)
	local var_6_15 = 1

	for iter_6_1, iter_6_2 in pairs(var_6_14.item) do
		arg_6_0.useItem[var_6_15]:refreshAward(iter_6_2[1], iter_6_2[2], iter_6_2[3], false, false)

		local var_6_16 = g_Self.kBagItemHandler:getItemCountByTemplateId(iter_6_2[2])

		arg_6_0.needItem[var_6_15]:setString(var_6_16)
		arg_6_0.haveItem[var_6_15]:setString("/" .. iter_6_2[3])

		if var_6_16 < iter_6_2[3] then
			arg_6_0.needItem[var_6_15]:setColor(FONT_COLOR_RED)
			arg_6_0.useItem[var_6_15]:setShowGetWay(iter_6_2[2], EGetWayType.NormalItem)
		else
			arg_6_0.needItem[var_6_15]:setColor(FONT_COLOR_GREEN)
			arg_6_0.useItem[var_6_15]:setShowGetWay(iter_6_2[2], EGetWayType.NormalItem)
		end

		arg_6_0.nodeuse[var_6_15]:setVisible(true)

		var_6_15 = var_6_15 + 1
	end

	if arg_6_0.hero.HeroBaseInfo.Level < var_6_14.heroLvl then
		arg_6_0.lbLimitLevel:setVisible(true)
		arg_6_0.btnStarup:setVisible(false)
		arg_6_0.lbLimitLevel:setString(a2u("\xD0\xE8Ҫ\xBB\xEF\xB0\xE9") .. var_6_14.heroLvl .. a2u("\xBC\xB6"))
	else
		arg_6_0.lbLimitLevel:setVisible(false)
		arg_6_0.btnStarup:setVisible(true)
	end

	arg_6_0.nodeuse[5]:setVisible(true)
	arg_6_0.needItem[5]:setString(var_6_14.gold)
	arg_6_0.useItem[5]:refreshAward(ECommonAwardType.Gold, -1, var_6_14.gold, false, false)

	if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Gold, var_6_14.gold) == true then
		arg_6_0.needItem[5]:setColor(FONT_COLOR_GREEN)
	else
		arg_6_0.needItem[5]:setColor(FONT_COLOR_RED)
	end
end

function zbHeroDetailWnd_Juexing.onStarUpgrade(arg_7_0)
	if arg_7_0.hero == nil then
		return
	end

	local var_7_0 = zbHeroQualityUpgradeTable:getRecord(arg_7_0.heroRecord.qualityUpId, arg_7_0.hero.HeroBaseInfo.Quality)

	if var_7_0.heroLvl > arg_7_0.hero.HeroBaseInfo.Level then
		g_Bubble:bubbleInfo(a2u("\xBB\xEF\xB0\xE9\xB5ȼ\xB6\xB2\xBB\xD7\xE3"))

		return
	end

	local var_7_1 = 1

	for iter_7_0, iter_7_1 in pairs(var_7_0.item) do
		if g_Self.kBagItemHandler:getItemCountByTemplateId(iter_7_1[2]) < iter_7_1[3] then
			g_MainScene:showGetWayWnd(iter_7_1[2], ECommonAwardType.Item)

			return
		end

		var_7_1 = var_7_1 + 1
	end

	if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Gold, var_7_0.gold) == false then
		g_Bubble:bubbleInfo(a2u("\xBD\xF0\xDF\xF7\xB1Ҳ\xBB\xD7\xE3"))

		return
	end

	g_WsMsgHandler:WS_Hero_UpgradeQuality_Req(arg_7_0.hero.HeroBaseInfo.TemplateId)
end

function createHeroDetailJuexingPanel(arg_8_0)
	local var_8_0 = zbHeroDetailWnd_Juexing.extend(CCNodeExtend.extend(CCNode:create()))

	var_8_0:init(arg_8_0)

	return var_8_0
end
