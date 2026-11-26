require("gamelogic.zbGmActivityTimeHeroItem")

local var_0_0 = 105
local var_0_1 = class("zbGmActivityWnd_TimeHero")

var_0_1.__index = var_0_1

function createGmActivityWnd_TimeHero(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = var_0_1.new()

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	return var_1_0
end

function var_0_1.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	(function()
		arg_2_0.nodeParent = arg_2_1
		arg_2_0.btnPriority = arg_2_2
		arg_2_0.items = {}
		arg_2_0.tableview = nil
		arg_2_0.tableviewHelper = nil
		arg_2_0.timeHeroInfo = nil
	end)()

	if zbUtil:isValidTable(g_GameData.ActivityGm.LimitTimeHero) then
		for iter_2_0, iter_2_1 in pairs(g_GameData.ActivityGm.LimitTimeHero) do
			if iter_2_0 == arg_2_3 + 1 - arg_2_4 then
				arg_2_0.timeHeroInfo = iter_2_1

				break
			end
		end
	end
end

function var_0_1.confirmCreateView(arg_4_0)
	(function()
		if arg_4_0.node ~= nil then
			return
		end

		CCLabelTTF:beginDelayCreateTexture()

		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/gmactivity_timehero.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner", true)
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_4_0.lbTime = tolua.cast(var_5_2:getChildByTag(1001), "CCLabelTTF")
		arg_4_0.lbDesc = tolua.cast(var_5_2:getChildByTag(1002), "CCLabelTTF")
		arg_4_0.spriteHero = tolua.cast(var_5_2:getChildByTag(1), "CCSprite")

		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1000), "CCLabelTTF")

		arg_4_0.spriteMoney = tolua.cast(var_5_2:getChildByTag(3), "CCSprite")
		arg_4_0.btnBuy = tolua.cast(var_5_2:getChildByTag(4), "CCControlButton")
		arg_4_0.lbNextTime = tolua.cast(var_5_2:getChildByTag(5), "CCLabelTTF")

		local var_5_4 = tolua.cast(var_5_2:getChildByTag(6), "CCSprite")
		local var_5_5 = tolua.cast(var_5_4:getChildByTag(1001), "CCLabelTTF")
		local var_5_6 = tolua.cast(var_5_4:getChildByTag(1002), "CCLabelTTF")

		arg_4_0.lbMoney = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_3, arg_4_0.lbMoney)
		arg_4_0.lbMoney:setScale(0.55)

		arg_4_0.lbTotalScore = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_5, arg_4_0.lbTotalScore)
		arg_4_0.lbTotalScore:setScale(0.55)

		arg_4_0.lbLeftScore = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_6, arg_4_0.lbLeftScore)
		arg_4_0.lbLeftScore:setScale(0.55)
		arg_4_0.btnBuy:addHandleOfControlEvent(function()
			arg_4_0:onBuy()
		end, CCControlEventTouchUpInside)
		arg_4_0.btnBuy:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_4_0.btnBuy:setSwallowsTouches(false)
		arg_4_0.btnBuy:setTouchPriority(arg_4_0.btnPriority:getTouchPriority())

		arg_4_0.layerContent = tolua.cast(var_5_2:getChildByTag(7), "CCLayerColor")
		arg_4_0.node = var_5_1

		arg_4_0.nodeParent:addChild(var_5_1)
		CCLabelTTF:endDelayCreateTexture(var_5_1)
	end)()

	if arg_4_0.tableViewHelper ~= nil and arg_4_0.tableViewHelper.clearLuaEnterHandler ~= nil then
		arg_4_0.tableViewHelper:clearLuaEnterHandler()
	end

	if arg_4_0.tableView == nil then
		local var_4_0 = arg_4_0.layerContent:getContentSize()

		arg_4_0.tableViewHelper = zbTableViewHelper:create()
		arg_4_0.tableView = zbTableViewHelper:createTableView(var_4_0, var_4_0, 1, arg_4_0.tableViewHelper)

		arg_4_0.tableView:setPosition(0, 0)
		arg_4_0.tableView:setAnchorPoint(ccp(0, 0))
		arg_4_0.layerContent:addChild(arg_4_0.tableView)
	else
		arg_4_0.tableViewHelper:removeAllCells()
	end

	local var_4_1 = table.getn(arg_4_0.timeHeroInfo.ScoreList)
	local var_4_2 = table.getn(arg_4_0.items)

	for iter_4_0 = 1, var_4_2 do
		if iter_4_0 <= var_4_1 then
			local var_4_3 = arg_4_0.items[iter_4_0]

			arg_4_0.tableViewHelper:addCell(var_4_3)
		end
	end

	if var_4_1 - var_4_2 > 0 then
		for iter_4_1 = 1, var_4_1 - var_4_2 do
			local var_4_4 = zbTableViewHelper:create()

			var_4_4:loadCCBFile("ccbi/tb_gmactivity_hero.ccbi")

			local var_4_5 = createGmActivityTimeHeroItem(translateAndStrokeHelper(var_4_4:readCCBNode()))

			var_4_5:retain()

			arg_4_0.items[var_4_2 + iter_4_1] = var_4_5

			arg_4_0.tableViewHelper:addCell(var_4_5)
			var_4_4:releaseSelf()
		end
	end

	local var_4_6 = 1

	for iter_4_2, iter_4_3 in pairs(arg_4_0.timeHeroInfo.ScoreList) do
		arg_4_0.items[var_4_6]:refresh(iter_4_3, arg_4_0.timeHeroInfo.LeftScore, arg_4_0.timeHeroInfo.ActId)

		var_4_6 = var_4_6 + 1
	end

	arg_4_0.tableViewHelper:refreshTabelView()
	arg_4_0.tableViewHelper:setTouchPriority(arg_4_0.btnPriority:getTouchPriority())

	if arg_4_0.tableViewHelper.SetLuaEnterHandler ~= nil then
		arg_4_0.tableViewHelper:SetLuaEnterHandler(function()
			arg_4_0:onTBNotifyEnter()
		end)
	end
end

function var_0_1.onTBNotifyEnter(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.items) do
		iter_8_1:refreshScorllEffect()
	end
end

function var_0_1.refresh(arg_9_0)
	if arg_9_0.timeHeroInfo == nil then
		return
	end

	arg_9_0.timeHeroInfo = g_Self.kGmActivityHandler:getTimeHeroInfoByActId(arg_9_0.timeHeroInfo.ActId)

	if arg_9_0.timeHeroInfo == nil then
		return
	end

	if arg_9_0.tableView == nil then
		arg_9_0:confirmCreateView()
	end

	local var_9_0 = 1

	for iter_9_0, iter_9_1 in pairs(arg_9_0.timeHeroInfo.ScoreList) do
		arg_9_0.items[var_9_0]:refresh(iter_9_1, arg_9_0.timeHeroInfo.LeftScore, arg_9_0.timeHeroInfo.ActId)

		var_9_0 = var_9_0 + 1
	end

	zbUtil:setTableViewOffset(arg_9_0.tableViewHelper, kCCScrollViewDirectionVertical, kCCTableViewFillTopDown, 3, table.getn(arg_9_0.timeHeroInfo.ScoreList), var_0_0, 1)
	arg_9_0:refreshDetail()
end

function var_0_1.refreshDetail(arg_10_0)
	arg_10_0.lbTime:setString(a2u(zbUtil:SprintfMMDDCh(arg_10_0.timeHeroInfo.GmBaseInfo.ActStart)) .. a2u(zbUtil:SprintfHHCh(arg_10_0.timeHeroInfo.GmBaseInfo.ActStart)) .. " - " .. a2u(zbUtil:SprintfMMDDCh(arg_10_0.timeHeroInfo.GmBaseInfo.ActEnd)) .. a2u(zbUtil:SprintfHHCh(arg_10_0.timeHeroInfo.GmBaseInfo.ActEnd)))
	arg_10_0.lbDesc:setString(arg_10_0.timeHeroInfo.GmBaseInfo.Content)

	local var_10_0 = zbIconHelper:getHeroCardIconPath(arg_10_0.timeHeroInfo.TemplateId)

	arg_10_0.spriteHero:setTexture(CCTextureCache:sharedTextureCache():addImage(var_10_0))
	arg_10_0.lbMoney:setString(arg_10_0.timeHeroInfo.SingleCost)
	arg_10_0.lbTotalScore:setString(arg_10_0.timeHeroInfo.TotalScore)
	arg_10_0.lbLeftScore:setString(arg_10_0.timeHeroInfo.LeftScore)
end

function var_0_1.onBuy(arg_11_0)
	if g_Self.kGmActivityHandler:isShowTime(arg_11_0.timeHeroInfo.GmBaseInfo.ActStart, arg_11_0.timeHeroInfo.GmBaseInfo.ActEnd) == false then
		g_Bubble:bubbleInfo(a2u("\xBB\xB2\xBB\xD4\xDA\xD3\xD0Чʱ\xBC\xE4\xC4\xDA!"))

		return
	end

	if arg_11_0.timeHeroInfo.FreeTm - g_Self.kTimeHandler:getServerTime() <= 0 then
		g_WsMsgHandler:WS_ActivityGm_LimitTimeHero_Req(arg_11_0.timeHeroInfo.ActId)

		return
	end

	if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Diamond, arg_11_0.timeHeroInfo.SingleCost) == false then
		g_Bubble:bubbleInfo(a2u("\xD7\xEAʯ\xB2\xBB\xD7\xE3"))

		return
	end

	g_WsMsgHandler:WS_ActivityGm_LimitTimeHero_Req(arg_11_0.timeHeroInfo.ActId)
end

function var_0_1.onFrameUpdate(arg_12_0, arg_12_1)
	if arg_12_0.timeHeroInfo == nil or arg_12_0.timeHeroInfo.FreeTm == nil then
		return
	end

	if arg_12_0.timeHeroInfo.FreeTm - g_Self.kTimeHandler:getServerTime() > 0 then
		local var_12_0 = zbUtil:SprintfHHMMSSNo24(arg_12_0.timeHeroInfo.FreeTm - g_Self.kTimeHandler:getServerTime())

		arg_12_0.lbNextTime:setString(a2u("\xBE\xE0\xC0\xEB\xC3\xE2\xB7ѳ\xE9ȡʱ\xBC\xE4:") .. a2u(var_12_0))
	else
		arg_12_0.lbNextTime:setString(a2u("\xC3\xE2\xB7ѳ\xE9ȡ"))
	end
end
