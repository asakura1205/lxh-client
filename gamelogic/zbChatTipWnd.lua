require("gamelogic.zbBaseWnd")
require("gamelogic.zbItem")

local var_0_0 = class("zbChatTipWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function var_0_0.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, var_0_0)

	return arg_1_0
end

function createChatTipWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNodeRGBA:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.chatDetail = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/chattip.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner", false, false)
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.layer = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)

		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCNode")

		arg_3_0.headIcon = tolua.cast(var_5_3:getChildByTag(1), "CCSprite")
		arg_3_0.lblname = tolua.cast(var_5_3:getChildByTag(3), "CCLabelTTF")

		local var_5_4 = tolua.cast(var_5_3:getChildByTag(2), "CCSprite")

		arg_3_0.lbllv = tolua.cast(var_5_4:getChildByTag(1001), "CCLabelTTF")

		local var_5_5 = tolua.cast(var_5_3:getChildByTag(4), "CCNode")
		local var_5_6 = tolua.cast(var_5_5:getChildByTag(1001), "CCLabelTTF")

		arg_3_0.vipRep = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_6, arg_3_0.vipRep)
		arg_3_0.vipRep:setScale(0.55)

		arg_3_0.lbllegionname = tolua.cast(var_5_3:getChildByTag(1005), "CCLabelTTF")
		arg_3_0.lblfightvalue = tolua.cast(var_5_3:getChildByTag(1006), "CCLabelTTF")
		arg_3_0.lbllasttm = tolua.cast(var_5_3:getChildByTag(1007), "CCLabelTTF")

		local var_5_7 = tolua.cast(var_5_2:getChildByTag(3), "CCNode")

		arg_3_0.btnchat = tolua.cast(var_5_7:getChildByTag(1), "CCControlButton")
		arg_3_0.btnchanlenge = tolua.cast(var_5_7:getChildByTag(2), "CCControlButton")
		arg_3_0.btnAddFriend = tolua.cast(var_5_7:getChildByTag(3), "CCControlButton")

		arg_3_0.btnchat:addHandleOfControlEvent(function()
			arg_3_0:onChat()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnAddFriend:addHandleOfControlEvent(function()
			arg_3_0:onAddFriend()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnchanlenge:addHandleOfControlEvent(function()
			arg_3_0:onChanlenge()
		end, CCControlEventTouchUpInside)

		local var_5_8 = tolua.cast(var_5_2:getChildByTag(2), "CCNode")

		arg_3_0.formationItems = {}

		for iter_5_0 = 1, 5 do
			local var_5_9 = tolua.cast(var_5_8:getChildByTag(iter_5_0), "CCLayerColor")
			local var_5_10 = createItem()
			local var_5_11 = ccp(var_5_9:getPosition())

			var_5_10:setPosition(var_5_11.x, var_5_11.y)
			var_5_10:setAnchorPoint(ccp(0.5, 0.5))
			var_5_8:addChild(var_5_10)
			var_5_10:setVisible(false)

			arg_3_0.formationItems[iter_5_0] = var_5_10

			arg_3_0.formationItems[iter_5_0]:setScale(0.8)
			var_5_9:removeFromParentAndCleanup(true)
		end

		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onUpdateFormationInfo()
	end, zbGameEvent.Event_ChatBaseFormationAck)
end

function var_0_0.refresh(arg_12_0, arg_12_1)
	arg_12_0.chatDetail = arg_12_1

	if arg_12_1 then
		g_Self.kChatHandler.bChatBaseFormationInfoReq = true

		g_WsMsgHandler:WS_Player_Formation_Req(arg_12_1.SenderId)

		local var_12_0 = zbIconHelper:getPlayerHeadIconPath(arg_12_1.SenderHeadId)

		arg_12_0.headIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_12_0))
		arg_12_0.lblname:setString(a2u(arg_12_1.SenderName))
		arg_12_0.lbllv:setString(arg_12_1.SenderLevel)
		arg_12_0.vipRep:setString(arg_12_1.SenderVipLevel)
		arg_12_0.lbllasttm:setVisible(false)
		arg_12_0.lblfightvalue:setVisible(false)
		arg_12_0.lbllegionname:setVisible(false)

		for iter_12_0, iter_12_1 in pairs(arg_12_0.formationItems) do
			iter_12_1:setVisible(false)
		end
	end
end

function var_0_0.onUpdateFormationInfo(arg_13_0)
	if PlayerFormationInfo then
		if type(PlayerFormationInfo.PlayerTipsInfo.LegionName) == "string" then
			arg_13_0.lbllegionname:setString(PlayerFormationInfo.PlayerTipsInfo.LegionName)
			arg_13_0.lbllegionname:setVisible(true)
		end

		if PlayerFormationInfo.PlayerTipsInfo.Online == "1" then
			arg_13_0.lbllasttm:setString(a2u("\xD4\xDA\xCF\xDF"))
		else
			local var_13_0 = math.max(g_Self.kTimeHandler:getServerTime() - PlayerFormationInfo.PlayerTipsInfo.LastTm - g_Self.kTimeHandler:getTimeZoneDelt(), 0)
			local var_13_1 = zbUtil:getPassTimeShort(var_13_0)

			arg_13_0.lbllasttm:setString(a2u(var_13_1))
		end

		arg_13_0.lblfightvalue:setString(PlayerFormationInfo.PlayerTipsInfo.FV)
		arg_13_0.lbllasttm:setVisible(true)
		arg_13_0.lblfightvalue:setVisible(true)

		local var_13_2 = 1

		for iter_13_0 = 1, table.getn(PlayerFormationInfo.HeroList) do
			local var_13_3 = PlayerFormationInfo.HeroList[iter_13_0]

			arg_13_0.formationItems[var_13_2]:setVisible(true)
			arg_13_0.formationItems[var_13_2]:refreshHero(var_13_3)

			var_13_2 = var_13_2 + 1
		end
	end
end

function var_0_0.onChat(arg_14_0)
	arg_14_0:hide()

	local var_14_0 = g_MainScene:showChat()
	local var_14_1 = {
		Level = PlayerFormationInfo.PlayerTipsInfo.Level,
		VipLevel = PlayerFormationInfo.PlayerTipsInfo.VipLevel,
		RoleName = PlayerFormationInfo.PlayerTipsInfo.RoleName,
		HeadId = PlayerFormationInfo.PlayerTipsInfo.HeadId,
		playerId = PlayerFormationInfo.PlayerTipsInfo.PlayerId
	}

	var_14_0:showChatPrivate(var_14_1)
end

function var_0_0.onAddFriend(arg_15_0)
	if g_Self:getLevel() < OPEN_FRIENDS_LEVEL then
		g_Bubble:bubbleInfo(a2u("\xBCӺ\xC3\xD3\xD1") .. OPEN_FRIENDS_LEVEL .. a2u("\xBC\xB6\xBF\xAA\xB7\xC5"))

		return
	end

	if arg_15_0.chatDetail then
		g_WsMsgHandler:WS_Friends_Apply_Req(arg_15_0.chatDetail.SenderId)
	end
end

function var_0_0.onChanlenge(arg_16_0)
	if PlayerFormationInfo then
		g_MainScene:showEmbattleChat(PlayerFormationInfo)
		arg_16_0:hide()

		if g_MainScene.wndChat then
			g_MainScene.wndChat:hide()
		end
	end
end

function var_0_0.onTouchTest(arg_17_0)
	local var_17_0 = arg_17_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_17_0.layer, var_17_0.x, var_17_0.y) == false then
		arg_17_0:hide()
	end
end
