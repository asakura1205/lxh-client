require("gamelogic.zbTabWnd")
require("gamelogic.zbActivityWnd_Sign")
require("gamelogic.zbActivityWnd_Tili")
require("gamelogic.zbActivityWnd_Upgrade")
require("gamelogic.zbActivityWnd_Vip")
require("gamelogic.zbActivityWnd_Desire")
require("gamelogic.zbActivityWnd_LuckCat")
require("gamelogic.zbActivityWnd_Card")

local var_0_0 = class("zbActivityWnd", zbTabWnd)

var_0_0.__index = var_0_0

function createActivityWnd()
	local var_1_0 = var_0_0.extend(zbTabWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create()))))

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
		return
	end

	local function var_3_1()
		local function var_5_0(arg_6_0)
			local var_6_0 = CCSprite:create(NOTIFY_TAG_PATH)

			var_6_0:setAnchorPoint(ccp(0.5, 0.5))
			var_6_0:setPosition(arg_6_0:getContentSize().width - 25, arg_6_0:getContentSize().height / 2 + 20)
			var_6_0:setVisible(false)
			arg_6_0:addChild(var_6_0)
			zbUIEffect:createNotifyTagScaleAction(var_6_0)

			return var_6_0
		end

		local var_5_1 = CCBProxy:create()
		local var_5_2 = getPreloadCCNode("ccbi/activity.ccbi")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCNode")
		local var_5_4 = tolua.cast(var_5_2:getChildByTag(2), "CCNode")

		arg_3_0.btnLayer = tolua.cast(var_5_4:getChildByTag(1), "CCSprite")
		arg_3_0.left_arrow = tolua.cast(var_5_4:getChildByTag(2), "CCSprite")
		arg_3_0.right_arrow = tolua.cast(var_5_4:getChildByTag(3), "CCSprite")

		zbUIEffect:runFadeToAction(arg_3_0.left_arrow)
		zbUIEffect:runFadeToAction(arg_3_0.right_arrow)

		local var_5_5 = tolua.cast(var_5_2:getChildByTag(102), "CCSprite")

		arg_3_0.spriteActiviTitle = tolua.cast(var_5_5:getChildByTag(1), "CCSprite")
		arg_3_0.node = var_5_2
		arg_3_0.layer = var_5_3
		arg_3_0.layerTab = var_5_4

		local var_5_6 = {}
		local var_5_7 = {}
		local var_5_8 = {}
		local var_5_9 = arg_3_0.btnLayer:getContentSize()
		local var_5_10 = CCSizeMake(var_5_9.width, var_5_9.height)

		arg_3_0.tableViewHelper = zbTableViewHelper:create()
		arg_3_0.tableView = zbTableViewHelper:createTableView(var_5_10, var_5_10, kCCScrollViewDirectionHorizontal, arg_3_0.tableViewHelper)

		arg_3_0.tableView:setAnchorPoint(ccp(0, 0))
		arg_3_0.btnLayer:addChild(arg_3_0.tableView)
		arg_3_0.tableViewHelper:setMaskPanel(arg_3_0.left_arrow, arg_3_0.right_arrow, nil, nil)

		for iter_5_0 = 1, EActivityType.BottomNull do
			local var_5_11 = ui:createButton("image/common/btnsharp170_blue.png", "image/common/btnsharp170_blue.png")

			ui:setButtonPic(var_5_11, "image/common/btnsharp170_blue.png", "image/common/btnsharp170_gold.png", "image/common/btnsharp170_gold.png")
			var_5_11:setZoomOnTouchDown(false)

			var_5_6[iter_5_0] = var_5_11

			var_5_11:setToucheMoveDelta(MOVE_TEST_DELTA)
			var_5_11:setSwallowsTouches(false)
			var_5_11:setAnchorPoint(ccp(0, 0))
			arg_3_0.tableViewHelper:addCell(var_5_11)

			var_5_8[iter_5_0] = "image/tab/tab_activity_tab" .. iter_5_0 .. ".png"
			var_5_7[iter_5_0] = tolua.cast(var_5_3:getChildByTag(iter_5_0), "CCNode")
		end

		arg_3_0.tableViewHelper:refreshTabelView()

		arg_3_0.notifyVip = var_5_0(var_5_6[EActivityType.Vip])
		arg_3_0.notifySign = var_5_0(var_5_6[EActivityType.Sign])
		arg_3_0.notifyTili = var_5_0(var_5_6[EActivityType.Tili])
		arg_3_0.notifyUpgrade = var_5_0(var_5_6[EActivityType.Upgrade])
		arg_3_0.notifyDesire = var_5_0(var_5_6[EActivityType.Desire])
		arg_3_0.notifyCard = var_5_0(var_5_6[EActivityType.Card])
		arg_3_0.tabButtons = var_5_6
		arg_3_0.module = {}
		arg_3_0.module[EActivityType.Sign] = zbActivityWnd_Sign:create(var_5_7[EActivityType.Sign], var_5_6[EActivityType.Sign], arg_3_0)
		arg_3_0.module[EActivityType.Tili] = zbActivityWnd_Tili:create(var_5_7[EActivityType.Tili], var_5_6[EActivityType.Tili], arg_3_0)
		arg_3_0.module[EActivityType.Upgrade] = zbActivityWnd_Upgrade:create(var_5_7[EActivityType.Upgrade], var_5_6[EActivityType.Upgrade], arg_3_0)
		arg_3_0.module[EActivityType.Desire] = zbActivityWnd_Desire:create(var_5_7[EActivityType.Desire], var_5_6[EActivityType.Desire], arg_3_0)
		arg_3_0.module[EActivityType.LuckCat] = zbActivityWnd_LuckCat:create(var_5_7[EActivityType.LuckCat], var_5_6[EActivityType.LuckCat], arg_3_0)
		arg_3_0.module[EActivityType.Vip] = zbActivityWnd_Vip:create(var_5_7[EActivityType.Vip], var_5_6[EActivityType.Vip], arg_3_0)
		arg_3_0.module[EActivityType.Card] = zbActivityWnd_Card:create(var_5_7[EActivityType.Card], var_5_6[EActivityType.Card], arg_3_0)

		arg_3_0:initTab(var_5_6, var_5_7, var_5_8)
		arg_3_0:addChild(var_5_2)
		arg_3_0:createMoneyPanel(var_5_2, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold,
			EMoneyPanelResType.Tili
		}, function()
			arg_3_0:hide()
		end)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(function()
		arg_3_0:onShow()
	end)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onDataUpdateAck()
	end, zbGameEvent.Event_Activity_Ack)
end

function var_0_0.refresh(arg_10_0, arg_10_1)
	arg_10_0:refreshNotify()

	if arg_10_1 then
		arg_10_0:selectTab(arg_10_1)
	end
end

function var_0_0.onShow(arg_11_0)
	arg_11_0:selectTab(1)
end

function var_0_0.doSelectTab(arg_12_0)
	if arg_12_0.currTab == EActivityType.LuckCat then
		g_WsMsgHandler:WS_ActivityAct_LuckyDiamondLog_Req()
	end

	if arg_12_0.module[arg_12_0.currTab] then
		arg_12_0.module[arg_12_0.currTab]:refresh()
	end

	arg_12_0.spriteframeCache = CCSpriteFrameCache:sharedSpriteFrameCache()

	arg_12_0.spriteframeCache:addSpriteFramesWithFile("ui/image/plist/activity.plist")

	local var_12_0 = arg_12_0.spriteframeCache:spriteFrameByName("activity_main" .. arg_12_0.currTab .. ".png")

	if var_12_0 then
		arg_12_0.spriteActiviTitle:initWithSpriteFrame(var_12_0)
	end
end

function var_0_0.onDataUpdateAck(arg_13_0)
	if arg_13_0.isShow and arg_13_0.module[arg_13_0.currTab] then
		arg_13_0.module[arg_13_0.currTab]:refresh()
	end

	arg_13_0:refreshNotify()
end

function var_0_0.refreshNotify(arg_14_0)
	arg_14_0.notifyVip:setVisible(g_Self.kGiftHandler:hasVIPGift())
	arg_14_0.notifySign:setVisible(g_Self.kGiftHandler:hasSignGift())
	arg_14_0.notifyUpgrade:setVisible(g_Self.kGiftHandler:hasUpgradeGift())
	arg_14_0.notifyTili:setVisible(g_Self.kGiftHandler:hasTiliGift())
	arg_14_0.notifyDesire:setVisible(g_Self.kGiftHandler:hasDesireGift())
	arg_14_0.notifyCard:setVisible(g_Self.kGiftHandler:hasCardGift())
end

function var_0_0.onFrameUpdate(arg_15_0, arg_15_1)
	arg_15_0:updateBackEffect()

	if arg_15_0.module[EActivityType.Desire] or arg_15_0.module[EActivityType.LuckCat] then
		arg_15_0.module[EActivityType.Desire]:onFrame()
		arg_15_0.module[EActivityType.LuckCat]:onFrame(arg_15_1)
	end
end
