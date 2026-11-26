require("gamelogic.zbHeroSoulHallItem")

zbHeroSoulHallWnd = class("zbHeroSoulHallWnd", zbBaseWnd)
zbHeroSoulHallWnd.__index = zbHeroSoulHallWnd

function zbHeroSoulHallWnd.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbHeroSoulHallWnd)

	return arg_1_0
end

function zbHeroSoulHallWnd.create(arg_2_0)
	local var_2_0 = zbHeroSoulHallWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNodeRGBA:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function zbHeroSoulHallWnd.init(arg_3_0)
	local function var_3_0()
		arg_3_0.hallItems = {}
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/heroSoulHall.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")

		arg_3_0.layer = tolua.cast(var_5_1:getChildByTag(1), "CCNode")
		arg_3_0.layerContent = tolua.cast(arg_3_0.layer:getChildByTag(1), "CCNode")
		arg_3_0.maskPanelLeft = tolua.cast(arg_3_0.layerContent:getChildByTag(1), "CCNode")
		arg_3_0.maskPanelRight = tolua.cast(arg_3_0.layerContent:getChildByTag(2), "CCNode")

		local var_5_2 = tolua.cast(var_5_1:getChildByTag(102), "CCNode")

		arg_3_0.btnRule = tolua.cast(var_5_2:getChildByTag(1), "CCControlButton")
		arg_3_0.btnRank = tolua.cast(var_5_2:getChildByTag(2), "CCControlButton")

		arg_3_0.btnRule:addHandleOfControlEvent(function()
			arg_3_0:onRule()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnRank:addHandleOfControlEvent(function()
			arg_3_0:onRank()
		end, CCControlEventTouchUpInside)
		zbUIEffect:runFadeToAction(arg_3_0.maskPanelLeft)
		zbUIEffect:runFadeToAction(arg_3_0.maskPanelRight)

		local var_5_3 = zbHeroSoulHallTable.count
		local var_5_4 = arg_3_0.layerContent:getContentSize()
		local var_5_5 = CCSizeMake(var_5_4.width * var_5_3 / 4, var_5_4.height)
		local var_5_6 = CCSizeMake(var_5_4.width, var_5_4.height)

		arg_3_0.tableViewHelper = zbTableViewHelper:create()
		arg_3_0.tableView = zbTableViewHelper:createTableView(var_5_5, var_5_6, kCCScrollViewDirectionHorizontal, arg_3_0.tableViewHelper)

		arg_3_0.tableView:setPosition(ccp(0, 0))
		arg_3_0.tableView:setAnchorPoint(ccp(0, 0))
		arg_3_0.layerContent:addChild(arg_3_0.tableView)
		arg_3_0.tableViewHelper:setMaskPanel(arg_3_0.maskPanelLeft, arg_3_0.maskPanelRight, nil, nil)

		if var_5_3 > 0 then
			local var_5_7 = zbTableViewHelper:create()

			var_5_7:loadCCBFile("ccbi/tb_heroSoulHall.ccbi")

			for iter_5_0 = 1, var_5_3 do
				local var_5_8 = zbHeroSoulHallItem:create(var_5_7:readCCBNode(), iter_5_0)

				arg_3_0.hallItems[iter_5_0] = var_5_8

				arg_3_0.tableViewHelper:addCell(var_5_8)
			end

			var_5_7:releaseSelf()
		end

		arg_3_0.tableViewHelper:refreshTabelView()
		arg_3_0.tableViewHelper:setTouchPriority(arg_3_0.btnRule:getTouchPriority())
		arg_3_0:addChild(var_5_1)
		arg_3_0:createMoneyPanel(var_5_1, {
			EMoneyPanelResType.Gold,
			EMoneyPanelResType.Diamond
		}, function()
			arg_3_0:hide()
		end)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setHideCallback(function()
		arg_3_0:onHide()
	end)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refresh()
	end, zbGameEvent.Event_HeroSoulHall_Ack)
end

function zbHeroSoulHallWnd.doDestroy(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.hallItems) do
		iter_11_1:releaseBg()
	end
end

function zbHeroSoulHallWnd.onHide(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.hallItems) do
		iter_12_1:releaseBg()
	end
end

function zbHeroSoulHallWnd.onRule(arg_13_0)
	g_MainScene:showRuleWnd(RuleType_HeroSoul)
end

function zbHeroSoulHallWnd.onRank(arg_14_0)
	if zbUtil:isValidTable(g_Self.kRankHandler.HeroSoulRankData.RankList) == false or table.getn(g_Self.kRankHandler.HeroSoulRankData.RankList) == 0 then
		g_WsMsgHandler:WS_Rank_Comm_Req(ERankType.HeroSoul)
	else
		g_MainScene:showHeroSoulRank()
	end
end

function zbHeroSoulHallWnd.refresh(arg_15_0)
	local var_15_0 = 1

	for iter_15_0, iter_15_1 in pairs(zbHeroSoulHallTable.records) do
		local var_15_1 = arg_15_0.hallItems[var_15_0]

		arg_15_0.hallItems[var_15_0]:refresh(iter_15_1)

		var_15_0 = var_15_0 + 1
	end
end
