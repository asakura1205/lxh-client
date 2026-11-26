require("gamelogic.zbBaseWnd")
require("gamelogic.zbHeroEquipSlot")
require("gamelogic.zbHeroDetailWnd_Avatar")
require("gamelogic.zbHeroDetailWnd_Detail")
require("gamelogic.zbHeroDetailWnd_Skill")
require("gamelogic.zbHeroDetailWnd_Xiliang")
require("gamelogic.zbHeroDetailWnd_Base")
require("gamelogic.zbHeroEquipSlotTips")
require("gamelogic.zbHeroDetailWnd_Starup")
require("gamelogic.zbHeroDetailWnd_Fate")
require("gamelogic.zbHeroDetailWnd_Juexing")
require("gamelogic.zbHeroDetailWnd_Partner")

zbHeroDetailWnd = class("zbHeroDetailWnd", zbBaseWnd)
zbHeroDetailWnd.__index = zbHeroDetailWnd

function zbHeroDetailWnd.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbHeroDetailWnd)

	return arg_1_0
end

function createHeroDetailWnd()
	local var_2_0 = zbHeroDetailWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function zbHeroDetailWnd.init(arg_3_0)
	local function var_3_0()
		arg_3_0.currTab = 1
		arg_3_0.hero = nil
		arg_3_0.curIndex = 1
		arg_3_0.refreshXilianFlag = {}
		arg_3_0.first = {}
		arg_3_0.first[EHeroDetailTab.Detail] = false
		arg_3_0.first[EHeroDetailTab.Skill] = false
		arg_3_0.first[EHeroDetailTab.XiLian] = false
		arg_3_0.first[EHeroDetailTab.StarUp] = false
		arg_3_0.first[EHeroDetailTab.Phase] = false
		arg_3_0.first[EHeroDetailTab.Fate] = false
		arg_3_0.first[EHeroDetailTab.Partner] = false
		arg_3_0.tabSprites = {}
	end

	local function var_3_1()
		local function var_5_0(arg_6_0)
			local var_6_0 = CCSprite:create(NOTIFY_TAG_PATH)

			var_6_0:setPosition(120, 60)
			var_6_0:setVisible(true)

			if arg_6_0:getChildByTag(500) == nil then
				arg_6_0:addChild(var_6_0, 1000000, 500)
			end

			zbUIEffect:createNotifyTagScaleAction(var_6_0)

			return var_6_0
		end

		local function var_5_1(arg_7_0)
			local var_7_0 = CCSprite:create("image/hero/hero_new.png")

			var_7_0:setAnchorPoint(ccp(0.5, 0.5))
			var_7_0:setPosition(arg_7_0:getContentSize().width - 20, arg_7_0:getContentSize().height / 2 + 20)
			arg_7_0:addChild(var_7_0)
			zbUIEffect:createNotifyTagScaleAction(var_7_0)

			return var_7_0
		end

		local var_5_2 = getPreloadCCNode("ccbi/heroDetail.ccbi")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCNode")
		local var_5_4 = tolua.cast(var_5_2:getChildByTag(2), "CCNode")

		arg_3_0.node = var_5_2
		arg_3_0.layer = var_5_3
		arg_3_0.layerAvatar = createHeroDetailAvatarPanel(tolua.cast(var_5_3:getChildByTag(1), "CCNode"), arg_3_0)
		arg_3_0.layerBase = createHeroDetailBasePanel(tolua.cast(var_5_3:getChildByTag(2), "CCNode"), arg_3_0)
		arg_3_0.layerAdd = tolua.cast(var_5_3:getChildByTag(10), "CCNode")
		arg_3_0.layerSkill = tolua.cast(var_5_3:getChildByTag(11), "CCNode")
		arg_3_0.layerTips = createHeroEquipSlotTipsPanel(tolua.cast(var_5_2:getChildByTag(99), "CCNode"))

		local var_5_5 = {
			[EHeroDetailTab.Detail] = "image/tab/tab_herodetail_detail.png",
			[EHeroDetailTab.Skill] = "image/tab/tab_herodetail_skill.png",
			[EHeroDetailTab.XiLian] = "image/tab/tab_herodetail_xiLian.png",
			[EHeroDetailTab.StarUp] = "image/tab/tab_herodetail_starUp.png",
			[EHeroDetailTab.Phase] = "image/tab/tab_herodetail_phase.png",
			[EHeroDetailTab.Fate] = "image/tab/tab_herodetail_fate.png",
			[EHeroDetailTab.Partner] = "image/tab/tab_herodetail_partner.png"
		}

		arg_3_0.tabImagePaths = var_5_5

		local var_5_6 = {}

		for iter_5_0 = 1, EHeroDetailTab.Partner do
			var_5_6[iter_5_0] = tolua.cast(var_5_4:getChildByTag(iter_5_0 + 10), "CCControlButton")

			var_5_6[iter_5_0]:addHandleOfControlEvent(function()
				arg_3_0:onTouch(iter_5_0)
			end, CCControlEventTouchUpInside)
			zbUtil:setButtonTitle(var_5_6[iter_5_0], "")

			arg_3_0.tabSprites[iter_5_0] = CCSprite:create(arg_3_0.tabImagePaths[iter_5_0])

			arg_3_0.tabSprites[iter_5_0]:setAnchorPoint(ccp(0.5, 0.5))
			arg_3_0.tabSprites[iter_5_0]:setPosition(var_5_6[iter_5_0]:getContentSize().width / 2, var_5_6[iter_5_0]:getContentSize().height / 2)
			var_5_6[iter_5_0]:addChild(arg_3_0.tabSprites[iter_5_0])
		end

		arg_3_0.tabButtons = var_5_6

		local var_5_7 = {
			[EHeroDetailTab.Detail] = tolua.cast(var_5_3:getChildByTag(3), "CCLayer"),
			[EHeroDetailTab.Fate] = tolua.cast(var_5_3:getChildByTag(8), "CCLayer")
		}

		arg_3_0.tabLayers = var_5_7
		arg_3_0.module = {}
		arg_3_0.module[EHeroDetailTab.Detail] = createHeroDetailDetailPanel(arg_3_0.tabLayers[EHeroDetailTab.Detail], "CCNode")

		local var_5_8 = getPreloadCCNode("ccbi/heroDetail_Xilian.ccbi")

		arg_3_0.module[EHeroDetailTab.XiLian] = createHeroDetailXiliangPanel(var_5_8, arg_3_0.tabButtons[EHeroDetailTab.XiLian])

		arg_3_0.layerAdd:addChild(arg_3_0.module[EHeroDetailTab.XiLian])

		local var_5_9 = getPreloadCCNode("ccbi/heroDetail_Skill.ccbi")

		arg_3_0.module[EHeroDetailTab.Skill] = createHeroDetailSkillPanel(var_5_9, "CCNode")

		arg_3_0.layerSkill:addChild(arg_3_0.module[EHeroDetailTab.Skill])

		local var_5_10 = getPreloadCCNode("ccbi/heroDetail_Starup.ccbi")

		arg_3_0.module[EHeroDetailTab.StarUp] = createHeroDetailWnd_StarupPanel(var_5_10, arg_3_0)

		arg_3_0.layerAdd:addChild(arg_3_0.module[EHeroDetailTab.StarUp])

		local var_5_11 = getPreloadCCNode("ccbi/heroDetail_Juexing.ccbi")

		arg_3_0.module[EHeroDetailTab.Phase] = createHeroDetailJuexingPanel(var_5_11)

		arg_3_0.layerAdd:addChild(arg_3_0.module[EHeroDetailTab.Phase])

		local var_5_12 = getPreloadCCNode("ccbi/heroDetail_Partner.ccbi")

		arg_3_0.module[EHeroDetailTab.Partner] = createHeroPartnerDetailPanel(var_5_12)

		arg_3_0.layerAdd:addChild(arg_3_0.module[EHeroDetailTab.Partner])

		arg_3_0.module[EHeroDetailTab.Fate] = createHeroFateDetailPanel(arg_3_0.tabLayers[EHeroDetailTab.Fate], arg_3_0.tabButtons[EHeroDetailTab.Fate])
		arg_3_0.btnSkill_Tag = var_5_0(var_5_6[EHeroDetailTab.Skill])
		arg_3_0.btnPhase_Tag = var_5_0(var_5_6[EHeroDetailTab.Phase])
		arg_3_0.btnStarUp_Tag = var_5_0(var_5_6[EHeroDetailTab.StarUp])
		arg_3_0.btnXiLian_Tag = var_5_0(var_5_6[EHeroDetailTab.XiLian])
		arg_3_0.btnPartner_Tag = var_5_0(var_5_6[EHeroDetailTab.Partner])
		arg_3_0.spriteLeft = tolua.cast(var_5_3:getChildByTag(24), "CCSprite")
		arg_3_0.spriteRight = tolua.cast(var_5_3:getChildByTag(25), "CCSprite")
		arg_3_0.btnLeft = tolua.cast(var_5_3:getChildByTag(26), "CCControlButton")
		arg_3_0.btnRight = tolua.cast(var_5_3:getChildByTag(27), "CCControlButton")

		arg_3_0.btnLeft:addHandleOfControlEvent(function()
			arg_3_0:onLeft()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnRight:addHandleOfControlEvent(function()
			arg_3_0:onRight()
		end, CCControlEventTouchUpInside)
		zbUIEffect:runFadeToAction(arg_3_0.spriteLeft)
		zbUIEffect:runFadeToAction(arg_3_0.spriteRight)

		arg_3_0.strHeroFateGuide = "HeroGuide" .. g_GameData.BaseInfo.PlayerId .. "_" .. EHeroDetailTab.Fate

		if zbGameCore:Instance():getConfigValue(arg_3_0.strHeroFateGuide) ~= 1 then
			arg_3_0.newFateOpen = var_5_1(var_5_6[EHeroDetailTab.Fate])
		end

		arg_3_0.strHeroPartnerGuide = "HeroGuide" .. g_GameData.BaseInfo.PlayerId .. "_" .. EHeroDetailTab.Partner

		if zbGameCore:Instance():getConfigValue(arg_3_0.strHeroPartnerGuide) ~= 1 then
			arg_3_0.newParnerOpen = var_5_1(var_5_6[EHeroDetailTab.Partner])
		end

		arg_3_0:addChild(var_5_2)
		arg_3_0:createMoneyPanel(var_5_2, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold,
			EMoneyPanelResType.SkillBook
		}, function()
			arg_3_0:hide()
		end)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refreshUpdate()
	end, zbGameEvent.Event_Update_Hero)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refreshUpdate()
	end, zbGameEvent.Event_Update_FragHero)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refreshUpdate()
	end, zbGameEvent.Event_Update_BagItem)
end

function zbHeroDetailWnd.visibleNotify(arg_15_0)
	local var_15_0 = g_Self.kHeroFragHandler:getHeroCanStarUp(arg_15_0.heroDetail.HeroBaseInfo.TemplateId)

	arg_15_0.btnStarUp_Tag:setVisible(var_15_0)

	local var_15_1 = g_Self.kHeroHandler:getHeroCanskillUp(arg_15_0.heroDetail)

	arg_15_0.btnSkill_Tag:setVisible(var_15_1)
	arg_15_0.btnPhase_Tag:setVisible(g_Self.kHeroHandler:getHeroCanJuxingUp(arg_15_0.heroDetail))
	arg_15_0.btnXiLian_Tag:setVisible(g_Self.kHeroHandler:getHeroCanXiLian(arg_15_0.heroDetail))
	arg_15_0.btnPartner_Tag:setVisible(g_Self.kHeroHandler:getHeroCanParners(arg_15_0.heroDetail))

	if arg_15_0.newFateOpen then
		local var_15_2 = zbGameCore:Instance():getConfigValue(arg_15_0.strHeroFateGuide)

		arg_15_0.newFateOpen:setVisible(not zbFunHelper:isLockNoTip(EFuncType.Fate) and var_15_2 ~= "1")
	end

	if arg_15_0.newParnerOpen then
		local var_15_3 = zbGameCore:Instance():getConfigValue(arg_15_0.strHeroPartnerGuide)

		arg_15_0.newParnerOpen:setVisible(not zbFunHelper:isLockNoTip(EFuncType.Follower) and var_15_3 ~= "1")
	end

	if zbFunHelper:isLockNoTip(EFuncType.Fate) then
		zbUIEffect:centerHeroDetailBtn(arg_15_0.tabButtons, EHeroDetailTab.Max - 2, true, 7)

		return
	elseif zbFunHelper:isLockNoTip(EFuncType.HeroRefresh) then
		zbUIEffect:centerHeroDetailBtn(arg_15_0.tabButtons, EHeroDetailTab.Max - 1, true, 7)

		return
	elseif zbFunHelper:isLockNoTip(EFuncType.Follower) then
		zbUIEffect:centerHeroDetailBtn(arg_15_0.tabButtons, EHeroDetailTab.Max, true, 7)

		return
	end

	zbUIEffect:centerHeroDetailBtn(arg_15_0.tabButtons, EHeroDetailTab.Max, false, 7)
end

function zbHeroDetailWnd.refresh(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_0.heroDetail = arg_16_1
	arg_16_0.heroDescList = arg_16_2
	arg_16_0.heroType = arg_16_3

	if arg_16_0.heroDetail == nil then
		return
	end

	arg_16_0:visibleNotify()

	if zbUtil:isValidTable(arg_16_0.heroDescList) then
		local var_16_0 = table.getn(arg_16_2)

		arg_16_0.spriteLeft:setVisible(var_16_0 > 1)
		arg_16_0.spriteRight:setVisible(var_16_0 > 1)
		arg_16_0.btnLeft:setVisible(var_16_0 > 1)
		arg_16_0.btnRight:setVisible(var_16_0 > 1)

		local var_16_1 = 1

		for iter_16_0, iter_16_1 in pairs(arg_16_2) do
			if iter_16_1 ~= nil and iter_16_1.HeroBaseInfo.TemplateId == arg_16_0.heroDetail.HeroBaseInfo.TemplateId then
				arg_16_0.curIndex = var_16_1

				break
			end

			var_16_1 = var_16_1 + 1
		end
	else
		arg_16_0.spriteLeft:setVisible(false)
		arg_16_0.spriteRight:setVisible(false)
		arg_16_0.btnLeft:setVisible(false)
		arg_16_0.btnRight:setVisible(false)
	end

	arg_16_0:doSelectTab()
	arg_16_0.layerAvatar:refreshDetail(arg_16_0.heroDetail)
	arg_16_0.layerBase:refresh(arg_16_0.heroDetail)
	arg_16_0.layerTips.node:setVisible(false)
end

function zbHeroDetailWnd.onFrameUpdate(arg_17_0, arg_17_1)
	return
end

function zbHeroDetailWnd.onClose(arg_18_0)
	arg_18_0:hide()
end

function zbHeroDetailWnd.doSelectTab(arg_19_0)
	if arg_19_0.module[arg_19_0.currTab] then
		arg_19_0.module[arg_19_0.currTab]:refresh(arg_19_0.heroDetail)
	end

	for iter_19_0 = 1, EHeroDetailTab.Partner do
		if arg_19_0.module[iter_19_0] then
			if iter_19_0 ~= arg_19_0.currTab then
				arg_19_0.module[iter_19_0].layer:setVisible(false)
				arg_19_0.tabButtons[iter_19_0]:setEnabled(true)
				arg_19_0.tabSprites[iter_19_0]:setGray(true)
			else
				arg_19_0.module[iter_19_0].layer:setVisible(true)
				arg_19_0.tabButtons[iter_19_0]:setEnabled(false)
				arg_19_0.tabSprites[iter_19_0]:setGray(false)
			end
		end
	end

	if arg_19_0.newFateOpen and arg_19_0.currTab == EHeroDetailTab.Fate then
		arg_19_0.newFateOpen:setVisible(false)
		zbGameCore:Instance():setConfigValue(arg_19_0.strHeroFateGuide, 1)
	end

	if arg_19_0.newParnerOpen and arg_19_0.currTab == EHeroDetailTab.Partner then
		arg_19_0.newParnerOpen:setVisible(false)
		zbGameCore:Instance():setConfigValue(arg_19_0.strHeroPartnerGuide, 1)
	end
end

function zbHeroDetailWnd.onLeft(arg_20_0)
	local var_20_0 = arg_20_0.curIndex - 1

	arg_20_0:selectShowHero(var_20_0)
end

function zbHeroDetailWnd.onRight(arg_21_0)
	local var_21_0 = arg_21_0.curIndex + 1

	arg_21_0:selectShowHero(var_21_0)
end

function zbHeroDetailWnd.selectShowHero(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.heroDescList

	if zbUtil:isValidTable(arg_22_0.heroDescList) == false then
		return
	end

	local var_22_1 = table.getn(var_22_0)

	if var_22_1 == 0 then
		arg_22_0:hide()

		return
	end

	if var_22_1 < arg_22_1 then
		arg_22_1 = 1
	end

	if arg_22_1 <= 0 then
		arg_22_1 = var_22_1
	end

	arg_22_0.curIndex = arg_22_1
	arg_22_0.heroDetail = var_22_0[arg_22_1]

	if arg_22_0.heroDetail == nil then
		arg_22_0:hide()

		return
	end

	arg_22_0:refresh(arg_22_0.heroDetail, arg_22_0.heroDescList, arg_22_0.heroType)
end

function zbHeroDetailWnd.refreshUpdate(arg_23_0)
	if arg_23_0.isShow == false then
		return
	end

	if arg_23_0.heroDetail ~= nil then
		arg_23_0.heroDetail = g_Self.kHeroHandler:getHeroByTemplateId(arg_23_0.heroDetail.HeroBaseInfo.TemplateId)

		if arg_23_0.heroDetail == nil then
			arg_23_0:hide()

			return
		end

		arg_23_0.heroDescList = arg_23_0:getHeroList()

		arg_23_0.layerAvatar:refreshDetail(arg_23_0.heroDetail)
		arg_23_0.layerBase:refresh(arg_23_0.heroDetail)
		arg_23_0:visibleNotify()
		arg_23_0:doSelectTab()
	else
		arg_23_0:hide()
	end
end

function zbHeroDetailWnd.getHeroList(arg_24_0)
	local var_24_0 = {}

	if arg_24_0.heroType == EHeroTabType.Battle then
		var_24_0 = g_Self.kHeroHandler:getWorkHeros()
	elseif arg_24_0.heroType == EHeroTabType.Entourage then
		var_24_0 = g_Self.kHeroHandler:getEntourageHeros()
	elseif arg_24_0.heroType == EHeroTabType.UnUse then
		var_24_0 = g_Self.kHeroHandler:getNoUseHeros()
	elseif arg_24_0.heroType == EHeroTabType.UnObtain then
		var_24_0 = g_Self.kHeroFragHandler:getSortedHeroFragsByType()
	end

	return var_24_0
end

function zbHeroDetailWnd.onTouch(arg_25_0, arg_25_1)
	if arg_25_1 == EHeroDetailTab.Fate and zbFunHelper:isLockAndTip(EFuncType.Fate) then
		return
	elseif arg_25_1 == EHeroDetailTab.XiLian and zbFunHelper:isLockAndTip(EFuncType.HeroRefresh) then
		return
	elseif arg_25_1 == EHeroDetailTab.Partner and zbFunHelper:isLockAndTip(EFuncType.Follower) then
		return
	end

	arg_25_0.currTab = arg_25_1

	arg_25_0:doSelectTab()
end

function zbHeroDetailWnd.onFrameUpdate(arg_26_0)
	arg_26_0:updateBackEffect()
end
