local var_0_0 = class("zbMoneyItem")

var_0_0.__index = var_0_0

function createMoneyItem(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local function var_2_0()
		arg_2_0.node = arg_2_1
		arg_2_0.moneyPanel = arg_2_2
		arg_2_0.moneyType = arg_2_3
		arg_2_0.moneyNum = 0
		arg_2_0.showTips = false
	end

	local function var_2_1()
		local function var_4_0(arg_5_0)
			local function var_5_0()
				arg_2_0.fxIcon:setVisible(true)
				arg_2_0.fxIcon:setAnimation("animation", false)
			end

			local function var_5_1()
				arg_2_0.fxIcon:setVisible(false)
			end

			arg_2_0.fxIcon = createUIAnimation()

			arg_2_0.fxIcon:refresh("effect/spine/ui_huobiguangxiao/ui_huobiguangxiao.json", "effect/spine/ui_huobiguangxiao/ui_huobiguangxiao.atlas")
			arg_2_0.fxIcon:setPosition(21, 25)
			arg_5_0:addChild(arg_2_0.fxIcon)

			local var_5_2 = CCArray:create()

			var_5_2:addObject(CCCallFuncN:create(var_5_0))
			var_5_2:addObject(CCDelayTime:create(1.5))
			var_5_2:addObject(CCCallFuncN:create(var_5_1))
			var_5_2:addObject(CCDelayTime:create(1.8))

			local var_5_3 = CCSequence:create(var_5_2)

			arg_5_0:stopAllActions()
			arg_5_0:runAction(CCRepeatForever:create(var_5_3))
		end

		arg_2_0.moneyIcon = tolua.cast(arg_2_1:getChildByTag(1), "CCSprite")
		arg_2_0.txtNum = tolua.cast(arg_2_1:getChildByTag(1002), "CCLabelTTF")
		arg_2_0.moneyBtn = tolua.cast(arg_2_1:getChildByTag(3), "CCControlButton")
		arg_2_0.moneyAddBtn = tolua.cast(arg_2_1:getChildByTag(4), "CCControlButton")

		arg_2_0.moneyAddBtn:addHandleOfControlEvent(function()
			arg_2_0:onAddMoney()
		end, CCControlEventTouchUpInside)
		arg_2_0.moneyBtn:addHandleOfControlEvent(function()
			arg_2_0:onTouchDown()
		end, CCControlEventTouchDown)
		arg_2_0.moneyBtn:addHandleOfControlEvent(function()
			arg_2_0:onAddMoney()
		end, CCControlEventTouchUpInside)
		arg_2_0.moneyBtn:addHandleOfControlEvent(function()
			arg_2_0:onTouchEnd()
		end, CCControlEventTouchEnd)

		arg_2_0.lbMoneyNum = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_2_0.txtNum, arg_2_0.lbMoneyNum)
		arg_2_0.lbMoneyNum:setScale(0.5)
		var_4_0(arg_2_0.moneyIcon)
		arg_2_0.moneyAddBtn:setVisible(arg_2_0.moneyType == EMoneyPanelResType.Diamond or arg_2_0.moneyType == EMoneyPanelResType.Gold or arg_2_0.moneyType == EMoneyPanelResType.Food or arg_2_0.moneyType == EMoneyPanelResType.Tili or arg_2_0.moneyType == EMoneyPanelResType.SkillBook or arg_2_0.moneyType == EMoneyPanelResType.DollsMoney or arg_2_0.moneyType == EMoneyPanelResType.GemOpen)

		local var_4_1 = zbIconHelper:getMoneyPanelIconPath(arg_2_3)

		arg_2_0.moneyIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_4_1))
	end

	var_2_0()
	var_2_1()

	arg_2_0.moneyNum = arg_2_0:getMoneyNum()
end

function var_0_0.onWealthChanged(arg_12_0, arg_12_1)
	if arg_12_0.moneyType == nil then
		arg_12_0.node:setVisible(false)

		return
	else
		arg_12_0.node:setVisible(true)
	end

	local var_12_0 = arg_12_0:getMoneyNum()

	if arg_12_1 == true then
		local var_12_1 = 0

		if type(var_12_0) == "number" then
			var_12_1 = var_12_0 - arg_12_0.moneyNum
		end

		if var_12_1 == 0 then
			arg_12_0.lbMoneyNum:setString(arg_12_0:foramatMoney(var_12_0))

			return
		end

		local var_12_2 = 10
		local var_12_3 = var_12_1 / var_12_2
		local var_12_4 = math.floor(var_12_3)

		if var_12_4 < 1 then
			var_12_4 = 1
			var_12_2 = var_12_1
		end

		local var_12_5 = arg_12_0.moneyNum
		local var_12_6 = CCArray:create()

		var_12_6:addObject(CCDelayTime:create(0.2))

		for iter_12_0 = 1, var_12_2 do
			var_12_6:addObject(CCCallFuncN:create(function()
				var_12_5 = var_12_5 + var_12_4

				arg_12_0.lbMoneyNum:setString(arg_12_0:foramatMoney(var_12_5))
			end))
			var_12_6:addObject(CCDelayTime:create(0.1))
		end

		var_12_6:addObject(CCCallFuncN:create(function()
			arg_12_0.lbMoneyNum:setString(arg_12_0:foramatMoney(var_12_0))
		end))

		local var_12_7 = CCSequence:create(var_12_6)

		arg_12_0.node:stopAllActions()
		arg_12_0.node:runAction(var_12_7)
	else
		arg_12_0.lbMoneyNum:setString(arg_12_0:foramatMoney(var_12_0))
	end

	arg_12_0.moneyNum = var_12_0
end

function var_0_0.foramatMoney(arg_15_0, arg_15_1)
	if string.find(arg_15_1, "/") then
		return arg_15_1
	end

	if arg_15_1 > 9999999 then
		return math.modf(arg_15_1 / 10000) .. "<"
	else
		return arg_15_1
	end
end

function var_0_0.resetMoneyItem(arg_16_0, arg_16_1)
	local var_16_0 = zbIconHelper:getMoneyPanelIconPath(arg_16_1)

	arg_16_0.moneyIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_16_0))

	arg_16_0.moneyType = arg_16_1

	arg_16_0.moneyAddBtn:setVisible(arg_16_0.moneyType == EMoneyPanelResType.Diamond or arg_16_0.moneyType == EMoneyPanelResType.Gold or arg_16_0.moneyType == EMoneyPanelResType.Food or arg_16_0.moneyType == EMoneyPanelResType.Tili or arg_16_0.moneyType == EMoneyPanelResType.SkillBook or arg_16_0.moneyType == EMoneyPanelResType.DollsMoney or arg_16_0.moneyType == EMoneyPanelResType.GemOpen)
	arg_16_0:onWealthChanged()
end

function var_0_0.getMoneyNum(arg_17_0)
	local var_17_0 = 0

	if arg_17_0.moneyType == EMoneyPanelResType.Diamond then
		var_17_0 = g_GameData.Wealth.Diamond
	elseif arg_17_0.moneyType == EMoneyPanelResType.Gold then
		var_17_0 = g_GameData.Wealth.Gold
	elseif arg_17_0.moneyType == EMoneyPanelResType.Food then
		var_17_0 = g_GameData.Wealth.Food
	elseif arg_17_0.moneyType == EMoneyPanelResType.Tili then
		var_17_0 = g_GameData.Wealth.Tili .. "/" .. g_GameData.CapacityInfo.Tili
	elseif arg_17_0.moneyType == EMoneyPanelResType.BarCard then
		var_17_0 = g_GameData.Wealth.BarCard
	elseif arg_17_0.moneyType == EMoneyPanelResType.BarMoney then
		var_17_0 = g_GameData.Wealth.BarMoney
	elseif arg_17_0.moneyType == EMoneyPanelResType.Soul then
		var_17_0 = g_GameData.Wealth.Soul
	elseif arg_17_0.moneyType == EMoneyPanelResType.EquipSoul then
		var_17_0 = g_GameData.Wealth.EquipSoul
	elseif arg_17_0.moneyType == EMoneyPanelResType.Arena then
		var_17_0 = g_GameData.Wealth.Arena
	elseif arg_17_0.moneyType == EMoneyPanelResType.Bgz then
		var_17_0 = g_GameData.Wealth.Bgz
	elseif arg_17_0.moneyType == EMoneyPanelResType.Legion then
		var_17_0 = g_GameData.Wealth.Legion
	elseif arg_17_0.moneyType == EMoneyPanelResType.Horn then
		var_17_0 = g_GameData.Wealth.Horn
	elseif arg_17_0.moneyType == EMoneyPanelResType.DollsMoney then
		var_17_0 = g_GameData.Wealth.DollsMoney
	elseif arg_17_0.moneyType == EMoneyPanelResType.SkillBook then
		var_17_0 = g_Self.kBagItemHandler:getItemCountByTemplateId(ITEM_ID_SKILLBOOK)
	elseif arg_17_0.moneyType == EMoneyPanelResType.Reset then
		var_17_0 = g_Self.kBagItemHandler:getItemCountByTemplateId(ITEM_ID_RESET)
	elseif arg_17_0.moneyType == EMoneyPanelResType.GemOpen then
		var_17_0 = g_Self.kBagItemHandler:getItemCount(EItemType.Material, EMaterialType.GemOpenHole)
	end

	return var_17_0
end

function var_0_0.onAddMoney(arg_18_0)
	if arg_18_0.showTips then
		return
	end

	if g_Self:getLevel() < 3 then
		g_Bubble:bubbleInfo(a2u("\xB5\xB1ǰ\xD5\xFD\xD4\xDA\xD2\xFD\xB5\xBC\xD6\xD0"))

		return
	end

	arg_18_0.node:stopAllActions()

	if arg_18_0.moneyType == EMoneyPanelResType.Diamond then
		g_MainScene:showVipBuyWnd()
	elseif arg_18_0.moneyType == EMoneyPanelResType.Gold then
		g_MainScene:showGoldenTouch(EExchangeType.Gold)
	elseif arg_18_0.moneyType == EMoneyPanelResType.Food then
		g_MainScene:showGoldenTouch(EExchangeType.Food)
	elseif arg_18_0.moneyType == EMoneyPanelResType.Tili then
		g_MainScene:showGoldenTouch(EExchangeType.Tili)
	elseif arg_18_0.moneyType == EMoneyPanelResType.SkillBook then
		g_MainScene:showGoldenTouch(EExchangeType.SkillBook)
	elseif arg_18_0.moneyType == EMoneyPanelResType.GemOpen then
		g_MainScene:showGoldenTouch(EExchangeType.GemOpenHole)
	elseif arg_18_0.moneyType == EMoneyPanelResType.DollsMoney then
		g_MainScene:showGoldenTouch(EExchangeType.DollsMoney)
	end
end

function var_0_0.onTouchDown(arg_19_0)
	if arg_19_0.moneyType ~= EMoneyPanelResType.Bgz then
		local var_19_0 = CCArray:create()

		var_19_0:addObject(CCDelayTime:create(0.3))
		var_19_0:addObject(CCCallFuncN:create(function()
			arg_19_0:onShowTips()
		end))

		local var_19_1 = CCSequence:create(var_19_0)

		arg_19_0.node:stopAllActions()
		arg_19_0.node:runAction(var_19_1)
	end
end

function var_0_0.onTouchEnd(arg_21_0)
	arg_21_0.showTips = false

	arg_21_0.node:stopAllActions()

	if arg_21_0.moneyPanel.moneyTips ~= nil then
		arg_21_0.moneyPanel.moneyTips:setVisible(false)
	end
end

function var_0_0.onShowTips(arg_22_0)
	arg_22_0.showTips = true

	local var_22_0 = ccp(arg_22_0.node:getPosition())

	if arg_22_0.moneyPanel.moneyTips then
		arg_22_0.moneyPanel.moneyTips:setPosition(var_22_0.x - 180, var_22_0.y)
		arg_22_0.moneyPanel.moneyTips:setVisible(true)

		local var_22_1, var_22_2, var_22_3 = zbIconHelper:getMoneyPanelIconPath(arg_22_0.moneyType)

		arg_22_0.moneyPanel.moneyName:setString(var_22_2)
		arg_22_0.moneyPanel.moneyDesc:setString(var_22_3)

		local var_22_4 = arg_22_0:getMoneyNum()

		arg_22_0.moneyPanel.moneyCount:setString(a2u("\xD2\xD1ӵ\xD3\xD0:") .. var_22_4)

		local var_22_5, var_22_6 = arg_22_0:getCountInfo()

		if var_22_6 == 0 and var_22_5 == 0 then
			arg_22_0.moneyPanel.moneyExchange:setVisible(false)
		else
			arg_22_0.moneyPanel.moneyExchange:setVisible(true)
			arg_22_0.moneyPanel.moneyExchange:setString(a2u("\xB6һ\xBB\xB4\xCE\xCA\xFD:") .. var_22_5 .. "/" .. var_22_6)
		end
	end
end

function var_0_0.isInCtrl(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_0.moneyType == nil then
		return false
	end

	if zbUtil:PointInCtrl(arg_23_0.moneyBtn, arg_23_1, arg_23_2) or zbUtil:PointInCtrl(arg_23_0.moneyAddBtn, arg_23_1, arg_23_2) then
		return true
	end

	return false
end

function var_0_0.getCountInfo(arg_24_0)
	local var_24_0 = 0
	local var_24_1 = 0
	local var_24_2 = zbVipTable:getRecord(g_GameData.BaseInfo.VipLevel)

	if arg_24_0.moneyType == EMoneyPanelResType.Gold then
		var_24_0 = g_GameData.ExchangeInfo.GoldCount
		var_24_1 = var_24_2.exchangeGoldNum
	elseif arg_24_0.moneyType == EMoneyPanelResType.Food then
		var_24_0 = g_GameData.ExchangeInfo.FoodCount
		var_24_1 = var_24_2.exchangeFoodNum
	elseif arg_24_0.moneyType == EMoneyPanelResType.SkillBook then
		var_24_0 = g_GameData.ExchangeInfo.SkillBookCount
		var_24_1 = var_24_2.exchangeSkillBookNum
	elseif arg_24_0.moneyType == EMoneyPanelResType.Tili then
		var_24_0 = g_GameData.ExchangeInfo.TiliCount
		var_24_1 = var_24_2.exchangeTiliNum
	elseif arg_24_0.moneyType == EMoneyPanelResType.GemOpen then
		var_24_0 = g_GameData.ExchangeInfo.GemOpenHoleCount
		var_24_1 = var_24_2.exchangeGemOpenHoleNum
	elseif arg_24_0.moneyType == EMoneyPanelResType.DollsMoney then
		var_24_0 = g_GameData.ExchangeInfo.DollsMoneyCount
		var_24_1 = var_24_2.exchangeDollsMoneyNum
	end

	return var_24_0, var_24_1
end
