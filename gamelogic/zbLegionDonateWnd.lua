require("gamelogic.zbBaseWnd")
require("gamelogic.zbLegionDonateTypeItem")

local var_0_0 = class("zbLegionDonateWnd", zbBaseWnd)

var_0_0.__index = var_0_0

local var_0_1 = 1054
local var_0_2 = 120

function createLegionDonateWnd()
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
		arg_3_0.legionDetail = nil
		arg_3_0.items = {}
		arg_3_0.tableview = nil
		arg_3_0.tableviewHelper = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/legiondonate.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1, "CCNode")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCLayer")
		local var_5_4 = tolua.cast(var_5_3:getChildByTag(1), "CCNode")

		arg_3_0.legionIcon = tolua.cast(var_5_4:getChildByTag(1), "CCSprite")
		arg_3_0.legionName = tolua.cast(var_5_4:getChildByTag(2), "CCLabelTTF")
		arg_3_0.legionlv = tolua.cast(var_5_4:getChildByTag(3), "CCSprite")
		arg_3_0.spriteBarBg1 = tolua.cast(var_5_4:getChildByTag(4), "CCSprite")

		local function var_5_5(arg_6_0, arg_6_1)
			local var_6_0 = CCSprite:create(arg_6_1)

			var_6_0:setAnchorPoint(ccp(0, 0))

			local var_6_1 = CCProgressTimer:create(var_6_0)

			var_6_1:setAnchorPoint(ccp(0, 0))
			var_6_1:setPercentage(0)
			var_6_1:setMidpoint(ccp(0, 1))
			var_6_1:setBarChangeRate(ccp(1, 0))
			var_6_1:setType(kCCProgressTimerTypeBar)
			var_6_1:retain()
			arg_6_0:addChild(var_6_1)

			return var_6_1
		end

		arg_3_0.spriteBar1 = var_5_5(arg_3_0.spriteBarBg1, "image/legion/donate/progress_green2.png")
		arg_3_0.spriteBarBg2 = tolua.cast(var_5_4:getChildByTag(5), "CCSprite")

		local function var_5_6(arg_7_0, arg_7_1)
			local var_7_0 = CCSprite:create(arg_7_1)

			var_7_0:setAnchorPoint(ccp(0, 0))

			local var_7_1 = CCProgressTimer:create(var_7_0)

			var_7_1:setAnchorPoint(ccp(0, 0))
			var_7_1:setPercentage(0)
			var_7_1:setMidpoint(ccp(0, 1))
			var_7_1:setBarChangeRate(ccp(1, 0))
			var_7_1:setType(kCCProgressTimerTypeBar)
			var_7_1:retain()
			arg_7_0:addChild(var_7_1)

			return var_7_1
		end

		arg_3_0.spriteBar2 = var_5_6(arg_3_0.spriteBarBg2, "image/legion/donate/progress_yel2.png")

		local var_5_7 = tolua.cast(var_5_4:getChildByTag(1007), "CCLabelTTF")

		arg_3_0.lblprogress1 = tolua.cast(var_5_4:getChildByTag(8), "CCLabelTTF")
		arg_3_0.lblprogress2 = tolua.cast(var_5_4:getChildByTag(9), "CCLabelTTF")
		arg_3_0.mainLayer = tolua.cast(var_5_3:getChildByTag(2), "CCLayer")
		arg_3_0.donatetimes = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_7, arg_3_0.donatetimes)
		arg_3_0.donatetimes:setScale(0.55)

		local var_5_8 = tolua.cast(var_5_3:getChildByTag(3), "CCNode")

		arg_3_0.btnRule = tolua.cast(var_5_8:getChildByTag(1), "CCControlButton")

		arg_3_0.btnRule:addHandleOfControlEvent(function()
			arg_3_0:onRule()
		end, CCControlEventTouchUpInside)
		arg_3_0:addChild(var_5_1)
		arg_3_0:createMoneyPanel(var_5_1, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold,
			EMoneyPanelResType.Legion
		}, function()
			arg_3_0:hide()
		end)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refresh()
	end, zbGameEvent.Event_LegionDetailAck)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:hide()
	end, zbGameEvent.Event_LegionTickOutAck)
end

function var_0_0.refresh(arg_12_0)
	arg_12_0.legionDetail = g_Self.kLegionHandler.legionDetail

	if arg_12_0.legionDetail then
		local var_12_0 = zbIconHelper:getLegionIconPath(arg_12_0.legionDetail.LegionBaseInfo.IconId)

		arg_12_0.legionIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_12_0))
		arg_12_0.legionName:setString(a2u(arg_12_0.legionDetail.LegionBaseInfo.LegionName))
		zbLegionHelp:setLegionLvTexture(arg_12_0.legionlv, arg_12_0.legionDetail.LegionBaseInfo.Level)

		local var_12_1 = zbLegionHelp:getLegionMaxExp(arg_12_0.legionDetail.LegionBaseInfo.Level)
		local var_12_2 = g_Self.kLegionHandler:getTechExp(ELegionTechType.Legion)
		local var_12_3 = math.min(math.ceil(100 * (var_12_2 / var_12_1)), 100)

		arg_12_0.spriteBar1:setPercentage(var_12_3)
		arg_12_0.lblprogress1:setString(var_12_2 .. "/" .. var_12_1)

		local var_12_4 = arg_12_0.legionDetail.DonateBaseInfo.MaxDonate
		local var_12_5 = arg_12_0.legionDetail.DonateBaseInfo.DailyDonate
		local var_12_6 = math.min(math.ceil(100 * (var_12_5 / var_12_4)), 100)

		arg_12_0.spriteBar2:setPercentage(var_12_6)
		arg_12_0.lblprogress2:setString(var_12_5 .. "/" .. var_12_4)

		local var_12_7 = math.max(g_GameData.LegionInfo.MaxDonate - g_GameData.LegionInfo.DailyDonate, 0)

		arg_12_0.donatetimes:setString(var_12_7 .. "/" .. g_GameData.LegionInfo.MaxDonate)
	end

	arg_12_0:refreshList()
end

function var_0_0.refreshList(arg_13_0)
	local var_13_0 = zbLegionHelp:getLegionDonateList()

	arg_13_0:createView(var_13_0)
	arg_13_0:refreshItems(var_13_0)
end

function var_0_0.createView(arg_14_0, arg_14_1)
	if table.getn(arg_14_0.items) == table.getn(arg_14_1) then
		return
	end

	for iter_14_0, iter_14_1 in pairs(arg_14_0.items) do
		iter_14_1:removeFromParentAndCleanup(false)
	end

	arg_14_0.items = {}

	if arg_14_0.tableView ~= nil then
		arg_14_0.tableView:removeFromParentAndCleanup(true)

		arg_14_0.tableView = nil
		arg_14_0.tableViewHelper = nil
	end

	if arg_14_1 == nil then
		arg_14_1 = {}
	end

	local var_14_0 = table.maxn(arg_14_1)
	local var_14_1 = table.maxn(arg_14_0.items)
	local var_14_2 = arg_14_0.mainLayer:getContentSize()
	local var_14_3 = CCSizeMake(var_14_2.width, var_0_2 * var_14_0)
	local var_14_4 = CCSizeMake(var_14_2.width, var_14_2.height)

	arg_14_0.tableViewHelper = zbTableViewHelper:create()
	arg_14_0.tableView = zbTableViewHelper:createTableView(var_14_3, var_14_4, 1, arg_14_0.tableViewHelper)

	arg_14_0.tableView:setPosition(0, 0)
	arg_14_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_14_0.mainLayer:addChild(arg_14_0.tableView)

	if var_14_0 - var_14_1 > 0 then
		local var_14_5 = zbTableViewHelper:create()

		var_14_5:loadCCBFile("ccbi/tb_legion_donatetype.ccbi")

		for iter_14_2 = 1, var_14_0 - var_14_1 do
			local var_14_6 = createLegionDonateTypeItem(translateAndStrokeHelper(var_14_5:readCCBNode()))

			var_14_6:retain()

			arg_14_0.items[var_14_1 + iter_14_2] = var_14_6
		end
	end

	local var_14_7 = 1

	for iter_14_3, iter_14_4 in pairs(arg_14_1) do
		local var_14_8 = arg_14_0.items[var_14_7]

		arg_14_0.tableViewHelper:addCell(var_14_8)

		var_14_7 = var_14_7 + 1
	end

	arg_14_0.tableViewHelper:refreshTabelView()
	arg_14_0.tableViewHelper:setTouchPriority(arg_14_0.moneyPanel.btnClose:getTouchPriority())
end

function var_0_0.refreshItems(arg_15_0, arg_15_1)
	local var_15_0 = 1

	for iter_15_0, iter_15_1 in pairs(arg_15_1) do
		arg_15_0.items[var_15_0]:refresh(iter_15_1)

		var_15_0 = var_15_0 + 1
	end
end

function var_0_0.onRule(arg_16_0)
	g_MainScene:showRuleWnd(RuleType_LegionDonate)
end
