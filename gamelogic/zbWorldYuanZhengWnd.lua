require("gamelogic.zbBaseWnd")
require("gamelogic.zbTimeLabel")

zbWorldYuanZhengWnd = class("zbWorldYuanZhengWnd", zbBaseWnd)
zbWorldYuanZhengWnd.__index = zbWorldYuanZhengWnd

function zbWorldYuanZhengWnd.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, zbWorldYuanZhengWnd)

	return arg_1_0
end

function createWorldYuanZhengWnd()
	local var_2_0 = zbWorldYuanZhengWnd.extend(zbBaseWnd.extend(CCNodeExtend.extend(CCNode:create())))

	var_2_0:initBase()
	var_2_0:init()

	return var_2_0
end

function zbWorldYuanZhengWnd.init(arg_3_0)
	local function var_3_0()
		arg_3_0.sprite = {}
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/world_yuanzheng.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1, "CCNode")
		local var_5_3 = tolua.cast(var_5_2:getChildByTag(3), "CCNode")

		for iter_5_0 = 1, 8 do
			arg_3_0.sprite[iter_5_0] = tolua.cast(var_5_3:getChildByTag(iter_5_0), "CCSprite")
		end

		local var_5_4 = tolua.cast(var_5_2:getChildByTag(4), "CCNode")

		arg_3_0.btnBribery = tolua.cast(var_5_4:getChildByTag(3), "CCControlButton")

		local var_5_5 = tolua.cast(var_5_4:getChildByTag(2), "CCLabelTTF")

		arg_3_0.lbMoney = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_5, arg_3_0.lbMoney)
		arg_3_0.lbMoney:setScale(0.6)

		arg_3_0.layerBtn = var_5_4

		local var_5_6 = tolua.cast(var_5_2:getChildByTag(5), "CCNode")
		local var_5_7 = tolua.cast(var_5_6:getChildByTag(2), "CCLabelTTF")

		arg_3_0.lbNum = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_7, arg_3_0.lbNum)
		arg_3_0.lbNum:setScale(0.6)

		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")

		arg_3_0.btnBribery:addHandleOfControlEvent(function()
			arg_3_0:onBribery()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
	arg_3_0:setShowCallback(handler(arg_3_0, arg_3_0.doShow))
	arg_3_0:setHideCallback(handler(arg_3_0, arg_3_0.doHide))
	arg_3_0:registerEvent(arg_3_0, function()
		arg_3_0:refresh()
	end, zbGameEvent.Event_UpdateBgzInfo)
end

function zbWorldYuanZhengWnd.doShow(arg_9_0)
	if g_MainScene.wndWorld then
		g_MainScene.wndWorld.wordMap:setLayerTouchEnabled(false)
	end
end

function zbWorldYuanZhengWnd.doHide(arg_10_0)
	if g_MainScene.wndWorld then
		g_MainScene.wndWorld.wordMap:setLayerTouchEnabled(true)
	end
end

function zbWorldYuanZhengWnd.refresh(arg_11_0)
	local var_11_0 = g_Self.kWorldHandler.worldInfo.BgzInfo
	local var_11_1 = zbVipTable:getRecord(g_Self:getVipLevel())

	if var_11_1 then
		arg_11_0.lbNum:setString(var_11_1.bgzBribery - var_11_0.BribeCount .. "/" .. var_11_1.bgzBribery)
	end

	local var_11_2 = g_DataConfig.kWorldBaseTable.special.bgzAnswer.foodCost

	if var_11_0.BribeCount >= table.getn(var_11_2) then
		arg_11_0.layerBtn:setVisible(false)
	else
		arg_11_0.lbMoney:setString(var_11_2[var_11_0.BribeCount + 1])
		arg_11_0.layerBtn:setVisible(true)
	end

	arg_11_0.spriteframeCache = CCSpriteFrameCache:sharedSpriteFrameCache()

	arg_11_0.spriteframeCache:addSpriteFramesWithFile("ui/image/plist/bgz.plist")

	for iter_11_0 = 1, 8 do
		local var_11_3 = arg_11_0.spriteframeCache:spriteFrameByName("bgz_wenhao.png")

		if var_11_3 then
			arg_11_0.sprite[iter_11_0]:initWithSpriteFrame(var_11_3)
		end
	end

	local var_11_4 = 1

	for iter_11_1, iter_11_2 in pairs(var_11_0.BgzClue) do
		if iter_11_2 ~= 0 then
			local var_11_5 = arg_11_0.spriteframeCache:spriteFrameByName("bgz_num" .. iter_11_2 .. ".png")

			if var_11_5 then
				arg_11_0.sprite[var_11_4]:initWithSpriteFrame(var_11_5)
			end
		end

		var_11_4 = var_11_4 + 1
	end
end

function zbWorldYuanZhengWnd.onBribery(arg_12_0)
	local var_12_0 = g_Self.kWorldHandler.worldInfo.BgzInfo
	local var_12_1 = zbVipTable:getRecord(g_Self:getVipLevel())

	if var_12_1 and var_12_1.bgzBribery - var_12_0.BribeCount <= 0 then
		g_Bubble:bubbleInfo("\xBB\xDF¸\xB4\xCE\xCA\xFD\xB2\xBB\xD7\xE3")

		return
	end

	if g_DataConfig.kWorldBaseTable.special.bgzAnswer.foodCost[var_12_0.BribeCount + 1] > g_GameData.Wealth.Food then
		g_Bubble:bubbleInfo("\xC3׷\xB9\xB2\xBB\xD7\xE3")

		return
	end

	g_WsMsgHandler:WS_WorldSpe_BgzBribe_Req(var_12_0.NodeId)
end
