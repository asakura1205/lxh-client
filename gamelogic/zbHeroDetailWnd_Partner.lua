require("gamelogic.zbItem")

local var_0_0 = 120

zbHeroDetailWnd_Partner = class("zbHeroDetailWnd_Partner", CCNodeExtend)
zbHeroDetailWnd_Partner.__index = zbHeroDetailWnd_Partner

function zbHeroDetailWnd_Partner.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbHeroDetailWnd_Partner)

	return arg_1_0
end

function zbHeroDetailWnd_Partner.init(arg_2_0, arg_2_1, arg_2_2)
	local function var_2_0()
		arg_2_0.layerContent = {}
		arg_2_0.spriteBg = {}
		arg_2_0.lbAttrAdd = {}
		arg_2_0.lbDesc = {}
		arg_2_0.spriteFight = {}
		arg_2_0.lbFight = {}
		arg_2_0.lbPartName = {}
		arg_2_0.btnTouch = {}
		arg_2_0.layerHead = {}
		arg_2_0.spriteLock = {}
		arg_2_0.lbLock = {}
		arg_2_0.btnUnLoad = {}
		arg_2_0.redPoint = {}
	end

	local function var_2_1()
		local function var_4_0(arg_5_0)
			local var_5_0 = CCSprite:create(NOTIFY_TAG_PATH)

			var_5_0:setPosition(120, 120)
			var_5_0:setVisible(true)

			if arg_5_0:getChildByTag(500) == nil then
				arg_5_0:addChild(var_5_0, 1000000, 500)
			end

			zbUIEffect:createNotifyTagScaleAction(var_5_0)

			return var_5_0
		end

		local var_4_1 = tolua.cast(arg_2_1:getChildByTag(1), "CCNode")

		arg_2_0.layer = var_4_1

		for iter_4_0 = 1, 3 do
			arg_2_0.layerContent[iter_4_0] = tolua.cast(var_4_1:getChildByTag(iter_4_0), "CCLayerColor")
			arg_2_0.spriteBg[iter_4_0] = tolua.cast(arg_2_0.layerContent[iter_4_0]:getChildByTag(1), "CCSprite")
			arg_2_0.btnTouch[iter_4_0] = tolua.cast(arg_2_0.layerContent[iter_4_0]:getChildByTag(2), "CCControlButton")
			arg_2_0.lbAttrAdd[iter_4_0] = tolua.cast(arg_2_0.layerContent[iter_4_0]:getChildByTag(4), "CCLabelTTF")
			arg_2_0.lbDesc[iter_4_0] = tolua.cast(arg_2_0.layerContent[iter_4_0]:getChildByTag(1005), "CCLabelTTF")
			arg_2_0.spriteFight[iter_4_0] = tolua.cast(arg_2_0.layerContent[iter_4_0]:getChildByTag(6), "CCSprite")

			local var_4_2 = tolua.cast(arg_2_0.spriteFight[iter_4_0]:getChildByTag(1), "CCLabelTTF")

			arg_2_0.lbPartName[iter_4_0] = tolua.cast(arg_2_0.layerContent[iter_4_0]:getChildByTag(8), "CCLabelTTF")
			arg_2_0.spriteLock[iter_4_0] = tolua.cast(arg_2_0.layerContent[iter_4_0]:getChildByTag(10), "CCSprite")
			arg_2_0.lbLock[iter_4_0] = tolua.cast(arg_2_0.layerContent[iter_4_0]:getChildByTag(11), "CCLabelTTF")
			arg_2_0.btnUnLoad[iter_4_0] = tolua.cast(arg_2_0.layerContent[iter_4_0]:getChildByTag(12), "CCControlButton")
			arg_2_0.lbFight[iter_4_0] = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

			require("gamebase.zbUI"):replaceCtrl(var_4_2, arg_2_0.lbFight[iter_4_0])
			arg_2_0.lbFight[iter_4_0]:setScale(0.55)

			local var_4_3 = tolua.cast(arg_2_0.layerContent[iter_4_0]:getChildByTag(3), "CCLayerColor")
			local var_4_4 = createItem()

			var_4_4:setPosition(var_4_3:getPosition())
			arg_2_0.layerContent[iter_4_0]:addChild(var_4_4)
			var_4_3:removeFromParentAndCleanup(true)

			arg_2_0.layerHead[iter_4_0] = var_4_4

			arg_2_0.btnTouch[iter_4_0]:addHandleOfControlEvent(function()
				arg_2_0:onTouch(iter_4_0)
			end, CCControlEventTouchUpInside)
			arg_2_0.btnUnLoad[iter_4_0]:addHandleOfControlEvent(function()
				arg_2_0:onUnLoad(iter_4_0)
			end, CCControlEventTouchUpInside)

			arg_2_0.redPoint[iter_4_0] = var_4_0(arg_2_0.layerContent[iter_4_0])
		end

		arg_2_1:setZOrder(ZORDER_TOP)
		arg_2_0:addChild(arg_2_1)
	end

	var_2_0()
	var_2_1()
end

local var_0_1 = {}

var_0_1[1] = "\xC1\xA6\xC1\xBF"
var_0_1[2] = "\xD6\xC7\xC1\xA6"
var_0_1[3] = "\xCC\xE5\xC1\xA6"

function zbHeroDetailWnd_Partner.refresh(arg_8_0, arg_8_1)
	arg_8_0.hero = arg_8_1

	for iter_8_0 = 1, 3 do
		arg_8_0.layerContent[iter_8_0]:setVisible(true)
		arg_8_0.redPoint[iter_8_0]:setVisible(g_Self.kHeroHandler:getHeroCanParner(arg_8_1, iter_8_0))
	end

	local var_8_0 = zbHeroServantTable:getRecord(arg_8_1.HeroBaseInfo.TemplateId)

	if var_8_0 == nil then
		echoInfo("error hero template id: " .. arg_8_1.HeroBaseInfo.TemplateId)

		for iter_8_1 = 1, 3 do
			arg_8_0.layerContent[iter_8_1]:setVisible(false)
		end

		return
	end

	for iter_8_2 = 1, 3 do
		arg_8_0.lbDesc[iter_8_2]:setString(a2u("\xCCṩ\xD7\xD4\xC9\xEDս\xB6\xB7\xC1\xA6\xB5\xC4") .. var_8_0.percent[iter_8_2] * 100 .. "%(" .. var_8_0.specialPercent[iter_8_2] * 100 .. a2u("%)\xD7\xF7Ϊ" .. var_0_1[var_8_0.attrType[iter_8_2]]) .. a2u("\xBCӳ\xC9"))

		local var_8_1 = zbHeroTable:getRecord(var_8_0.heroId[iter_8_2])

		if var_8_1 ~= nil then
			arg_8_0.lbPartName[iter_8_2]:setString(var_8_1.name)
		end

		arg_8_0.lbAttrAdd[iter_8_2]:setString(a2u(var_0_1[var_8_0.attrType[iter_8_2]]) .. " +" .. 0)
		arg_8_0.layerHead[iter_8_2]:setVisible(false)
		arg_8_0.btnTouch[iter_8_2]:setVisible(false)
		arg_8_0.spriteFight[iter_8_2]:setVisible(false)
		arg_8_0.spriteLock[iter_8_2]:setVisible(false)
		arg_8_0.lbLock[iter_8_2]:setVisible(false)
		arg_8_0.btnUnLoad[iter_8_2]:setVisible(false)
		arg_8_0.spriteBg[iter_8_2]:setGray(false)
	end

	if arg_8_1.PartnerInfo.MasterTid > 0 then
		local var_8_2 = zbHeroTable:getRecord(arg_8_1.PartnerInfo.MasterTid)

		for iter_8_3 = 1, 3 do
			arg_8_0.spriteBg[iter_8_3]:setGray(true)
			arg_8_0.spriteLock[iter_8_3]:setVisible(true)
			arg_8_0.lbLock[iter_8_3]:setVisible(true)
			arg_8_0.lbLock[iter_8_3]:setString(a2u("\xD2Ѿ\xAD\xCA\xC7") .. var_8_2.name .. a2u("\xB5\xC4\xCB\xE6\xB4ӣ\xAC\xB2\xBB\xC4\xDC\xD4\xD9Я\xB4\xF8\xCB\xE6\xB4\xD3"))
		end

		return
	end

	for iter_8_4 = 1, 3 do
		if arg_8_1.PartnerInfo.PartnerList[iter_8_4] > 0 then
			arg_8_0.btnUnLoad[iter_8_4]:setVisible(true)
			arg_8_0.spriteFight[iter_8_4]:setVisible(true)
			arg_8_0.layerHead[iter_8_4]:setVisible(true)

			local var_8_3 = g_Self.kHeroHandler:getHeroByTemplateId(arg_8_1.PartnerInfo.PartnerList[iter_8_4])

			arg_8_0.layerHead[iter_8_4]:refreshHero(var_8_3.HeroBaseInfo)
			arg_8_0.lbFight[iter_8_4]:setString(var_8_3.HeroBaseInfo.FV)

			if arg_8_1.PartnerInfo.PartnerList[iter_8_4] == var_8_0.heroId[iter_8_4] then
				arg_8_0.lbDesc[iter_8_4]:setString(a2u("\xCCṩ\xD7\xD4\xC9\xEDս\xB6\xB7\xC1\xA6\xB5\xC4") .. "(" .. var_8_0.specialPercent[iter_8_4] * 100 .. a2u("%)\xD7\xF7Ϊ" .. var_0_1[var_8_0.attrType[iter_8_4]]) .. a2u("\xBCӳ\xC9"))
				arg_8_0.lbPartName[iter_8_4]:setString(a2u("\xD2Ѽ\xA4\xBB\xEE"))
				arg_8_0.lbAttrAdd[iter_8_4]:setString(a2u(var_0_1[var_8_0.attrType[iter_8_4]]) .. " +" .. var_8_3.HeroBaseInfo.FV * var_8_0.specialPercent[iter_8_4])
			else
				arg_8_0.lbDesc[iter_8_4]:setString(a2u("\xCCṩ\xD7\xD4\xC9\xEDս\xB6\xB7\xC1\xA6\xB5\xC4") .. var_8_0.percent[iter_8_4] * 100 .. "%" .. a2u("\xD7\xF7Ϊ" .. var_0_1[var_8_0.attrType[iter_8_4]]) .. a2u("\xBCӳ\xC9"))
				arg_8_0.lbAttrAdd[iter_8_4]:setString(a2u(var_0_1[var_8_0.attrType[iter_8_4]]) .. " +" .. var_8_3.HeroBaseInfo.FV * var_8_0.percent[iter_8_4])
			end
		elseif arg_8_1.HeroBaseInfo.Level >= var_8_0.attrLevel[iter_8_4] then
			arg_8_0.btnTouch[iter_8_4]:setVisible(true)
		else
			arg_8_0.spriteBg[iter_8_4]:setGray(true)
			arg_8_0.spriteLock[iter_8_4]:setVisible(true)
			arg_8_0.lbLock[iter_8_4]:setVisible(true)
			arg_8_0.lbLock[iter_8_4]:setString(var_8_0.attrLevel[iter_8_4] .. a2u("\xBC\xB6\xBD\xE2\xCB\xF8\xB8\xC3\xC0\xB8λ"))
		end
	end
end

function zbHeroDetailWnd_Partner.onTouch(arg_9_0, arg_9_1)
	if arg_9_0.hero.PartnerInfo.MasterTid == 0 then
		g_MainScene:showHeroSelectWnd():refreshPartner(arg_9_1, arg_9_0.hero.HeroBaseInfo.TemplateId, arg_9_0.hero.PartnerInfo.PartnerList)
	else
		g_Bubble:bubbleInfo(a2u("\xD2Ѿ\xAD\xCA\xC7\xC6\xE4\xCB\xFB\xBB\xEF\xB0\xE9\xB5\xC4\xCB\xE6\xB4\xD3"))
	end
end

function zbHeroDetailWnd_Partner.onUnLoad(arg_10_0, arg_10_1)
	g_WsMsgHandler:WS_Hero_PutDownPartner_Req(arg_10_1, arg_10_0.hero.HeroBaseInfo.TemplateId)
end

function createHeroPartnerDetailPanel(arg_11_0, arg_11_1)
	local var_11_0 = zbHeroDetailWnd_Partner.extend(CCNodeExtend.extend(CCNode:create()))

	var_11_0:init(arg_11_0, arg_11_1)

	return var_11_0
end
