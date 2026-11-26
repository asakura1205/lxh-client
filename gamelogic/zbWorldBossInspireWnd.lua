require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbWorldBossInspireWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createWorldBossInspireWnd()
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
		arg_3_0.lbAttr = {}
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/world_boss_inspire.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.layer = var_5_2

		for iter_5_0 = 1, 3 do
			arg_3_0.lbAttr[iter_5_0] = tolua.cast(var_5_2:getChildByTag(iter_5_0), "CCLabelTTF")
		end

		arg_3_0.spriteMoney = tolua.cast(var_5_2:getChildByTag(4), "CCSprite")

		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1005), "CCLabelTTF")

		arg_3_0.btnCommon = tolua.cast(var_5_2:getChildByTag(6), "CCControlButton")
		arg_3_0.btnInspire = tolua.cast(var_5_2:getChildByTag(7), "CCControlButton")

		arg_3_0.btnCommon:addHandleOfControlEvent(function()
			arg_3_0:onCommon()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnInspire:addHandleOfControlEvent(function()
			arg_3_0:onInspire()
		end, CCControlEventTouchUpInside)

		arg_3_0.lbMoney = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_3, arg_3_0.lbMoney)
		arg_3_0.lbMoney:setScale(0.6)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onCommon()
	end, zbGameEvent.Event_WorldBoss_Inspire_Ack)
end

function var_0_0.refresh(arg_10_0)
	arg_10_0.lbMoney:setString(g_DataConfig.m_kWorldBossCfg.InspireCostDiamond)

	for iter_10_0 = 1, 3 do
		arg_10_0.lbAttr[iter_10_0]:setVisible(false)
	end

	local var_10_0 = 1

	for iter_10_1, iter_10_2 in ipairs(g_DataConfig.m_kWorldBossCfg.buffList) do
		arg_10_0.lbAttr[var_10_0]:setString(iter_10_2.desc)
		arg_10_0.lbAttr[var_10_0]:setVisible(true)

		var_10_0 = var_10_0 + 1
	end
end

function var_0_0.onCommon(arg_11_0)
	if g_MainScene.wndWorldBoss and g_Self.kWorldHandler.worldBossInfo then
		g_MainScene.wndWorldBoss:hide()
		arg_11_0:hide()
		g_MainScene:showEmbattleWorldBoss(g_Self.kWorldHandler.worldBossInfo.BossId, g_Self.kWorldHandler.worldBossBuffList)
	end
end

function var_0_0.onInspire(arg_12_0)
	if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Diamond, g_DataConfig.m_kWorldBossCfg.InspireCostDiamond) == false then
		g_Bubble:bubbleInfo(a2u("\xD7\xEAʯ\xB2\xBB\xD7\xE3"))

		return
	end

	g_WsMsgHandler:WS_WorldBoss_Inspire_Req()
end

function var_0_0.onTouchTest(arg_13_0)
	local var_13_0 = arg_13_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_13_0.layer, var_13_0.x, var_13_0.y) == false then
		arg_13_0:hide()
	end
end
