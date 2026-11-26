require("gamelogic.zbTabWnd")
require("gamelogic.zbHeroList")

local var_0_0 = class("zbHeroListWnd", zbTabWnd)

var_0_0.__index = var_0_0

function createHeroListWnd()
	local var_1_0 = var_0_0.extend(zbTabWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create()))))

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
		return
	end

	local function var_3_1()
		local function var_5_0(arg_6_0)
			local var_6_0 = CCSprite:create(NOTIFY_TAG_PATH)

			var_6_0:setAnchorPoint(ccp(0.5, 0.5))
			var_6_0:setPosition(arg_6_0:getContentSize().width - 25, arg_6_0:getContentSize().height / 2 + 20)
			var_6_0:setVisible(false)
			arg_6_0:addChild(var_6_0)
			zbUIEffect:createNotifyTagScaleAction(var_6_0)

			return var_6_0
		end

		local function var_5_1(arg_7_0)
			local var_7_0 = CCSprite:create("image/hero/hero_new.png")

			var_7_0:setAnchorPoint(ccp(0.5, 0.5))
			var_7_0:setPosition(arg_7_0:getContentSize().width - 20, arg_7_0:getContentSize().height / 2 + 20)
			var_7_0:setVisible(false)
			arg_7_0:addChild(var_7_0)
			zbUIEffect:createNotifyTagScaleAction(var_7_0)

			return var_7_0
		end

		local var_5_2 = CCBProxy:create()
		local var_5_3 = CCBReaderLoad("ccbi/heroList.ccbi", var_5_2, true, "HelloCocosBuilderLayerOwner")
		local var_5_4 = tolua.cast(var_5_3:getChildByTag(1), "CCNode")
		local var_5_5 = tolua.cast(var_5_3:getChildByTag(2), "CCNode")

		arg_3_0.node = var_5_3
		arg_3_0.layer = var_5_4
		arg_3_0.layerTab = var_5_5

		local var_5_6 = tolua.cast(var_5_4:getChildByTag(22), "CCSprite")

		zbUIEffect:runFadeToAction(var_5_6)

		local var_5_7 = {
			[EHeroTabType.Battle] = tolua.cast(var_5_5:getChildByTag(1), "CCControlButton"),
			[EHeroTabType.Entourage] = tolua.cast(var_5_5:getChildByTag(2), "CCControlButton"),
			[EHeroTabType.UnUse] = tolua.cast(var_5_5:getChildByTag(3), "CCControlButton"),
			[EHeroTabType.UnObtain] = tolua.cast(var_5_5:getChildByTag(4), "CCControlButton")
		}
		local var_5_8 = {
			[EHeroTabType.Battle] = tolua.cast(var_5_4:getChildByTag(11), "CCLayer"),
			[EHeroTabType.Entourage] = tolua.cast(var_5_4:getChildByTag(12), "CCLayer"),
			[EHeroTabType.UnUse] = tolua.cast(var_5_4:getChildByTag(13), "CCLayer"),
			[EHeroTabType.UnObtain] = tolua.cast(var_5_4:getChildByTag(14), "CCLayer")
		}
		local var_5_9 = {
			[EHeroTabType.Battle] = "image/tab/tab_hero_battle.png",
			[EHeroTabType.Entourage] = "image/tab/tab_hero_entourage.png",
			[EHeroTabType.UnUse] = "image/tab/tab_hero_unUse.png",
			[EHeroTabType.UnObtain] = "image/tab/tab_hero_unObtain.png"
		}

		arg_3_0.notifyBattle = var_5_0(var_5_7[EHeroTabType.Battle])
		arg_3_0.notifyEntourage = var_5_0(var_5_7[EHeroTabType.Entourage])
		arg_3_0.notifyUnObtain = var_5_0(var_5_7[EHeroTabType.UnObtain])
		arg_3_0.newBattle = var_5_1(var_5_7[EHeroTabType.Battle])
		arg_3_0.newEntourage = var_5_1(var_5_7[EHeroTabType.Entourage])
		arg_3_0.newUnUse = var_5_1(var_5_7[EHeroTabType.UnUse])
		arg_3_0.tabButtons = var_5_7
		arg_3_0.module = {}
		arg_3_0.module[EHeroTabType.Battle] = createHeroListPanel(var_5_8[EHeroTabType.Battle], EHeroTabType.Battle, spriteLeft, var_5_6, var_5_7[EHeroTabType.Battle], arg_3_0)
		arg_3_0.module[EHeroTabType.Entourage] = createHeroListPanel(var_5_8[EHeroTabType.Entourage], EHeroTabType.Entourage, spriteLeft, var_5_6, var_5_7[EHeroTabType.Entourage], arg_3_0)
		arg_3_0.module[EHeroTabType.UnUse] = createHeroListPanel(var_5_8[EHeroTabType.UnUse], EHeroTabType.UnUse, spriteLeft, var_5_6, var_5_7[EHeroTabType.UnUse], arg_3_0)
		arg_3_0.module[EHeroTabType.UnObtain] = createHeroListPanel(var_5_8[EHeroTabType.UnObtain], EHeroTabType.UnObtain, spriteLeft, var_5_6, var_5_7[EHeroTabType.UnObtain], arg_3_0)

		arg_3_0:initTab(var_5_7, var_5_8, var_5_9)
		arg_3_0:addChild(var_5_3)
		arg_3_0:addBtnChat(var_5_3)
		arg_3_0:createMoneyPanel(var_5_3, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold,
			EMoneyPanelResType.SkillBook
		}, function()
			arg_3_0:hide()
		end)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(function()
		arg_3_0:onShow()
	end)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onDataUpdateAck()
	end, zbGameEvent.Event_Update_Hero)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onDataUpdateAck()
	end, zbGameEvent.Event_Update_FragHero)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onDataUpdateAck()
	end, zbGameEvent.Event_Update_Formation)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onDataUpdateAck()
	end, zbGameEvent.Event_Update_BagItem)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onDataUpdateAck()
	end, zbGameEvent.Event_Update_BagEquip)
end

function var_0_0.refresh(arg_15_0)
	arg_15_0:onUpdateNotify()
end

function var_0_0.onShow(arg_16_0)
	arg_16_0:selectTab(1)
end

function var_0_0.doSelectTab(arg_17_0)
	arg_17_0.module[arg_17_0.currTab]:refresh()
end

function var_0_0.onDataUpdateAck(arg_18_0)
	for iter_18_0, iter_18_1 in pairs(arg_18_0.module) do
		iter_18_1:refreshDirtyFlag()
	end

	if arg_18_0.isShow then
		arg_18_0.module[arg_18_0.currTab]:refresh()
	end

	g_Self.kRedPointHandler:refreshHero()
	arg_18_0:onUpdateNotify()
end

function var_0_0.onFrameUpdate(arg_19_0)
	arg_19_0:updateBackEffect()
end

function var_0_0.onUpdateNotify(arg_20_0)
	local var_20_0 = arg_20_0:isHaveNewHero(EHeroTabType.Battle)

	arg_20_0.newBattle:setVisible(var_20_0)

	if var_20_0 == false then
		arg_20_0.notifyBattle:setVisible(g_Self.kHeroHandler:getBattleHeroNotify())
	else
		arg_20_0.notifyBattle:setVisible(false)
	end

	local var_20_1 = arg_20_0:isHaveNewHero(EHeroTabType.Entourage)

	arg_20_0.newEntourage:setVisible(var_20_1)

	if var_20_1 == false then
		arg_20_0.notifyEntourage:setVisible(g_Self.kHeroHandler:getEntourageHeroNotify())
	else
		arg_20_0.notifyEntourage:setVisible(false)
	end

	local var_20_2 = arg_20_0:isHaveNewHero(EHeroTabType.UnUse)

	arg_20_0.newUnUse:setVisible(var_20_2)
	arg_20_0.notifyUnObtain:setVisible(g_Self.kHeroHandler:getUnObtainHeroNotify())
end

function var_0_0.isHaveNewHero(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.module[arg_21_1]:getHeroList()
	local var_21_1 = 1

	for iter_21_0, iter_21_1 in pairs(var_21_0) do
		if g_Self.kHeroHandler.isNewHero[iter_21_1.HeroBaseInfo.TemplateId] ~= nil then
			return true
		end
	end

	return false
end
