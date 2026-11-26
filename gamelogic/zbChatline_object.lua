local var_0_0 = class("zbChatline_object", CCNodeExtend)

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

function createChatObjectItem(arg_2_0)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.playerInfo = nil
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCLayerColor")

		arg_3_0.layerContent = var_5_0
		arg_3_0.bg = tolua.cast(var_5_0:getChildByTag(1), "CCSprite")
		arg_3_0.head = tolua.cast(var_5_0:getChildByTag(2), "CCSprite")

		local var_5_1 = tolua.cast(var_5_0:getChildByTag(3), "CCSprite")

		arg_3_0.lv = tolua.cast(var_5_1:getChildByTag(1001), "CCLabelTTF")
		arg_3_0.name = tolua.cast(var_5_0:getChildByTag(1004), "CCLabelTTF")

		local var_5_2 = tolua.cast(var_5_0:getChildByTag(5), "CCNode")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1001), "CCLabelTTF")

		arg_3_0.lblVipRep = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_3, arg_3_0.lblVipRep)
		arg_3_0.lblVipRep:setScale(0.55)

		arg_3_0.btnTouch = tolua.cast(var_5_0:getChildByTag(6), "CCControlButton")

		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnTouch:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnTouch:setSwallowsTouches(false)

		local function var_5_4(arg_7_0)
			local var_7_0 = CCSprite:create(NOTIFY_TAG_PATH)

			var_7_0:setPosition(240, 100)
			var_7_0:setVisible(false)
			arg_7_0:addChild(var_7_0)
			zbUIEffect:createNotifyTagScaleAction(var_7_0)

			return var_7_0
		end

		arg_3_0.notifyTag = var_5_4(var_5_0)

		arg_3_0:addChild(arg_3_1)
		arg_3_0:setContentSize(var_5_0:getContentSize())
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_8_0, arg_8_1)
	arg_8_0.layerContent:setVisible(arg_8_1 ~= nil)

	arg_8_0.playerInfo = arg_8_1

	if arg_8_1 then
		arg_8_0.lv:setString(arg_8_1.Level)
		arg_8_0.lblVipRep:setString(arg_8_1.VipLevel)
		arg_8_0.name:setString(a2u(arg_8_1.RoleName))

		local var_8_0 = zbIconHelper:getPlayerHeadIconPath(arg_8_1.HeadId)

		arg_8_0.head:setTexture(CCTextureCache:sharedTextureCache():addImage(var_8_0))
	end
end

function var_0_0.onTouch(arg_9_0)
	if arg_9_0.playerInfo then
		g_Self.kChatHandler.curPrivateChatPlayerInfo = arg_9_0.playerInfo

		g_Self.kChatHandler:delPrivateRecord(arg_9_0.playerInfo.playerId)

		if g_MainScene.wndChat then
			g_MainScene.wndChat:privateChatSel()
		end
	end
end

function var_0_0.setCurSel(arg_10_0)
	if arg_10_0.playerInfo and g_Self.kChatHandler.curPrivateChatPlayerInfo then
		if arg_10_0.playerInfo.playerId == g_Self.kChatHandler.curPrivateChatPlayerInfo.playerId then
			arg_10_0.bg:setTexture(CCTextureCache:sharedTextureCache():addImage("ui/image/chat/chat_friend1.png"))
		else
			arg_10_0.bg:setTexture(CCTextureCache:sharedTextureCache():addImage("ui/image/chat/chat_friend2.png"))
		end
	end
end

function var_0_0.update(arg_11_0)
	if arg_11_0.playerInfo then
		local var_11_0 = g_Self.kChatHandler:isInPrivateRecord(arg_11_0.playerInfo.playerId)

		arg_11_0.notifyTag:setVisible(var_11_0)
	end
end
