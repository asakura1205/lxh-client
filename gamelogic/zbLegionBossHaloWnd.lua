require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbLegionBossHalo", zbBaseWnd)

var_0_0.__index = var_0_0

function createLegionBossHaloWnd()
	local var_1_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNodeRGBA:create())))

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
		arg_3_0.select = {}
		arg_3_0.costMoney = 0
		arg_3_0.buffid1 = g_DataConfig.m_kLegionBaseCfg.legionBoss.BuffBuy[1].buffId
		arg_3_0.buffid2 = g_DataConfig.m_kLegionBaseCfg.legionBoss.BuffBuy[2].buffId
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/legion_bosshalo.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.layer = var_5_2
		arg_3_0.node1 = tolua.cast(var_5_2:getChildByTag(1), "CCNode")

		local var_5_3 = tolua.cast(arg_3_0.node1:getChildByTag(1001), "CCLabelTTF")

		arg_3_0.lbDesc1 = tolua.cast(arg_3_0.node1:getChildByTag(2), "CCLabelTTF")
		arg_3_0.checkNode1 = tolua.cast(arg_3_0.node1:getChildByTag(3), "CCNode")
		arg_3_0.btnSelect1 = tolua.cast(arg_3_0.checkNode1:getChildByTag(3), "CCControlButton")
		arg_3_0.spriteSelect1 = tolua.cast(arg_3_0.checkNode1:getChildByTag(4), "CCSprite")
		arg_3_0.lbbuffbuyed1 = tolua.cast(arg_3_0.node1:getChildByTag(4), "CCLabelTTF")
		arg_3_0.node2 = tolua.cast(var_5_2:getChildByTag(2), "CCNode")

		local var_5_4 = tolua.cast(arg_3_0.node2:getChildByTag(1001), "CCLabelTTF")

		arg_3_0.lbDesc2 = tolua.cast(arg_3_0.node2:getChildByTag(2), "CCLabelTTF")
		arg_3_0.checkNode2 = tolua.cast(arg_3_0.node2:getChildByTag(3), "CCNode")
		arg_3_0.btnSelect2 = tolua.cast(arg_3_0.checkNode2:getChildByTag(3), "CCControlButton")
		arg_3_0.spriteSelect2 = tolua.cast(arg_3_0.checkNode2:getChildByTag(4), "CCSprite")
		arg_3_0.lbbuffbuyed2 = tolua.cast(arg_3_0.node2:getChildByTag(4), "CCLabelTTF")
		arg_3_0.node2 = tolua.cast(var_5_2:getChildByTag(2), "CCNode")

		local var_5_5 = tolua.cast(var_5_2:getChildByTag(1001), "CCLabelTTF")

		arg_3_0.btnFight = tolua.cast(var_5_2:getChildByTag(3), "CCControlButton")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")
		arg_3_0.lbMoney1 = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_3, arg_3_0.lbMoney1)
		arg_3_0.lbMoney1:setScale(0.55)

		arg_3_0.lbMoney2 = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_4, arg_3_0.lbMoney2)
		arg_3_0.lbMoney2:setScale(0.55)

		arg_3_0.lbMoney = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_5, arg_3_0.lbMoney)
		arg_3_0.lbMoney:setScale(0.55)
		arg_3_0.lbMoney1:setString(g_DataConfig.m_kLegionBaseCfg.legionBoss.BuffBuy[1].costDiamond)
		arg_3_0.lbMoney2:setString(g_DataConfig.m_kLegionBaseCfg.legionBoss.BuffBuy[2].costDiamond)
		arg_3_0.btnSelect1:addHandleOfControlEvent(function()
			arg_3_0:onSelect(arg_3_0.buffid1)
		end, CCControlEventTouchUpInside)
		arg_3_0.btnSelect2:addHandleOfControlEvent(function()
			arg_3_0:onSelect(arg_3_0.buffid2)
		end, CCControlEventTouchUpInside)
		arg_3_0.btnFight:addHandleOfControlEvent(function()
			arg_3_0:onFight()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:doFight()
	end, zbGameEvent.Event_LegionBossBuff_Ack)
end

function var_0_0.refresh(arg_12_0)
	local function var_12_0(arg_13_0)
		if g_GameData.LegionInfo and zbUtil:isValidTable(g_GameData.LegionInfo.LegionBoss.BuffList) then
			for iter_13_0, iter_13_1 in pairs(g_GameData.LegionInfo.LegionBoss.BuffList) do
				if iter_13_1.BuffId == arg_13_0 then
					return true
				end
			end
		end

		return false
	end

	arg_12_0.checkNode1:setVisible(not var_12_0(arg_12_0.buffid1))
	arg_12_0.checkNode2:setVisible(not var_12_0(arg_12_0.buffid2))
	arg_12_0.lbbuffbuyed1:setVisible(var_12_0(arg_12_0.buffid1))
	arg_12_0.lbbuffbuyed2:setVisible(var_12_0(arg_12_0.buffid2))

	arg_12_0.select = {}

	arg_12_0:refreshSel()
end

function var_0_0.refreshSel(arg_14_0)
	local function var_14_0(arg_15_0)
		for iter_15_0, iter_15_1 in pairs(arg_14_0.select) do
			if iter_15_1 == arg_15_0 then
				return true
			end
		end

		return false
	end

	arg_14_0.spriteSelect1:setVisible(var_14_0(arg_14_0.buffid1))
	arg_14_0.spriteSelect2:setVisible(var_14_0(arg_14_0.buffid2))

	local function var_14_1(arg_16_0)
		for iter_16_0, iter_16_1 in pairs(g_DataConfig.m_kLegionBaseCfg.legionBoss.BuffBuy) do
			if iter_16_1.buffId == arg_16_0 then
				return iter_16_1.costDiamond
			end
		end
	end

	local var_14_2 = 0

	for iter_14_0, iter_14_1 in pairs(arg_14_0.select) do
		var_14_2 = var_14_2 + var_14_1(iter_14_1)
	end

	arg_14_0.costMoney = var_14_2

	arg_14_0.lbMoney:setString(arg_14_0.costMoney)
end

function var_0_0.onSelect(arg_17_0, arg_17_1)
	(function()
		for iter_18_0, iter_18_1 in pairs(arg_17_0.select) do
			if iter_18_1 == arg_17_1 then
				table.remove(arg_17_0.select, iter_18_0)

				return
			end
		end

		table.insert(arg_17_0.select, arg_17_1)
	end)()
	arg_17_0:refreshSel()
end

function var_0_0.onFight(arg_19_0)
	if arg_19_0.costMoney == 0 then
		arg_19_0:doFight()
	elseif arg_19_0.costMoney > g_GameData.Wealth.Diamond then
		g_Bubble:bubbleInfo(a2u("\xD7\xEAʯ\xB2\xBB\xD7\xE3"))

		return
	else
		g_WsMsgHandler:WS_LegionBoss_BuyBuff_Req(arg_19_0.select)
	end
end

function var_0_0.doFight(arg_20_0)
	if g_Self.kLegionHandler.fightBossInfo then
		arg_20_0:hide()

		if g_MainScene.wndLegionBoss then
			g_MainScene.wndLegionBoss:hide()
		end

		g_MainScene:showEmbattleLegionBoss(g_Self.kLegionHandler.fightBossInfo)
	end
end

function var_0_0.onTouchTest(arg_21_0)
	local var_21_0 = arg_21_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_21_0.layer, var_21_0.x, var_21_0.y) == false and zbUtil:PointInCtrl(arg_21_0.btnClose, var_21_0.x, var_21_0.y) == false then
		arg_21_0:hide()
	end
end
