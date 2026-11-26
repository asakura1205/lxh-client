require("gamelogic.zbItem")

local var_0_0 = class("zbSevenWnd_Half")

var_0_0.__index = var_0_0

function createSevenWnd_Half(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	(function()
		arg_2_0.items = {}
		arg_2_0.day = 1
		arg_2_0.first = 1
		arg_2_0.dayInfo = nil
		arg_2_0.nodeParent = arg_2_1
		arg_2_0.btnPriority = arg_2_2
		arg_2_0.scrollEffect = {}
	end)()
end

function var_0_0.refresh(arg_4_0)
	(function()
		if arg_4_0.node ~= nil then
			return
		end

		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/seven_half.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner", true)
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_4_0.lbTime = tolua.cast(var_5_2:getChildByTag(1), "CCLabelTTF")
		arg_4_0.lbDay = tolua.cast(var_5_2:getChildByTag(2), "CCLabelTTF")
		arg_4_0.spriteLine = tolua.cast(var_5_2:getChildByTag(3), "CCSprite")
		arg_4_0.btnBuy = tolua.cast(var_5_2:getChildByTag(4), "CCControlButton")
		arg_4_0.btnLeft = tolua.cast(var_5_2:getChildByTag(5), "CCControlButton")
		arg_4_0.btnRight = tolua.cast(var_5_2:getChildByTag(6), "CCControlButton")

		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1001), "CCLabelTTF")
		local var_5_4 = tolua.cast(var_5_2:getChildByTag(1002), "CCLabelTTF")

		arg_4_0.lbVip = tolua.cast(var_5_2:getChildByTag(1003), "CCLabelTTF")

		for iter_5_0 = 1, 3 do
			local var_5_5 = tolua.cast(var_5_2:getChildByTag(iter_5_0 + 10), "CCLayer")
			local var_5_6 = createItem()

			var_5_6:setPosition(var_5_5:getPosition())
			var_5_6:setScale(0.8)
			var_5_6:setNeedTip(true)
			var_5_6:setSupportTouchDownTip(false)
			var_5_6:setSupportTouchTip(true)
			var_5_6.btnFrame:setTouchPriority(arg_4_0.btnPriority:getTouchPriority())

			arg_4_0.items[iter_5_0] = var_5_6

			var_5_2:addChild(arg_4_0.items[iter_5_0])
			var_5_5:removeFromParentAndCleanup(true)
		end

		arg_4_0.centerPositionX = arg_4_0.items[2]:getPositionX()
		arg_4_0.lbShowPrice = CCLabelAtlas:create("", "font/rank_num_red.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_3, arg_4_0.lbShowPrice)
		arg_4_0.lbShowPrice:setScale(0.6)

		arg_4_0.lbSalePrice = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_4, arg_4_0.lbSalePrice)
		arg_4_0.lbSalePrice:setScale(0.6)
		arg_4_0.spriteLine:setZOrder(ZORDER_TOP)
		arg_4_0.btnBuy:addHandleOfControlEvent(function()
			arg_4_0:onBuy()
		end, CCControlEventTouchUpInside)
		arg_4_0.btnLeft:addHandleOfControlEvent(function()
			arg_4_0:onLeft()
		end, CCControlEventTouchUpInside)
		arg_4_0.btnRight:addHandleOfControlEvent(function()
			arg_4_0:onRight()
		end, CCControlEventTouchUpInside)
		arg_4_0.btnBuy:setTouchPriority(arg_4_0.btnPriority:getTouchPriority())
		arg_4_0.btnLeft:setTouchPriority(arg_4_0.btnPriority:getTouchPriority())
		arg_4_0.btnRight:setTouchPriority(arg_4_0.btnPriority:getTouchPriority())

		arg_4_0.node = var_5_1

		arg_4_0.nodeParent:addChild(var_5_1)
	end)()

	if zbUtil:isValidTable(g_GameData.ActivityOs) == false or zbUtil:isValidTable(g_GameData.ActivityOs.HalfPacks) == false then
		return
	end

	if arg_4_0.first == 1 then
		arg_4_0.day = arg_4_0:getToDay()
		arg_4_0.first = 0
	end

	arg_4_0:refreshDetail()
end

function var_0_0.refreshDetail(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(g_GameData.ActivityOs.HalfPacks) do
		if iter_9_1.Day == arg_9_0.day then
			arg_9_0.dayInfo = iter_9_1
		end
	end

	if arg_9_0.dayInfo == nil then
		return
	end

	arg_9_0.lbDay:setString(a2u("\xB5\xDA") .. zbUtil:getNumberBig(arg_9_0.dayInfo.Day) .. a2u("\xCC\xEC"))
	arg_9_0.lbShowPrice:setString(arg_9_0.dayInfo.ShowDiamond)
	arg_9_0.lbSalePrice:setString(arg_9_0.dayInfo.SaleDiamond)
	arg_9_0.lbVip:setString(a2u("(Vip") .. arg_9_0.dayInfo.Vip .. a2u("\xBF\xC9\xD2Թ\xBA\xC2\xF2)"))
	arg_9_0.btnBuy:setGray(arg_9_0.dayInfo.State == 2)

	for iter_9_2 = 1, 3 do
		arg_9_0.items[iter_9_2]:setVisible(false)
	end

	local var_9_0 = 1

	for iter_9_3, iter_9_4 in pairs(arg_9_0.dayInfo.AwardList) do
		arg_9_0.items[var_9_0]:refreshAward(iter_9_4.Type, iter_9_4.Id, iter_9_4.Count, nil, false)
		arg_9_0.items[var_9_0].lbName:setScale(1.5)
		arg_9_0.items[var_9_0].lbName:setString("X" .. iter_9_4.Count)

		if (iter_9_4.Type == ECommonAwardType.HeroFrag or iter_9_4.Type == ECommonAwardType.Hero or iter_9_4.Type == ECommonAwardType.Diamond or iter_9_4.Type == ECommonAwardType.BarMoney or iter_9_4.Type == ECommonAwardType.EquipFrag and zbItemTable:getItemQuality(iter_9_4.Id) > EItemQuality.Golden or iter_9_4.Type == ECommonAwardType.Item and zbItemTable:getItemType(iter_9_4.Id) == EItemType.Equip and zbItemTable:getItemQuality(iter_9_4.Id) > EItemQuality.Purple or zbItemTable:getItemQuality(iter_9_4.Id) > EItemQuality.Golden) and arg_9_0.scrollEffect[var_9_0] == nil then
			arg_9_0.scrollEffect[var_9_0] = g_EffectSystem:creatScrollEffect(arg_9_0.items[var_9_0], iter_9_4.Type)

			arg_9_0.scrollEffect[var_9_0]:setAnimation("animation", true)
		end

		arg_9_0.items[var_9_0]:setVisible(true)

		var_9_0 = var_9_0 + 1
	end

	zbUIEffect:centerStar(arg_9_0.items, arg_9_0.centerPositionX)
end

function var_0_0.onBuy(arg_10_0)
	if g_Self:getVipLevel() < arg_10_0.dayInfo.Vip then
		g_Bubble:bubbleInfo(a2u("(Vip") .. arg_10_0.dayInfo.Vip .. a2u("\xBF\xC9\xD2Թ\xBA\xC2\xF2)"))

		return
	end

	if arg_10_0.dayInfo.State == 2 then
		g_Bubble:bubbleInfo(a2u("\xD2ѹ\xBA\xC2\xF2"))

		return
	end

	if arg_10_0.dayInfo.State == 0 then
		g_Bubble:bubbleInfo(a2u("δ\xB5\xBD\xBBʱ\xBC\xE4\xC8\xD5"))

		return
	end

	if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Diamond, arg_10_0.dayInfo.SaleDiamond) == false then
		g_Bubble:bubbleInfo(a2u("\xD7\xEAʯ\xB2\xBB\xD7\xE3"))

		return
	end

	g_WsMsgHandler:WS_ActivityOs_HalfPacks_Req(arg_10_0.day)
end

function var_0_0.onLeft(arg_11_0)
	if arg_11_0.day > 1 then
		arg_11_0.day = arg_11_0.day - 1

		arg_11_0:refreshDetail()
	end
end

function var_0_0.onRight(arg_12_0)
	if arg_12_0.day < 7 then
		arg_12_0.day = arg_12_0.day + 1

		arg_12_0:refreshDetail()
	end
end

function var_0_0.onFrame(arg_13_0)
	if g_Self.kSevenHandler:getSevenLessTime() == 0 then
		arg_13_0.lbTime:setString(a2u("\xBB\xD2ѽ\xE1\xCA\xF8"))
	elseif g_Self.kSevenHandler:getSevenLessTime() < 86400 then
		arg_13_0.lbTime:setString(zbUtil:SprintfHHMMSSNo24(g_Self.kSevenHandler:getSevenLessTime()))
	else
		arg_13_0.lbTime:setString(zbUtil:getPassTime2(g_Self.kSevenHandler:getSevenLessTime()))
	end
end

function var_0_0.getToDay(arg_14_0)
	local var_14_0 = 1

	for iter_14_0, iter_14_1 in pairs(g_GameData.ActivityOs.HalfPacks) do
		if iter_14_1.State == 0 then
			var_14_0 = iter_14_0 - 1

			break
		end
	end

	if var_14_0 == 0 then
		var_14_0 = 1
	end

	return var_14_0
end
