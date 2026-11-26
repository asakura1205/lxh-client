require("gamelogic.zbMoneyPanel")
require("gamelogic.zbBaseWndHelper")

zbBaseWnd = class("zbBaseWnd", CCNodeExtend)
zbBaseWnd.__index = zbBaseWnd
UI_FADE_SPEED = 1
UI_SEQUENCE_SHOW = "animation_01"
UI_SEQUENCE_HIDE = "animation_02"

function zbBaseWnd.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbBaseWnd)

	return arg_1_0
end

function zbBaseWnd.initBase(arg_2_0)
	arg_2_0.moneyPanel = nil
	arg_2_0.gameEventList = {}
	arg_2_0.modelLayer = nil
	arg_2_0.isShow = false
	arg_2_0.prevWnd = nil
	arg_2_0.bNeedsMutableSet = true
	arg_2_0.showCB = nil
	arg_2_0.isShowAniming = false
	arg_2_0.isHideAniming = false
	arg_2_0.isHiding = false
	arg_2_0.fadeFrame = 0
	arg_2_0.fxFadeInBone = nil
	arg_2_0.fxFadeOutBone = nil
	arg_2_0.isWindow = true

	insertMainSceneWin(arg_2_0)
end

function zbBaseWnd.createMoneyPanel(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	arg_3_0:readYunEffect(arg_3_1)
	arg_3_0:readBackEffectNode(arg_3_1)

	if zbUtil:isValidTable(arg_3_2) then
		arg_3_0.moneyPanel = createMoneyPanel(arg_3_0, arg_3_2, arg_3_3, arg_3_4, arg_3_5)

		arg_3_1:addChild(arg_3_0.moneyPanel.node)
	else
		echo("warning: invalid initMoneyPanel param")
	end
end

function zbBaseWnd.registerEvent(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_1 == nil or arg_4_2 == nil or arg_4_3 == nil then
		echo("warning: invalid registerEvent param ---------------------------------")

		return
	end

	g_GameEventMgr:registerEvent(arg_4_1, arg_4_2, arg_4_3)

	local var_4_0 = {
		node = arg_4_1,
		eventFunction = arg_4_2,
		eventId = arg_4_3
	}

	table.insert(arg_4_0.gameEventList, var_4_0)
end

function zbBaseWnd.freeRegisterEvent(arg_5_0)
	if arg_5_0.gameEventList == nil then
		echo("warning: invalid gameEventList")

		return
	end

	for iter_5_0, iter_5_1 in pairs(arg_5_0.gameEventList) do
		g_GameEventMgr:unregisterEvent(iter_5_1.node, iter_5_1.eventId)
	end
end

function zbBaseWnd.setWinType(arg_6_0, arg_6_1)
	local function var_6_0()
		local var_7_0 = CCEGLView:sharedOpenGLView():getFrameSize()
		local var_7_1 = CCLayerColor:create(ccc4(0, 0, 0, 160))

		var_7_1:setContentSize(var_7_0)
		var_7_1:setAnchorPoint(ccp(0, 0))
		arg_6_0:addChild(var_7_1)
	end

	arg_6_0.winType = arg_6_1

	if arg_6_1 == EWinType.Pop_HideAll or arg_6_1 == EWinType.Pop_Has_MoneyPanel or arg_6_1 == EWinType.Pop_Has_MoneyPanel_HeadPanel or arg_6_1 == EWinType.Pop_OnlyDark or arg_6_1 == EWinType.Pop_OnlyDark_NoHide then
		var_6_0()
	end
end

function zbBaseWnd.getWinType(arg_8_0)
	return arg_8_0.winType
end

function zbBaseWnd.setModel(arg_9_0)
	if arg_9_0.modelLayer == nil then
		arg_9_0:removeFromParentAndCleanup(false)

		arg_9_0.modelLayer = CCLayerModel:create()

		arg_9_0.modelLayer:setNeedsMutableSet(arg_9_0.bNeedsMutableSet)
		arg_9_0.modelLayer:bindChild(arg_9_0)
		arg_9_0.modelLayer:retain()
	end
end

function zbBaseWnd.setNeedsMutableSet(arg_10_0, arg_10_1)
	arg_10_0.bNeedsMutableSet = arg_10_1
end

function zbBaseWnd.show(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.isShowAniming = false
	arg_11_0.isHideAniming = false

	arg_11_0:setVisible(true)

	if arg_11_0.isShow then
		return
	end

	if arg_11_0.modelLayer ~= nil then
		arg_11_0.modelLayer:removeFromParentAndCleanup(false)
		arg_11_0.modelLayer:doModel(arg_11_1)
		arg_11_0:setNormalWnd(false)
		arg_11_0:setModelWnd(true)
	else
		arg_11_0:removeFromParentAndCleanup(false)
		arg_11_1:addChild(arg_11_0)
		arg_11_0:setNormalWnd(true)
		arg_11_0:setModelWnd(false)
	end

	arg_11_0.isShow = true

	arg_11_0:setCascadeOpacityEnabled(true)

	if g_MainScene then
		insertVisWin(arg_11_0)
		g_MainScene:notifyWndShow(arg_11_0)
	end

	if arg_11_0.showCB ~= nil then
		arg_11_0.showCB()
	end

	if arg_11_0.bg0 ~= nil and arg_11_2 ~= nil and arg_11_2 == true then
		arg_11_0.isShowAniming = true
		arg_11_0.isHideAniming = false

		arg_11_0:confirmBackEffect()
		arg_11_0.fxFadeInBone:setVisible(true)
		arg_11_0.fxFadeOutBone:setVisible(false)

		local var_11_0 = CCArray:create()

		var_11_0:addObject(CCDelayTime:create(1000))

		local var_11_1 = CCSequence:create(var_11_0)

		arg_11_0.bg0:stopAllActions()
		arg_11_0.bg0:runAction(var_11_1)

		arg_11_0.fadeFrame = 0

		arg_11_0:setPosition(100000, 100000)
		arg_11_0:disableTouch()
	elseif g_MainScene ~= nil and g_MainScene.wndGuide ~= nil then
		g_MainScene.wndGuide:onWndFadeOver(arg_11_0)
	end
end

function zbBaseWnd.hide(arg_12_0, arg_12_1)
	if arg_12_1 == nil then
		arg_12_1 = true
	end

	arg_12_0.isShowAniming = false
	arg_12_0.isHideAniming = false

	if arg_12_0.prevWnd ~= nil then
		arg_12_0.prevWnd:setVisible(true)

		arg_12_0.prevWnd = nil
	end

	local function var_12_0()
		if arg_12_0.modelLayer ~= nil then
			arg_12_0.modelLayer:exitModel()
		else
			arg_12_0:removeFromParentAndCleanup(false)
		end

		arg_12_0.isShow = false

		if arg_12_0.hideCB ~= nil then
			arg_12_0.hideCB()
		end

		if g_MainScene then
			removeVisWin(arg_12_0)
			g_MainScene:notifyWndHide(arg_12_0)
		end

		arg_12_0.isHiding = false
	end

	if arg_12_0.fxFadeInBone ~= nil and arg_12_1 then
		arg_12_0.isShowAniming = false
		arg_12_0.isHideAniming = true

		if arg_12_0.isHiding == false then
			arg_12_0.isHiding = true

			arg_12_0.fxFadeInBone:setVisible(false)
			arg_12_0.fxFadeOutBone:setVisible(true)
			arg_12_0.fxFadeOutBone:setAnimation(UI_SEQUENCE_HIDE, false, UI_FADE_SPEED)
			arg_12_0.fxFadeOutBone:setStartTime(0.03333333333333333)

			local var_12_1 = CCArray:create()

			var_12_1:addObject(CCCallFuncN:create(function()
				g_MainScene.wndMain:onEffectLight()
			end))
			var_12_1:addObject(CCFadeTo:create(arg_12_0.hideAnimDuration / UI_FADE_SPEED / 2, 20))
			var_12_1:addObject(CCCallFuncN:create(function()
				arg_12_0:enableTouch()
			end))
			var_12_1:addObject(CCDelayTime:create(arg_12_0.hideAnimDuration / UI_FADE_SPEED / 2))
			var_12_1:addObject(CCCallFuncN:create(var_12_0))

			local var_12_2 = CCSequence:create(var_12_1)

			arg_12_0.bg0:stopAllActions()
			arg_12_0.bg0:runAction(var_12_2)
			arg_12_0:updateBackEffect()
			arg_12_0:disableTouch()
		end
	else
		var_12_0()
	end
end

function zbBaseWnd.setShowCallback(arg_16_0, arg_16_1)
	arg_16_0.showCB = arg_16_1
end

function zbBaseWnd.setHideCallback(arg_17_0, arg_17_1)
	arg_17_0.hideCB = arg_17_1
end

function zbBaseWnd.setPrevWnd(arg_18_0, arg_18_1)
	if arg_18_1 ~= nil then
		arg_18_0.prevWnd = arg_18_1

		arg_18_0.prevWnd:setVisible(false)
	else
		arg_18_0.prevWnd = nil
	end
end

function zbBaseWnd.freeDestroy(arg_19_0)
	removeMainSceneWin(arg_19_0)
	arg_19_0:freeRegisterEvent()
	arg_19_0:doDestroy()

	arg_19_0.showCB = nil
	arg_19_0.prevWnd = nil
	arg_19_0.hideCB = nil

	if arg_19_0.modelLayer == nil then
		arg_19_0:removeFromParentAndCleanup(true)
	else
		arg_19_0.modelLayer:exitModel()
		arg_19_0:removeFromParentAndCleanup(true)
		arg_19_0.modelLayer:release()
	end

	removeVisWin(arg_19_0)
end

function zbBaseWnd.doDestroy(arg_20_0)
	return
end

function zbBaseWnd.addBtnChat(arg_21_0, arg_21_1, arg_21_2)
	local function var_21_0(arg_22_0)
		local var_22_0 = CCSprite:create(NOTIFY_TAG_PATH)

		var_22_0:setPosition(60, 70)
		var_22_0:setVisible(false)
		arg_22_0:addChild(var_22_0)
		zbUIEffect:createNotifyTagScaleAction(var_22_0)

		return var_22_0
	end

	arg_21_0.btnChat = ui:createButton("image/main/mm_chat_normal.png", "image/main/mm_chat_normal.png")
	arg_21_0.btnChat.notifyChat = var_21_0(arg_21_0.btnChat)

	arg_21_0.btnChat:addHandleOfControlEvent(function()
		g_Self.kChatHandler.notifyChat = false

		if zbFunHelper:isLockAndTip(EFuncType.Chat) then
			return
		end

		g_MainScene:showChat()
		arg_21_0.btnChat.notifyChat:setVisible(false)
	end, CCControlEventTouchUpInside)
	arg_21_0.btnChat:setAnchorPoint(ccp(0, 0))
	arg_21_0.btnChat:setPosition(0, 180)
	arg_21_0.btnChat:setPreferredSize(CCSizeMake(80, 80))
	arg_21_1:addChild(arg_21_0.btnChat)

	if arg_21_2 ~= nil then
		arg_21_0.btnChat:setPosition(arg_21_2)
	end
end

function zbBaseWnd.confirmBackEffect(arg_24_0)
	if arg_24_0.fxFadeInBone ~= nil then
		return
	end

	arg_24_0.fxFadeInBone = createUIAnimation()

	arg_24_0.fxFadeInBone:refreshBone("effect/spine/peijingxiaoguo/peijingxiaoguo")
	arg_24_0.fxFadeInBone:setPosition(0, 0)
	arg_24_0:addChild(arg_24_0.fxFadeInBone)

	arg_24_0.fxFadeOutBone = createUIAnimation()

	arg_24_0.fxFadeOutBone:refreshBone("effect/spine/peijingxiaoguo/peijingxiaoguo")
	arg_24_0.fxFadeOutBone:setPosition(0, 0)
	arg_24_0:addChild(arg_24_0.fxFadeOutBone)

	arg_24_0.showAnimDuration = arg_24_0.fxFadeInBone:getAnimDuration(UI_SEQUENCE_SHOW)
	arg_24_0.hideAnimDuration = arg_24_0.fxFadeInBone:getAnimDuration(UI_SEQUENCE_HIDE)
end

function zbBaseWnd.readYunEffect(arg_25_0, arg_25_1)
	local var_25_0 = tolua.cast(arg_25_1:getChildByTag(88), "CCNode")

	if var_25_0 == nil then
		return
	end

	local function var_25_1(arg_26_0, arg_26_1, arg_26_2)
		local var_26_0 = createUIAnimation()

		var_26_0:refreshBone(arg_26_1)
		var_26_0:setPosition(arg_26_2)
		arg_26_0:addChild(var_26_0)

		return var_26_0
	end

	arg_25_0.fxYunTopLeft = var_25_1(var_25_0, "effect/spine/ui_main/zuoshangjiao/zuoshangjiao", ccp(0, 0))
	arg_25_0.fxYunBottomLeft = var_25_1(var_25_0, "effect/spine/ui_main/zuoxiajiao/zuoxiajiao", ccp(0, 0))
	arg_25_0.fxYunBottomRight = var_25_1(var_25_0, "effect/spine/ui_main/youxiajiao/youxiajiao", ccp(0, 0))

	arg_25_0.fxYunTopLeft:setAnimation("animation", true)
	arg_25_0.fxYunBottomLeft:setAnimation("animation", true)
	arg_25_0.fxYunBottomRight:setAnimation("animation", true)
end

function zbBaseWnd.refreshBackEffect(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	if arg_27_1 == nil then
		return
	end

	if arg_27_0.fxFadeInBone == nil then
		return
	end

	local var_27_0

	if arg_27_0.fxFadeInBone:isVisible() then
		var_27_0 = arg_27_0.fxFadeInBone
	elseif arg_27_0.fxFadeOutBone:isVisible() then
		var_27_0 = arg_27_0.fxFadeOutBone
	end

	if var_27_0 == nil then
		return
	end

	local var_27_1 = var_27_0.skeleton:findBone(arg_27_3)

	if var_27_1 ~= nil then
		if arg_27_2 == nil then
			arg_27_1:setPosition(spBone_getWorldX(var_27_1), spBone_getWorldY(var_27_1))
		else
			arg_27_1:setPosition(arg_27_2.x + spBone_getWorldX(var_27_1), arg_27_2.y + spBone_getWorldY(var_27_1))
		end
	end
end

function zbBaseWnd.enableTouch(arg_28_0)
	CCDirector:sharedDirector():getTouchDispatcher():setDispatchEvents(true)
end

function zbBaseWnd.disableTouch(arg_29_0)
	CCDirector:sharedDirector():getTouchDispatcher():setDispatchEvents(false)
end

function zbBaseWnd.updateBackEffect(arg_30_0)
	if arg_30_0:isFading() == false then
		return
	end

	if arg_30_0.isShowAniming == false and arg_30_0.isHideAniming == false then
		return
	end

	arg_30_0.fadeFrame = arg_30_0.fadeFrame + 1

	if arg_30_0.fadeFrame == 5 and arg_30_0.fxFadeInBone ~= nil and arg_30_0.fxFadeInBone:isVisible() then
		arg_30_0:setPosition(0, 0)
		arg_30_0.fxFadeInBone:setAnimation(UI_SEQUENCE_SHOW, false, UI_FADE_SPEED)
		arg_30_0.fxFadeInBone:setStartTime(0.03333333333333333)
		arg_30_0:updateBackEffect()

		local var_30_0 = CCArray:create()

		var_30_0:addObject(CCFadeTo:create(arg_30_0.showAnimDuration / UI_FADE_SPEED / 2, 255))
		var_30_0:addObject(CCCallFuncN:create(function()
			if g_MainScene.wndGuide ~= nil then
				g_MainScene.wndGuide:onWndFadeOver(arg_30_0)
			end
		end))
		var_30_0:addObject(CCCallFuncN:create(function()
			arg_30_0:enableTouch()
		end))
		var_30_0:addObject(CCDelayTime:create(arg_30_0.showAnimDuration / UI_FADE_SPEED / 2 + 1))

		local var_30_1 = CCSequence:create(var_30_0)

		arg_30_0.bg0:setOpacity(20)
		arg_30_0.bg0:stopAllActions()
		arg_30_0.bg0:runAction(var_30_1)
		g_MainScene.wndMain:onHideAll()
	end

	arg_30_0:refreshBackEffect(arg_30_0.mainBaselayer, arg_30_0.layerBase_Pos, BONES_SEQUENCE_SMBG)
	arg_30_0:refreshBackEffect(arg_30_0.tabBaseLayer, arg_30_0.layerTab_Pos, BONES_SEQUENCE_TAB)
	arg_30_0:refreshBackEffect(arg_30_0.spriteBaseTitle, arg_30_0.spriteBaseTitle_Pos, BONES_SEQUENCE_TITLE)
	arg_30_0:refreshBackEffect(arg_30_0.spriteBaseSubTitle, arg_30_0.spriteBaseSubTitle_Pos, BONES_SEQUENCE_SUBTITLE)
	arg_30_0:refreshBackEffect(arg_30_0.spriteBaseSubTitle2, arg_30_0.spriteBaseSubTitle2_Pos, BONES_SEQUENCE_CLOSE)
	arg_30_0:refreshBackEffect(arg_30_0.moneyPanel.layer, arg_30_0.moneyPanel.layer_Pos, BONES_SEQUENCE_MONEYPANEL)
	arg_30_0:refreshBackEffect(arg_30_0.fxYunTopLeft, nil, BONES_SEQUENCE_ZUOUP)
	arg_30_0:refreshBackEffect(arg_30_0.fxYunBottomLeft, nil, BONES_SEQUENCE_ZUODW)
	arg_30_0:refreshBackEffect(arg_30_0.fxYunBottomRight, nil, BONES_SEQUENCE_YOU)
end

function zbBaseWnd.readBackEffectNode(arg_33_0, arg_33_1)
	arg_33_0.mainBaselayer = tolua.cast(arg_33_1:getChildByTag(1), "CCNode")
	arg_33_0.tabBaseLayer = tolua.cast(arg_33_1:getChildByTag(2), "CCNode")
	arg_33_0.bg0 = tolua.cast(arg_33_1:getChildByTag(100), "CCSprite")
	arg_33_0.spriteBaseTitle = tolua.cast(arg_33_1:getChildByTag(102), "CCSprite")
	arg_33_0.spriteBaseSubTitle = tolua.cast(arg_33_1:getChildByTag(103), "CCSprite")
	arg_33_0.spriteBaseSubTitle2 = tolua.cast(arg_33_1:getChildByTag(104), "CCSprite")

	if arg_33_0.mainBaselayer then
		arg_33_0.layerBase_Pos = ccp(arg_33_0.mainBaselayer:getPosition())
	end

	if arg_33_0.tabBaseLayer then
		arg_33_0.layerTab_Pos = ccp(arg_33_0.tabBaseLayer:getPosition())
	end

	if arg_33_0.spriteBaseTitle then
		arg_33_0.spriteBaseTitle_Pos = ccp(arg_33_0.spriteBaseTitle:getPosition())
	end

	if arg_33_0.spriteBaseSubTitle then
		arg_33_0.spriteBaseSubTitle_Pos = ccp(arg_33_0.spriteBaseSubTitle:getPosition())
	end

	if arg_33_0.spriteBaseSubTitle2 then
		arg_33_0.spriteBaseSubTitle2_Pos = ccp(arg_33_0.spriteBaseSubTitle2:getPosition())
	end
end

function zbBaseWnd.isFading(arg_34_0)
	return arg_34_0.bg0 ~= nil and arg_34_0.bg0:numberOfRunningActions() > 0
end
