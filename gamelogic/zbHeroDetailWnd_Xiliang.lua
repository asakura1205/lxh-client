zbHeroDetailWnd_Xiliang = class("zbHeroDetailWnd_Xiliang", CCNodeExtend)
zbHeroDetailWnd_Xiliang.__index = zbHeroDetailWnd_Xiliang

local var_0_0 = 3

function zbHeroDetailWnd_Xiliang.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbHeroDetailWnd_Xiliang)

	return arg_1_0
end

function createHeroDetailXiliangPanel(arg_2_0, arg_2_1)
	local var_2_0 = zbHeroDetailWnd_Xiliang.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0, arg_2_1)

	return var_2_0
end

function zbHeroDetailWnd_Xiliang.init(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0()
		arg_3_0.btnPriority = arg_3_2
		arg_3_0.btnXiulian = {}
		arg_3_0.selectTag = 1
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCLayer")

		arg_3_0.layer = var_5_0
		arg_3_0.layerXilian = tolua.cast(var_5_0:getChildByTag(1), "CCNode")
		arg_3_0.xilianLevelDummy = tolua.cast(arg_3_0.layerXilian:getChildByTag(1), "CCLabelTTF")
		arg_3_0.xilianLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.xilianLevelDummy, arg_3_0.xilianLevel)
		arg_3_0.xilianLevel:setScale(0.65)

		arg_3_0.xilianMax = tolua.cast(arg_3_0.layerXilian:getChildByTag(2), "CCLabelTTF")
		arg_3_0.xilianLimit = tolua.cast(arg_3_0.layerXilian:getChildByTag(4), "CCLabelTTF")
		arg_3_0.value1 = {}
		arg_3_0.value2 = {}
		arg_3_0.progress = {}

		for iter_5_0 = 1, 3 do
			local var_5_1 = tolua.cast(arg_3_0.layerXilian:getChildByTag(iter_5_0 + 4), "CCNode")
			local var_5_2 = tolua.cast(var_5_1:getChildByTag(1003), "CCLabelTTF")
			local var_5_3 = tolua.cast(var_5_1:getChildByTag(1004), "CCLabelTTF")
			local var_5_4 = tolua.cast(var_5_1:getChildByTag(5), "CCSprite")

			arg_3_0.value1[iter_5_0] = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

			require("gamebase.zbUI"):replaceCtrl(var_5_2, arg_3_0.value1[iter_5_0])
			arg_3_0.value1[iter_5_0]:setScale(0.55)

			arg_3_0.value2[iter_5_0] = CCLabelAtlas:create("", "font/rank_num_green.png", 26, 42, string.byte("+"))

			require("gamebase.zbUI"):replaceCtrl(var_5_3, arg_3_0.value2[iter_5_0])
			arg_3_0.value2[iter_5_0]:setScale(0.45)

			arg_3_0.progress[iter_5_0] = zbUtil:createProgressTimer(var_5_4, "image/herodetail/herodetail_progress.png")
		end

		arg_3_0.needMoney = {}

		for iter_5_1 = 1, 2 do
			local var_5_5 = tolua.cast(arg_3_0.layerXilian:getChildByTag(iter_5_1 + 7), "CCNode")
			local var_5_6 = tolua.cast(var_5_5:getChildByTag(4), "CCLabelTTF")

			arg_3_0.needMoney[iter_5_1] = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

			require("gamebase.zbUI"):replaceCtrl(var_5_6, arg_3_0.needMoney[iter_5_1])
			arg_3_0.needMoney[iter_5_1]:setScale(0.45)

			local var_5_7 = tolua.cast(var_5_5:getChildByTag(22), "CCControlButton")

			var_5_7:addHandleOfControlEvent(function()
				arg_3_0:onUpgrade(iter_5_1)
			end, CCControlEventTouchUpInside)

			arg_3_0.btnXiulian[iter_5_1] = var_5_7

			if iter_5_1 == 1 then
				local var_5_8 = tolua.cast(var_5_5:getChildByTag(3), "CCLayer")

				var_5_8:setVisible(false)

				arg_3_0.useXlItem = createItem()

				local var_5_9 = ccp(var_5_8:getPosition())

				arg_3_0.useXlItem:setPosition(var_5_8:getPosition())
				arg_3_0.useXlItem:setScale(0.4)
				arg_3_0.useXlItem:setNeedTip(true)
				var_5_5:addChild(arg_3_0.useXlItem)
			end
		end

		local var_5_10 = tolua.cast(arg_3_0.layerXilian:getChildByTag(20), "CCNode")
		local var_5_11 = tolua.cast(var_5_10:getChildByTag(3), "CCLayer")

		var_5_11:setVisible(false)

		arg_3_0.useXlMaxItem = createItem()

		local var_5_12 = ccp(var_5_11:getPosition())

		arg_3_0.useXlMaxItem:setPosition(var_5_11:getPosition())
		arg_3_0.useXlMaxItem:setScale(0.4)
		arg_3_0.useXlMaxItem:setNeedTip(true)
		var_5_10:addChild(arg_3_0.useXlMaxItem)

		local var_5_13 = tolua.cast(var_5_10:getChildByTag(4), "CCLabelTTF")

		arg_3_0.xlMaxNum = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_13, arg_3_0.xlMaxNum)
		arg_3_0.xlMaxNum:setScale(0.65)
		tolua.cast(var_5_10:getChildByTag(6), "CCControlButton"):addHandleOfControlEvent(function()
			arg_3_0:onSelect()
		end, CCControlEventTouchUpInside)

		local var_5_14 = tolua.cast(var_5_10:getChildByTag(5), "CCSprite")

		arg_3_0.spriteSelOk = tolua.cast(var_5_14:getChildByTag(1), "CCSprite")
		arg_3_0.layerTupo = tolua.cast(var_5_0:getChildByTag(2), "CCNode")
		arg_3_0.currLevelDummy = tolua.cast(arg_3_0.layerTupo:getChildByTag(1), "CCLabelTTF")
		arg_3_0.nextLevelDummy = tolua.cast(arg_3_0.layerTupo:getChildByTag(2), "CCLabelTTF")
		arg_3_0.lbCurrLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.currLevelDummy, arg_3_0.lbCurrLevel)
		arg_3_0.lbCurrLevel:setScale(0.7)

		arg_3_0.lbNextLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.nextLevelDummy, arg_3_0.lbNextLevel)
		arg_3_0.lbNextLevel:setScale(0.7)

		arg_3_0.attr1 = {}
		arg_3_0.attr2 = {}

		for iter_5_2 = 1, 3 do
			local var_5_15 = tolua.cast(arg_3_0.layerTupo:getChildByTag(iter_5_2 + 4), "CCNode")
			local var_5_16 = tolua.cast(var_5_15:getChildByTag(3), "CCLabelTTF")
			local var_5_17 = tolua.cast(var_5_15:getChildByTag(4), "CCLabelTTF")

			arg_3_0.attr1[iter_5_2] = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

			require("gamebase.zbUI"):replaceCtrl(var_5_16, arg_3_0.attr1[iter_5_2])
			arg_3_0.attr1[iter_5_2]:setScale(0.65)

			arg_3_0.attr2[iter_5_2] = CCLabelAtlas:create("", "font/rank_num_green.png", 26, 42, string.byte("+"))

			require("gamebase.zbUI"):replaceCtrl(var_5_17, arg_3_0.attr2[iter_5_2])
			arg_3_0.attr2[iter_5_2]:setScale(0.65)
		end

		local var_5_18 = tolua.cast(arg_3_0.layerTupo:getChildByTag(8), "CCNode")
		local var_5_19 = tolua.cast(var_5_18:getChildByTag(4), "CCLabelTTF")

		arg_3_0.needTupo = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_19, arg_3_0.needTupo)
		arg_3_0.needTupo:setScale(0.65)

		arg_3_0.nodeValue = var_5_18

		local var_5_20 = tolua.cast(var_5_18:getChildByTag(3), "CCLayer")

		var_5_20:setVisible(false)

		arg_3_0.useTpItem = createItem()

		local var_5_21 = ccp(var_5_20:getPosition())

		arg_3_0.useTpItem:setPosition(var_5_20:getPosition())
		arg_3_0.useTpItem:setScale(0.4)
		arg_3_0.useTpItem:setNeedTip(true)
		var_5_18:addChild(arg_3_0.useTpItem)

		arg_3_0.needLevel = tolua.cast(arg_3_0.layerTupo:getChildByTag(10), "CCLabelTTF")
		arg_3_0.haveNode = tolua.cast(arg_3_0.layerTupo:getChildByTag(20), "CCNode")

		local var_5_22 = tolua.cast(arg_3_0.haveNode:getChildByTag(4), "CCLabelTTF")

		arg_3_0.haveCount = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_22, arg_3_0.haveCount)
		arg_3_0.haveCount:setScale(0.65)

		local var_5_23 = tolua.cast(arg_3_0.haveNode:getChildByTag(3), "CCLayer")

		var_5_23:setVisible(false)

		arg_3_0.useTpMaxItem = createItem()

		local var_5_24 = ccp(var_5_23:getPosition())

		arg_3_0.useTpMaxItem:setPosition(var_5_23:getPosition())
		arg_3_0.useTpMaxItem:setScale(0.4)
		arg_3_0.useTpMaxItem:setNeedTip(true)
		arg_3_0.haveNode:addChild(arg_3_0.useTpMaxItem)

		arg_3_0.btnTupo = tolua.cast(var_5_18:getChildByTag(22), "CCControlButton")

		arg_3_0.btnTupo:addHandleOfControlEvent(function()
			arg_3_0:onTupo()
		end, CCControlEventTouchUpInside)
		var_5_0:setTouchPriority(arg_3_0.btnPriority:getTouchPriority())
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

local var_0_1 = {
	[EHeroType.Force] = EAttrType.Force,
	[EHeroType.Intelligence] = EAttrType.Intelligence,
	[EHeroType.Tili] = EAttrType.Tili
}

function zbHeroDetailWnd_Xiliang.refresh(arg_9_0, arg_9_1)
	arg_9_0.hero = arg_9_1

	local var_9_0 = zbHeroTable:getRecord(arg_9_1.HeroBaseInfo.TemplateId)

	if var_9_0 == nil then
		echoInfo("error hero template id: " .. arg_9_1.HeroBaseInfo.TemplateId)

		return
	end

	local var_9_1 = zbHeroMainAttrUpgradeTable:getRecord(var_9_0.mainAttrUpId, arg_9_1.WashInfo.Level)

	arg_9_0.mainAttrRecord = var_9_1

	local var_9_2 = true

	for iter_9_0, iter_9_1 in pairs(arg_9_1.WashInfo.MAttr) do
		if iter_9_1[1] == var_0_1[var_9_0.heroType] then
			if iter_9_1[3] < var_9_1.max * 2 then
				var_9_2 = false

				break
			end
		elseif iter_9_1[3] < var_9_1.max then
			var_9_2 = false

			break
		end
	end

	if var_9_2 == false then
		arg_9_0:refreshXilian(arg_9_1, var_9_0, var_9_1)
	else
		arg_9_0:refreshTupo(arg_9_1, var_9_0, var_9_1)
	end
end

function zbHeroDetailWnd_Xiliang.refreshXilian(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0.hero = arg_10_1

	arg_10_0.layerXilian:setVisible(true)
	arg_10_0.layerTupo:setVisible(false)
	arg_10_0.xilianLevel:setString(arg_10_1.WashInfo.Level)
	arg_10_0.xilianLimit:setString(a2u("(\xCA\xF4\xD0Ե\xE3\xD0\xDE\xC1\xB6\xC9\xCF\xCF\xDE:") .. arg_10_3.max .. ")")

	local var_10_0 = 1

	for iter_10_0, iter_10_1 in pairs(arg_10_1.WashInfo.MAttr) do
		arg_10_0.value2[iter_10_1[1]]:setString(iter_10_1[3] .. "/" .. arg_10_3.max)

		local var_10_1 = math.min(math.ceil(100 * (iter_10_1[3] / arg_10_3.max)), 99)

		if iter_10_1[1] == var_0_1[arg_10_2.heroType] then
			arg_10_0.value2[iter_10_1[1]]:setString(iter_10_1[3] .. "/" .. arg_10_3.max * 2)

			var_10_1 = math.min(math.ceil(100 * (iter_10_1[3] / (arg_10_3.max * 2))), 99)
		end

		arg_10_0.progress[iter_10_1[1]]:setPercentage(var_10_1)
	end

	force, intelligence, tili = g_Self.kHeroHandler:getHeroGrow(arg_10_1.HeroBaseInfo.TemplateId, arg_10_1.HeroBaseInfo.Level, arg_10_1.HeroBaseInfo.Star, arg_10_1.HeroBaseInfo.Quality)

	arg_10_0.value1[1]:setString(tonumber(string.format("%.1f", arg_10_2.forceBase + force)))
	arg_10_0.value1[2]:setString(tonumber(string.format("%.1f", arg_10_2.intelligenceBase + intelligence)))
	arg_10_0.value1[3]:setString(tonumber(string.format("%.1f", arg_10_2.tiliBase + tili)))
	arg_10_0.needMoney[1]:setString(arg_10_3.itemCost * arg_10_0.selectTag)
	arg_10_0.needMoney[2]:setString(arg_10_3.diamondCost * arg_10_0.selectTag)
	arg_10_0.spriteSelOk:setVisible(arg_10_0.selectTag == 10)

	local var_10_2 = zbItemTable:getHeroXilianItems()

	arg_10_0.useXlItem:refreshAward(ECommonAwardType.Item, var_10_2.id, 0, false, false)
	arg_10_0.useXlMaxItem:refreshAward(ECommonAwardType.Item, var_10_2.id, 0, false, false)

	local var_10_3 = g_Self.kBagItemHandler:getItemCount(EItemType.Material, EMaterialType.HeroXilian)

	arg_10_0.xlMaxNum:setString(var_10_3)
	arg_10_0.xilianMax:setString(a2u("(\xD7\xEE\xB8߿\xC9\xC9\xFD\xD6\xC1") .. zbHeroMainAttrUpgradeTable:getMaxlvlCurrLevel(arg_10_2.mainAttrUpId, arg_10_1.HeroBaseInfo.Level) .. a2u("\xBC\xB6)"))
end

function zbHeroDetailWnd_Xiliang.refreshTupo(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0.layerXilian:setVisible(false)
	arg_11_0.layerTupo:setVisible(true)

	local var_11_0 = arg_11_1.WashInfo.Level
	local var_11_1 = arg_11_1.WashInfo.Level + 1

	if var_11_1 > arg_11_2.tupo then
		var_11_1 = arg_11_2.tupo
	end

	arg_11_0.lbCurrLevel:setString(var_11_0)
	arg_11_0.lbNextLevel:setString(var_11_1)

	local var_11_2 = zbHeroMainAttrUpgradeTable:getRecord(arg_11_2.mainAttrUpId, var_11_1)

	for iter_11_0 = 1, 3 do
		arg_11_0.attr1[iter_11_0]:setString(arg_11_3.max)
		arg_11_0.attr2[iter_11_0]:setString(var_11_2.max)

		if iter_11_0 == var_0_1[arg_11_2.heroType] then
			arg_11_0.attr1[iter_11_0]:setString(arg_11_3.max * 2)
			arg_11_0.attr2[iter_11_0]:setString(var_11_2.max * 2)
		end
	end

	arg_11_0.needTupo:setString(arg_11_3.cost)

	if arg_11_1.HeroBaseInfo.Level < arg_11_3.unlockLvl then
		arg_11_0.haveNode:setVisible(false)
		arg_11_0.needLevel:setVisible(true)
		arg_11_0.needLevel:setString(a2u("\xD0\xE8Ҫ\xBB\xEF\xB0\xE9") .. arg_11_3.unlockLvl .. a2u("\xBC\xB6"))
		arg_11_0.nodeValue:setVisible(false)
	else
		arg_11_0.haveCount:setString(g_Self.kBagItemHandler:getItemCountByTemplateId(2040501))
		arg_11_0.haveNode:setVisible(true)
		arg_11_0.needLevel:setVisible(false)
		arg_11_0.nodeValue:setVisible(true)
	end

	local var_11_3 = zbItemTable:getHeroTupoItems()

	arg_11_0.useTpItem:refreshAward(ECommonAwardType.Item, var_11_3.id, 0, false, false)
	arg_11_0.useTpMaxItem:refreshAward(ECommonAwardType.Item, var_11_3.id, 0, false, false)

	local var_11_4 = g_Self.kBagItemHandler:getItemCount(EItemType.Material, EMaterialType.HeroTupo)

	arg_11_0.haveCount:setString(var_11_4)
end

function zbHeroDetailWnd_Xiliang.onUpgrade(arg_12_0, arg_12_1)
	if arg_12_0.selectTag == 10 and arg_12_1 == 2 then
		if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Diamond, arg_12_0.mainAttrRecord.diamondCost * arg_12_0.selectTag) == false then
			if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Diamond, arg_12_0.mainAttrRecord.diamondCost) then
				g_Bubble:bubbleInfo(a2u("\xD7\xEAʯ\xB2\xBB\xD7\xE3,ֻ\xC4ܵ\xA5\xB4\xCE\xD0\xDE\xC1\xB6\xA1\xA3"))
			else
				g_Bubble:bubbleInfo(a2u("\xD7\xEAʯ\xB2\xBB\xD7\xE3"))
			end

			arg_12_0:onSelect()

			return
		end

		local var_12_0 = a2u("\xCAǷ񻨷\xD1") .. arg_12_0.mainAttrRecord.diamondCost * arg_12_0.selectTag .. a2u("\xD7\xEAʯ\xBD\xF8\xD0\xD0ʮ\xB4\xCE\xD0\xDE\xC1\xB6\xA3\xA1")

		g_MessageBox:showYesNo(var_12_0, function()
			g_WsMsgHandler:WS_Hero_Xilian_Req(arg_12_0.hero.HeroBaseInfo.TemplateId, arg_12_1, arg_12_0.selectTag)
		end)
	elseif arg_12_0.selectTag == 10 and arg_12_1 == 1 then
		if arg_12_0.mainAttrRecord.itemCost * arg_12_0.selectTag > g_Self.kBagItemHandler:getItemCount(EItemType.Material, EMaterialType.HeroXilian) then
			if g_Self.kBagItemHandler:getItemCount(EItemType.Material, EMaterialType.HeroXilian) >= arg_12_0.mainAttrRecord.itemCost then
				g_Bubble:bubbleInfo(a2u("\xB8\xA2\xC1鵤\xB2\xBB\xD7㣬ֻ\xC4ܵ\xA5\xB4\xCE\xD0\xDE\xC1\xB6\xA1\xA3"))
			else
				local var_12_1 = zbItemTable:getHeroXilianItems()

				g_MainScene:showGetWayWnd(var_12_1.id, ECommonAwardType.Item)
			end

			arg_12_0:onSelect()

			return
		end

		g_WsMsgHandler:WS_Hero_Xilian_Req(arg_12_0.hero.HeroBaseInfo.TemplateId, arg_12_1, arg_12_0.selectTag)
	else
		if g_Self.kBagItemHandler:getItemCount(EItemType.Material, EMaterialType.HeroXilian) < arg_12_0.selectTag and arg_12_1 == 1 then
			local var_12_2 = zbItemTable:getHeroXilianItems()

			g_MainScene:showGetWayWnd(var_12_2.id, ECommonAwardType.Item)

			return
		elseif g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Diamond, arg_12_0.mainAttrRecord.diamondCost) == false and arg_12_1 == 2 then
			g_Bubble:bubbleInfo(a2u("\xD7\xEAʯ\xB2\xBB\xD7\xE3"))

			return
		end

		g_WsMsgHandler:WS_Hero_Xilian_Req(arg_12_0.hero.HeroBaseInfo.TemplateId, arg_12_1, arg_12_0.selectTag)
	end
end

function zbHeroDetailWnd_Xiliang.onTupo(arg_14_0)
	if arg_14_0.hero.HeroBaseInfo.Level < arg_14_0.mainAttrRecord.unlockLvl then
		g_Bubble:bubbleInfo(a2u("\xBB\xEF\xB0\xE9\xB5ȼ\xB6\xB2\xBB\xD7\xE3"))

		return
	end

	if g_Self.kBagItemHandler:getItemCount(EItemType.Material, EMaterialType.HeroTupo) < arg_14_0.mainAttrRecord.cost then
		local var_14_0 = zbItemTable:getHeroTupoItems()

		g_MainScene:showGetWayWnd(var_14_0.id, ECommonAwardType.Item)

		return
	end

	g_WsMsgHandler:WS_Hero_Tupo_Req(arg_14_0.hero.HeroBaseInfo.TemplateId)
end

function zbHeroDetailWnd_Xiliang.onSelect(arg_15_0)
	arg_15_0.selectTag = 11 - arg_15_0.selectTag

	arg_15_0.spriteSelOk:setVisible(arg_15_0.selectTag == 10)

	if arg_15_0.selectTag == 10 then
		arg_15_0.needMoney[1]:setString(arg_15_0.mainAttrRecord.itemCost * 10)
		arg_15_0.needMoney[2]:setString(arg_15_0.mainAttrRecord.diamondCost * 10)
	else
		arg_15_0.needMoney[1]:setString(arg_15_0.mainAttrRecord.itemCost)
		arg_15_0.needMoney[2]:setString(arg_15_0.mainAttrRecord.diamondCost)
	end
end
