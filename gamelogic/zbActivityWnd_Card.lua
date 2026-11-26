zbActivityWnd_Card = class("zbActivityWnd_Card")
zbActivityWnd_Card.__index = zbActivityWnd_Card

function zbActivityWnd_Card.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbActivityWnd_Card)

	return arg_1_0
end

function zbActivityWnd_Card.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = zbActivityWnd_Card.new()

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3)

	return var_2_0
end

function zbActivityWnd_Card.init(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	(function()
		arg_3_0.lbLeftDay = {}
		arg_3_0.spriteMoney1 = {}
		arg_3_0.lbMoney1 = {}
		arg_3_0.spriteMoney2 = {}
		arg_3_0.lbMoney2 = {}
		arg_3_0.spriteGeted = {}
		arg_3_0.btnGet = {}
		arg_3_0.spriteExtra = {}
		arg_3_0.lbExtra = {}
		arg_3_0.nodeParent = arg_3_1
		arg_3_0.btnPriority = arg_3_2
		arg_3_0.parentWnd = arg_3_3
	end)()
end

function zbActivityWnd_Card.refresh(arg_5_0)
	(function()
		if arg_5_0.node ~= nil then
			return
		end

		local var_6_0 = CCBProxy:create()
		local var_6_1 = CCBReaderLoad("ccbi/activity_card.ccbi", var_6_0, true, "HelloCocosBuilderLayerOwner", true)
		local var_6_2 = tolua.cast(var_6_1:getChildByTag(1), "CCNode")
		local var_6_3 = {}

		for iter_6_0 = 1, 2 do
			var_6_3[iter_6_0] = tolua.cast(var_6_2:getChildByTag(iter_6_0), "CCSprite")
			arg_5_0.lbLeftDay[iter_6_0] = tolua.cast(var_6_3[iter_6_0]:getChildByTag(1), "CCLabelTTF")
			arg_5_0.spriteMoney1[iter_6_0] = tolua.cast(var_6_3[iter_6_0]:getChildByTag(2), "CCSprite")
			arg_5_0.lbMoney1[iter_6_0] = tolua.cast(var_6_3[iter_6_0]:getChildByTag(3), "CCLabelTTF")
			arg_5_0.spriteMoney2[iter_6_0] = tolua.cast(var_6_3[iter_6_0]:getChildByTag(4), "CCSprite")
			arg_5_0.lbMoney2[iter_6_0] = tolua.cast(var_6_3[iter_6_0]:getChildByTag(5), "CCLabelTTF")
			arg_5_0.spriteGeted[iter_6_0] = tolua.cast(var_6_3[iter_6_0]:getChildByTag(6), "CCSprite")
			arg_5_0.btnGet[iter_6_0] = tolua.cast(var_6_3[iter_6_0]:getChildByTag(7), "CCControlButton")

			arg_5_0.btnGet[iter_6_0]:setTouchPriority(arg_5_0.btnPriority:getTouchPriority())
			arg_5_0.btnGet[iter_6_0]:addHandleOfControlEvent(function()
				arg_5_0:onGet(iter_6_0)
			end, CCControlEventTouchUpInside)
			arg_5_0.btnGet[iter_6_0]:setToucheMoveDelta(MOVE_TEST_DELTA)
			arg_5_0.btnGet[iter_6_0]:setSwallowsTouches(false)
		end

		local var_6_4 = tolua.cast(var_6_2:getChildByTag(3), "CCSprite")

		for iter_6_1 = 1, 2 do
			arg_5_0.spriteExtra[iter_6_1] = tolua.cast(var_6_4:getChildByTag(2 * iter_6_1 - 1), "CCSprite")
			arg_5_0.lbExtra[iter_6_1] = tolua.cast(var_6_4:getChildByTag(2 * iter_6_1), "CCLabelTTF")
		end

		arg_5_0.spriteExtraGeted = tolua.cast(var_6_4:getChildByTag(5), "CCSprite")
		arg_5_0.btnExtra = tolua.cast(var_6_4:getChildByTag(6), "CCControlButton")

		arg_5_0.btnExtra:setTouchPriority(arg_5_0.btnPriority:getTouchPriority())
		arg_5_0.btnExtra:addHandleOfControlEvent(function()
			arg_5_0:onExtra()
		end, CCControlEventTouchUpInside)
		arg_5_0.btnExtra:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_5_0.btnExtra:setSwallowsTouches(false)

		arg_5_0.node = var_6_1

		arg_5_0.nodeParent:addChild(var_6_1)
	end)()

	if zbUtil:isValidTable(g_GameData.VipInfo) == false then
		return
	end

	for iter_5_0 = 1, 2 do
		local var_5_0

		if iter_5_0 == 1 then
			var_5_0 = g_GameData.VipInfo.MonthCard

			arg_5_0.lbLeftDay[1]:setString(var_5_0.LeftDay .. a2u("\xCC\xEC"))
		else
			var_5_0 = g_GameData.VipInfo.ForeverCard

			if var_5_0.LeftDay == 0 then
				arg_5_0.lbLeftDay[2]:setString(var_5_0.LeftDay .. a2u("\xCC\xEC"))
			else
				arg_5_0.lbLeftDay[2]:setString(a2u("\xD3\xC0\xBE\xC3"))
			end
		end

		if var_5_0 ~= nil then
			if var_5_0.AwardList[1] then
				local var_5_1 = zbIconHelper:getMoneyPanelIconPath(var_5_0.AwardList[1].Type)

				arg_5_0.spriteMoney1[iter_5_0]:setTexture(CCTextureCache:sharedTextureCache():addImage(var_5_1))
				arg_5_0.lbMoney1[iter_5_0]:setString(var_5_0.AwardList[1].Count)
			end

			if var_5_0.AwardList[2] then
				local var_5_2 = zbIconHelper:getMoneyPanelIconPath(var_5_0.AwardList[2].Type)

				arg_5_0.spriteMoney2[iter_5_0]:setTexture(CCTextureCache:sharedTextureCache():addImage(var_5_2))
				arg_5_0.lbMoney2[iter_5_0]:setString(var_5_0.AwardList[2].Count)
				arg_5_0.spriteMoney2[iter_5_0]:setVisible(true)
				arg_5_0.lbMoney2[iter_5_0]:setVisible(true)
			else
				arg_5_0.spriteMoney2[iter_5_0]:setVisible(false)
				arg_5_0.lbMoney2[iter_5_0]:setVisible(false)
			end

			arg_5_0.spriteGeted[iter_5_0]:setVisible(var_5_0.DailyAward == 2)
			arg_5_0.btnGet[iter_5_0]:setVisible(var_5_0.DailyAward ~= 2)

			if var_5_0.DailyAward == 0 then
				zbUtil:setButtonTitle(arg_5_0.btnGet[iter_5_0], a2u("\xB9\xBA\xC2\xF2"))
			else
				zbUtil:setButtonTitle(arg_5_0.btnGet[iter_5_0], a2u("\xC1\xECȡ"))
			end
		end
	end

	if zbUtil:isValidTable(g_GameData.VipInfo.TwoCard) == true then
		for iter_5_1 = 1, 2 do
			local var_5_3 = g_GameData.VipInfo.TwoCard.AwardList[iter_5_1]

			if var_5_3 ~= nil then
				local var_5_4 = zbIconHelper:getAwardIconPath(var_5_3.Type, var_5_3.Id)

				arg_5_0.spriteExtra[iter_5_1]:setTexture(CCTextureCache:sharedTextureCache():addImage(var_5_4))
				arg_5_0.lbExtra[iter_5_1]:setString(var_5_3.Count)
			end
		end

		arg_5_0.spriteExtraGeted:setVisible(g_GameData.VipInfo.TwoCard.DailyAward == 2)
		arg_5_0.btnExtra:setVisible(g_GameData.VipInfo.TwoCard.DailyAward ~= 2)

		if g_GameData.VipInfo.TwoCard.DailyAward == 0 then
			zbUtil:setButtonTitle(arg_5_0.btnExtra, a2u("\xB9\xBA\xC2\xF2"))
		else
			zbUtil:setButtonTitle(arg_5_0.btnExtra, a2u("\xC1\xECȡ"))
		end
	end
end

function zbActivityWnd_Card.onGet(arg_9_0, arg_9_1)
	if zbUtil:isValidTable(g_GameData.VipInfo) == false then
		return
	end

	local var_9_0
	local var_9_1 = 1

	if arg_9_1 == 1 then
		var_9_0 = g_GameData.VipInfo.MonthCard
		var_9_1 = EVipGoodsType.Month
	else
		var_9_0 = g_GameData.VipInfo.ForeverCard
		var_9_1 = EVipGoodsType.Forever
	end

	if var_9_0 ~= nil and var_9_0.DailyAward == 0 then
		g_MainScene:showVipBuyWnd()

		return
	end

	g_WsMsgHandler:WS_ActivityAct_VipCardAward_Req(var_9_1)
end

function zbActivityWnd_Card.onExtra(arg_10_0)
	if zbUtil:isValidTable(g_GameData.VipInfo) == false or zbUtil:isValidTable(g_GameData.VipInfo.TwoCard) == false then
		return
	end

	if g_GameData.VipInfo.TwoCard.DailyAward == 0 then
		g_MainScene:showVipBuyWnd()

		return
	end

	g_WsMsgHandler:WS_ActivityAct_TwoCardAward_Req()
end
