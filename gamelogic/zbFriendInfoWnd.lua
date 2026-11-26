require("gamelogic.zbBaseWnd")
require("gamelogic.zbItem")

local var_0_0 = class("zbFriendInfoWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createFriendInfoWnd()
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
		arg_3_0.frienddata = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/friendinfo.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1, "CCNode")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCLayer")

		arg_3_0.layerTouchTest = var_5_3
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.btnClose = tolua.cast(var_5_3:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)

		local var_5_4 = tolua.cast(var_5_3:getChildByTag(1), "CCNode")

		arg_3_0.headIcon = tolua.cast(var_5_4:getChildByTag(1), "CCSprite")
		arg_3_0.lblname = tolua.cast(var_5_4:getChildByTag(3), "CCLabelTTF")

		local var_5_5 = tolua.cast(var_5_4:getChildByTag(2), "CCSprite")

		arg_3_0.lbllv = tolua.cast(var_5_5:getChildByTag(1001), "CCLabelTTF")

		local var_5_6 = tolua.cast(var_5_4:getChildByTag(4), "CCNode")
		local var_5_7 = tolua.cast(var_5_6:getChildByTag(1001), "CCLabelTTF")

		arg_3_0.vipRep = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_7, arg_3_0.vipRep)
		arg_3_0.vipRep:setScale(0.55)

		arg_3_0.lbllegionname = tolua.cast(var_5_4:getChildByTag(1005), "CCLabelTTF")
		arg_3_0.lblfightvalue = tolua.cast(var_5_4:getChildByTag(1006), "CCLabelTTF")
		arg_3_0.lbllasttm = tolua.cast(var_5_4:getChildByTag(1007), "CCLabelTTF")

		local var_5_8 = tolua.cast(var_5_3:getChildByTag(3), "CCNode")

		arg_3_0.btnchat = tolua.cast(var_5_8:getChildByTag(1), "CCControlButton")
		arg_3_0.btnchanlenge = tolua.cast(var_5_8:getChildByTag(2), "CCControlButton")
		arg_3_0.btnjh = tolua.cast(var_5_8:getChildByTag(3), "CCControlButton")
		arg_3_0.btnDelfriend = tolua.cast(var_5_8:getChildByTag(4), "CCControlButton")

		arg_3_0.btnchat:addHandleOfControlEvent(function()
			arg_3_0:onChat()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnjh:addHandleOfControlEvent(function()
			arg_3_0:onJiaohu()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnchanlenge:addHandleOfControlEvent(function()
			arg_3_0:onChanlenge()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnDelfriend:addHandleOfControlEvent(function()
			arg_3_0:onDelFriend()
		end, CCControlEventTouchUpInside)

		local var_5_9 = tolua.cast(var_5_3:getChildByTag(2), "CCNode")

		arg_3_0.formationItems = {}

		for iter_5_0 = 1, 5 do
			local var_5_10 = tolua.cast(var_5_9:getChildByTag(iter_5_0), "CCLayerColor")
			local var_5_11 = createItem()
			local var_5_12 = ccp(var_5_10:getPosition())

			var_5_11:setPosition(var_5_12.x, var_5_12.y)
			var_5_11:setAnchorPoint(ccp(0.5, 0.5))
			var_5_9:addChild(var_5_11)
			var_5_11:setVisible(false)

			arg_3_0.formationItems[iter_5_0] = var_5_11

			arg_3_0.formationItems[iter_5_0]:setScale(0.8)
			var_5_10:removeFromParentAndCleanup(true)
		end

		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(function()
		arg_3_0:onShowCallback()
	end)
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onUpdateFormationInfo()
	end, zbGameEvent.Event_FriendBaseFormationAck)
end

function var_0_0.refresh(arg_14_0, arg_14_1)
	arg_14_0.frienddata = arg_14_1

	if arg_14_1 then
		g_Self.kFriendHandler.bfriendBaseFormationInfoReq = true

		g_WsMsgHandler:WS_Player_Formation_Req(arg_14_1.PlayerBaseInfo.PlayerId)

		local var_14_0 = zbIconHelper:getPlayerHeadIconPath(arg_14_1.PlayerBaseInfo.HeadId)

		arg_14_0.headIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_14_0))
		arg_14_0.lblname:setString(a2u(arg_14_1.PlayerBaseInfo.RoleName))
		arg_14_0.lbllv:setString(arg_14_1.PlayerBaseInfo.Level)
		arg_14_0.vipRep:setString(arg_14_1.PlayerBaseInfo.VipLevel)
		arg_14_0.lblfightvalue:setString(arg_14_1.PlayerBaseInfo.FV)

		if arg_14_1.PlayerBaseInfo.Online == "1" then
			arg_14_0.lbllasttm:setString(a2u("\xD4\xDA\xCF\xDF"))
		else
			local var_14_1 = math.max(g_Self.kTimeHandler:getServerTime() - arg_14_1.PlayerBaseInfo.LastTm - g_Self.kTimeHandler:getTimeZoneDelt(), 0)
			local var_14_2 = zbUtil:getPassTimeShort(var_14_1)

			arg_14_0.lbllasttm:setString(a2u(var_14_2))
		end

		arg_14_0.lbllegionname:setVisible(false)

		for iter_14_0, iter_14_1 in pairs(arg_14_0.formationItems) do
			iter_14_1:setVisible(false)
		end
	end
end

function var_0_0.onUpdateFormationInfo(arg_15_0)
	if PlayerFormationInfo then
		if type(PlayerFormationInfo.PlayerTipsInfo.LegionName) == "string" then
			arg_15_0.lbllegionname:setString(PlayerFormationInfo.PlayerTipsInfo.LegionName)
			arg_15_0.lbllegionname:setVisible(true)
		end

		local var_15_0 = 1

		for iter_15_0 = 1, table.getn(PlayerFormationInfo.HeroList) do
			local var_15_1 = PlayerFormationInfo.HeroList[iter_15_0]

			arg_15_0.formationItems[var_15_0]:setVisible(true)
			arg_15_0.formationItems[var_15_0]:refreshHero(var_15_1)

			var_15_0 = var_15_0 + 1
		end
	end
end

function var_0_0.onShowCallback(arg_16_0)
	return
end

function var_0_0.onChat(arg_17_0)
	if arg_17_0.frienddata then
		arg_17_0:hide()
		g_MainScene.wndFriend:hide()

		local var_17_0 = g_MainScene:showChat()
		local var_17_1 = {
			Level = arg_17_0.frienddata.PlayerBaseInfo.Level,
			VipLevel = arg_17_0.frienddata.PlayerBaseInfo.VipLevel,
			RoleName = arg_17_0.frienddata.PlayerBaseInfo.RoleName,
			HeadId = arg_17_0.frienddata.PlayerBaseInfo.HeadId,
			playerId = arg_17_0.frienddata.PlayerBaseInfo.PlayerId
		}

		var_17_0:showChatPrivate(var_17_1)
	end
end

function var_0_0.onChanlenge(arg_18_0)
	if PlayerFormationInfo then
		g_MainScene:showEmbattleFriend(PlayerFormationInfo)
		arg_18_0:hide()
		g_MainScene.wndFriend:hide()
	end
end

function var_0_0.onJiaohu(arg_19_0)
	if arg_19_0.frienddata then
		g_MainScene:showFriendJiohuWnd(arg_19_0.frienddata):setPrevWnd(arg_19_0)
	end
end

function var_0_0.onDelFriend(arg_20_0)
	if arg_20_0.frienddata then
		arg_20_0:hide()

		local function var_20_0()
			g_WsMsgHandler:WS_Friends_Delete_Req(arg_20_0.frienddata.PlayerBaseInfo.PlayerId)
		end

		local var_20_1 = string.format(a2u("ȷ\xB6\xA8ɾ\xB3\xFD\xBA\xC3\xD3\xD1[color=0xff0000]%s[/color]\xC2\xF0\xA3\xBF"), a2u(arg_20_0.frienddata.PlayerBaseInfo.RoleName))

		g_MessageBox:showYesNo(a2u(var_20_1), var_20_0)
	end
end

function var_0_0.onTouchTest(arg_22_0)
	local var_22_0 = arg_22_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_22_0.layerTouchTest, var_22_0.x, var_22_0.y) == false and zbUtil:PointInCtrl(arg_22_0.btnClose, var_22_0.x, var_22_0.y) == false then
		arg_22_0:hide()
	end
end
