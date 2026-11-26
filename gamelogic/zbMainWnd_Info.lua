local var_0_0 = class("zbMainWnd_Info")

var_0_0.__index = var_0_0

function createMainWndInfo(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	local function var_2_0()
		arg_2_0.parentWnd = arg_2_1
	end

	local function var_2_1()
		local function var_4_0(arg_5_0, arg_5_1)
			local var_5_0 = CCSprite:create(arg_5_1)

			var_5_0:setAnchorPoint(ccp(0, 0))

			local var_5_1 = CCProgressTimer:create(var_5_0)

			var_5_1:setAnchorPoint(ccp(0, 0))
			var_5_1:setPercentage(100)
			var_5_1:setMidpoint(ccp(0, 1))
			var_5_1:setBarChangeRate(ccp(1, 0))
			var_5_1:setType(kCCProgressTimerTypeBar)
			var_5_1:retain()
			arg_5_0:addChild(var_5_1)

			return var_5_1
		end

		arg_2_0.headLayer = arg_2_2
		arg_2_0.lbName = tolua.cast(arg_2_0.headLayer:getChildByTag(1), "CCLabelTTF")
		arg_2_0.btnHead = tolua.cast(arg_2_0.headLayer:getChildByTag(3), "CCControlButton")
		arg_2_0.spriteIcon = tolua.cast(arg_2_0.headLayer:getChildByTag(5), "CCSprite")
		arg_2_0.btnHeadExpTip = tolua.cast(arg_2_0.headLayer:getChildByTag(8), "CCControlButton")
		arg_2_0.nodeFight = tolua.cast(arg_2_0.headLayer:getChildByTag(4), "CCNode")
		arg_2_0.FightDummy = tolua.cast(arg_2_0.nodeFight:getChildByTag(1), "CCLabelTTF")
		arg_2_0.nodeLv = tolua.cast(arg_2_0.headLayer:getChildByTag(6), "CCNode")
		arg_2_0.spriteProgressBg = tolua.cast(arg_2_0.nodeLv:getChildByTag(1), "CCSprite")
		arg_2_0.spriteProgress = var_4_0(arg_2_0.spriteProgressBg, "image/main/main_exp_progress.png")
		arg_2_0.lbProgress = tolua.cast(arg_2_0.nodeLv:getChildByTag(3), "CCLabelTTF")
		arg_2_0.speiteLv = tolua.cast(arg_2_0.nodeLv:getChildByTag(4), "CCSprite")
		arg_2_0.levelDummy = tolua.cast(arg_2_0.speiteLv:getChildByTag(1), "CCLabelTTF")
		arg_2_0.nodeVip = tolua.cast(arg_2_0.headLayer:getChildByTag(7), "CCNode")
		arg_2_0.VipDummy = tolua.cast(arg_2_0.nodeVip:getChildByTag(1), "CCLabelTTF")
		arg_2_0.btnVip = tolua.cast(arg_2_0.nodeVip:getChildByTag(3), "CCControlButton")
		arg_2_0.vipgiftpop = tolua.cast(arg_2_0.nodeVip:getChildByTag(6), "CCNode")

		arg_2_0.vipgiftpop:setVisible(false)

		arg_2_0.nodeOnline = tolua.cast(arg_2_0.headLayer:getChildByTag(9), "CCNode")
		arg_2_0.lbOnlineDummy = tolua.cast(arg_2_0.nodeOnline:getChildByTag(0), "CCLabelTTF")
		arg_2_0.btnOnline = tolua.cast(arg_2_0.nodeOnline:getChildByTag(1), "CCControlButton")
		arg_2_0.effectOnline = tolua.cast(arg_2_0.nodeOnline:getChildByTag(3), "CCControlButton")
		arg_2_0.lbOnline = zbTimeLabel:create(arg_2_0.lbOnlineDummy, "", "", true)

		arg_2_0.lbOnline:setCustomCallback(function()
			arg_2_0:refresh()
		end)
		arg_2_0.btnOnline:addHandleOfControlEvent(function()
			arg_2_0:onOnline()
		end, CCControlEventTouchUpInside)
		arg_2_0:setBtnChargeEffect(arg_2_0.effectOnline)

		arg_2_0.lbLv = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_2_0.levelDummy, arg_2_0.lbLv)
		arg_2_0.lbLv:setScale(0.5)

		arg_2_0.lbVip = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_2_0.VipDummy, arg_2_0.lbVip)
		arg_2_0.lbVip:setScale(0.5)

		arg_2_0.lbFight = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_2_0.FightDummy, arg_2_0.lbFight)
		arg_2_0.lbFight:setScale(0.5)
		arg_2_0.btnHead:addHandleOfControlEvent(function()
			arg_2_0:onHead()
		end, CCControlEventTouchUpInside)
		arg_2_0.btnHeadExpTip:addHandleOfControlEvent(function()
			arg_2_0:onHeadExpTip()
		end, CCControlEventTouchUpInside)
		arg_2_0.btnVip:addHandleOfControlEvent(function()
			arg_2_0:onVIP()
		end, CCControlEventTouchUpInside)
	end

	var_2_0()
	var_2_1()
	arg_2_0:refresh()
end

function var_0_0.onFrameUpdate(arg_11_0)
	if g_GameStateMachine:isOneSecondPassed() == false then
		return
	end

	arg_11_0.vipgiftpop:setVisible(false)

	local var_11_0 = g_GameData.BaseInfo.VipLevel

	if var_11_0 <= 0 then
		return
	end

	for iter_11_0 = 1, var_11_0 do
		local var_11_1 = g_Self.kVipHandler:getVipGiftDetailByLevel(iter_11_0)

		if var_11_1 and var_11_1.State == 1 then
			arg_11_0.vipgiftpop:setVisible(true)
		end
	end
end

function var_0_0.refresh(arg_12_0)
	local var_12_0 = zbIconHelper:getPlayerHeadIconPath(g_GameData.BaseInfo.HeadId)

	arg_12_0.spriteIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_12_0))
	arg_12_0.lbName:setString(a2u(g_Self:getName()))
	arg_12_0.lbLv:setString(g_Self:getLevel())
	arg_12_0.lbVip:setString(g_Self:getVipLevel())
	arg_12_0.lbFight:setString(g_Self:getFightValue())

	local var_12_1 = g_GameData.BaseInfo.Exp
	local var_12_2 = zbPlayerUpgradeTable:getExpNeed(g_GameData.BaseInfo.Level)

	arg_12_0.lbProgress:setString(var_12_1 .. "/" .. var_12_2)

	local var_12_3 = math.min(math.ceil(100 * (var_12_1 / var_12_2)), 100)

	arg_12_0.spriteProgress:runAction(CCProgressTo:create(0, var_12_3))
	arg_12_0:startTime()
	arg_12_0.effectOnline:setVisible(zbUtil:isValidTable(g_GameData.ActivityAct) and zbUtil:isValidTable(g_GameData.ActivityAct.OnlineAward) and g_Self.kTimeHandler:getServerTime() >= g_GameData.ActivityAct.OnlineAward.NextTm)
end

function var_0_0.onHead(arg_13_0)
	g_MainScene:showSettingWnd()
end

function var_0_0.onHeadExpTip(arg_14_0)
	g_MainScene:showMainExpTipWnd()
end

function var_0_0.onVIP(arg_15_0)
	g_MainScene:showVipTequan()
end

function var_0_0.startTime(arg_16_0)
	if zbUtil:isValidTable(g_GameData.ActivityAct) == false or zbUtil:isValidTable(g_GameData.ActivityAct.OnlineAward) == false then
		arg_16_0.nodeOnline:setVisible(false)

		return
	end

	arg_16_0.nodeOnline:setVisible(true)
	arg_16_0.lbOnline:start(g_GameData.ActivityAct.OnlineAward.NextTm - g_Self.kTimeHandler:getServerTime())
end

function var_0_0.onOnline(arg_17_0)
	if zbUtil:isValidTable(g_GameData.ActivityAct) and zbUtil:isValidTable(g_GameData.ActivityAct.OnlineAward) then
		if g_GameData.ActivityAct.OnlineAward.NextTm - g_Self.kTimeHandler:getServerTime() > 0 then
			g_MainScene:showOnlineAwardWnd()
		else
			g_WsMsgHandler:WS_ActivityAct_OnlineAward_Req()
		end
	end
end

function var_0_0.setBtnChargeEffect(arg_18_0, arg_18_1)
	if arg_18_1 then
		local var_18_0 = createUIAnimation()

		var_18_0:refresh("effect/spine/ui_chonzhiguangxiao/ui_chonzhiguangxiao.json", "effect/spine/ui_chonzhiguangxiao/ui_chonzhiguangxiao.atlas")
		var_18_0:setPosition(ccp(40, 40))
		var_18_0:setScale(0.8)
		var_18_0:setAnimation("animation", true)
		arg_18_1:addChild(var_18_0)
	end
end

function var_0_0.isContained(arg_19_0, arg_19_1, arg_19_2)
	if zbUtil:PointInCtrl(arg_19_0.btnHead, arg_19_1, arg_19_2) or zbUtil:PointInCtrl(arg_19_0.btnVip, arg_19_1, arg_19_2) then
		return true
	end

	return false
end
