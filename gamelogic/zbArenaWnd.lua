require("gamelogic.zbBaseWnd")
require("gamelogic.zbArenaItem")
require("gamelogic.zbItem")

local var_0_0 = class("zbArenaWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createArenaWnd()
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
		arg_3_0.playerItems = {}
		arg_3_0.heroItems = {}
		arg_3_0.openTime = g_Self.kTimeHandler:getServerTime()
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/arena.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCLayer")
		local var_5_4 = tolua.cast(var_5_3:getChildByTag(1), "CCNode")

		arg_3_0.spriteIcon = tolua.cast(var_5_4:getChildByTag(1), "CCSprite")

		local var_5_5 = tolua.cast(var_5_4:getChildByTag(1002), "CCLabelTTF")
		local var_5_6 = tolua.cast(var_5_4:getChildByTag(1003), "CCLabelTTF")

		arg_3_0.nodeCurGod = tolua.cast(var_5_3:getChildByTag(2), "CCLayer")
		arg_3_0.spriteGodIcon = tolua.cast(arg_3_0.nodeCurGod:getChildByTag(1), "CCSprite")

		local var_5_7 = tolua.cast(arg_3_0.nodeCurGod:getChildByTag(1002), "CCLabelTTF")
		local var_5_8 = tolua.cast(var_5_3:getChildByTag(3), "CCNode")

		for iter_5_0 = 1, 5 do
			local var_5_9 = tolua.cast(var_5_8:getChildByTag(iter_5_0), "CCNode")

			var_5_9:setVisible(false)

			local var_5_10 = createItem()

			var_5_10:setPosition(var_5_9:getPosition())
			var_5_10:setScale(0.8)

			arg_3_0.heroItems[iter_5_0] = var_5_10

			var_5_8:addChild(var_5_10)
			var_5_9:removeFromParentAndCleanup(true)
		end

		local var_5_11 = tolua.cast(var_5_3:getChildByTag(4), "CCNode")

		for iter_5_1 = 1, 5 do
			local var_5_12 = zbTableViewHelper:create()

			var_5_12:loadCCBFile("ccbi/tb_arena.ccbi")

			local var_5_13 = tolua.cast(var_5_11:getChildByTag(10 + iter_5_1), "CCNode")
			local var_5_14 = createArenaItem(translateAndStrokeHelper(var_5_12:readCCBNode()))

			var_5_14:setPosition(var_5_13:getPosition())

			arg_3_0.playerItems[iter_5_1] = var_5_14

			var_5_11:addChild(var_5_14)
			var_5_13:removeFromParentAndCleanup(true)
			var_5_12:releaseSelf()
		end

		local var_5_15 = tolua.cast(var_5_3:getChildByTag(1005), "CCLabelTTF")

		arg_3_0.btnFormation = tolua.cast(var_5_3:getChildByTag(6), "CCControlButton")
		arg_3_0.awardNode = tolua.cast(var_5_2:getChildByTag(2), "CCNode")
		arg_3_0.spriteMoney1 = tolua.cast(arg_3_0.awardNode:getChildByTag(1), "CCSprite")

		local var_5_16 = tolua.cast(arg_3_0.awardNode:getChildByTag(1003), "CCLabelTTF")

		arg_3_0.spriteMoney2 = tolua.cast(arg_3_0.awardNode:getChildByTag(4), "CCSprite")

		local var_5_17 = tolua.cast(arg_3_0.awardNode:getChildByTag(1005), "CCLabelTTF")
		local var_5_18 = tolua.cast(var_5_2:getChildByTag(3), "CCNode")

		arg_3_0.btnRank = tolua.cast(var_5_18:getChildByTag(1), "CCControlButton")
		arg_3_0.btnRule = tolua.cast(var_5_18:getChildByTag(2), "CCControlButton")
		arg_3_0.btnRecord = tolua.cast(var_5_18:getChildByTag(3), "CCControlButton")
		arg_3_0.btnDeclare = tolua.cast(var_5_18:getChildByTag(4), "CCControlButton")

		local var_5_19 = tolua.cast(var_5_2:getChildByTag(4), "CCNode")
		local var_5_20 = tolua.cast(var_5_19:getChildByTag(1001), "CCLabelTTF")

		arg_3_0.btnChangeAll = tolua.cast(var_5_19:getChildByTag(2), "CCControlButton")
		arg_3_0.btnReset = tolua.cast(var_5_19:getChildByTag(3), "CCControlButton")
		arg_3_0.nodeDeclare = tolua.cast(var_5_2:getChildByTag(5), "CCNode")
		arg_3_0.btnTouchTest = tolua.cast(arg_3_0.nodeDeclare:getChildByTag(0), "CCControlButton")
		arg_3_0.btnSend = tolua.cast(arg_3_0.nodeDeclare:getChildByTag(3), "CCControlButton")

		local var_5_21 = tolua.cast(arg_3_0.nodeDeclare:getChildByTag(1), "CCLayer")
		local var_5_22 = tolua.cast(arg_3_0.nodeDeclare:getChildByTag(2), "CCScrollView")
		local var_5_23 = ccc3(184, 167, 144)

		arg_3_0.inputBox = zbUtil:createEditBox(var_5_21, a2u("һȺս\xCE\xE5\xD4\xFC\xA3\xA1\xB2\xBB\xB7\xFE\xC0\xB4ս"), MAX_CHAT_LEN, "image/common/button_transparent.png", 20, var_5_23)

		var_5_22:addChild(arg_3_0.inputBox)
		var_5_22:setCanMove(false)

		arg_3_0.lbRank = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_5, arg_3_0.lbRank)
		arg_3_0.lbRank:setScale(0.8)

		arg_3_0.lbCombatPower = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_15, arg_3_0.lbCombatPower)
		arg_3_0.lbCombatPower:setScale(0.6)

		arg_3_0.lbLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_6, arg_3_0.lbLevel)
		arg_3_0.lbLevel:setScale(0.5)

		arg_3_0.lbCurGodLv = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_7, arg_3_0.lbCurGodLv)
		arg_3_0.lbCurGodLv:setScale(0.5)

		arg_3_0.lbMoney1 = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_16, arg_3_0.lbMoney1)
		arg_3_0.lbMoney1:setScale(0.5)

		arg_3_0.lbMoney2 = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_17, arg_3_0.lbMoney2)
		arg_3_0.lbMoney2:setScale(0.5)

		arg_3_0.lbCount = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_20, arg_3_0.lbCount)
		arg_3_0.lbCount:setScale(0.7)
		arg_3_0.btnFormation:addHandleOfControlEvent(function()
			arg_3_0:onFormation()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnRank:addHandleOfControlEvent(function()
			arg_3_0:onRank()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnRule:addHandleOfControlEvent(function()
			arg_3_0:onRule()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnRecord:addHandleOfControlEvent(function()
			arg_3_0:onRecord()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnDeclare:addHandleOfControlEvent(function()
			arg_3_0:onDeclare()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnChangeAll:addHandleOfControlEvent(function()
			arg_3_0:onChangeAll()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnReset:addHandleOfControlEvent(function()
			arg_3_0:onCountReset()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnSend:addHandleOfControlEvent(function()
			arg_3_0:onSend()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)
		arg_3_0:addChild(var_5_1)
		arg_3_0:createMoneyPanel(var_5_1, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold,
			EMoneyPanelResType.Arena
		}, function()
			arg_3_0:hide()
		end)
		arg_3_0.nodeDeclare:setVisible(false)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(function()
		arg_3_0:onShowCallback()
	end)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refreshRoleInfo()
	end, zbGameEvent.Event_Update_BaseInfo)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refresh()
	end, zbGameEvent.Event_Update_Arena)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refreshMyFormation()
	end, zbGameEvent.Event_Update_Formation)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onBalanceOverWin()
	end, zbGameEvent.Event_BalanceOver_Win)
end

function var_0_0.onShowCallback(arg_21_0)
	g_WsMsgHandler:WS_Arena_GetData_Req()
end

function var_0_0.refresh(arg_22_0)
	arg_22_0:refreshTableView()
	arg_22_0:refreshMyFormation()
	arg_22_0:refreshCombatInfo()
	arg_22_0:refreshRoleInfo()
end

function var_0_0.refreshTableView(arg_23_0)
	for iter_23_0, iter_23_1 in pairs(arg_23_0.playerItems) do
		iter_23_1:setVisible(false)
	end

	if g_Self.kArenaHandler.PlayerList ~= nil then
		local var_23_0 = 1

		for iter_23_2, iter_23_3 in pairs(g_Self.kArenaHandler.PlayerList) do
			local var_23_1 = arg_23_0.playerItems[var_23_0]

			if var_23_0 <= 5 then
				var_23_1:refresh(iter_23_3)
				var_23_1:setVisible(true)

				var_23_0 = var_23_0 + 1
			end
		end
	end
end

function var_0_0.refreshCombatInfo(arg_24_0)
	local var_24_0 = g_Self.kArenaHandler.ArenaCombatInfo

	if var_24_0 ~= nil then
		arg_24_0.lbCount:setString(var_24_0.MaxCombatCount - var_24_0.CombatCount .. "/" .. var_24_0.MaxCombatCount)
		arg_24_0.btnReset:setVisible(var_24_0.CombatCount >= var_24_0.MaxCombatCount)
		arg_24_0.btnChangeAll:setVisible(var_24_0.CombatCount < var_24_0.MaxCombatCount)
	end
end

function var_0_0.refreshRoleInfo(arg_25_0)
	local var_25_0 = zbIconHelper:getPlayerHeadIconPath(g_GameData.BaseInfo.HeadId)

	arg_25_0.spriteIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_25_0))
	arg_25_0.lbLevel:setString(g_Self:getLevel())

	local var_25_1 = g_Self.kArenaHandler.ArenaBaseInfo

	if var_25_1 ~= nil then
		if var_25_1.Signature ~= "" then
			arg_25_0.inputBox:setText(a2u(var_25_1.Signature))
		end

		arg_25_0.lbRank:setString(var_25_1.Rank)

		local var_25_2 = zbArenaDailyAwardTable:getRecord(var_25_1.Rank)

		arg_25_0.awardNode:setVisible(var_25_2 ~= nil)

		if var_25_2 then
			arg_25_0.lbMoney1:setString(var_25_2.diamond)
			arg_25_0.lbMoney2:setString(var_25_2.rankMoney)
		end
	end
end

function var_0_0.refreshMyFormation(arg_26_0)
	for iter_26_0 = 1, 5 do
		arg_26_0.heroItems[iter_26_0]:setVisible(false)
	end

	local var_26_0 = g_Self.kFormation:getWorkingHero()
	local var_26_1 = 1

	for iter_26_1, iter_26_2 in pairs(var_26_0) do
		if var_26_1 <= 5 then
			arg_26_0.heroItems[var_26_1]:refreshHero(iter_26_2)
			arg_26_0.heroItems[var_26_1]:setVisible(true)
		end

		var_26_1 = var_26_1 + 1
	end

	local var_26_2 = g_GameData.GodInfo

	if var_26_2 ~= nil then
		local var_26_3 = zbGodBaseTable:getRecord(var_26_2.GodId)

		if var_26_3 ~= nil then
			arg_26_0.spriteGodIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_26_3.iconPath))
			arg_26_0.lbCurGodLv:setString(var_26_2.Level)
		end
	else
		arg_26_0.nodeCurGod:setVisible(false)
	end

	arg_26_0.lbCombatPower:setString(g_Self.kFormation:getCombatPower())
end

function var_0_0.onFormation(arg_27_0)
	g_MainScene:showFormationWnd()
end

function var_0_0.onRank(arg_28_0)
	if zbFunHelper:isBuildingLockAndTip(EBuildingType.Rank) then
		return
	end

	g_WsMsgHandler:WS_Rank_Arena_Req()
end

function var_0_0.onRule(arg_29_0)
	g_MainScene:showRuleArenaWnd()
end

function var_0_0.onRecord(arg_30_0)
	g_MainScene:showArenaRecordWnd()
end

function var_0_0.onChangeAll(arg_31_0)
	g_WsMsgHandler:WS_Arena_GetData_Req()
end

function var_0_0.onCountReset(arg_32_0)
	local var_32_0 = 0
	local var_32_1 = 100

	local function var_32_2()
		if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Diamond, var_32_1) == false then
			g_Bubble:bubbleInfo(a2u("\xD7\xEAʯ\xB2\xBB\xD7\xE3"))

			return
		end

		g_WsMsgHandler:WS_Arena_Reset_Req()
	end

	local var_32_3 = g_DataConfig.kArenaBaseTable.resetDiamond
	local var_32_4 = g_Self.kArenaHandler.ArenaCombatInfo
	local var_32_5 = zbVipTable:getRecord(g_Self:getVipLevel())
	local var_32_6 = 0

	if var_32_5 then
		var_32_6 = var_32_5.arenaResetNum
	end

	if var_32_4 ~= nil and var_32_3 ~= nil then
		var_32_0 = var_32_4.ResetCount
		var_32_1 = var_32_3[var_32_0 + 1]

		if var_32_1 == nil then
			var_32_1 = var_32_3[table.getn(var_32_3)]
		end

		if var_32_6 <= var_32_0 then
			g_Bubble:bubbleInfo(a2u("\xBD\xF1\xC8\xD5\xD6\xD8\xD6ô\xCE\xCA\xFD\xD2\xD1\xD3\xC3\xCD\xEA"))

			return
		end
	end

	local var_32_7 = a2u("\xBD\xF1\xC8\xD5\xD2\xD1\xD6\xD8\xD6\xC3") .. var_32_0 .. "/" .. var_32_6 .. a2u("\xB4\xCE,\xB1\xBE\xB4\xCE\xD6\xD8\xD6\xC3\xD0\xE8Ҫ") .. var_32_1 .. a2u("\xD7\xEAʯ")

	g_MessageBox:showYesNo(var_32_7, var_32_2)
end

function var_0_0.onDeclare(arg_34_0)
	arg_34_0.nodeDeclare:setVisible(true)
end

function var_0_0.onSend(arg_35_0)
	local var_35_0 = arg_35_0.inputBox:getText()

	if var_35_0 == "" then
		g_Bubble:bubbleInfo(a2u("\xC7\xEB\xCA\xE4\xC8\xEBս\xB6\xB7\xD0\xFB\xD1\xD4"))

		return
	end

	local var_35_1 = zbUtil:repValidText(var_35_0)

	arg_35_0.nodeDeclare:setVisible(false)
	g_WsMsgHandler:WS_Arena_Signature_Req(var_35_1)
end

function var_0_0.onTouchTest(arg_36_0)
	local var_36_0 = arg_36_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_36_0.nodeDeclare, var_36_0.x, var_36_0.y) == false then
		arg_36_0.nodeDeclare:setVisible(false)
	end
end

function var_0_0.canChanllenge(arg_37_0)
	local var_37_0 = g_Self.kFormation:getWorkingHero()

	if table.getn(var_37_0) <= 0 then
		g_Bubble:bubbleInfo(a2u("\xC7\xEB\xCF\xC8\xC9\xE8\xD6\xC3\xD5\xF3\xC8\xDD"))

		return false
	end

	if arg_37_0.btnChangeAll:isVisible() then
		return true
	elseif arg_37_0.btnReset:isVisible() then
		g_Bubble:bubbleInfo(a2u("\xCC\xF4ս\xB4\xCE\xCA\xFD\xD2\xD1\xD3\xC3\xCD\xEA"))

		return false
	end

	return false
end

function var_0_0.onBalanceOverWin(arg_38_0)
	if g_MainScene.wndEmbattle == nil or g_MainScene.wndEmbattle.battleMode ~= EMBATTLE_TYPE_ARENA then
		return
	end

	if g_Self.kArenaHandler.IsBestRank > 0 then
		g_MainScene:showArenaHistoryBestWnd()
	else
		g_MainScene:showArenaRankUp()
	end
end

function var_0_0.onFrameUpdate(arg_39_0)
	arg_39_0:updateBackEffect()

	for iter_39_0 = 1, 5 do
		if arg_39_0:getPalyerDeclareIndex() == iter_39_0 then
			arg_39_0.playerItems[iter_39_0]:setDeclareVisible()
		end
	end
end

function var_0_0.getPalyerDeclareIndex(arg_40_0)
	if g_Self.kArenaHandler.PlayerList ~= nil then
		local var_40_0 = table.getn(g_Self.kArenaHandler.PlayerList)
		local var_40_1 = (g_Self.kTimeHandler:getServerTime() - arg_40_0.openTime) % (15 * var_40_0)

		for iter_40_0 = 1, var_40_0 do
			if math.ceil(var_40_1) / 15 == iter_40_0 then
				return iter_40_0
			end
		end
	end

	return nil
end
