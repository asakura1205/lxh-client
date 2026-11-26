require("gamelogic.zbBaseWnd")
require("gamelogic.zbHeroCommentList")

local var_0_0 = class("zbHeroCommentWnd", zbBaseWnd)

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

function createHeroCommentWnd()
	local var_2_0 = var_0_0.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function var_0_0.init(arg_3_0)
	local function var_3_0()
		arg_3_0.heroTemId = nil
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/herocomment.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")

		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.herobg = tolua.cast(var_5_2:getChildByTag(1), "CCSprite")
		arg_3_0.layerContent = tolua.cast(var_5_2:getChildByTag(2), "CCLayer")

		local var_5_3 = tolua.cast(var_5_2:getChildByTag(3), "CCNode")

		arg_3_0.nodeInput = tolua.cast(var_5_2:getChildByTag(4), "CCLayer")

		arg_3_0.nodeInput:setVisible(false)

		local var_5_4 = tolua.cast(arg_3_0.nodeInput:getChildByTag(9), "CCLayer")
		local var_5_5 = tolua.cast(arg_3_0.nodeInput:getChildByTag(10), "CCScrollView")
		local var_5_6 = ccc3(184, 167, 144)

		arg_3_0.inputBox = zbUtil:createEditBox(var_5_4, "", 100, "image/common/button_transparent.png", 22, var_5_6)

		var_5_5:addChild(arg_3_0.inputBox)
		var_5_5:setCanMove(false)
		arg_3_0.inputBox:setPlaceHolder(a2u("\xD4ڴ\xCB\xCA\xE4\xC8\xEB\xC6\xC0\xC2\xDB\xC4\xDA\xC8\xDD..."))

		arg_3_0.btnSend = tolua.cast(arg_3_0.nodeInput:getChildByTag(1), "CCControlButton")

		arg_3_0.btnSend:addHandleOfControlEvent(function()
			arg_3_0:onSend()
		end, CCControlEventTouchUpInside)

		arg_3_0.btnClose = tolua.cast(var_5_3:getChildByTag(1), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)

		arg_3_0.btnShare = tolua.cast(var_5_3:getChildByTag(3), "CCControlButton")

		arg_3_0.btnShare:addHandleOfControlEvent(function()
			arg_3_0:onShare()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnShare:setVisible(false)

		arg_3_0.btnComment = tolua.cast(var_5_3:getChildByTag(2), "CCControlButton")

		arg_3_0.btnComment:addHandleOfControlEvent(function()
			arg_3_0:onComment()
		end, CCControlEventTouchUpInside)

		arg_3_0.heroCommentList = createHeroCommentList(arg_3_0.layerContent, arg_3_0.btnClose)

		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onReqAck()
	end, zbGameEvent.Event_Update_HeroComment)
	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_12_0)
	if g_Self.kHeroHandler.commentHeroTemlatedId then
		local var_12_0 = zbIconHelper:getHeroCardIconPath(g_Self.kHeroHandler.commentHeroTemlatedId)

		arg_12_0.herobg:setTexture(CCTextureCache:sharedTextureCache():addImage(var_12_0))
		g_WsMsgHandler:WS_HeroComment_PullComment_Req(g_Self.kHeroHandler.commentHeroTemlatedId)
	end
end

function var_0_0.onReqAck(arg_13_0)
	arg_13_0.heroCommentList:refresh()
end

function var_0_0.onShare(arg_14_0)
	return
end

function var_0_0.onSend(arg_15_0)
	local var_15_0 = arg_15_0.inputBox:getText()

	if var_15_0 == "" then
		g_Bubble:bubbleInfo(a2u("\xC7\xEB\xCA\xE4\xC8\xEB\xC1\xC4\xCC\xEC\xC4\xDA\xC8\xDD"))

		return
	end

	if zbUtil:isValidText(var_15_0) == false then
		g_Bubble:bubbleInfo(a2u("\xBA\xAC\xD3зǷ\xA8\xD7ַ\xFB"))

		return
	end

	arg_15_0.nodeInput:setVisible(false)
	g_WsMsgHandler:WS_HeroComment_AddComment_Req(g_Self.kHeroHandler.commentHeroTemlatedId, a2u(var_15_0))
end

function var_0_0.onComment(arg_16_0)
	arg_16_0.nodeInput:setVisible(true)
end

function var_0_0.onTouchTest(arg_17_0)
	local var_17_0 = arg_17_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_17_0.nodeInput, var_17_0.x, var_17_0.y) == false and zbUtil:PointInCtrl(arg_17_0.btnClose, var_17_0.x, var_17_0.y) == false then
		arg_17_0.nodeInput:setVisible(false)
	end
end
