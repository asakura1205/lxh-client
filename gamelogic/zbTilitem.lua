zbTilitem = class("zbTilitem", CCNodeExtend)
zbTilitem.__index = zbTilitem

function zbTilitem.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbTilitem)

	return arg_1_0
end

function zbTilitem.create(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = zbTilitem.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_1, arg_2_2)

	return var_2_0
end

function zbTilitem.init(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0()
		arg_3_0.index = arg_3_1
		arg_3_0.meishi = nil
	end

	local function var_3_1()
		CCLabelTTF:beginDelayCreateTexture()

		local var_5_0 = zbUtil:loadCCBNode("ccbi/tb_tili.ccbi")
		local var_5_1 = tolua.cast(var_5_0:getChildByTag(1), "CCNode")

		arg_3_0.spriteIcon = tolua.cast(var_5_1:getChildByTag(2), "CCSprite")
		arg_3_0.lbEatTime = tolua.cast(var_5_1:getChildByTag(4), "CCLabelTTF")
		arg_3_0.btnEat = tolua.cast(var_5_1:getChildByTag(5), "CCControlButton")
		arg_3_0.spriteOutdate = tolua.cast(var_5_1:getChildByTag(6), "CCSprite")
		arg_3_0.spriteGeted = tolua.cast(var_5_1:getChildByTag(7), "CCSprite")
		arg_3_0.btnEatOutdate = tolua.cast(var_5_1:getChildByTag(8), "CCControlButton")
		arg_3_0.needMoney = tolua.cast(var_5_1:getChildByTag(9), "CCNode")
		arg_3_0.lbTemp = tolua.cast(var_5_1:getChildByTag(10), "CCLabelTTF")
		arg_3_0.lbMoneyDummy = tolua.cast(arg_3_0.needMoney:getChildByTag(1006), "CCLabelTTF")

		arg_3_0.lbTemp:setVisible(false)

		arg_3_0.lbMoney = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbMoneyDummy, arg_3_0.lbMoney)
		arg_3_0.lbMoney:setScale(0.55)

		arg_3_0.btnTouch = tolua.cast(var_5_1:getChildByTag(100), "CCControlButton")

		arg_3_0.btnTouch:addHandleOfControlEvent(function()
			arg_3_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnEat:addHandleOfControlEvent(function()
			arg_3_0:onEat()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnEatOutdate:addHandleOfControlEvent(function()
			arg_3_0:onOutdate()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnTouch:setZoomOnTouchDown(true)
		arg_3_0.btnTouch:setZoomChildNode(var_5_1)
		arg_3_0:addChild(var_5_0)

		arg_3_0.lbTemp2 = tolua.cast(var_5_1:getChildByTag(10), "CCLabelTTF")

		arg_3_0.btnTouch:setTouchPriority(arg_3_2:getTouchPriority())
		arg_3_0.btnEat:setTouchPriority(arg_3_2:getTouchPriority())
		arg_3_0.btnEatOutdate:setTouchPriority(arg_3_2:getTouchPriority())
		CCLabelTTF:endDelayCreateTexture(var_5_0)
	end

	var_3_0()
	var_3_1()
end

function zbTilitem.refresh(arg_9_0, arg_9_1)
	arg_9_0.tiliData = arg_9_1

	arg_9_0.lbTemp2:setString(a2u("\xB5\xF6\xD3\xE3\xBA\xF3\xBF\xC9\xD6\xC6\xD7\xF7") .. arg_9_1.Num .. a2u("\xD3\xE3\xB8\xC9"))

	local var_9_0 = zbUtil:SprintfHHMMSS(g_Self.kTimeHandler:getServerTime() + g_Self.kTimeHandler:getTimeZoneDelt())
	local var_9_1 = string.format("%02d:00:00", arg_9_1.StartHour)
	local var_9_2 = string.format("%02d:00:00", arg_9_1.EndHour)

	arg_9_0.spriteframeCache = CCSpriteFrameCache:sharedSpriteFrameCache()

	arg_9_0.spriteframeCache:addSpriteFramesWithFile("ui/image/plist/activity.plist")

	local var_9_3 = arg_9_0.spriteframeCache:spriteFrameByName("tili_icon" .. arg_9_0.index .. ".png")

	if var_9_3 then
		arg_9_0.spriteIcon:initWithSpriteFrame(var_9_3)
	end

	arg_9_0.spriteGeted:setVisible(arg_9_1.State == 1)

	local var_9_4 = arg_9_1.State == 0 and var_9_1 < var_9_0 and var_9_0 < var_9_2

	arg_9_0.btnEat:setVisible(var_9_4)
	arg_9_0.lbEatTime:setVisible(var_9_0 < var_9_1)

	local var_9_5 = string.format("%02d:00", arg_9_1.StartHour)
	local var_9_6 = string.format("%02d:00", arg_9_1.EndHour)

	arg_9_0.lbEatTime:setString(a2u("\xB4\xB9\xB5\xF6ʱ\xBC\xE4:") .. var_9_5 .. "-" .. var_9_6)
	arg_9_0.spriteOutdate:setVisible(arg_9_1.State == 0 and var_9_2 < var_9_0)
	arg_9_0.btnEatOutdate:setVisible(arg_9_1.State == 0 and var_9_2 < var_9_0)
	arg_9_0.needMoney:setVisible(arg_9_1.State == 0 and var_9_2 < var_9_0)
	arg_9_0.lbMoney:setString(arg_9_1.AddedCost)
	arg_9_0:setVisible(true)
end

function zbTilitem.onTouch(arg_10_0)
	local var_10_0 = zbUtil:SprintfHHMMSS(g_Self.kTimeHandler:getServerTime() + g_Self.kTimeHandler:getTimeZoneDelt())
	local var_10_1 = string.format("%02d:00:00", arg_10_0.tiliData.StartHour)
	local var_10_2 = string.format("%02d:00:00", arg_10_0.tiliData.EndHour)
	local var_10_3 = string.format("%02d:00", arg_10_0.tiliData.StartHour)
	local var_10_4 = string.format("%02d:00", arg_10_0.tiliData.EndHour)

	if var_10_0 < var_10_1 then
		g_Bubble:bubbleInfo(a2u("\xB4\xB9\xB5\xF6ʱ\xBC\xE4:") .. var_10_3 .. "-" .. var_10_4 .. a2u("\xC7\xEB׼\xB5\xE3\xB9\xFD\xC0\xB4\xB4\xB9\xB5\xF6Ŷ\xA3\xA1"))

		return
	end

	if arg_10_0.tiliData.State == 0 and var_10_2 < var_10_0 then
		g_Bubble:bubbleInfo(a2u("\xB4\xB9\xB5\xF6ʱ\xBC\xE4:") .. var_10_3 .. "-" .. var_10_4 .. a2u("\xD2\xE0\xBF\xC9\xD7\xEAʯ\xB2\xB9\xB5\xF6Ŷ\xA3\xA1"))

		return
	end

	if arg_10_0.tiliData.State == 1 then
		g_Bubble:bubbleInfo(a2u("\xB4\xB9\xB5\xF6ʱ\xBC\xE4:") .. var_10_3 .. "-" .. var_10_4 .. a2u("\xCF´\xCE\xD4\xD9\xC0\xB4Ŷ\xA3\xA1"))

		return
	end
end

function zbTilitem.onEat(arg_11_0)
	g_WsMsgHandler:WS_ActivityAct_Tili_Req()
end

function zbTilitem.onOutdate(arg_12_0)
	g_WsMsgHandler:WS_ActivityAct_TiliAdded_Req(arg_12_0.index)
end
