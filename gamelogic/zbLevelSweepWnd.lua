require("gamelogic.zbLevelSweepAward")

local var_0_0 = class("zbLevelSweepWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createLevelSweepWnd()
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
		arg_3_0.forceId = -1
		arg_3_0.levelId = -1
		arg_3_0.levelType = -1
		arg_3_0.levelAwardList = nil
		arg_3_0.extraAwardList = nil
		arg_3_0.items = {}
		arg_3_0.tableview = nil
		arg_3_0.tableviewHelper = nil
		arg_3_0.checkedLevelUp = false
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/level_sweep.ccbi", var_5_0, true, "")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.layerContent = tolua.cast(var_5_2:getChildByTag(1), "CCLayerColor")
		arg_3_0.spriteExp = tolua.cast(var_5_2:getChildByTag(2), "CCSprite")
		arg_3_0.lbRoleExp = tolua.cast(var_5_2:getChildByTag(3), "CCLabelTTF")
		arg_3_0.btnSweedTenContinue = tolua.cast(var_5_2:getChildByTag(11), "CCControlButton")
		arg_3_0.btnSweedContinue = tolua.cast(var_5_2:getChildByTag(12), "CCControlButton")
		arg_3_0.btnResetBuy = tolua.cast(var_5_2:getChildByTag(13), "CCControlButton")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnSweedTenContinue:addHandleOfControlEvent(function()
			arg_3_0:onContinueTenSweep()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnSweedContinue:addHandleOfControlEvent(function()
			arg_3_0:onContinueSweep()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnResetBuy:addHandleOfControlEvent(function()
			arg_3_0:onResetEliteLevel()
		end, CCControlEventTouchUpInside)

		arg_3_0.layerTouchTest = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)

		arg_3_0.animNode = CCNode:create()

		arg_3_0.animNode:retain()
		arg_3_0:addChild(arg_3_0.animNode)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setHideCallback(function()
		arg_3_0:onHide()
	end)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:updateSweep()
	end, zbGameEvent.Event_ResetEliteLevel_Ack)
end

function var_0_0.onHide(arg_13_0)
	if g_Self.kFriendHandler:haveNewBoss() == true then
		g_MainScene:showFriendBossWnd(g_Self.kFriendHandler.newBossInfo)
	end
end

function var_0_0.refresh(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5, arg_14_6)
	arg_14_0.forceId = arg_14_1
	arg_14_0.levelId = arg_14_2
	arg_14_0.levelType = arg_14_3
	arg_14_0.levelAwardList = arg_14_4
	arg_14_0.extraAwardList = arg_14_5

	for iter_14_0, iter_14_1 in pairs(arg_14_0.items) do
		iter_14_1:removeFromParentAndCleanup(false)
	end

	if arg_14_0.tableView ~= nil then
		arg_14_0.tableView:removeFromParentAndCleanup(true)

		arg_14_0.tableView = nil
		arg_14_0.tableViewHelper = nil
	end

	local var_14_0 = table.getn(arg_14_4) + 1
	local var_14_1 = table.getn(arg_14_0.items)
	local var_14_2 = arg_14_0.layerContent:getContentSize()
	local var_14_3 = CCSizeMake(var_14_2.width, var_14_2.height)

	arg_14_0.tableViewHelper = zbTableViewHelper:create()
	arg_14_0.tableView = zbTableViewHelper:createTableView(var_14_2, var_14_2, 1, arg_14_0.tableViewHelper)

	arg_14_0.tableView:setPosition(0, 0)
	arg_14_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_14_0.layerContent:addChild(arg_14_0.tableView)

	if var_14_0 - var_14_1 > 0 then
		for iter_14_2 = 1, var_14_0 - var_14_1 do
			local var_14_4 = zbTableViewHelper:create()

			var_14_4:loadCCBFile("ccbi/tb_levelsweep.ccbi")

			local var_14_5 = zbLevelSweepAward:create(translateAndStrokeHelper(var_14_4:readCCBNode()))

			var_14_5:retain()
			table.insert(arg_14_0.items, var_14_5)
			var_14_4:releaseSelf()
		end
	end

	local var_14_6 = table.getn(arg_14_4)

	arg_14_0.sweepCount = 0

	local var_14_7 = 1

	if var_14_6 == 1 then
		for iter_14_3, iter_14_4 in pairs(arg_14_4) do
			local var_14_8 = arg_14_0.items[var_14_7]

			var_14_8:refresh(iter_14_4, var_14_7, true)
			arg_14_0.tableViewHelper:addCell(var_14_8)

			var_14_7 = var_14_7 + 1
		end
	else
		for iter_14_5, iter_14_6 in pairs(arg_14_4) do
			local var_14_9 = arg_14_0.items[var_14_7]

			var_14_9:refresh(iter_14_6, var_14_7)
			arg_14_0.tableViewHelper:addCell(var_14_9)

			var_14_7 = var_14_7 + 1
		end
	end

	if var_14_7 <= table.getn(arg_14_0.items) then
		local var_14_10 = arg_14_0.items[var_14_7]

		var_14_10:refreshExtra(arg_14_5)
		arg_14_0.tableViewHelper:addCell(var_14_10)
	end

	arg_14_0.sweepCount = var_14_7

	arg_14_0.tableViewHelper:refreshTabelView()
	arg_14_0.tableViewHelper:setTouchPriority(arg_14_0.btnSweedContinue:getTouchPriority())
	arg_14_0:createAnimEffect(var_14_0)
	arg_14_0.lbRoleExp:setVisible(arg_14_6 ~= nil)
	arg_14_0.spriteExp:setVisible(arg_14_6 ~= nil)

	if arg_14_6 ~= nil and arg_14_6 > 0 then
		arg_14_0.lbRoleExp:setString("+" .. arg_14_6)
	end

	arg_14_0.checkedLevelUp = false
end

function var_0_0.getNeedTili(arg_15_0, arg_15_1)
	local var_15_0, var_15_1 = zbForceSetTable:getLoginAndWinTili(arg_15_0.levelId, arg_15_0.levelType)

	return (var_15_0 + var_15_1) * arg_15_1
end

function var_0_0.onContinueSweep(arg_16_0)
	if g_Self.kFriendHandler:haveNewBoss() == true then
		arg_16_0:hide()

		return
	end

	if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Tili, arg_16_0:getNeedTili(1)) == false then
		g_MainScene:showGoldenTouch(EExchangeType.Tili)
		g_Bubble:bubbleInfo(a2u("\xD3\xE3\xB8ɲ\xBB\xD7\xE3"))

		return
	end

	if arg_16_0.levelType == ELevelType.ELevelMode_Elite then
		local var_16_0 = zbForceTable:getRecord(arg_16_0.forceId)
		local var_16_1 = g_Self.kWarPathHandler:getLevelInfo(arg_16_0.levelType, arg_16_0.forceId, arg_16_0.levelId)

		if var_16_1 ~= nil and var_16_0.eliteMaxFight - var_16_1.FightCount <= 0 then
			g_Bubble:bubbleInfo(a2u("\xB8ùؿ\xA8\xBD\xF8\xC8\xEB\xB4\xCE\xCA\xFD\xD2Ѵﱾ\xC8\xD5\xC9\xCF\xCFޣ\xAC\xC7\xEB\xCF\xC8\xD6\xD8\xD6\xC3"))

			return
		end
	elseif arg_16_0.levelType == ELevelType.ELevelMode_Nightmare then
		local var_16_2 = zbForceTable:getRecord(arg_16_0.forceId)
		local var_16_3 = g_Self.kWarPathHandler:getLevelInfo(arg_16_0.levelType, arg_16_0.forceId, arg_16_0.levelId)

		if var_16_3 ~= nil and var_16_2.nightmareMaxFight - var_16_3.FightCount <= 0 then
			g_Bubble:bubbleInfo(a2u("\xB8ùؿ\xA8\xBD\xF8\xC8\xEB\xB4\xCE\xCA\xFD\xD2Ѵﱾ\xC8\xD5\xC9\xCF\xCFޣ\xAC\xC7\xEB\xCF\xC8\xD6\xD8\xD6\xC3"))

			return
		end
	end

	g_WsMsgHandler:WS_GameLevel_SaoDang_Req(arg_16_0.forceId, arg_16_0.levelId, arg_16_0.levelType, 1)
end

function var_0_0.onContinueTenSweep(arg_17_0)
	if g_Self.kFriendHandler:haveNewBoss() == true then
		arg_17_0:hide()

		return
	end

	if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Tili, arg_17_0:getNeedTili(10)) == false then
		g_MainScene:showGoldenTouch(EExchangeType.Tili)
		g_Bubble:bubbleInfo(a2u("\xD3\xE3\xB8ɲ\xBB\xD7\xE3"))

		return
	end

	g_WsMsgHandler:WS_GameLevel_SaoDang_Req(arg_17_0.forceId, arg_17_0.levelId, arg_17_0.levelType, 10)
end

function var_0_0.onResetEliteLevel(arg_18_0)
	local function var_18_0()
		g_WsMsgHandler:WS_GameLevel_Reset_Req(arg_18_0.forceId, arg_18_0.levelId, arg_18_0.levelType)
	end

	local var_18_1 = g_Self.kWarPathHandler:getLevelInfo(arg_18_0.levelType, arg_18_0.forceId, arg_18_0.levelId)
	local var_18_2 = zbVipTable:getRecord(g_Self:getVipLevel())
	local var_18_3 = 0

	if var_18_2 and var_18_2.eliteLevelResetNum <= var_18_1.RefreshCount then
		g_Bubble:bubbleInfo(a2u("\xD6\xD8\xD6ô\xCE\xCA\xFD\xD2\xD1\xD3\xC3\xCD\xEA"))

		return
	end

	local var_18_4 = g_DataConfig.kForceBaseTable.resetDiamond[1]
	local var_18_5 = table.getn(g_DataConfig.kForceBaseTable.resetDiamond)

	if var_18_5 >= var_18_1.RefreshCount + 1 then
		var_18_4 = g_DataConfig.kForceBaseTable.resetDiamond[var_18_1.RefreshCount + 1]
	else
		var_18_4 = g_DataConfig.kForceBaseTable.resetDiamond[var_18_5]
	end

	local var_18_6 = string.format(a2u("\xD6\xD8\xD6ùؿ\xA8\xB4\xCE\xCA\xFD\xD0\xE8Ҫ\xBB\xA8\xB7\xD1") .. var_18_4 .. a2u("\xD7\xEAʯ\xA3\xAC\xCAǷ\xF1\xBC\xCC\xD0\xF8\xA3\xBF\xA3\xA8\xBD\xF1\xC8\xD5\xD2\xD1\xD6\xD8\xD6\xC3") .. var_18_1.RefreshCount .. a2u("\xB4\xCE)"))

	g_MessageBox:showYesNo(var_18_6, var_18_0)
end

function var_0_0.updateSweep(arg_20_0)
	if arg_20_0.levelType == ELevelType.Elite then
		arg_20_0.btnSweedTenContinue:setVisible(false)

		local var_20_0 = zbForceTable:getRecord(arg_20_0.forceId)
		local var_20_1 = g_Self.kWarPathHandler:getLevelInfo(arg_20_0.levelType, arg_20_0.forceId, arg_20_0.levelId)

		if var_20_1 ~= nil and var_20_0.eliteMaxFight - var_20_1.FightCount <= 0 then
			arg_20_0.btnSweedContinue:setVisible(false)
			arg_20_0.btnResetBuy:setVisible(true)
		else
			arg_20_0.btnSweedContinue:setVisible(true)
			arg_20_0.btnResetBuy:setVisible(false)
		end
	elseif arg_20_0.levelType == ELevelType.Nightmare then
		arg_20_0.btnSweedTenContinue:setVisible(false)

		local var_20_2 = zbForceTable:getRecord(arg_20_0.forceId)
		local var_20_3 = g_Self.kWarPathHandler:getLevelInfo(arg_20_0.levelType, arg_20_0.forceId, arg_20_0.levelId)

		if var_20_3 ~= nil and var_20_2.nightmareMaxFight - var_20_3.FightCount <= 0 then
			arg_20_0.btnSweedContinue:setVisible(false)
			arg_20_0.btnResetBuy:setVisible(true)
		else
			arg_20_0.btnSweedContinue:setVisible(true)
			arg_20_0.btnResetBuy:setVisible(false)
		end
	end
end

function var_0_0.onTouchTest(arg_21_0)
	local var_21_0 = arg_21_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_21_0.layerTouchTest, var_21_0.x, var_21_0.y) == false and zbUtil:PointInCtrl(arg_21_0.btnClose, var_21_0.x, var_21_0.y) == false then
		arg_21_0:hide()
	end
end

local var_0_1 = 0.15
local var_0_2 = 0.15

function var_0_0.createAnimEffect(arg_22_0, arg_22_1)
	local function var_22_0(arg_23_0)
		local var_23_0 = {}
		local var_23_1

		if arg_23_0.layerAward:isVisible() then
			var_23_0 = arg_23_0.items
		elseif arg_23_0.layerAwardExtra:isVisible() then
			var_23_0 = arg_23_0.itemsExtra
		end

		local var_23_2 = var_0_1

		for iter_23_0, iter_23_1 in pairs(var_23_0) do
			if iter_23_1:isVisible() then
				var_23_2 = var_23_2 + var_0_1
			end
		end

		return var_23_2
	end

	arg_22_0.fadeLineIndex = 0

	local function var_22_1()
		arg_22_0.fadeLineIndex = arg_22_0.fadeLineIndex + 1

		local var_24_0 = arg_22_0.items[arg_22_0.fadeLineIndex]

		if var_24_0 ~= nil then
			var_24_0:setVisible(true)
			arg_22_0:fadeLine(var_24_0)
		end
	end

	local function var_22_2()
		local var_25_0 = tolua.cast(arg_22_0.tableView, "CCScrollView")
		local var_25_1 = arg_22_0.layerContent:getContentSize()
		local var_25_2 = var_25_0:getContentOffset()
		local var_25_3 = math.min(var_25_2.y + 160, 0)

		var_25_0:setContentOffsetInDuration(ccp(0, var_25_3), var_0_2)
	end

	local function var_22_3()
		arg_22_0.btnClose:setVisible(true)
		arg_22_0.btnTouchTest:setVisible(true)
		arg_22_0.tableViewHelper:setCanMove(true)
		tolua.cast(arg_22_0.tableView, "CCScrollView"):setBounceable(true)
		arg_22_0.btnSweedContinue:setVisible(arg_22_1 <= 2)
		arg_22_0.btnSweedTenContinue:setVisible(arg_22_1 >= 11)

		if arg_22_0.levelType == ELevelType.Elite then
			arg_22_0.btnSweedTenContinue:setVisible(false)

			local var_26_0 = zbForceTable:getRecord(arg_22_0.forceId)
			local var_26_1 = g_Self.kWarPathHandler:getLevelInfo(arg_22_0.levelType, arg_22_0.forceId, arg_22_0.levelId)

			if var_26_1 ~= nil and var_26_0.eliteMaxFight - var_26_1.FightCount <= 0 then
				arg_22_0.btnSweedContinue:setVisible(false)
				arg_22_0.btnResetBuy:setVisible(true)
			end
		elseif arg_22_0.levelType == ELevelType.Nightmare then
			arg_22_0.btnSweedTenContinue:setVisible(false)

			local var_26_2 = zbForceTable:getRecord(arg_22_0.forceId)
			local var_26_3 = g_Self.kWarPathHandler:getLevelInfo(arg_22_0.levelType, arg_22_0.forceId, arg_22_0.levelId)

			if var_26_3 ~= nil and var_26_2.nightmareMaxFight - var_26_3.FightCount <= 0 then
				arg_22_0.btnSweedContinue:setVisible(false)
				arg_22_0.btnResetBuy:setVisible(true)
			end
		end
	end

	local var_22_4 = CCArray:create()

	for iter_22_0 = 1, arg_22_0.sweepCount do
		local var_22_5 = arg_22_0.items[iter_22_0]

		if var_22_5 ~= nil then
			var_22_5:setVisible(false)

			local var_22_6 = var_22_0(var_22_5)

			var_22_4:addObject(CCCallFuncN:create(var_22_1))
			var_22_4:addObject(CCDelayTime:create(var_22_6))
			var_22_4:addObject(CCCallFuncN:create(var_22_2))

			if iter_22_0 == arg_22_0.sweepCount then
				var_22_4:addObject(CCCallFuncN:create(var_22_3))
			else
				var_22_4:addObject(CCDelayTime:create(var_0_2))
			end
		end
	end

	arg_22_0.animNode:stopAllActions()
	arg_22_0.animNode:runAction(CCSequence:create(var_22_4))
	arg_22_0.btnSweedTenContinue:setVisible(false)
	arg_22_0.btnSweedContinue:setVisible(false)
	arg_22_0.btnResetBuy:setVisible(false)
	arg_22_0.btnClose:setVisible(false)
	arg_22_0.btnTouchTest:setVisible(false)
	arg_22_0.tableViewHelper:setCanMove(false)

	local var_22_7 = tolua.cast(arg_22_0.tableView, "CCScrollView")

	var_22_7:setBounceable(false)

	arg_22_0.scrollInitOffset = var_22_7:getContentOffset()
end

function var_0_0.fadeLine(arg_27_0, arg_27_1)
	local var_27_0 = {}
	local var_27_1

	if arg_27_1.layerAward:isVisible() then
		var_27_0 = arg_27_1.items
		var_27_1 = arg_27_1.lbAwardTitle
	elseif arg_27_1.layerAwardExtra:isVisible() then
		var_27_0 = arg_27_1.itemsExtra
		var_27_1 = arg_27_1.lbAwardExtraTitle
	end

	local var_27_2 = 0 + arg_27_0:fadeTitle(var_27_1)

	for iter_27_0, iter_27_1 in pairs(var_27_0) do
		if iter_27_1:isVisible() then
			var_27_2 = var_27_2 + arg_27_0:fadeNode(iter_27_1, var_27_2)
		end
	end

	return var_27_2
end

function var_0_0.fadeTitle(arg_28_0, arg_28_1)
	local function var_28_0(arg_29_0)
		arg_29_0:setVisible(true)
	end

	local var_28_1 = CCArray:create()

	var_28_1:addObject(CCCallFuncN:create(var_28_0))
	var_28_1:addObject(CCScaleTo:create(var_0_1 / 2, 1.2))
	var_28_1:addObject(CCScaleTo:create(var_0_1 / 2, 0.9))
	arg_28_1:setVisible(false)
	arg_28_1:stopAllActions()
	arg_28_1:runAction(CCSequence:create(var_28_1))

	return var_0_1
end

function var_0_0.fadeNode(arg_30_0, arg_30_1, arg_30_2)
	local function var_30_0(arg_31_0)
		arg_31_0:setVisible(true)
	end

	local var_30_1 = CCArray:create()

	var_30_1:addObject(CCDelayTime:create(arg_30_2))
	var_30_1:addObject(CCCallFuncN:create(var_30_0))
	var_30_1:addObject(CCScaleTo:create(var_0_1 / 2, 1.1))
	var_30_1:addObject(CCScaleTo:create(var_0_1 / 2, 0.9))
	arg_30_1:setVisible(false)
	arg_30_1:stopAllActions()
	arg_30_1:runAction(CCSequence:create(var_30_1))

	return var_0_1
end

function var_0_0.onFrameUpdate(arg_32_0)
	if arg_32_0.checkedLevelUp == false and g_Self:isNeedShowLevelUp() and (arg_32_0.btnSweedTenContinue:isVisible() or arg_32_0.btnSweedContinue:isVisible() or arg_32_0.btnResetBuy:isVisible() or arg_32_0.btnClose:isVisible()) then
		arg_32_0.checkedLevelUp = true

		g_MainScene:checkShowLevelUpWnd()
	end
end
