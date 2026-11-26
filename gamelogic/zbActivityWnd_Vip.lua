require("gamelogic.zbTimeLabel")

zbActivityWnd_Vip = class("zbActivityWnd_Vip")
zbActivityWnd_Vip.__index = zbActivityWnd_Vip

function zbActivityWnd_Vip.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbActivityWnd_Vip)

	return arg_1_0
end

function zbActivityWnd_Vip.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = zbActivityWnd_Vip.new()

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3)

	return var_2_0
end

function zbActivityWnd_Vip.init(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	(function()
		arg_3_0.spriteDay = {}
		arg_3_0.btnGet = {}
		arg_3_0.position = {}
		arg_3_0.lbGetNum = {}
		arg_3_0.nodeParent = arg_3_1
		arg_3_0.btnPriority = arg_3_2
		arg_3_0.parentWnd = arg_3_3
	end)()
end

function zbActivityWnd_Vip.refresh(arg_5_0)
	(function()
		if arg_5_0.node ~= nil then
			return
		end

		CCLabelTTF:beginDelayCreateTexture()

		local var_6_0 = CCBProxy:create()
		local var_6_1 = CCBReaderLoad("ccbi/activity_vip.ccbi", var_6_0, true, "HelloCocosBuilderLayerOwner", true)
		local var_6_2 = tolua.cast(var_6_1:getChildByTag(1), "CCNode")

		arg_5_0.nodeParent:addChild(var_6_1)

		for iter_6_0 = 1, 7 do
			local var_6_3 = tolua.cast(var_6_2:getChildByTag(iter_6_0), "CCNode")

			arg_5_0.btnGet[iter_6_0] = tolua.cast(var_6_3:getChildByTag(1), "CCControlButton")
			arg_5_0.spriteDay[iter_6_0] = tolua.cast(var_6_3:getChildByTag(2), "CCSprite")
			arg_5_0.position[iter_6_0] = ccp(arg_5_0.btnGet[iter_6_0]:getPosition())

			arg_5_0.btnGet[iter_6_0]:addHandleOfControlEvent(function()
				arg_5_0:onGet(iter_6_0)
			end, CCControlEventTouchUpInside)
			arg_5_0.btnGet[iter_6_0]:setTouchPriority(arg_5_0.btnPriority:getTouchPriority())

			local var_6_4 = tolua.cast(var_6_3:getChildByTag(3), "CCSprite")
			local var_6_5 = tolua.cast(var_6_4:getChildByTag(1001), "CCLabelTTF")

			arg_5_0.lbGetNum[iter_6_0] = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

			require("gamebase.zbUI"):replaceCtrl(var_6_5, arg_5_0.lbGetNum[iter_6_0])
			arg_5_0.lbGetNum[iter_6_0]:setScale(0.55)
			arg_5_0.lbGetNum[iter_6_0]:setString(iter_6_0 * 10)
		end

		arg_5_0.spriteTalk = tolua.cast(var_6_2:getChildByTag(10), "CCSprite")
		arg_5_0.lbTalk = tolua.cast(arg_5_0.spriteTalk:getChildByTag(1), "CCLabelTTF")

		arg_5_0.spriteTalk:setVisible(false)

		local var_6_6 = tolua.cast(var_6_2:getChildByTag(1001), "CCLabelTTF")

		arg_5_0.lbActAll = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_6_6, arg_5_0.lbActAll)
		arg_5_0.lbActAll:setScale(0.55)

		local var_6_7 = tolua.cast(var_6_2:getChildByTag(1002), "CCLabelTTF")

		arg_5_0.curViplvRep = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_6_7, arg_5_0.curViplvRep)
		arg_5_0.curViplvRep:setScale(0.7)

		local var_6_8 = tolua.cast(var_6_2:getChildByTag(1003), "CCLabelTTF")

		arg_5_0.nextViplvRep = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_6_8, arg_5_0.nextViplvRep)
		arg_5_0.nextViplvRep:setScale(0.65)

		arg_5_0.vipDots = tolua.cast(var_6_2:getChildByTag(21), "CCLabelTTF")
		arg_5_0.btnGotoVip = tolua.cast(var_6_2:getChildByTag(30), "CCControlButton")

		arg_5_0.btnGotoVip:addHandleOfControlEvent(function()
			arg_5_0:onGotoVip()
		end, CCControlEventTouchUpInside)
		arg_5_0.btnGotoVip:setTouchPriority(arg_5_0.btnPriority:getTouchPriority())

		arg_5_0.spriteBarBg = tolua.cast(var_6_2:getChildByTag(20), "CCSprite")

		local function var_6_9(arg_9_0, arg_9_1)
			local var_9_0 = CCSprite:create(arg_9_1)

			var_9_0:setAnchorPoint(ccp(0, 0))

			local var_9_1 = CCProgressTimer:create(var_9_0)

			var_9_1:setAnchorPoint(ccp(0, 0))
			var_9_1:setPercentage(0)
			var_9_1:setMidpoint(ccp(0, 1))
			var_9_1:setBarChangeRate(ccp(1, 0))
			var_9_1:setType(kCCProgressTimerTypeBar)
			var_9_1:retain()
			arg_9_0:addChild(var_9_1)

			return var_9_1
		end

		arg_5_0.spriteBar = var_6_9(arg_5_0.spriteBarBg, "image/vip/vip_progress2.png")

		local var_6_10 = CCArray:create()

		var_6_10:addObject(CCCallFuncN:create(function()
			arg_5_0.lbTalk:setString(a2u("\xC8ճ\xA3\xBB\xEEԾ\xB6ȴﵽ100\xBC\xB4\xBF\xC9\xC1\xECȡ"))
		end))
		var_6_10:addObject(CCDelayTime:create(3))
		var_6_10:addObject(CCCallFuncN:create(function()
			arg_5_0.lbTalk:setString(a2u("\xC1\xECȡ\xB5\xC4\xD7\xEAʯ\xBF\xC9\xD2\xD4\xCC\xE1\xC9\xFDVIP\xB5ȼ\xB6\xBF\xC9\xD2Ա\xE4\xB5ø\xFC\xBC\xD3\xC0\xF7\xBA\xA6Ŷ\xA3\xA1"))
		end))
		var_6_10:addObject(CCDelayTime:create(3))

		local var_6_11 = CCSequence:create(var_6_10)

		arg_5_0.lbTalk:stopAllActions()
		arg_5_0.lbTalk:runAction(CCRepeatForever:create(var_6_11))

		arg_5_0.node = var_6_1

		CCLabelTTF:endDelayCreateTexture(var_6_1)
	end)()

	if zbUtil:isValidTable(g_GameData.ActivityAct) == false or zbUtil:isValidTable(g_GameData.ActivityAct.LoginVip) == false then
		return
	end

	arg_5_0.lbActAll:setString(g_GameData.DailyTask.ActiveCount)

	for iter_5_0 = 1, 7 do
		arg_5_0.spriteDay[iter_5_0]:setVisible(iter_5_0 < g_GameData.ActivityAct.LoginVip.Day)
	end

	arg_5_0.spriteDay[g_GameData.ActivityAct.LoginVip.Day]:setVisible(g_GameData.ActivityAct.LoginVip.State == 1)

	if g_GameData.ActivityAct.LoginVip.State == 0 and g_GameData.DailyTask.ActiveCount >= 100 then
		if arg_5_0.fxRecharge == nil then
			arg_5_0.fxRecharge = createUIAnimation()

			arg_5_0.fxRecharge:refresh("effect/spine/ui_yindaodianji/ui_yindaodianji.json", "effect/spine/ui_yindaodianji/ui_yindaodianji.atlas")
			arg_5_0.fxRecharge:setPosition(ccp(90, 75))
			arg_5_0.fxRecharge:setAnimation("animation", true)
			arg_5_0.btnGet[g_GameData.ActivityAct.LoginVip.Day]:addChild(arg_5_0.fxRecharge)
		end
	elseif arg_5_0.fxRecharge then
		arg_5_0.fxRecharge:setVisible(false)
	end

	local var_5_0 = g_GameData.BaseInfo.VipLevel

	arg_5_0.curViplvRep:setString(var_5_0)

	if var_5_0 >= MAX_VIPLEVEL then
		arg_5_0.nextViplvRep:setString(MAX_VIPLEVEL)
	else
		arg_5_0.nextViplvRep:setString(var_5_0 + 1)
	end

	if g_GameData.VipInfo then
		local var_5_1 = g_GameData.VipInfo.VipBaseInfo.Exp
		local var_5_2 = 100 * var_5_1 / g_GameData.VipInfo.VipBaseInfo.NextTotalExp

		arg_5_0.vipDots:setString(var_5_1 .. "/" .. g_GameData.VipInfo.VipBaseInfo.NextTotalExp)

		if var_5_0 >= MAX_VIPLEVEL then
			arg_5_0.vipDots:setString(a2u("\xD2Ѵ\xEF\xD7\xEE\xB4\xF3\xB5ȼ\xB6"))
		end

		arg_5_0.spriteBar:runAction(CCProgressTo:create(0.1, var_5_2))
	end
end

function zbActivityWnd_Vip.onGet(arg_12_0, arg_12_1)
	if zbUtil:isValidTable(g_GameData.ActivityAct) == false or zbUtil:isValidTable(g_GameData.ActivityAct.LoginVip) == false then
		return
	end

	if g_GameData.ActivityAct.LoginVip.Day ~= arg_12_1 then
		return
	end

	if g_GameData.DailyTask.ActiveCount < 100 then
		g_Bubble:bubbleInfo("\xC8ճ\xA3\xBB\xEEԾ\xB6ȴﵽ100\xBC\xB4\xBF\xC9\xC1\xECȡ\xA3\xA1")

		return
	end

	if g_GameData.ActivityAct.LoginVip.State == 1 then
		return
	end

	g_WsMsgHandler:WS_ActivityAct_LoginVip_Req()
end

function zbActivityWnd_Vip.onGotoVip(arg_13_0)
	if arg_13_0.parentWnd then
		arg_13_0.parentWnd:hide()
	end

	g_MainScene:showVipBuyWnd()
end
