require("gamelogic.zbChatContent")

local var_0_0 = class("zbChatline_world", CCNodeExtend)

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

function createChatlineWorld(arg_2_0)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.data = nil
	end

	local function var_3_1()
		arg_3_0.layerContent = tolua.cast(arg_3_1:getChildByTag(1), "CCLayerColor")
		arg_3_0.chattm = tolua.cast(arg_3_0.layerContent:getChildByTag(1002), "CCLabelTTF")
		arg_3_0.lblname = tolua.cast(arg_3_0.layerContent:getChildByTag(1004), "CCLabelTTF")
		arg_3_0.spframe = tolua.cast(arg_3_0.layerContent:getChildByTag(5), "CCScale9Sprite")

		local var_5_0 = tolua.cast(arg_3_0.layerContent:getChildByTag(1006), "CCLabelTTF")

		arg_3_0.lblLvRep = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_0, arg_3_0.lblLvRep)
		arg_3_0.lblLvRep:setScale(0.55)

		arg_3_0.head = tolua.cast(arg_3_0.layerContent:getChildByTag(1), "CCSprite")
		arg_3_0.sphorn = tolua.cast(arg_3_0.layerContent:getChildByTag(7), "CCSprite")
		arg_3_0.btnHead = tolua.cast(arg_3_0.layerContent:getChildByTag(10), "CCControlButton")

		arg_3_0.btnHead:addHandleOfControlEvent(function()
			arg_3_0:onHeadTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnHead:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnHead:setSwallowsTouches(false)
		arg_3_0.btnHead:setTouchPriority(TOUCHPRIORITY_MIN)

		local var_5_1 = tolua.cast(arg_3_0.layerContent:getChildByTag(3), "CCNode")

		arg_3_0.content = createChatContent()

		arg_3_0.content:setPosition(120, 40)
		var_5_1:addChild(arg_3_0.content)

		arg_3_0.layerContent2 = tolua.cast(arg_3_1:getChildByTag(2), "CCLayerColor")
		arg_3_0.chattm2 = tolua.cast(arg_3_0.layerContent2:getChildByTag(1002), "CCLabelTTF")
		arg_3_0.spframe2 = tolua.cast(arg_3_0.layerContent2:getChildByTag(5), "CCScale9Sprite")

		local var_5_2 = tolua.cast(arg_3_0.layerContent2:getChildByTag(3), "CCNode")

		arg_3_0.content2 = createChatContent()

		arg_3_0.content2:setPosition(130, 45)
		var_5_2:addChild(arg_3_0.content2)
		arg_3_0:addChild(arg_3_1)
		arg_3_0:setContentSize(arg_3_0.layerContent:getContentSize())
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_0.data = arg_7_1

		arg_7_0.layerContent:setVisible(arg_7_1.scroll ~= 1)
		arg_7_0.layerContent2:setVisible(arg_7_1.scroll == 1)

		if arg_7_1.scroll == 1 then
			arg_7_0.chattm2:setString(zbUtil:SprintfHHMM(arg_7_1.Tm + g_Self.kTimeHandler:getTimeZoneDelt()))
			arg_7_0.content2:refresh(arg_7_1.Content)
			arg_7_0.spframe2:setPreferredSize(CCSizeMake(arg_7_0.content2.width, 45))

			return
		end

		arg_7_0.lblname:setString(a2u(arg_7_1.SenderName))
		arg_7_0.content:refresh(arg_7_1.ChatMsg)
		arg_7_0.spframe:setPreferredSize(CCSizeMake(arg_7_0.content.width, 50))

		local var_7_0 = zbUtil:SprintfHHMM(arg_7_1.ChatTm + g_Self.kTimeHandler:getTimeZoneDelt())

		arg_7_0.chattm:setString(var_7_0)
		arg_7_0.lblLvRep:setString(arg_7_1.SenderLevel)

		local var_7_1 = zbIconHelper:getPlayerHeadIconPath(arg_7_1.SenderHeadId)

		arg_7_0.head:setTexture(CCTextureCache:sharedTextureCache():addImage(var_7_1))
		arg_7_0.sphorn:setVisible(arg_7_1.IsHorn == 1)
	end
end

function var_0_0.onHeadTouch(arg_8_0)
	if arg_8_0.data then
		if arg_8_0.data.scroll == 1 or arg_8_0.data.SenderId == g_Self:getPlayerId() then
			return
		end

		g_MainScene:showChatTip(arg_8_0.data):setPrevWnd(g_MainScene.wndChat)
	end
end
