local var_0_0 = class("zbMainWnd_Shortcut")

var_0_0.__index = var_0_0

function createMainWndShortcut(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	local function var_2_0()
		arg_2_0.parentWnd = arg_2_1
		arg_2_0.btnNode = {}
	end

	local function var_2_1()
		local function var_4_0(arg_5_0)
			local var_5_0 = CCSprite:create(NOTIFY_TAG_PATH)

			var_5_0:setAnchorPoint(ccp(0.5, 0.5))
			var_5_0:setPosition(arg_5_0:getContentSize().width / 2 + 25, arg_5_0:getContentSize().height / 2 + 25)
			var_5_0:setVisible(false)
			arg_5_0:addChild(var_5_0)
			zbUIEffect:createNotifyTagScaleAction(var_5_0)

			return var_5_0
		end

		arg_2_0.node = arg_2_2
		arg_2_0.btnWelfare = tolua.cast(arg_2_2:getChildByTag(1), "CCControlButton")
		arg_2_0.btnGmActivity = tolua.cast(arg_2_2:getChildByTag(2), "CCControlButton")
		arg_2_0.nodeSeven = tolua.cast(arg_2_2:getChildByTag(3), "CCNode")
		arg_2_0.lbSeven = tolua.cast(arg_2_0.nodeSeven:getChildByTag(0), "CCLabelTTF")
		arg_2_0.btnSeven = tolua.cast(arg_2_0.nodeSeven:getChildByTag(1), "CCControlButton")
		arg_2_0.btnFriendBoss = tolua.cast(arg_2_2:getChildByTag(4), "CCControlButton")
		arg_2_0.btnLuckCat = tolua.cast(arg_2_2:getChildByTag(5), "CCControlButton")
		arg_2_0.btnLimitHero = tolua.cast(arg_2_2:getChildByTag(6), "CCControlButton")
		arg_2_0.btnRechargeSum = tolua.cast(arg_2_2:getChildByTag(7), "CCControlButton")
		arg_2_0.btnRechargeDaily = tolua.cast(arg_2_2:getChildByTag(8), "CCControlButton")
		arg_2_0.btnRechargeSingle = tolua.cast(arg_2_2:getChildByTag(9), "CCControlButton")
		arg_2_0.btnFund = tolua.cast(arg_2_2:getChildByTag(10), "CCControlButton")
		arg_2_0.btnLimitShop = tolua.cast(arg_2_2:getChildByTag(11), "CCControlButton")
		arg_2_0.btnConsumSum = tolua.cast(arg_2_2:getChildByTag(12), "CCControlButton")
		arg_2_0.btnCard = tolua.cast(arg_2_2:getChildByTag(13), "CCControlButton")
		arg_2_0.btnCharge = tolua.cast(arg_2_2:getChildByTag(14), "CCControlButton")
		arg_2_0.btnChargeComm = tolua.cast(arg_2_2:getChildByTag(15), "CCControlButton")
		arg_2_0.btnRebate = tolua.cast(arg_2_2:getChildByTag(16), "CCControlButton")

		arg_2_0.btnWelfare:addHandleOfControlEvent(function()
			arg_2_0:onWelfare()
		end, CCControlEventTouchUpInside)
		arg_2_0.btnGmActivity:addHandleOfControlEvent(function()
			arg_2_0:onGmActivity()
		end, CCControlEventTouchUpInside)
		arg_2_0.btnSeven:addHandleOfControlEvent(function()
			arg_2_0:onSeven()
		end, CCControlEventTouchUpInside)
		arg_2_0.btnFriendBoss:addHandleOfControlEvent(function()
			arg_2_0:onFriendBoss()
		end, CCControlEventTouchUpInside)
		arg_2_0.btnLuckCat:addHandleOfControlEvent(function()
			arg_2_0:onLuckCat()
		end, CCControlEventTouchUpInside)
		arg_2_0.btnLimitHero:addHandleOfControlEvent(function()
			arg_2_0:onLimitHero()
		end, CCControlEventTouchUpInside)
		arg_2_0.btnRechargeSum:addHandleOfControlEvent(function()
			arg_2_0:onRechargeSum()
		end, CCControlEventTouchUpInside)
		arg_2_0.btnRechargeDaily:addHandleOfControlEvent(function()
			arg_2_0:onRechargeDaily()
		end, CCControlEventTouchUpInside)
		arg_2_0.btnRechargeSingle:addHandleOfControlEvent(function()
			arg_2_0:onRechargeSingle()
		end, CCControlEventTouchUpInside)
		arg_2_0.btnFund:addHandleOfControlEvent(function()
			arg_2_0:onFund()
		end, CCControlEventTouchUpInside)
		arg_2_0.btnLimitShop:addHandleOfControlEvent(function()
			arg_2_0:onLimitShop()
		end, CCControlEventTouchUpInside)
		arg_2_0.btnConsumSum:addHandleOfControlEvent(function()
			arg_2_0:onConsumSum()
		end, CCControlEventTouchUpInside)
		arg_2_0.btnCard:addHandleOfControlEvent(function()
			arg_2_0:onCard()
		end, CCControlEventTouchUpInside)
		arg_2_0.btnCharge:addHandleOfControlEvent(function()
			arg_2_0:onCharge()
		end, CCControlEventTouchUpInside)
		arg_2_0.btnChargeComm:addHandleOfControlEvent(function()
			arg_2_0:onChargeComm()
		end, CCControlEventTouchUpInside)
		arg_2_0.btnRebate:addHandleOfControlEvent(function()
			arg_2_0:onRebate()
		end, CCControlEventTouchUpInside)

		arg_2_0.notifyWelfare = var_4_0(arg_2_0.btnWelfare)
		arg_2_0.notifyGmActivity = var_4_0(arg_2_0.btnGmActivity)
		arg_2_0.notifySeven = var_4_0(arg_2_0.btnSeven)
		arg_2_0.notifyFriendBoss = var_4_0(arg_2_0.btnFriendBoss)
		arg_2_0.notifyLimitHero = var_4_0(arg_2_0.btnLimitHero)
		arg_2_0.notifyRechargeSum = var_4_0(arg_2_0.btnRechargeSum)
		arg_2_0.notifyRechargeDaily = var_4_0(arg_2_0.btnRechargeDaily)
		arg_2_0.notifyRechargeSingle = var_4_0(arg_2_0.btnRechargeSingle)
		arg_2_0.notifyConsumSum = var_4_0(arg_2_0.btnConsumSum)
		arg_2_0.notifyCard = var_4_0(arg_2_0.btnCard)
		arg_2_0.notifyCharge = var_4_0(arg_2_0.btnCharge)
		arg_2_0.btnNode[1] = arg_2_0.btnWelfare
		arg_2_0.btnNode[2] = arg_2_0.btnGmActivity
		arg_2_0.btnNode[3] = arg_2_0.nodeSeven
		arg_2_0.btnNode[4] = arg_2_0.btnFriendBoss
		arg_2_0.btnNode[5] = arg_2_0.btnLuckCat
		arg_2_0.btnNode[6] = arg_2_0.btnLimitHero
		arg_2_0.btnNode[7] = arg_2_0.btnRechargeSum
		arg_2_0.btnNode[8] = arg_2_0.btnRechargeDaily
		arg_2_0.btnNode[9] = arg_2_0.btnRechargeSingle
		arg_2_0.btnNode[10] = arg_2_0.btnFund
		arg_2_0.btnNode[11] = arg_2_0.btnLimitShop
		arg_2_0.btnNode[12] = arg_2_0.btnConsumSum
		arg_2_0.btnNode[13] = arg_2_0.btnCard
		arg_2_0.btnNode[14] = arg_2_0.btnCharge
		arg_2_0.btnNode[15] = arg_2_0.btnChargeComm
		arg_2_0.btnNode[16] = arg_2_0.btnRebate

		arg_2_0:setBtnChargeEffect(arg_2_0.btnCharge)
		arg_2_0:setBtnChargeEffect(arg_2_0.btnChargeComm)
		arg_2_0:setBtnChargeEffect(arg_2_0.btnRebate)
	end

	var_2_0()
	var_2_1()
end

function var_0_0.onWelfare(arg_22_0)
	if zbFunHelper:isLockAndTip(EFuncType.Activity) then
		return
	end

	g_MainScene:showActivityWnd()
end

function var_0_0.onGmActivity(arg_23_0)
	g_MainScene:showGmActivityWnd()
end

function var_0_0.onSeven(arg_24_0)
	g_MainScene:showSevenWnd()
end

function var_0_0.onFriendBoss(arg_25_0)
	if zbFunHelper:isLockAndTip(EFuncType.FriendsBoss) then
		return
	end

	g_WsMsgHandler:WS_FriendsBoss_GetInfo_Req(true)
end

function var_0_0.onLimitHero(arg_26_0)
	g_MainScene:showGmActivityWnd(GMTAB_LIMITHERO)
end

function var_0_0.onRechargeSum(arg_27_0)
	g_MainScene:showGmActivityWnd(GMTAB_RECHARGESUM)
end

function var_0_0.onRechargeDaily(arg_28_0)
	g_MainScene:showGmActivityWnd(GMTAB_RECHARGEDAILY)
end

function var_0_0.onRechargeSingle(arg_29_0)
	g_MainScene:showGmActivityWnd(GMTAB_RECHARGESINGLE)
end

function var_0_0.onFund(arg_30_0)
	g_MainScene:showGmActivityWnd(GMTAB_FUND)
end

function var_0_0.onLimitShop(arg_31_0)
	g_MainScene:showGmActivityWnd(GMTAB_LIMITSHOP)
end

function var_0_0.onConsumSum(arg_32_0)
	g_MainScene:showGmActivityWnd(GMTAB_CONSUMSUM)
end

function var_0_0.onCard(arg_33_0)
	g_MainScene:showActivityWnd(EActivityType.Card)
end

function var_0_0.onLuckCat(arg_34_0)
	g_MainScene:showActivityWnd(EActivityType.LuckCat)
end

function var_0_0.onCharge(arg_35_0)
	g_MainScene:showFirstRechargeWnd()
end

function var_0_0.onChargeComm(arg_36_0)
	g_MainScene:showVipBuyWnd()
end

function var_0_0.onRebate(arg_37_0)
	g_MainScene:showRebateAwardWnd()
end

function var_0_0.onFrameUpdate(arg_38_0)
	if g_GameStateMachine:isOneSecondPassed() then
		arg_38_0:refreshDetail()
	end
end

function var_0_0.refresh(arg_39_0)
	arg_39_0:refreshDetail()
end

function var_0_0.refreshDetail(arg_40_0)
	arg_40_0.notifyWelfare:setVisible(g_Self.kGiftHandler:hasGift())
	arg_40_0.notifyGmActivity:setVisible(g_Self.kGmActivityHandler:hasGmActivityGift())
	arg_40_0.notifySeven:setVisible(g_Self.kSevenHandler:hasSevenGift())
	arg_40_0.notifyFriendBoss:setVisible(g_Self.kFriendHandler.haveNewFriendBoss == true)
	arg_40_0.notifyLimitHero:setVisible(g_Self.kGmActivityHandler:getTimeHeroGift() ~= false)
	arg_40_0.notifyRechargeSum:setVisible(g_Self.kGmActivityHandler:getRechargeSumGift() ~= false)
	arg_40_0.notifyRechargeDaily:setVisible(g_Self.kGmActivityHandler:getRechargeDailyGift() ~= false)
	arg_40_0.notifyRechargeSingle:setVisible(g_Self.kGmActivityHandler:getRechargeSingleGift() ~= false)
	arg_40_0.notifyConsumSum:setVisible(g_Self.kGmActivityHandler:getConsumSumGift() ~= false)
	arg_40_0.notifyCharge:setVisible(g_GameData.VipInfo.FirstBuy.State == 1)
	arg_40_0.notifyCard:setVisible(g_Self.kGiftHandler:hasCardGift())
	arg_40_0.btnFriendBoss:setVisible(zbUtil:isValidTable(g_Self.kFriendHandler.bossList) == true and table.getn(g_Self.kFriendHandler.bossList) > 0)

	if g_Self.kSevenHandler:getSevenVisible() == false then
		arg_40_0.nodeSeven:setVisible(false)
	else
		arg_40_0.nodeSeven:setVisible(true)

		if g_Self.kSevenHandler:getSevenLessTime() > 86400 then
			arg_40_0.lbSeven:setString(a2u("ʣ\xD3\xE0:") .. zbUtil:getExpireTime(86400 + g_Self.kSevenHandler:getSevenLessTime()))
		elseif g_Self.kSevenHandler:getSevenLessTime() == 0 then
			arg_40_0.lbSeven:setString(a2u("\xBB\xD2ѽ\xE1\xCA\xF8"))
		else
			arg_40_0.lbSeven:setString(zbUtil:SprintfHHMMSSNo24(g_Self.kSevenHandler:getSevenLessTime()))
		end
	end

	arg_40_0.btnLuckCat:setVisible(g_Self.kGiftHandler:getBtnLuckCatVisible())

	local var_40_0 = 0

	arg_40_0.btnLimitHero:setVisible(zbUtil:isValidTable(g_GameData.ActivityGm) == true and zbUtil:isValidTable(g_GameData.ActivityGm.LimitTimeHero) == true and table.getn(g_GameData.ActivityGm.LimitTimeHero) > 0)
	arg_40_0.btnRechargeSum:setVisible(zbUtil:isValidTable(g_GameData.ActivityGm) == true and zbUtil:isValidTable(g_GameData.ActivityGm.RechargeSum) == true and table.getn(g_GameData.ActivityGm.RechargeSum) > 0)
	arg_40_0.btnRechargeDaily:setVisible(zbUtil:isValidTable(g_GameData.ActivityGm) == true and zbUtil:isValidTable(g_GameData.ActivityGm.RechargeDaily) == true and table.getn(g_GameData.ActivityGm.RechargeDaily) > 0)
	arg_40_0.btnRechargeSingle:setVisible(zbUtil:isValidTable(g_GameData.ActivityGm) == true and zbUtil:isValidTable(g_GameData.ActivityGm.RechargeSingle) == true and table.getn(g_GameData.ActivityGm.RechargeSingle) > 0)
	arg_40_0.btnFund:setVisible(zbUtil:isValidTable(g_GameData.ActivityGm) == true and zbUtil:isValidTable(g_GameData.ActivityGm.Fund) == true and g_GameData.ActivityGm.Fund.BuyState == 0)
	arg_40_0.btnLimitShop:setVisible(zbUtil:isValidTable(g_GameData.ActivityGm) == true and zbUtil:isValidTable(g_GameData.ActivityGm.LimitTimeShop) == true and table.getn(g_GameData.ActivityGm.LimitTimeShop) > 0)
	arg_40_0.btnConsumSum:setVisible(zbUtil:isValidTable(g_GameData.ActivityGm) == true and zbUtil:isValidTable(g_GameData.ActivityGm.ConsumSum) == true and table.getn(g_GameData.ActivityGm.ConsumSum) > 0)

	local var_40_1 = 0

	for iter_40_0 = 6, 12 do
		if arg_40_0.btnNode[iter_40_0]:isVisible() then
			var_40_1 = var_40_1 + 1

			if var_40_1 > 2 then
				for iter_40_1 = iter_40_0, 12 do
					arg_40_0.btnNode[iter_40_1]:setVisible(false)
				end

				break
			end
		end
	end

	arg_40_0.btnRebate:setVisible(zbUtil:isValidTable(g_GameData.ActivityAct) == true and zbUtil:isValidTable(g_GameData.ActivityAct.RebateAward) == true)
	arg_40_0.btnCharge:setVisible(arg_40_0.btnRebate:isVisible() == false and g_GameData.VipInfo.FirstBuy.State ~= 2)
	arg_40_0.btnChargeComm:setVisible(arg_40_0.btnRebate:isVisible() == false and g_GameData.VipInfo.FirstBuy.State == 2)
	arg_40_0:setShortcutMenuPos()
end

function var_0_0.isContained(arg_41_0, arg_41_1, arg_41_2)
	if zbUtil:PointInCtrl(arg_41_0.btnActivity, arg_41_1, arg_41_2) or zbUtil:PointInCtrl(arg_41_0.btnFriendBoss, arg_41_1, arg_41_2) or zbUtil:PointInCtrl(arg_41_0.btnLuckCat, arg_41_1, arg_41_2) or zbUtil:PointInCtrl(arg_41_0.btnCard, arg_41_1, arg_41_2) or zbUtil:PointInCtrl(arg_41_0.btnGmActivity, arg_41_1, arg_41_2) or arg_41_0.nodeSeven:isVisible() and zbUtil:PointInCtrl(arg_41_0.nodeSeven, arg_41_1, arg_41_2) or arg_41_0.btnWelfare:isVisible() and zbUtil:PointInCtrl(arg_41_0.btnWelfare, arg_41_1, arg_41_2) or arg_41_0.btnSeven:isVisible() and zbUtil:PointInCtrl(arg_41_0.btnSeven, arg_41_1, arg_41_2) or arg_41_0.btnCharge:isVisible() and zbUtil:PointInCtrl(arg_41_0.btnCharge, arg_41_1, arg_41_2) or arg_41_0.btnLimitHero:isVisible() and zbUtil:PointInCtrl(arg_41_0.btnLimitHero, arg_41_1, arg_41_2) or arg_41_0.btnRebate:isVisible() and zbUtil:PointInCtrl(arg_41_0.btnRebate, arg_41_1, arg_41_2) or arg_41_0.btnFund:isVisible() and zbUtil:PointInCtrl(arg_41_0.btnFund, arg_41_1, arg_41_2) or arg_41_0.btnConsumSum:isVisible() and zbUtil:PointInCtrl(arg_41_0.btnConsumSum, arg_41_1, arg_41_2) or arg_41_0.btnLimitShop:isVisible() and zbUtil:PointInCtrl(arg_41_0.btnLimitShop, arg_41_1, arg_41_2) or arg_41_0.btnRechargeSingle:isVisible() and zbUtil:PointInCtrl(arg_41_0.btnRechargeSingle, arg_41_1, arg_41_2) or arg_41_0.btnRechargeDaily:isVisible() and zbUtil:PointInCtrl(arg_41_0.btnRechargeDaily, arg_41_1, arg_41_2) or arg_41_0.btnRechargeSum:isVisible() and zbUtil:PointInCtrl(arg_41_0.btnRechargeSum, arg_41_1, arg_41_2) or arg_41_0.btnChargeComm:isVisible() and zbUtil:PointInCtrl(arg_41_0.btnChargeComm, arg_41_1, arg_41_2) then
		return true
	end

	return false
end

function var_0_0.setShortcutMenuPos(arg_42_0)
	local var_42_0 = 0

	for iter_42_0 = 1, table.getn(arg_42_0.btnNode) do
		if arg_42_0.btnNode[iter_42_0]:isVisible() then
			arg_42_0.btnNode[iter_42_0]:setPositionX(-50 - 80 * var_42_0)

			var_42_0 = var_42_0 + 1
		end
	end
end

function var_0_0.setBtnChargeEffect(arg_43_0, arg_43_1)
	if arg_43_1 then
		local var_43_0 = createUIAnimation()

		var_43_0:refresh("effect/spine/ui_chonzhiguangxiao/ui_chonzhiguangxiao.json", "effect/spine/ui_chonzhiguangxiao/ui_chonzhiguangxiao.atlas")
		var_43_0:setPosition(ccp(40, 40))
		var_43_0:setScale(0.8)
		var_43_0:setAnimation("animation", true)
		arg_43_1:addChild(var_43_0)
	end
end
