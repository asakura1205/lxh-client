require("gamelogic.zbItem")

zbLegionRedSendItem = class("zbLegionRedSendItem")
zbLegionRedSendItem.__index = zbLegionRedSendItem

function zbLegionRedSendItem.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbLegionRedSendItem)

	return arg_1_0
end

function zbLegionRedSendItem.create(arg_2_0, arg_2_1)
	local var_2_0 = zbLegionRedSendItem.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1)

	return var_2_0
end

function zbLegionRedSendItem.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.record = nil
		arg_3_0.lbAward = {}
		arg_3_0.awardItem = {}
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		arg_3_0.spriteBg = tolua.cast(var_5_0:getChildByTag(0), "CCSprite")
		arg_3_0.btnSendRed = tolua.cast(var_5_0:getChildByTag(1), "CCControlButton")

		arg_3_0.btnSendRed:addHandleOfControlEvent(function()
			arg_3_0:onSendRed()
		end, CCControlEventTouchUpInside)

		arg_3_0.spriteMoney = tolua.cast(var_5_0:getChildByTag(2), "CCSprite")

		local var_5_1 = tolua.cast(arg_3_0.spriteMoney:getChildByTag(1002), "CCLabelTTF")

		arg_3_0.lbVip = tolua.cast(var_5_0:getChildByTag(4), "CCLabelTTF")
		arg_3_0.spriteCost = tolua.cast(var_5_0:getChildByTag(3), "CCSprite")

		local var_5_2 = tolua.cast(arg_3_0.spriteCost:getChildByTag(1003), "CCLabelTTF")
		local var_5_3 = tolua.cast(var_5_0:getChildByTag(1004), "CCLabelTTF")

		for iter_5_0 = 1, 3 do
			local var_5_4 = tolua.cast(var_5_0:getChildByTag(10 + iter_5_0), "CCLayerColor")
			local var_5_5 = createItem()

			var_5_5:setPosition(var_5_4:getPosition())
			var_5_5:setScale(0.35)
			var_5_5:setNeedTip(false)
			var_5_0:addChild(var_5_5)

			arg_3_0.awardItem[iter_5_0] = var_5_5

			var_5_4:removeFromParentAndCleanup(true)
		end

		local function var_5_6(arg_7_0)
			local var_7_0 = tolua.cast(var_5_0:getChildByTag(arg_7_0), "CCLabelTTF")

			label = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

			require("gamebase.zbUI"):replaceCtrl(var_7_0, label)
			label:setScale(0.48)

			return label
		end

		arg_3_0.lbAward[1] = var_5_6(1011)
		arg_3_0.lbAward[2] = var_5_6(1012)
		arg_3_0.lbAward[3] = var_5_6(1013)
		arg_3_0.lbMoney = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_1, arg_3_0.lbMoney)
		arg_3_0.lbMoney:setScale(0.65)

		arg_3_0.lbCost = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_2, arg_3_0.lbCost)
		arg_3_0.lbCost:setScale(0.7)

		arg_3_0.lbCount = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_3, arg_3_0.lbCount)
		arg_3_0.lbCount:setScale(0.5)
		arg_3_0:setContentSize(var_5_0:getContentSize())
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function zbLegionRedSendItem.refresh(arg_8_0, arg_8_1)
	if arg_8_1 == nil then
		return
	end

	arg_8_0.record = arg_8_1

	local var_8_0 = "image/legion/red/red_type" .. arg_8_1.type .. ".png"

	arg_8_0.spriteBg:setTexture(CCTextureCache:sharedTextureCache():addImage(var_8_0))
	arg_8_0.lbMoney:setString(arg_8_1.diamond)
	arg_8_0.lbCount:setString(arg_8_1.num)

	local var_8_1 = zbIconHelper:getMoneyPanelIconPath(arg_8_1.hongbao[1].Type)

	arg_8_0.spriteCost:setTexture(CCTextureCache:sharedTextureCache():addImage(var_8_1))
	arg_8_0.lbCost:setString(arg_8_1.hongbao[1].Count)

	for iter_8_0 = 1, 3 do
		arg_8_0.awardItem[iter_8_0]:setVisible(false)
		arg_8_0.lbAward[iter_8_0]:setVisible(false)
	end

	local var_8_2 = 1

	for iter_8_1, iter_8_2 in pairs(arg_8_1.awardList) do
		arg_8_0.awardItem[var_8_2]:refreshAward(iter_8_2.Type, iter_8_2.Id, iter_8_2.Count, false, false)
		arg_8_0.lbAward[var_8_2]:setString(iter_8_2.Count)
		arg_8_0.awardItem[var_8_2]:setVisible(true)
		arg_8_0.lbAward[var_8_2]:setVisible(true)

		var_8_2 = var_8_2 + 1
	end

	if arg_8_0.record and g_Self:getVipLevel() < arg_8_0.record.needVip then
		arg_8_0.spriteMoney:setVisible(false)
		arg_8_0.lbVip:setVisible(true)
		arg_8_0.lbVip:setString("VIP" .. arg_8_0.record.needVip .. a2u("\xBFɷ\xA2"))
		arg_8_0.btnSendRed:setGray(true)
	else
		arg_8_0.spriteMoney:setVisible(true)
		arg_8_0.lbVip:setVisible(false)
		arg_8_0.btnSendRed:setGray(false)
	end
end

function zbLegionRedSendItem.onSendRed(arg_9_0)
	if arg_9_0.record and g_Self:getVipLevel() < arg_9_0.record.needVip then
		g_Bubble:bubbleInfo("Vip" .. arg_9_0.record.needVip .. "\xBF\xC9\xD2Է\xA2\xB4˺\xEC\xB0\xFC")

		return
	end

	if g_GameData.LegionInfo.Hongbao.SendCount >= g_GameData.LegionInfo.Hongbao.SendMax then
		g_Bubble:bubbleInfo("\xBD\xF1\xC8շ\xA2\xBA\xEC\xB0\xFC\xD2Ѵ\xEF\xC9\xCF\xCF\xDE")

		return
	end

	if arg_9_0.record ~= nil then
		local function var_9_0()
			g_WsMsgHandler:WS_LegionGame_SendHongbao_Req(arg_9_0.record.type)
		end

		local var_9_1 = a2u("ȷ\xB6\xA8\xBB\xA8\xB7\xD1") .. arg_9_0.record.diamond .. a2u("\xD7\xEAʯ\xB7\xA2\xA1\xBE") .. arg_9_0.record.name .. a2u("\xA1\xBF\xC2\xF0?")

		g_MessageBox:showYesNo(var_9_1, var_9_0)
	end
end
