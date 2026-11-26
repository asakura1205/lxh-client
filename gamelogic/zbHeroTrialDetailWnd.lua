require("gamelogic.zbBaseWnd")
require("gamelogic.zbHeroTrialDetailItem")

local var_0_0 = class("zbHeroTrialDetailWnd", zbBaseWnd)

var_0_0.__index = var_0_0

local var_0_1 = 6

function createHeroTrialDetailWnd()
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
		arg_3_0.trialRecord = nil
		arg_3_0.type = 1
		arg_3_0.leftTimes = 0
		arg_3_0.items = {}
		arg_3_0.tableView = nil
		arg_3_0.tableViewHelper = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/herotrialdetail.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.spriteTitle = tolua.cast(var_5_2:getChildByTag(1), "CCSprite")
		arg_3_0.lbldes = tolua.cast(var_5_2:getChildByTag(1002), "CCLabelTTF")
		arg_3_0.left_arrow = tolua.cast(var_5_2:getChildByTag(3), "CCSprite")
		arg_3_0.right_arrow = tolua.cast(var_5_2:getChildByTag(4), "CCSprite")

		local var_5_3 = tolua.cast(var_5_2:getChildByTag(5), "CCLabelTTF")

		arg_3_0.difselLayer = tolua.cast(var_5_2:getChildByTag(6), "CCLayer")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)

		arg_3_0.lbTimes = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_3, arg_3_0.lbTimes)
		arg_3_0.lbTimes:setScale(0.55)
		zbUIEffect:runFadeToAction(arg_3_0.left_arrow)
		zbUIEffect:runFadeToAction(arg_3_0.right_arrow)
		arg_3_0:addChild(var_5_1)
		arg_3_0:createMoneyPanel(var_5_1, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold,
			EMoneyPanelResType.Food
		})
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refreshItems()
	end, zbGameEvent.Event_Update_TrialInfo)
end

function var_0_0.refresh(arg_8_0, arg_8_1)
	arg_8_0:confirmCreateView(arg_8_1)
	arg_8_0:refreshItems()
end

function var_0_0.confirmCreateView(arg_9_0, arg_9_1)
	arg_9_0.type = arg_9_1
	arg_9_0.trialRecord = zbHeroTrialBaseTable:getRecord(arg_9_1)

	if arg_9_0.trialRecord == nil then
		return
	end

	arg_9_0.spriteframeCache = CCSpriteFrameCache:sharedSpriteFrameCache()

	arg_9_0.spriteframeCache:addSpriteFramesWithFile("ui/image/plist/herotrial.plist")

	local var_9_0 = arg_9_0.spriteframeCache:spriteFrameByName("herotrial_title" .. arg_9_1 .. ".png")

	if var_9_0 then
		arg_9_0.spriteTitle:initWithSpriteFrame(var_9_0)
	end

	arg_9_0.lbldes:setString(arg_9_0.trialRecord.desc)

	if table.getn(arg_9_0.items) == var_0_1 then
		return
	end

	for iter_9_0, iter_9_1 in pairs(arg_9_0.items) do
		iter_9_1:removeFromParentAndCleanup(false)
	end

	arg_9_0.items = {}

	if arg_9_0.tableView ~= nil then
		arg_9_0.tableView:removeFromParentAndCleanup(true)

		arg_9_0.tableView = nil
		arg_9_0.tableViewHelper = nil
	end

	local var_9_1 = var_0_1
	local var_9_2 = table.getn(arg_9_0.items)
	local var_9_3 = arg_9_0.difselLayer:getContentSize()
	local var_9_4 = CCSizeMake(var_9_3.width, var_9_3.height)

	arg_9_0.tableViewHelper = zbTableViewHelper:create()
	arg_9_0.tableView = zbTableViewHelper:createTableView(var_9_3, var_9_3, 0, arg_9_0.tableViewHelper)

	arg_9_0.tableView:setPosition(0, 0)
	arg_9_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_9_0.difselLayer:addChild(arg_9_0.tableView)
	arg_9_0.tableViewHelper:setMaskPanel(arg_9_0.left_arrow, arg_9_0.right_arrow, nil, nil)

	if var_9_1 - var_9_2 > 0 then
		for iter_9_2 = 1, var_9_1 - var_9_2 do
			local var_9_5 = zbTableViewHelper:create()

			var_9_5:loadCCBFile("ccbi/tb_herotrial_detail.ccbi")

			local var_9_6 = createHeroTrialDetailItem(translateAndStrokeHelper(var_9_5:readCCBNode()))

			var_9_6:setContentSize(CCSizeMake(240, 320))
			var_9_6:retain()
			table.insert(arg_9_0.items, var_9_6)
			var_9_5:releaseSelf()
		end
	end

	for iter_9_3 = 1, var_0_1 do
		local var_9_7 = arg_9_0.items[iter_9_3]

		var_9_7:refresh(arg_9_0.type, iter_9_3)
		arg_9_0.tableViewHelper:addCell(var_9_7)
	end

	arg_9_0.tableViewHelper:refreshTabelView()
	arg_9_0.tableViewHelper:setTouchPriority(arg_9_0.btnClose:getTouchPriority())
end

function var_0_0.refreshItems(arg_10_0)
	for iter_10_0 = 1, var_0_1 do
		arg_10_0.items[iter_10_0]:refresh(arg_10_0.type, iter_10_0)
	end

	local var_10_0, var_10_1 = g_Self.kHeroTrialHandler:getLeftTrialNumByType(arg_10_0.type)

	arg_10_0.lbTimes:setString(var_10_0 .. "/" .. var_10_1)
end

function var_0_0.onBattleEnd(arg_11_0)
	arg_11_0:refresh(arg_11_0.type)
	g_MainScene:showBalance(g_HeroTrialResultSynAck)
end
