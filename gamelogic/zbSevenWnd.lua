require("gamelogic.zbTabWnd")
require("gamelogic.zbSevenWnd_Sign")
require("gamelogic.zbSevenWnd_Charge")
require("gamelogic.zbSevenWnd_Half")
require("gamelogic.zbSevenWnd_Power")
require("gamelogic.zbSevenWnd_Arena")
require("gamelogic.zbSevenWnd_Level")
require("gamelogic.zbSevenWnd_Pata")
require("gamelogic.zbSevenWnd_Star")

local var_0_0 = class("zbSevenWnd", zbTabWnd)

var_0_0.__index = var_0_0

function createSevenWnd()
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
		local var_5_2 = CCBReaderLoad("ccbi/seven.ccbi", var_5_1, true, "HelloCocosBuilderLayerOwner")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCNode")
		local var_5_4 = tolua.cast(var_5_2:getChildByTag(2), "CCNode")

		arg_3_0.btnLayer = tolua.cast(var_5_4:getChildByTag(1), "CCSprite")
		arg_3_0.left_arrow = tolua.cast(var_5_4:getChildByTag(2), "CCSprite")
		arg_3_0.right_arrow = tolua.cast(var_5_4:getChildByTag(3), "CCSprite")

		zbUIEffect:runFadeToAction(arg_3_0.left_arrow)
		zbUIEffect:runFadeToAction(arg_3_0.right_arrow)

		local var_5_5 = tolua.cast(var_5_2:getChildByTag(102), "CCSprite")

		arg_3_0.spriteTitle = tolua.cast(var_5_5:getChildByTag(1), "CCSprite")
		arg_3_0.node = var_5_2
		arg_3_0.layer = var_5_3
		arg_3_0.layerTab = var_5_4

		local var_5_6 = {}
		local var_5_7 = {}
		local var_5_8 = arg_3_0.btnLayer:getContentSize()
		local var_5_9 = CCSizeMake(var_5_8.width, var_5_8.height)

		arg_3_0.tableViewHelper = zbTableViewHelper:create()
		arg_3_0.tableView = zbTableViewHelper:createTableView(var_5_9, var_5_9, kCCScrollViewDirectionHorizontal, arg_3_0.tableViewHelper)

		arg_3_0.tableView:setPosition(0, 0)
		arg_3_0.tableView:setAnchorPoint(ccp(0, 0))
		arg_3_0.btnLayer:addChild(arg_3_0.tableView)
		arg_3_0.tableViewHelper:setMaskPanel(arg_3_0.left_arrow, arg_3_0.right_arrow, nil, nil)

		for iter_5_0 = ESevenType.Sign, ESevenType.Star do
			local var_5_10 = ui:createButton("image/common/btnsharp170_blue.png", "image/common/btnsharp170_blue.png")

			ui:setButtonPic(var_5_10, "image/common/btnsharp170_blue.png", "image/common/btnsharp170_gold.png", "image/common/btnsharp170_gold.png")
			var_5_10:setZoomOnTouchDown(false)

			var_5_6[iter_5_0] = var_5_10

			var_5_10:setToucheMoveDelta(MOVE_TEST_DELTA)
			var_5_10:setSwallowsTouches(false)
			var_5_10:setAnchorPoint(ccp(0, 0))
			arg_3_0.tableViewHelper:addCell(var_5_10)

			var_5_7[iter_5_0] = tolua.cast(var_5_3:getChildByTag(iter_5_0), "CCNode")
		end

		arg_3_0.tableViewHelper:refreshTabelView()

		arg_3_0.notifySign = var_5_0(var_5_6[ESevenType.Sign])
		arg_3_0.notifyPower = var_5_0(var_5_6[ESevenType.Power])
		arg_3_0.notifyArena = var_5_0(var_5_6[ESevenType.Arena])
		arg_3_0.notifyLevel = var_5_0(var_5_6[ESevenType.Level])
		arg_3_0.notifyPata = var_5_0(var_5_6[ESevenType.Pata])
		arg_3_0.notifyStar = var_5_0(var_5_6[ESevenType.Star])

		local var_5_11 = {
			[ESevenType.Sign] = "image/tab/tab_seven_sign.png",
			[ESevenType.Half] = "image/tab/tab_seven_half.png",
			[ESevenType.Power] = "image/tab/tab_seven_power.png",
			[ESevenType.Arena] = "image/tab/tab_seven_arena.png",
			[ESevenType.Level] = "image/tab/tab_seven_level.png",
			[ESevenType.Pata] = "image/tab/tab_seven_pata.png",
			[ESevenType.Star] = "image/tab/tab_seven_star.png"
		}

		arg_3_0.module = {}
		arg_3_0.module[ESevenType.Sign] = createSevenWnd_Sign(var_5_7[ESevenType.Sign], var_5_6[ESevenType.Sign], arg_3_0)
		arg_3_0.module[ESevenType.Half] = createSevenWnd_Half(var_5_7[ESevenType.Half], var_5_6[ESevenType.Half], arg_3_0)
		arg_3_0.module[ESevenType.Power] = createSevenWnd_Power(var_5_7[ESevenType.Power], var_5_6[ESevenType.Power], arg_3_0)
		arg_3_0.module[ESevenType.Arena] = createSevenWnd_Arena(var_5_7[ESevenType.Arena], var_5_6[ESevenType.Arena], arg_3_0)
		arg_3_0.module[ESevenType.Level] = createSevenWnd_Level(var_5_7[ESevenType.Level], var_5_6[ESevenType.Level], arg_3_0)
		arg_3_0.module[ESevenType.Pata] = createSevenWnd_Pata(var_5_7[ESevenType.Pata], var_5_6[ESevenType.Pata], arg_3_0)
		arg_3_0.module[ESevenType.Star] = createSevenWnd_Star(var_5_7[ESevenType.Star], var_5_6[ESevenType.Star], arg_3_0)

		arg_3_0:initTab(var_5_6, var_5_7, var_5_11)
		arg_3_0:addChild(var_5_2)
		arg_3_0:createMoneyPanel(var_5_2, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold,
			EMoneyPanelResType.Level
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
	end, zbGameEvent.Event_Seven_Ack)
end

function var_0_0.refresh(arg_10_0)
	g_WsMsgHandler:WS_ActivityOs_GetData_Req()
	arg_10_0:refreshNotify()
end

function var_0_0.onShow(arg_11_0)
	arg_11_0:selectTab(1)
end

function var_0_0.doSelectTab(arg_12_0)
	arg_12_0.module[arg_12_0.currTab]:refresh()

	if arg_12_0.currTab == ESevenType.Sign then
		arg_12_0.spriteTitle:setTexture(CCTextureCache:sharedTextureCache():addImage("image/seven/seven_sign.png"))
	elseif arg_12_0.currTab == ESevenType.Half then
		arg_12_0.spriteTitle:setTexture(CCTextureCache:sharedTextureCache():addImage("image/seven/seven_half.png"))
	elseif arg_12_0.currTab == ESevenType.Power then
		arg_12_0.spriteTitle:setTexture(CCTextureCache:sharedTextureCache():addImage("image/seven/seven_power.png"))
	elseif arg_12_0.currTab == ESevenType.Arena then
		arg_12_0.spriteTitle:setTexture(CCTextureCache:sharedTextureCache():addImage("image/seven/seven_arena.png"))
	elseif arg_12_0.currTab == ESevenType.Level then
		arg_12_0.spriteTitle:setTexture(CCTextureCache:sharedTextureCache():addImage("image/seven/seven_level.png"))
	elseif arg_12_0.currTab == ESevenType.Pata then
		arg_12_0.spriteTitle:setTexture(CCTextureCache:sharedTextureCache():addImage("image/seven/seven_pata.png"))
	elseif arg_12_0.currTab == ESevenType.Star then
		arg_12_0.spriteTitle:setTexture(CCTextureCache:sharedTextureCache():addImage("image/seven/seven_star.png"))
	end
end

function var_0_0.onDataUpdateAck(arg_13_0)
	if arg_13_0.isShow and arg_13_0.module[arg_13_0.currTab] then
		arg_13_0.module[arg_13_0.currTab]:refresh()
	end

	arg_13_0:refreshNotify()
end

function var_0_0.refreshNotify(arg_14_0)
	arg_14_0.notifySign:setVisible(g_Self.kSevenHandler:hasSignGift())
	arg_14_0.notifyStar:setVisible(g_Self.kSevenHandler:hasStarGift())
	arg_14_0.notifyLevel:setVisible(g_Self.kSevenHandler:hasLevelGift())
	arg_14_0.notifyPata:setVisible(g_Self.kSevenHandler:hasPataGift())
	arg_14_0.notifyArena:setVisible(g_Self.kSevenHandler:hasArenaGift())
	arg_14_0.notifyPower:setVisible(g_Self.kSevenHandler:hasPowerGift())
end

function var_0_0.onFrameUpdate(arg_15_0)
	arg_15_0:updateBackEffect()

	if arg_15_0.currTab ~= ESevenType.Sign then
		arg_15_0.module[arg_15_0.currTab]:onFrame()
	end
end
