require("gamelogic.zbBaseWnd")

local var_0_0 = class("zbArenaHistoryBestWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createArenaHistoryBestWnd()
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
		return
	end

	local function var_3_1()
		function createArrowMoveAction(arg_6_0)
			local var_6_0 = 1.1
			local var_6_1 = 10
			local var_6_2 = ccp(arg_6_0:getPosition())

			var_6_2.x = var_6_2.x - 3

			local var_6_3 = CCMoveTo:create(var_6_0, var_6_2)

			var_6_2.x = var_6_2.x + 6

			local var_6_4 = CCMoveTo:create(var_6_0, var_6_2)
			local var_6_5 = CCArray:create()

			var_6_5:addObject(var_6_3)
			var_6_5:addObject(var_6_4)

			local var_6_6 = CCSequence:create(var_6_5)

			arg_6_0:stopAllActions()
			arg_6_0:runAction(CCRepeatForever:create(var_6_6))
		end

		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/arena_historybest.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCLayer")

		arg_3_0.spriteTitle = tolua.cast(var_5_2:getChildByTag(0), "CCSprite")
		arg_3_0.nodeRank = tolua.cast(var_5_2:getChildByTag(1), "CCNode")

		local var_5_3 = tolua.cast(arg_3_0.nodeRank:getChildByTag(1001), "CCLabelTTF")

		arg_3_0.spriteRankHint = tolua.cast(arg_3_0.nodeRank:getChildByTag(2), "CCSprite")

		local var_5_4 = tolua.cast(arg_3_0.nodeRank:getChildByTag(1003), "CCLabelTTF")

		arg_3_0.nodeHistoryAward = tolua.cast(var_5_2:getChildByTag(2), "CCNode")
		arg_3_0.spriteHistoryMoney1 = tolua.cast(arg_3_0.nodeHistoryAward:getChildByTag(1), "CCSprite")

		local var_5_5 = tolua.cast(arg_3_0.nodeHistoryAward:getChildByTag(1002), "CCLabelTTF")

		arg_3_0.spriteHistoryMoney2 = tolua.cast(arg_3_0.nodeHistoryAward:getChildByTag(3), "CCSprite")

		local var_5_6 = tolua.cast(arg_3_0.nodeHistoryAward:getChildByTag(1004), "CCLabelTTF")

		arg_3_0.nodeDailyAward = tolua.cast(var_5_2:getChildByTag(3), "CCNode")
		arg_3_0.spriteMoney1 = tolua.cast(arg_3_0.nodeDailyAward:getChildByTag(1), "CCSprite")

		local var_5_7 = tolua.cast(arg_3_0.nodeDailyAward:getChildByTag(1002), "CCLabelTTF")

		arg_3_0.spriteDailyHint1 = tolua.cast(arg_3_0.nodeDailyAward:getChildByTag(3), "CCSprite")

		local var_5_8 = tolua.cast(arg_3_0.nodeDailyAward:getChildByTag(1004), "CCLabelTTF")

		arg_3_0.spriteMoney2 = tolua.cast(arg_3_0.nodeDailyAward:getChildByTag(5), "CCSprite")

		local var_5_9 = tolua.cast(arg_3_0.nodeDailyAward:getChildByTag(1006), "CCLabelTTF")

		arg_3_0.spriteDailyHint2 = tolua.cast(arg_3_0.nodeDailyAward:getChildByTag(7), "CCSprite")

		local var_5_10 = tolua.cast(arg_3_0.nodeDailyAward:getChildByTag(1008), "CCLabelTTF")

		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		createArrowMoveAction(arg_3_0.spriteRankHint)
		createArrowMoveAction(arg_3_0.spriteDailyHint1)
		createArrowMoveAction(arg_3_0.spriteDailyHint2)

		arg_3_0.lblastRank = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_3, arg_3_0.lblastRank)
		arg_3_0.lblastRank:setScale(0.7)

		arg_3_0.lbCurRank = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_4, arg_3_0.lbCurRank)
		arg_3_0.lbCurRank:setScale(0.7)

		arg_3_0.lbHistoryMoney1 = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_5, arg_3_0.lbHistoryMoney1)
		arg_3_0.lbHistoryMoney1:setScale(0.55)

		arg_3_0.lbHistoryMoney2 = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_6, arg_3_0.lbHistoryMoney2)
		arg_3_0.lbHistoryMoney2:setScale(0.55)

		arg_3_0.lblastMoney1 = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_7, arg_3_0.lblastMoney1)
		arg_3_0.lblastMoney1:setScale(0.55)

		arg_3_0.lbCurMoney1 = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_8, arg_3_0.lbCurMoney1)
		arg_3_0.lbCurMoney1:setScale(0.55)

		arg_3_0.lblastMoney2 = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_9, arg_3_0.lblastMoney2)
		arg_3_0.lblastMoney2:setScale(0.55)

		arg_3_0.lbCurMoney2 = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_10, arg_3_0.lbCurMoney2)
		arg_3_0.lbCurMoney2:setScale(0.55)

		arg_3_0.sprite_money = {}
		arg_3_0.sprite_money[1] = arg_3_0.spriteHistoryMoney1
		arg_3_0.sprite_money[2] = arg_3_0.spriteHistoryMoney2
		arg_3_0.lbl_moneyArena = {}
		arg_3_0.lbl_moneyArena[1] = arg_3_0.lbHistoryMoney1
		arg_3_0.lbl_moneyArena[2] = arg_3_0.lbHistoryMoney2
		arg_3_0.layerTouchTest = var_5_2
		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_9_0)
	g_Audio:playSound("audio/sound/ui_herostar.mp3")

	local var_9_0 = g_Self.kArenaHandler.ArenaBaseInfo.BestRank + g_Self.kArenaHandler.IsBestRank
	local var_9_1 = g_Self.kArenaHandler.ArenaBaseInfo.BestRank

	arg_9_0.lblastRank:setString(var_9_0)
	arg_9_0.lbCurRank:setString(var_9_1)

	local var_9_2 = zbArenaDailyAwardTable:getRecord(tonumber(var_9_0))
	local var_9_3 = zbArenaDailyAwardTable:getRecord(tonumber(var_9_1))

	if var_9_2 ~= nil then
		arg_9_0.lblastMoney1:setString(var_9_2.diamond)
		arg_9_0.lblastMoney2:setString(var_9_2.rankMoney)
	else
		arg_9_0.lblastMoney1:setString(0)
		arg_9_0.lblastMoney2:setString(0)
	end

	if var_9_3 ~= nil then
		arg_9_0.lbCurMoney1:setString(var_9_3.diamond)
		arg_9_0.lbCurMoney2:setString(var_9_3.rankMoney)
	else
		arg_9_0.lbCurMoney1:setString(0)
		arg_9_0.lbCurMoney2:setString(0)
	end

	for iter_9_0 = 1, 2 do
		arg_9_0.sprite_money[iter_9_0]:setVisible(false)
		arg_9_0.lbl_moneyArena[iter_9_0]:setVisible(false)
	end

	if zbUtil:isValidTable(g_Self.kArenaHandler.AwardList) then
		for iter_9_1, iter_9_2 in pairs(g_Self.kArenaHandler.AwardList) do
			local var_9_4 = zbIconHelper:getAwardIconPath(iter_9_2.Type, iter_9_2.Id)

			if arg_9_0.sprite_money[iter_9_1] ~= nil and arg_9_0.lbl_moneyArena[iter_9_1] ~= nil then
				arg_9_0.sprite_money[iter_9_1]:setVisible(true)
				arg_9_0.lbl_moneyArena[iter_9_1]:setVisible(true)
				arg_9_0.sprite_money[iter_9_1]:setTexture(CCTextureCache:sharedTextureCache():addImage(var_9_4))
				arg_9_0.lbl_moneyArena[iter_9_1]:setString(iter_9_2.Count)
			end
		end
	end

	arg_9_0:playEffect()
end

function var_0_0.playEffect(arg_10_0)
	local var_10_0 = 0

	local function var_10_1(arg_11_0, arg_11_1)
		local function var_11_0()
			arg_11_0:setVisible(true)
			arg_11_0:playAnimationOnce(ANIMATION_SEQUENCE_WIN, ANIMATION_SEQUENCE_IDLE, 0.2)
		end

		local var_11_1 = CCArray:create()

		var_11_1:addObject(CCDelayTime:create(var_10_0))
		var_11_1:addObject(CCCallFuncN:create(var_11_0))
		arg_11_0:setVisible(false)
		arg_11_0:stopAllActions()
		arg_11_0:runAction(CCSequence:create(var_11_1))

		var_10_0 = var_10_0 + arg_11_1
	end

	local function var_10_2(arg_13_0, arg_13_1, arg_13_2)
		local function var_13_0(arg_14_0)
			arg_14_0:setVisible(true)
		end

		local var_13_1 = CCArray:create()

		var_13_1:addObject(CCDelayTime:create(var_10_0))
		var_13_1:addObject(CCCallFuncN:create(var_13_0))
		arg_13_0:setVisible(false)
		arg_13_0:stopAllActions()
		arg_13_0:runAction(CCSequence:create(var_13_1))

		var_10_0 = var_10_0 + arg_13_1
	end

	var_10_2(arg_10_0.spriteTitle, 0.25)
	var_10_2(arg_10_0.nodeRank, 0.25)
	var_10_2(arg_10_0.nodeHistoryAward, 0.25)
	var_10_2(arg_10_0.nodeDailyAward, 0.25)
	var_10_2(arg_10_0.btnClose, 0.25)
end

function var_0_0.onTouchTest(arg_15_0)
	local var_15_0 = arg_15_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_15_0.layerTouchTest, var_15_0.x, var_15_0.y) == false and zbUtil:PointInCtrl(arg_15_0.btnClose, var_15_0.x, var_15_0.y) == false then
		arg_15_0:hide()
	end
end
