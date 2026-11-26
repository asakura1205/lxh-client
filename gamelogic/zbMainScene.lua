require("gamecore.zbAnimation")
require("gamecore.zbUIAnimation")

zbMainScene = class("zbMainScene", function()
	return display.newScene("zbMainScene")
end)
zbMainScene.__index = zbMainScene

require("gamelogic.zbMainScene_fun")

function zbMainScene.create(arg_2_0)
	local var_2_0 = zbMainScene.new()

	var_2_0:init()

	return var_2_0
end

function zbMainScene.init(arg_3_0)
	arg_3_0:addUpDownBorder()
	arg_3_0:retain()

	arg_3_0.lastGuideWndVisible = false
	arg_3_0.lastOnlyMainVisible = false
	arg_3_0.waitShowNewFunList = {}

	arg_3_0:readLocalWaitFunShowList()

	g_MainScene = arg_3_0
end

function zbMainScene.free(arg_4_0)
	local function var_4_0(arg_5_0, arg_5_1)
		for iter_5_0, iter_5_1 in pairs(arg_5_0) do
			table.insert(arg_5_1, iter_5_1)
		end
	end

	local var_4_1 = {}

	var_4_0(g_MainWinTable, var_4_1)

	g_MainWinTable = {}
	g_VisWinTable = {}

	for iter_4_0, iter_4_1 in pairs(var_4_1) do
		zbUtil:freeWnd(iter_4_1)
	end

	zbUtil:freeWnd(arg_4_0.wndLoading)
	arg_4_0:removeAllChildrenWithCleanup(true)
	arg_4_0:release()
end

function zbMainScene.freeWnd(arg_6_0)
	if arg_6_0.wndSubject then
		zbUtil:freeWnd(arg_6_0.wndSubject)

		arg_6_0.wndSubject = nil
	end

	if arg_6_0.wndShowHeroStarUp then
		zbUtil:freeWnd(arg_6_0.wndShowHeroStarUp)

		arg_6_0.wndShowHeroStarUp = nil
	end

	if arg_6_0.wndShowLevelUp then
		zbUtil:freeWnd(arg_6_0.wndShowLevelUp)

		arg_6_0.wndShowLevelUp = nil
	end

	if arg_6_0.wndShowNewBoss then
		zbUtil:freeWnd(arg_6_0.wndShowNewBoss)

		arg_6_0.wndShowNewBoss = nil
	end

	if arg_6_0.wndShowNewGod then
		zbUtil:freeWnd(arg_6_0.wndShowNewGod)

		arg_6_0.wndShowNewGod = nil
	end

	if arg_6_0.wndShowVipLevelUp then
		zbUtil:freeWnd(arg_6_0.wndShowVipLevelUp)

		arg_6_0.wndShowVipLevelUp = nil
	end

	if arg_6_0.wndDecomposeList then
		zbUtil:freeWnd(arg_6_0.wndDecomposeList)

		arg_6_0.wndDecomposeList = nil
	end

	if arg_6_0.wndLegionDonate then
		zbUtil:freeWnd(arg_6_0.wndLegionDonate)

		arg_6_0.wndLegionDonate = nil
	end

	if arg_6_0.wndHeroHandbook then
		zbUtil:freeWnd(arg_6_0.wndHeroHandbook)

		arg_6_0.wndHeroHandbook = nil
	end

	if arg_6_0.wndVip then
		zbUtil:freeWnd(arg_6_0.wndVip)

		arg_6_0.wndVip = nil
	end

	if g_Self:getLevel() > 5 and arg_6_0.wndPub then
		zbUtil:freeWnd(arg_6_0.wndPub)

		arg_6_0.wndPub = nil
	end

	if arg_6_0.wndHeroShow then
		zbUtil:freeWnd(arg_6_0.wndHeroShow)

		arg_6_0.wndHeroShow = nil
	end

	if arg_6_0.wndTech then
		zbUtil:freeWnd(arg_6_0.wndTech)

		arg_6_0.wndTech = nil
	end

	if arg_6_0.wndFirstRecharge then
		zbUtil:freeWnd(arg_6_0.wndFirstRecharge)

		arg_6_0.wndFirstRecharge = nil
	end

	if arg_6_0.wndRebateAward then
		zbUtil:freeWnd(arg_6_0.wndRebateAward)

		arg_6_0.wndRebateAward = nil
	end

	if arg_6_0.wndVipRecharge then
		zbUtil:freeWnd(arg_6_0.wndVipRecharge)

		arg_6_0.wndVipRecharge = nil
	end

	if arg_6_0.wndGemsDecompose then
		zbUtil:freeWnd(arg_6_0.wndGemsDecompose)

		arg_6_0.wndGemsDecompose = nil
	end

	if arg_6_0.wndHeroDecompose then
		zbUtil:freeWnd(arg_6_0.wndHeroDecompose)

		arg_6_0.wndHeroDecompose = nil
	end

	if arg_6_0.wndHeroReset then
		zbUtil:freeWnd(arg_6_0.wndHeroReset)

		arg_6_0.wndHeroReset = nil
	end

	if arg_6_0.wndEquipDecompose then
		zbUtil:freeWnd(arg_6_0.wndEquipDecompose)

		arg_6_0.wndEquipDecompose = nil
	end

	if arg_6_0.wndGod then
		zbUtil:freeWnd(arg_6_0.wndGod)

		arg_6_0.wndGod = nil
	end

	if arg_6_0.wndWorldGame then
		zbUtil:freeWnd(arg_6_0.wndWorldGame)

		arg_6_0.wndWorldGame = nil
	end

	if arg_6_0.wndWorldBox then
		zbUtil:freeWnd(arg_6_0.wndWorldBox)

		arg_6_0.wndWorldBox = nil
	end

	if arg_6_0.wndHeroSoulView then
		zbUtil:freeWnd(arg_6_0.wndHeroSoulView)

		arg_6_0.wndHeroSoulView = nil
	end

	if arg_6_0.wndHeroSoulList then
		zbUtil:freeWnd(arg_6_0.wndHeroSoulList)

		arg_6_0.wndHeroSoulList = nil
	end

	if arg_6_0.wndHeroSoulDetail then
		zbUtil:freeWnd(arg_6_0.wndHeroSoulDetail)

		arg_6_0.wndHeroSoulDetail = nil
	end

	if arg_6_0.wndHeroSoulRank then
		zbUtil:freeWnd(arg_6_0.wndHeroSoulRank)

		arg_6_0.wndHeroSoulRank = nil
	end
end

function zbMainScene.showLoadingWnd(arg_7_0)
	require("gamelogic.zbLoadingWnd")

	if arg_7_0.wndLoading == nil then
		arg_7_0.wndLoading = createLoadingWnd()

		arg_7_0.wndLoading:retain()
	end

	arg_7_0.wndLoading:setModel(true)
	arg_7_0.wndLoading:show(arg_7_0)
	arg_7_0.wndLoading:beginLoad()
end

function zbMainScene.showWaitMomentWnd(arg_8_0)
	require("gamelogic.zbWaitMomentWnd")

	if arg_8_0.wndWaitmoment == nil then
		arg_8_0.wndWaitmoment = createWaitMomentWnd()

		arg_8_0.wndWaitmoment:retain()
	end

	arg_8_0.wndWaitmoment:setModel(true)
	arg_8_0.wndWaitmoment:show(arg_8_0)
end

function zbMainScene.showMain(arg_9_0)
	if arg_9_0.wndMain == nil then
		require("gamelogic.zbMainWnd")

		arg_9_0.wndMain = zbMainWnd:create()

		arg_9_0.wndMain:retain()
	end

	arg_9_0.wndMain:show(arg_9_0)
end

function zbMainScene.showChat(arg_10_0)
	if arg_10_0.wndChat == nil then
		require("gamelogic.zbChatWnd")

		arg_10_0.wndChat = createChatWnd()

		arg_10_0.wndChat:retain()
	end

	arg_10_0.wndChat:setModel(true)
	arg_10_0.wndChat:show(arg_10_0)

	return arg_10_0.wndChat
end

function zbMainScene.showChatTip(arg_11_0, arg_11_1)
	if arg_11_0.wndChatTip == nil then
		require("gamelogic.zbChatTipWnd")

		arg_11_0.wndChatTip = createChatTipWnd()

		arg_11_0.wndChatTip:retain()
	end

	arg_11_0.wndChatTip:setModel(true)
	arg_11_0.wndChatTip:show(arg_11_0)
	arg_11_0.wndChatTip:refresh(arg_11_1)

	return arg_11_0.wndChatTip
end

function zbMainScene.popupEventComplete(arg_12_0, arg_12_1)
	if arg_12_0.wndTipEventComplete == nil then
		require("gamelogic.zbTipEventCompleteWnd")

		arg_12_0.wndTipEventComplete = createTipEventCompleteWnd()

		arg_12_0.wndTipEventComplete:retain()
	end

	arg_12_0.wndTipEventComplete:popup(arg_12_1)
end

function zbMainScene.showChatpalyerTouchPopTip(arg_13_0)
	if arg_13_0.wndTipchattouchPop == nil then
		require("gamelogic.zbTipChatPlayerTouchPopWnd")

		arg_13_0.wndTipchattouchPop = zbTipChatPlayerTouchPopWnd:create()

		arg_13_0.wndTipchattouchPop:retain()
	end

	arg_13_0.wndTipchattouchPop:setModel(true)
	arg_13_0.wndTipchattouchPop:show(arg_13_0)
end

function zbMainScene.showStuffConvertWnd(arg_14_0)
	if arg_14_0.wndStuffConvert == nil then
		require("gamelogic.zbStuffConvertWnd")

		arg_14_0.wndStuffConvert = zbStuffConvertWnd:create()

		arg_14_0.wndStuffConvert:retain()
	end

	arg_14_0.wndStuffConvert:setModel(true)
	arg_14_0.wndStuffConvert:show(arg_14_0)
	arg_14_0.wndStuffConvert:refresh()
end

function zbMainScene.update(arg_15_0, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndWorld, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndMain, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndFarm, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndMail, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndFriend, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndCombat, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndBalanceWin, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndLevelSweep, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndSetting, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndLoading, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndReconnect, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndAccount, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndTask, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndDecomposeCountSelect, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndDecomposeHeroCountSelect, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndShop, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndShopWorld, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndGodLevelUp, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndHornBuy, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndPub, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndItemCountSelect, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndGod, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndFightPowerUp, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndArenaRankUp, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndRankList, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndLegionNo, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndLegionLuckyCat, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndWorld, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndHeroListTempWnd, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndHeroListWnd, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndHeroDetail, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndEquipListWnd, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndEquipDetail, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndWorldResInfo, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndWorldRes, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndWorldTask, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndArena, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndBag, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndEquipDecompose, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndGemsDecompose, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndHeroDecompose, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndTech, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndHeroTrial, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndActivity, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndSeven, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndGmActivity, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndWarPath, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndGuideLxhVideo, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndGuideWorldVideo, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndGuideYeyejia, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndGuide, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndLegionScene, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndLegionRed, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndChat, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndHeroHandbook, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndVip, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndLegionLog, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndTreasure, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndLegionWar, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndWawaji, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndLegionWarPosition, arg_15_1)
	arg_15_0:updateWnd(arg_15_0.wndWaitmoment, arg_15_1)

	local var_15_0 = g_Self.kRedPointHandler:hasRedPoint(ERedPointType.Chat)

	if arg_15_0.wndMain ~= nil then
		arg_15_0.wndMain.btnChat.notifyChat:setVisible(var_15_0)
	end

	for iter_15_0, iter_15_1 in pairs(g_VisWinTable) do
		if iter_15_1.btnChat then
			iter_15_1.btnChat.notifyChat:setVisible(var_15_0)
		end
	end

	arg_15_0:checkWndVisible()
	arg_15_0:checkGuideVisible()
	arg_15_0:checkNewFunction()
	zbChannelUtil_Login:checkSdkLoginStateChange()
end

function zbMainScene.checkGuideVisible(arg_16_0)
	local var_16_0 = arg_16_0:isWndVisible(arg_16_0.wndGuide)

	if arg_16_0.lastGuideWndVisible == true and var_16_0 == false then
		g_Guide:notifyGuideWndHide()
	end

	arg_16_0.lastGuideWndVisible = var_16_0
end

function zbMainScene.updateWnd(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 ~= nil and arg_17_1:isVisible() and arg_17_1.isShow then
		arg_17_1:onFrameUpdate(arg_17_2)
	end
end

function zbMainScene.isWndVisible(arg_18_0, arg_18_1)
	return arg_18_1 ~= nil and arg_18_1:isVisible() and arg_18_1.isShow and arg_18_1:isFading() == false
end

function zbMainScene.setWndVisible(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_1 ~= nil then
		arg_19_1:setVisible(arg_19_2)
	end
end

function zbMainScene.checkWndVisible(arg_20_0)
	local var_20_0 = not (arg_20_0:isWndVisible(arg_20_0.wndBag) or arg_20_0:isWndVisible(arg_20_0.wndHeroListWnd) or arg_20_0:isWndVisible(arg_20_0.wndEquipListWnd) or arg_20_0:isWndVisible(arg_20_0.wndHeroDetail) or arg_20_0:isWndVisible(arg_20_0.wndEquipDetail) or arg_20_0:isWndVisible(arg_20_0.wndTech) or arg_20_0:isWndVisible(arg_20_0.wndTask) or arg_20_0:isWndVisible(arg_20_0.wndShop) or arg_20_0:isWndVisible(arg_20_0.wndVipRecharge) or arg_20_0:isWndVisible(arg_20_0.wndHeroShow) or arg_20_0:isWndVisible(arg_20_0.wndRankList) or arg_20_0:isWndVisible(arg_20_0.wndRole) or arg_20_0:isWndVisible(arg_20_0.wndWarPath) or arg_20_0:isWndVisible(arg_20_0.wndWarForce) or arg_20_0:isWndVisible(arg_20_0.wndCombat) or arg_20_0:isWndVisible(arg_20_0.wndFormation) or arg_20_0:isWndVisible(arg_20_0.wndEmbattle) or arg_20_0:isWndVisible(arg_20_0.wndGemsDecompose) or arg_20_0:isWndVisible(arg_20_0.wndHeroDecompose) or arg_20_0:isWndVisible(arg_20_0.wndEquipDecompose) or arg_20_0:isWndVisible(arg_20_0.wndHeroReset) or arg_20_0:isWndVisible(arg_20_0.wndGod) or arg_20_0:isWndVisible(arg_20_0.wndArena) or arg_20_0:isWndVisible(arg_20_0.wndPata) or arg_20_0:isWndVisible(arg_20_0.wndHeroTrial) or arg_20_0:isWndVisible(arg_20_0.wndHeroTrialDetail) or arg_20_0:isWndVisible(arg_20_0.wndLegionScene) or arg_20_0:isWndVisible(arg_20_0.wndLegionDonate) or arg_20_0:isWndVisible(arg_20_0.wndLegionRed) or arg_20_0:isWndVisible(arg_20_0.wndWorld) or arg_20_0:isWndVisible(arg_20_0.wndYuanZheng) or arg_20_0:isWndVisible(arg_20_0.wndActivity) or arg_20_0:isWndVisible(arg_20_0.wndSeven) or arg_20_0:isWndVisible(arg_20_0.wndGmActivity) or arg_20_0:isWndVisible(arg_20_0.wndReconnect) or arg_20_0:isWndVisible(arg_20_0.wndGuideYeyejia) or arg_20_0:isWndVisible(arg_20_0.wndGuideLxhVideo) or arg_20_0:isWndVisible(arg_20_0.wndGuideWorldVideo) or arg_20_0:isWndVisible(arg_20_0.wndHeroHandbook) or arg_20_0:isWndVisible(arg_20_0.wndVip) or arg_20_0:isWndVisible(arg_20_0.wndTreasure) or arg_20_0:isWndVisible(arg_20_0.wndHeroSoulHall) or arg_20_0:isWndVisible(arg_20_0.wndHeroSoulView) or arg_20_0:isWndVisible(arg_20_0.wndWorldBoss) or arg_20_0:isWndVisible(arg_20_0.wndGuideTitle) or arg_20_0:isWndVisible(arg_20_0.wndWawaji) or arg_20_0:isWndVisible(arg_20_0.wndLegionWar))

	arg_20_0:setWndVisible(arg_20_0.wndMain, var_20_0)
end

function zbMainScene.isCanSeeMain(arg_21_0)
	if arg_21_0.wndMain == nil then
		return false
	end

	return arg_21_0.wndMain.isShow and arg_21_0.wndMain:isVisible()
end

function zbMainScene.notifyWndShow(arg_22_0, arg_22_1)
	arg_22_0:checkDarkLight(arg_22_1)
end

function zbMainScene.notifyWndHide(arg_23_0, arg_23_1)
	arg_23_0:checkDarkLight(arg_23_1)
end

local function var_0_0()
	for iter_24_0, iter_24_1 in pairs(g_VisWinTable) do
		if iter_24_1:getWinType() == EWinType.Pop_HideAll then
			return true
		end
	end

	return false
end

local function var_0_1()
	for iter_25_0, iter_25_1 in pairs(g_VisWinTable) do
		if iter_25_1:getWinType() == EWinType.Pop_OnlyDark then
			return true
		end
	end

	return false
end

local function var_0_2()
	for iter_26_0, iter_26_1 in pairs(g_VisWinTable) do
		if iter_26_1:getWinType() == EWinType.Pop_Has_MoneyPanel_HeadPanel then
			return true
		end
	end

	return false
end

local function var_0_3()
	for iter_27_0, iter_27_1 in pairs(g_VisWinTable) do
		if iter_27_1:getWinType() == EWinType.Pop_Has_MoneyPanel or iter_27_1:getWinType() == EWinType.Pop_Has_MoneyPanel_HeadPanel then
			return true
		end
	end

	return false
end

function zbMainScene.checkDarkLight(arg_28_0, arg_28_1)
	local var_28_0 = var_0_0()
	local var_28_1 = var_0_1()
	local var_28_2 = var_0_2()
	local var_28_3 = var_0_3()

	if g_MainScene.wndMain ~= nil then
		if var_28_0 then
			g_MainScene.wndMain:onHideAll()
		elseif var_28_1 then
			g_MainScene.wndMain:onOnlyDark()
		elseif var_28_2 or var_28_3 then
			g_MainScene.wndMain:onDark(var_28_2, var_28_3)
		else
			g_MainScene.wndMain:onLight()
		end
	end
end

function zbMainScene.hasSecondWndVisible(arg_29_0)
	return hasSecondWndVis()
end

function zbMainScene.isOnlyMainVisible(arg_30_0)
	return arg_30_0:isMainVisible() and arg_30_0:hasSecondWndVisible() == false
end

function zbMainScene.isMainVisible(arg_31_0)
	if arg_31_0.wndMain ~= nil then
		return arg_31_0.wndMain.isShow and arg_31_0.wndMain:isVisible()
	end

	return false
end

function zbMainScene.showChatURLWnd(arg_32_0)
	if arg_32_0.wndChatURL == nil then
		require("gamelogic.zbChatURLWnd")

		arg_32_0.wndChatURL = createChatURLWnd()

		arg_32_0.wndChatURL:retain()
	end

	arg_32_0.wndChatURL:setModel(true)
	arg_32_0.wndChatURL:show(arg_32_0)
	arg_32_0.wndChatURL:refresh()
end

function zbMainScene.createLoadActivityWnd(arg_33_0)
	if arg_33_0.wndActivity == nil then
		require("gamelogic.zbActivityWnd")

		arg_33_0.wndActivity = createActivityWnd()

		arg_33_0.wndActivity:retain()
	end
end

function zbMainScene.showActivityWnd(arg_34_0, arg_34_1)
	arg_34_0:createLoadActivityWnd()
	arg_34_0.wndActivity:setModel(true)
	arg_34_0.wndActivity:show(arg_34_0, true)
	arg_34_0.wndActivity:refresh(arg_34_1)
end

function zbMainScene.showSevenWnd(arg_35_0)
	if arg_35_0.wndSeven == nil then
		require("gamelogic.zbSevenWnd")

		arg_35_0.wndSeven = createSevenWnd()

		arg_35_0.wndSeven:retain()
	end

	arg_35_0.wndSeven:setModel(true)
	arg_35_0.wndSeven:show(arg_35_0, true)
	arg_35_0.wndSeven:refresh()
end

function zbMainScene.showGmActivityWnd(arg_36_0, arg_36_1)
	local var_36_0, var_36_1, var_36_2, var_36_3, var_36_4, var_36_5, var_36_6, var_36_7 = g_Self.kGmActivityHandler:getActivityGmCount()

	if arg_36_0.wndGmActivity and table.getn(arg_36_0.wndGmActivity.tabButtons) ~= var_36_0 then
		zbUtil:freeWnd(arg_36_0.wndGmActivity)

		arg_36_0.wndGmActivity = nil
	end

	if arg_36_0.wndGmActivity == nil then
		require("gamelogic.zbGmActivityWnd")

		arg_36_0.wndGmActivity = createGmActivityWnd()

		arg_36_0.wndGmActivity:retain()
	end

	arg_36_0.wndGmActivity:setModel(true)
	arg_36_0.wndGmActivity:show(arg_36_0)
	arg_36_0.wndGmActivity:refresh(arg_36_1)
end

function zbMainScene.showFormationWnd(arg_37_0)
	if arg_37_0.wndFormation == nil then
		require("gamelogic.zbFormationWnd")

		arg_37_0.wndFormation = createFormationWnd()

		arg_37_0.wndFormation:retain()
	end

	arg_37_0.wndFormation:setModel(true)
	arg_37_0.wndFormation:show(arg_37_0)
	arg_37_0.wndFormation:refresh()

	return arg_37_0.wndFormation
end

function zbMainScene.showFormationTip(arg_38_0, arg_38_1)
	if arg_38_0.wndFormationTip == nil then
		require("gamelogic.zbFormationTipWnd")

		arg_38_0.wndFormationTip = createFormationTipWnd()

		arg_38_0.wndFormationTip:retain()
	end

	arg_38_0.wndFormationTip:show(arg_38_0)
	arg_38_0.wndFormationTip:refresh(arg_38_1)
end

function zbMainScene.hideFormationTip(arg_39_0)
	if arg_39_0.wndFormationTip ~= nil and arg_39_0.wndFormationTip.isShow then
		arg_39_0.wndFormationTip:hide()
	end
end

function zbMainScene.showHeroSelectWnd(arg_40_0)
	if arg_40_0.wndHeroSelect == nil then
		require("gamelogic.zbHeroSelectWnd")

		arg_40_0.wndHeroSelect = createHeroSelectWnd()

		arg_40_0.wndHeroSelect:retain()
	end

	arg_40_0.wndHeroSelect:setModel(true)
	arg_40_0.wndHeroSelect:show(arg_40_0)

	return arg_40_0.wndHeroSelect
end

function zbMainScene.createHeroListWnd(arg_41_0)
	if arg_41_0.wndHeroListWnd == nil then
		require("gamelogic.zbHeroListWnd")

		arg_41_0.wndHeroListWnd = createHeroListWnd()

		arg_41_0.wndHeroListWnd:retain()
	end
end

function zbMainScene.showHeroListWnd(arg_42_0)
	arg_42_0:createHeroListWnd()
	arg_42_0.wndHeroListWnd:setModel(true)
	arg_42_0.wndHeroListWnd:refresh()
	arg_42_0.wndHeroListWnd:show(arg_42_0, true)
end

function zbMainScene.showHeroDetailWnd(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	if arg_43_0.wndHeroDetail == nil then
		require("gamelogic.zbHeroDetailWnd")

		arg_43_0.wndHeroDetail = createHeroDetailWnd(arg_43_1)

		arg_43_0.wndHeroDetail:retain()
	end

	arg_43_0.wndHeroDetail:setModel(true)
	arg_43_0.wndHeroDetail:show(arg_43_0, true)
	arg_43_0.wndHeroDetail:refresh(arg_43_1, arg_43_2, arg_43_3)

	return arg_43_0.wndHeroDetail
end

function zbMainScene.showHeroDetailAddExpWnd(arg_44_0, arg_44_1)
	if arg_44_0.wndHeroDetailAddExp == nil then
		require("gamelogic.zbHeroDetailWnd_AddExp")

		arg_44_0.wndHeroDetailAddExp = createHeroDetailAddExpWnd()

		arg_44_0.wndHeroDetailAddExp:retain()
	end

	arg_44_0.wndHeroDetailAddExp:setModel(true)
	arg_44_0.wndHeroDetailAddExp:show(arg_44_0)
	arg_44_0.wndHeroDetailAddExp:refresh(arg_44_1)
end

function zbMainScene.showHeroExtraAttrWnd(arg_45_0, arg_45_1)
	if arg_45_0.wndHeroExtraAttr == nil then
		require("gamelogic.zbHeroExtraAttrWnd")

		arg_45_0.wndHeroExtraAttr = createHeroExtraAttrWnd()

		arg_45_0.wndHeroExtraAttr:retain()
	end

	arg_45_0.wndHeroExtraAttr:setModel(true)
	arg_45_0.wndHeroExtraAttr:show(arg_45_0)
	arg_45_0.wndHeroExtraAttr:refresh(arg_45_1)
end

function zbMainScene.showFightPowerUpWnd(arg_46_0)
	if arg_46_0.wndFightPowerUp == nil then
		require("gamelogic.zbFightPowerUpWnd")

		arg_46_0.wndFightPowerUp = createFightPowerUpWnd()

		arg_46_0.wndFightPowerUp:retain()
	end

	arg_46_0.wndFightPowerUp:show(arg_46_0)
	arg_46_0.wndFightPowerUp:refresh()
end

function zbMainScene.showFragComposeWnd(arg_47_0, arg_47_1, arg_47_2)
	if arg_47_0.wndFragCompose == nil then
		require("gamelogic.zbFragComposeWnd")

		arg_47_0.wndFragCompose = createFragComposeWnd()

		arg_47_0.wndFragCompose:retain()
	end

	arg_47_0.wndFragCompose:setModel(true)
	arg_47_0.wndFragCompose:show(arg_47_0)
	arg_47_0.wndFragCompose:refresh(arg_47_1, arg_47_2)

	return arg_47_0.wndFragCompose
end

function zbMainScene.showEquipSelectWnd(arg_48_0, arg_48_1, arg_48_2)
	if arg_48_0.wndEquipSelect == nil then
		require("gamelogic.zbEquipSelectWnd")

		arg_48_0.wndEquipSelect = createEquipSelectWnd(heroDetail)

		arg_48_0.wndEquipSelect:retain()
	end

	arg_48_0.wndEquipSelect:setModel(true)
	arg_48_0.wndEquipSelect:show(arg_48_0)
	arg_48_0.wndEquipSelect:refresh(arg_48_1, arg_48_2)

	return arg_48_0.wndEquipSelect
end

function zbMainScene.showEquipFateListWnd(arg_49_0, arg_49_1, arg_49_2)
	if arg_49_0.wndEquipFateList == nil then
		require("gamelogic.zbHeroDetailWnd_EquipFate")

		arg_49_0.wndEquipFateList = createEquipFateListWnd(heroDetail)

		arg_49_0.wndEquipFateList:retain()
	end

	arg_49_0.wndEquipFateList:setModel(true)
	arg_49_0.wndEquipFateList:show(arg_49_0)
	arg_49_0.wndEquipFateList:refresh(arg_49_1, arg_49_2)

	return arg_49_0.wndEquipFateList
end

function zbMainScene.createEquipListWnd(arg_50_0)
	if arg_50_0.wndEquipListWnd == nil then
		require("gamelogic.zbEquipListWnd")

		arg_50_0.wndEquipListWnd = createEquipListWnd()

		arg_50_0.wndEquipListWnd:retain()
	end
end

function zbMainScene.showEquipListWnd(arg_51_0)
	arg_51_0:createEquipListWnd()
	arg_51_0.wndEquipListWnd:setModel(true)
	arg_51_0.wndEquipListWnd:show(arg_51_0, true)
end

function zbMainScene.showEquipDetailWnd(arg_52_0, arg_52_1, arg_52_2)
	if arg_52_0.wndEquipDetail == nil then
		require("gamelogic.zbEquipDetailWnd")

		arg_52_0.wndEquipDetail = createEquipDetailWnd()

		arg_52_0.wndEquipDetail:retain()
	end

	arg_52_0.wndEquipDetail:setModel(true)
	arg_52_0.wndEquipDetail:show(arg_52_0, true)
	arg_52_0.wndEquipDetail:refresh(arg_52_1, arg_52_2)

	return arg_52_0.wndEquipDetail
end

function zbMainScene.showEquipGemTip(arg_53_0, arg_53_1, arg_53_2, arg_53_3, arg_53_4)
	if arg_53_0.wndEquipGemTip == nil then
		require("gamelogic.zbEquipDetail_GemTip")

		arg_53_0.wndEquipGemTip = createEquipGemTipWnd()

		arg_53_0.wndEquipGemTip:retain()
	end

	arg_53_0.wndEquipGemTip:setModel(true)
	arg_53_0.wndEquipGemTip:show(arg_53_0)
	arg_53_0.wndEquipGemTip:refresh(arg_53_1, arg_53_2, arg_53_3, arg_53_4)

	return arg_53_0.wndEquipGemTip
end

function zbMainScene.showGemsSelect(arg_54_0, arg_54_1, arg_54_2, arg_54_3, arg_54_4)
	if arg_54_0.wndGemsSelect == nil then
		require("gamelogic.zbEquipDetail_GemsSelectWnd")

		arg_54_0.wndGemsSelect = createGemsSelectWnd()

		arg_54_0.wndGemsSelect:retain()
	end

	arg_54_0.wndGemsSelect:setModel(true)
	arg_54_0.wndGemsSelect:show(arg_54_0)
	arg_54_0.wndGemsSelect:refresh(arg_54_1, arg_54_2, arg_54_3, arg_54_4)

	return arg_54_0.wndGemsSelect
end

function zbMainScene.showEquipCuilianSelect(arg_55_0, arg_55_1, arg_55_2)
	if arg_55_0.wndEquipCuilianSelect == nil then
		require("gamelogic.zbEquipDetail_CuilianSelectWnd")

		arg_55_0.wndEquipCuilianSelect = createEquipCuilianSelectWnd()

		arg_55_0.wndEquipCuilianSelect:retain()
	end

	arg_55_0.wndEquipCuilianSelect:setModel(true)
	arg_55_0.wndEquipCuilianSelect:show(arg_55_0)
	arg_55_0.wndEquipCuilianSelect:setSelectdList(arg_55_1, arg_55_2)
end

function zbMainScene.showAttrExplainWnd(arg_56_0)
	if arg_56_0.wndAttrExplain == nil then
		require("gamelogic.zbAttrExplainWnd")

		arg_56_0.wndAttrExplain = zbAttrExplainWnd:create()

		arg_56_0.wndAttrExplain:retain()
	end

	arg_56_0.wndAttrExplain:setModel(true)
	arg_56_0.wndAttrExplain:show(arg_56_0)
end

function zbMainScene.showXilianYesWnd(arg_57_0, arg_57_1, arg_57_2, arg_57_3, arg_57_4)
	if arg_57_0.wndXilianYes == nil then
		require("gamelogic.zbEquipDetail_XilianYesWnd")

		arg_57_0.wndXilianYes = createEquipXilianYesWnd()

		arg_57_0.wndXilianYes:retain()
	end

	arg_57_0.wndXilianYes:setModel(true)
	arg_57_0.wndXilianYes:show(arg_57_0)
	arg_57_0.wndXilianYes:refresh(arg_57_1, arg_57_2, arg_57_3, arg_57_4)
end

function zbMainScene.showMainExpTipWnd(arg_58_0)
	if arg_58_0.wndMainExpTip == nil then
		require("gamelogic.zbMainExpTipWnd")

		arg_58_0.wndMainExpTip = createMainExpTipWnd()

		arg_58_0.wndMainExpTip:retain()
	end

	arg_58_0.wndMainExpTip:setModel(true)
	arg_58_0.wndMainExpTip:show(arg_58_0)
	arg_58_0.wndMainExpTip:refresh()
end

function zbMainScene.showBagWnd(arg_59_0)
	if arg_59_0.wndBag == nil then
		require("gamelogic.zbBagWnd")

		arg_59_0.wndBag = createBagWnd()

		arg_59_0.wndBag:retain()
	end

	arg_59_0.wndBag:setModel(true)
	arg_59_0.wndBag:refresh()
	arg_59_0.wndBag:show(arg_59_0, true)
end

function zbMainScene.showMailWnd(arg_60_0)
	if arg_60_0.wndMail == nil then
		require("gamelogic.zbMailWnd")

		arg_60_0.wndMail = createMailWnd()

		arg_60_0.wndMail:retain()
	end

	arg_60_0.wndMail:setModel(true)
	arg_60_0.wndMail:show(arg_60_0)
	arg_60_0.wndMail:refresh()
end

function zbMainScene.showMailContentWnd(arg_61_0, arg_61_1)
	if arg_61_0.wndMailDetail == nil then
		require("gamelogic.zbMailDetailWnd")

		arg_61_0.wndMailDetail = createMailDetailWnd()

		arg_61_0.wndMailDetail:retain()
	end

	arg_61_0.wndMailDetail:setModel(true)
	arg_61_0.wndMailDetail:show(arg_61_0)
	arg_61_0.wndMailDetail:refresh(arg_61_1)

	return arg_61_0.wndMailDetail
end

function zbMainScene.showGoldenTouch(arg_62_0, arg_62_1)
	if arg_62_0.wndGoldenTouch == nil then
		require("gamelogic.zbGoldenTouchWnd")

		arg_62_0.wndGoldenTouch = createGoldenTouchWnd()

		arg_62_0.wndGoldenTouch:retain()
	end

	arg_62_0.wndGoldenTouch:setModel(true)
	arg_62_0.wndGoldenTouch:show(arg_62_0)
	arg_62_0.wndGoldenTouch:refresh(arg_62_1)

	return arg_62_0.wndGoldenTouch
end

function zbMainScene.showFarmWnd(arg_63_0)
	if arg_63_0.wndFarm == nil then
		require("gamelogic.zbFarmWnd")

		arg_63_0.wndFarm = createFarmWnd()

		arg_63_0.wndFarm:retain()
	end

	arg_63_0.wndFarm:setModel(true)
	arg_63_0.wndFarm:show(arg_63_0)
	arg_63_0.wndFarm:refresh()
end

function zbMainScene.showTaskWnd(arg_64_0, arg_64_1)
	if arg_64_0.wndTask == nil then
		require("gamelogic.zbTaskWnd")

		arg_64_0.wndTask = createTaskWnd()

		arg_64_0.wndTask:retain()
	end

	arg_64_0.wndTask:setModel(true)
	arg_64_0.wndTask:show(arg_64_0, true)
	arg_64_0.wndTask:refresh(arg_64_1)
end

function zbMainScene.showTechListWnd(arg_65_0)
	if arg_65_0.wndTechList == nil then
		require("gamelogic.zbTechListWnd")

		arg_65_0.wndTechList = createTechListWnd()

		arg_65_0.wndTechList:retain()
	end

	arg_65_0.wndTechList:setModel(true)
	arg_65_0.wndTechList:show(arg_65_0, true)
	arg_65_0.wndTechList:refresh()
end

function zbMainScene.showTechWnd(arg_66_0)
	if arg_66_0.wndTech == nil then
		require("gamelogic.zbTechWnd")

		arg_66_0.wndTech = createTechWnd()

		arg_66_0.wndTech:retain()
	end

	arg_66_0.wndTech:setModel(true)
	arg_66_0.wndTech:show(arg_66_0, true)
end

function zbMainScene.showShopWnd(arg_67_0, arg_67_1)
	if arg_67_0.wndShop == nil then
		require("gamelogic.zbShopWnd")

		arg_67_0.wndShop = createShopWnd()

		arg_67_0.wndShop:retain()
	end

	arg_67_0.wndShop:setModel(true)
	arg_67_0.wndShop:refresh(arg_67_1)
	arg_67_0.wndShop:getAutoSaleItemList()
	arg_67_0.wndShop:show(arg_67_0, true)
end

function zbMainScene.showShopWorldWnd(arg_68_0)
	if arg_68_0.wndShopWorld == nil then
		require("gamelogic.zbShopWorldWnd")

		arg_68_0.wndShopWorld = createShopWorldWnd()

		arg_68_0.wndShopWorld:retain()
	end

	arg_68_0.wndShopWorld:setModel(true)
	arg_68_0.wndShopWorld:show(arg_68_0)
	arg_68_0.wndShopWorld:refresh()
end

function zbMainScene.showShopBuyConfirm(arg_69_0, arg_69_1, arg_69_2)
	if arg_69_0.wndShopBuyConfirm == nil then
		require("gamelogic.zbShopBuyConfirmWnd")

		arg_69_0.wndShopBuyConfirm = createShopBuyConfirmWnd()

		arg_69_0.wndShopBuyConfirm:retain()
	end

	arg_69_0.wndShopBuyConfirm:setModel(true)
	arg_69_0.wndShopBuyConfirm:show(arg_69_0)
	arg_69_0.wndShopBuyConfirm:refresh(arg_69_1, arg_69_2)
end

function zbMainScene.showShopAutoSell(arg_70_0, arg_70_1)
	if arg_70_0.wndShopAutoSell == nil then
		require("gamelogic.zbShopAutoSellWnd")

		arg_70_0.wndShopAutoSell = createShopAutoSellWnd()

		arg_70_0.wndShopAutoSell:retain()
	end

	arg_70_0.wndShopAutoSell:setModel(true)
	arg_70_0.wndShopAutoSell:show(arg_70_0)
	arg_70_0.wndShopAutoSell:refresh(arg_70_1)
end

function zbMainScene.showSettingWnd(arg_71_0)
	if arg_71_0.wndSetting == nil then
		require("gamelogic.zbSettingWnd")

		arg_71_0.wndSetting = createSettingWnd()

		arg_71_0.wndSetting:retain()
	end

	arg_71_0.wndSetting:setModel(true)
	arg_71_0.wndSetting:show(arg_71_0)
	arg_71_0.wndSetting:refresh()
end

function zbMainScene.showSettingHeadWnd(arg_72_0)
	if arg_72_0.wndSettingHead == nil then
		require("gamelogic.zbSettingHeadWnd")

		arg_72_0.wndSettingHead = createSettingHeadWnd()

		arg_72_0.wndSettingHead:retain()
	end

	arg_72_0.wndSettingHead:setModel(true)
	arg_72_0.wndSettingHead:show(arg_72_0)
end

function zbMainScene.showSubjectWnd(arg_73_0)
	if arg_73_0.wndSubject == nil then
		require("gamelogic.zbSubjectWnd")

		arg_73_0.wndSubject = createSubjectWnd()

		arg_73_0.wndSubject:retain()
	end

	arg_73_0.wndSubject:setModel(true)
	arg_73_0.wndSubject:show(arg_73_0)
	arg_73_0.wndSubject:refresh(arg_73_0)
end

function zbMainScene.showAwardWnd(arg_74_0, arg_74_1)
	if arg_74_0.wndAward == nil then
		require("gamelogic.zbAwardWnd")

		arg_74_0.wndAward = createAwardWnd()

		arg_74_0.wndAward:retain()
	end

	arg_74_0.wndAward:hide()
	arg_74_0.wndAward:show(arg_74_0)
	arg_74_0.wndAward:refresh(arg_74_1)
end

function zbMainScene.showAwardMuchWnd(arg_75_0, arg_75_1)
	if arg_75_0.wndAwardMuch == nil then
		require("gamelogic.zbAwardMuchWnd")

		arg_75_0.wndAwardMuch = createAwardMuchWnd()

		arg_75_0.wndAwardMuch:retain()
	end

	arg_75_0.wndAwardMuch:setModel(true)
	arg_75_0.wndAwardMuch:show(arg_75_0)
	arg_75_0.wndAwardMuch:refresh(arg_75_1)
end

function zbMainScene.checkShowLevelUpWnd(arg_76_0)
	if g_Self:isNeedShowLevelUp() == false then
		return false
	end

	if arg_76_0.wndShowLevelUp == nil then
		require("gamelogic.zbShowLevelUpWnd")

		arg_76_0.wndShowLevelUp = createShowLevelUpWnd()

		arg_76_0.wndShowLevelUp:retain()
	end

	arg_76_0.wndShowLevelUp:setModel(true)
	arg_76_0.wndShowLevelUp:show(arg_76_0)
	arg_76_0.wndShowLevelUp:refresh()

	return true
end

function zbMainScene.showVipLevelUpWnd(arg_77_0)
	if arg_77_0.wndShowVipLevelUp == nil then
		require("gamelogic.zbShowVipLevelUpWnd")

		arg_77_0.wndShowVipLevelUp = createVipLevelUpWnd()

		arg_77_0.wndShowVipLevelUp:retain()
	end

	arg_77_0.wndShowVipLevelUp:setModel(true)
	arg_77_0.wndShowVipLevelUp:show(arg_77_0)
	arg_77_0.wndShowVipLevelUp:refresh()

	return true
end

function zbMainScene.checkShowNewFuncWnd(arg_78_0, arg_78_1)
	if arg_78_0.wndShowNewFunc == nil then
		require("gamelogic.zbShowNewFuncWnd")

		arg_78_0.wndShowNewFunc = createShowNewFuncWnd()

		arg_78_0.wndShowNewFunc:retain()
	end

	return arg_78_0.wndShowNewFunc:refresh(arg_78_1)
end

function zbMainScene.checkShowNewFuncWndImmRecord(arg_79_0, arg_79_1)
	if arg_79_0.wndShowNewFunc == nil then
		require("gamelogic.zbShowNewFuncWnd")

		arg_79_0.wndShowNewFunc = createShowNewFuncWnd()

		arg_79_0.wndShowNewFunc:retain()
	end

	return arg_79_0.wndShowNewFunc:refreshFunRecord(arg_79_1)
end

function zbMainScene.showNewGodWnd(arg_80_0, arg_80_1)
	if arg_80_0.wndShowNewGod == nil then
		require("gamelogic.zbShowNewGodWnd")

		arg_80_0.wndShowNewGod = createShowNewGodWnd()

		arg_80_0.wndShowNewGod:retain()
	end

	arg_80_0.wndShowNewGod:setModel(true)
	arg_80_0.wndShowNewGod:show(arg_80_0)
	arg_80_0.wndShowNewGod:refresh(arg_80_1)
end

function zbMainScene.showFriendBossWnd(arg_81_0, arg_81_1)
	if arg_81_0.wndShowFriendBoss == nil then
		require("gamelogic.zbShowFriendBossWnd")

		arg_81_0.wndShowFriendBoss = createShowFriendBossWnd()

		arg_81_0.wndShowFriendBoss:retain()
	end

	arg_81_0.wndShowFriendBoss:setModel(true)
	arg_81_0.wndShowFriendBoss:show(arg_81_0)
	arg_81_0.wndShowFriendBoss:refresh(arg_81_1)
end

function zbMainScene.showShowNewBossWnd(arg_82_0, arg_82_1, arg_82_2, arg_82_3)
	if arg_82_0.wndShowNewBoss == nil then
		require("gamelogic.zbShowNewBossWnd")

		arg_82_0.wndShowNewBoss = createShowNewBossWnd()

		arg_82_0.wndShowNewBoss:retain()
	end

	arg_82_0.wndShowNewBoss:setModel(true)
	arg_82_0.wndShowNewBoss:show(arg_82_0)
	arg_82_0.wndShowNewBoss:refresh(arg_82_1, arg_82_2, arg_82_3)
end

function zbMainScene.showHeroStarUpWnd(arg_83_0, arg_83_1)
	if arg_83_0.wndShowHeroStarUp == nil then
		require("gamelogic.zbShowHeroStarUpWnd")

		arg_83_0.wndShowHeroStarUp = createShowHeroStarUpWnd()

		arg_83_0.wndShowHeroStarUp:retain()
	end

	arg_83_0.wndShowHeroStarUp:setModel(true)
	arg_83_0.wndShowHeroStarUp:show(arg_83_0)
	arg_83_0.wndShowHeroStarUp:refresh(arg_83_1)
end

function zbMainScene.showNewRoleWnd(arg_84_0, arg_84_1)
	if arg_84_0.wndShowNewRole == nil then
		require("gamelogic.zbShowNewRoleWnd")

		arg_84_0.wndShowNewRole = createShowNewRoleWnd()

		arg_84_0.wndShowNewRole:retain()
	end

	arg_84_0.wndShowNewRole:setModel(true)
	arg_84_0.wndShowNewRole:show(arg_84_0)
	arg_84_0.wndShowNewRole:refresh(arg_84_1)
end

function zbMainScene.hideCommonTip(arg_85_0)
	if arg_85_0.wndCommomTip ~= nil then
		arg_85_0.wndCommomTip:hide()
	end
end

function zbMainScene.showHeroTip(arg_86_0, arg_86_1)
	if arg_86_0.wndCommomTip == nil then
		require("gamelogic.zbTipCommonWnd")

		arg_86_0.wndCommomTip = createTipCommonWnd()

		arg_86_0.wndCommomTip:retain()
	end

	arg_86_0.wndCommomTip:setModel(true)
	arg_86_0.wndCommomTip:show(arg_86_0)
	arg_86_0.wndCommomTip:showHeroTips(arg_86_1)
end

function zbMainScene.showAwardTip(arg_87_0, arg_87_1, arg_87_2)
	if arg_87_0.wndCommomTip == nil then
		require("gamelogic.zbTipCommonWnd")

		arg_87_0.wndCommomTip = createTipCommonWnd()

		arg_87_0.wndCommomTip:retain()
	end

	arg_87_0.wndCommomTip:setModel(true)
	arg_87_0.wndCommomTip:show(arg_87_0)
	arg_87_0.wndCommomTip:showAwardTips(arg_87_1, arg_87_2)
end

function zbMainScene.showSkillTip(arg_88_0, arg_88_1, arg_88_2)
	if arg_88_0.wndCommomTip == nil then
		require("gamelogic.zbTipCommonWnd")

		arg_88_0.wndCommomTip = createTipCommonWnd()

		arg_88_0.wndCommomTip:retain()
	end

	arg_88_0.wndCommomTip:setModel(true)
	arg_88_0.wndCommomTip:show(arg_88_0)
	arg_88_0.wndCommomTip:showSkillTips(arg_88_1, arg_88_2)
end

function zbMainScene.showGodEquipSkillTips(arg_89_0, arg_89_1)
	if arg_89_0.wndCommomTip == nil then
		require("gamelogic.zbTipCommonWnd")

		arg_89_0.wndCommomTip = createTipCommonWnd()

		arg_89_0.wndCommomTip:retain()
	end

	arg_89_0.wndCommomTip:setModel(true)
	arg_89_0.wndCommomTip:show(arg_89_0)
	arg_89_0.wndCommomTip:showGodEquipSkillTips(arg_89_1)
end

function zbMainScene.showHeroShowWnd(arg_90_0)
	if arg_90_0.wndHeroShow == nil then
		require("gamelogic.zbHeroShowWnd")

		arg_90_0.wndHeroShow = createHeroShowWnd()

		arg_90_0.wndHeroShow:retain()
	end

	arg_90_0.wndHeroShow:setModel(true)
	arg_90_0.wndHeroShow:show(arg_90_0)
	arg_90_0.wndHeroShow:refresh()
end

function zbMainScene.showBagItemInfoWnd(arg_91_0, arg_91_1, arg_91_2, arg_91_3)
	if arg_91_0.wndBagItemInfo == nil then
		require("gamelogic.zbBagItemInfoWnd")

		arg_91_0.wndBagItemInfo = createBagItemInfoWnd()

		arg_91_0.wndBagItemInfo:retain()
	end

	arg_91_0.wndBagItemInfo:setModel(true)
	arg_91_0.wndBagItemInfo:show(arg_91_0)
	arg_91_0.wndBagItemInfo:refresh(arg_91_1, arg_91_2, arg_91_3)
end

function zbMainScene.showWsConnectWaitWnd(arg_92_0)
	if arg_92_0.wndReconnect == nil then
		require("gamelogic.zbWsConnectWait")

		arg_92_0.wndReconnect = createWsConnectWaitWnd()

		arg_92_0.wndReconnect:retain()
	end

	arg_92_0.wndReconnect:setModel(true)
	arg_92_0.wndReconnect:show(arg_92_0)
end

function zbMainScene.freeWsConnectWaitWnd(arg_93_0)
	if g_MainScene.wndReconnect then
		zbUtil:freeWnd(g_MainScene.wndReconnect)

		g_MainScene.wndReconnect = nil
	end
end

function zbMainScene.showServerNotice(arg_94_0)
	if arg_94_0.wndServerNotice == nil then
		require("gamelogic.zbServerNoticeWnd")

		arg_94_0.wndServerNotice = createServerNoticeWnd()

		arg_94_0.wndServerNotice:retain()
	end

	arg_94_0.wndServerNotice:setModel(true)
	arg_94_0.wndServerNotice:show(arg_94_0)
	arg_94_0.wndServerNotice:refresh()
end

function zbMainScene.showChatHornWnd(arg_95_0)
	if arg_95_0.wndChatHorn == nil then
		require("gamelogic.zbChatHornWnd")

		arg_95_0.wndChatHorn = createChatHornWnd()

		arg_95_0.wndChatHorn:retain()
	end

	arg_95_0.wndChatHorn:setModel(true)
	arg_95_0.wndChatHorn:show(arg_95_0)
end

function zbMainScene.showChatFaceWnd(arg_96_0)
	if arg_96_0.wndChatFace == nil then
		require("gamelogic.zbChatFaceWnd")

		arg_96_0.wndChatFace = createChatFaceWnd()

		arg_96_0.wndChatFace:retain()
	end

	arg_96_0.wndChatFace:setModel(true)
	arg_96_0.wndChatFace:show(arg_96_0)
end

function zbMainScene.showAccount(arg_97_0)
	if arg_97_0.wndAccount == nil then
		require("gamelogic.zbAccountWnd")

		arg_97_0.wndAccount = createAccountWnd()

		arg_97_0.wndAccount:retain()
	end

	arg_97_0.wndAccount:setModel(true)
	arg_97_0.wndAccount:show(arg_97_0)
end

function zbMainScene.showChangeName(arg_98_0, arg_98_1)
	if arg_98_0.wndChangeName == nil then
		require("gamelogic.zbChangeNameWnd")

		arg_98_0.wndChangeName = createChangeNameWnd()

		arg_98_0.wndChangeName:retain()
	end

	arg_98_0.wndChangeName:setModel(true)
	arg_98_0.wndChangeName:show(arg_98_0)
	arg_98_0.wndChangeName:refresh(arg_98_1)
end

function zbMainScene.showChangHeadIcon(arg_99_0)
	if arg_99_0.wndChangHeadIcon == nil then
		require("gamelogic.zbChangeHeadIconWnd")

		arg_99_0.wndChangHeadIcon = createChangHeadIconWnd()

		arg_99_0.wndChangHeadIcon:retain()
	end

	arg_99_0.wndChangHeadIcon:setModel(true)
	arg_99_0.wndChangHeadIcon:show(arg_99_0)
	arg_99_0.wndChangHeadIcon:refresh()

	return arg_99_0.wndChangHeadIcon
end

function zbMainScene.showWarPath(arg_100_0, arg_100_1, arg_100_2)
	if arg_100_2 == nil then
		arg_100_2 = true
	end

	if arg_100_0.wndWarPath == nil then
		require("gamelogic.zbWarPathWnd")

		arg_100_0.wndWarPath = createWarPathWnd()

		arg_100_0.wndWarPath:retain()
	end

	arg_100_0.wndWarPath:setModel(true)
	arg_100_0.wndWarPath:show(arg_100_0, arg_100_2)
	arg_100_0.wndWarPath:refresh(arg_100_1)
end

function zbMainScene.showWarForce(arg_101_0, arg_101_1, arg_101_2, arg_101_3)
	if arg_101_0.wndWarForce == nil then
		require("gamelogic.zbWarForceWnd")

		arg_101_0.wndWarForce = createWarForceWnd()

		arg_101_0.wndWarForce:retain()
	end

	arg_101_0.wndWarForce:setModel(true)
	arg_101_0.wndWarForce:show(arg_101_0)
	arg_101_0.wndWarForce:gotoForce(arg_101_1, arg_101_2, arg_101_3)

	return arg_101_0.wndWarForce
end

function zbMainScene.showTeamForce(arg_102_0)
	if arg_102_0.wndTeamForce == nil then
		require("gamelogic.zbTeamForceWnd")

		arg_102_0.wndTeamForce = createTeamForceWnd()

		arg_102_0.wndTeamForce:retain()
	end

	arg_102_0.wndTeamForce:setModel(true)
	arg_102_0.wndTeamForce:show(arg_102_0)
	arg_102_0.wndTeamForce:refresh()
end

function zbMainScene.showForceAward(arg_103_0, arg_103_1, arg_103_2, arg_103_3)
	if arg_103_0.wndForceAward == nil then
		require("gamelogic.zbForceAwardWnd")

		arg_103_0.wndForceAward = createForceAwardWnd()

		arg_103_0.wndForceAward:retain()
	end

	arg_103_0.wndForceAward:setModel(true)
	arg_103_0.wndForceAward:show(arg_103_0)
	arg_103_0.wndForceAward:refresh(arg_103_1, arg_103_2, arg_103_3)
end

function zbMainScene.showLevelDialog(arg_104_0, arg_104_1, arg_104_2, arg_104_3)
	if arg_104_0.wndLevel == nil then
		require("gamelogic.zbLevelWnd")

		arg_104_0.wndLevel = createLevelWnd()

		arg_104_0.wndLevel:retain()
	end

	arg_104_0.wndLevel:setModel(true)
	arg_104_0.wndLevel:show(arg_104_0)
	arg_104_0.wndLevel:refresh(arg_104_1, arg_104_2, arg_104_3)
end

function zbMainScene.showLevelSweep(arg_105_0, arg_105_1)
	if arg_105_0.wndLevelSweep == nil then
		require("gamelogic.zbLevelSweepWnd")

		arg_105_0.wndLevelSweep = createLevelSweepWnd()

		arg_105_0.wndLevelSweep:retain()
	end

	arg_105_0.wndLevelSweep:setModel(true)
	arg_105_0.wndLevelSweep:show(arg_105_0)
	arg_105_0.wndLevelSweep:refresh(arg_105_1.ForceId, arg_105_1.LevelId, arg_105_1.LevelType, arg_105_1.LevelAwardList, arg_105_1.ExtraAwardList, arg_105_1.RoleExp)
end

function zbMainScene.createEmbattleWnd(arg_106_0)
	if arg_106_0.wndEmbattle == nil then
		require("gamelogic.zbEmbattleWnd")

		arg_106_0.wndEmbattle = createEmbattleWnd()

		arg_106_0.wndEmbattle:retain()
	end

	arg_106_0.wndEmbattle:setModel(true)
	arg_106_0.wndEmbattle:show(arg_106_0)

	return arg_106_0.wndEmbattle
end

function zbMainScene.showEmbattleAndRefreshItems(arg_107_0)
	local var_107_0 = arg_107_0:createEmbattleWnd()

	var_107_0:refreshLeft()
	var_107_0:refreshRight()

	return var_107_0
end

function zbMainScene.showEmbattleLevel(arg_108_0, arg_108_1, arg_108_2, arg_108_3)
	local var_108_0 = arg_108_0:createEmbattleWnd()

	var_108_0:refreshLevel(arg_108_1, arg_108_2, arg_108_3)

	return var_108_0
end

function zbMainScene.showEmbattleArena(arg_109_0, arg_109_1)
	local var_109_0 = arg_109_0:createEmbattleWnd()

	var_109_0:refreshArena(arg_109_1)

	return var_109_0
end

function zbMainScene.showEmbattleChat(arg_110_0, arg_110_1)
	local var_110_0 = arg_110_0:createEmbattleWnd()

	var_110_0:refreshChat(arg_110_1)

	return var_110_0
end

function zbMainScene.showEmbattleFriend(arg_111_0, arg_111_1)
	local var_111_0 = arg_111_0:createEmbattleWnd()

	var_111_0:refreshFriend(arg_111_1)

	return var_111_0
end

function zbMainScene.showEmbattleFriendBoss(arg_112_0, arg_112_1)
	local var_112_0 = arg_112_0:createEmbattleWnd()

	var_112_0:refreshFriendBoss(arg_112_1)

	return var_112_0
end

function zbMainScene.showEmbattleLegionBoss(arg_113_0, arg_113_1)
	local var_113_0 = arg_113_0:createEmbattleWnd()

	var_113_0:refreshLegionBoss(arg_113_1)

	return var_113_0
end

function zbMainScene.showEmbattleLegionWar(arg_114_0, arg_114_1, arg_114_2, arg_114_3, arg_114_4)
	local var_114_0 = arg_114_0:createEmbattleWnd()

	var_114_0:refreshLegionWar(arg_114_1, arg_114_2, arg_114_3, arg_114_4)

	return var_114_0
end

function zbMainScene.showEmbattleLegionMem(arg_115_0, arg_115_1)
	local var_115_0 = arg_115_0:createEmbattleWnd()

	var_115_0:refreshLegionMem(arg_115_1)

	return var_115_0
end

function zbMainScene.showEmbattlePata(arg_116_0, arg_116_1, arg_116_2)
	local var_116_0 = arg_116_0:createEmbattleWnd()

	var_116_0:refreshPata(arg_116_1, arg_116_2)

	return var_116_0
end

function zbMainScene.showEmbattleYuanzheng(arg_117_0, arg_117_1, arg_117_2)
	local var_117_0 = arg_117_0:createEmbattleWnd()

	var_117_0:refreshYuanzheng(arg_117_1, arg_117_2)

	return var_117_0
end

function zbMainScene.showEmbattleTrial(arg_118_0, arg_118_1, arg_118_2)
	local var_118_0 = arg_118_0:createEmbattleWnd()

	var_118_0:refreshTrial(arg_118_1, arg_118_2)

	return var_118_0
end

function zbMainScene.showEmbattleWorldRes(arg_119_0, arg_119_1)
	local var_119_0 = arg_119_0:createEmbattleWnd()

	var_119_0:refreshWorldRes(arg_119_1)

	return var_119_0
end

function zbMainScene.showEmbattleWorldHorse(arg_120_0, arg_120_1, arg_120_2)
	local var_120_0 = arg_120_0:createEmbattleWnd()

	var_120_0:refreshWorldHorse(arg_120_1, arg_120_2)

	return var_120_0
end

function zbMainScene.showEmbattleWorldBoss(arg_121_0, arg_121_1, arg_121_2)
	local var_121_0 = arg_121_0:createEmbattleWnd()

	var_121_0:refreshWorldBoss(arg_121_1, arg_121_2)

	return var_121_0
end

function zbMainScene.showCombat(arg_122_0)
	if arg_122_0.wndCombat == nil then
		require("gamelogic.zbCombatWnd")

		arg_122_0.wndCombat = createCombatWnd()

		arg_122_0.wndCombat:retain()
		arg_122_0.wndCombat:setModel(true)
	end

	arg_122_0.wndCombat:show(arg_122_0)
	arg_122_0.wndCombat:refresh()
end

function zbMainScene.showCombatFocus(arg_123_0)
	if arg_123_0.wndCombatFocus == nil then
		require("gamelogic.zbCombatFocusWnd")

		arg_123_0.wndCombatFocus = createCombatFocusWnd()

		arg_123_0.wndCombatFocus:retain()
		arg_123_0.wndCombatFocus:setModel(true)
	end

	arg_123_0.wndCombatFocus:show(arg_123_0)
	arg_123_0.wndCombatFocus:refresh()
end

function zbMainScene.showCombatQte(arg_124_0)
	if arg_124_0.wndCombatQte == nil then
		require("gamelogic.zbCombatFocusWnd")

		arg_124_0.wndCombatQte = createCombatQTEWnd()

		arg_124_0.wndCombatQte:retain()
		arg_124_0.wndCombatQte:setModel(true)
	end

	arg_124_0.wndCombatQte:show(arg_124_0)
	arg_124_0.wndCombatQte:refresh()
end

function zbMainScene.showBulletScreen(arg_125_0, arg_125_1, arg_125_2, arg_125_3)
	if arg_125_0.wndBulletScreen == nil then
		require("gamelogic.zbBulletScreenWnd")

		arg_125_0.wndBulletScreen = createBulletScreenWnd()

		arg_125_0.wndBulletScreen:retain()
		arg_125_0.wndBulletScreen:setModel(true)
	end

	arg_125_0.wndBulletScreen:hide()
	arg_125_0.wndBulletScreen:show(arg_125_0)
	arg_125_0.wndBulletScreen:refresh(arg_125_1, arg_125_2, arg_125_3)
end

function zbMainScene.showCombatPause(arg_126_0)
	if arg_126_0.wndCombatPause == nil then
		require("gamelogic.zbCombatPauseWnd")

		arg_126_0.wndCombatPause = createCombatPauseWnd()

		arg_126_0.wndCombatPause:retain()
		arg_126_0.wndCombatPause:setModel(true)
	end

	arg_126_0.wndCombatPause:show(arg_126_0)
	arg_126_0.wndCombatPause:refresh()
end

function zbMainScene.showFriendBossBalance(arg_127_0)
	if arg_127_0.wndFriendBossBalance == nil then
		require("gamelogic.zbFriendBossBalanceWnd")

		arg_127_0.wndFriendBossBalance = createFriendBossBalanceWnd()

		arg_127_0.wndFriendBossBalance:retain()
	end

	arg_127_0.wndFriendBossBalance:setModel(true)
	arg_127_0.wndFriendBossBalance:show(arg_127_0)
	arg_127_0.wndFriendBossBalance:refreshResultData()
end

function zbMainScene.showLegionBossBalance(arg_128_0)
	if arg_128_0.wndLegionBossBalance == nil then
		require("gamelogic.zbLegionBossBalanceWnd")

		arg_128_0.wndLegionBossBalance = createLegionBossBalanceWnd()

		arg_128_0.wndLegionBossBalance:retain()
	end

	arg_128_0.wndLegionBossBalance:setModel(true)
	arg_128_0.wndLegionBossBalance:show(arg_128_0)
	arg_128_0.wndLegionBossBalance:refreshResultData()
end

function zbMainScene.showWorldBossBalance(arg_129_0)
	if arg_129_0.wndWorldBossBalance == nil then
		require("gamelogic.zbWorldBossBalanceWnd")

		arg_129_0.wndWorldBossBalance = createWorldBossBalanceWnd()

		arg_129_0.wndWorldBossBalance:retain()
	end

	arg_129_0.wndWorldBossBalance:setModel(true)
	arg_129_0.wndWorldBossBalance:show(arg_129_0)
	arg_129_0.wndWorldBossBalance:refreshResultData()
end

function zbMainScene.doShowPataBalance(arg_130_0)
	if arg_130_0:isWndVisible(arg_130_0.wndChat) then
		arg_130_0.wndChat:hide()
	end

	if g_MainScene.wndCombat then
		g_CombatSystem:setNormalSpeed()
	end

	if g_CombatSystem.combatData.result >= EBattleResult.Win1 then
		arg_130_0:showPataBalanceWin()
	else
		arg_130_0:showBalanceLose()
	end
end

function zbMainScene.showPataBalanceWin(arg_131_0)
	if arg_131_0.wndPataBalanceWin == nil then
		require("gamelogic.zbPataBalanceWinWnd")

		arg_131_0.wndPataBalanceWin = createPataBalanceWinWnd()

		arg_131_0.wndPataBalanceWin:retain()
	end

	arg_131_0.wndPataBalanceWin:setModel(true)
	arg_131_0.wndPataBalanceWin:show(arg_131_0)
	arg_131_0.wndPataBalanceWin:refreshResultData()
end

function zbMainScene.showBalance(arg_132_0, arg_132_1)
	if arg_132_0:isWndVisible(arg_132_0.wndChat) then
		arg_132_0.wndChat:hide()
	end

	if g_MainScene.wndBulletScreen then
		g_MainScene.wndBulletScreen:hide()
	end

	if g_MainScene.wndCombat then
		g_CombatSystem:setNormalSpeed()
	end

	if g_CombatSystem.combatData.result >= EBattleResult.Win1 then
		arg_132_0:showBalanceWin(arg_132_1)
	else
		arg_132_0:showBalanceLose()
	end
end

function zbMainScene.showBalanceWin(arg_133_0, arg_133_1)
	if arg_133_0.wndBalanceWin == nil then
		require("gamelogic.zbBalanceWinWnd")

		arg_133_0.wndBalanceWin = createBalanceWinWnd()

		arg_133_0.wndBalanceWin:retain()
	end

	arg_133_0.wndBalanceWin:setModel(true)
	arg_133_0.wndBalanceWin:show(arg_133_0)
	arg_133_0.wndBalanceWin:refreshResultData(arg_133_1)
end

function zbMainScene.showBalanceLose(arg_134_0)
	if arg_134_0.wndBalanceLose == nil then
		require("gamelogic.zbBalanceLoseWnd")

		arg_134_0.wndBalanceLose = createBalanceLoseWnd()

		arg_134_0.wndBalanceLose:retain()
	end

	arg_134_0.wndBalanceLose:setModel(true)
	arg_134_0.wndBalanceLose:show(arg_134_0)
	arg_134_0.wndBalanceLose:refreshResultData()
end

function zbMainScene.showAccountPopWnd(arg_135_0)
	if arg_135_0.wndAccountPop == nil then
		require("gamelogic.zbAcccountPopWnd")

		arg_135_0.wndAccountPop = createAccountPopWnd()

		arg_135_0.wndAccountPop:retain()
	end

	arg_135_0.wndAccountPop:setModel(true)
	arg_135_0.wndAccountPop:show(arg_135_0)
end

function zbMainScene.showBalanceData(arg_136_0)
	if arg_136_0.wndBalanceData == nil then
		require("gamelogic.zbBalanceDataWnd")

		arg_136_0.wndBalanceData = createBalanceDataWnd()

		arg_136_0.wndBalanceData:retain()
	end

	arg_136_0.wndBalanceData:setModel(true)
	arg_136_0.wndBalanceData:show(arg_136_0)
	arg_136_0.wndBalanceData:refresh()
end

function zbMainScene.showRuleWnd(arg_137_0, arg_137_1)
	if arg_137_0.wndRuleCommon == nil then
		require("gamelogic.zbRuleCommonWnd")

		arg_137_0.wndRuleCommon = createRuleCommonWnd()

		arg_137_0.wndRuleCommon:retain()
	end

	arg_137_0.wndRuleCommon:setModel(true)
	arg_137_0.wndRuleCommon:show(arg_137_0)
	arg_137_0.wndRuleCommon:refreshRuleType(arg_137_1)
end

function zbMainScene.showRuleEquipWuXingWnd(arg_138_0)
	if arg_138_0.wndRuleEquipWuXing == nil then
		require("gamelogic.zbRuleEquipWuXingWnd")

		arg_138_0.wndRuleEquipWuXing = createRuleEquipWuXingWnd()

		arg_138_0.wndRuleEquipWuXing:retain()
	end

	arg_138_0.wndRuleEquipWuXing:setModel(true)
	arg_138_0.wndRuleEquipWuXing:show(arg_138_0)
	arg_138_0.wndRuleEquipWuXing:refresh()
end

function zbMainScene.showRuleArenaWnd(arg_139_0)
	if arg_139_0.wndRuleArena == nil then
		require("gamelogic.zbRuleArenaWnd")

		arg_139_0.wndRuleArena = createRuleArenaWnd()

		arg_139_0.wndRuleArena:retain()
	end

	arg_139_0.wndRuleArena:setModel(true)
	arg_139_0.wndRuleArena:show(arg_139_0)
	arg_139_0.wndRuleArena:refresh()
end

function zbMainScene.createArenaWnd(arg_140_0)
	if arg_140_0.wndArena == nil then
		require("gamelogic.zbArenaWnd")

		arg_140_0.wndArena = createArenaWnd()

		arg_140_0.wndArena:retain()
	end
end

function zbMainScene.showArenaWnd(arg_141_0)
	arg_141_0:createArenaWnd()
	arg_141_0.wndArena:setModel(true)
	arg_141_0.wndArena:refresh()
	arg_141_0.wndArena:show(arg_141_0, true)
end

function zbMainScene.showArenaPlayerWnd(arg_142_0, arg_142_1)
	if arg_142_0.wndArenaPlayer == nil then
		require("gamelogic.zbArenaPlayerWnd")

		arg_142_0.wndArenaPlayer = createArenaPlayerWnd()

		arg_142_0.wndArenaPlayer:retain()
	end

	arg_142_0.wndArenaPlayer:setModel(true)
	arg_142_0.wndArenaPlayer:show(arg_142_0)
	arg_142_0.wndArenaPlayer:refresh(arg_142_1)
end

function zbMainScene.showArenaRecordWnd(arg_143_0)
	if arg_143_0.wndArenaRecord == nil then
		require("gamelogic.zbArenaRecordWnd")

		arg_143_0.wndArenaRecord = createArenaRecordWnd()

		arg_143_0.wndArenaRecord:retain()
	end

	arg_143_0.wndArenaRecord:setModel(true)
	arg_143_0.wndArenaRecord:show(arg_143_0)
	arg_143_0.wndArenaRecord:refresh()
end

function zbMainScene.showArenaHistoryBestWnd(arg_144_0)
	if arg_144_0.wndArenaHistory == nil then
		require("gamelogic.zbArenaHistoryBestWnd")

		arg_144_0.wndArenaHistory = createArenaHistoryBestWnd()

		arg_144_0.wndArenaHistory:retain()
	end

	arg_144_0.wndArenaHistory:setModel(true)
	arg_144_0.wndArenaHistory:show(arg_144_0)
	arg_144_0.wndArenaHistory:refresh()
end

function zbMainScene.showArenaRankUp(arg_145_0)
	if arg_145_0.wndArenaRankUp == nil then
		require("gamelogic.zbArenaRankUpWnd")

		arg_145_0.wndArenaRankUp = createArenaRankUpWnd()

		arg_145_0.wndArenaRankUp:retain()
	end

	arg_145_0.wndArenaRankUp:setModel(true)
	arg_145_0.wndArenaRankUp:show(arg_145_0)
	arg_145_0.wndArenaRankUp:refresh()
end

function zbMainScene.showRankListWnd(arg_146_0, arg_146_1)
	if arg_146_0.wndRankList == nil then
		require("gamelogic.zbRankListWnd")

		arg_146_0.wndRankList = createRankListWnd()

		arg_146_0.wndRankList:retain()
	end

	arg_146_0.wndRankList:setModel(true)
	arg_146_0.wndRankList:show(arg_146_0, true)
	arg_146_0.wndRankList:refresh(arg_146_1)
end

function zbMainScene.showRankTipArenaWnd(arg_147_0, arg_147_1)
	if arg_147_0.wndRankTipArena == nil then
		require("gamelogic.zbRank_TipArenaWnd")

		arg_147_0.wndRankTipArena = createRankTipArenaWnd()

		arg_147_0.wndRankTipArena:retain()
	end

	arg_147_0.wndRankTipArena:setModel(true)
	arg_147_0.wndRankTipArena:show(arg_147_0)
	arg_147_0.wndRankTipArena:refresh(arg_147_1)
end

function zbMainScene.showRankTipPowerWnd(arg_148_0, arg_148_1)
	if arg_148_0.wndRankTipPower == nil then
		require("gamelogic.zbRank_TipPowerWnd")

		arg_148_0.wndRankTipPower = createRankTipPowerWnd()

		arg_148_0.wndRankTipPower:retain()
	end

	arg_148_0.wndRankTipPower:setModel(true)
	arg_148_0.wndRankTipPower:show(arg_148_0)
	arg_148_0.wndRankTipPower:refresh(arg_148_1)
end

function zbMainScene.showRankTipSingleWnd(arg_149_0, arg_149_1)
	if arg_149_0.wndRankTipSingle == nil then
		require("gamelogic.zbRank_TipSingleWnd")

		arg_149_0.wndRankTipSingle = createRankTipSingleWnd()

		arg_149_0.wndRankTipSingle:retain()
	end

	arg_149_0.wndRankTipSingle:setModel(true)
	arg_149_0.wndRankTipSingle:show(arg_149_0)
	arg_149_0.wndRankTipSingle:refresh(arg_149_1)
end

function zbMainScene.showHeroTrialWnd(arg_150_0)
	if arg_150_0.wndHeroTrial == nil then
		require("gamelogic.zbHeroTrialWnd")

		arg_150_0.wndHeroTrial = createHeroTrialWnd()

		arg_150_0.wndHeroTrial:retain()
	end

	arg_150_0.wndHeroTrial:setModel(true)
	arg_150_0.wndHeroTrial:show(arg_150_0, true)
	arg_150_0.wndHeroTrial:refresh()
end

function zbMainScene.showHeroTrialDetailWnd(arg_151_0, arg_151_1)
	if arg_151_0.wndHeroTrialDetail == nil then
		require("gamelogic.zbHeroTrialDetailWnd")

		arg_151_0.wndHeroTrialDetail = createHeroTrialDetailWnd()

		arg_151_0.wndHeroTrialDetail:retain()
	end

	arg_151_0.wndHeroTrialDetail:setModel(true)
	arg_151_0.wndHeroTrialDetail:show(arg_151_0)
	arg_151_0.wndHeroTrialDetail:refresh(arg_151_1)

	return arg_151_0.wndHeroTrialDetail
end

function zbMainScene.showHeroTrialSweepWnd(arg_152_0, arg_152_1)
	if arg_152_0.wndHeroTrialSweep == nil then
		require("gamelogic.zbHeroTrialSweepWnd")

		arg_152_0.wndHeroTrialSweep = createHeroTrialSweepWnd()

		arg_152_0.wndHeroTrialSweep:retain()
	end

	arg_152_0.wndHeroTrialSweep:setModel(true)
	arg_152_0.wndHeroTrialSweep:show(arg_152_0)
	arg_152_0.wndHeroTrialSweep:refresh(arg_152_1.TrialType, arg_152_1.Level, arg_152_1.AwardList)
end

function zbMainScene.showShenShanListWnd(arg_153_0)
	if arg_153_0.wndShenShanList == nil then
		require("gamelogic.zbShenShanListWnd")

		arg_153_0.wndShenShanList = createShenShanListWnd()

		arg_153_0.wndShenShanList:retain()
	end

	arg_153_0.wndShenShanList:setModel(true)
	arg_153_0.wndShenShanList:show(arg_153_0)
	arg_153_0.wndShenShanList:refresh()
end

function zbMainScene.showPataWnd(arg_154_0)
	if arg_154_0.wndPata == nil then
		require("gamelogic.zbPataWnd")

		arg_154_0.wndPata = createPataWnd()

		arg_154_0.wndPata:retain()
	end

	arg_154_0.wndPata:setModel(true)
	arg_154_0.wndPata:show(arg_154_0)
	arg_154_0.wndPata:refresh()
end

function zbMainScene.showPataSaoDangBuyWnd(arg_155_0, arg_155_1)
	if arg_155_0.wndPataSaoDangBuy == nil then
		require("gamelogic.zbPataSaoDangBuyWnd")

		arg_155_0.wndPataSaoDangBuy = createPataSaoDangBuyWnd()

		arg_155_0.wndPataSaoDangBuy:retain()
	end

	arg_155_0.wndPataSaoDangBuy:setModel(true)
	arg_155_0.wndPataSaoDangBuy:show(arg_155_0)
	arg_155_0.wndPataSaoDangBuy:refresh(arg_155_1)
end

function zbMainScene.showPataSaoDangAwardWnd(arg_156_0, arg_156_1)
	if arg_156_0.wndPataSaoDangAward == nil then
		require("gamelogic.zbPataSaoDangAwardWnd")

		arg_156_0.wndPataSaoDangAward = createPataSaoDangAwardWnd()

		arg_156_0.wndPataSaoDangAward:retain()
	end

	arg_156_0.wndPataSaoDangAward:setModel(true)
	arg_156_0.wndPataSaoDangAward:show(arg_156_0)
	arg_156_0.wndPataSaoDangAward:refresh(arg_156_1)
end

function zbMainScene.showPataScoreAwardWnd(arg_157_0)
	if arg_157_0.wndPataScoreAward == nil then
		require("gamelogic.zbPataScoreAwardWnd")

		arg_157_0.wndPataScoreAward = createPataScoreAwardWnd()

		arg_157_0.wndPataScoreAward:retain()
	end

	arg_157_0.wndPataScoreAward:setModel(true)
	arg_157_0.wndPataScoreAward:show(arg_157_0)
	arg_157_0.wndPataScoreAward:refresh()
end

function zbMainScene.showYuanZhengWnd(arg_158_0)
	if arg_158_0.wndYuanZheng == nil then
		require("gamelogic.zbYuanZhengWnd")

		arg_158_0.wndYuanZheng = createYuanZhengWnd()

		arg_158_0.wndYuanZheng:retain()
	end

	arg_158_0.wndYuanZheng:setModel(true)
	arg_158_0.wndYuanZheng:show(arg_158_0)
	arg_158_0.wndYuanZheng:refresh(true)
end

function zbMainScene.showYuanzhengScoreAwardWnd(arg_159_0)
	if arg_159_0.wndScoreAward == nil then
		require("gamelogic.zbYuanzhengScoreAwardWnd")

		arg_159_0.wndYuanzhengScoreAward = createYuanzhengScoreAwardWnd()

		arg_159_0.wndYuanzhengScoreAward:retain()
	end

	arg_159_0.wndYuanzhengScoreAward:setModel(true)
	arg_159_0.wndYuanzhengScoreAward:show(arg_159_0)
	arg_159_0.wndYuanzhengScoreAward:refresh()
end

function zbMainScene.showYuanzhengPlayerWnd(arg_160_0, arg_160_1, arg_160_2)
	if arg_160_0.wndYuanzhengPlayer == nil then
		require("gamelogic.zbYuanzhengPlayerWnd")

		arg_160_0.wndYuanzhengPlayer = createYuanzhengPlayerWnd()

		arg_160_0.wndYuanzhengPlayer:retain()
	end

	arg_160_0.wndYuanzhengPlayer:setModel(true)
	arg_160_0.wndYuanzhengPlayer:show(arg_160_0)
	arg_160_0.wndYuanzhengPlayer:refresh(arg_160_1, arg_160_2)
end

function zbMainScene.showPubWnd(arg_161_0)
	if arg_161_0.wndPub == nil then
		require("gamelogic.zbPubWnd")

		arg_161_0.wndPub = createPubWnd()

		arg_161_0.wndPub:retain()
	end

	arg_161_0.wndPub:setModel(true)
	arg_161_0.wndPub:show(arg_161_0)
	arg_161_0.wndPub:refresh()
end

function zbMainScene.showPubGetItemWnd(arg_162_0, arg_162_1)
	if arg_162_0.wndPubGetItem == nil then
		require("gamelogic.zbPubGetItemWnd")

		arg_162_0.wndPubGetItem = createPubGetItemWnd()

		arg_162_0.wndPubGetItem:retain()
	end

	arg_162_0.wndPubGetItem:setModel(true)
	arg_162_0.wndPubGetItem:show(arg_162_0)
	arg_162_0.wndPubGetItem:refresh(arg_162_1)
end

function zbMainScene.showPubGetHeroWnd(arg_163_0, arg_163_1, arg_163_2, arg_163_3, arg_163_4, arg_163_5)
	if arg_163_0.wndPubGetHero == nil then
		require("gamelogic.zbPubGetHeroWnd")

		arg_163_0.wndPubGetHero = createPubGetHeroWnd()

		arg_163_0.wndPubGetHero:retain()
	end

	arg_163_0.wndPubGetHero:setModel(true)
	arg_163_0.wndPubGetHero:show(arg_163_0)
	arg_163_0.wndPubGetHero:refresh(arg_163_1, arg_163_2, arg_163_3, arg_163_4, arg_163_5)
end

function zbMainScene.showPubGetTenWnd(arg_164_0, arg_164_1)
	if arg_164_0.wndPubGetTen == nil then
		require("gamelogic.zbPubGetTenWnd")

		arg_164_0.wndPubGetTen = createPubGetTenWnd()

		arg_164_0.wndPubGetTen:retain()
	end

	arg_164_0.wndPubGetTen:setModel(true)
	arg_164_0.wndPubGetTen:show(arg_164_0)
	arg_164_0.wndPubGetTen:refresh(arg_164_1)
end

function zbMainScene.showGemsDecompose(arg_165_0)
	if arg_165_0.wndGemsDecompose == nil then
		require("gamelogic.zbGemsDecomposeWnd")

		arg_165_0.wndGemsDecompose = createGemsDecomposeWnd()

		arg_165_0.wndGemsDecompose:retain()
	end

	arg_165_0.wndGemsDecompose:setModel(true)
	arg_165_0.wndGemsDecompose:show(arg_165_0, true)

	return arg_165_0.wndGemsDecompose
end

function zbMainScene.showGemsDecomposeSelect(arg_166_0, arg_166_1, arg_166_2)
	if arg_166_0.wndGemsDecomposeSelect == nil then
		require("gamelogic.zbGemsDecomposeSelectWnd")

		arg_166_0.wndGemsDecomposeSelect = createGemsDecomposeSelWnd()

		arg_166_0.wndGemsDecomposeSelect:retain()
	end

	arg_166_0.wndGemsDecomposeSelect:setModel(true)
	arg_166_0.wndGemsDecomposeSelect:show(arg_166_0)
	arg_166_0.wndGemsDecomposeSelect:setSelectdList(arg_166_1, arg_166_2)
end

function zbMainScene.showDecomposeList(arg_167_0)
	if arg_167_0.wndDecomposeList == nil then
		require("gamelogic.zbDecomposeListWnd")

		arg_167_0.wndDecomposeList = createDecomposeListWnd()

		arg_167_0.wndDecomposeList:retain()
	end

	arg_167_0.wndDecomposeList:setModel(true)
	arg_167_0.wndDecomposeList:show(arg_167_0)
	arg_167_0.wndDecomposeList:refresh()
end

function zbMainScene.showEquipDecompose(arg_168_0)
	if arg_168_0.wndEquipDecompose == nil then
		require("gamelogic.zbEquipDecomposeWnd")

		arg_168_0.wndEquipDecompose = createEquipDecomposeWnd()

		arg_168_0.wndEquipDecompose:retain()
	end

	arg_168_0.wndEquipDecompose:setModel(true)
	arg_168_0.wndEquipDecompose:show(arg_168_0, true)

	return arg_168_0.wndEquipDecompose
end

function zbMainScene.showEquipDecomposeSelect(arg_169_0, arg_169_1, arg_169_2)
	if arg_169_0.wndEquipDecomposeSelect == nil then
		require("gamelogic.zbEquipDecomposeSelectWnd")

		arg_169_0.wndEquipDecomposeSelect = createEquipDecomposeSelWnd()

		arg_169_0.wndEquipDecomposeSelect:retain()
	end

	arg_169_0.wndEquipDecomposeSelect:setModel(true)
	arg_169_0.wndEquipDecomposeSelect:show(arg_169_0)
	arg_169_0.wndEquipDecomposeSelect:setSelectdList(arg_169_1, arg_169_2)
end

function zbMainScene.showEquipDecomposeSet(arg_170_0)
	if arg_170_0.zbEquipDecomposeSetWnd == nil then
		require("gamelogic.zbEquipDecomposeSetWnd")

		arg_170_0.zbEquipDecomposeSetWnd = createEquipDecomposeSetWnd()

		arg_170_0.zbEquipDecomposeSetWnd:retain()
	end

	arg_170_0.zbEquipDecomposeSetWnd:setModel(true)
	arg_170_0.zbEquipDecomposeSetWnd:show(arg_170_0)
	arg_170_0.zbEquipDecomposeSetWnd:refresh()
end

function zbMainScene.showDecomposeCountSelcetWnd(arg_171_0, arg_171_1, arg_171_2)
	if arg_171_0.wndDecomposeCountSelect == nil then
		require("gamelogic.zbDecomposeCountSelectWnd")

		arg_171_0.wndDecomposeCountSelect = createDecomposeCountSelWnd()

		arg_171_0.wndDecomposeCountSelect:retain()
	end

	arg_171_0.wndDecomposeCountSelect:setModel(true)
	arg_171_0.wndDecomposeCountSelect:show(arg_171_0)
	arg_171_0.wndDecomposeCountSelect:refresh(arg_171_1, arg_171_2)

	return arg_171_0.wndDecomposeCountSelect
end

function zbMainScene.showHeroDecompose(arg_172_0)
	if arg_172_0.wndHeroDecompose == nil then
		require("gamelogic.zbHeroDecomposeWnd")

		arg_172_0.wndHeroDecompose = createHeroDecomposeWnd()

		arg_172_0.wndHeroDecompose:retain()
	end

	arg_172_0.wndHeroDecompose:setModel(true)
	arg_172_0.wndHeroDecompose:show(arg_172_0, true)

	return arg_172_0.wndHeroDecompose
end

function zbMainScene.showHeroDecomposeHeroSelect(arg_173_0, arg_173_1)
	if arg_173_0.wndHeroDecomposeHeroSelect == nil then
		require("gamelogic.zbHeroDecomposeHeroSelectWnd")

		arg_173_0.wndHeroDecomposeHeroSelect = createHeroDecomposeHeroSelectWnd()

		arg_173_0.wndHeroDecomposeHeroSelect:retain()
	end

	arg_173_0.wndHeroDecomposeHeroSelect:setModel(true)
	arg_173_0.wndHeroDecomposeHeroSelect:show(arg_173_0)
	arg_173_0.wndHeroDecomposeHeroSelect:setSelectdList(arg_173_1)
	arg_173_0.wndHeroDecomposeHeroSelect:refresh()
end

function zbMainScene.showDecomposeHeroCountSelcetWnd(arg_174_0, arg_174_1, arg_174_2)
	if arg_174_0.wndDecomposeHeroCountSelect == nil then
		require("gamelogic.zbDecomposeHeroCountSelectWnd")

		arg_174_0.wndDecomposeHeroCountSelect = createDecomposeHeroCountSelWnd()

		arg_174_0.wndDecomposeHeroCountSelect:retain()
	end

	arg_174_0.wndDecomposeHeroCountSelect:setModel(true)
	arg_174_0.wndDecomposeHeroCountSelect:show(arg_174_0)
	arg_174_0.wndDecomposeHeroCountSelect:refresh(arg_174_1, arg_174_2)

	return arg_174_0.wndDecomposeHeroCountSelect
end

function zbMainScene.showHeroReset(arg_175_0)
	if arg_175_0.wndHeroReset == nil then
		require("gamelogic.zbHeroResetWnd")

		arg_175_0.wndHeroReset = createHeroResetWnd()

		arg_175_0.wndHeroReset:retain()
	end

	arg_175_0.wndHeroReset:setModel(true)
	arg_175_0.wndHeroReset:show(arg_175_0)
	arg_175_0.wndHeroReset:refresh()
end

function zbMainScene.showItemCountSelcetWnd(arg_176_0, arg_176_1, arg_176_2)
	if arg_176_0.wndItemCountSelect == nil then
		require("gamelogic.zbItemCountSelectWnd")

		arg_176_0.wndItemCountSelect = createItemCountSelWnd()

		arg_176_0.wndItemCountSelect:retain()
	end

	arg_176_0.wndItemCountSelect:setModel(true)
	arg_176_0.wndItemCountSelect:show(arg_176_0)
	arg_176_0.wndItemCountSelect:refresh(arg_176_1, arg_176_2)
end

function zbMainScene.showHornBuyWnd(arg_177_0)
	if arg_177_0.wndHornBuy == nil then
		require("gamelogic.zbHornBuyWnd")

		arg_177_0.wndHornBuy = createHornBuyWnd()

		arg_177_0.wndHornBuy:retain()
	end

	arg_177_0.wndHornBuy:setModel(true)
	arg_177_0.wndHornBuy:show(arg_177_0)
	arg_177_0.wndHornBuy:refresh()
end

function zbMainScene.showGodWnd(arg_178_0)
	if arg_178_0.wndGod == nil then
		require("gamelogic.zbGodWnd")

		arg_178_0.wndGod = createGodWnd()

		arg_178_0.wndGod:retain()
	end

	arg_178_0.wndGod:setModel(true)
	arg_178_0.wndGod:show(arg_178_0, true)
	arg_178_0.wndGod:refresh()
end

function zbMainScene.showGodListWnd(arg_179_0)
	if arg_179_0.wndGodList == nil then
		require("gamelogic.zbGodListWnd")

		arg_179_0.wndGodList = createGodListWnd()

		arg_179_0.wndGodList:retain()
	end

	arg_179_0.wndGodList:setModel(true)
	arg_179_0.wndGodList:show(arg_179_0)
	arg_179_0.wndGodList:refresh()
end

function zbMainScene.showGodDetailWnd(arg_180_0, arg_180_1)
	if arg_180_0.wndGodDetail == nil then
		require("gamelogic.zbGodDetailWnd")

		arg_180_0.wndGodDetail = createGodDetailWnd()

		arg_180_0.wndGodDetail:retain()
	end

	arg_180_0.wndGodDetail:setModel(true)
	arg_180_0.wndGodDetail:show(arg_180_0)
	arg_180_0.wndGodDetail:refresh(arg_180_1)

	return arg_180_0.wndGodDetail
end

function zbMainScene.startCombatTalk(arg_181_0, arg_181_1)
	if arg_181_0.wndCombatTalk == nil then
		require("gamelogic.zbCombatTalkWnd")

		arg_181_0.wndCombatTalk = createCombatTalkWnd()

		arg_181_0.wndCombatTalk:retain()
	end

	arg_181_0.wndCombatTalk:setModel(true)
	arg_181_0.wndCombatTalk:show(arg_181_0)
	arg_181_0.wndCombatTalk:start(arg_181_1)
end

function zbMainScene.roundCombatTalk(arg_182_0, arg_182_1, arg_182_2)
	if arg_182_0.wndCombatTalk == nil then
		require("gamelogic.zbCombatTalkWnd")

		arg_182_0.wndCombatTalk = createCombatTalkWnd()

		arg_182_0.wndCombatTalk:retain()
	end

	arg_182_0.wndCombatTalk:setModel(true)
	arg_182_0.wndCombatTalk:show(arg_182_0)

	return arg_182_0.wndCombatTalk:newRound(arg_182_1, arg_182_2)
end

function zbMainScene.finishCombatTalk(arg_183_0)
	if arg_183_0.wndCombatTalk == nil then
		require("gamelogic.zbCombatTalkWnd")

		arg_183_0.wndCombatTalk = createCombatTalkWnd()

		arg_183_0.wndCombatTalk:retain()
	end

	arg_183_0.wndCombatTalk:setModel(true)
	arg_183_0.wndCombatTalk:show(arg_183_0)
	arg_183_0.wndCombatTalk:finish()
end

function zbMainScene.showGodLevelUpWnd(arg_184_0)
	if arg_184_0.wndGodLevelUp == nil then
		require("gamelogic.zbGodLevelUpWnd")

		arg_184_0.wndGodLevelUp = createGodLevelUpWnd()

		arg_184_0.wndGodLevelUp:retain()
	end

	arg_184_0.wndGodLevelUp:setModel(true)
	arg_184_0.wndGodLevelUp:show(arg_184_0)
	arg_184_0.wndGodLevelUp:refresh()
end

function zbMainScene.showGodStarUpWnd(arg_185_0)
	if arg_185_0.wndGodStarUp == nil then
		require("gamelogic.zbGodStarUpWnd")

		arg_185_0.wndGodStarUp = createGodStarUpWnd()

		arg_185_0.wndGodStarUp:retain()
	end

	arg_185_0.wndGodStarUp:setModel(true)
	arg_185_0.wndGodStarUp:show(arg_185_0)
	arg_185_0.wndGodStarUp:refresh()
end

function zbMainScene.showGodSkillUpWnd(arg_186_0, arg_186_1)
	if arg_186_0.wndGodSkillUp == nil then
		require("gamelogic.zbGodSkillUpWnd")

		arg_186_0.wndGodSkillUp = createGodSkillUpWnd()

		arg_186_0.wndGodSkillUp:retain()
	end

	arg_186_0.wndGodSkillUp:setModel(true)
	arg_186_0.wndGodSkillUp:show(arg_186_0)
	arg_186_0.wndGodSkillUp:refresh(arg_186_1)
end

function zbMainScene.showEffectUIPlayWnd(arg_187_0, arg_187_1)
	if arg_187_0.wndEffectUIPlay == nil then
		require("gamelogic.zbEffectUIPlayWnd")

		arg_187_0.wndEffectUIPlay = createEffectUIPlayWnd()

		arg_187_0.wndEffectUIPlay:retain()
	end

	arg_187_0.wndEffectUIPlay:show(arg_187_0)
	arg_187_0.wndEffectUIPlay:playEffect(arg_187_1)
end

function zbMainScene.showBoxPreViewWnd(arg_188_0, arg_188_1)
	if arg_188_0.wndBoxPreView == nil then
		require("gamelogic.zbBoxPreViewWnd")

		arg_188_0.wndBoxPreView = createBoxPreView()

		arg_188_0.wndBoxPreView:retain()
	end

	arg_188_0.wndBoxPreView:setModel(true)
	arg_188_0.wndBoxPreView:show(arg_188_0)
	arg_188_0.wndBoxPreView:refresh(arg_188_1)
end

function zbMainScene.showHeroPreview(arg_189_0)
	if arg_189_0.wndHeroPreview == nil then
		require("gamelogic.zbHeroPreviewWnd")

		arg_189_0.wndHeroPreview = createHeroPreviewWnd()

		arg_189_0.wndHeroPreview:retain()
	end

	arg_189_0.wndHeroPreview:setModel(true)
	arg_189_0.wndHeroPreview:show(arg_189_0)
	arg_189_0.wndHeroPreview:refresh()

	return arg_189_0.wndHeroPreview
end

function zbMainScene.showGetWayWnd(arg_190_0, arg_190_1, arg_190_2, arg_190_3)
	if arg_190_0.wndGetWay == nil then
		require("gamelogic.zbGetWayWnd")

		arg_190_0.wndGetWay = createGetWayWnd()

		arg_190_0.wndGetWay:retain()
	end

	arg_190_0.wndGetWay:setModel(true)
	arg_190_0.wndGetWay:show(arg_190_0)
	arg_190_0.wndGetWay:refresh(arg_190_1, arg_190_2, arg_190_3)

	return arg_190_0.wndGetWay
end

function zbMainScene.showHeroGetWay(arg_191_0, arg_191_1)
	if arg_191_0.wndGetWayNewHero == nil then
		require("gamelogic.zbGetWayNewHeroWnd")

		arg_191_0.wndGetWayNewHero = createGetWayNewHeroWnd()

		arg_191_0.wndGetWayNewHero:retain()
	end

	arg_191_0.wndGetWayNewHero:setModel(true)
	arg_191_0.wndGetWayNewHero:show(arg_191_0)
	arg_191_0.wndGetWayNewHero:refresh(arg_191_1)

	return arg_191_0.wndGetWayNewHero
end

function zbMainScene.showSkillDescTips(arg_192_0, arg_192_1, arg_192_2, arg_192_3, arg_192_4)
	if arg_192_0.wndSkillDescTips == nil then
		require("gamelogic.zbSkillDescTipsWnd")

		arg_192_0.wndSkillDescTips = createSkillDescTipsWnd()

		arg_192_0.wndSkillDescTips:retain()
	end

	arg_192_0.wndSkillDescTips:setModel(true)
	arg_192_0.wndSkillDescTips:show(arg_192_0)
	arg_192_0.wndSkillDescTips:refresh(arg_192_1, arg_192_2, arg_192_3, arg_192_4)
end

function zbMainScene.showFriendBossListWnd(arg_193_0)
	if arg_193_0.wndFriendBossList == nil then
		require("gamelogic.zbFriendBossListWnd")

		arg_193_0.wndFriendBossList = createFriendBossListWnd()

		arg_193_0.wndFriendBossList:retain()
	end

	arg_193_0.wndFriendBossList:setModel(true)
	arg_193_0.wndFriendBossList:show(arg_193_0)
	arg_193_0.wndFriendBossList:refresh()

	return arg_193_0.wndFriendBossList
end

function zbMainScene.showFriendWnd(arg_194_0)
	if arg_194_0.wndFriend == nil then
		require("gamelogic.zbFriendWnd")

		arg_194_0.wndFriend = createFriendWnd()

		arg_194_0.wndFriend:retain()
	end

	arg_194_0.wndFriend:setModel(true)
	arg_194_0.wndFriend:show(arg_194_0)
	arg_194_0.wndFriend:refresh()

	return arg_194_0.wndFriend
end

function zbMainScene.showFriendInfo(arg_195_0, arg_195_1)
	if arg_195_0.wndFriendInfo == nil then
		require("gamelogic.zbFriendInfoWnd")

		arg_195_0.wndFriendInfo = createFriendInfoWnd()

		arg_195_0.wndFriendInfo:retain()
	end

	arg_195_0.wndFriendInfo:setModel(true)
	arg_195_0.wndFriendInfo:show(arg_195_0)
	arg_195_0.wndFriendInfo:refresh(arg_195_1)

	return arg_195_0.wndFriendInfo
end

function zbMainScene.showFriendBubble(arg_196_0, arg_196_1)
	if arg_196_0.wndFriendBubble == nil then
		require("gamelogic.zbFriendBubbleWnd")

		arg_196_0.wndFriendBubble = createFriendBubbleWnd()

		arg_196_0.wndFriendBubble:retain()
	end

	arg_196_0.wndFriendBubble:setModel(true)
	arg_196_0.wndFriendBubble:show(arg_196_0)
	arg_196_0.wndFriendBubble:refresh(arg_196_1)
end

function zbMainScene.showFriendJiohuWnd(arg_197_0, arg_197_1)
	if arg_197_0.wndFriendJiaohu == nil then
		require("gamelogic.zbFriendJiaohuWnd")

		arg_197_0.wndFriendJiaohu = createFriendJiaohuWnd()

		arg_197_0.wndFriendJiaohu:retain()
	end

	arg_197_0.wndFriendJiaohu:setModel(true)
	arg_197_0.wndFriendJiaohu:show(arg_197_0)
	arg_197_0.wndFriendJiaohu:refresh(arg_197_1)

	return arg_197_0.wndFriendJiaohu
end

function zbMainScene.showLegionNoWnd(arg_198_0)
	if arg_198_0.wndLegionNo == nil then
		require("gamelogic.zbLegionNoWnd")

		arg_198_0.wndLegionNo = createLegionNoWnd()

		arg_198_0.wndLegionNo:retain()
	end

	arg_198_0.wndLegionNo:setModel(true)
	arg_198_0.wndLegionNo:show(arg_198_0)
	arg_198_0.wndLegionNo:refresh()
end

function zbMainScene.showLegionIconSelWnd(arg_199_0)
	if arg_199_0.wndLegionIconSel == nil then
		require("gamelogic.zbLegionIconSelWnd")

		arg_199_0.wndLegionIconSel = createLegionIconSelWnd()

		arg_199_0.wndLegionIconSel:retain()
	end

	arg_199_0.wndLegionIconSel:setModel(true)
	arg_199_0.wndLegionIconSel:show(arg_199_0)
	arg_199_0.wndLegionIconSel:refresh()
end

function zbMainScene.showLegionJoinCdClearWnd(arg_200_0, arg_200_1)
	if arg_200_0.wndLegionJoinCdClear == nil then
		require("gamelogic.zbLegionJoinCdClearWnd")

		arg_200_0.wndLegionJoinCdClear = createLegionJoinCdClearWnd()

		arg_200_0.wndLegionJoinCdClear:retain()
	end

	arg_200_0.wndLegionJoinCdClear:setModel(true)
	arg_200_0.wndLegionJoinCdClear:show(arg_200_0)
	arg_200_0.wndLegionJoinCdClear:refresh(arg_200_1)
end

function zbMainScene.showLegionSceneWnd(arg_201_0)
	if arg_201_0.wndLegionScene == nil then
		require("gamelogic.zbLegionScene")

		arg_201_0.wndLegionScene = createLegionSceneWnd()

		arg_201_0.wndLegionScene:retain()
	end

	arg_201_0.wndLegionScene:setModel(true)
	arg_201_0.wndLegionScene:show(arg_201_0)
	arg_201_0.wndLegionScene:refresh()
end

function zbMainScene.showLegionDonateWnd(arg_202_0)
	if arg_202_0.wndLegionDonate == nil then
		require("gamelogic.zbLegionDonateWnd")

		arg_202_0.wndLegionDonate = createLegionDonateWnd()

		arg_202_0.wndLegionDonate:retain()
	end

	arg_202_0.wndLegionDonate:setModel(true)
	arg_202_0.wndLegionDonate:show(arg_202_0)
	arg_202_0.wndLegionDonate:refresh()
end

function zbMainScene.showChangeLegionSignWnd(arg_203_0)
	if arg_203_0.wndChangeLegionSign == nil then
		require("gamelogic.zbChangeLegionSignWnd")

		arg_203_0.wndChangeLegionSign = createChangeLegionSignWnd()

		arg_203_0.wndChangeLegionSign:retain()
	end

	arg_203_0.wndChangeLegionSign:setModel(true)
	arg_203_0.wndChangeLegionSign:show(arg_203_0)
	arg_203_0.wndChangeLegionSign:refresh()
end

function zbMainScene.showLegionMemberWnd(arg_204_0)
	if arg_204_0.wndLegionMem == nil then
		require("gamelogic.zbLegionMemberWnd")

		arg_204_0.wndLegionMem = createLegionMemWnd()

		arg_204_0.wndLegionMem:retain()
	end

	arg_204_0.wndLegionMem:setModel(true)
	arg_204_0.wndLegionMem:show(arg_204_0)
	arg_204_0.wndLegionMem:refresh()
end

function zbMainScene.showLegionLimitSetWnd(arg_205_0)
	if arg_205_0.wndLegionLimitSet == nil then
		require("gamelogic.zbLegionLimitedWnd")

		arg_205_0.wndLegionLimitSet = createLegionLimitedWnd()

		arg_205_0.wndLegionLimitSet:retain()
	end

	arg_205_0.wndLegionLimitSet:setModel(true)
	arg_205_0.wndLegionLimitSet:show(arg_205_0)
	arg_205_0.wndLegionLimitSet:refresh()
end

function zbMainScene.showLegionMemInfo(arg_206_0, arg_206_1)
	if arg_206_0.wndLegionMemInfo == nil then
		require("gamelogic.zbLegionMemInfoWnd")

		arg_206_0.wndLegionMemInfo = createLegionMemInfoWnd()

		arg_206_0.wndLegionMemInfo:retain()
	end

	arg_206_0.wndLegionMemInfo:setModel(true)
	arg_206_0.wndLegionMemInfo:show(arg_206_0)
	arg_206_0.wndLegionMemInfo:refresh(arg_206_1)

	return arg_206_0.wndLegionMemInfo
end

function zbMainScene.showLegionMemMgr(arg_207_0, arg_207_1)
	if arg_207_0.wndLegionMemMgr == nil then
		require("gamelogic.zbLegionMemberManage")

		arg_207_0.wndLegionMemMgr = createLegionMemManageWnd()

		arg_207_0.wndLegionMemMgr:retain()
	end

	arg_207_0.wndLegionMemMgr:setModel(true)
	arg_207_0.wndLegionMemMgr:show(arg_207_0)
	arg_207_0.wndLegionMemMgr:refresh(arg_207_1)

	return arg_207_0.wndLegionMemMgr
end

function zbMainScene.showLegionLuckyCat(arg_208_0)
	if arg_208_0.wndLegionLuckyCat == nil then
		require("gamelogic.zbLegionLuckyCatWnd")

		arg_208_0.wndLegionLuckyCat = createLegionLuckyCatWnd()

		arg_208_0.wndLegionLuckyCat:retain()
	end

	arg_208_0.wndLegionLuckyCat:setModel(true)
	arg_208_0.wndLegionLuckyCat:show(arg_208_0)
	arg_208_0.wndLegionLuckyCat:refresh()

	return arg_208_0.wndLegionLuckyCat
end

function zbMainScene.showLegionParty(arg_209_0)
	if arg_209_0.wndLegionParty == nil then
		require("gamelogic.zbLegionPartyWnd")

		arg_209_0.wndLegionParty = createLegionPartyWnd()

		arg_209_0.wndLegionParty:retain()
	end

	arg_209_0.wndLegionParty:setModel(true)
	arg_209_0.wndLegionParty:show(arg_209_0)
	arg_209_0.wndLegionParty:refresh()

	return arg_209_0.wndLegionParty
end

function zbMainScene.showLegionLog(arg_210_0, arg_210_1, arg_210_2)
	if arg_210_0.wndLegionLog == nil then
		require("gamelogic.zbLegionPartyLogWnd")

		arg_210_0.wndLegionLog = createLegionPartyLogWnd()

		arg_210_0.wndLegionLog:retain()
	end

	arg_210_0.wndLegionLog:setModel(true)
	arg_210_0.wndLegionLog:show(arg_210_0)
	arg_210_0.wndLegionLog:refresh(arg_210_1, arg_210_2)

	return arg_210_0.wndLegionLog
end

function zbMainScene.showLegionHeroTrainSelect(arg_211_0, arg_211_1)
	if arg_211_0.wndLegionHeroTrainSelect == nil then
		require("gamelogic.zbLegionHeroTrainSelectWnd")

		arg_211_0.wndLegionHeroTrainSelect = createLegionHeroTrainSelectWnd()

		arg_211_0.wndLegionHeroTrainSelect:retain()
	end

	arg_211_0.wndLegionHeroTrainSelect:setModel(true)
	arg_211_0.wndLegionHeroTrainSelect:show(arg_211_0)
	arg_211_0.wndLegionHeroTrainSelect:refresh(arg_211_1)

	return arg_211_0.wndLegionHeroTrainSelect
end

function zbMainScene.showLegionHeroTrain(arg_212_0)
	if arg_212_0.wndLegionHeroTrain == nil then
		require("gamelogic.zbLegionHeroTrainWnd")

		arg_212_0.wndLegionHeroTrain = createLegionHeroTrainWnd()

		arg_212_0.wndLegionHeroTrain:retain()
	end

	arg_212_0.wndLegionHeroTrain:setModel(true)
	arg_212_0.wndLegionHeroTrain:show(arg_212_0)
	arg_212_0.wndLegionHeroTrain:refresh()

	return arg_212_0.wndLegionHeroTrain
end

function zbMainScene.showLegionWelfare(arg_213_0)
	if arg_213_0.wndLegionWelfare == nil then
		require("gamelogic.zbLegionWelfareWnd")

		arg_213_0.wndLegionWelfare = createLegionWelfareWnd()

		arg_213_0.wndLegionWelfare:retain()
	end

	arg_213_0.wndLegionWelfare:setModel(true)
	arg_213_0.wndLegionWelfare:show(arg_213_0)
	arg_213_0.wndLegionWelfare:refresh()
end

function zbMainScene.showLegionBless(arg_214_0)
	if arg_214_0.wndLegionBless == nil then
		require("gamelogic.zbLegionBlessWnd")

		arg_214_0.wndLegionBless = createLegionBlessWnd()

		arg_214_0.wndLegionBless:retain()
	end

	arg_214_0.wndLegionBless:setModel(true)
	arg_214_0.wndLegionBless:show(arg_214_0)
	arg_214_0.wndLegionBless:refresh()
end

function zbMainScene.showLegionBoss(arg_215_0)
	if arg_215_0.wndLegionBoss == nil then
		require("gamelogic.zbLegionBossWnd")

		arg_215_0.wndLegionBoss = createLegionBossWnd()

		arg_215_0.wndLegionBoss:retain()
	end

	arg_215_0.wndLegionBoss:setModel(true)
	arg_215_0.wndLegionBoss:show(arg_215_0)
	arg_215_0.wndLegionBoss:refresh()
end

function zbMainScene.showLegionBossHalo(arg_216_0)
	if arg_216_0.wndLegionBossHalo == nil then
		require("gamelogic.zbLegionBossHaloWnd")

		arg_216_0.wndLegionBossHalo = createLegionBossHaloWnd()

		arg_216_0.wndLegionBossHalo:retain()
	end

	arg_216_0.wndLegionBossHalo:setModel(true)
	arg_216_0.wndLegionBossHalo:show(arg_216_0)
	arg_216_0.wndLegionBossHalo:refresh()
end

function zbMainScene.showLegionBossDamageRank(arg_217_0, arg_217_1)
	if arg_217_0.wndLegionBossDamageRank == nil then
		require("gamelogic.zbLegionBossDamageRankWnd")

		arg_217_0.wndLegionBossDamageRank = createLegionBossDamageRankWnd()

		arg_217_0.wndLegionBossDamageRank:retain()
	end

	arg_217_0.wndLegionBossDamageRank:setModel(true)
	arg_217_0.wndLegionBossDamageRank:show(arg_217_0)
	arg_217_0.wndLegionBossDamageRank:refresh(arg_217_1)
end

function zbMainScene.showLegionRed(arg_218_0)
	if arg_218_0.wndLegionRed == nil then
		require("gamelogic.zbLegionRedWnd")

		arg_218_0.wndLegionRed = createLegionRedWnd()

		arg_218_0.wndLegionRed:retain()
	end

	arg_218_0.wndLegionRed:setModel(true)
	arg_218_0.wndLegionRed:show(arg_218_0)
	arg_218_0.wndLegionRed:refresh()
end

function zbMainScene.showLegionRedRank(arg_219_0, arg_219_1)
	if arg_219_0.wndLegionRedRank == nil then
		require("gamelogic.zbLegionRedRankWnd")

		arg_219_0.wndLegionRedRank = createLegionRedRankWnd()

		arg_219_0.wndLegionRedRank:retain()
	end

	arg_219_0.wndLegionRedRank:setModel(true)
	arg_219_0.wndLegionRedRank:show(arg_219_0)
	arg_219_0.wndLegionRedRank:refresh(arg_219_1)
end

function zbMainScene.showLegionDonateOpe(arg_220_0)
	if arg_220_0.wndLegionDonateOpe == nil then
		require("gamelogic.zbLegionDonateOpeWnd")

		arg_220_0.wndLegionDonateOpe = createLegionDonateOpeWnd()

		arg_220_0.wndLegionDonateOpe:retain()
	end

	arg_220_0.wndLegionDonateOpe:setModel(true)
	arg_220_0.wndLegionDonateOpe:show(arg_220_0)
	arg_220_0.wndLegionDonateOpe:refresh()

	return arg_220_0.wndLegionDonateOpe
end

function zbMainScene.showLegionDonateOther(arg_221_0, arg_221_1)
	if arg_221_0.wndLegionDonateOther == nil then
		require("gamelogic.zbLegionDonateOtherWnd")

		arg_221_0.wndLegionDonateOther = createLegionDonateOtherWnd()

		arg_221_0.wndLegionDonateOther:retain()
	end

	arg_221_0.wndLegionDonateOther:setModel(true)
	arg_221_0.wndLegionDonateOther:show(arg_221_0)
	arg_221_0.wndLegionDonateOther:refresh(arg_221_1)

	return arg_221_0.wndLegionDonateOther
end

function zbMainScene.showWorldRobInfoWnd(arg_222_0, arg_222_1)
	if arg_222_0.wndWorldRobInfo == nil then
		require("gamelogic.zbWorldRobInfoWnd")

		arg_222_0.wndWorldRobInfo = createWorldRobInfoWnd()

		arg_222_0.wndWorldRobInfo:retain()
	end

	arg_222_0.wndWorldRobInfo:setModel(true)
	arg_222_0.wndWorldRobInfo:show(arg_222_0)
	arg_222_0.wndWorldRobInfo:refresh(arg_222_1)
end

function zbMainScene.showWorldBoxWnd(arg_223_0, arg_223_1)
	if arg_223_0.wndWorldBox == nil then
		require("gamelogic.zbWorldBoxWnd")

		arg_223_0.wndWorldBox = createWorldBoxWnd()

		arg_223_0.wndWorldBox:retain()
	end

	arg_223_0.wndWorldBox:setModel(true)
	arg_223_0.wndWorldBox:show(arg_223_0)
	arg_223_0.wndWorldBox:refresh(arg_223_1)
end

function zbMainScene.showWorldGameWnd(arg_224_0, arg_224_1)
	if arg_224_0.wndWorldGame == nil then
		require("gamelogic.zbWorldGameWnd")

		arg_224_0.wndWorldGame = createWorldGameWnd()

		arg_224_0.wndWorldGame:retain()
	end

	arg_224_0.wndWorldGame:setModel(true)
	arg_224_0.wndWorldGame:show(arg_224_0)
	arg_224_0.wndWorldGame:refresh(arg_224_1)
end

function zbMainScene.showWorldResWnd(arg_225_0, arg_225_1)
	if arg_225_0.wndWorldRes == nil then
		require("gamelogic.zbWorldResWnd")

		arg_225_0.wndWorldRes = createWorldResWnd()

		arg_225_0.wndWorldRes:retain()
	end

	arg_225_0.wndWorldRes:setModel(true)
	arg_225_0.wndWorldRes:show(arg_225_0)
	arg_225_0.wndWorldRes:refresh(arg_225_1)
end

function zbMainScene.showWorldResInfoWnd(arg_226_0, arg_226_1)
	if arg_226_0.wndWorldResInfo == nil then
		require("gamelogic.zbWorldResInfoWnd")

		arg_226_0.wndWorldResInfo = createWorldResInfoWnd()

		arg_226_0.wndWorldResInfo:retain()
	end

	arg_226_0.wndWorldResInfo:setModel(true)
	arg_226_0.wndWorldResInfo:show(arg_226_0)
	arg_226_0.wndWorldResInfo:refresh(arg_226_1)
end

function zbMainScene.showCDClearWnd(arg_227_0, arg_227_1)
	if arg_227_0.wndCDClear == nil then
		require("gamelogic.zbCDClearWnd")

		arg_227_0.wndCDClear = createCDClearWnd()

		arg_227_0.wndCDClear:retain()
	end

	arg_227_0.wndCDClear:setModel(true)
	arg_227_0.wndCDClear:show(arg_227_0)
	arg_227_0.wndCDClear:refresh(arg_227_1)
end

function zbMainScene.showWorldTaskWnd(arg_228_0, arg_228_1)
	if arg_228_0.wndWorldTask == nil then
		require("gamelogic.zbWorldTaskWnd")

		arg_228_0.wndWorldTask = createWorldTaskWnd()

		arg_228_0.wndWorldTask:retain()
	end

	arg_228_0.wndWorldTask:setModel(true)
	arg_228_0.wndWorldTask:show(arg_228_0)
	arg_228_0.wndWorldTask:refresh(arg_228_1)
end

function zbMainScene.showWorldTaskSetWnd(arg_229_0, arg_229_1)
	if arg_229_0.wndWorldTaskSet == nil then
		require("gamelogic.zbWorldTaskSetWnd")

		arg_229_0.wndWorldTaskSet = createWorldTaskSetWnd()

		arg_229_0.wndWorldTaskSet:retain()
	end

	arg_229_0.wndWorldTaskSet:setModel(true)
	arg_229_0.wndWorldTaskSet:show(arg_229_0)
	arg_229_0.wndWorldTaskSet:refresh(arg_229_1)

	return arg_229_0.wndWorldTaskSet
end

function zbMainScene.showWorldHeroSelectWnd(arg_230_0)
	if arg_230_0.wndWorldHeroSelect == nil then
		require("gamelogic.zbWorldHeroSelectWnd")

		arg_230_0.wndWorldHeroSelect = createWorldHeroSelectWnd()

		arg_230_0.wndWorldHeroSelect:retain()
	end

	arg_230_0.wndWorldHeroSelect:setModel(true)
	arg_230_0.wndWorldHeroSelect:show(arg_230_0)
	arg_230_0.wndWorldHeroSelect:refresh()

	return arg_230_0.wndWorldHeroSelect
end

function zbMainScene.showWorldYuanZheng(arg_231_0)
	if arg_231_0.wndWorldYuanZheng == nil then
		require("gamelogic.zbWorldYuanZhengWnd")

		arg_231_0.wndWorldYuanZheng = createWorldYuanZhengWnd()

		arg_231_0.wndWorldYuanZheng:retain()
	end

	arg_231_0.wndWorldYuanZheng:setModel(true)
	arg_231_0.wndWorldYuanZheng:show(arg_231_0)
	arg_231_0.wndWorldYuanZheng:refresh()
end

function zbMainScene.showWorld(arg_232_0)
	if arg_232_0.wndWorld == nil then
		require("gamelogic.zbWorld")

		arg_232_0.wndWorld = createWorldWnd()

		arg_232_0.wndWorld:retain()
	end

	arg_232_0.wndWorld:show(arg_232_0)
end

function zbMainScene.showWorldBoss(arg_233_0)
	if arg_233_0.wndWorldBoss == nil then
		require("gamelogic.zbWorldBossWnd")

		arg_233_0.wndWorldBoss = createWorldBossWnd()

		arg_233_0.wndWorldBoss:retain()
	end

	arg_233_0.wndWorldBoss:setModel(true)
	arg_233_0.wndWorldBoss:show(arg_233_0)
	arg_233_0.wndWorldBoss:refresh()
end

function zbMainScene.showWorldBossInspire(arg_234_0)
	if arg_234_0.wndWorldBossInspire == nil then
		require("gamelogic.zbWorldBossInspireWnd")

		arg_234_0.wndWorldBossInspire = createWorldBossInspireWnd()

		arg_234_0.wndWorldBossInspire:retain()
	end

	arg_234_0.wndWorldBossInspire:setModel(true)
	arg_234_0.wndWorldBossInspire:show(arg_234_0)
	arg_234_0.wndWorldBossInspire:refresh()
end

function zbMainScene.showWorldBossAward(arg_235_0)
	if arg_235_0.wndWorldBossAward == nil then
		require("gamelogic.zbWorldBossAwardWnd")

		arg_235_0.wndWorldBossAward = createWorldBossAwardWnd()

		arg_235_0.wndWorldBossAward:retain()
	end

	arg_235_0.wndWorldBossAward:setModel(true)
	arg_235_0.wndWorldBossAward:show(arg_235_0)
	arg_235_0.wndWorldBossAward:refresh()
end

function zbMainScene.showWorldBossRank(arg_236_0, arg_236_1)
	if arg_236_0.wndWorldBossRank == nil then
		require("gamelogic.zbWorldBossRankWnd")

		arg_236_0.wndWorldBossRank = createWorldBossRankWnd()

		arg_236_0.wndWorldBossRank:retain()
	end

	arg_236_0.wndWorldBossRank:setModel(true)
	arg_236_0.wndWorldBossRank:show(arg_236_0)
	arg_236_0.wndWorldBossRank:refresh(arg_236_1)
end

function zbMainScene.showRoleWnd(arg_237_0)
	if arg_237_0.wndRole == nil then
		require("gamelogic.zbRoleWnd")

		arg_237_0.wndRole = createRoleWnd()

		arg_237_0.wndRole:retain()
	end

	arg_237_0.wndRole:setModel(true)
	arg_237_0.wndRole:show(arg_237_0)
	arg_237_0.wndRole:refresh()
end

function zbMainScene.showRoleCreateWnd(arg_238_0, arg_238_1)
	if arg_238_0.wndRoleCreate == nil then
		require("gamelogic.zbRoleCreateWnd")

		arg_238_0.wndRoleCreate = createRoleCreateWnd()

		arg_238_0.wndRoleCreate:retain()
	end

	arg_238_0.wndRoleCreate:setModel(true)
	arg_238_0.wndRoleCreate:show(arg_238_0)
	arg_238_0.wndRoleCreate:refresh(arg_238_1)
end

function zbMainScene.showWorldLeftResWnd(arg_239_0, arg_239_1)
	if arg_239_0.wndWorldLeftRes == nil then
		require("gamelogic.zbWorldLeftResWnd")

		arg_239_0.wndWorldLeftRes = createWorldLeftResWnd()

		arg_239_0.wndWorldLeftRes:retain()
	end

	arg_239_0.wndWorldLeftRes:setModel(true)
	arg_239_0.wndWorldLeftRes:show(arg_239_0)
	arg_239_0.wndWorldLeftRes:refresh(arg_239_1)
end

function zbMainScene.showLockTipWnd(arg_240_0, arg_240_1)
	if arg_240_0.wndLockTip == nil then
		require("gamelogic.zbLockTipWnd")

		arg_240_0.wndLockTip = createLockTipWnd()

		arg_240_0.wndLockTip:retain()
	end

	arg_240_0.wndLockTip:setModel(true)
	arg_240_0.wndLockTip:show(arg_240_0)
	arg_240_0.wndLockTip:refresh(arg_240_1)
end

function zbMainScene.showGuideWnd(arg_241_0)
	if arg_241_0.wndGuide == nil then
		require("gamelogic.zbGuideWnd")

		arg_241_0.wndGuide = createGuideWnd()

		arg_241_0.wndGuide:retain()
	end

	arg_241_0.wndGuide:setModel(true)
	arg_241_0.wndGuide:show(arg_241_0)
end

function zbMainScene.hideGuideWnd(arg_242_0)
	if arg_242_0.wndGuide ~= nil then
		arg_242_0.wndGuide:hide()
	end
end

function zbMainScene.showGuideTalkWnd(arg_243_0, arg_243_1, arg_243_2, arg_243_3)
	if arg_243_0.wndGuideTalk == nil then
		require("gamelogic.zbGuideTalkWnd")

		arg_243_0.wndGuideTalk = createGuideTalkWnd()

		arg_243_0.wndGuideTalk:retain()
	end

	arg_243_0.wndGuideTalk:refresh(arg_243_1, arg_243_2, arg_243_3)
end

function zbMainScene.showGuideTitleWnd(arg_244_0, arg_244_1, arg_244_2)
	if arg_244_0.wndGuideTitle == nil then
		require("gamelogic.zbGuideTitleWnd")

		arg_244_0.wndGuideTitle = createGuideTitleWnd()

		arg_244_0.wndGuideTitle:retain()
	end

	arg_244_0.wndGuideTitle:refresh(arg_244_1, arg_244_2)
end

function zbMainScene.showGuideLxhVideoWnd(arg_245_0)
	if arg_245_0.wndGuideLxhVideo == nil then
		require("gamelogic.zbGuideLxhVideoWnd")

		arg_245_0.wndGuideLxhVideo = createGuideLxhVideoWnd()

		arg_245_0.wndGuideLxhVideo:retain()
	end

	arg_245_0.wndGuideLxhVideo:setModel(true)
	arg_245_0.wndGuideLxhVideo:show(arg_245_0)
end

function zbMainScene.showGuideYeyejiaWnd(arg_246_0)
	if arg_246_0.wndGuideYeyejia == nil then
		require("gamelogic.zbGuideYeyejiaWnd")

		arg_246_0.wndGuideYeyejia = createGuideYeyeWnd()

		arg_246_0.wndGuideYeyejia:retain()
	end

	arg_246_0.wndGuideYeyejia:setModel(true)
	arg_246_0.wndGuideYeyejia:show(arg_246_0)
	arg_246_0.wndGuideYeyejia:refresh()
end

function zbMainScene.showGuideWorldVideoWnd(arg_247_0)
	if arg_247_0.wndGuideWorldVideo == nil then
		require("gamelogic.zbGuideWorldVideoWnd")

		arg_247_0.wndGuideWorldVideo = createGuideWorldVideoWnd()

		arg_247_0.wndGuideWorldVideo:retain()
	end

	arg_247_0.wndGuideWorldVideo:setModel(true)
	arg_247_0.wndGuideWorldVideo:show(arg_247_0)
end

function zbMainScene.showHeroCommentWnd(arg_248_0)
	if arg_248_0.wndHeroComment == nil then
		require("gamelogic.zbHeroCommentWnd")

		arg_248_0.wndHeroComment = createHeroCommentWnd()

		arg_248_0.wndHeroComment:retain()
	end

	arg_248_0.wndHeroComment:setModel(true)
	arg_248_0.wndHeroComment:show(arg_248_0)
	arg_248_0.wndHeroComment:refresh()
end

function zbMainScene.showHeroHandbookWnd(arg_249_0)
	if arg_249_0.wndHeroHandbook == nil then
		require("gamelogic.zbHeroHandbookWnd")

		arg_249_0.wndHeroHandbook = createHeroHandbookWnd()

		arg_249_0.wndHeroHandbook:retain()
	end

	arg_249_0.wndHeroHandbook:setModel(true)
	arg_249_0.wndHeroHandbook:show(arg_249_0, true)
	arg_249_0.wndHeroHandbook:refresh()
end

function zbMainScene.showVipBuyWnd(arg_250_0)
	if arg_250_0.wndVip == nil then
		require("gamelogic.zbVipWnd")

		arg_250_0.wndVip = createVipWnd()

		arg_250_0.wndVip:retain()
	end

	arg_250_0.wndVip:setModel(true)
	arg_250_0.wndVip:show(arg_250_0, true)
	arg_250_0.wndVip:refresh()
	arg_250_0.wndVip:showVipBuy()
end

function zbMainScene.showVipTequan(arg_251_0)
	if arg_251_0.wndVip == nil then
		require("gamelogic.zbVipWnd")

		arg_251_0.wndVip = createVipWnd()

		arg_251_0.wndVip:retain()
	end

	arg_251_0.wndVip:setModel(true)
	arg_251_0.wndVip:show(arg_251_0, true)
	arg_251_0.wndVip:refresh()
	arg_251_0.wndVip:showVipTequan()
end

function zbMainScene.showShowPubShareWnd(arg_252_0, arg_252_1)
	if arg_252_0.wndShowPubShare == nil then
		require("gamelogic.zbShowPubShareWnd")

		arg_252_0.wndShowPubShare = createShowPubShareWnd()

		arg_252_0.wndShowPubShare:retain()
	end

	arg_252_0.wndShowPubShare:setModel(true)
	arg_252_0.wndShowPubShare:show(arg_252_0)
	arg_252_0.wndShowPubShare:refresh(arg_252_1)
end

function zbMainScene.showTreasureWnd(arg_253_0, arg_253_1, arg_253_2)
	if arg_253_0.wndTreasure == nil then
		require("gamelogic.zbTreaSureWnd")

		arg_253_0.wndTreasure = createTreasureWnd()

		arg_253_0.wndTreasure:retain()
	end

	arg_253_0.wndTreasure:setModel(true)
	arg_253_0.wndTreasure:show(arg_253_0)
	arg_253_0.wndTreasure:setChapterIdAndlevel(arg_253_1, arg_253_2)
	arg_253_0.wndTreasure:refresh()
end

function zbMainScene.showTreasureTipWnd(arg_254_0, arg_254_1, arg_254_2)
	if arg_254_0.wndTreasureTip == nil then
		require("gamelogic.zbTreaSureTipWnd")

		arg_254_0.wndTreasureTip = createTreasureTipWnd()

		arg_254_0.wndTreasureTip:retain()
	end

	arg_254_0.wndTreasureTip:setModel(true)
	arg_254_0.wndTreasureTip:show(arg_254_0)
	arg_254_0.wndTreasureTip:refresh(arg_254_1, arg_254_2)
end

function zbMainScene.showTreaSureBoxView(arg_255_0, arg_255_1)
	if arg_255_0.wndTreaSureBoxView == nil then
		require("gamelogic.zbTreaSureBoxPreviewWnd")

		arg_255_0.wndTreaSureBoxView = createTreaSureBoxPreviewWnd()

		arg_255_0.wndTreaSureBoxView:retain()
	end

	arg_255_0.wndTreaSureBoxView:setModel(true)
	arg_255_0.wndTreaSureBoxView:show(arg_255_0)
	arg_255_0.wndTreaSureBoxView:refresh(arg_255_1)
end

function zbMainScene.showHeroSoulHall(arg_256_0)
	if arg_256_0.wndHeroSoulHall == nil then
		require("gamelogic.zbHeroSoulHallWnd")

		arg_256_0.wndHeroSoulHall = zbHeroSoulHallWnd:create()

		arg_256_0.wndHeroSoulHall:retain()
	end

	arg_256_0.wndHeroSoulHall:setModel(true)
	arg_256_0.wndHeroSoulHall:show(arg_256_0)
	arg_256_0.wndHeroSoulHall:refresh()

	return arg_256_0.wndHeroSoulHall
end

function zbMainScene.showHeroSoulView(arg_257_0, arg_257_1, arg_257_2)
	if arg_257_0.wndHeroSoulView == nil then
		require("gamelogic.zbHeroSoulViewWnd")

		arg_257_0.wndHeroSoulView = createHeroSoulViewWnd()

		arg_257_0.wndHeroSoulView:retain()
	end

	arg_257_0.wndHeroSoulView:setModel(true)
	arg_257_0.wndHeroSoulView:show(arg_257_0)
	arg_257_0.wndHeroSoulView:refresh(arg_257_1, arg_257_2)
end

function zbMainScene.showHeroSoulList(arg_258_0, arg_258_1, arg_258_2)
	if arg_258_0.wndHeroSoulList == nil then
		require("gamelogic.zbHeroSoulListWnd")

		arg_258_0.wndHeroSoulList = zbHeroSoulListWnd:create()

		arg_258_0.wndHeroSoulList:retain()
	end

	arg_258_0.wndHeroSoulList:setModel(true)
	arg_258_0.wndHeroSoulList:show(arg_258_0)
	arg_258_0.wndHeroSoulList:refresh(arg_258_1, arg_258_2)
end

function zbMainScene.showHeroSoulDetail(arg_259_0, arg_259_1, arg_259_2, arg_259_3)
	if arg_259_0.wndHeroSoulDetail == nil then
		require("gamelogic.zbHeroSoulDetailWnd")

		arg_259_0.wndHeroSoulDetail = zbHeroSoulDetailWnd:create()

		arg_259_0.wndHeroSoulDetail:retain()
	end

	arg_259_0.wndHeroSoulDetail:setModel(true)
	arg_259_0.wndHeroSoulDetail:show(arg_259_0)
	arg_259_0.wndHeroSoulDetail:refresh(arg_259_1, arg_259_2, arg_259_3)
end

function zbMainScene.showHeroSoulRank(arg_260_0)
	if arg_260_0.wndHeroSoulRank == nil then
		require("gamelogic.zbHeroSoulRankWnd")

		arg_260_0.wndHeroSoulRank = createHeroSoulRankWnd()

		arg_260_0.wndHeroSoulRank:retain()
	end

	arg_260_0.wndHeroSoulRank:setModel(true)
	arg_260_0.wndHeroSoulRank:show(arg_260_0)
	arg_260_0.wndHeroSoulRank:refreshDetail()
end

function zbMainScene.showLegionWarBalanceWnd(arg_261_0)
	if arg_261_0.wndLegionWarBalance == nil then
		require("gamelogic.zbLegionWarBalanceWnd")

		arg_261_0.wndLegionWarBalance = createLegionWarBalanceWnd()

		arg_261_0.wndLegionWarBalance:retain()
	end

	arg_261_0.wndLegionWarBalance:setModel(true)
	arg_261_0.wndLegionWarBalance:show(arg_261_0)
	arg_261_0.wndLegionWarBalance:refreshResultData()
end

function zbMainScene.showLegionWarDailyWnd(arg_262_0, arg_262_1)
	if arg_262_0.wndLegionWarDaily == nil then
		require("gamelogic.zbLegionWar_DailyWnd")

		arg_262_0.wndLegionWarDaily = createLegionWarDailyWnd()

		arg_262_0.wndLegionWarDaily:retain()
	end

	arg_262_0.wndLegionWarDaily:setModel(true)
	arg_262_0.wndLegionWarDaily:show(arg_262_0)
	arg_262_0.wndLegionWarDaily:refresh(arg_262_1)
end

function zbMainScene.showLegionWarPositionWnd(arg_263_0, arg_263_1)
	if arg_263_0.wndLegionWarPosition == nil then
		require("gamelogic.zbLegionWar_PositionWnd")

		arg_263_0.wndLegionWarPosition = createLegionWarPositionWnd()

		arg_263_0.wndLegionWarPosition:retain()
	end

	arg_263_0.wndLegionWarPosition:setModel(true)
	arg_263_0.wndLegionWarPosition:show(arg_263_0)
	arg_263_0.wndLegionWarPosition:gotoForce(arg_263_1)
end

function zbMainScene.showLegionWarAssignWnd(arg_264_0, arg_264_1)
	if arg_264_0.wndLegionWarAssign == nil then
		require("gamelogic.zbLegionWarAssignWnd")

		arg_264_0.wndLegionWarAssign = createLegionWarAssignWnd()

		arg_264_0.wndLegionWarAssign:retain()
	end

	arg_264_0.wndLegionWarAssign:setModel(true)
	arg_264_0.wndLegionWarAssign:show(arg_264_0)
	arg_264_0.wndLegionWarAssign:refresh(arg_264_1)

	return arg_264_0.wndLegionWarAssign
end

function zbMainScene.showLegionWarFightWnd(arg_265_0, arg_265_1, arg_265_2, arg_265_3)
	if arg_265_0.wndLegionWarFight == nil then
		require("gamelogic.zbLegionWarFightWnd")

		arg_265_0.wndLegionWarFight = createLegionWarFightWnd()

		arg_265_0.wndLegionWarFight:retain()
	end

	arg_265_0.wndLegionWarFight:setModel(true)
	arg_265_0.wndLegionWarFight:show(arg_265_0)
	arg_265_0.wndLegionWarFight:refresh(arg_265_1, arg_265_2, arg_265_3)
end

function zbMainScene.showLegionWarWnd(arg_266_0)
	if arg_266_0.wndLegionWar == nil then
		require("gamelogic.zbLegionWarWnd")

		arg_266_0.wndLegionWar = createLegionWarWnd()

		arg_266_0.wndLegionWar:retain()
	end

	arg_266_0.wndLegionWar:setModel(true)
	arg_266_0.wndLegionWar:show(arg_266_0)
	arg_266_0.wndLegionWar:refresh()
end

function zbMainScene.showLegionWarApplyWnd(arg_267_0)
	if arg_267_0.wndLegionWarApply == nil then
		require("gamelogic.zbLegionWarApplyWnd")

		arg_267_0.wndLegionWarApply = createLegionWarApplyWnd()

		arg_267_0.wndLegionWarApply:retain()
	end

	arg_267_0.wndLegionWarApply:setModel(true)
	arg_267_0.wndLegionWarApply:show(arg_267_0)
	arg_267_0.wndLegionWarApply:refresh()
end

function zbMainScene.showLegionWarEliteSetWnd(arg_268_0, arg_268_1)
	if arg_268_0.wndLegionWarEliteSet == nil then
		require("gamelogic.zbLegionWarEliteSetWnd")

		arg_268_0.wndLegionWarEliteSet = createLegionWarEliteSetWnd()

		arg_268_0.wndLegionWarEliteSet:retain()
	end

	arg_268_0.wndLegionWarEliteSet:setModel(true)
	arg_268_0.wndLegionWarEliteSet:show(arg_268_0)
	arg_268_0.wndLegionWarEliteSet:refresh(arg_268_1)
end

function zbMainScene.showLegionWarHeroWnd(arg_269_0, arg_269_1, arg_269_2)
	if arg_269_0.wndLegionWarHero == nil then
		require("gamelogic.zbLegionWarHeroWnd")

		arg_269_0.wndLegionWarHero = createLegionWarHeroWnd()

		arg_269_0.wndLegionWarHero:retain()
	end

	arg_269_0.wndLegionWarHero:setModel(true)
	arg_269_0.wndLegionWarHero:show(arg_269_0)
	arg_269_0.wndLegionWarHero:refresh(arg_269_1, arg_269_2)

	return arg_269_0.wndLegionWarHero
end

function zbMainScene.showLegionWarReportWnd(arg_270_0, arg_270_1)
	if arg_270_0.wndLegionWarReport == nil then
		require("gamelogic.zbLegionWarReportWnd")

		arg_270_0.wndLegionWarReport = createLegionWarReportWnd()

		arg_270_0.wndLegionWarReport:retain()
	end

	arg_270_0.wndLegionWarReport:setModel(true)
	arg_270_0.wndLegionWarReport:show(arg_270_0)
	arg_270_0.wndLegionWarReport:refresh(arg_270_1)
end

function zbMainScene.showLegionWarPlayerWnd(arg_271_0, arg_271_1, arg_271_2)
	if arg_271_0.wndLegionWarPlayer == nil then
		require("gamelogic.zbLegionWarPlayerWnd")

		arg_271_0.wndLegionWarPlayer = createLegionWarPlayerWnd()

		arg_271_0.wndLegionWarPlayer:retain()
	end

	arg_271_0.wndLegionWarPlayer:setModel(true)
	arg_271_0.wndLegionWarPlayer:show(arg_271_0)
	arg_271_0.wndLegionWarPlayer:refresh(arg_271_1, arg_271_2)
end

function zbMainScene.showFirstRechargeWnd(arg_272_0)
	if arg_272_0.wndFirstRecharge == nil then
		require("gamelogic.zbFirstRechargeWnd")

		arg_272_0.wndFirstRecharge = createFirstRechargeWnd()

		arg_272_0.wndFirstRecharge:retain()
	end

	arg_272_0.wndFirstRecharge:setModel(true)
	arg_272_0.wndFirstRecharge:show(arg_272_0)
	arg_272_0.wndFirstRecharge:refresh()
end

function zbMainScene.showRebateAwardWnd(arg_273_0)
	if arg_273_0.wndRebateAward == nil then
		require("gamelogic.zbRebateAwardWnd")

		arg_273_0.wndRebateAward = createRebateAwardWnd()

		arg_273_0.wndRebateAward:retain()
	end

	arg_273_0.wndRebateAward:setModel(true)
	arg_273_0.wndRebateAward:show(arg_273_0)
	arg_273_0.wndRebateAward:refresh()
end

function zbMainScene.showOnlineAwardWnd(arg_274_0)
	if arg_274_0.wndOnlineAward == nil then
		require("gamelogic.zbOnlineAwardWnd")

		arg_274_0.wndOnlineAward = createOnlineAwardWnd()

		arg_274_0.wndOnlineAward:retain()
	end

	arg_274_0.wndOnlineAward:setModel(true)
	arg_274_0.wndOnlineAward:show(arg_274_0)
	arg_274_0.wndOnlineAward:refresh()
end

function zbMainScene.showWawajiWnd(arg_275_0)
	if arg_275_0.wndWawaji == nil then
		require("gamelogic.zbWawajiWnd")

		arg_275_0.wndWawaji = createWawajiWnd()

		arg_275_0.wndWawaji:retain()
	end

	arg_275_0.wndWawaji:setModel(true)
	arg_275_0.wndWawaji:show(arg_275_0)
	arg_275_0.wndWawaji:refresh()
end
