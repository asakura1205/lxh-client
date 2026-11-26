require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbPubWnd", zbBaseWnd)

var_0_0.__index = var_0_0

local var_0_1 = "animation_01"
local var_0_2 = "animation_02"

function createPubWnd()
	local var_1_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_1_0:initBase()
	var_1_0:init()

	return var_1_0
end

function var_0_0.extend(arg_2_0)
	local var_2_0 = tolua.getpeer(arg_2_0)

	if not var_2_0 then
		var_2_0 = {}

		tolua.setpeer(arg_2_0, var_2_0)
	end

	setmetatable(var_2_0, var_0_0)

	return arg_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.barDrawType = EBarDrawType.NormalSingle
		arg_3_0.effectbg = nil
		arg_3_0.effectdrawAck = nil
	end

	local function var_3_1(arg_5_0)
		local var_5_0 = CCSprite:create(NOTIFY_TAG_PATH)

		var_5_0:setPosition(90, 90)
		var_5_0:setVisible(false)
		arg_5_0:addChild(var_5_0)
		zbUIEffect:createNotifyTagScaleAction(var_5_0)

		return var_5_0
	end

	local function var_3_2()
		local var_6_0 = CCBProxy:create()
		local var_6_1 = CCBReaderLoad("ccbi/pub.ccbi", var_6_0, true, "HelloCocosBuilderLayerOwner")
		local var_6_2 = tolua.cast(var_6_1:getChildByTag(1), "CCNode")

		arg_3_0.alphaLayer = tolua.cast(var_6_2:getChildByTag(200), "CCLayerColor")
		arg_3_0.nodeBottom = tolua.cast(var_6_2:getChildByTag(1), "CCNode")
		arg_3_0.nodePub = {}
		arg_3_0.btnPub = {}
		arg_3_0.nodemoney = {}
		arg_3_0.spriteMoney = {}
		arg_3_0.lbMoney = {}
		arg_3_0.lbtimes = {}
		arg_3_0.lbtimedesc = {}
		arg_3_0.notifyPub = {}

		for iter_6_0 = 1, 3 do
			arg_3_0.nodePub[iter_6_0] = tolua.cast(arg_3_0.nodeBottom:getChildByTag(iter_6_0), "CCNode")
			arg_3_0.btnPub[iter_6_0] = tolua.cast(arg_3_0.nodePub[iter_6_0]:getChildByTag(1), "CCControlButton")
			arg_3_0.nodemoney[iter_6_0] = tolua.cast(arg_3_0.nodePub[iter_6_0]:getChildByTag(10), "CCNode")
			arg_3_0.spriteMoney[iter_6_0] = tolua.cast(arg_3_0.nodemoney[iter_6_0]:getChildByTag(2), "CCSprite")
			arg_3_0.lbMoney[iter_6_0] = tolua.cast(arg_3_0.nodemoney[iter_6_0]:getChildByTag(3), "CCLabelTTF")
			arg_3_0.lbtimes[iter_6_0] = tolua.cast(arg_3_0.nodePub[iter_6_0]:getChildByTag(2), "CCLabelTTF")
			arg_3_0.lbtimedesc[iter_6_0] = tolua.cast(arg_3_0.nodePub[iter_6_0]:getChildByTag(4), "CCLabelTTF")

			arg_3_0.btnPub[iter_6_0]:addHandleOfControlEvent(function()
				arg_3_0:onPub(iter_6_0)
			end, CCControlEventTouchUpInside)

			if iter_6_0 <= 2 then
				arg_3_0.notifyPub[iter_6_0] = var_3_1(arg_3_0.nodePub[iter_6_0])
			end
		end

		local var_6_3 = tolua.cast(var_6_2:getChildByTag(5), "CCNode")

		arg_3_0.btnPreView = tolua.cast(var_6_3:getChildByTag(5), "CCControlButton")
		arg_3_0.spriteBg = tolua.cast(var_6_2:getChildByTag(6), "CCSprite")
		arg_3_0.lbDesc = tolua.cast(var_6_2:getChildByTag(7), "CCLabelTTF")
		arg_3_0.effectDrawAckNode = tolua.cast(var_6_2:getChildByTag(8), "CCNode")
		arg_3_0.effectbgNode = tolua.cast(var_6_2:getChildByTag(9), "CCNode")

		arg_3_0.btnPreView:addHandleOfControlEvent(function()
			arg_3_0:onPreView()
		end, CCControlEventTouchUpInside)
		arg_3_0:addChild(var_6_1)
		arg_3_0:addBtnChat(var_6_1)
		arg_3_0:createMoneyPanel(var_6_1, {
			EMoneyPanelResType.Diamond,
			EMoneyPanelResType.BarMoney,
			EMoneyPanelResType.BarCard
		}, function()
			arg_3_0:onClose()
		end)
		arg_3_0:createDrawEffect(var_0_1)
		arg_3_0:createDrawAckEffect()
		arg_3_0.lbDesc:setString(a2u("\xB6\xD4ľͷ\xB4߸\xFC\xA3\xAC\xBFɻ\xF1\xB5\xC3\xCB\xFB\xBB\xAD\xB3\xF6\xB5\xC4\xCE\xEFƷ\xBB\xF2\xBF\xA8\xC5\xC6"))
	end

	var_3_0()
	var_3_2()
	arg_3_0:setShowCallback(handler(arg_3_0, arg_3_0.doShow))
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onBarDrawAck()
	end, zbGameEvent.Event_BarDraw_Ack)
end

function var_0_0.doShow(arg_11_0)
	arg_11_0:setDrawNodeVisible(true)
end

function var_0_0.setShareUiVisible(arg_12_0, arg_12_1)
	arg_12_0:setDrawNodeVisible(arg_12_1)
	arg_12_0.nodeBottom:setVisible(arg_12_1)
	arg_12_0.spriteBg:setVisible(arg_12_1)
	arg_12_0.lbDesc:setVisible(arg_12_1)
	arg_12_0.effectDrawAckNode:setVisible(arg_12_1)

	if arg_12_0.btnChat then
		arg_12_0.btnChat:setVisible(arg_12_1)
	end

	if arg_12_0.moneyPanel then
		arg_12_0.moneyPanel:setLayerVisible(arg_12_1)
	end
end

function var_0_0.onClose(arg_13_0)
	arg_13_0:stopAllActions()
	arg_13_0:hide()
end

function var_0_0.setDrawNodeVisible(arg_14_0, arg_14_1)
	arg_14_0.nodeBottom:setVisible(arg_14_1)
	arg_14_0.alphaLayer:setVisible(not arg_14_1)
end

function var_0_0.onFrameUpdate(arg_15_0, arg_15_1)
	if g_GameStateMachine:isOneSecondPassed() == false then
		return
	end

	arg_15_0:refresh()
end

function var_0_0.refresh(arg_16_0)
	if zbUtil:isValidTable(g_GameData.BarInfo) == false then
		return
	end

	for iter_16_0 = EBarDrawType.NormalSingle, EBarDrawType.DiamondSingle do
		arg_16_0.notifyPub[iter_16_0]:setVisible(false)
		arg_16_0.lbtimedesc[iter_16_0]:setVisible(true)

		local var_16_0 = g_GameData.BarInfo.BarList[iter_16_0]

		arg_16_0.lbMoney[iter_16_0]:setString("x" .. var_16_0.SinglePrice)

		if iter_16_0 == EBarDrawType.DiamondSingle then
			if g_GameData.Wealth.BarMoney >= var_16_0.BarMoneyPrice then
				arg_16_0.spriteMoney[2]:setTexture(CCTextureCache:sharedTextureCache():addImage("image/common/money_barmoney.png"))
				arg_16_0.lbMoney[2]:setString("x" .. var_16_0.BarMoneyPrice)
			else
				arg_16_0.spriteMoney[2]:setTexture(CCTextureCache:sharedTextureCache():addImage("image/common/money_diamond.png"))
			end
		end

		if var_16_0.FreeCount >= var_16_0.FreeTotalCount then
			arg_16_0.nodemoney[iter_16_0]:setVisible(true)
			arg_16_0.lbtimes[iter_16_0]:setVisible(false)
			arg_16_0.lbtimedesc[iter_16_0]:setVisible(true)

			if var_16_0.IsMoneyFirst then
				if iter_16_0 == EBarDrawType.NormalSingle then
					arg_16_0.lbtimedesc[iter_16_0]:setString(a2u(""))
				else
					arg_16_0.lbtimedesc[iter_16_0]:setString(a2u("\xCA׳\xE9\xB1صû\xEF\xB0\xE9"))
				end
			end
		else
			local var_16_1 = math.max(var_16_0.NextFreeTm - g_Self.kTimeHandler:getServerTime(), 0)

			if var_16_0.NextFreeTm == 0 or var_16_1 <= 0 then
				arg_16_0.notifyPub[iter_16_0]:setVisible(true)
				arg_16_0.nodemoney[iter_16_0]:setVisible(false)
				arg_16_0.lbtimes[iter_16_0]:setVisible(true)

				if iter_16_0 == EBarDrawType.DiamondSingle then
					arg_16_0.lbtimes[iter_16_0]:setString(a2u("\xC3\xE2\xB7ѳ\xE9ȡ"))
				else
					local var_16_2 = math.max(var_16_0.FreeTotalCount - var_16_0.FreeCount, 0)

					arg_16_0.lbtimes[iter_16_0]:setString(a2u("\xC3\xE2\xB7Ѵ\xCE\xCA\xFD:") .. var_16_2 .. "/" .. var_16_0.FreeTotalCount)
				end

				arg_16_0.lbtimedesc[iter_16_0]:setVisible(false)
			else
				arg_16_0.nodemoney[iter_16_0]:setVisible(true)
				arg_16_0.lbtimes[iter_16_0]:setVisible(false)

				local var_16_3 = zbUtil:SprintfHHMMSSNo24(var_16_1)

				arg_16_0.lbtimedesc[iter_16_0]:setString(var_16_3 .. a2u("\xBA\xF3\xC3\xE2\xB7\xD1"))
			end
		end
	end

	local var_16_4 = g_GameData.BarInfo.BarList[EBarDrawType.DiamondSingle]

	if var_16_4 then
		if g_GameData.Wealth.BarMoney >= var_16_4.BarMoneyPrice * 10 then
			arg_16_0.spriteMoney[3]:setTexture(CCTextureCache:sharedTextureCache():addImage("image/common/money_barmoney.png"))
			arg_16_0.lbMoney[3]:setString("x" .. var_16_4.BarMoneyPrice * 10)
		else
			arg_16_0.spriteMoney[3]:setTexture(CCTextureCache:sharedTextureCache():addImage("image/common/money_diamond.png"))
			arg_16_0.lbMoney[3]:setString("x" .. var_16_4.TenPrice)
		end
	end
end

function var_0_0.createDrawEffect(arg_17_0, arg_17_1)
	arg_17_0.effectbg = createUIAnimation()

	arg_17_0.effectbg:refresh("effect/spine/ui_chouka/chouka_01/chouka_01.json", "effect/spine/ui_chouka/chouka_01/chouka_01.atlas")
	arg_17_0.effectbg:setPosition(0, 0)
	arg_17_0.effectbg:setAnchorPoint(ccp(0, 0))
	arg_17_0.effectbg:setAnimation(arg_17_1, true)
	arg_17_0.effectbgNode:addChild(arg_17_0.effectbg)
end

function var_0_0.createDrawAckEffect(arg_18_0)
	arg_18_0.effectdrawAck = createUIAnimation()

	arg_18_0.effectdrawAck:refresh("effect/spine/ui_chouka/chouka_02/chouka_02.json", "effect/spine/ui_chouka/chouka_02/chouka_02.atlas")
	arg_18_0.effectdrawAck:setPosition(0, 0)
	arg_18_0.effectdrawAck:setAnchorPoint(ccp(0.5, 0))
	arg_18_0.effectDrawAckNode:addChild(arg_18_0.effectdrawAck)
end

function var_0_0.onBarDrawAck(arg_19_0)
	arg_19_0:refresh()

	local function var_19_0()
		arg_19_0.effectdrawAck:setAnimation("animation", false)
	end

	local function var_19_1()
		if arg_19_0.effectbg then
			arg_19_0.effectbg:setAnimation(var_0_1, true)
		end

		local var_21_0 = g_Self.kPubHandler.AwardList

		if arg_19_0.barDrawType == EBarDrawType.NormalSingle or arg_19_0.barDrawType == EBarDrawType.DiamondSingle then
			local var_21_1

			if zbUtil:isValidTable(var_21_0) and table.getn(var_21_0) > 0 then
				var_21_1 = var_21_0[1]
			end

			if var_21_1 then
				if var_21_1.Type == ECommonAwardType.Hero then
					g_MainScene:showPubGetHeroWnd(var_21_1, false, true, g_Self.kPubHandler.callBack, true)
				else
					g_MainScene:showPubGetItemWnd(var_21_1)
				end
			end
		else
			g_MainScene:showPubGetTenWnd(var_21_0)
		end
	end

	if arg_19_0.effectbg then
		arg_19_0.effectbg:setAnimation(var_0_2, true)
	end

	local var_19_2 = CCDelayTime:create(1)
	local var_19_3 = CCCallFuncN:create(var_19_0)
	local var_19_4 = CCDelayTime:create(2)
	local var_19_5 = CCCallFuncN:create(var_19_1)
	local var_19_6 = CCArray:create()

	var_19_6:addObject(var_19_2)
	var_19_6:addObject(var_19_3)
	var_19_6:addObject(var_19_4)
	var_19_6:addObject(var_19_5)

	local var_19_7 = CCSequence:create(var_19_6)

	arg_19_0:stopAllActions()
	arg_19_0:setDrawNodeVisible(false)
	arg_19_0:runAction(var_19_7)
end

function var_0_0.onPub(arg_22_0, arg_22_1)
	arg_22_0.barDrawType = arg_22_1

	if EBarDrawType.NormalSingle == arg_22_1 then
		local var_22_0 = g_GameData.BarInfo.BarList[arg_22_1]

		if var_22_0 == nil then
			return
		end

		local var_22_1 = math.max(var_22_0.NextFreeTm - g_Self.kTimeHandler:getServerTime(), 0)

		if (var_22_0.FreeCount >= var_22_0.FreeTotalCount or var_22_1 > 0) and var_22_0.SinglePrice > g_GameData.Wealth.BarCard then
			g_Bubble:bubbleInfo(a2u("\xBB\xBD\xC1\xE9ʯ\xB2\xBB\xD7\xE3"))

			return
		end
	elseif EBarDrawType.DiamondSingle == arg_22_1 then
		local var_22_2 = g_GameData.BarInfo.BarList[arg_22_1]

		if var_22_2 == nil then
			return
		end

		local var_22_3 = math.max(var_22_2.NextFreeTm - g_Self.kTimeHandler:getServerTime(), 0)

		if (var_22_2.FreeCount >= var_22_2.FreeTotalCount or var_22_3 > 0) and g_GameData.Wealth.BarMoney < var_22_2.BarMoneyPrice and var_22_2.SinglePrice > g_GameData.Wealth.Diamond then
			g_Bubble:bubbleInfo(a2u("\xD7\xEAʯ\xB2\xBB\xD7\xE3"))

			return
		end
	else
		local var_22_4 = g_GameData.BarInfo.BarList[EBarDrawType.DiamondSingle]

		if var_22_4 == nil then
			return
		end

		if g_GameData.Wealth.BarMoney < var_22_4.BarMoneyPrice * 10 and var_22_4.TenPrice > g_GameData.Wealth.Diamond then
			g_Bubble:bubbleInfo(a2u("\xD7\xEAʯ\xB2\xBB\xD7\xE3"))

			return
		end
	end

	g_WsMsgHandler:WS_Bar_Draw_Req(arg_22_1)
end

function var_0_0.onPreView(arg_23_0)
	g_MainScene:showHeroHandbookWnd()
end
