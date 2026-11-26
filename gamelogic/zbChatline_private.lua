local var_0_0 = class("zbChatline_private", CCNodeExtend)

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

function createChatlinePrivate(arg_2_0, arg_2_1)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0, arg_2_1)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0()
		arg_3_0.friendNodeInitPosX = 0
		arg_3_0.selfNodeInitPosX = 0
		arg_3_0.data = nil
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCLayerColor")

		arg_3_0.nodefriend = tolua.cast(var_5_0:getChildByTag(1), "CCNode")
		arg_3_0.nodefriend_head = tolua.cast(arg_3_0.nodefriend:getChildByTag(1), "CCSprite")
		arg_3_0.nodefriend_chattm = tolua.cast(arg_3_0.nodefriend:getChildByTag(1002), "CCLabelTTF")
		arg_3_0.nodefriend_lblname = tolua.cast(arg_3_0.nodefriend:getChildByTag(1004), "CCLabelTTF")
		arg_3_0.nodefriend_spframe = tolua.cast(arg_3_0.nodefriend:getChildByTag(5), "CCScale9Sprite")
		arg_3_0.nodefriend_touch = tolua.cast(arg_3_0.nodefriend:getChildByTag(7), "CCControlButton")

		arg_3_0.nodefriend_touch:addHandleOfControlEvent(function()
			arg_3_0:onHeadTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0.nodefriend_touch:setTouchPriority(arg_3_2)

		local var_5_1 = tolua.cast(arg_3_0.nodefriend:getChildByTag(1006), "CCLabelTTF")

		arg_3_0.nodefriend_lblLvRep = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_1, arg_3_0.nodefriend_lblLvRep)
		arg_3_0.nodefriend_lblLvRep:setScale(0.55)

		arg_3_0.nodefriend_contentNode = tolua.cast(arg_3_0.nodefriend:getChildByTag(3), "CCNode")
		arg_3_0.nodefriend_content = createChatContent()

		arg_3_0.nodefriend_contentNode:addChild(arg_3_0.nodefriend_content)

		arg_3_0.nodeself = tolua.cast(var_5_0:getChildByTag(2), "CCNode")
		arg_3_0.nodeself_head = tolua.cast(arg_3_0.nodeself:getChildByTag(1), "CCSprite")
		arg_3_0.nodeself_chattm = tolua.cast(arg_3_0.nodeself:getChildByTag(1002), "CCLabelTTF")
		arg_3_0.nodeself_lblname = tolua.cast(arg_3_0.nodeself:getChildByTag(1004), "CCLabelTTF")
		arg_3_0.nodeself_spframe = tolua.cast(arg_3_0.nodeself:getChildByTag(5), "CCScale9Sprite")

		local var_5_2 = tolua.cast(arg_3_0.nodeself:getChildByTag(1006), "CCLabelTTF")

		arg_3_0.nodeself_lblLvRep = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_2, arg_3_0.nodeself_lblLvRep)
		arg_3_0.nodeself_lblLvRep:setScale(0.55)

		arg_3_0.nodeself_contentNode = tolua.cast(arg_3_0.nodeself:getChildByTag(3), "CCNode")
		arg_3_0.nodeself_content = createChatContent()

		arg_3_0.nodeself_contentNode:addChild(arg_3_0.nodeself_content)

		arg_3_0.friendNodeInitPosX = arg_3_0.nodefriend_contentNode:getPositionX()
		arg_3_0.selfNodeInitPosX = arg_3_0.nodeself_contentNode:getPositionX()

		arg_3_0:addChild(arg_3_1)
		arg_3_0:setContentSize(var_5_0:getContentSize())
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_7_0, arg_7_1)
	arg_7_0.data = arg_7_1

	if arg_7_1 then
		arg_7_0.nodeself:setVisible(arg_7_1.SenderId == g_GameData.BaseInfo.PlayerId)
		arg_7_0.nodefriend:setVisible(arg_7_1.SenderId ~= g_GameData.BaseInfo.PlayerId)

		if arg_7_1.SenderId == g_GameData.BaseInfo.PlayerId then
			arg_7_0.nodeself_content:refresh(arg_7_1.ChatMsg)
			arg_7_0.nodeself_spframe:setPreferredSize(CCSizeMake(arg_7_0.nodeself_content.width, 50))

			local var_7_0 = zbUtil:SprintfHHMM(arg_7_1.ChatTm + g_Self.kTimeHandler:getTimeZoneDelt())

			arg_7_0.nodeself_chattm:setString(var_7_0)
			arg_7_0.nodeself_lblLvRep:setString(arg_7_1.SenderLevel)

			local var_7_1 = zbIconHelper:getPlayerHeadIconPath(arg_7_1.SenderHeadId)

			arg_7_0.nodeself_head:setTexture(CCTextureCache:sharedTextureCache():addImage(var_7_1))
			arg_7_0.nodeself_lblname:setString(a2u(arg_7_1.SenderName))
			arg_7_0.nodeself_content:setPosition(ccp(-arg_7_0.nodeself_content.width + 30, 20))
		else
			arg_7_0.nodefriend_content:refresh(arg_7_1.ChatMsg)
			arg_7_0.nodefriend_spframe:setPreferredSize(CCSizeMake(arg_7_0.nodefriend_content.width, 50))

			local var_7_2 = zbUtil:SprintfHHMM(arg_7_1.ChatTm + g_Self.kTimeHandler:getTimeZoneDelt())

			arg_7_0.nodefriend_chattm:setString(var_7_2)
			arg_7_0.nodefriend_lblLvRep:setString(arg_7_1.SenderLevel)

			local var_7_3 = zbIconHelper:getPlayerHeadIconPath(arg_7_1.SenderHeadId)

			arg_7_0.nodefriend_head:setTexture(CCTextureCache:sharedTextureCache():addImage(var_7_3))
			arg_7_0.nodefriend_lblname:setString(a2u(arg_7_1.SenderName))
			arg_7_0.nodefriend_content:setPosition(ccp(0, 20))
		end
	end
end

function var_0_0.onHeadTouch(arg_8_0)
	if arg_8_0.data then
		g_MainScene:showChatTip(arg_8_0.data):setPrevWnd(g_MainScene.wndChat)
	end
end
