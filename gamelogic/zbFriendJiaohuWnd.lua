require("gamelogic.zbBaseWnd")
require("gamelogic.zbChatContent")

local var_0_0 = class("zbFriendJiaohuWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createFriendJiaohuWnd()
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
		local var_5_1 = CCBReaderLoad("ccbi/friendjiaohuinfo.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1, "CCNode")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCLayer")

		arg_3_0.layerTouchTest = var_5_3
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.btnClose = tolua.cast(var_5_3:getChildByTag(1), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)

		local var_5_4 = tolua.cast(var_5_3:getChildByTag(2), "CCNode")

		arg_3_0.headIcon = tolua.cast(var_5_4:getChildByTag(1), "CCSprite")

		local var_5_5 = tolua.cast(var_5_4:getChildByTag(2), "CCSprite")

		arg_3_0.lbllv = tolua.cast(var_5_5:getChildByTag(1), "CCLabelTTF")
		arg_3_0.lblname = tolua.cast(var_5_4:getChildByTag(3), "CCLabelTTF")

		local var_5_6 = tolua.cast(var_5_4:getChildByTag(4), "CCNode")
		local var_5_7 = tolua.cast(var_5_6:getChildByTag(1), "CCLabelTTF")

		arg_3_0.vipRep = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_7, arg_3_0.vipRep)
		arg_3_0.vipRep:setScale(0.55)

		local var_5_8 = tolua.cast(var_5_4:getChildByTag(5), "CCNode")

		arg_3_0.curIntimacy = tolua.cast(var_5_8:getChildByTag(1), "CCSprite")
		arg_3_0.nextIntimacy = tolua.cast(var_5_8:getChildByTag(3), "CCSprite")
		arg_3_0.lblprogress = tolua.cast(var_5_8:getChildByTag(4), "CCLabelTTF")

		local function var_5_9(arg_8_0, arg_8_1)
			local var_8_0 = CCSprite:create(arg_8_1)

			var_8_0:setAnchorPoint(ccp(0, 0))

			local var_8_1 = CCProgressTimer:create(var_8_0)

			var_8_1:setAnchorPoint(ccp(0, 0))
			var_8_1:setPercentage(0)
			var_8_1:setMidpoint(ccp(0, 1))
			var_8_1:setBarChangeRate(ccp(1, 0))
			var_8_1:setType(kCCProgressTimerTypeBar)
			var_8_1:retain()
			arg_8_0:addChild(var_8_1)

			return var_8_1
		end

		arg_3_0.spriteBarBg = tolua.cast(var_5_8:getChildByTag(2), "CCSprite")
		arg_3_0.spriteBar = var_5_9(arg_3_0.spriteBarBg, "image/legion/boss/boss_progress.png")

		local var_5_10 = tolua.cast(var_5_3:getChildByTag(3), "CCNode")

		arg_3_0.lbDesc = tolua.cast(var_5_10:getChildByTag(11), "CCLabelTTF")
		arg_3_0.lbHaveJiaohu = tolua.cast(var_5_10:getChildByTag(12), "CCLabelTTF")
		arg_3_0.action = {}
		arg_3_0.lblheart = {}
		arg_3_0.moneysp = {}
		arg_3_0.costmoney = {}
		arg_3_0.btnAction = {}

		for iter_5_0 = 1, 6 do
			arg_3_0.action[iter_5_0] = tolua.cast(var_5_10:getChildByTag(iter_5_0), "CCNode")
			arg_3_0.lblheart[iter_5_0] = tolua.cast(arg_3_0.action[iter_5_0]:getChildByTag(1), "CCLabelTTF")
			arg_3_0.moneysp[iter_5_0] = tolua.cast(arg_3_0.action[iter_5_0]:getChildByTag(2), "CCSprite")
			arg_3_0.costmoney[iter_5_0] = tolua.cast(arg_3_0.action[iter_5_0]:getChildByTag(3), "CCLabelTTF")
			arg_3_0.btnAction[iter_5_0] = tolua.cast(arg_3_0.action[iter_5_0]:getChildByTag(4), "CCControlButton")

			arg_3_0.btnAction[iter_5_0]:addHandleOfControlEvent(function()
				arg_3_0:onAction(iter_5_0)
			end, CCControlEventTouchUpInside)
		end

		arg_3_0.nodeActionLogs = tolua.cast(var_5_3:getChildByTag(4), "CCNode")

		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onUpdateActionAck()
	end, zbGameEvent.Event_UpdateFriendsActionAck)
end

function var_0_0.onUpdateActionAck(arg_11_0)
	if arg_11_0.frienddata then
		local var_11_0 = g_Self.kFriendHandler:getFriendInfoById(arg_11_0.frienddata.PlayerBaseInfo.PlayerId)

		arg_11_0:refresh(var_11_0)
	end
end

function var_0_0.refresh(arg_12_0, arg_12_1)
	arg_12_0.frienddata = arg_12_1

	if arg_12_1 then
		local var_12_0 = zbIconHelper:getPlayerHeadIconPath(arg_12_1.PlayerBaseInfo.HeadId)

		arg_12_0.headIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_12_0))
		arg_12_0.lbllv:setString(arg_12_1.PlayerBaseInfo.Level)
		arg_12_0.lblname:setString(a2u(arg_12_1.PlayerBaseInfo.RoleName))
		arg_12_0.vipRep:setString(arg_12_1.PlayerBaseInfo.VipLevel)

		local var_12_1 = arg_12_1.FriendsBaseData.Level + 1
		local var_12_2 = arg_12_1.FriendsBaseData.Level

		g_Self.kFriendHandler:setIntimacyIcon(arg_12_0.curIntimacy, var_12_2 + 1)

		local var_12_3 = var_12_2 + 2

		if var_12_3 >= 6 then
			var_12_3 = 6
		end

		g_Self.kFriendHandler:setIntimacyIcon(arg_12_0.nextIntimacy, var_12_3)

		local var_12_4 = g_Self.kFriendHandler:getFriendlyByLv(var_12_2)
		local var_12_5 = arg_12_1.FriendsBaseData.Friendly

		arg_12_0.lblprogress:setString(var_12_5 .. "/" .. var_12_4)

		local var_12_6 = math.min(math.ceil(100 * (var_12_5 / var_12_4)), 100)

		arg_12_0.spriteBar:setPercentage(var_12_6)

		if zbUtil:isValidTable(g_DataConfig.m_kCommonCfg.friendsConfig.friendsAction) then
			for iter_12_0 = 1, 6 do
				local var_12_7 = g_DataConfig.m_kCommonCfg.friendsConfig.friendsAction[iter_12_0]

				arg_12_0.lblheart[iter_12_0]:setString("+" .. var_12_7.friendly)

				local var_12_8 = var_12_7.MoneyType
				local var_12_9 = "image/common/money_gold.png"

				if var_12_8 == 2 then
					var_12_9 = "image/common/money_diamond.png"
				end

				arg_12_0.moneysp[iter_12_0]:setVisible(var_12_8 ~= 0)
				arg_12_0.moneysp[iter_12_0]:setTexture(CCTextureCache:sharedTextureCache():addImage(var_12_9))
				arg_12_0.costmoney[iter_12_0]:setString(var_12_7.MoneyCount)
				arg_12_0.costmoney[iter_12_0]:setVisible(var_12_8 ~= 0)
			end
		end

		if zbUtil:isValidTable(arg_12_1.ActionList) then
			arg_12_0.nodeActionLogs:removeAllChildrenWithCleanup(true)

			local var_12_10 = 1

			for iter_12_1 = 1, table.getn(arg_12_1.ActionList) do
				local var_12_11 = arg_12_1.ActionList[iter_12_1]

				if var_12_10 <= 3 then
					local var_12_12 = var_12_11.PlayerId
					local var_12_13 = var_12_11.ActionType
					local var_12_14 = ""
					local var_12_15 = g_Self.kFriendHandler:getActionInfo(var_12_11.ActionType)

					if var_12_15 then
						var_12_14 = var_12_15.action_des
					end

					if var_12_14 ~= "" then
						local var_12_16 = math.max(g_Self.kTimeHandler:getServerTime() - var_12_11.ActionTm - g_Self.kTimeHandler:getTimeZoneDelt(), 0)
						local var_12_17 = zbUtil:getPassTimeShort(var_12_16)
						local var_12_18 = a2u(arg_12_1.PlayerBaseInfo.RoleName)
						local var_12_19 = a2u("\xC4\xE3")

						if var_12_11.PlayerId == g_Self:getPlayerId() then
							var_12_18 = a2u("\xC4\xE3")
							var_12_19 = a2u(arg_12_1.PlayerBaseInfo.RoleName)
						end

						local var_12_20 = ""

						if var_12_11.ActionType <= 6 then
							var_12_20 = var_12_17 .. " " .. string.format(var_12_14, "[color=0x00ff00]" .. var_12_18 .. "[/color]", "[color=0x00ff00]" .. var_12_19 .. "[/color]") .. string.format(a2u(",\xD4\xF6\xBCӺøж\xC8%d\xB5\xE3"), var_12_11.ActionValue)
						else
							var_12_20 = string.format(var_12_14, "[color=0x00ff00]" .. var_12_18 .. "[/color]", "[color=0x00ff00]" .. var_12_19 .. "[/color]")

							if var_12_11.ActionValue == 0 then
								var_12_20 = var_12_20 .. a2u(",ս\xB0\xDC\xC1\xCB")
							else
								var_12_20 = var_12_20 .. a2u(",ʤ\xC0\xFB\xC1\xCB")
							end
						end

						local var_12_21 = createChatContent()

						var_12_21:setPosition(0, 0 - (var_12_10 - 1) * 30)
						var_12_21:refresh(a2u(var_12_20))
						arg_12_0.nodeActionLogs:addChild(var_12_21)

						var_12_10 = var_12_10 + 1
					end
				end
			end
		end

		local var_12_22 = g_Self.kFriendHandler:getFriendInfoById(arg_12_1.PlayerBaseInfo.PlayerId)

		if var_12_22 and var_12_22.FriendsBaseData.ActionCount >= g_DataConfig.m_kCommonCfg.friendsConfig.actionLimit then
			for iter_12_2 = 1, 6 do
				arg_12_0.action[iter_12_2]:setVisible(false)
			end

			arg_12_0.lbDesc:setVisible(false)
			arg_12_0.lbHaveJiaohu:setVisible(true)
		else
			for iter_12_3 = 1, 6 do
				arg_12_0.action[iter_12_3]:setVisible(true)
			end

			arg_12_0.lbDesc:setVisible(true)
			arg_12_0.lbHaveJiaohu:setVisible(false)
		end
	end
end

function var_0_0.onAction(arg_13_0, arg_13_1)
	if arg_13_0.frienddata then
		local var_13_0 = g_Self.kFriendHandler:getFriendInfoById(arg_13_0.frienddata.PlayerBaseInfo.PlayerId)

		if var_13_0 then
			if var_13_0.FriendsBaseData.ActionCount >= g_DataConfig.m_kCommonCfg.friendsConfig.actionLimit then
				g_Bubble:bubbleInfo(a2u("\xBD\xF1\xC8\xD5\xD2ѽ\xBB\xBB\xA5"))

				return
			end

			g_WsMsgHandler:WS_Friends_Action_Req(arg_13_0.frienddata.PlayerBaseInfo.PlayerId, arg_13_1)
		end
	end
end

function var_0_0.onTouchTest(arg_14_0)
	local var_14_0 = arg_14_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_14_0.layerTouchTest, var_14_0.x, var_14_0.y) == false and zbUtil:PointInCtrl(arg_14_0.btnClose, var_14_0.x, var_14_0.y) == false then
		arg_14_0:hide()
	end
end
