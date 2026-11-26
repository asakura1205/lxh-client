local var_0_0 = class("zbFriendJhItem")

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

function createFriendJhItem(arg_2_0)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.data = nil
	end

	local function var_3_1()
		local function var_5_0(arg_6_0, arg_6_1)
			local var_6_0 = CCSprite:create(arg_6_1)

			var_6_0:setAnchorPoint(ccp(0, 0))

			local var_6_1 = CCProgressTimer:create(var_6_0)

			var_6_1:setAnchorPoint(ccp(0, 0))
			var_6_1:setPercentage(0)
			var_6_1:setMidpoint(ccp(0, 1))
			var_6_1:setBarChangeRate(ccp(1, 0))
			var_6_1:setType(kCCProgressTimerTypeBar)
			var_6_1:retain()
			arg_6_0:addChild(var_6_1)

			return var_6_1
		end

		local var_5_1 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		arg_3_0.layerContent = var_5_1
		arg_3_0.intimacy = tolua.cast(var_5_1:getChildByTag(1), "CCSprite")
		arg_3_0.headIcon = tolua.cast(var_5_1:getChildByTag(2), "CCSprite")
		arg_3_0.lbname = tolua.cast(var_5_1:getChildByTag(3), "CCLabelTTF")

		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1004), "CCLabelTTF")
		local var_5_3 = tolua.cast(var_5_1:getChildByTag(4), "CCNode")
		local var_5_4 = tolua.cast(var_5_3:getChildByTag(1001), "CCLabelTTF")
		local var_5_5 = tolua.cast(var_5_1:getChildByTag(5), "CCNode")

		arg_3_0.nextIntimacy = tolua.cast(var_5_5:getChildByTag(3), "CCSprite")
		arg_3_0.lblprogress = tolua.cast(var_5_5:getChildByTag(1005), "CCLabelTTF")
		arg_3_0.spriteBarBg = tolua.cast(var_5_5:getChildByTag(2), "CCSprite")
		arg_3_0.spriteBar = var_5_0(arg_3_0.spriteBarBg, "image/common/progress147x25.png")
		arg_3_0.lbLvRep = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_2, arg_3_0.lbLvRep)
		arg_3_0.lbLvRep:setScale(0.4)

		arg_3_0.vipRep = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_4, arg_3_0.vipRep)
		arg_3_0.vipRep:setScale(0.55)

		arg_3_0.btnJiaohu = tolua.cast(var_5_1:getChildByTag(1007), "CCControlButton")

		arg_3_0.btnJiaohu:addHandleOfControlEvent(function()
			arg_3_0:onJiaohu()
		end, CCControlEventTouchUpInside)
		arg_3_0:setContentSize(var_5_1:getContentSize())
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_8_0, arg_8_1)
	arg_8_0.data = arg_8_1

	arg_8_0:setVisible(arg_8_0.data ~= nil)

	if arg_8_0.data then
		local var_8_0 = zbIconHelper:getPlayerHeadIconPath(arg_8_1.PlayerBaseInfo.HeadId)

		arg_8_0.headIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_8_0))

		local var_8_1 = arg_8_1.FriendsBaseData.Level

		g_Self.kFriendHandler:setIntimacyIcon(arg_8_0.intimacy, var_8_1 + 1)
		arg_8_0.lbLvRep:setString(arg_8_1.PlayerBaseInfo.Level)
		arg_8_0.lbname:setString(a2u(arg_8_1.PlayerBaseInfo.RoleName))
		arg_8_0.vipRep:setString(arg_8_1.PlayerBaseInfo.VipLevel)

		local var_8_2 = arg_8_1.FriendsBaseData.Level + 1
		local var_8_3 = arg_8_1.FriendsBaseData.Level
		local var_8_4 = var_8_3 + 2

		if var_8_4 >= 6 then
			var_8_4 = 6
		end

		g_Self.kFriendHandler:setIntimacyIcon(arg_8_0.nextIntimacy, var_8_4)

		local var_8_5 = g_Self.kFriendHandler:getFriendlyByLv(var_8_3)
		local var_8_6 = arg_8_1.FriendsBaseData.Friendly

		arg_8_0.lblprogress:setString(var_8_6 .. "/" .. var_8_5)

		local var_8_7 = math.min(math.ceil(100 * (var_8_6 / var_8_5)), 100)

		arg_8_0.spriteBar:setPercentage(var_8_7)

		if arg_8_1.FriendsBaseData.ActionCount >= g_DataConfig.m_kCommonCfg.friendsConfig.actionLimit then
			zbUtil:setButtonTitle(arg_8_0.btnJiaohu, a2u("\xD2ѻ\xA5\xB6\xAF"))
			arg_8_0.btnJiaohu:setGray(true)
		else
			zbUtil:setButtonTitle(arg_8_0.btnJiaohu, a2u("\xBB\xA5\xB6\xAF"))
			arg_8_0.btnJiaohu:setGray(false)
		end
	end
end

function var_0_0.onJiaohu(arg_9_0)
	if arg_9_0.data then
		g_MainScene:showFriendJiohuWnd(arg_9_0.data):setPrevWnd(g_MainScene.wndFriend)
	end
end
