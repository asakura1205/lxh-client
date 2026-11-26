require("gamelogic.zbItem")

zbActivityWnd_Desire = class("zbActivityWnd_Desire")
zbActivityWnd_Desire.__index = zbActivityWnd_Desire

function zbActivityWnd_Desire.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbActivityWnd_Desire)

	return arg_1_0
end

function zbActivityWnd_Desire.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = zbActivityWnd_Desire.new()

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3)

	return var_2_0
end

function zbActivityWnd_Desire.init(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	(function()
		arg_3_0.touchFlag = false
		arg_3_0.items = {}
		arg_3_0.itemsSprite = {}
		arg_3_0.preAngle = 0
		arg_3_0.nodeParent = arg_3_1
		arg_3_0.parentWnd = arg_3_3
		arg_3_0.btnPriority = arg_3_2
		arg_3_0.scrollEffect = {}
	end)()
	arg_3_0.parentWnd:registerEvent(arg_3_0.nodeParent, function()
		arg_3_0:toTurn()
	end, zbGameEvent.Event_WishTurntable_Ack)
end

function zbActivityWnd_Desire.onFrame(arg_6_0)
	if arg_6_0.touchFlag == true then
		local var_6_0 = arg_6_0.spritePoint:getRotationX()
		local var_6_1 = math.floor(var_6_0 % 360)
		local var_6_2 = math.floor(var_6_1 / 45) + 1

		for iter_6_0 = 1, 8 do
			if iter_6_0 == var_6_2 then
				arg_6_0.items[iter_6_0].spriteIcon:setOpacity(255)
			else
				arg_6_0.items[iter_6_0].spriteIcon:setOpacity(240)
			end
		end
	end
end

function zbActivityWnd_Desire.refresh(arg_7_0)
	(function()
		if arg_7_0.node ~= nil then
			return
		end

		local var_8_0 = CCBProxy:create()
		local var_8_1 = CCBReaderLoad("ccbi/activity_desire.ccbi", var_8_0, true, "HelloCocosBuilderLayerOwner", true)
		local var_8_2 = tolua.cast(var_8_1:getChildByTag(1), "CCNode")

		arg_7_0.layerLeft = tolua.cast(var_8_2:getChildByTag(1), "CCNode")
		arg_7_0.lbTurntable = tolua.cast(arg_7_0.layerLeft:getChildByTag(1001), "CCLabelTTF")
		arg_7_0.lbRefresh = tolua.cast(arg_7_0.layerLeft:getChildByTag(1002), "CCLabelTTF")
		arg_7_0.spriteMoneyIcon = tolua.cast(arg_7_0.layerLeft:getChildByTag(31), "CCSprite")
		arg_7_0.spriteFreeLeft = tolua.cast(arg_7_0.layerLeft:getChildByTag(12), "CCSprite")
		arg_7_0.lbMoneyLeftDummy = tolua.cast(arg_7_0.layerLeft:getChildByTag(1003), "CCLabelTTF")
		arg_7_0.btnRefreshReward = tolua.cast(arg_7_0.layerLeft:getChildByTag(4), "CCControlButton")
		arg_7_0.lbTurntableUsed = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_7_0.lbTurntable, arg_7_0.lbTurntableUsed)
		arg_7_0.lbTurntableUsed:setScale(0.6)

		arg_7_0.lbRefreshReward = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_7_0.lbRefresh, arg_7_0.lbRefreshReward)
		arg_7_0.lbRefreshReward:setScale(0.6)

		arg_7_0.lbMoneyLeft = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_7_0.lbMoneyLeftDummy, arg_7_0.lbMoneyLeft)
		arg_7_0.lbMoneyLeft:setScale(0.6)

		arg_7_0.layerRight = tolua.cast(var_8_2:getChildByTag(2), "CCNode")

		for iter_8_0 = 1, 8 do
			local var_8_3 = tolua.cast(arg_7_0.layerRight:getChildByTag(1), "CCNode")
			local var_8_4 = tolua.cast(var_8_3:getChildByTag(iter_8_0), "CCNode")
			local var_8_5 = createItem()

			var_8_5:setPosition(var_8_4:getPosition())
			var_8_5:setScale(0.65)
			var_8_5:setNeedTip(true)
			var_8_5:setSupportTouchDownTip(false)
			var_8_5:setSupportTouchTip(true)
			var_8_5.btnFrame:setTouchPriority(arg_7_0.btnPriority:getTouchPriority())
			var_8_3:addChild(var_8_5)
			var_8_4:removeFromParentAndCleanup(true)
			table.insert(arg_7_0.items, var_8_5)

			local var_8_6 = tolua.cast(arg_7_0.layerRight:getChildByTag(2), "CCNode")

			arg_7_0.itemsSprite[iter_8_0] = tolua.cast(var_8_6:getChildByTag(iter_8_0), "CCSprite")
		end

		arg_7_0.spriteBg = tolua.cast(arg_7_0.layerRight:getChildByTag(0), "CCSprite")
		arg_7_0.btnBegin = tolua.cast(arg_7_0.layerRight:getChildByTag(10), "CCControlButton")
		arg_7_0.spriteBegin = tolua.cast(arg_7_0.layerRight:getChildByTag(11), "CCSprite")
		arg_7_0.spriteFree = tolua.cast(arg_7_0.layerRight:getChildByTag(12), "CCSprite")
		arg_7_0.spritePoint = tolua.cast(arg_7_0.layerRight:getChildByTag(20), "CCSprite")
		arg_7_0.lbMoney = tolua.cast(arg_7_0.layerRight:getChildByTag(30), "CCLabelTTF")
		arg_7_0.spriteIcon = tolua.cast(arg_7_0.layerRight:getChildByTag(31), "CCSprite")

		arg_7_0.btnRefreshReward:addHandleOfControlEvent(function()
			arg_7_0:refreshReward()
		end, CCControlEventTouchUpInside)
		arg_7_0.btnBegin:addHandleOfControlEvent(function()
			arg_7_0:toBegin()
		end, CCControlEventTouchUpInside)
		arg_7_0.spritePoint:setZOrder(ZORDER_TOP)
		arg_7_0.btnRefreshReward:setTouchPriority(arg_7_0.btnPriority:getTouchPriority())
		arg_7_0.btnBegin:setTouchPriority(arg_7_0.btnPriority:getTouchPriority())

		arg_7_0.node = var_8_1

		arg_7_0.nodeParent:addChild(var_8_1)
	end)()

	if zbUtil:isValidTable(g_GameData.ActivityAct) == false or zbUtil:isValidTable(g_GameData.ActivityAct.WishTurntable) == false then
		return
	end

	local var_7_0 = g_GameData.ActivityAct.WishTurntable

	arg_7_0.lbTurntableUsed:setString(var_7_0.RunMax - var_7_0.RunCount)
	arg_7_0.lbRefreshReward:setString(var_7_0.RefreshMax - var_7_0.RefreshCount)

	if var_7_0.RefreshCost == 0 then
		arg_7_0.spriteFreeLeft:setVisible(true)
		arg_7_0.lbMoneyLeft:setVisible(false)
		arg_7_0.spriteMoneyIcon:setVisible(false)
	else
		arg_7_0.spriteFreeLeft:setVisible(false)
		arg_7_0.lbMoneyLeft:setVisible(true)
		arg_7_0.spriteMoneyIcon:setVisible(true)
	end

	if var_7_0.RunCost == 0 then
		arg_7_0.spriteFree:setVisible(true)
		arg_7_0.lbMoney:setVisible(false)
		arg_7_0.spriteIcon:setVisible(false)
	else
		arg_7_0.spriteFree:setVisible(false)
		arg_7_0.lbMoney:setVisible(true)
		arg_7_0.spriteIcon:setVisible(true)
	end

	if var_7_0.RefreshCount >= var_7_0.RefreshMax or var_7_0.RunCount >= var_7_0.RunMax then
		arg_7_0.spriteMoneyIcon:setVisible(false)
		arg_7_0.lbMoneyLeft:setVisible(false)
		arg_7_0.btnRefreshReward:setGray(true)
		arg_7_0.btnRefreshReward:setEnabled(false)
	else
		arg_7_0.lbMoneyLeft:setString(var_7_0.RefreshCost)
	end

	if var_7_0.RunCount >= var_7_0.RunMax then
		arg_7_0.spriteIcon:setVisible(false)
		arg_7_0.lbMoney:setVisible(false)
		arg_7_0.spriteBegin:setVisible(false)
		arg_7_0.btnBegin:setGray(true)
		arg_7_0.btnBegin:setEnabled(false)
	else
		arg_7_0.lbMoney:setString(var_7_0.RunCost)
	end

	local var_7_1 = 1

	for iter_7_0, iter_7_1 in pairs(var_7_0.SlotList) do
		arg_7_0.items[var_7_1]:refreshAward(iter_7_1.AwardItem.Type, iter_7_1.AwardItem.Id, iter_7_1.AwardItem.Count, false, true)
		arg_7_0.items[var_7_1].spriteIcon:setOpacity(240)

		if (iter_7_1.AwardItem.Type == ECommonAwardType.HeroFrag or iter_7_1.AwardItem.Type == ECommonAwardType.Hero or iter_7_1.AwardItem.Type == ECommonAwardType.Diamond or iter_7_1.AwardItem.Type == ECommonAwardType.BarMoney or iter_7_1.AwardItem.Type == ECommonAwardType.EquipFrag and zbItemTable:getItemQuality(iter_7_1.AwardItem.Id) > EItemQuality.Golden or iter_7_1.AwardItem.Type == ECommonAwardType.Item and zbItemTable:getItemType(iter_7_1.AwardItem.Id) == EItemType.Equip and zbItemTable:getItemQuality(iter_7_1.AwardItem.Id) > EItemQuality.Purple or zbItemTable:getItemQuality(iter_7_1.AwardItem.Id) > EItemQuality.Golden) and arg_7_0.scrollEffect[var_7_1] == nil then
			arg_7_0.scrollEffect[var_7_1] = g_EffectSystem:creatScrollEffect(arg_7_0.items[var_7_1], iter_7_1.AwardItem.Type)

			arg_7_0.scrollEffect[var_7_1]:setAnimation("animation", true)
		end

		arg_7_0.itemsSprite[var_7_1]:setVisible(iter_7_1.State == 1)

		var_7_1 = var_7_1 + 1
	end

	arg_7_0.spritePoint:stopAllActions()
	arg_7_0.spritePoint:setRotation(arg_7_0.preAngle)

	if g_Self.kActivityHandler.wishData ~= nil then
		g_Self.kDataChange:update(g_Self.kActivityHandler.wishData)

		g_Self.kActivityHandler.wishData = nil
	end
end

function zbActivityWnd_Desire.toBegin(arg_11_0)
	local var_11_0 = g_GameData.ActivityAct.WishTurntable

	if var_11_0.RunCount >= var_11_0.RunMax then
		g_Bubble:bubbleInfo(a2u("\xBD\xF1\xC8\xD5\xD0\xEDԸ\xB4\xCE\xCA\xFD\xD2\xD1\xD3\xC3\xCD\xEA"))

		return
	end

	local var_11_1 = false

	for iter_11_0, iter_11_1 in pairs(var_11_0.SlotList) do
		if iter_11_1.State == 0 then
			var_11_1 = true

			break
		end
	end

	if var_11_1 == false then
		g_Bubble:bubbleInfo(a2u("\xB1\xBE\xC2\xD6ת\xC5\xCC\xD2Ѿ\xADȫ\xB2\xBF\xC1\xEC\xCD꣬\xC7\xEBˢ\xD0\xC2ת\xC5\xCC"))

		return
	end

	if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Diamond, var_11_0.RunCost) == false then
		g_Bubble:bubbleInfo(a2u("\xD7\xEAʯ\xB2\xBB\xD7\xE3"))

		return
	end

	g_WsMsgHandler:WS_ActivityAct_WishTabRun_Req()
end

function zbActivityWnd_Desire.toTurn(arg_12_0)
	local function var_12_0()
		arg_12_0.btnBegin:setEnabled(true)
		arg_12_0.btnRefreshReward:setEnabled(true)
		arg_12_0:refresh()

		arg_12_0.touchFlag = false

		if g_Self.kActivityHandler.wishData ~= nil then
			g_Self.kDataChange:update(g_Self.kActivityHandler.wishData)

			g_Self.kActivityHandler.wishData = nil
		end
	end

	arg_12_0.touchFlag = true

	arg_12_0.btnBegin:setEnabled(false)
	arg_12_0.btnRefreshReward:setEnabled(false)

	local var_12_1 = 1

	for iter_12_0, iter_12_1 in pairs(g_GameData.ActivityAct.WishTurntable.SlotList) do
		if iter_12_1.Index == g_Self.kActivityHandler.wishTurntableSoltType then
			break
		end

		var_12_1 = var_12_1 + 1
	end

	local var_12_2 = math.random((var_12_1 - 1) * 45 + 3, var_12_1 * 45 - 3)
	local var_12_3 = var_12_2 - arg_12_0.preAngle
	local var_12_4 = CCArray:create()

	var_12_4:addObject(CCEaseInOut:create(CCRotateBy:create(5, 2880 + var_12_3), 2))
	var_12_4:addObject(CCCallFuncN:create(var_12_0))
	arg_12_0.spritePoint:runAction(CCSequence:create(var_12_4))

	arg_12_0.preAngle = var_12_2

	arg_12_0.parentWnd:refreshNotify()
end

function zbActivityWnd_Desire.refreshReward(arg_14_0)
	local var_14_0 = g_GameData.ActivityAct.WishTurntable

	if var_14_0.RunCount >= var_14_0.RunMax then
		g_Bubble:bubbleInfo(a2u("\xBD\xF1\xC8\xD5\xD0\xEDԸ\xB4\xCE\xCA\xFD\xD2\xD1\xD3\xC3\xCD\xEA"))

		return
	end

	local function var_14_1()
		if g_Self.kWealthHandler:hasEnoughMoney(ECommonAwardType.Diamond, var_14_0.RefreshCost) == false then
			g_Bubble:bubbleInfo(a2u("\xD7\xEAʯ\xB2\xBB\xD7\xE3"))

			return
		end

		g_WsMsgHandler:WS_ActivityAct_WishTabRefresh_Req()
	end

	g_MessageBox:showYesNo(a2u("ȷ\xC8ϻ\xA8\xB7\xD1") .. var_14_0.RefreshCost .. a2u("\xD7\xEAʯˢ\xD0½\xB1\xC0\xF8\xC2\xF0"), var_14_1)
end
