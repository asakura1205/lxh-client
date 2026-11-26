require("gamelogic.zbTabWnd")
require("gamelogic.zbGmActivityButton")
require("gamelogic.zbGmActivityWnd_Notice")
require("gamelogic.zbGmActivityWnd_Double")
require("gamelogic.zbGmActivityWnd_Active")
require("gamelogic.zbGmActivityWnd_Exchange")
require("gamelogic.zbGmActivityWnd_TimeHero")
require("gamelogic.zbGmActivityWnd_TimeShop")
require("gamelogic.zbGmActivityWnd_Fund")
require("gamelogic.zbGmActivityWnd_FundWelfare")
require("gamelogic.zbGmActivityWnd_RechargeDaily")
require("gamelogic.zbGmActivityWnd_RechargeDailySum")
require("gamelogic.zbGmActivityWnd_RechargeDailySingle")
require("gamelogic.zbGmActivityWnd_RechargeSingle")
require("gamelogic.zbGmActivityWnd_RechargeSum")
require("gamelogic.zbGmActivityWnd_ConsumSum")
require("gamelogic.zbGmActivityWnd_ConsumDailySum")
require("gamelogic.zbGmActivityWnd_HeroReset")

zbGmActivityWnd = class("zbGmActivityWnd", zbTabWnd)
zbGmActivityWnd.__index = zbGmActivityWnd

function zbGmActivityWnd.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbGmActivityWnd)

	return arg_1_0
end

function createGmActivityWnd()
	local var_2_0 = zbGmActivityWnd.extend(zbTabWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNodeRGBA:create()))))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function zbGmActivityWnd.init(arg_3_0)
	local function var_3_0()
		arg_3_0.modules = {}
		arg_3_0.first = {}
		arg_3_0.items = {}
		arg_3_0.notifyButton = {}
	end

	local function var_3_1(arg_5_0)
		local var_5_0 = CCSprite:create(NOTIFY_TAG_PATH)

		var_5_0:setAnchorPoint(ccp(0.5, 0.5))
		var_5_0:setPosition(arg_5_0:getContentSize().width - 25, arg_5_0:getContentSize().height / 2 + 20)
		var_5_0:setVisible(false)
		arg_5_0:addChild(var_5_0)
		zbUIEffect:createNotifyTagScaleAction(var_5_0)

		return var_5_0
	end

	local function var_3_2()
		local var_6_0 = CCBProxy:create()
		local var_6_1 = CCBReaderLoad("ccbi/gmactivity.ccbi", var_6_0, true, "HelloCocosBuilderLayerOwner")
		local var_6_2 = tolua.cast(var_6_1:getChildByTag(1), "CCNode")
		local var_6_3 = tolua.cast(var_6_2:getChildByTag(0), "CCNode")

		arg_3_0.layerMenu = tolua.cast(var_6_3:getChildByTag(0), "CCNode")
		arg_3_0.maskPanelUp = tolua.cast(var_6_3:getChildByTag(101), "CCSprite")
		arg_3_0.maskPanelDown = tolua.cast(var_6_3:getChildByTag(102), "CCSprite")

		zbUIEffect:runFadeToAction(arg_3_0.maskPanelUp)
		zbUIEffect:runFadeToAction(arg_3_0.maskPanelDown)

		local var_6_4 = arg_3_0.layerMenu:getContentSize()
		local var_6_5 = CCSizeMake(var_6_4.width, 70 * GMTAB_COUNT)
		local var_6_6 = CCSizeMake(var_6_4.width, var_6_4.height)

		arg_3_0.tableViewHelper = zbTableViewHelper:create()
		arg_3_0.tableView = zbTableViewHelper:createTableView(var_6_5, var_6_6, 1, arg_3_0.tableViewHelper)

		arg_3_0.tableView:setPosition(ccp(0, 0))
		arg_3_0.tableView:setAnchorPoint(ccp(0, 0))
		arg_3_0.layerMenu:addChild(arg_3_0.tableView)
		arg_3_0.tableViewHelper:setMaskPanel(nil, nil, arg_3_0.maskPanelUp, arg_3_0.maskPanelDown)

		arg_3_0.buttonNum = 1
		arg_3_0.tabButtons = {}

		local var_6_7 = zbTableViewHelper:create()

		var_6_7:loadCCBFile("ccbi/tb_gmactivitybtn.ccbi")

		if zbUtil:isValidTable(g_GameData.ActivityGm) and zbUtil:isValidTable(g_GameData.ActivityGm.Fund) and g_Self.kGmActivityHandler:isShowTime(g_GameData.ActivityGm.Fund.GmBaseInfo.ShowStart, g_GameData.ActivityGm.Fund.GmBaseInfo.ShowEnd) then
			local var_6_8 = g_Self.kGmActivityHandler:isShowTime(g_GameData.ActivityGm.Fund.GmBaseInfo.ActStart, g_GameData.ActivityGm.Fund.GmBaseInfo.ActEnd)
			local var_6_9 = createGmActivityButton(var_6_7:readCCBNode(), 0, g_GameData.ActivityGm.Fund.GmBaseInfo.Title, var_6_8)

			arg_3_0.tabButtons[arg_3_0.buttonNum] = var_6_9.btnFrame
			arg_3_0.notifyFund = var_3_1(var_6_9)
			arg_3_0.fundNum = arg_3_0.buttonNum
			arg_3_0.buttonNum = arg_3_0.buttonNum + 1

			table.insert(arg_3_0.items, var_6_9)
			arg_3_0.tableViewHelper:addCell(var_6_9)
		end

		if zbUtil:isValidTable(g_GameData.ActivityGm) and zbUtil:isValidTable(g_GameData.ActivityGm.FundWelfare) and g_Self.kGmActivityHandler:isShowTime(g_GameData.ActivityGm.FundWelfare.GmBaseInfo.ShowStart, g_GameData.ActivityGm.FundWelfare.GmBaseInfo.ShowEnd) then
			local var_6_10 = g_Self.kGmActivityHandler:isShowTime(g_GameData.ActivityGm.FundWelfare.GmBaseInfo.ActStart, g_GameData.ActivityGm.FundWelfare.GmBaseInfo.ActEnd)
			local var_6_11 = createGmActivityButton(var_6_7:readCCBNode(), 0, g_GameData.ActivityGm.FundWelfare.GmBaseInfo.Title, var_6_10)

			arg_3_0.tabButtons[arg_3_0.buttonNum] = var_6_11.btnFrame
			arg_3_0.notifyFundWelfare = var_3_1(var_6_11)
			arg_3_0.fundWelfareNum = arg_3_0.buttonNum
			arg_3_0.buttonNum = arg_3_0.buttonNum + 1

			table.insert(arg_3_0.items, var_6_11)
			arg_3_0.tableViewHelper:addCell(var_6_11)
		end

		arg_3_0.noticeNum = 0
		arg_3_0.noticebtnBeginNum = arg_3_0.buttonNum

		if zbUtil:isValidTable(g_GameData.ActivityGm) and zbUtil:isValidTable(g_GameData.ActivityGm.Notice) then
			local var_6_12 = 0

			for iter_6_0, iter_6_1 in pairs(g_GameData.ActivityGm.Notice) do
				if g_Self.kGmActivityHandler:isShowTime(iter_6_1.ShowStart, iter_6_1.ShowEnd) then
					local var_6_13 = g_Self.kGmActivityHandler:isShowTime(iter_6_1.ActStart, iter_6_1.ActEnd)
					local var_6_14 = createGmActivityButton(var_6_7:readCCBNode(), 0, iter_6_1.Title, var_6_13)

					arg_3_0.tabButtons[arg_3_0.buttonNum] = var_6_14.btnFrame
					arg_3_0.buttonNum = arg_3_0.buttonNum + 1

					table.insert(arg_3_0.items, var_6_14)
					arg_3_0.tableViewHelper:addCell(var_6_14)

					var_6_12 = var_6_12 + 1
				end
			end

			arg_3_0.noticeNum = var_6_12
		end

		arg_3_0.noticebtnEndNum = arg_3_0.buttonNum
		arg_3_0.doubleNum = 0
		arg_3_0.doublebtnBeginNum = arg_3_0.buttonNum

		if zbUtil:isValidTable(g_GameData.ActivityGm) and zbUtil:isValidTable(g_GameData.ActivityGm.DoubleDrop) then
			local var_6_15 = 0

			for iter_6_2, iter_6_3 in pairs(g_GameData.ActivityGm.DoubleDrop) do
				if g_Self.kGmActivityHandler:isShowTime(iter_6_3.GmBaseInfo.ShowStart, iter_6_3.GmBaseInfo.ShowEnd) then
					local var_6_16 = g_Self.kGmActivityHandler:isShowTime(iter_6_3.GmBaseInfo.ActStart, iter_6_3.GmBaseInfo.ActEnd)
					local var_6_17 = createGmActivityButton(var_6_7:readCCBNode(), 0, iter_6_3.GmBaseInfo.Title, var_6_16)

					arg_3_0.tabButtons[arg_3_0.buttonNum] = var_6_17.btnFrame
					arg_3_0.buttonNum = arg_3_0.buttonNum + 1

					table.insert(arg_3_0.items, var_6_17)
					arg_3_0.tableViewHelper:addCell(var_6_17)

					var_6_15 = var_6_15 + 1
				end
			end

			arg_3_0.doubleNum = var_6_15
		end

		arg_3_0.doublebtnEndNum = arg_3_0.buttonNum
		arg_3_0.activeNum = 0
		arg_3_0.activebtnBeginNum = arg_3_0.buttonNum

		if zbUtil:isValidTable(g_GameData.ActivityGm) and zbUtil:isValidTable(g_GameData.ActivityGm.DailyActive) then
			local var_6_18 = 0

			for iter_6_4, iter_6_5 in pairs(g_GameData.ActivityGm.DailyActive) do
				if g_Self.kGmActivityHandler:isShowTime(iter_6_5.GmBaseInfo.ShowStart, iter_6_5.GmBaseInfo.ShowEnd) then
					local var_6_19 = g_Self.kGmActivityHandler:isShowTime(iter_6_5.GmBaseInfo.ActStart, iter_6_5.GmBaseInfo.ActEnd)
					local var_6_20 = createGmActivityButton(var_6_7:readCCBNode(), 0, iter_6_5.GmBaseInfo.Title, var_6_19)

					arg_3_0.tabButtons[arg_3_0.buttonNum] = var_6_20.btnFrame
					arg_3_0.notifyButton[arg_3_0.buttonNum] = var_3_1(var_6_20)
					arg_3_0.buttonNum = arg_3_0.buttonNum + 1

					table.insert(arg_3_0.items, var_6_20)
					arg_3_0.tableViewHelper:addCell(var_6_20)

					var_6_18 = var_6_18 + 1
				end
			end

			arg_3_0.activeNum = var_6_18
		end

		arg_3_0.activebtnEndNum = arg_3_0.buttonNum
		arg_3_0.exchangeNum = 0
		arg_3_0.exchangebtnBeginNum = arg_3_0.buttonNum

		if zbUtil:isValidTable(g_GameData.ActivityGm) and zbUtil:isValidTable(g_GameData.ActivityGm.ItemExchange) then
			local var_6_21 = 0

			for iter_6_6, iter_6_7 in pairs(g_GameData.ActivityGm.ItemExchange) do
				if g_Self.kGmActivityHandler:isShowTime(iter_6_7.GmBaseInfo.ShowStart, iter_6_7.GmBaseInfo.ShowEnd) then
					local var_6_22 = g_Self.kGmActivityHandler:isShowTime(iter_6_7.GmBaseInfo.ActStart, iter_6_7.GmBaseInfo.ActEnd)
					local var_6_23 = createGmActivityButton(var_6_7:readCCBNode(), 0, iter_6_7.GmBaseInfo.Title, var_6_22)

					arg_3_0.tabButtons[arg_3_0.buttonNum] = var_6_23.btnFrame
					arg_3_0.notifyButton[arg_3_0.buttonNum] = var_3_1(var_6_23)
					arg_3_0.buttonNum = arg_3_0.buttonNum + 1

					table.insert(arg_3_0.items, var_6_23)
					arg_3_0.tableViewHelper:addCell(var_6_23)

					var_6_21 = var_6_21 + 1
				end
			end

			arg_3_0.exchangeNum = var_6_21
		end

		arg_3_0.exchangebtnEndNum = arg_3_0.buttonNum
		arg_3_0.timeHeroNum = 0
		arg_3_0.timeHerobtnBeginNum = arg_3_0.buttonNum

		if zbUtil:isValidTable(g_GameData.ActivityGm) and zbUtil:isValidTable(g_GameData.ActivityGm.LimitTimeHero) then
			local var_6_24 = 0

			for iter_6_8, iter_6_9 in pairs(g_GameData.ActivityGm.LimitTimeHero) do
				if g_Self.kGmActivityHandler:isShowTime(iter_6_9.GmBaseInfo.ShowStart, iter_6_9.GmBaseInfo.ShowEnd) then
					local var_6_25 = g_Self.kGmActivityHandler:isShowTime(iter_6_9.GmBaseInfo.ActStart, iter_6_9.GmBaseInfo.ActEnd)
					local var_6_26 = createGmActivityButton(var_6_7:readCCBNode(), 0, iter_6_9.GmBaseInfo.Title, var_6_25)

					arg_3_0.tabButtons[arg_3_0.buttonNum] = var_6_26.btnFrame
					arg_3_0.notifyButton[arg_3_0.buttonNum] = var_3_1(var_6_26)
					arg_3_0.buttonNum = arg_3_0.buttonNum + 1

					table.insert(arg_3_0.items, var_6_26)
					arg_3_0.tableViewHelper:addCell(var_6_26)

					var_6_24 = var_6_24 + 1
				end
			end

			arg_3_0.timeHeroNum = var_6_24
		end

		arg_3_0.timeHerobtnEndNum = arg_3_0.buttonNum
		arg_3_0.timeShopNum = 0
		arg_3_0.timeShopbtnBeginNum = arg_3_0.buttonNum

		if zbUtil:isValidTable(g_GameData.ActivityGm) and zbUtil:isValidTable(g_GameData.ActivityGm.LimitTimeShop) then
			local var_6_27 = 0

			for iter_6_10, iter_6_11 in pairs(g_GameData.ActivityGm.LimitTimeShop) do
				if g_Self.kGmActivityHandler:isShowTime(iter_6_11.GmBaseInfo.ShowStart, iter_6_11.GmBaseInfo.ShowEnd) then
					local var_6_28 = g_Self.kGmActivityHandler:isShowTime(iter_6_11.GmBaseInfo.ActStart, iter_6_11.GmBaseInfo.ActEnd)
					local var_6_29 = createGmActivityButton(var_6_7:readCCBNode(), 0, iter_6_11.GmBaseInfo.Title, var_6_28)

					arg_3_0.tabButtons[arg_3_0.buttonNum] = var_6_29.btnFrame
					arg_3_0.buttonNum = arg_3_0.buttonNum + 1

					table.insert(arg_3_0.items, var_6_29)
					arg_3_0.tableViewHelper:addCell(var_6_29)

					var_6_27 = var_6_27 + 1
				end
			end

			arg_3_0.timeShopNum = var_6_27
		end

		arg_3_0.timeShopbtnEndNum = arg_3_0.buttonNum
		arg_3_0.rechargeDailyNum = 0
		arg_3_0.rechargeDailybtnBeginNum = arg_3_0.buttonNum

		if zbUtil:isValidTable(g_GameData.ActivityGm) and zbUtil:isValidTable(g_GameData.ActivityGm.RechargeDaily) then
			local var_6_30 = 0

			for iter_6_12, iter_6_13 in pairs(g_GameData.ActivityGm.RechargeDaily) do
				if g_Self.kGmActivityHandler:isShowTime(iter_6_13.GmBaseInfo.ShowStart, iter_6_13.GmBaseInfo.ShowEnd) then
					local var_6_31 = g_Self.kGmActivityHandler:isShowTime(iter_6_13.GmBaseInfo.ActStart, iter_6_13.GmBaseInfo.ActEnd)
					local var_6_32 = createGmActivityButton(var_6_7:readCCBNode(), 0, iter_6_13.GmBaseInfo.Title, var_6_31)

					arg_3_0.tabButtons[arg_3_0.buttonNum] = var_6_32.btnFrame
					arg_3_0.notifyButton[arg_3_0.buttonNum] = var_3_1(var_6_32)
					arg_3_0.buttonNum = arg_3_0.buttonNum + 1

					table.insert(arg_3_0.items, var_6_32)
					arg_3_0.tableViewHelper:addCell(var_6_32)

					var_6_30 = var_6_30 + 1
				end
			end

			arg_3_0.rechargeDailyNum = var_6_30
		end

		arg_3_0.rechargeDailybtnEndNum = arg_3_0.buttonNum
		arg_3_0.rechargeDailySumNum = 0
		arg_3_0.rechargeDailySumbtnBeginNum = arg_3_0.buttonNum

		if zbUtil:isValidTable(g_GameData.ActivityGm) and zbUtil:isValidTable(g_GameData.ActivityGm.RechargeDailySum) then
			local var_6_33 = 0

			for iter_6_14, iter_6_15 in pairs(g_GameData.ActivityGm.RechargeDailySum) do
				if g_Self.kGmActivityHandler:isShowTime(iter_6_15.GmBaseInfo.ShowStart, iter_6_15.GmBaseInfo.ShowEnd) then
					local var_6_34 = g_Self.kGmActivityHandler:isShowTime(iter_6_15.GmBaseInfo.ActStart, iter_6_15.GmBaseInfo.ActEnd)
					local var_6_35 = createGmActivityButton(var_6_7:readCCBNode(), 0, iter_6_15.GmBaseInfo.Title, var_6_34)

					arg_3_0.tabButtons[arg_3_0.buttonNum] = var_6_35.btnFrame
					arg_3_0.notifyButton[arg_3_0.buttonNum] = var_3_1(var_6_35)
					arg_3_0.buttonNum = arg_3_0.buttonNum + 1

					table.insert(arg_3_0.items, var_6_35)
					arg_3_0.tableViewHelper:addCell(var_6_35)

					var_6_33 = var_6_33 + 1
				end
			end

			arg_3_0.rechargeDailySumNum = var_6_33
		end

		arg_3_0.rechargeDailySumbtnEndNum = arg_3_0.buttonNum
		arg_3_0.rechargeDailySingleNum = 0
		arg_3_0.rechargeDailySinglebtnBeginNum = arg_3_0.buttonNum

		if zbUtil:isValidTable(g_GameData.ActivityGm) and zbUtil:isValidTable(g_GameData.ActivityGm.RechargeDailySingle) then
			local var_6_36 = 0

			for iter_6_16, iter_6_17 in pairs(g_GameData.ActivityGm.RechargeDailySingle) do
				if g_Self.kGmActivityHandler:isShowTime(iter_6_17.GmBaseInfo.ShowStart, iter_6_17.GmBaseInfo.ShowEnd) then
					local var_6_37 = g_Self.kGmActivityHandler:isShowTime(iter_6_17.GmBaseInfo.ActStart, iter_6_17.GmBaseInfo.ActEnd)
					local var_6_38 = createGmActivityButton(var_6_7:readCCBNode(), 0, iter_6_17.GmBaseInfo.Title, var_6_37)

					arg_3_0.tabButtons[arg_3_0.buttonNum] = var_6_38.btnFrame
					arg_3_0.notifyButton[arg_3_0.buttonNum] = var_3_1(var_6_38)
					arg_3_0.buttonNum = arg_3_0.buttonNum + 1

					table.insert(arg_3_0.items, var_6_38)
					arg_3_0.tableViewHelper:addCell(var_6_38)

					var_6_36 = var_6_36 + 1
				end
			end

			arg_3_0.rechargeDailySingleNum = var_6_36
		end

		arg_3_0.rechargeDailySinglebtnEndNum = arg_3_0.buttonNum
		arg_3_0.rechargeSingleNum = 0
		arg_3_0.rechargeSinglebtnBeginNum = arg_3_0.buttonNum

		if zbUtil:isValidTable(g_GameData.ActivityGm) and zbUtil:isValidTable(g_GameData.ActivityGm.RechargeSingle) then
			local var_6_39 = 0

			for iter_6_18, iter_6_19 in pairs(g_GameData.ActivityGm.RechargeSingle) do
				if g_Self.kGmActivityHandler:isShowTime(iter_6_19.GmBaseInfo.ShowStart, iter_6_19.GmBaseInfo.ShowEnd) then
					local var_6_40 = g_Self.kGmActivityHandler:isShowTime(iter_6_19.GmBaseInfo.ActStart, iter_6_19.GmBaseInfo.ActEnd)
					local var_6_41 = createGmActivityButton(var_6_7:readCCBNode(), 0, iter_6_19.GmBaseInfo.Title, var_6_40)

					arg_3_0.tabButtons[arg_3_0.buttonNum] = var_6_41.btnFrame
					arg_3_0.notifyButton[arg_3_0.buttonNum] = var_3_1(var_6_41)
					arg_3_0.buttonNum = arg_3_0.buttonNum + 1

					table.insert(arg_3_0.items, var_6_41)
					arg_3_0.tableViewHelper:addCell(var_6_41)

					var_6_39 = var_6_39 + 1
				end
			end

			arg_3_0.rechargeSingleNum = var_6_39
		end

		arg_3_0.rechargeSinglebtnEndNum = arg_3_0.buttonNum
		arg_3_0.rechargeSumNum = 0
		arg_3_0.rechargeSumbtnBeginNum = arg_3_0.buttonNum

		if zbUtil:isValidTable(g_GameData.ActivityGm) and zbUtil:isValidTable(g_GameData.ActivityGm.RechargeSum) then
			local var_6_42 = 0

			for iter_6_20, iter_6_21 in pairs(g_GameData.ActivityGm.RechargeSum) do
				if g_Self.kGmActivityHandler:isShowTime(iter_6_21.GmBaseInfo.ShowStart, iter_6_21.GmBaseInfo.ShowEnd) then
					local var_6_43 = g_Self.kGmActivityHandler:isShowTime(iter_6_21.GmBaseInfo.ActStart, iter_6_21.GmBaseInfo.ActEnd)
					local var_6_44 = createGmActivityButton(var_6_7:readCCBNode(), 0, iter_6_21.GmBaseInfo.Title, var_6_43)

					arg_3_0.tabButtons[arg_3_0.buttonNum] = var_6_44.btnFrame
					arg_3_0.notifyButton[arg_3_0.buttonNum] = var_3_1(var_6_44)
					arg_3_0.buttonNum = arg_3_0.buttonNum + 1

					table.insert(arg_3_0.items, var_6_44)
					arg_3_0.tableViewHelper:addCell(var_6_44)

					var_6_42 = var_6_42 + 1
				end
			end

			arg_3_0.rechargeSumNum = var_6_42
		end

		arg_3_0.rechargeSumbtnEndNum = arg_3_0.buttonNum
		arg_3_0.consumSumNum = 0
		arg_3_0.consumSumbtnBeginNum = arg_3_0.buttonNum

		if zbUtil:isValidTable(g_GameData.ActivityGm) and zbUtil:isValidTable(g_GameData.ActivityGm.ConsumSum) then
			local var_6_45 = 0

			for iter_6_22, iter_6_23 in pairs(g_GameData.ActivityGm.ConsumSum) do
				if g_Self.kGmActivityHandler:isShowTime(iter_6_23.GmBaseInfo.ShowStart, iter_6_23.GmBaseInfo.ShowEnd) then
					local var_6_46 = g_Self.kGmActivityHandler:isShowTime(iter_6_23.GmBaseInfo.ActStart, iter_6_23.GmBaseInfo.ActEnd)
					local var_6_47 = createGmActivityButton(var_6_7:readCCBNode(), 0, iter_6_23.GmBaseInfo.Title, var_6_46)

					arg_3_0.tabButtons[arg_3_0.buttonNum] = var_6_47.btnFrame
					arg_3_0.notifyButton[arg_3_0.buttonNum] = var_3_1(var_6_47)
					arg_3_0.buttonNum = arg_3_0.buttonNum + 1

					table.insert(arg_3_0.items, var_6_47)
					arg_3_0.tableViewHelper:addCell(var_6_47)

					var_6_45 = var_6_45 + 1
				end
			end

			arg_3_0.consumSumNum = var_6_45
		end

		arg_3_0.consumSumbtnEndNum = arg_3_0.buttonNum
		arg_3_0.consumDailySumNum = 0
		arg_3_0.consumDailySumbtnBeginNum = arg_3_0.buttonNum

		if zbUtil:isValidTable(g_GameData.ActivityGm) and zbUtil:isValidTable(g_GameData.ActivityGm.ConsumDailySum) then
			local var_6_48 = 0

			for iter_6_24, iter_6_25 in pairs(g_GameData.ActivityGm.ConsumDailySum) do
				if g_Self.kGmActivityHandler:isShowTime(iter_6_25.GmBaseInfo.ShowStart, iter_6_25.GmBaseInfo.ShowEnd) then
					local var_6_49 = g_Self.kGmActivityHandler:isShowTime(iter_6_25.GmBaseInfo.ActStart, iter_6_25.GmBaseInfo.ActEnd)
					local var_6_50 = createGmActivityButton(var_6_7:readCCBNode(), 0, iter_6_25.GmBaseInfo.Title, var_6_49)

					arg_3_0.tabButtons[arg_3_0.buttonNum] = var_6_50.btnFrame
					arg_3_0.notifyButton[arg_3_0.buttonNum] = var_3_1(var_6_50)
					arg_3_0.buttonNum = arg_3_0.buttonNum + 1

					table.insert(arg_3_0.items, var_6_50)
					arg_3_0.tableViewHelper:addCell(var_6_50)

					var_6_48 = var_6_48 + 1
				end
			end

			arg_3_0.consumDailySumNum = var_6_48
		end

		arg_3_0.consumDailySumbtnEndNum = arg_3_0.buttonNum
		arg_3_0.heroResetNum = 0
		arg_3_0.heroResetbtnBeginNum = arg_3_0.buttonNum

		if zbUtil:isValidTable(g_GameData.ActivityGm) and zbUtil:isValidTable(g_GameData.ActivityGm.HeroReset) then
			local var_6_51 = 0

			for iter_6_26, iter_6_27 in pairs(g_GameData.ActivityGm.HeroReset) do
				if g_Self.kGmActivityHandler:isShowTime(iter_6_27.GmBaseInfo.ShowStart, iter_6_27.GmBaseInfo.ShowEnd) then
					local var_6_52 = g_Self.kGmActivityHandler:isShowTime(iter_6_27.GmBaseInfo.ActStart, iter_6_27.GmBaseInfo.ActEnd)
					local var_6_53 = createGmActivityButton(var_6_7:readCCBNode(), 0, iter_6_27.GmBaseInfo.Title, var_6_52)

					arg_3_0.tabButtons[arg_3_0.buttonNum] = var_6_53.btnFrame
					arg_3_0.buttonNum = arg_3_0.buttonNum + 1

					table.insert(arg_3_0.items, var_6_53)
					arg_3_0.tableViewHelper:addCell(var_6_53)

					var_6_51 = var_6_51 + 1
				end
			end

			arg_3_0.heroResetNum = var_6_51
		end

		arg_3_0.heroResetbtnEndNum = arg_3_0.buttonNum

		arg_3_0.tableViewHelper:refreshTabelView()

		arg_3_0.tabLayers = {}

		if arg_3_0.fundNum then
			arg_3_0.tabLayers[arg_3_0.fundNum] = tolua.cast(var_6_2:getChildByTag(1), "CCNode")
		end

		if arg_3_0.fundWelfareNum then
			arg_3_0.tabLayers[arg_3_0.fundWelfareNum] = tolua.cast(var_6_2:getChildByTag(2), "CCNode")
		end

		for iter_6_28 = arg_3_0.noticebtnBeginNum, arg_3_0.noticebtnEndNum - 1 do
			arg_3_0.tabLayers[iter_6_28] = tolua.cast(var_6_2:getChildByTag(3), "CCNode")
		end

		for iter_6_29 = arg_3_0.doublebtnBeginNum, arg_3_0.doublebtnEndNum - 1 do
			arg_3_0.tabLayers[iter_6_29] = tolua.cast(var_6_2:getChildByTag(4), "CCNode")
		end

		for iter_6_30 = arg_3_0.activebtnBeginNum, arg_3_0.activebtnEndNum - 1 do
			arg_3_0.tabLayers[iter_6_30] = tolua.cast(var_6_2:getChildByTag(5), "CCNode")
		end

		for iter_6_31 = arg_3_0.exchangebtnBeginNum, arg_3_0.exchangebtnEndNum - 1 do
			arg_3_0.tabLayers[iter_6_31] = tolua.cast(var_6_2:getChildByTag(6), "CCNode")
		end

		for iter_6_32 = arg_3_0.timeHerobtnBeginNum, arg_3_0.timeHerobtnEndNum - 1 do
			arg_3_0.tabLayers[iter_6_32] = tolua.cast(var_6_2:getChildByTag(7), "CCNode")
		end

		for iter_6_33 = arg_3_0.timeShopbtnBeginNum, arg_3_0.timeShopbtnEndNum - 1 do
			arg_3_0.tabLayers[iter_6_33] = tolua.cast(var_6_2:getChildByTag(8), "CCNode")
		end

		for iter_6_34 = arg_3_0.rechargeDailybtnBeginNum, arg_3_0.rechargeDailybtnEndNum - 1 do
			arg_3_0.tabLayers[iter_6_34] = tolua.cast(var_6_2:getChildByTag(9), "CCNode")
		end

		for iter_6_35 = arg_3_0.rechargeDailySumbtnBeginNum, arg_3_0.rechargeDailySumbtnEndNum - 1 do
			arg_3_0.tabLayers[iter_6_35] = tolua.cast(var_6_2:getChildByTag(10), "CCNode")
		end

		for iter_6_36 = arg_3_0.rechargeDailySinglebtnBeginNum, arg_3_0.rechargeDailySinglebtnEndNum - 1 do
			arg_3_0.tabLayers[iter_6_36] = tolua.cast(var_6_2:getChildByTag(11), "CCNode")
		end

		for iter_6_37 = arg_3_0.rechargeSinglebtnBeginNum, arg_3_0.rechargeSinglebtnEndNum - 1 do
			arg_3_0.tabLayers[iter_6_37] = tolua.cast(var_6_2:getChildByTag(12), "CCNode")
		end

		for iter_6_38 = arg_3_0.rechargeSumbtnBeginNum, arg_3_0.rechargeSumbtnEndNum - 1 do
			arg_3_0.tabLayers[iter_6_38] = tolua.cast(var_6_2:getChildByTag(13), "CCNode")
		end

		for iter_6_39 = arg_3_0.consumSumbtnBeginNum, arg_3_0.consumSumbtnEndNum - 1 do
			arg_3_0.tabLayers[iter_6_39] = tolua.cast(var_6_2:getChildByTag(14), "CCNode")
		end

		for iter_6_40 = arg_3_0.consumDailySumbtnBeginNum, arg_3_0.consumDailySumbtnEndNum - 1 do
			arg_3_0.tabLayers[iter_6_40] = tolua.cast(var_6_2:getChildByTag(15), "CCNode")
		end

		for iter_6_41 = arg_3_0.heroResetbtnBeginNum, arg_3_0.heroResetbtnEndNum - 1 do
			arg_3_0.tabLayers[iter_6_41] = tolua.cast(var_6_2:getChildByTag(16), "CCNode")
		end

		arg_3_0:initTab(arg_3_0.tabButtons, arg_3_0.tabLayers, nil, function(arg_7_0)
			return arg_3_0:switchTabCheck(arg_7_0)
		end)
		arg_3_0:addChild(var_6_1)
		arg_3_0:createMoneyPanel(var_6_1, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.Gold,
			EMoneyPanelResType.Level
		}, function()
			arg_3_0:hide()
		end)
	end

	var_3_0()
	var_3_2()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onDataUpdateAck()
	end, zbGameEvent.Event_GmActivity_Ack)
end

function zbGmActivityWnd.refresh(arg_10_0, arg_10_1)
	g_WsMsgHandler:WS_ActivityGm_GetData_Req()

	if arg_10_1 ~= nil then
		arg_10_0:selectTab(arg_10_1)
		zbUtil:setTableViewOffset(arg_10_0.tableViewHelper, kCCScrollViewDirectionVertical, kCCTableViewFillTopDown, 7, table.maxn(arg_10_0.tabButtons), 70, arg_10_1)
	end
end

function zbGmActivityWnd.switchTabCheck(arg_11_0, arg_11_1)
	if arg_11_0.first[arg_11_1] ~= true then
		if arg_11_0.fundNum and arg_11_0.fundNum == arg_11_1 then
			arg_11_0.modules[arg_11_1] = createGmActivityWnd_Fund(arg_11_0.tabLayers[arg_11_1], arg_11_0.tabButtons[arg_11_1])
		elseif arg_11_0.fundWelfareNum and arg_11_0.fundWelfareNum == arg_11_1 then
			arg_11_0.modules[arg_11_1] = createGmActivityWnd_FundWelfare(arg_11_0.tabLayers[arg_11_1], arg_11_0.tabButtons[arg_11_1])
		elseif arg_11_0.noticeNum > 0 and arg_11_1 < arg_11_0.noticebtnEndNum and arg_11_1 >= arg_11_0.noticebtnBeginNum then
			arg_11_0.modules[arg_11_1] = createGmActivityWnd_Notice(arg_11_0.tabLayers[arg_11_1], arg_11_0.tabButtons[arg_11_1], arg_11_1, arg_11_0.noticebtnBeginNum)
		elseif arg_11_0.doubleNum > 0 and arg_11_1 < arg_11_0.doublebtnEndNum and arg_11_1 >= arg_11_0.doublebtnBeginNum then
			arg_11_0.modules[arg_11_1] = createGmActivityWnd_Double(arg_11_0.tabLayers[arg_11_1], arg_11_0.tabButtons[arg_11_1], arg_11_1, arg_11_0.doublebtnBeginNum)
		elseif arg_11_0.activeNum > 0 and arg_11_1 < arg_11_0.activebtnEndNum and arg_11_1 >= arg_11_0.activebtnBeginNum then
			arg_11_0.modules[arg_11_1] = createGmActivityWnd_Active(arg_11_0.tabLayers[arg_11_1], arg_11_0.tabButtons[arg_11_1], arg_11_1, arg_11_0.activebtnBeginNum)
		elseif arg_11_0.exchangeNum > 0 and arg_11_1 < arg_11_0.exchangebtnEndNum and arg_11_1 >= arg_11_0.exchangebtnBeginNum then
			arg_11_0.modules[arg_11_1] = createGmActivityWnd_Exchange(arg_11_0.tabLayers[arg_11_1], arg_11_0.tabButtons[arg_11_1], arg_11_1, arg_11_0.exchangebtnBeginNum)
		elseif arg_11_0.timeHeroNum > 0 and arg_11_1 < arg_11_0.timeHerobtnEndNum and arg_11_1 >= arg_11_0.timeHerobtnBeginNum then
			arg_11_0.modules[arg_11_1] = createGmActivityWnd_TimeHero(arg_11_0.tabLayers[arg_11_1], arg_11_0.tabButtons[arg_11_1], arg_11_1, arg_11_0.timeHerobtnBeginNum)
		elseif arg_11_0.timeShopNum > 0 and arg_11_1 < arg_11_0.timeShopbtnEndNum and arg_11_1 >= arg_11_0.timeShopbtnBeginNum then
			arg_11_0.modules[arg_11_1] = createGmActivityWnd_TimeShop(arg_11_0.tabLayers[arg_11_1], arg_11_0.tabButtons[arg_11_1], arg_11_1, arg_11_0.timeShopbtnBeginNum)
		elseif arg_11_0.rechargeDailyNum > 0 and arg_11_1 < arg_11_0.rechargeDailybtnEndNum and arg_11_1 >= arg_11_0.rechargeDailybtnBeginNum then
			arg_11_0.modules[arg_11_1] = createGmActivityWnd_RechargeDaily(arg_11_0.tabLayers[arg_11_1], arg_11_0.tabButtons[arg_11_1], arg_11_1, arg_11_0.rechargeDailybtnBeginNum)
		elseif arg_11_0.rechargeDailySumNum > 0 and arg_11_1 < arg_11_0.rechargeDailySumbtnEndNum and arg_11_1 >= arg_11_0.rechargeDailySumbtnBeginNum then
			arg_11_0.modules[arg_11_1] = createGmActivityWnd_RechargeDailySum(arg_11_0.tabLayers[arg_11_1], arg_11_0.tabButtons[arg_11_1], arg_11_1, arg_11_0.rechargeDailySumbtnBeginNum)
		elseif arg_11_0.rechargeDailySingleNum > 0 and arg_11_1 < arg_11_0.rechargeDailySinglebtnEndNum and arg_11_1 >= arg_11_0.rechargeDailySinglebtnBeginNum then
			arg_11_0.modules[arg_11_1] = createGmActivityWnd_RechargeDailySingle(arg_11_0.tabLayers[arg_11_1], arg_11_0.tabButtons[arg_11_1], arg_11_1, arg_11_0.rechargeDailySinglebtnBeginNum)
		elseif arg_11_0.rechargeSingleNum > 0 and arg_11_1 < arg_11_0.rechargeSinglebtnEndNum and arg_11_1 >= arg_11_0.rechargeSinglebtnBeginNum then
			arg_11_0.modules[arg_11_1] = createGmActivityWnd_RechargeSingle(arg_11_0.tabLayers[arg_11_1], arg_11_0.tabButtons[arg_11_1], arg_11_1, arg_11_0.rechargeSinglebtnBeginNum)
		elseif arg_11_0.rechargeSumNum > 0 and arg_11_1 < arg_11_0.rechargeSumbtnEndNum and arg_11_1 >= arg_11_0.rechargeSumbtnBeginNum then
			arg_11_0.modules[arg_11_1] = createGmActivityWnd_RechargeSum(arg_11_0.tabLayers[arg_11_1], arg_11_0.tabButtons[arg_11_1], arg_11_1, arg_11_0.rechargeSumbtnBeginNum)
		elseif arg_11_0.consumSumNum > 0 and arg_11_1 < arg_11_0.consumSumbtnEndNum and arg_11_1 >= arg_11_0.consumSumbtnBeginNum then
			arg_11_0.modules[arg_11_1] = createGmActivityWnd_ConsumSum(arg_11_0.tabLayers[arg_11_1], arg_11_0.tabButtons[arg_11_1], arg_11_1, arg_11_0.consumSumbtnBeginNum)
		elseif arg_11_0.consumDailySumNum > 0 and arg_11_1 < arg_11_0.consumDailySumbtnEndNum and arg_11_1 >= arg_11_0.consumDailySumbtnBeginNum then
			arg_11_0.modules[arg_11_1] = createGmActivityWnd_ConsumDailySum(arg_11_0.tabLayers[arg_11_1], arg_11_0.tabButtons[arg_11_1], arg_11_1, arg_11_0.consumDailySumbtnBeginNum)
		elseif arg_11_0.heroResetNum > 0 and arg_11_1 < arg_11_0.heroResetbtnEndNum and arg_11_1 >= arg_11_0.heroResetbtnBeginNum then
			arg_11_0.modules[arg_11_1] = createGmActivityWnd_HeroReset(arg_11_0.tabLayers[arg_11_1], arg_11_0.tabButtons[arg_11_1], arg_11_1, arg_11_0.heroResetbtnBeginNum)
		end

		arg_11_0.first[arg_11_1] = true
	end

	arg_11_0.modules[arg_11_1]:refresh()

	return true
end

function zbGmActivityWnd.onFrameUpdate(arg_12_0, arg_12_1)
	if arg_12_0.isShow == false then
		return
	end

	for iter_12_0 = arg_12_0.timeHerobtnBeginNum, arg_12_0.timeHerobtnEndNum - 1 do
		if arg_12_0.currTab == iter_12_0 then
			arg_12_0.modules[iter_12_0]:onFrameUpdate(arg_12_1)
		end
	end

	if g_GameStateMachine:isOneSecondPassed() == false then
		return
	end

	if arg_12_0.notifyFund then
		arg_12_0.notifyFund:setVisible(g_Self.kGmActivityHandler:hasFundGift())
	end

	if arg_12_0.notifyFundWelfare then
		arg_12_0.notifyFundWelfare:setVisible(g_Self.kGmActivityHandler:hasFundWelfareGift())
	end

	for iter_12_1 = arg_12_0.activebtnBeginNum, arg_12_0.activebtnEndNum - 1 do
		arg_12_0.notifyButton[iter_12_1]:setVisible(g_Self.kGmActivityHandler:hasActivieGift(iter_12_1 - arg_12_0.activebtnBeginNum + 1))
	end

	for iter_12_2 = arg_12_0.exchangebtnBeginNum, arg_12_0.exchangebtnEndNum - 1 do
		arg_12_0.notifyButton[iter_12_2]:setVisible(g_Self.kGmActivityHandler:hasExchangeGift(iter_12_2 - arg_12_0.exchangebtnBeginNum + 1))
	end

	for iter_12_3 = arg_12_0.timeHerobtnBeginNum, arg_12_0.timeHerobtnEndNum - 1 do
		arg_12_0.notifyButton[iter_12_3]:setVisible(g_Self.kGmActivityHandler:hasTimeHeroGift(iter_12_3 - arg_12_0.timeHerobtnBeginNum + 1))
	end

	for iter_12_4 = arg_12_0.rechargeDailybtnBeginNum, arg_12_0.rechargeDailybtnEndNum - 1 do
		arg_12_0.notifyButton[iter_12_4]:setVisible(g_Self.kGmActivityHandler:hasRechargeDailyGift(iter_12_4 - arg_12_0.rechargeDailybtnBeginNum + 1))
	end

	for iter_12_5 = arg_12_0.rechargeDailySumbtnBeginNum, arg_12_0.rechargeDailySumbtnEndNum - 1 do
		arg_12_0.notifyButton[iter_12_5]:setVisible(g_Self.kGmActivityHandler:hasRechargeDailySumGift(iter_12_5 - arg_12_0.rechargeDailySumbtnBeginNum + 1))
	end

	for iter_12_6 = arg_12_0.rechargeDailySinglebtnBeginNum, arg_12_0.rechargeDailySinglebtnEndNum - 1 do
		arg_12_0.notifyButton[iter_12_6]:setVisible(g_Self.kGmActivityHandler:hasRechargeDailySingleGift(iter_12_6 - arg_12_0.rechargeDailySinglebtnBeginNum + 1))
	end

	for iter_12_7 = arg_12_0.rechargeSinglebtnBeginNum, arg_12_0.rechargeSinglebtnEndNum - 1 do
		arg_12_0.notifyButton[iter_12_7]:setVisible(g_Self.kGmActivityHandler:hasRechargeSingleGift(iter_12_7 - arg_12_0.rechargeSinglebtnBeginNum + 1))
	end

	for iter_12_8 = arg_12_0.rechargeSumbtnBeginNum, arg_12_0.rechargeSumbtnEndNum - 1 do
		arg_12_0.notifyButton[iter_12_8]:setVisible(g_Self.kGmActivityHandler:hasRechargeSumGift(iter_12_8 - arg_12_0.rechargeSumbtnBeginNum + 1))
	end

	for iter_12_9 = arg_12_0.consumSumbtnBeginNum, arg_12_0.consumSumbtnEndNum - 1 do
		arg_12_0.notifyButton[iter_12_9]:setVisible(g_Self.kGmActivityHandler:hasConsumSumGift(iter_12_9 - arg_12_0.consumSumbtnBeginNum + 1))
	end

	for iter_12_10 = arg_12_0.consumDailySumbtnBeginNum, arg_12_0.consumDailySumbtnEndNum - 1 do
		arg_12_0.notifyButton[iter_12_10]:setVisible(g_Self.kGmActivityHandler:hasConsumDailySumGift(iter_12_10 - arg_12_0.consumDailySumbtnBeginNum + 1))
	end
end

function zbGmActivityWnd.onDataUpdateAck(arg_13_0)
	if arg_13_0.isShow and arg_13_0.modules[arg_13_0.currTab] then
		arg_13_0.modules[arg_13_0.currTab]:refresh()
	end
end

local var_0_0 = "image/common/btnsharp250_80_blue.png"
local var_0_1 = "image/common/btnsharp250_80_gold.png"

function zbGmActivityWnd.doSelectTab(arg_14_0)
	for iter_14_0 = 1, arg_14_0.buttonNum - 1 do
		if arg_14_0.currTab == iter_14_0 then
			ui:setButtonStroke2(arg_14_0.tabButtons[iter_14_0], FONT_COLOR_WHITE, 26, BTN_YELLOW_STOKE_COLOR)
			ui:setButtonPic(arg_14_0.tabButtons[iter_14_0], var_0_1, var_0_1, var_0_1)
		else
			ui:setButtonStroke2(arg_14_0.tabButtons[iter_14_0], FONT_COLOR_WHITE, 24, BTN_YELLOW_STOKE_COLOR)
			ui:setButtonPic(arg_14_0.tabButtons[iter_14_0], var_0_0, var_0_0, var_0_0)
		end

		local var_14_0 = arg_14_0.modules[iter_14_0]

		if var_14_0 and var_14_0.node then
			if arg_14_0.currTab ~= iter_14_0 then
				var_14_0.node:setVisible(false)
			else
				var_14_0.node:setVisible(true)
			end
		end
	end
end
