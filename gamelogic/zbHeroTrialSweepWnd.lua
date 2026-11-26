require("gamelogic.zbLevelSweepAward")

local var_0_0 = class("zbHeroTrialSweepWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createHeroTrialSweepWnd()
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
		arg_3_0.awardList = {}
		arg_3_0.trialType = 0
		arg_3_0.level = 0
		arg_3_0.items = {}
		arg_3_0.tableview = nil
		arg_3_0.tableviewHelper = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/level_sweep.ccbi", var_5_0, true, "")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.layerContent = tolua.cast(var_5_2:getChildByTag(1), "CCLayerColor")
		arg_3_0.spriteExp = tolua.cast(var_5_2:getChildByTag(2), "CCSprite")
		arg_3_0.lbRoleExp = tolua.cast(var_5_2:getChildByTag(3), "CCLabelTTF")
		arg_3_0.btnSweedTen = tolua.cast(var_5_2:getChildByTag(11), "CCControlButton")
		arg_3_0.btnSweedEnd = tolua.cast(var_5_2:getChildByTag(12), "CCControlButton")
		arg_3_0.btnResetBuy = tolua.cast(var_5_2:getChildByTag(13), "CCControlButton")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnSweedTen:setVisible(false)
		arg_3_0.spriteExp:setVisible(false)
		arg_3_0.lbRoleExp:setVisible(false)
		arg_3_0.btnResetBuy:setVisible(false)
		arg_3_0.btnSweedEnd:addHandleOfControlEvent(function()
			arg_3_0:onContinueSweep()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)

		arg_3_0.animNode = CCNode:create()

		arg_3_0.animNode:retain()
		arg_3_0:addChild(arg_3_0.animNode)

		arg_3_0.layerTouchTest = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setHideCallback(function()
		arg_3_0:onHideCallback()
	end)
end

function var_0_0.onHideCallback(arg_10_0)
	g_MainScene:showHeroTrialDetailWnd(arg_10_0.trialType)
end

function var_0_0.refresh(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0.awardList = arg_11_3
	arg_11_0.trialType = arg_11_1
	arg_11_0.level = arg_11_2

	for iter_11_0, iter_11_1 in pairs(arg_11_0.items) do
		iter_11_1:removeFromParentAndCleanup(false)
	end

	if arg_11_0.tableView ~= nil then
		arg_11_0.tableView:removeFromParentAndCleanup(true)

		arg_11_0.tableView = nil
		arg_11_0.tableViewHelper = nil
	end

	local var_11_0 = table.getn(arg_11_0.awardList) + 1
	local var_11_1 = table.getn(arg_11_0.items)
	local var_11_2 = arg_11_0.layerContent:getContentSize()
	local var_11_3 = CCSizeMake(var_11_2.width, var_11_2.height)

	arg_11_0.tableViewHelper = zbTableViewHelper:create()
	arg_11_0.tableView = zbTableViewHelper:createTableView(var_11_2, var_11_2, 1, arg_11_0.tableViewHelper)

	arg_11_0.tableView:setPosition(0, -20)
	arg_11_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_11_0.layerContent:addChild(arg_11_0.tableView)

	if var_11_0 - var_11_1 > 0 then
		for iter_11_2 = 1, var_11_0 - var_11_1 do
			local var_11_4 = zbTableViewHelper:create()

			var_11_4:loadCCBFile("ccbi/tb_levelsweep.ccbi")

			local var_11_5 = zbLevelSweepAward:create(translateAndStrokeHelper(var_11_4:readCCBNode()))

			var_11_5.layerAwardContainer:setPositionY(var_11_5.layerAwardContainer:getPositionY() - 20)
			var_11_5:retain()
			table.insert(arg_11_0.items, var_11_5)
			var_11_4:releaseSelf()
		end
	end

	local var_11_6 = arg_11_0.items[1]

	var_11_6:refresh(arg_11_0.awardList, 1, true)
	arg_11_0.tableViewHelper:addCell(var_11_6)
	arg_11_0.tableViewHelper:refreshTabelView()
	arg_11_0.tableViewHelper:setTouchPriority(arg_11_0.btnSweedEnd:getTouchPriority())
	arg_11_0:createAnimEffect()
end

local var_0_1 = 0.15
local var_0_2 = 0.15

function var_0_0.createAnimEffect(arg_12_0)
	local function var_12_0(arg_13_0)
		local var_13_0 = {}
		local var_13_1

		if arg_13_0.layerAward:isVisible() then
			var_13_0 = arg_13_0.items
		elseif arg_13_0.layerAwardExtra:isVisible() then
			var_13_0 = arg_13_0.itemsExtra
		end

		local var_13_2 = var_0_1

		for iter_13_0, iter_13_1 in pairs(var_13_0) do
			if iter_13_1:isVisible() then
				var_13_2 = var_13_2 + var_0_1
			end
		end

		return var_13_2
	end

	arg_12_0.fadeLineIndex = 0

	local function var_12_1()
		arg_12_0.fadeLineIndex = arg_12_0.fadeLineIndex + 1

		local var_14_0 = arg_12_0.items[arg_12_0.fadeLineIndex]

		if var_14_0 ~= nil then
			var_14_0:setVisible(true)
			arg_12_0:fadeLine(var_14_0)
		end
	end

	local function var_12_2()
		arg_12_0.btnSweedEnd:setVisible(true)
		arg_12_0.btnClose:setVisible(true)
		arg_12_0.btnTouchTest:setVisible(true)
		arg_12_0.tableViewHelper:setCanMove(true)
		tolua.cast(arg_12_0.tableView, "CCScrollView"):setBounceable(true)
	end

	local var_12_3 = CCArray:create()
	local var_12_4 = arg_12_0.items[1]

	if var_12_4 ~= nil then
		var_12_4:setVisible(false)

		local var_12_5 = var_12_0(var_12_4)

		var_12_3:addObject(CCCallFuncN:create(var_12_1))
		var_12_3:addObject(CCDelayTime:create(var_12_5))
		var_12_3:addObject(CCCallFuncN:create(var_12_2))
	end

	arg_12_0.animNode:stopAllActions()
	arg_12_0.animNode:runAction(CCSequence:create(var_12_3))
	arg_12_0.btnSweedEnd:setVisible(false)
	arg_12_0.btnClose:setVisible(false)
	arg_12_0.btnTouchTest:setVisible(false)
	arg_12_0.tableViewHelper:setCanMove(false)

	local var_12_6 = tolua.cast(arg_12_0.tableView, "CCScrollView")

	var_12_6:setBounceable(false)

	arg_12_0.scrollInitOffset = var_12_6:getContentOffset()
end

function var_0_0.fadeLine(arg_16_0, arg_16_1)
	local var_16_0 = {}
	local var_16_1

	if arg_16_1.layerAward:isVisible() then
		var_16_0 = arg_16_1.items
		var_16_1 = arg_16_1.lbAwardTitle
	elseif arg_16_1.layerAwardExtra:isVisible() then
		var_16_0 = arg_16_1.itemsExtra
		var_16_1 = arg_16_1.lbAwardExtraTitle
	end

	local var_16_2 = 0 + arg_16_0:fadeTitle(var_16_1)

	for iter_16_0, iter_16_1 in pairs(var_16_0) do
		if iter_16_1:isVisible() then
			var_16_2 = var_16_2 + arg_16_0:fadeNode(iter_16_1, var_16_2)
		end
	end

	return var_16_2
end

function var_0_0.fadeTitle(arg_17_0, arg_17_1)
	local function var_17_0(arg_18_0)
		arg_18_0:setVisible(true)
	end

	local var_17_1 = CCArray:create()

	var_17_1:addObject(CCCallFuncN:create(var_17_0))
	var_17_1:addObject(CCScaleTo:create(var_0_1 / 2, 1.2))
	var_17_1:addObject(CCScaleTo:create(var_0_1 / 2, 1))
	arg_17_1:setVisible(false)
	arg_17_1:stopAllActions()
	arg_17_1:runAction(CCSequence:create(var_17_1))

	return var_0_1
end

function var_0_0.fadeNode(arg_19_0, arg_19_1, arg_19_2)
	local function var_19_0(arg_20_0)
		arg_20_0:setVisible(true)
	end

	local var_19_1 = CCArray:create()

	var_19_1:addObject(CCDelayTime:create(arg_19_2))
	var_19_1:addObject(CCCallFuncN:create(var_19_0))
	var_19_1:addObject(CCScaleTo:create(var_0_1 / 2, 1.1))
	var_19_1:addObject(CCScaleTo:create(var_0_1 / 2, 1))
	arg_19_1:setVisible(false)
	arg_19_1:stopAllActions()
	arg_19_1:runAction(CCSequence:create(var_19_1))

	return var_0_1
end

function var_0_0.onTouchTest(arg_21_0)
	local var_21_0 = arg_21_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_21_0.layerTouchTest, var_21_0.x, var_21_0.y) == false and zbUtil:PointInCtrl(arg_21_0.btnClose, var_21_0.x, var_21_0.y) == false then
		arg_21_0:hide()
	end
end

function var_0_0.onContinueSweep(arg_22_0)
	arg_22_0.leftTimes = g_Self.kHeroTrialHandler:getLeftTrialNumByType(arg_22_0.trialType)

	if arg_22_0.leftTimes <= 0 then
		g_Bubble:bubbleInfo(a2u("\xBD\xF1\xC8մ\xCE\xCA\xFD\xD2\xD1\xD3\xC3\xCD\xEA"))

		return
	end

	g_WsMsgHandler:WS_Trial_SaoDang_Req(arg_22_0.trialType, arg_22_0.level)
end
