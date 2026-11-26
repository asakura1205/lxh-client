require("gamelogic.zbBaseWnd")
require("gamelogic.zbItem")

local var_0_0 = class("zbHeroResetWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function var_0_0.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, var_0_0)

	return arg_1_0
end

function createHeroResetWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNodeRGBA:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.items = {}
		arg_3_0.tableView = nil
		arg_3_0.tableViewHelper = nil
		arg_3_0.heroData = nil
		arg_3_0.resetRate = 70
		arg_3_0.diamond = 0
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/hero_reset.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner", false, false)
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.spriteAdd = tolua.cast(var_5_2:getChildByTag(1), "CCSprite")

		zbUIEffect:runFadeToAction(arg_3_0.spriteAdd)

		arg_3_0.nodeAvatar = tolua.cast(var_5_2:getChildByTag(2), "CCNode")
		arg_3_0.btnHero = tolua.cast(var_5_2:getChildByTag(3), "CCControlButton")

		arg_3_0.btnHero:addHandleOfControlEvent(function()
			arg_3_0:onHero()
		end, CCControlEventTouchUpInside)

		arg_3_0.heroAvatar = createUIAnimation()

		arg_3_0.heroAvatar:setPosition(0, 70)
		arg_3_0.heroAvatar:setScale(1.3)
		arg_3_0.nodeAvatar:addChild(arg_3_0.heroAvatar)

		local var_5_3 = CCSprite:create("image/combat/yingzi.png")

		var_5_3:setPosition(0, 0)
		var_5_3:setZOrder(-1)
		arg_3_0.heroAvatar:addChild(var_5_3)

		arg_3_0.layerItems = tolua.cast(var_5_2:getChildByTag(4), "CCLayer")
		arg_3_0.spriteReset = tolua.cast(var_5_2:getChildByTag(5), "CCSprite")

		local var_5_4 = tolua.cast(var_5_2:getChildByTag(1005), "CCLabelTTF")
		local var_5_5 = tolua.cast(var_5_2:getChildByTag(1006), "CCLabelTTF")

		arg_3_0.lbReset = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_4, arg_3_0.lbReset)
		arg_3_0.lbReset:setScale(0.6)

		arg_3_0.lbResetRate = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_5, arg_3_0.lbResetRate)
		arg_3_0.lbResetRate:setScale(0.6)

		arg_3_0.btnReset = tolua.cast(var_5_2:getChildByTag(6), "CCControlButton")
		arg_3_0.btnRule = tolua.cast(var_5_2:getChildByTag(10), "CCControlButton")

		arg_3_0.btnReset:addHandleOfControlEvent(function()
			arg_3_0:onReset()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnRule:addHandleOfControlEvent(function()
			arg_3_0:onRule()
		end, CCControlEventTouchUpInside)
		arg_3_0:addChild(var_5_1)
		arg_3_0:createMoneyPanel(var_5_1, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold,
			EMoneyPanelResType.Reset
		}, function()
			arg_3_0:hide()
		end)
	end

	var_3_0()
	var_3_1()
	arg_3_0:createView()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refresh()
	end, zbGameEvent.Event_HeroResetSuccess)
end

function var_0_0.refresh(arg_11_0)
	arg_11_0.diamond = g_Self.kGmActivityHandler:getGmActivityHeroReset()

	if arg_11_0.diamond == nil then
		arg_11_0.diamond = 350
	end

	arg_11_0.lbReset:setString(1)
	arg_11_0.lbResetRate:setString(100 .. ";")
	arg_11_0:refreshResetItems()
	arg_11_0:heroSelectBack()
end

function var_0_0.createView(arg_12_0)
	local var_12_0 = arg_12_0.layerItems:getContentSize()
	local var_12_1 = CCSizeMake(var_12_0.width, var_12_0.height)

	arg_12_0.tableViewHelper = zbTableViewHelper:create()
	arg_12_0.tableView = zbTableViewHelper:createTableView(var_12_1, var_12_1, 0, arg_12_0.tableViewHelper)

	arg_12_0.tableView:setPosition(0, 10)
	arg_12_0.tableView:setAnchorPoint(ccp(0, 0))
	arg_12_0.layerItems:addChild(arg_12_0.tableView)
	arg_12_0.tableViewHelper:refreshTabelView()
	arg_12_0.tableViewHelper:setTouchPriority(arg_12_0.btnReset:getTouchPriority())
end

function var_0_0.refreshResetItems(arg_13_0, arg_13_1)
	if arg_13_1 == nil then
		arg_13_0.tableViewHelper:removeAllCells()
		arg_13_0.tableViewHelper:refreshTabelView()

		return
	end

	local var_13_0 = arg_13_0.tableViewHelper:getCellNum() ~= table.getn(arg_13_1)

	if var_13_0 then
		arg_13_0.tableViewHelper:removeAllCells()
	end

	local var_13_1 = table.getn(arg_13_1)
	local var_13_2 = table.getn(arg_13_0.items)

	if var_13_1 - var_13_2 > 0 then
		for iter_13_0 = 1, var_13_1 - var_13_2 do
			local var_13_3 = createItem()

			var_13_3:setScale(0.8)
			var_13_3:setNeedTip(false)
			var_13_3:setSwallowsTouches(false)
			var_13_3:retain()

			arg_13_0.items[var_13_2 + iter_13_0] = var_13_3
		end
	end

	local var_13_4 = 1

	for iter_13_1, iter_13_2 in pairs(arg_13_1) do
		local var_13_5 = arg_13_0.items[var_13_4]

		if iter_13_2.Type == ECommonAwardType.Item and zbItemTable:isEquip(iter_13_2.Id) then
			var_13_5:refreshAward(iter_13_2.Type, iter_13_2.Id, iter_13_2.Count, false, false)
		else
			var_13_5:refreshAward(iter_13_2.Type, iter_13_2.Id, iter_13_2.Count, false)
		end

		var_13_4 = var_13_4 + 1

		if var_13_0 then
			arg_13_0.tableViewHelper:addCell(var_13_5)
		end
	end

	if var_13_0 then
		arg_13_0.tableViewHelper:refreshTabelView()
		arg_13_0.tableViewHelper:setTouchPriority(arg_13_0.btnReset:getTouchPriority())
	end
end

function var_0_0.onHero(arg_14_0)
	g_MainScene:showHeroSelectWnd():refreshHeroSelCallback(handler(arg_14_0, arg_14_0.heroSelectBack))
end

function var_0_0.heroSelectBack(arg_15_0, arg_15_1)
	arg_15_0.btnReset:setGray(arg_15_1 == nil)
	arg_15_0.btnReset:setEnabled(arg_15_1 ~= nil)
	arg_15_0.spriteAdd:setVisible(arg_15_1 == nil)
	arg_15_0.heroAvatar:setVisible(arg_15_1 ~= nil)

	if arg_15_1 ~= nil then
		arg_15_0.heroData = arg_15_1

		g_WsMsgHandler:WS_Hero_CalcReset_Req(arg_15_1.HeroBaseInfo.TemplateId, (arg_15_0.resetRate - 70) / 5 * arg_15_0.diamond)
		arg_15_0.heroAvatar:refreshHeroTemplateId(arg_15_1.HeroBaseInfo.TemplateId)
		arg_15_0.heroAvatar:setAnimation(ANIMATION_SEQUENCE_IDLE, true)
	end
end

function var_0_0.onReset(arg_16_0)
	if g_Self.kBagItemHandler:getItemCountByTemplateId(ITEM_ID_RESET) < 1 then
		g_Bubble:bubbleInfo(a2u("\xBB\xD8¯ʯ\xB2\xBB\xD7\xE3"))

		return
	end

	g_WsMsgHandler:WS_Hero_ConfirmReset_Req(arg_16_0.heroData.HeroBaseInfo.TemplateId, (arg_16_0.resetRate - 70) / 5 * arg_16_0.diamond)
end

function var_0_0.onRule(arg_17_0)
	g_MainScene:showRuleWnd(RuleType_HeroReset)
end
