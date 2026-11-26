require("gamelogic.zbPataSaoDangAwardItem")

local var_0_0 = class("zbPataSaoDangAwardWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createPataSaoDangAwardWnd()
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
		arg_3_0.levelAwardList = nil
		arg_3_0.items = {}
		arg_3_0.tableview = nil
		arg_3_0.tableviewHelper = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/pata_saodang_award.ccbi", var_5_0, true, "")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.lbTemp = tolua.cast(var_5_2:getChildByTag(0), "CCLabelTTF")
		arg_3_0.layerContent = tolua.cast(var_5_2:getChildByTag(1), "CCLayerColor")
		arg_3_0.btnSweedContinue = tolua.cast(var_5_2:getChildByTag(6), "CCControlButton")

		arg_3_0.btnSweedContinue:addHandleOfControlEvent(function()
			arg_3_0:onContinueSweep()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)

		arg_3_0.animNode = CCNode:create()

		arg_3_0.animNode:retain()
		arg_3_0:addChild(arg_3_0.animNode)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_7_0, arg_7_1)
	arg_7_0.levelAwardList = arg_7_1

	arg_7_0.lbTemp:setString(a2u(string.format("\xB1\xBE\xB4\xCEɨ\xB5\xB4ֱ\xBD\xD3\xCC\xF4ս\xC1\xCB%d\xB2㣬\xBB\xF1\xB5\xC3\xC8\xE7\xCF½\xB1\xC0\xF8", g_GameData.PataInfo.BaseInfo.TodaySaoDangLayer)))

	for iter_7_0, iter_7_1 in pairs(arg_7_0.items) do
		iter_7_1:removeFromParentAndCleanup(false)
	end

	if arg_7_0.tableView ~= nil then
		arg_7_0.tableView:removeFromParentAndCleanup(true)

		arg_7_0.tableView = nil
		arg_7_0.tableViewHelper = nil
	end

	local var_7_0 = table.getn(arg_7_1)
	local var_7_1 = table.getn(arg_7_0.items)
	local var_7_2 = arg_7_0.layerContent:getContentSize()
	local var_7_3 = CCSizeMake(var_7_2.width, var_7_2.height)

	arg_7_0.tableViewHelper = zbTableViewHelper:create()
	arg_7_0.tableView = zbTableViewHelper:createTableView(var_7_2, var_7_2, 1, arg_7_0.tableViewHelper)

	arg_7_0.tableView:setPosition(0, 0)
	arg_7_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_7_0.layerContent:addChild(arg_7_0.tableView)

	if var_7_0 - var_7_1 > 0 then
		for iter_7_2 = 1, var_7_0 - var_7_1 do
			local var_7_4 = zbTableViewHelper:create()

			var_7_4:loadCCBFile("ccbi/tb_PataSaoDangAward.ccbi")

			local var_7_5 = zbPataSaoDangAwardItem:create(translateAndStrokeHelper(var_7_4:readCCBNode()))

			var_7_5:retain()
			table.insert(arg_7_0.items, var_7_5)
			var_7_4:releaseSelf()
		end
	end

	local var_7_6 = table.getn(arg_7_1)

	arg_7_0.sweepCount = 0

	local var_7_7 = 1

	for iter_7_3, iter_7_4 in pairs(arg_7_1) do
		local var_7_8 = arg_7_0.items[var_7_7]

		var_7_8:refresh(iter_7_4, var_7_7)
		arg_7_0.tableViewHelper:addCell(var_7_8)

		var_7_7 = var_7_7 + 1
	end

	arg_7_0.sweepCount = var_7_0

	arg_7_0.tableViewHelper:refreshTabelView()
	arg_7_0.tableViewHelper:setTouchPriority(arg_7_0.btnSweedContinue:getTouchPriority())
	arg_7_0:createAnimEffect()
end

function var_0_0.onContinueSweep(arg_8_0)
	g_WsMsgHandler:WS_Pata_SaoDangNext_Req()
end

local var_0_1 = 0.15
local var_0_2 = 0.15

function var_0_0.createAnimEffect(arg_9_0)
	local function var_9_0(arg_10_0)
		local var_10_0 = {}
		local var_10_1

		if arg_10_0.layerAward:isVisible() then
			var_10_0 = arg_10_0.items
		elseif arg_10_0.layerAwardExtra:isVisible() then
			var_10_0 = arg_10_0.itemsExtra
		end

		local var_10_2 = var_0_1

		for iter_10_0, iter_10_1 in pairs(var_10_0) do
			if iter_10_1:isVisible() then
				var_10_2 = var_10_2 + var_0_1
			end
		end

		return var_10_2
	end

	arg_9_0.fadeLineIndex = 0

	local function var_9_1()
		arg_9_0.fadeLineIndex = arg_9_0.fadeLineIndex + 1

		local var_11_0 = arg_9_0.items[arg_9_0.fadeLineIndex]

		if var_11_0 ~= nil then
			var_11_0:setVisible(true)
			arg_9_0:fadeLine(var_11_0)
		end
	end

	local function var_9_2()
		local var_12_0 = tolua.cast(arg_9_0.tableView, "CCScrollView")
		local var_12_1 = arg_9_0.layerContent:getContentSize()
		local var_12_2 = var_12_0:getContentOffset()
		local var_12_3 = math.min(var_12_2.y + 130, 0)

		var_12_0:setContentOffsetInDuration(ccp(0, var_12_3), var_0_2)
	end

	local function var_9_3()
		arg_9_0.tableViewHelper:setCanMove(true)
		tolua.cast(arg_9_0.tableView, "CCScrollView"):setBounceable(true)
		arg_9_0.btnSweedContinue:setVisible(true)
	end

	local var_9_4 = CCArray:create()

	for iter_9_0 = 1, arg_9_0.sweepCount do
		local var_9_5 = arg_9_0.items[iter_9_0]

		if var_9_5 ~= nil then
			var_9_5:setVisible(false)

			local var_9_6 = var_9_0(var_9_5)

			var_9_4:addObject(CCCallFuncN:create(var_9_1))
			var_9_4:addObject(CCDelayTime:create(var_9_6))
			var_9_4:addObject(CCCallFuncN:create(var_9_2))

			if iter_9_0 == arg_9_0.sweepCount then
				var_9_4:addObject(CCCallFuncN:create(var_9_3))
			else
				var_9_4:addObject(CCDelayTime:create(var_0_2))
			end
		end
	end

	arg_9_0.animNode:stopAllActions()
	arg_9_0.animNode:runAction(CCSequence:create(var_9_4))
	arg_9_0.btnSweedContinue:setVisible(false)
	arg_9_0.tableViewHelper:setCanMove(false)

	local var_9_7 = tolua.cast(arg_9_0.tableView, "CCScrollView")

	var_9_7:setBounceable(false)

	arg_9_0.scrollInitOffset = var_9_7:getContentOffset()
end

function var_0_0.fadeLine(arg_14_0, arg_14_1)
	local var_14_0 = {}
	local var_14_1

	if arg_14_1.layerAward:isVisible() then
		var_14_0 = arg_14_1.items
		var_14_1 = arg_14_1.lbAwardTitle
	elseif arg_14_1.layerAwardExtra:isVisible() then
		var_14_0 = arg_14_1.itemsExtra
		var_14_1 = arg_14_1.lbAwardExtraTitle
	end

	local var_14_2 = 0 + arg_14_0:fadeTitle(var_14_1)

	for iter_14_0, iter_14_1 in pairs(var_14_0) do
		if iter_14_1:isVisible() then
			var_14_2 = var_14_2 + arg_14_0:fadeNode(iter_14_1, var_14_2)
		end
	end

	return var_14_2
end

function var_0_0.fadeTitle(arg_15_0, arg_15_1)
	local function var_15_0(arg_16_0)
		arg_16_0:setVisible(true)
	end

	local var_15_1 = CCArray:create()

	var_15_1:addObject(CCCallFuncN:create(var_15_0))
	var_15_1:addObject(CCScaleTo:create(var_0_1 / 2, 1.2))
	var_15_1:addObject(CCScaleTo:create(var_0_1 / 2, 0.9))
	arg_15_1:setVisible(false)
	arg_15_1:stopAllActions()
	arg_15_1:runAction(CCSequence:create(var_15_1))

	return var_0_1
end

function var_0_0.fadeNode(arg_17_0, arg_17_1, arg_17_2)
	local function var_17_0(arg_18_0)
		arg_18_0:setVisible(true)
	end

	local var_17_1 = CCArray:create()

	var_17_1:addObject(CCDelayTime:create(arg_17_2))
	var_17_1:addObject(CCCallFuncN:create(var_17_0))
	var_17_1:addObject(CCScaleTo:create(var_0_1 / 2, 1.1))
	var_17_1:addObject(CCScaleTo:create(var_0_1 / 2, 0.9))
	arg_17_1:setVisible(false)
	arg_17_1:stopAllActions()
	arg_17_1:runAction(CCSequence:create(var_17_1))

	return var_0_1
end
