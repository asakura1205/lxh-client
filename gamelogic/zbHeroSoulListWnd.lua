require("gamelogic.zbTabWnd")

zbHeroSoulListWnd = class("zbHeroSoulListWnd", zbTabWnd)
zbHeroSoulListWnd.__index = zbHeroSoulListWnd

local var_0_0 = "image/common/effect_upgrade_suc.png"

function zbHeroSoulListWnd.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbHeroSoulListWnd)

	return arg_1_0
end

function zbHeroSoulListWnd.create(arg_2_0)
	local var_2_0 = zbHeroSoulListWnd.extend(zbTabWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNodeRGBA:create()))))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function zbHeroSoulListWnd.init(arg_3_0)
	local function var_3_0()
		arg_3_0.refreshTag = true
		arg_3_0.lbMiaoshu = {}
		arg_3_0.spriteNode = {}
		arg_3_0.nodeBtn = {}
		arg_3_0.btnChange = {}
		arg_3_0.spriteUse = {}
		arg_3_0.btnBuy = {}
		arg_3_0.spriteMoney = {}
		arg_3_0.lbMoney = {}
		arg_3_0.spriteDengjie = {}
		arg_3_0.spriteJibie = {}
		arg_3_0.lbLevelLimit = {}
		arg_3_0.myIndex = 1
		arg_3_0.notifyBtn = {}
		arg_3_0.spriteframeCache = CCSpriteFrameCache:sharedSpriteFrameCache()

		arg_3_0.spriteframeCache:addSpriteFramesWithFile("ui/image/plist/herosoul.plist")
	end

	local function var_3_1(arg_5_0)
		local var_5_0 = CCSprite:create(NOTIFY_TAG_PATH)

		var_5_0:setPosition(ccp(140, 70))
		var_5_0:setVisible(false)
		arg_5_0:addChild(var_5_0)
		zbUIEffect:createNotifyTagScaleAction(var_5_0)

		return var_5_0
	end

	local function var_3_2()
		local var_6_0 = CCBProxy:create()
		local var_6_1 = CCBReaderLoad("ccbi/heroSoulList.ccbi", var_6_0, true, "HelloCocosBuilderLayerOwner")
		local var_6_2 = tolua.cast(var_6_1:getChildByTag(2), "CCNode")
		local var_6_3 = {}

		var_6_3[1] = "image/tab/tab_herosoul_1.png"
		var_6_3[2] = "image/tab/tab_herosoul_2.png"
		var_6_3[3] = "image/tab/tab_herosoul_3.png"
		var_6_3[4] = "image/tab/tab_herosoul_4.png"
		var_6_3[5] = "image/tab/tab_herosoul_5.png"

		local var_6_4 = {}

		for iter_6_0 = 1, 5 do
			var_6_4[iter_6_0] = tolua.cast(var_6_2:getChildByTag(iter_6_0), "CCControlButton")
			arg_3_0.lbLevelLimit[iter_6_0] = tolua.cast(var_6_2:getChildByTag(iter_6_0 + 10), "CCLabelTTF")
			arg_3_0.notifyBtn[iter_6_0] = var_3_1(var_6_4[iter_6_0])
		end

		local var_6_5 = {
			tolua.cast(var_6_1:getChildByTag(1), "CCLayer"),
			tolua.cast(var_6_1:getChildByTag(1), "CCLayer"),
			tolua.cast(var_6_1:getChildByTag(1), "CCLayer"),
			tolua.cast(var_6_1:getChildByTag(1), "CCLayer"),
			(tolua.cast(var_6_1:getChildByTag(1), "CCLayer"))
		}

		arg_3_0:initTab(var_6_4, var_6_5, var_6_3, function(arg_7_0)
			return arg_3_0:switchTabCheck(arg_7_0)
		end)

		arg_3_0.layerDetail = tolua.cast(var_6_1:getChildByTag(1), "CCLayer")
		arg_3_0.spriteAvatar = tolua.cast(arg_3_0.layerDetail:getChildByTag(0), "CCSprite")
		arg_3_0.spriteMidTitle = tolua.cast(arg_3_0.layerDetail:getChildByTag(102), "CCSprite")
		arg_3_0.lbHeroName = tolua.cast(arg_3_0.spriteMidTitle:getChildByTag(3), "CCLabelTTF")

		for iter_6_1 = 1, 3 do
			arg_3_0.spriteNode[iter_6_1] = tolua.cast(arg_3_0.layerDetail:getChildByTag(iter_6_1), "CCSprite")
			arg_3_0.spriteDengjie[iter_6_1] = tolua.cast(arg_3_0.spriteNode[iter_6_1]:getChildByTag(2), "CCSprite")
			arg_3_0.spriteJibie[iter_6_1] = tolua.cast(arg_3_0.spriteNode[iter_6_1]:getChildByTag(1), "CCSprite")
			arg_3_0.lbMiaoshu[iter_6_1] = tolua.cast(arg_3_0.spriteNode[iter_6_1]:getChildByTag(3), "CCLabelTTF")

			local var_6_6 = tolua.cast(arg_3_0.spriteNode[iter_6_1]:getChildByTag(4), "CCNode")

			arg_3_0.btnBuy[iter_6_1] = tolua.cast(var_6_6:getChildByTag(1), "CCControlButton")
			arg_3_0.spriteMoney[iter_6_1] = tolua.cast(var_6_6:getChildByTag(2), "CCSprite")

			local var_6_7 = tolua.cast(var_6_6:getChildByTag(1001), "CCLabelTTF")

			arg_3_0.lbMoney[iter_6_1] = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

			require("gamebase.zbUI"):replaceCtrl(var_6_7, arg_3_0.lbMoney[iter_6_1])
			arg_3_0.lbMoney[iter_6_1]:setScale(0.55)

			arg_3_0.nodeBtn[iter_6_1] = var_6_6
			arg_3_0.btnChange[iter_6_1] = tolua.cast(arg_3_0.spriteNode[iter_6_1]:getChildByTag(6), "CCControlButton")
			arg_3_0.spriteUse[iter_6_1] = tolua.cast(arg_3_0.spriteNode[iter_6_1]:getChildByTag(5), "CCSprite")

			arg_3_0.btnChange[iter_6_1]:addHandleOfControlEvent(function()
				arg_3_0:onChange(iter_6_1)
			end, CCControlEventTouchUpInside)
			arg_3_0.btnBuy[iter_6_1]:addHandleOfControlEvent(function()
				arg_3_0:onBuy(iter_6_1)
			end, CCControlEventTouchUpInside)
		end

		arg_3_0:addChild(var_6_1)
		arg_3_0:createMoneyPanel(var_6_1, {
			EMoneyPanelResType.Gold,
			EMoneyPanelResType.Diamond
		}, function()
			arg_3_0:hide()
		end)
	end

	var_3_0()
	var_3_2()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refreshDetail()
	end, zbGameEvent.Event_HeroSoulHall_Ack)
end

function zbHeroSoulListWnd.doShow(arg_12_0)
	return
end

function zbHeroSoulListWnd.doHide(arg_13_0)
	return
end

function zbHeroSoulListWnd.switchTabCheck(arg_14_0, arg_14_1)
	local var_14_0 = zbHeroSoulTable:getRecord(arg_14_1)

	if var_14_0[1] == nil then
		return false
	end

	if var_14_0[1].openLevel > g_Self:getLevel() then
		g_Bubble:bubbleInfo(a2u("\xB5ȼ\xB6\xB2\xBB\xD7\xE3"))

		return false
	end

	return true
end

local var_0_1 = {}

var_0_1[1] = "\xCE﹥"
var_0_1[2] = "\xCE\xEF\xB7\xC0"
var_0_1[3] = "\xB7\xA8\xB9\xA5"
var_0_1[4] = "\xB7\xA8\xB7\xC0"
var_0_1[5] = "Ѫ\xC1\xBF"

function zbHeroSoulListWnd.doSelectTab(arg_15_0)
	arg_15_0.heroSoulRecord = zbHeroSoulTable:getRecord(arg_15_0.currTab)

	for iter_15_0, iter_15_1 in pairs(arg_15_0.heroSoulRecord) do
		if arg_15_0.lbMiaoshu[iter_15_1.grade] ~= nil then
			arg_15_0.lbMiaoshu[iter_15_1.grade]:setString(a2u(var_0_1[arg_15_0.myIndex]) .. " +" .. zbHeroSoulTable:getAddition(iter_15_1, arg_15_0.myIndex))
			arg_15_0.lbMoney[iter_15_1.grade]:setString(iter_15_1.price.awardNum)

			local var_15_0 = zbIconHelper:getMoneyPanelIconPath(iter_15_1.price.awardType)

			arg_15_0.spriteMoney[iter_15_1.grade]:setTexture(CCTextureCache:sharedTextureCache():addImage(var_15_0))

			local var_15_1 = arg_15_0.spriteframeCache:spriteFrameByName("herosoul_dengjie0" .. iter_15_1.quality .. ".png")

			if var_15_1 then
				arg_15_0.spriteDengjie[iter_15_1.grade]:initWithSpriteFrame(var_15_1)
			end

			arg_15_0.spriteNode[iter_15_1.grade]:setTexture(CCTextureCache:sharedTextureCache():addImage("ui/image/herosoulhall/herosoul_unselect.png"))
			arg_15_0.spriteNode[iter_15_1.grade]:setContentSize(CCSizeMake(554, 84))
			arg_15_0.spriteNode[iter_15_1.grade]:setPositionX(1136)
			arg_15_0.btnChange[iter_15_1.grade]:setVisible(false)
			arg_15_0.nodeBtn[iter_15_1.grade]:setVisible(true)
			arg_15_0.spriteUse[iter_15_1.grade]:setVisible(false)

			if arg_15_0.soulList ~= nil then
				local var_15_2

				for iter_15_2, iter_15_3 in pairs(arg_15_0.soulList.SoulList) do
					if iter_15_1.id == iter_15_3.HeroSoulId then
						if iter_15_3.Status == 1 then
							arg_15_0.btnChange[iter_15_1.grade]:setVisible(false)
							arg_15_0.nodeBtn[iter_15_1.grade]:setVisible(false)
							arg_15_0.spriteUse[iter_15_1.grade]:setVisible(true)
							arg_15_0.spriteNode[iter_15_1.grade]:setTexture(CCTextureCache:sharedTextureCache():addImage("ui/image/herosoulhall/herosoul_select.png"))
							arg_15_0.spriteNode[iter_15_1.grade]:setContentSize(CCSizeMake(608, 84))
						else
							arg_15_0.btnChange[iter_15_1.grade]:setVisible(true)
							arg_15_0.nodeBtn[iter_15_1.grade]:setVisible(false)
							arg_15_0.spriteUse[iter_15_1.grade]:setVisible(false)
						end
					end
				end
			end
		end
	end
end

function zbHeroSoulListWnd.refresh(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0.hallRecord = arg_16_1
	arg_16_0.myIndex = arg_16_2

	for iter_16_0 = 1, 5 do
		local var_16_0 = zbHeroSoulTable:getRecord(iter_16_0)

		if var_16_0[1] ~= nil then
			if var_16_0[1].openLevel > g_Self:getLevel() then
				arg_16_0.lbLevelLimit[iter_16_0]:setString("(" .. var_16_0[1].openLevel .. a2u("\xBC\xB6\xBF\xAA\xB7\xC5)"))
				arg_16_0.lbLevelLimit[iter_16_0]:setVisible(true)
			else
				arg_16_0.lbLevelLimit[iter_16_0]:setVisible(false)
			end
		end
	end

	arg_16_0:refreshDetail()
end

function zbHeroSoulListWnd.refreshDetail(arg_17_0)
	arg_17_0.soulList = nil
	arg_17_0.hallData = nil

	if g_GameData.HeroSoulHallInfo ~= nil and type(g_GameData.HeroSoulHallInfo) == "table" then
		for iter_17_0, iter_17_1 in pairs(g_GameData.HeroSoulHallInfo.HeroSoulHallList) do
			if arg_17_0.hallRecord.id == iter_17_1.HallId then
				arg_17_0.hallData = iter_17_1
			end
		end

		if arg_17_0.hallData ~= nil and type(arg_17_0.hallData) == "table" then
			for iter_17_2, iter_17_3 in pairs(arg_17_0.hallData.HeroSoulList) do
				if arg_17_0.myIndex == iter_17_3.Position then
					arg_17_0.soulList = iter_17_3

					break
				end
			end
		end
	end

	local var_17_0 = zbHeroSoulHallTable:getHeroID(arg_17_0.hallRecord.id, arg_17_0.myIndex)
	local var_17_1 = zbHeroTable:getRecord(var_17_0)

	if var_17_1 ~= nil then
		arg_17_0.lbHeroName:setString(var_17_1.name)
	end

	arg_17_0.heroid = var_17_0

	local var_17_2 = zbIconHelper:getHeroCardIconPath(var_17_0)

	arg_17_0.spriteAvatar:setTexture(CCTextureCache:sharedTextureCache():addImage(var_17_2))

	for iter_17_4 = 1, 3 do
		arg_17_0.btnBuy[iter_17_4]:setGray(true)
	end

	if g_Self.kHeroHandler:hasHeroByTemplateId(arg_17_0.heroid) == true then
		for iter_17_5 = 1, 3 do
			arg_17_0.btnBuy[iter_17_5]:setGray(false)
		end
	end

	arg_17_0:doSelectTab()
	arg_17_0:refreshNotify()
end

function zbHeroSoulListWnd.onBuy(arg_18_0, arg_18_1)
	if g_Self.kHeroHandler:hasHeroByTemplateId(arg_18_0.heroid) == false then
		g_Bubble:bubbleInfo(a2u("\xD0\xE8Ҫӵ\xD3иû\xEF\xB0\xE9"))

		return
	end

	for iter_18_0, iter_18_1 in pairs(arg_18_0.heroSoulRecord) do
		if iter_18_1.grade == arg_18_1 then
			if g_Self.kWealthHandler:hasEnoughMoney(iter_18_1.price.awardType, iter_18_1.price.awardNum) == false then
				g_Bubble:bubbleInfo(a2u("\xD7\xCAԴ\xB2\xBB\xD7\xE3"))

				return
			end

			g_WsMsgHandler:WS_HeroSoul_Buy_Req(arg_18_0.hallRecord.id, arg_18_0.myIndex, iter_18_1.id)
		end
	end
end

function zbHeroSoulListWnd.onChange(arg_19_0, arg_19_1)
	local var_19_0

	for iter_19_0, iter_19_1 in pairs(arg_19_0.soulList.SoulList) do
		if iter_19_1.Status == 1 then
			var_19_0 = iter_19_1

			break
		end
	end

	for iter_19_2, iter_19_3 in pairs(arg_19_0.heroSoulRecord) do
		if iter_19_3.grade == arg_19_1 then
			g_WsMsgHandler:WS_HeroSoul_Exchange_Req(arg_19_0.hallRecord.id, arg_19_0.myIndex, var_19_0.HeroSoulId, iter_19_3.id)
		end
	end
end

function zbHeroSoulListWnd.refreshNotify(arg_20_0)
	for iter_20_0 = 1, 5 do
		arg_20_0.notifyBtn[iter_20_0]:setVisible(g_Self.kHeroSoulHallHandler:hasHeroSoul(arg_20_0.hallRecord.id, arg_20_0.myIndex, iter_20_0))
	end
end
