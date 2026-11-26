local var_0_0 = class("zbMainMenu")

var_0_0.__index = var_0_0

function createMainMenu(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	local function var_2_0(arg_3_0)
		local var_3_0 = CCSprite:create(NOTIFY_TAG_PATH)

		var_3_0:setAnchorPoint(ccp(0.5, 0.5))
		var_3_0:setPosition(arg_3_0:getContentSize().width / 2 + 25, arg_3_0:getContentSize().height / 2 + 25)
		var_3_0:setVisible(false)
		arg_3_0:addChild(var_3_0)
		zbUIEffect:createNotifyTagScaleAction(var_3_0)

		return var_3_0
	end

	arg_2_0.parentWnd = arg_2_1
	arg_2_0.node = arg_2_2
	arg_2_0.spriteBg = tolua.cast(arg_2_2:getChildByTag(100), "CCSprite")
	arg_2_0.menuFormation = tolua.cast(arg_2_2:getChildByTag(1), "CCControlButton")
	arg_2_0.menuHero = tolua.cast(arg_2_2:getChildByTag(2), "CCControlButton")
	arg_2_0.menuBag = tolua.cast(arg_2_2:getChildByTag(3), "CCControlButton")
	arg_2_0.menuEquip = tolua.cast(arg_2_2:getChildByTag(4), "CCControlButton")
	arg_2_0.menuFight = tolua.cast(arg_2_2:getChildByTag(5), "CCControlButton")
	arg_2_0.menuFriend = tolua.cast(arg_2_2:getChildByTag(6), "CCControlButton")
	arg_2_0.menuMail = tolua.cast(arg_2_2:getChildByTag(7), "CCControlButton")
	arg_2_0.menuTask = tolua.cast(arg_2_2:getChildByTag(8), "CCControlButton")
	arg_2_0.menuPreshow = tolua.cast(arg_2_2:getChildByTag(9), "CCControlButton")
	arg_2_0.notifyFormation = var_2_0(arg_2_0.menuFormation)
	arg_2_0.notifyHero = var_2_0(arg_2_0.menuHero)
	arg_2_0.notifyBag = var_2_0(arg_2_0.menuBag)
	arg_2_0.notifyEquip = var_2_0(arg_2_0.menuEquip)
	arg_2_0.notifyFight = var_2_0(arg_2_0.menuFight)
	arg_2_0.notifyFriend = var_2_0(arg_2_0.menuFriend)
	arg_2_0.notifyMail = var_2_0(arg_2_0.menuMail)
	arg_2_0.notifyTask = var_2_0(arg_2_0.menuTask)

	arg_2_0.menuFormation:addHandleOfControlEvent(function()
		arg_2_0:onFormation()
	end, CCControlEventTouchUpInside)
	arg_2_0.menuHero:addHandleOfControlEvent(function()
		arg_2_0:onHero()
	end, CCControlEventTouchUpInside)
	arg_2_0.menuBag:addHandleOfControlEvent(function()
		arg_2_0:onBag()
	end, CCControlEventTouchUpInside)
	arg_2_0.menuEquip:addHandleOfControlEvent(function()
		arg_2_0:onEquip()
	end, CCControlEventTouchUpInside)
	arg_2_0.menuFight:addHandleOfControlEvent(function()
		arg_2_0:onFight()
	end, CCControlEventTouchUpInside)
	arg_2_0.menuFriend:addHandleOfControlEvent(function()
		arg_2_0:onFriend()
	end, CCControlEventTouchUpInside)
	arg_2_0.menuMail:addHandleOfControlEvent(function()
		arg_2_0:onMail()
	end, CCControlEventTouchUpInside)
	arg_2_0.menuTask:addHandleOfControlEvent(function()
		arg_2_0:onTask()
	end, CCControlEventTouchUpInside)
	arg_2_0.menuPreshow:addHandleOfControlEvent(function()
		arg_2_0:onPreshow()
	end, CCControlEventTouchUpInside)

	local var_2_1 = createUIAnimation()

	var_2_1:refresh("effect/spine/ui_fubentubiao/ui_fubentubiao.json", "effect/spine/ui_fubentubiao/ui_fubentubiao.atlas")
	var_2_1:setPosition(50, 50)
	var_2_1:setAnchorPoint(ccp(0, 0))
	var_2_1:setAnimation("animation", true)
	arg_2_0.menuFight:addChild(var_2_1)

	if g_Self:getLevel() <= 15 then
		arg_2_0.spiteHitMe = CCSprite:create("image/main/main_hitme.png")

		arg_2_0.menuFight:addChild(arg_2_0.spiteHitMe)
		arg_2_0.spiteHitMe:setPosition(5, 85)
		arg_2_0.spiteHitMe:setAnchorPoint(ccp(0, 0))
		arg_2_0.spiteHitMe:setScaleX(0.7)

		arg_2_0.costValue = CCLabelTTF:create(a2u("\xB9\xCA\xCA¿\xAAʼ\xC0\xB2\xA3\xA1"), DefaultFontName, 20)

		arg_2_0.menuFight:addChild(arg_2_0.costValue)
		arg_2_0.costValue:setPosition(25, 108)
		arg_2_0.costValue:setAnchorPoint(ccp(0, 0))
		arg_2_0.spiteHitMe:setVisible(true)
		arg_2_0.costValue:setVisible(true)
		arg_2_0.costValue:setColor(FONT_COLOR_BLACK)
		zbUIEffect:createArrowMoveAction(arg_2_0.spiteHitMe, 5, 2)
		zbUIEffect:createArrowMoveAction(arg_2_0.costValue, 5, 2)
	end

	arg_2_0.nodeAnim = CCNode:create()

	arg_2_0.parentWnd:addChild(arg_2_0.nodeAnim)

	arg_2_0.position = ccp(arg_2_0.node:getPosition())
end

function var_0_0.onFormation(arg_13_0)
	g_MainScene:showFormationWnd()
end

function var_0_0.onHero(arg_14_0)
	g_MainScene:showHeroListWnd()
end

function var_0_0.onBag(arg_15_0)
	g_MainScene:showBagWnd()
end

function var_0_0.onEquip(arg_16_0)
	g_MainScene:showEquipListWnd()
end

function var_0_0.onFight(arg_17_0)
	g_MainScene:showWarPath()
end

function var_0_0.onFriend(arg_18_0)
	if zbFunHelper:isLockAndTip(EFuncType.Friends) then
		return
	end

	g_Self.kFriendHandler:openFriend()
end

function var_0_0.onMail(arg_19_0)
	g_MainScene:showMailWnd()
end

function var_0_0.onTask(arg_20_0)
	if zbFunHelper:isLockAndTip(EFuncType.MainTask) then
		return
	end

	if zbFunHelper:isLockNoTip(EFuncType.DailyTask) then
		g_MainScene:showTaskWnd(ETaskType.Success)
	else
		g_MainScene:showTaskWnd(ETaskType.Daily)
	end
end

function var_0_0.onPreshow(arg_21_0)
	g_MainScene:showHeroHandbookWnd()
end

function var_0_0.onWarPath(arg_22_0)
	g_MainScene:showWarPath()
end

function var_0_0.onFrameUpdate(arg_23_0, arg_23_1)
	arg_23_0:onUpdateNotify()

	if arg_23_0.spiteHitMe then
		if g_Self:getLevel() >= 5 and g_Self:getLevel() <= 15 then
			arg_23_0.spiteHitMe:setVisible(true)
			arg_23_0.costValue:setVisible(true)
		else
			arg_23_0.spiteHitMe:setVisible(false)
			arg_23_0.costValue:setVisible(false)
		end
	end
end

function var_0_0.onUpdateNotify(arg_24_0)
	arg_24_0.notifyFormation:setVisible(g_Self.kRedPointHandler:hasRedPoint(ERedPointType.Formation))
	arg_24_0.notifyHero:setVisible(g_Self.kRedPointHandler:hasRedPoint(ERedPointType.Hero))
	arg_24_0.notifyBag:setVisible(g_Self.kRedPointHandler:hasRedPoint(ERedPointType.Bag))
	arg_24_0.notifyEquip:setVisible(g_Self.kRedPointHandler:hasRedPoint(ERedPointType.Equip))
	arg_24_0.notifyFight:setVisible(g_Self.kRedPointHandler:hasRedPoint(ERedPointType.GameLevel))
	arg_24_0.notifyFriend:setVisible(g_Self.kRedPointHandler:hasRedPoint(ERedPointType.Friend))
	arg_24_0.notifyMail:setVisible(g_Self.kRedPointHandler:hasRedPoint(ERedPointType.Mail))
	arg_24_0.notifyTask:setVisible(g_Self.kRedPointHandler:hasRedPoint(ERedPointType.Task))
end

function var_0_0.popdown(arg_25_0)
	arg_25_0.node:setVisible(false)
end

function var_0_0.popup(arg_26_0)
	arg_26_0.node:setVisible(true)
end

function var_0_0.isContained(arg_27_0, arg_27_1, arg_27_2)
	if zbUtil:PointInCtrl(arg_27_0.spriteBg, arg_27_1, arg_27_2) then
		return true
	end

	return false
end
