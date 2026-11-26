require("gamelogic.zbMoneyItem")

local var_0_0 = class("zbMoneyPanel")

var_0_0.__index = var_0_0

function createMoneyPanel(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	local function var_2_0()
		arg_2_0.moneyTypeList = arg_2_2
		arg_2_0.moneyItemList = {}
		arg_2_0.parentWnd = arg_2_1
	end

	local function var_2_1()
		CCLabelTTF:beginDelayCreateTexture()

		local var_4_0 = CCBProxy:create()
		local var_4_1 = CCBReaderLoad("ccbi/moneypanel.ccbi", var_4_0, true, "HelloCocosBuilderLayerOwner", true)
		local var_4_2 = tolua.cast(var_4_1:getChildByTag(2), "CCNode")

		arg_2_0.layer_Pos = ccp(var_4_2:getPosition())
		arg_2_0.node = var_4_1
		arg_2_0.moneyItemList[1] = createMoneyItem(tolua.cast(var_4_2:getChildByTag(1), "CCSprite"), arg_2_0, arg_2_0.moneyTypeList[1])
		arg_2_0.moneyItemList[2] = createMoneyItem(tolua.cast(var_4_2:getChildByTag(2), "CCSprite"), arg_2_0, arg_2_0.moneyTypeList[2])
		arg_2_0.moneyItemList[3] = createMoneyItem(tolua.cast(var_4_2:getChildByTag(3), "CCSprite"), arg_2_0, arg_2_0.moneyTypeList[3])
		arg_2_0.moneyItemList[4] = createMoneyItem(tolua.cast(var_4_2:getChildByTag(4), "CCSprite"), arg_2_0, arg_2_0.moneyTypeList[4])
		arg_2_0.moneyTips = tolua.cast(var_4_2:getChildByTag(10), "CCNode")
		arg_2_0.moneyName = tolua.cast(arg_2_0.moneyTips:getChildByTag(1), "CCLabelTTF")
		arg_2_0.moneyCount = tolua.cast(arg_2_0.moneyTips:getChildByTag(2), "CCLabelTTF")
		arg_2_0.moneyExchange = tolua.cast(arg_2_0.moneyTips:getChildByTag(3), "CCLabelTTF")
		arg_2_0.moneyDesc = tolua.cast(arg_2_0.moneyTips:getChildByTag(4), "CCLabelTTF")

		arg_2_0.moneyTips:setVisible(false)

		arg_2_0.btnClose = tolua.cast(var_4_2:getChildByTag(31), "CCControlButton")

		arg_2_0.btnClose:setZoomOnTouchDown(true)

		if arg_2_3 then
			arg_2_0.btnClose:setVisible(true)
			arg_2_0.btnClose:addHandleOfControlEvent(function()
				arg_2_3()
			end, CCControlEventTouchUpInside)
		else
			for iter_4_0 = 1, 4 do
				local var_4_3 = ccp(arg_2_0.moneyItemList[iter_4_0].node:getPosition())

				arg_2_0.moneyItemList[iter_4_0].node:setPosition(var_4_3.x + 130, var_4_3.y)
			end

			arg_2_0.btnClose:setVisible(false)
		end

		arg_2_0.layer = var_4_2

		CCLabelTTF:endDelayCreateTexture(var_4_2)
	end

	var_2_0()
	var_2_1()
	arg_2_0:onWealthChanged()
	arg_2_0.parentWnd:registerEvent(arg_2_0.node, function()
		arg_2_0:onWealthChanged()
	end, zbGameEvent.Event_Update_Wealth)
	arg_2_0.parentWnd:registerEvent(arg_2_0.node, function()
		arg_2_0:onWealthChanged()
	end, zbGameEvent.Event_Update_CapacityInfo)
	arg_2_0.parentWnd:registerEvent(arg_2_0.node, function()
		arg_2_0:onWealthChanged()
	end, zbGameEvent.Event_Update_BagItem)
end

function var_0_0.setLayerVisible(arg_9_0, arg_9_1)
	arg_9_0.layer:setVisible(arg_9_1)
end

function var_0_0.onWealthChanged(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.moneyItemList) do
		iter_10_1:onWealthChanged(arg_10_0.parentWnd.isShow)
	end
end

function var_0_0.setMoneyTypeList(arg_11_0, arg_11_1)
	arg_11_0.moneyTypeList = arg_11_1

	for iter_11_0 = 1, table.getn(arg_11_0.moneyTypeList) do
		if arg_11_0.moneyTypeList[iter_11_0] ~= nil then
			arg_11_0.moneyItemList[iter_11_0]:resetMoneyItem(arg_11_0.moneyTypeList[iter_11_0])
		end
	end
end

function var_0_0.isInPanel(arg_12_0, arg_12_1, arg_12_2)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.moneyItemList) do
		if iter_12_1:isInCtrl(arg_12_1, arg_12_2) then
			return true
		end
	end

	return false
end
