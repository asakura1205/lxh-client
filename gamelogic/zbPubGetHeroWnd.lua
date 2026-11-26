require("gamelogic.zbBaseWnd")
require("gamelogic.zbItem")

local var_0_0 = class("zbPubGetHeroWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createPubGetHeroWnd()
	local var_1_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

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
		arg_3_0.spriteStars = {}
		arg_3_0.layerinitPos = ccp(0, 0)
		arg_3_0.backtendraw = nil
		arg_3_0.actionEnd = false
		arg_3_0.firstActionEnd = false
		arg_3_0.secondActionDid = false
		arg_3_0.award = nil
		arg_3_0.customHideCallback = nil
		arg_3_0.showScroll = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/pub_hero.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")

		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.nodeView = tolua.cast(var_5_1:getChildByTag(3), "CCNode")
		arg_3_0.viewEffectNode1 = tolua.cast(arg_3_0.nodeView:getChildByTag(200), "CCNode")
		arg_3_0.viewEffectNode2 = tolua.cast(arg_3_0.nodeView:getChildByTag(100), "CCNode")
		arg_3_0.heroTypeNode = tolua.cast(arg_3_0.nodeView:getChildByTag(2), "CCNode")
		arg_3_0.heroType = tolua.cast(arg_3_0.heroTypeNode:getChildByTag(2), "CCSprite")
		arg_3_0.lblviewName = tolua.cast(arg_3_0.heroTypeNode:getChildByTag(1), "CCLabelTTF")
		arg_3_0.sprarity = tolua.cast(arg_3_0.nodeView:getChildByTag(3), "CCSprite")
		arg_3_0.quality = tolua.cast(arg_3_0.nodeView:getChildByTag(4), "CCNode")
		arg_3_0.location = tolua.cast(arg_3_0.nodeView:getChildByTag(5), "CCLabelTTF")
		arg_3_0.hero = tolua.cast(arg_3_0.nodeView:getChildByTag(6), "CCSprite")
		arg_3_0.btnShare = tolua.cast(arg_3_0.nodeView:getChildByTag(14), "CCControlButton")

		arg_3_0.btnShare:addHandleOfControlEvent(function()
			arg_3_0:onShare()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnShare:setVisible(false)

		arg_3_0.viewStars = {}

		for iter_5_0 = 1, 8 do
			arg_3_0.viewStars[iter_5_0] = tolua.cast(arg_3_0.quality:getChildByTag(iter_5_0), "CCSprite")
		end

		arg_3_0.layer = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")
		arg_3_0.layerinitPos = ccp(arg_3_0.layer:getPosition())
		arg_3_0.nodehero = tolua.cast(arg_3_0.layer:getChildByTag(1), "CCNode")
		arg_3_0.nodeStar = tolua.cast(arg_3_0.nodehero:getChildByTag(1), "CCNode")
		arg_3_0.lbName = tolua.cast(arg_3_0.nodehero:getChildByTag(2), "CCLabelTTF")
		arg_3_0.lbDesc = tolua.cast(arg_3_0.nodehero:getChildByTag(3), "CCLabelTTF")
		arg_3_0.heroType2 = tolua.cast(arg_3_0.nodehero:getChildByTag(4), "CCSprite")
		arg_3_0.sprarity2 = tolua.cast(arg_3_0.nodehero:getChildByTag(5), "CCSprite")
		arg_3_0.nodeAvatar = tolua.cast(arg_3_0.nodehero:getChildByTag(100), "CCNode")
		arg_3_0.heroAvatar = createUIAnimation()

		arg_3_0.heroAvatar:setPosition(0, 22)
		arg_3_0.nodeAvatar:addChild(arg_3_0.heroAvatar)

		for iter_5_1 = 1, 8 do
			arg_3_0.spriteStars[iter_5_1] = tolua.cast(arg_3_0.nodeStar:getChildByTag(iter_5_1), "CCSprite")
		end

		arg_3_0.nodefrag = tolua.cast(arg_3_0.layer:getChildByTag(2), "CCNode")

		local var_5_2 = tolua.cast(arg_3_0.nodefrag:getChildByTag(1), "CCLayerColor")
		local var_5_3 = createItem()

		var_5_3:setPosition(var_5_2:getPosition())
		var_5_3:setScale(0.9)
		arg_3_0.nodefrag:addChild(var_5_3)

		arg_3_0.equipItemDummy = var_5_3

		var_5_2:removeFromParentAndCleanup(true)

		arg_3_0.effectRoot = tolua.cast(var_5_1:getChildByTag(2), "CCNode")

		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.setShareUiVisible(arg_8_0, arg_8_1)
	arg_8_0.nodeView:setVisible(arg_8_1)
end

function var_0_0.onShare(arg_9_0)
	if arg_9_0.award then
		arg_9_0:setShareUiVisible(false)

		if g_Broadcast then
			g_Broadcast:setBroadCastVisible(false)
		end

		if g_MainScene.wndPub then
			g_MainScene.wndPub:setShareUiVisible(false)
		end

		g_MainScene:showShowPubShareWnd(arg_9_0.award.Id)
		zbGlobalUtil:shareTxtAndImage("", "")
	end
end

function var_0_0.initEffect(arg_10_0)
	if arg_10_0.effect == nil then
		arg_10_0.effect = createUIAnimation()

		arg_10_0.effect:refresh("effect/spine/ui_chouka/chouka_03/chouka_03.json", "effect/spine/ui_chouka/chouka_03/chouka_03.atlas")
		arg_10_0.effect:setPosition(0, 0)
		arg_10_0.effect:setAnchorPoint(ccp(0.5, 0))
		arg_10_0.effectRoot:addChild(arg_10_0.effect)
	end
end

function var_0_0.createHeroViewEffect(arg_11_0)
	g_Audio:playSound(AudioDefine.UI_ITEM_GET)
	arg_11_0.viewEffectNode1:removeAllChildrenWithCleanup(true)

	local var_11_0 = createUIAnimation()

	var_11_0:refresh("effect/spine/ui_chouka/chouka_06_1/chouka_06_1.json", "effect/spine/ui_chouka/chouka_06_1/chouka_06_1.atlas")
	var_11_0:setPosition(0, 0)
	arg_11_0.viewEffectNode1:addChild(var_11_0)

	if arg_11_0.isPub then
		var_11_0:playAnimationOnce("animation_01", "animation_02", 0.12)
	else
		var_11_0:playAnimationOnce("animation_03", "animation_04", 0.12)
	end

	arg_11_0.viewEffectNode2:removeAllChildrenWithCleanup(true)

	local var_11_1 = createUIAnimation()

	var_11_1:refresh("effect/spine/ui_chouka/chouka_06_2/chouka_06_2.json", "effect/spine/ui_chouka/chouka_06_2/chouka_06_2.atlas")
	var_11_1:setPosition(0, 0)
	arg_11_0.viewEffectNode2:addChild(var_11_1)
	var_11_1:playAnimationOnce("animation_01", "animation_02", 0.12)
end

function var_0_0.refresh(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5)
	arg_12_0.award = arg_12_1

	if arg_12_2 then
		arg_12_0.backtendraw = arg_12_2
	else
		arg_12_0.backtendraw = false
	end

	if arg_12_3 then
		arg_12_0.isPub = arg_12_3
	else
		arg_12_0.isPub = false
	end

	arg_12_0.customHideCallback = arg_12_4
	arg_12_0.showScroll = arg_12_5

	local function var_12_0()
		arg_12_0.firstActionEnd = true

		arg_12_0:initEffect()
	end

	if arg_12_1.bHave ~= true then
		g_Self.kHeroHandler.isNewHero[arg_12_1.Id] = arg_12_1.Id
	end

	arg_12_0.layer:setVisible(false)

	arg_12_0.actionEnd = false

	arg_12_0.nodeView:setVisible(true)

	arg_12_0.firstActionEnd = false
	arg_12_0.secondActionDid = false
	arg_12_0.quality = tolua.cast(arg_12_0.nodeView:getChildByTag(4), "CCNode")
	arg_12_0.location = tolua.cast(arg_12_0.nodeView:getChildByTag(5), "CCLabelTTF")

	local var_12_1 = zbHeroTable:getRecord(arg_12_1.Id)

	if var_12_1 then
		arg_12_0.heroType:setTexture(CCTextureCache:sharedTextureCache():addImage(zbIconHelper:getHeroTypeIconPath(var_12_1.heroType)))
		arg_12_0.heroType2:setTexture(CCTextureCache:sharedTextureCache():addImage(zbIconHelper:getHeroTypeIconPath(var_12_1.heroType)))
		arg_12_0.sprarity:setTexture(CCTextureCache:sharedTextureCache():addImage("image/herodetail/herodetail_rarity" .. var_12_1.rarity .. ".png"))
		arg_12_0.sprarity2:setTexture(CCTextureCache:sharedTextureCache():addImage("image/herodetail/herodetail_rarity" .. var_12_1.rarity .. ".png"))
		arg_12_0.lblviewName:setString(var_12_1.name)

		local var_12_2 = zbColor:getHeroNameColor(var_12_1.quality)

		arg_12_0.lblviewName:setColor(var_12_2)
		arg_12_0.location:setString(var_12_1.description0)

		local var_12_3 = zbIconHelper:getHeroCardIconPath(var_12_1.avatarId)

		arg_12_0.hero:setTexture(CCTextureCache:sharedTextureCache():addImage(var_12_3))

		for iter_12_0 = 1, 8 do
			arg_12_0.viewStars[iter_12_0]:setVisible(false)
		end

		local var_12_4 = var_12_1.star

		zbUIEffect:centerHeroStar(arg_12_0.viewStars, var_12_4, nil, false)

		local var_12_5, var_12_6 = zbHeroQualityTable:exchangeHeroQuality(var_12_1.quality)

		if arg_12_0.showScroll and var_12_5 > EHeroQuality.Blue then
			arg_12_0:sendScrollBroadcast(var_12_1)
		end
	end

	arg_12_0:createHeroViewEffect()

	for iter_12_1 = 2, 5 do
		local var_12_7 = tolua.cast(arg_12_0.nodeView:getChildByTag(iter_12_1), "CCNode")

		var_12_7:setPositionX(var_12_7:getPositionX() + 1136)
	end

	local function var_12_8()
		if var_12_1 then
			local var_14_0 = zbAvatarTable:getAvatarSoundPath(var_12_1.id, ESoundType.E_GET)

			g_Audio:playSound(var_14_0)
		end
	end

	local var_12_9 = CCScaleTo:create(0.15, 1.4)
	local var_12_10 = CCScaleTo:create(0.15, 0.9)
	local var_12_11 = CCScaleTo:create(0.3, 1.3)
	local var_12_12 = CCScaleTo:create(0.2, 1)
	local var_12_13 = CCCallFuncN:create(var_12_8)
	local var_12_14 = CCArray:create()

	var_12_14:addObject(var_12_9)
	var_12_14:addObject(var_12_10)
	var_12_14:addObject(var_12_11)
	var_12_14:addObject(var_12_12)
	var_12_14:addObject(CCDelayTime:create(1))
	var_12_14:addObject(var_12_13)

	local var_12_15 = CCSequence:create(var_12_14)

	arg_12_0.hero:stopAllActions()
	arg_12_0.hero:runAction(var_12_15)

	for iter_12_2 = 2, 5 do
		local var_12_16 = tolua.cast(arg_12_0.nodeView:getChildByTag(iter_12_2), "CCNode")
		local var_12_17 = CCMoveBy:create(0.5 + (iter_12_2 - 2) * 0.1, ccp(-1136, 0))

		if iter_12_2 == 5 then
			local var_12_18 = CCDelayTime:create(1)
			local var_12_19 = CCArray:create()

			var_12_19:addObject(var_12_17)
			var_12_19:addObject(var_12_18)
			var_12_19:addObject(CCCallFuncN:create(var_12_0))

			local var_12_20 = CCSequence:create(var_12_19)

			var_12_16:runAction(var_12_20)

			return
		end

		var_12_16:stopAllActions()
		var_12_16:runAction(var_12_17)
	end
end

function var_0_0.avartarScale(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_2 ~= nil then
		local var_15_0 = zbAvatarTable:getRecord(arg_15_2.avatarId)

		if var_15_0 ~= nil then
			local var_15_1 = math.min(250 / var_15_0.hudOffset.y, 1.2)

			arg_15_1:setScale(var_15_1)
		end
	end
end

function var_0_0.doSecondEffect(arg_16_0)
	arg_16_0.nodeView:setVisible(false)

	if arg_16_0.effect then
		arg_16_0.effect:playAnimationOnce("animation_01", "animation_02", 0.12)
	end

	arg_16_0:playUIEffect(arg_16_0.award)
end

function var_0_0.playUIEffect(arg_17_0, arg_17_1)
	arg_17_0.layer:setVisible(true)
	arg_17_0.layer:setPosition(arg_17_0.layerinitPos.x, arg_17_0.layerinitPos.y)
	arg_17_0.layer:setScale(0.1)
	arg_17_0.nodehero:setVisible(true)
	arg_17_0.nodefrag:setVisible(false)

	local var_17_0 = zbHeroTable:getRecord(arg_17_1.Id)

	if var_17_0 then
		arg_17_0.lbName:setString(var_17_0.name)

		local var_17_1 = zbColor:getHeroNameColor(var_17_0.quality)

		arg_17_0.lbName:setColor(var_17_1)
		arg_17_0.lbDesc:setString(var_17_0.description0)
		arg_17_0.heroAvatar:refreshHeroTemplateId(arg_17_1.Id)
		arg_17_0.heroAvatar:setAnimation(ANIMATION_SEQUENCE_IDLE, true)
		arg_17_0:avartarScale(arg_17_0.heroAvatar, var_17_0)
	end

	for iter_17_0 = 1, 8 do
		arg_17_0.spriteStars[iter_17_0]:setVisible(false)
	end

	local function var_17_2()
		local var_18_0 = var_17_0.star

		zbUIEffect:centerHeroStar(arg_17_0.spriteStars, var_18_0, nil, true)

		if arg_17_1.bHave then
			arg_17_0:convertToHeroFrags(arg_17_1.Id, var_18_0)
		else
			arg_17_0.actionEnd = true
		end
	end

	local var_17_3 = CCScaleTo:create(0.5, 0.8)
	local var_17_4 = CCRotateBy:create(0.5, 3600)
	local var_17_5 = CCSpawn:createWithTwoActions(var_17_3, var_17_4)
	local var_17_6 = CCScaleTo:create(0.1, 1.2)
	local var_17_7 = CCScaleTo:create(0.08, 1)
	local var_17_8 = CCDelayTime:create(1)
	local var_17_9 = CCCallFuncN:create(var_17_2)
	local var_17_10 = CCArray:create()

	var_17_10:addObject(var_17_6)
	var_17_10:addObject(var_17_7)
	var_17_10:addObject(var_17_8)
	var_17_10:addObject(var_17_9)

	local var_17_11 = CCSequence:create(var_17_10)

	arg_17_0.layer:stopAllActions()
	arg_17_0.layer:runAction(CCSequence:createWithTwoActions(var_17_5, var_17_11))
end

function var_0_0.convertToHeroFrags(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = zbHeroTable:getHeroStarRate(arg_19_1, arg_19_2)

	local function var_19_1()
		arg_19_0.nodehero:setVisible(false)
		arg_19_0.nodefrag:setVisible(true)

		arg_19_0.actionEnd = true
	end

	local var_19_2 = CCDelayTime:create(1)
	local var_19_3 = CCCallFunc:create(var_19_1)
	local var_19_4 = CCSequence:createWithTwoActions(var_19_2, var_19_3)

	arg_19_0.equipItemDummy:refreshAward(ECommonAwardType.HeroFrag, arg_19_1, var_19_0)
	arg_19_0:stopAllActions()
	arg_19_0:runAction(var_19_4)
end

function var_0_0.onTouchTest(arg_21_0)
	arg_21_0:onClose()
end

function var_0_0.onClose(arg_22_0)
	if arg_22_0.firstActionEnd and arg_22_0.secondActionDid == false then
		arg_22_0:doSecondEffect()

		arg_22_0.secondActionDid = true
	end

	if arg_22_0.actionEnd == false then
		return
	end

	arg_22_0:hide()
	arg_22_0:stopAllActions()

	if arg_22_0.backtendraw then
		g_MainScene:showPubGetTenWnd(g_Self.kPubHandler.AwardList)
	elseif g_MainScene.wndPub then
		g_MainScene.wndPub:setDrawNodeVisible(true)
	end

	if arg_22_0.customHideCallback ~= nil then
		arg_22_0.customHideCallback()

		g_Self.kPubHandler.callBack = nil
		g_Self.kHeroHandler.customHideCallback = nil
	end
end

function var_0_0.sendScrollBroadcast(arg_23_0, arg_23_1)
	local var_23_0 = zbColor:getItemColorHex(arg_23_1.quality)
	local var_23_1 = string.format("\xB9\xA7ϲ\xCD\xE6\xBC\xD2[color=0x00FF00]%s[/color]\xD4\xDAС\xBA\xDA\xCEݻ\xF1\xB5û\xEF\xB0\xE9[color=%s]%s[/color]\xA3\xA1\xCA\xD6\xC6\xF8\xB2\xBB\xB4\xED\xB0\xA1\xA3\xACŷ\xB0\xE6\xB5ģ\xA1", g_Self:getName(), var_23_0, arg_23_1.name)
	local var_23_2 = {
		ScrollType = EScrollNotifyType.BarHero
	}

	var_23_2.Priority = 1
	var_23_2.Repeat = 1
	var_23_2.Interval = 0
	var_23_2.SysChat = 0
	var_23_2.Content = var_23_1
	var_23_2.Tm = math.ceil(g_Self.kTimeHandler:getServerTime())

	g_Broadcast:refresh(var_23_2)
end
