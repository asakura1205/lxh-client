require("gamelogic.zbBaseWnd")
require("gamelogic.zbItem")

local var_0_0 = class("zbYuanzhengPlayerWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createYuanzhengPlayerWnd()
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
		arg_3_0.heroItems = {}
		arg_3_0.playerInfo = nil
		arg_3_0.awardItems = {}
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/yuanzheng_player.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.layer = var_5_2
		arg_3_0.spriteHead = tolua.cast(var_5_2:getChildByTag(1), "CCSprite")
		arg_3_0.lbName = tolua.cast(var_5_2:getChildByTag(2), "CCLabelTTF")

		local var_5_3 = tolua.cast(var_5_2:getChildByTag(3), "CCSprite")
		local var_5_4 = tolua.cast(var_5_3:getChildByTag(1), "CCLabelTTF")
		local var_5_5 = tolua.cast(var_5_2:getChildByTag(4), "CCNode")
		local var_5_6 = tolua.cast(var_5_5:getChildByTag(1), "CCLabelTTF")

		arg_3_0.lbDesc = tolua.cast(var_5_2:getChildByTag(1005), "CCLabelTTF")

		local var_5_7 = tolua.cast(var_5_2:getChildByTag(6), "CCNode")

		for iter_5_0 = 1, 5 do
			local var_5_8 = tolua.cast(var_5_7:getChildByTag(iter_5_0), "CCNode")

			var_5_8:setVisible(false)

			local var_5_9 = createItem()

			var_5_9:setPosition(var_5_8:getPosition())
			var_5_9:setScale(0.8)

			arg_3_0.heroItems[iter_5_0] = var_5_9

			var_5_7:addChild(var_5_9)
			var_5_8:removeFromParentAndCleanup(true)
		end

		local var_5_10 = tolua.cast(var_5_2:getChildByTag(7), "CCNode")

		for iter_5_1 = 1, 3 do
			local var_5_11 = tolua.cast(var_5_10:getChildByTag(iter_5_1), "CCNode")

			var_5_11:setVisible(false)

			local var_5_12 = createItem()

			var_5_12:setPosition(var_5_11:getPosition())
			var_5_12:setScale(0.6)

			arg_3_0.awardItems[iter_5_1] = var_5_12

			var_5_10:addChild(var_5_12)
			var_5_11:removeFromParentAndCleanup(true)
		end

		arg_3_0.btnFight = tolua.cast(var_5_2:getChildByTag(8), "CCControlButton")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")
		arg_3_0.lbFight = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_4, arg_3_0.lbFight)
		arg_3_0.lbFight:setScale(0.6)

		arg_3_0.lbVip = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_6, arg_3_0.lbVip)
		arg_3_0.lbVip:setScale(0.6)
		arg_3_0.btnFight:addHandleOfControlEvent(function()
			arg_3_0:onFight()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnClose:addHandleOfControlEvent(function()
			arg_3_0:hide()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_9_0)
	arg_9_0.bgzInfo = g_GameData.BgzInfo
	arg_9_0.playerInfo = g_Self.kYuanzhengHandler.formationInfo

	if arg_9_0.playerInfo == nil then
		return
	end

	if arg_9_0.playerInfo.PlayerTipsInfo ~= nil then
		arg_9_0.lbName:setString(arg_9_0.playerInfo.PlayerTipsInfo.RoleName)
		arg_9_0.lbFight:setString(arg_9_0.playerInfo.PlayerTipsInfo.FV)
		arg_9_0.lbVip:setString(arg_9_0.playerInfo.PlayerTipsInfo.VipLevel)

		if zbUtil:isValidTable(arg_9_0.playerInfo.PlayerTipsInfo.LegionName) then
			arg_9_0.lbDesc:setString(a2u(arg_9_0.playerInfo.PlayerTipsInfo.LegionName))
		else
			arg_9_0.lbDesc:setString("")
		end

		local var_9_0 = zbIconHelper:getPlayerHeadIconPath(arg_9_0.playerInfo.PlayerTipsInfo.HeadId)

		arg_9_0.spriteHead:setTexture(CCTextureCache:sharedTextureCache():addImage(var_9_0))
	end

	for iter_9_0 = 1, 5 do
		arg_9_0.heroItems[iter_9_0]:setVisible(false)
	end

	for iter_9_1 = 1, 3 do
		arg_9_0.awardItems[iter_9_1]:setVisible(false)
	end

	local var_9_1 = arg_9_0.playerInfo.HeroList
	local var_9_2 = 1

	for iter_9_2, iter_9_3 in pairs(var_9_1) do
		if var_9_2 <= 5 then
			arg_9_0.heroItems[var_9_2]:refreshHero(iter_9_3)
			arg_9_0.heroItems[var_9_2]:setVisible(true)
		end

		var_9_2 = var_9_2 + 1
	end

	local var_9_3 = 1

	for iter_9_4, iter_9_5 in pairs(g_DataConfig.kBgzCommonTable.levelList) do
		if iter_9_5.level == arg_9_0.bgzInfo.CurLevel then
			for iter_9_6, iter_9_7 in pairs(iter_9_5.levelAward) do
				arg_9_0.awardItems[var_9_3]:refreshAward(iter_9_7[1], iter_9_7[2], iter_9_7[3], false)
				arg_9_0.awardItems[var_9_3]:setVisible(true)

				var_9_3 = var_9_3 + 1
			end

			break
		end
	end
end

function var_0_0.onFight(arg_10_0)
	if arg_10_0.bgzInfo.TotalFightCnt - arg_10_0.bgzInfo.DayFightCnt <= 0 then
		g_Bubble:bubbleInfo("\xB1\xBE\xC2\xD6\xCC\xF4ս\xB4\xCE\xCA\xFD\xD2\xD1\xD3\xC3\xCD\xEA")

		return
	end

	arg_10_0:hide()
	g_MainScene:showEmbattleYuanzheng(arg_10_0.playerInfo, g_Self.kYuanzhengHandler.currBtnIndex)
end

function var_0_0.onTouchTest(arg_11_0)
	local var_11_0 = arg_11_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_11_0.layer, var_11_0.x, var_11_0.y) == false and zbUtil:PointInCtrl(arg_11_0.btnClose, var_11_0.x, var_11_0.y) == false then
		arg_11_0:hide()
	end
end
