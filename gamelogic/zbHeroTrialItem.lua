require("gamebase.zbFunctions")

local var_0_0 = class("zbHeroTrialItem", CCNodeExtend)

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

function createHeroTrialItem(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0, arg_2_1, arg_2_2)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	function initMember()
		arg_3_0.type = arg_3_2
		arg_3_0.parentWnd = arg_3_3
		arg_3_0.notifyBtn = nil
	end

	function initCCB()
		local function var_5_0(arg_6_0)
			local var_6_0 = CCSprite:create(NOTIFY_TAG_PATH)

			var_6_0:setPosition(220, 280)
			arg_6_0:addChild(var_6_0)
			zbUIEffect:createNotifyTagScaleAction(var_6_0)

			return var_6_0
		end

		local var_5_1 = tolua.cast(arg_3_1:getChildByTag(1), "CCLayer")

		arg_3_0.btnTouch = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")
		arg_3_0.spriteType = tolua.cast(var_5_1:getChildByTag(1), "CCSprite")
		arg_3_0.notifyBtn = var_5_0(arg_3_0.spriteType)
		arg_3_0.spriteTimes = tolua.cast(var_5_1:getChildByTag(2), "CCSprite")

		local var_5_2 = tolua.cast(arg_3_0.spriteTimes:getChildByTag(1001), "CCLabelTTF")

		arg_3_0.lbOpenDay = tolua.cast(var_5_1:getChildByTag(3), "CCLabelTTF")
		arg_3_0.lbTimes = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_2, arg_3_0.lbTimes)
		arg_3_0.lbTimes:setScale(0.55)
		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnTouch:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnTouch:setSwallowsTouches(flase)
		arg_3_0:setContentSize(var_5_1:getContentSize())
		arg_3_0:addChild(arg_3_1)
	end

	initMember()
	initCCB()
end

function var_0_0.refresh(arg_8_0)
	arg_8_0.spriteframeCache = CCSpriteFrameCache:sharedSpriteFrameCache()

	arg_8_0.spriteframeCache:addSpriteFramesWithFile("ui/image/plist/herotrial.plist")

	local var_8_0 = arg_8_0.spriteframeCache:spriteFrameByName("herotrial_type" .. arg_8_0.type .. ".png")

	if var_8_0 then
		arg_8_0.spriteType:initWithSpriteFrame(var_8_0)
	end

	arg_8_0.notifyBtn:setZOrder(ZORDER_TOP)

	local var_8_1, var_8_2 = g_Self.kHeroTrialHandler:getLeftTrialNumByType(arg_8_0.type)

	arg_8_0.lbOpenDay:setVisible(var_8_2 == 0)
	arg_8_0.spriteTimes:setVisible(var_8_2 ~= 0)
	arg_8_0.spriteType:setGray(var_8_2 == 0 and arg_8_0.type ~= 6)

	local var_8_3 = a2u("ÿ\xD6\xDC")
	local var_8_4 = zbHeroTrialBaseTable:getOpenWeekTime(arg_8_0.type)
	local var_8_5 = table.getn(var_8_4)

	for iter_8_0 = 1, var_8_5 do
		local var_8_6 = tonumber(var_8_4[iter_8_0])
		local var_8_7 = ""
		local var_8_8 = zbUtil:getWeekBig(var_8_6)

		var_8_3 = var_8_3 .. var_8_8

		if iter_8_0 < var_8_5 then
			var_8_3 = var_8_3 .. ","
		end
	end

	if arg_8_0.type == 6 then
		arg_8_0.lbOpenDay:setString(a2u("ÿ\xCC쿪\xB7\xC5"))
	else
		arg_8_0.lbOpenDay:setString(var_8_3 .. a2u("\xBF\xAA\xB7\xC5"))
	end

	arg_8_0.lbTimes:setString(var_8_1 .. "/" .. var_8_2)
	arg_8_0.notifyBtn:setVisible(g_Self.kHeroTrialHandler:hasChallengeNotify(arg_8_0.type))

	if arg_8_0.type == 6 then
		arg_8_0.notifyBtn:setVisible(g_Self.kRedPointHandler.wawajiState)
	end
end

function var_0_0.onTouch(arg_9_0)
	if arg_9_0.type == 6 then
		g_WsMsgHandler:WS_Dolls_GetInfo_Req()

		return
	end

	local var_9_0, var_9_1 = g_Self.kHeroTrialHandler:getLeftTrialNumByType(arg_9_0.type)

	if var_9_1 == 0 then
		g_Bubble:bubbleInfo(a2u("\xBD\xF1\xC8ղ\xBB\xBF\xAA\xB7\xC5"))

		return
	end

	g_MainScene:showHeroTrialDetailWnd(arg_9_0.type):setPrevWnd(arg_9_0.parentWnd)
end
