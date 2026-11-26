local var_0_0 = class("zbFriendItem")

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

function createFriendItem(arg_2_0)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.friendBaseData = nil
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		arg_3_0.layerContent = var_5_0
		arg_3_0.btnTouch = tolua.cast(var_5_0:getChildByTag(100), "CCControlButton")
		arg_3_0.intimacy = tolua.cast(var_5_0:getChildByTag(1), "CCSprite")
		arg_3_0.headIcon = tolua.cast(var_5_0:getChildByTag(2), "CCSprite")
		arg_3_0.lbname = tolua.cast(var_5_0:getChildByTag(3), "CCLabelTTF")

		local var_5_1 = tolua.cast(var_5_0:getChildByTag(1004), "CCLabelTTF")

		arg_3_0.lbLastTime = tolua.cast(var_5_0:getChildByTag(1005), "CCLabelTTF")
		arg_3_0.lbLvRep = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_1, arg_3_0.lbLvRep)
		arg_3_0.lbLvRep:setScale(0.55)

		arg_3_0.btnGet = tolua.cast(var_5_0:getChildByTag(1006), "CCControlButton")
		arg_3_0.btnGive = tolua.cast(var_5_0:getChildByTag(1007), "CCControlButton")

		arg_3_0.btnGet:addHandleOfControlEvent(function()
			arg_3_0:onGetTili()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnGive:addHandleOfControlEvent(function()
			arg_3_0:onGiveTili()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnTouch:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnTouch:setSwallowsTouches(false)
		arg_3_0:setContentSize(var_5_0:getContentSize())
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_9_0, arg_9_1)
	arg_9_0.friendBaseData = arg_9_1

	arg_9_0:setVisible(arg_9_0.friendBaseData ~= nil)

	if arg_9_0.friendBaseData ~= nil then
		local var_9_0 = zbIconHelper:getPlayerHeadIconPath(arg_9_1.PlayerBaseInfo.HeadId)

		arg_9_0.headIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_9_0))
		arg_9_0.lbname:setString(a2u(arg_9_1.PlayerBaseInfo.RoleName))
		arg_9_0.lbLvRep:setString(arg_9_1.PlayerBaseInfo.Level)

		local var_9_1 = arg_9_1.FriendsBaseData.Level

		g_Self.kFriendHandler:setIntimacyIcon(arg_9_0.intimacy, var_9_1 + 1)

		if arg_9_1.PlayerBaseInfo.Online == 1 then
			arg_9_0.lbLastTime:setString(a2u("\xD4\xDA\xCF\xDF"))
		else
			local var_9_2 = math.max(g_Self.kTimeHandler:getServerTime() - arg_9_1.PlayerBaseInfo.LastTm - g_Self.kTimeHandler:getTimeZoneDelt(), 0)
			local var_9_3 = zbUtil:getPassTimeShort(var_9_2)

			arg_9_0.lbLastTime:setString(var_9_3)
		end

		arg_9_0.btnGet:setGray(false)
		arg_9_0.btnGet:setEnabled(true)
		arg_9_0.btnGet:setVisible(true)
		zbUtil:setButtonTitle(arg_9_0.btnGet, a2u("\xC1\xECȡ"))
		zbUtil:setButtonTitle(arg_9_0.btnGive, a2u("\xD4\xF9\xCB\xCD"))

		if arg_9_1.FriendsBaseData.GetTili == 1 then
			arg_9_0.btnGet:setGray(true)
			arg_9_0.btnGet:setEnabled(false)
			zbUtil:setButtonTitle(arg_9_0.btnGet, a2u("\xD2\xD1\xC1\xECȡ"))
		elseif arg_9_1.FriendsBaseData.GetTili == 2 then
			arg_9_0.btnGet:setVisible(false)
		end

		if arg_9_1.FriendsBaseData.GiveTili == 1 then
			arg_9_0.btnGive:setGray(true)
			arg_9_0.btnGive:setEnabled(false)
			zbUtil:setButtonTitle(arg_9_0.btnGive, a2u("\xD2\xD1\xD4\xF9\xCB\xCD"))
		end
	end
end

function var_0_0.onGetTili(arg_10_0)
	if arg_10_0.friendBaseData then
		g_WsMsgHandler:WS_Friends_GetTili_Req(arg_10_0.friendBaseData.PlayerBaseInfo.PlayerId)
	end
end

function var_0_0.onGiveTili(arg_11_0)
	if arg_11_0.friendBaseData then
		if g_Self.kFriendHandler.frienddata and g_Self.kFriendHandler.frienddata.FriendsBaseInfo and g_Self.kFriendHandler.frienddata.FriendsBaseInfo.TiliCount >= g_DataConfig.m_kCommonCfg.friendsConfig.tiliMax then
			g_Bubble:bubbleInfo(a2u("\xD2Ѵ\xEF\xD7\xEE\xB4\xF3\xD4\xF9\xCBʹ\xCE\xCA\xFD"))

			return
		end

		g_WsMsgHandler:WS_Friends_GiveTili_Req(arg_11_0.friendBaseData.PlayerBaseInfo.PlayerId)
	end
end

function var_0_0.onTouch(arg_12_0)
	if arg_12_0.friendBaseData then
		g_MainScene:showFriendInfo(arg_12_0.friendBaseData):setPrevWnd(g_MainScene.wndFriend)
	end
end
