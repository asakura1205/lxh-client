require("gamelogic.zbRankList")
require("gamelogic.zbRankSingleList")
require("gamelogic.zbRankTopItem")
require("gamelogic.zbRankLegionList")
require("gamelogic.zbRankPataList")

local var_0_0 = class("zbRankListWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createRankListWnd()
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
		arg_3_0.eRankTab = -1
		arg_3_0.topItems = {}
		arg_3_0.nodeRankList = {}
		arg_3_0.firstOpenItem = {}
		arg_3_0.firstOpenItem[ERankTab.Arena] = true
		arg_3_0.firstOpenItem[ERankTab.FV] = true
		arg_3_0.firstOpenItem[ERankTab.HeroBestFV] = true
		arg_3_0.firstOpenItem[ERankTab.Bgz] = true
		arg_3_0.firstOpenItem[ERankTab.Pata] = true
		arg_3_0.firstOpenItem[ERankTab.Legion] = true
		arg_3_0.tabSprites = {}
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/rank.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")
		local var_5_3 = tolua.cast(var_5_1:getChildByTag(2), "CCNode")
		local var_5_4 = {
			[ERankTab.Arena] = "image/tab/tab_rank_arena.png",
			[ERankTab.FV] = "image/tab/tab_rank_fv.png",
			[ERankTab.HeroBestFV] = "image/tab/tab_rank_single.png",
			[ERankTab.Bgz] = "image/tab/tab_rank_bgz.png",
			[ERankTab.Pata] = "image/tab/tab_seven_pata.png",
			[ERankTab.Legion] = "image/tab/tab_rank_legion.png"
		}

		arg_3_0.tabImagePaths = var_5_4

		local var_5_5 = {}

		for iter_5_0 = ERankTab.Arena, ERankTab.Legion do
			var_5_5[iter_5_0] = tolua.cast(var_5_3:getChildByTag(iter_5_0), "CCControlButton")

			var_5_5[iter_5_0]:addHandleOfControlEvent(function()
				arg_3_0:onTouch(iter_5_0)
			end, CCControlEventTouchUpInside)
			zbUtil:setButtonTitle(var_5_5[iter_5_0], "")

			arg_3_0.tabSprites[iter_5_0] = CCSprite:create(arg_3_0.tabImagePaths[iter_5_0])

			arg_3_0.tabSprites[iter_5_0]:setAnchorPoint(ccp(0.5, 0.5))
			arg_3_0.tabSprites[iter_5_0]:setPosition(var_5_5[iter_5_0]:getContentSize().width / 2, var_5_5[iter_5_0]:getContentSize().height / 2)
			var_5_5[iter_5_0]:addChild(arg_3_0.tabSprites[iter_5_0])
		end

		arg_3_0.tabButtons = var_5_5
		arg_3_0.lbRefreshDesc = tolua.cast(var_5_2:getChildByTag(1), "CCLabelTTF")
		arg_3_0.spriteLeftBg = tolua.cast(var_5_2:getChildByTag(2), "CCSprite")
		arg_3_0.lbNoRank = tolua.cast(var_5_2:getChildByTag(3), "CCLabelTTF")

		arg_3_0.lbNoRank:setVisible(false)

		for iter_5_1 = 1, 3 do
			local var_5_6 = tolua.cast(var_5_2:getChildByTag(5 + iter_5_1), "CCLayerColor")
			local var_5_7 = createRankTopItem()

			var_5_7:setPosition(var_5_6:getPosition())
			var_5_2:addChild(var_5_7)

			arg_3_0.topItems[iter_5_1] = var_5_7

			var_5_6:removeFromParentAndCleanup(true)
		end

		local var_5_8 = {}

		for iter_5_2 = ERankTab.Arena, ERankTab.Legion do
			arg_3_0.nodeRankList[iter_5_2] = tolua.cast(var_5_2:getChildByTag(iter_5_2 + 10), "CCLayer")

			local var_5_9 = tolua.cast(arg_3_0.nodeRankList[iter_5_2]:getChildByTag(1), "CCLayer")
			local var_5_10 = tolua.cast(arg_3_0.nodeRankList[iter_5_2]:getChildByTag(401), "CCNode")

			if iter_5_2 == ERankTab.Arena or iter_5_2 == ERankTab.FV then
				var_5_8[iter_5_2] = createRankList(var_5_9, var_5_10, arg_3_0.tabButtons[iter_5_2], arg_3_0)
			elseif iter_5_2 == ERankTab.HeroBestFV then
				var_5_8[iter_5_2] = createRankSingleList(var_5_9, var_5_10, arg_3_0.tabButtons[iter_5_2], arg_3_0)
			elseif iter_5_2 == ERankTab.Bgz or iter_5_2 == ERankTab.Pata then
				var_5_8[iter_5_2] = createRankPataList(var_5_9, var_5_10, arg_3_0.tabButtons[iter_5_2], arg_3_0)
			elseif iter_5_2 == ERankTab.Legion then
				var_5_8[iter_5_2] = createRankLegionList(var_5_9, var_5_10, arg_3_0.tabButtons[iter_5_2], arg_3_0)
			end
		end

		arg_3_0.module = var_5_8

		arg_3_0:addChild(var_5_1)

		arg_3_0.firstOpen = true

		arg_3_0:createMoneyPanel(var_5_1, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold
		}, function()
			arg_3_0:hide()
		end)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onRankArenaAck()
	end, zbGameEvent.Event_UpdateArenaRankAck)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onRankCommonAck()
	end, zbGameEvent.Event_UpdateCommonRankAck)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onRankLegionAck()
	end, zbGameEvent.Event_UpdateLegionRankAck)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onRankHeroAck()
	end, zbGameEvent.Event_UpdateHeroRankAck)
end

function var_0_0.refresh(arg_12_0, arg_12_1)
	arg_12_0.eRankTab = arg_12_1

	arg_12_0:doSelectTab()

	if arg_12_1 == ERankTab.Arena then
		arg_12_0:onRankArenaAck()
	elseif arg_12_1 == ERankTab.FV then
		if arg_12_0.firstOpenItem[ERankTab.FV] == true then
			g_WsMsgHandler:WS_Rank_Comm_Req(ERankType.FV)
		else
			arg_12_0:onRankCommonAck()
		end
	elseif arg_12_1 == ERankTab.HeroBestFV then
		if arg_12_0.firstOpenItem[ERankTab.HeroBestFV] == true then
			g_WsMsgHandler:WS_Rank_Hero_Req()
		else
			arg_12_0:onRankHeroAck()
		end
	elseif arg_12_1 == ERankTab.Bgz then
		if arg_12_0.firstOpenItem[ERankTab.Bgz] == true then
			g_WsMsgHandler:WS_Rank_Comm_Req(ERankType.Bgz)
		else
			arg_12_0:onRankCommonAck()
		end
	elseif arg_12_1 == ERankTab.Pata then
		if arg_12_0.firstOpenItem[ERankTab.Pata] == true then
			g_WsMsgHandler:WS_Rank_Comm_Req(ERankType.Pata)
		else
			arg_12_0:onRankCommonAck()
		end
	elseif arg_12_1 == ERankTab.Legion then
		if arg_12_0.firstOpenItem[ERankTab.Legion] == true then
			g_WsMsgHandler:WS_Rank_Legion_Req()
		else
			arg_12_0:onRankLegionAck()
		end
	end
end

function var_0_0.onTouch(arg_13_0, arg_13_1)
	arg_13_0.eRankTab = arg_13_1

	arg_13_0:doSelectTab()
	arg_13_0:refresh(arg_13_0.eRankTab)
end

function var_0_0.doSelectTab(arg_14_0)
	for iter_14_0 = ERankTab.Arena, ERankTab.Legion do
		if arg_14_0.module[iter_14_0] then
			if iter_14_0 ~= arg_14_0.eRankTab then
				arg_14_0.nodeRankList[iter_14_0]:setVisible(false)
				arg_14_0.tabButtons[iter_14_0]:setEnabled(true)
				arg_14_0.tabSprites[iter_14_0]:setGray(true)
			else
				arg_14_0.nodeRankList[iter_14_0]:setVisible(true)
				arg_14_0.tabButtons[iter_14_0]:setEnabled(false)
				arg_14_0.tabSprites[iter_14_0]:setGray(false)
			end
		end
	end

	if arg_14_0.eRankTab == ERankTab.Arena then
		arg_14_0.lbRefreshDesc:setString(a2u("ʵʱ\xB8\xFC\xD0\xC2\xC5\xC5\xD0а\xF1"))
	else
		arg_14_0.lbRefreshDesc:setString(a2u("ÿ\xC8\xD504:00\xB8\xFC\xD0\xC2\xC5\xC5\xD0а\xF1"))
	end

	for iter_14_1 = 1, 3 do
		arg_14_0.topItems[iter_14_1]:setVisible(arg_14_0.eRankTab == ERankTab.Arena or arg_14_0.eRankTab == ERankTab.FV or arg_14_0.eRankTab == ERankTab.HeroBestFV)
	end

	arg_14_0.spriteLeftBg:setVisible(arg_14_0.eRankTab == ERankTab.Arena or arg_14_0.eRankTab == ERankTab.FV or arg_14_0.eRankTab == ERankTab.HeroBestFV)
end

function var_0_0.onFrameUpdate(arg_15_0, arg_15_1)
	if arg_15_0.module[arg_15_0.eRankTab] then
		arg_15_0.module[arg_15_0.eRankTab]:onFrame()
	end

	arg_15_0:updateBackEffect()
end

function var_0_0.onRankArenaAck(arg_16_0)
	arg_16_0.module[arg_16_0.eRankTab]:refresh(arg_16_0.eRankTab)

	for iter_16_0 = 1, 3 do
		arg_16_0.topItems[iter_16_0]:setVisible(false)
	end

	local var_16_0 = 1

	for iter_16_1, iter_16_2 in pairs(g_Self.kRankHandler.ArenaRankList) do
		if iter_16_2.Rank == 1 then
			arg_16_0.topItems[1]:refresh(iter_16_2, arg_16_0.eRankTab)
		elseif iter_16_2.Rank == 2 then
			arg_16_0.topItems[2]:refresh(iter_16_2, arg_16_0.eRankTab)
		elseif iter_16_2.Rank == 3 then
			arg_16_0.topItems[3]:refresh(iter_16_2, arg_16_0.eRankTab)

			return
		end
	end
end

function var_0_0.onRankHeroAck(arg_17_0)
	arg_17_0.module[arg_17_0.eRankTab]:refresh(arg_17_0.eRankTab)

	arg_17_0.firstOpenItem[arg_17_0.eRankTab] = false

	for iter_17_0 = 1, 3 do
		arg_17_0.topItems[iter_17_0]:setVisible(false)
	end

	local var_17_0 = 1

	for iter_17_1, iter_17_2 in pairs(g_Self.kRankHandler.HeroRankList) do
		if iter_17_2.Rank == 1 then
			arg_17_0.topItems[1]:refresh(iter_17_2, arg_17_0.eRankTab)
		elseif iter_17_2.Rank == 2 then
			arg_17_0.topItems[2]:refresh(iter_17_2, arg_17_0.eRankTab)
		elseif iter_17_2.Rank == 3 then
			arg_17_0.topItems[3]:refresh(iter_17_2, arg_17_0.eRankTab)

			return
		end
	end
end

function var_0_0.onRankCommonAck(arg_18_0)
	arg_18_0.module[arg_18_0.eRankTab]:refresh(arg_18_0.eRankTab)

	arg_18_0.firstOpenItem[arg_18_0.eRankTab] = false

	if arg_18_0.eRankTab == ERankTab.FV then
		for iter_18_0 = 1, 3 do
			arg_18_0.topItems[iter_18_0]:setVisible(false)
		end

		local var_18_0 = 1

		for iter_18_1, iter_18_2 in pairs(g_Self.kRankHandler.FVRankData.RankList) do
			if iter_18_2.RankInfo.Rank == 1 then
				arg_18_0.topItems[1]:refresh(iter_18_2, arg_18_0.eRankTab)
			elseif iter_18_2.RankInfo.Rank == 2 then
				arg_18_0.topItems[2]:refresh(iter_18_2, arg_18_0.eRankTab)
			elseif iter_18_2.RankInfo.Rank == 3 then
				arg_18_0.topItems[3]:refresh(iter_18_2, arg_18_0.eRankTab)

				return
			end
		end
	end
end

function var_0_0.onRankLegionAck(arg_19_0)
	arg_19_0.module[arg_19_0.eRankTab]:refresh()

	arg_19_0.firstOpenItem[arg_19_0.eRankTab] = false
end
