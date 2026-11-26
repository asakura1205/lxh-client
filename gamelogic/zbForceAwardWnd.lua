require("gamelogic.zbBaseWnd")
require("gamelogic.zbItem")

local var_0_0 = class("zbForceAwardWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createForceAwardWnd()
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
		arg_3_0.awardItems = {}
		arg_3_0.levelType = -1
		arg_3_0.forceId = -1
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/forceaward.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		for iter_5_0 = 1, 3 do
			local var_5_3 = tolua.cast(var_5_2:getChildByTag(iter_5_0), "CCLayerColor")
			local var_5_4 = createItem()

			var_5_4:setPosition(var_5_3:getPosition())
			var_5_2:addChild(var_5_4)
			var_5_3:removeFromParentAndCleanup(true)

			arg_3_0.awardItems[iter_5_0] = var_5_4
		end

		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")
		arg_3_0.spriteTitle = tolua.cast(var_5_2:getChildByTag(4), "CCSprite")
		arg_3_0.btnGetAward = tolua.cast(var_5_2:getChildByTag(5), "CCControlButton")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		local var_5_5 = tolua.cast(var_5_2:getChildByTag(6), "CCLabelTTF")

		arg_3_0.lbStar = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_5, arg_3_0.lbStar)
		arg_3_0.lbStar:setScale(0.8)

		arg_3_0.layerTouchTest = var_5_2

		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
		arg_3_0.btnGetAward:addHandleOfControlEvent(function()
			arg_3_0:onGetAwardReq()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
	end

	var_3_0()
	var_3_1()
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:onGetAwardAck()
	end, zbGameEvent.Event_ForceStarAward_Ack)
end

function var_0_0.refresh(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0.levelType = arg_10_1
	arg_10_0.forceId = arg_10_2
	arg_10_0.starCount = arg_10_3

	local var_10_0 = zbForceStarAwardTable:getRecord(arg_10_1, arg_10_2, arg_10_0.starCount)

	if var_10_0 == nil then
		return
	end

	arg_10_0.lbStar:setString(arg_10_0.starCount)

	for iter_10_0, iter_10_1 in pairs(arg_10_0.awardItems) do
		iter_10_1:setVisible(false)
	end

	local var_10_1 = 1

	for iter_10_2, iter_10_3 in pairs(var_10_0) do
		local var_10_2 = arg_10_0.awardItems[var_10_1]

		if var_10_2 ~= nil then
			var_10_2:refreshAward(iter_10_3.awardType, iter_10_3.awardId, iter_10_3.awardCount)
			var_10_2:setVisible(true)
		end

		var_10_1 = var_10_1 + 1
	end
end

function var_0_0.onGetAwardReq(arg_11_0)
	if g_Self.kWarPathHandler:getForceStarCount(arg_11_0.levelType, arg_11_0.forceId) >= arg_11_0.starCount then
		g_WsMsgHandler:WS_GameLevel_StarAward_Req(arg_11_0.forceId, arg_11_0.levelType, arg_11_0.starCount)
	else
		g_Bubble:bubbleInfo(a2u("Ŭ\xC1\xA6\xB4\xEF\xB3\xC9") .. arg_11_0.starCount .. a2u("\xD0ǻ\xF1\xB5ý\xB1\xC0\xF8"))
	end
end

function var_0_0.onGetAwardAck(arg_12_0)
	arg_12_0:hide()
end

function var_0_0.onTouchTest(arg_13_0)
	local var_13_0 = arg_13_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_13_0.layerTouchTest, var_13_0.x, var_13_0.y) == false then
		arg_13_0:hide()
	end
end
