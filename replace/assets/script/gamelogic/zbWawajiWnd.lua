require("gamelogic.zbBaseWnd")
require("gamelogic.zbWawajiItem")
require("gamelogic.zbTimeLabel")

local var_0_0 = 400

zbWawajiWnd = class("zbWawajiWnd", zbBaseWnd)
zbWawajiWnd.__index = zbWawajiWnd

function zbWawajiWnd.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbWawajiWnd)

	return arg_1_0
end

local var_0_1 = 3

function createWawajiWnd(arg_2_0)
	local var_2_0 = zbWawajiWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init(arg_2_0)

	return var_2_0
end

function zbWawajiWnd.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.yaoganMove = 0
		arg_3_0.nodeItem = {}
		arg_3_0.beginZhua = false
		arg_3_0.zhuaqiIndex = 0
		arg_3_0.resultComeBack = 0
		arg_3_0.countdown = 0
		arg_3_0.timeStop = false
	end

	local function var_3_1()
		local function var_5_0()
			local var_6_0 = createUIPoolAnimation()

			var_6_0:setAnchorPoint(ccp(0.5, 0))
			var_6_0:setScale(0.8)

			return var_6_0
		end

		local var_5_1 = CCBProxy:create()
		local var_5_2 = CCBReaderLoad("ccbi/wawaji.ccbi", var_5_1, true, "HelloCocosBuilderLayerOwner")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCNode")

		arg_3_0.layer = var_5_3
		arg_3_0.nodeYaogan = tolua.cast(var_5_3:getChildByTag(1), "CCNode")
		arg_3_0.spriteLeft = tolua.cast(arg_3_0.nodeYaogan:getChildByTag(2), "CCSprite")
		arg_3_0.spriteRight = tolua.cast(arg_3_0.nodeYaogan:getChildByTag(3), "CCSprite")
		arg_3_0.btnYaogan = tolua.cast(arg_3_0.nodeYaogan:getChildByTag(4), "CCControlButton")

		zbUIEffect:runFadeToAction(arg_3_0.spriteLeft)
		zbUIEffect:runFadeToAction(arg_3_0.spriteRight)

		arg_3_0.nodeItems = tolua.cast(var_5_3:getChildByTag(2), "CCNode")
		arg_3_0.nodeZhuazi = tolua.cast(arg_3_0.nodeItems:getChildByTag(100), "CCNode")
		arg_3_0.pointZhuazi = ccp(arg_3_0.nodeZhuazi:getPosition())
		arg_3_0.intPointZhuazi = arg_3_0.pointZhuazi

		for iter_5_0 = 1, 10 do
			arg_3_0.nodeItem[iter_5_0] = createWawajiItem(arg_3_0.nodeItems:getChildByTag(iter_5_0), iter_5_0)
		end

		arg_3_0.btnBegin = tolua.cast(var_5_3:getChildByTag(3), "CCControlButton")
		arg_3_0.nodeChuanSong = tolua.cast(var_5_3:getChildByTag(4), "CCNode")
		arg_3_0.pointChuanSong = ccp(arg_3_0.nodeChuanSong:getPosition())
		arg_3_0.nodeInput = tolua.cast(var_5_3:getChildByTag(5), "CCNode")
		arg_3_0.spriteMoney = tolua.cast(arg_3_0.nodeInput:getChildByTag(1), "CCSprite")

		local var_5_4 = tolua.cast(arg_3_0.spriteMoney:getChildByTag(1001), "CCLabelTTF")

		arg_3_0.lbNeedMoney = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_4, arg_3_0.lbNeedMoney)
		arg_3_0.lbNeedMoney:setScale(0.65)
		arg_3_0.lbNeedMoney:setString("X" .. 1)

		arg_3_0.spritePlease = tolua.cast(arg_3_0.nodeInput:getChildByTag(2), "CCSprite")
		arg_3_0.btnInput = tolua.cast(arg_3_0.nodeInput:getChildByTag(3), "CCControlButton")

		zbUIEffect:createNotifyTagScaleAction(arg_3_0.btnInput)

		arg_3_0.nodeTime = tolua.cast(var_5_3:getChildByTag(6), "CCNode")
		arg_3_0.lbTimeDummy = tolua.cast(arg_3_0.nodeTime:getChildByTag(1), "CCLabelTTF")

		arg_3_0.btnYaogan:addHandleOfControlEvent(function()
			arg_3_0:onYaogan()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnYaogan:addHandleOfControlEvent(function()
			arg_3_0:onYaoganDown()
		end, CCControlEventTouchDown)
		arg_3_0.btnYaogan:addHandleOfControlEvent(function()
			arg_3_0:onYaoganMove()
		end, CCControlEventTouchMove)
		arg_3_0.btnYaogan:addHandleOfControlEvent(function()
			arg_3_0:onYaoganEnd()
		end, CCControlEventTouchEnd)
		arg_3_0.btnInput:addHandleOfControlEvent(function()
			arg_3_0:onInput()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnBegin:addHandleOfControlEvent(function()
			arg_3_0:onBegin()
		end, CCControlEventTouchUpInside)

		local function var_5_5(arg_13_0)
			local var_13_0 = createUIAnimation()

			var_13_0:refresh(arg_13_0 .. ".json", arg_13_0 .. ".atlas")
			var_13_0:setAnchorPoint(ccp(0.5, 0))
			var_13_0:setZOrder(ZORDER_BOTTOM)
			var_13_0:setScale(1)

			return var_13_0
		end

		arg_3_0.zhuaziEffct = var_5_5("effect/spine/zhuashou/zhuashou")
		arg_3_0.yaoganEffct = var_5_5("effect/spine/yaogan/yaogan")

		arg_3_0.zhuaziEffct:setPosition(0, 0)
		arg_3_0.yaoganEffct:setPosition(0, 20)
		arg_3_0.nodeZhuazi:addChild(arg_3_0.zhuaziEffct, 0)
		arg_3_0.nodeYaogan:addChild(arg_3_0.yaoganEffct, 0)

		arg_3_0.heroAvatar = var_5_0()

		arg_3_0.nodeZhuazi:addChild(arg_3_0.heroAvatar)

		arg_3_0.layerCry = tolua.cast(var_5_2:getChildByTag(2), "CCNode")

		arg_3_0.layerCry:setVisible(false)
		arg_3_0:addChild(var_5_2)
		arg_3_0:createMoneyPanel(var_5_2, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.DollsMoney
		}, function()
			arg_3_0:hide()
		end)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refreshGrab()
	end, zbGameEvent.Event_Dolls_GrabAck)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refreshInput()
	end, zbGameEvent.Event_Dolls_PutCoinAck)
end

function zbWawajiWnd.doDestroy(arg_17_0)
	for iter_17_0 = 1, 10 do
		arg_17_0.nodeItem[iter_17_0]:free()
	end

	if arg_17_0.heroAvatar then
		arg_17_0.heroAvatar:free()
	end
end

function zbWawajiWnd.resetWawaji(arg_18_0)
	arg_18_0:refresh()
end

function zbWawajiWnd.refresh(arg_19_0)
	g_Self.kRedPointHandler.wawajiState = false

	g_Self.kRedPointHandler:refreshHeroTrial()

	arg_19_0.resultComeBack = 0

	arg_19_0.nodeZhuazi:setPosition(arg_19_0.intPointZhuazi)

	arg_19_0.pointZhuazi = arg_19_0.intPointZhuazi

	for iter_19_0, iter_19_1 in pairs(arg_19_0.nodeItem) do
		iter_19_1.ccNode:setVisible(true)
	end

	arg_19_0.zhuaziEffct:setAnimation("animation", true)
	arg_19_0.heroAvatar:setVisible(false)
	arg_19_0.btnYaogan:setEnabled(true)
	arg_19_0.spriteLeft:setVisible(false)
	arg_19_0.spriteRight:setVisible(false)
	arg_19_0.btnYaogan:setVisible(false)
	arg_19_0.yaoganEffct:setGray(true)

	for iter_19_2, iter_19_3 in pairs(g_Self.kHeroTrialHandler.DollsList) do
		if iter_19_2 < 11 then
			arg_19_0.nodeItem[iter_19_2]:refresh(iter_19_3)
		end
	end

	if g_Self.kHeroTrialHandler.DollsInfo.PutCoinTm + 30 > g_Self.kTimeHandler:getServerTime() then
		arg_19_0:refreshInput()
	else
		arg_19_0.nodeInput:setVisible(true)
		arg_19_0.nodeTime:setVisible(false)
		zbUtil:setBtnEnable(arg_19_0.btnBegin, false)
	end

	arg_19_0.timeStop = false

	arg_19_0.layerCry:setVisible(false)
end

function zbWawajiWnd.refreshInput(arg_20_0)
	g_Audio:playSound("audio/sound/ui_toubi.mp3")
	g_Audio:playSound("audio/sound/ui_wawajikaishi.mp3")
	arg_20_0.nodeInput:setVisible(false)
	arg_20_0.nodeTime:setVisible(true)
	zbUtil:setBtnEnable(arg_20_0.btnBegin, true)
	arg_20_0.spriteLeft:setVisible(true)
	arg_20_0.spriteRight:setVisible(true)
	arg_20_0.yaoganEffct:setAnimation("animation1", false)
	arg_20_0.btnYaogan:setVisible(true)
	arg_20_0.yaoganEffct:setGray(false)

	local var_20_0 = g_Self.kHeroTrialHandler.DollsInfo.PutCoinTm + 30 - g_Self.kTimeHandler:getServerTime()

	if var_20_0 > 30 then
		var_20_0 = 30
	end

	arg_20_0.startCdTime = os_timenow()
	arg_20_0.countdown = var_20_0
	arg_20_0.startCountdown = var_20_0
end

function zbWawajiWnd.refreshGrab(arg_21_0)
	arg_21_0.resultComeBack = arg_21_0.resultComeBack + 1

	if arg_21_0.resultComeBack == 2 then
		if g_Self.kHeroTrialHandler.DollsGrabResult ~= 1 then
			local var_21_0 = CCArray:create()

			var_21_0:addObject(CCDelayTime:create(1))
			var_21_0:addObject(CCMoveTo:create(1, ccp(10, -400)))
			var_21_0:addObject(CCCallFuncN:create(function()
				arg_21_0.heroAvatar:setVisible(false)
			end))
			var_21_0:addObject(CCDelayTime:create(2))
			var_21_0:addObject(CCCallFuncN:create(function()
				arg_21_0.layerCry:setVisible(true)
			end))

			local var_21_1 = CCSequence:create(var_21_0)

			arg_21_0.heroAvatar:stopAllActions()
			arg_21_0.heroAvatar:runAction(var_21_1)
		end

		local var_21_2 = CCArray:create()

		if arg_21_0.pointZhuazi.x > 568 then
			var_21_2:addObject(CCMoveTo:create(3, ccp(-200, arg_21_0.pointZhuazi.y)))
		else
			var_21_2:addObject(CCMoveTo:create(3, ccp(1400, arg_21_0.pointZhuazi.y)))
		end

		var_21_2:addObject(CCCallFuncN:create(function()
			arg_21_0.zhuaziEffct:setAnimation("animation", true)
			arg_21_0.heroAvatar:setVisible(false)
		end))
		var_21_2:addObject(CCMoveTo:create(1, ccp(arg_21_0.pointZhuazi.x, arg_21_0.pointZhuazi.y)))
		var_21_2:addObject(CCDelayTime:create(1))
		var_21_2:addObject(CCCallFuncN:create(function()
			arg_21_0:refresh()
		end))

		if g_Self.kHeroTrialHandler.dataChange then
			var_21_2:addObject(CCCallFuncN:create(function()
				g_Self.kDataChange:update(g_Self.kHeroTrialHandler.dataChange)
			end))
		end

		local var_21_3 = CCSequence:create(var_21_2)

		arg_21_0.nodeZhuazi:stopAllActions()
		arg_21_0.nodeZhuazi:runAction(var_21_3)
	end
end

function zbWawajiWnd.onFrameUpdate(arg_27_0)
	arg_27_0:updateYaoganMove()
	arg_27_0:updateZhuaqu()
	arg_27_0:updateChuanSong()

	if arg_27_0.countdown > 0 then
		arg_27_0.countdown = math.ceil(arg_27_0.startCountdown - (os_timenow() - arg_27_0.startCdTime))

		arg_27_0.lbTimeDummy:setString(arg_27_0.countdown)

		if arg_27_0.countdown <= 0 and arg_27_0.timeStop == false then
			arg_27_0:onBegin()
		end
	else
		arg_27_0.lbTimeDummy:setString("X")
	end
end

function zbWawajiWnd.updateYaoganMove(arg_28_0)
	if arg_28_0.yaoganMove == 0 then
		return
	end

	if arg_28_0.yaoganMove == 1 then
		if arg_28_0.pointZhuazi.x < 1100 then
			arg_28_0.pointZhuazi.x = arg_28_0.pointZhuazi.x + 8
		end
	elseif arg_28_0.yaoganMove == -1 and arg_28_0.pointZhuazi.x > 30 then
		arg_28_0.pointZhuazi.x = arg_28_0.pointZhuazi.x - 8
	end

	arg_28_0.nodeZhuazi:setPosition(arg_28_0.pointZhuazi)
end

function zbWawajiWnd.updateZhuaqu(arg_29_0)
	if arg_29_0.beginZhua == false then
		return
	end

	arg_29_0.zhuaqiIndex = 0

	local var_29_0 = ccp(arg_29_0.nodeZhuazi:getPosition())

	for iter_29_0 = 1, 10 do
		if arg_29_0.nodeItem[iter_29_0]:updateZhuaqu(var_29_0) == true then
			arg_29_0.beginZhua = false
			arg_29_0.zhuaqiIndex = iter_29_0

			g_WsMsgHandler:WS_Dolls_Grab_Req(arg_29_0.nodeItem[arg_29_0.zhuaqiIndex].dollsItem.Index)
			arg_29_0:onZhuaqi()
		end
	end
end

function zbWawajiWnd.updateChuanSong(arg_30_0)
	arg_30_0.pointChuanSong.x = arg_30_0.pointChuanSong.x - var_0_1

	if arg_30_0.pointChuanSong.x <= -128 then
		arg_30_0.pointChuanSong.x = 0
	end

	arg_30_0.nodeChuanSong:setPosition(arg_30_0.pointChuanSong)

	for iter_30_0 = 1, 10 do
		if arg_30_0.nodeItem[iter_30_0].intItemPoint.x < -wawajiDistance then
			arg_30_0.nodeItem[iter_30_0].intItemPoint.x = wawajiDistance * 9
		else
			arg_30_0.nodeItem[iter_30_0].intItemPoint.x = arg_30_0.nodeItem[iter_30_0].intItemPoint.x - var_0_1
		end

		arg_30_0.nodeItem[iter_30_0].ccNode:setPosition(arg_30_0.nodeItem[iter_30_0].intItemPoint)
	end
end

function zbWawajiWnd.onZhuaqi(arg_31_0)
	if arg_31_0.zhuaqiIndex == 0 then
		return
	end

	arg_31_0.nodeItem[arg_31_0.zhuaqiIndex]:onZhuaqi()

	local var_31_0 = CCArray:create()

	if arg_31_0.nodeItem[arg_31_0.zhuaqiIndex].dollsItem.Index == 0 then
		var_31_0:addObject(CCCallFuncN:create(function()
			arg_31_0.zhuaziEffct:setAnimation("animation3", false)
		end))
		var_31_0:addObject(CCDelayTime:create(0.5))

		for iter_31_0 = 1, 10 do
			if arg_31_0.nodeItem[iter_31_0].dollsItem.Index ~= 0 then
				arg_31_0.nodeItem[iter_31_0].intHero:setAnimation(ANIMATION_SEQUENCE_BEHIT, false)
			end
		end
	else
		var_31_0:addObject(CCCallFuncN:create(function()
			arg_31_0.zhuaziEffct:setAnimation("animation2", false)
		end))
		var_31_0:addObject(CCCallFuncN:create(function()
			arg_31_0:showHero()
		end))
		var_31_0:addObject(CCDelayTime:create(1))
	end

	var_31_0:addObject(CCMoveTo:create(1, ccp(arg_31_0.pointZhuazi.x, arg_31_0.pointZhuazi.y)))
	var_31_0:addObject(CCCallFuncN:create(function()
		arg_31_0:refreshGrab()
	end))

	local var_31_1 = CCSequence:create(var_31_0)

	arg_31_0.nodeZhuazi:stopAllActions()
	arg_31_0.nodeZhuazi:runAction(var_31_1)
end

function zbWawajiWnd.onYaogan(arg_36_0)
	return
end

function zbWawajiWnd.onYaoganDown(arg_37_0)
	arg_37_0.yaoganMove = 0
	arg_37_0.lastDownTouch = arg_37_0.btnYaogan:getTouch():getLocation()
end

function zbWawajiWnd.onYaoganMove(arg_38_0)
	arg_38_0.lastMoveTouch = arg_38_0.btnYaogan:getTouch():getLocation()

	if ccpDistanceSQ(arg_38_0.lastMoveTouch, arg_38_0.lastDownTouch) <= var_0_0 then
		arg_38_0.yaoganEffct:setAnimation("animation1", true)

		arg_38_0.yaoganMove = 0

		return
	end

	if arg_38_0.lastMoveTouch.x > arg_38_0.lastDownTouch.x then
		arg_38_0.yaoganMove = 1

		arg_38_0.yaoganEffct:setAnimation("animation2", true)
	elseif arg_38_0.lastMoveTouch.x < arg_38_0.lastDownTouch.x then
		arg_38_0.yaoganMove = -1

		arg_38_0.yaoganEffct:setAnimation("animation3", true)
	else
		arg_38_0.yaoganMove = 0
	end
end

function zbWawajiWnd.onYaoganEnd(arg_39_0)
	arg_39_0.yaoganMove = 0

	arg_39_0.yaoganEffct:setAnimation("animation1", false)
end

function zbWawajiWnd.onInput(arg_40_0)
	if g_GameData.Wealth.DollsMoney <= 0 then
		g_Bubble:bubbleInfo(a2u("\xCD\xDE\xCD޻\xFA\xB4\xFA\xB1Ҳ\xBB\xD7\xE3"))

		return
	end

	local var_40_0 = a2u("\xCAǷ񻨷\xD11\xB4\xFA\xB1ҽ\xF8\xD0\xD0\xCD\xDE\xCD޻\xFA\xA3\xA1")

	g_MessageBox:showYesNo(var_40_0, function()
		g_WsMsgHandler:WS_Dolls_PutCoin_Req()
	end)
end

function zbWawajiWnd.onBegin(arg_42_0)
	if arg_42_0.beginZhua == true then
		return
	end

	zbUtil:setBtnEnable(arg_42_0.btnBegin, false)

	arg_42_0.timeStop = true
	arg_42_0.yaoganMove = 0
	arg_42_0.countdown = 0
	arg_42_0.beginZhua = true

	arg_42_0.btnYaogan:setEnabled(false)
	arg_42_0.yaoganEffct:setAnimation("animation1", false)

	local var_42_0 = CCArray:create()

	var_42_0:addObject(CCMoveTo:create(1.2, ccp(arg_42_0.pointZhuazi.x, arg_42_0.pointZhuazi.y - 250)))
	var_42_0:addObject(CCCallFuncN:create(function()
		arg_42_0.zhuaziEffct:setAnimation("animation2", false)
	end))
	var_42_0:addObject(CCDelayTime:create(1))
	var_42_0:addObject(CCCallFuncN:create(function()
		arg_42_0.beginZhua = false
	end))
	var_42_0:addObject(CCMoveTo:create(1.2, ccp(arg_42_0.pointZhuazi.x, arg_42_0.pointZhuazi.y)))
	var_42_0:addObject(CCCallFuncN:create(function()
		arg_42_0:refreshGrab()
	end))
	var_42_0:addObject(CCCallFuncN:create(function()
		g_WsMsgHandler:WS_Dolls_Grab_Req(0)
	end))

	local var_42_1 = CCSequence:create(var_42_0)

	arg_42_0.nodeZhuazi:stopAllActions()
	arg_42_0.nodeZhuazi:runAction(var_42_1)
end

function zbWawajiWnd.showHero(arg_47_0)
	arg_47_0.heroAvatar:refreshHeroTemplateId(arg_47_0.nodeItem[arg_47_0.zhuaqiIndex].dollsItem.Item.Id)
	arg_47_0.heroAvatar:setAnimation(ANIMATION_SEQUENCE_PICKUP, true)

	local var_47_0 = zbHeroTable:getRecord(arg_47_0.nodeItem[arg_47_0.zhuaqiIndex].dollsItem.Item.Id)
	local var_47_1 = zbAvatarTable:getRecord(var_47_0.avatarId)

	if var_47_1 == nil then
		echoInfo("zbHero:init: monster == nil")

		return
	end

	arg_47_0.heroAvatar:setPosition(10, -var_47_1.hudOffset.y * 0.8 + 40)
	arg_47_0.heroAvatar:setVisible(true)
end
