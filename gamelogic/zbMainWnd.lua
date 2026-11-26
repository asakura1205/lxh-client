require("gamelogic.zbBaseWnd")
require("gamelogic.zbMainWnd_Info")
require("gamelogic.zbMainWnd_Shortcut")
require("gamelogic.zbMainWnd_Scene")
require("gamelogic.zbMainMenu")
require("gamelogic.zbTimeLabel")

zbMainWnd = class("zbMainWnd", zbBaseWnd)
zbMainWnd.__index = zbMainWnd

function zbMainWnd.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbMainWnd)

	return arg_1_0
end

function zbMainWnd.create(arg_2_0)
	local var_2_0 = zbMainWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function zbMainWnd.init(arg_3_0)
	local function var_3_0()
		return
	end

	local function var_3_1()
		local function var_5_0(arg_6_0, arg_6_1, arg_6_2)
			local var_6_0 = createUIAnimation()

			var_6_0:refreshBone(arg_6_1)
			var_6_0:setPosition(arg_6_2)
			arg_6_0:addChild(var_6_0)

			return var_6_0
		end

		local var_5_1 = CCBProxy:create()
		local var_5_2 = CCBReaderLoad("ccbi/main.ccbi", var_5_1, true, "HelloCocosBuilderLayerOwner")

		arg_3_0.uiLayer = tolua.cast(var_5_2, "CCLayer")
		arg_3_0.mapLayer = tolua.cast(arg_3_0.uiLayer:getChildByTag(10000), "CCNode")
		arg_3_0.headLayer = tolua.cast(arg_3_0.uiLayer:getChildByTag(102), "CCNode")

		local var_5_3 = tolua.cast(arg_3_0.headLayer:getChildByTag(88), "CCNode")

		arg_3_0.shortcutLayer = tolua.cast(arg_3_0.uiLayer:getChildByTag(5), "CCLayer")
		arg_3_0.mainMenuLayer = tolua.cast(arg_3_0.uiLayer:getChildByTag(2), "CCNode")

		local var_5_4 = tolua.cast(arg_3_0.mainMenuLayer:getChildByTag(88), "CCNode")

		arg_3_0.mainMenu = createMainMenu(arg_3_0, arg_3_0.mainMenuLayer)
		arg_3_0.mainScene = createMainWndScene(arg_3_0, arg_3_0.mapLayer)
		arg_3_0.mainInfo = createMainWndInfo(arg_3_0, arg_3_0.headLayer)
		arg_3_0.mainShortcut = createMainWndShortcut(arg_3_0, arg_3_0.shortcutLayer)
		arg_3_0.shortcutLayer_Pos = ccp(arg_3_0.shortcutLayer:getPosition())
		arg_3_0.effectMainBone = createUIAnimation()

		arg_3_0.effectMainBone:refreshBone("effect/spine/peijingxiaoguo/peijingxiaoguo")
		arg_3_0.effectMainBone:setPosition(0, 0)
		arg_3_0:addChild(arg_3_0.effectMainBone)

		arg_3_0.showMainDuration = arg_3_0.effectMainBone:getAnimDuration(UI_SEQUENCE_SHOW)
		arg_3_0.hideMainDuration = arg_3_0.effectMainBone:getAnimDuration(UI_SEQUENCE_HIDE)

		arg_3_0:addChild(arg_3_0.uiLayer)
		arg_3_0:addBtnChat(arg_3_0.uiLayer)

		local function var_5_5(arg_7_0, arg_7_1, arg_7_2)
			local var_7_0 = createUIAnimation()

			var_7_0:refreshBone(arg_7_1)
			var_7_0:setPosition(arg_7_2)
			arg_7_0:addChild(var_7_0)

			return var_7_0
		end

		arg_3_0.fxYunTopLeft = var_5_5(var_5_3, "effect/spine/ui_main/zuoshangjiao/zuoshangjiao", ccp(0, 0))
		arg_3_0.fxYunBottomLeft = var_5_5(var_5_4, "effect/spine/ui_main/zuoxiajiao/zuoxiajiao", ccp(0, 0))
		arg_3_0.fxYunBottomRight = var_5_5(var_5_4, "effect/spine/ui_main/youxiajiao/youxiajiao", ccp(0, 0))

		arg_3_0.fxYunTopLeft:setAnimation("animation", true)
		arg_3_0.fxYunBottomLeft:setAnimation("animation", true)
		arg_3_0.fxYunBottomRight:setAnimation("animation", true)
		arg_3_0:createMoneyPanel(var_5_2, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold,
			EMoneyPanelResType.Food,
			EMoneyPanelResType.Tili
		})
	end

	var_3_0()
	var_3_1()
	zbGlobalUtil:GameCallSDKFunction("hideNavigation", "", "")
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0.mainInfo:refresh()
	end, zbGameEvent.Event_Update_BaseInfo)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0.mainInfo:refresh()
	end, zbGameEvent.Event_Update_Formation)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0.mainInfo:refresh()
	end, zbGameEvent.Event_Activity_Ack)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0.mainShortcut:refresh()
	end, zbGameEvent.Event_Activity_Ack)
end

function zbMainWnd.onFrameUpdate(arg_12_0, arg_12_1)
	arg_12_0.mainMenu:onFrameUpdate(arg_12_1)
	arg_12_0.mainScene:onFrameUpdate(arg_12_1)
	arg_12_0.mainShortcut:onFrameUpdate(arg_12_1)
	arg_12_0.mainInfo:onFrameUpdate(arg_12_1)
	arg_12_0:updateMainBackEffect()
end

function zbMainWnd.isTouchOnUI(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_0.mainMenu:isContained(arg_13_1, arg_13_2) then
		return true
	end

	if arg_13_0.mainInfo:isContained(arg_13_1, arg_13_2) then
		return true
	end

	if arg_13_0.mainShortcut:isContained(arg_13_1, arg_13_2) then
		return true
	end

	if arg_13_0.moneyPanel:isInPanel(arg_13_1, arg_13_2) then
		return true
	end

	return false
end

function zbMainWnd.onHideAll(arg_14_0)
	arg_14_0:onDark(false, false)
end

function zbMainWnd.onOnlyDark(arg_15_0)
	arg_15_0:onDark(true, true)
end

function zbMainWnd.onDark(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0.headLayer:setVisible(arg_16_1)
	arg_16_0.moneyPanel.node:setVisible(arg_16_2)
	arg_16_0.shortcutLayer:setVisible(false)
	arg_16_0.btnChat:setVisible(false)
	arg_16_0.mainMenu:popdown()
end

function zbMainWnd.onLight(arg_17_0)
	arg_17_0.headLayer:setVisible(true)
	arg_17_0.moneyPanel.node:setVisible(true)
	arg_17_0.shortcutLayer:setVisible(true)
	arg_17_0.btnChat:setVisible(true)
	arg_17_0.mainMenu:popup()
end

function zbMainWnd.onEffectLight(arg_18_0)
	arg_18_0:onLight()

	local var_18_0 = 0.915

	arg_18_0.effectMainBone:setAnimation(UI_SEQUENCE_SHOW, false, var_18_0)

	local var_18_1 = CCArray:create()

	var_18_1:addObject(CCFadeTo:create(arg_18_0.showMainDuration / var_18_0 / 2, 255))
	var_18_1:addObject(CCCallFuncN:create(function()
		arg_18_0:enableTouch()
	end))
	var_18_1:addObject(CCDelayTime:create(arg_18_0.showMainDuration / var_18_0 / 2 + 1))

	local var_18_2 = CCSequence:create(var_18_1)

	arg_18_0.bg0:setOpacity(20)
	arg_18_0.bg0:stopAllActions()
	arg_18_0.bg0:runAction(var_18_2)
end

function zbMainWnd.updateMainBackEffect(arg_20_0)
	if arg_20_0:isFading() == false then
		return
	end

	arg_20_0:refreshMainBackEffect(arg_20_0.tabBaseLayer, arg_20_0.layerTab_Pos, BONES_SEQUENCE_TAB)
	arg_20_0:refreshMainBackEffect(arg_20_0.spriteBaseTitle, arg_20_0.spriteBaseTitle_Pos, BONES_SEQUENCE_TITLE)
	arg_20_0:refreshMainBackEffect(arg_20_0.spriteBaseSubTitle, arg_20_0.spriteBaseSubTitle_Pos, BONES_SEQUENCE_SUBTITLE)
	arg_20_0:refreshMainBackEffect(arg_20_0.spriteBaseSubTitle2, arg_20_0.spriteBaseSubTitle2_Pos, BONES_SEQUENCE_CLOSE)
	arg_20_0:refreshMainBackEffect(arg_20_0.moneyPanel.layer, arg_20_0.moneyPanel.layer_Pos, BONES_SEQUENCE_MONEYPANEL)
	arg_20_0:refreshMainBackEffect(arg_20_0.fxYunTopLeft, nil, BONES_SEQUENCE_ZUOUP)
	arg_20_0:refreshMainBackEffect(arg_20_0.fxYunBottomLeft, nil, BONES_SEQUENCE_ZUODW)
	arg_20_0:refreshMainBackEffect(arg_20_0.fxYunBottomRight, nil, BONES_SEQUENCE_YOU)
	arg_20_0:refreshMainBackEffect(arg_20_0.shortcutLayer, arg_20_0.shortcutLayer_Pos, BONES_SEQUENCE_YOU)
end

function zbMainWnd.refreshMainBackEffect(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	if arg_21_1 == nil then
		return
	end

	local var_21_0 = arg_21_0.effectMainBone.skeleton:findBone(arg_21_3)

	if var_21_0 ~= nil then
		if arg_21_2 == nil then
			arg_21_1:setPosition(spBone_getWorldX(var_21_0), spBone_getWorldY(var_21_0))
		else
			arg_21_1:setPosition(arg_21_2.x + spBone_getWorldX(var_21_0), arg_21_2.y + spBone_getWorldY(var_21_0))
		end
	end
end
