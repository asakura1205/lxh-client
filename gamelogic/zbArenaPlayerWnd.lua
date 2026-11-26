require("gamelogic.zbBaseWnd")
require("gamelogic.zbItem")

local var_0_0 = class("zbArenaPlayerWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createArenaPlayerWnd()
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
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/arena_player.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.layer = var_5_2
		arg_3_0.spriteHead = tolua.cast(var_5_2:getChildByTag(1), "CCSprite")
		arg_3_0.lbName = tolua.cast(var_5_2:getChildByTag(2), "CCLabelTTF")

		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1010), "CCLabelTTF")
		local var_5_4 = tolua.cast(var_5_2:getChildByTag(3), "CCSprite")
		local var_5_5 = tolua.cast(var_5_4:getChildByTag(1001), "CCLabelTTF")
		local var_5_6 = tolua.cast(var_5_2:getChildByTag(4), "CCNode")
		local var_5_7 = tolua.cast(var_5_6:getChildByTag(1001), "CCLabelTTF")

		arg_3_0.lbDesc = tolua.cast(var_5_2:getChildByTag(1005), "CCLabelTTF")
		arg_3_0.lbArena = tolua.cast(var_5_2:getChildByTag(1006), "CCLabelTTF")

		local var_5_8 = tolua.cast(var_5_2:getChildByTag(1007), "CCLabelTTF")
		local var_5_9 = tolua.cast(var_5_2:getChildByTag(8), "CCNode")

		for iter_5_0 = 1, 5 do
			local var_5_10 = tolua.cast(var_5_9:getChildByTag(iter_5_0), "CCNode")

			var_5_10:setVisible(false)

			local var_5_11 = createItem()

			var_5_11:setPosition(var_5_10:getPosition())
			var_5_11:setScale(0.8)

			arg_3_0.heroItems[iter_5_0] = var_5_11

			var_5_9:addChild(var_5_11)
			var_5_10:removeFromParentAndCleanup(true)
		end

		arg_3_0.btnFight = tolua.cast(var_5_2:getChildByTag(9), "CCControlButton")
		arg_3_0.btnClose = tolua.cast(var_5_2:getChildByTag(31), "CCControlButton")
		arg_3_0.lbLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_3, arg_3_0.lbLevel)
		arg_3_0.lbLevel:setScale(0.45)

		arg_3_0.lbFight = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_5, arg_3_0.lbFight)
		arg_3_0.lbFight:setScale(0.55)

		arg_3_0.lbVip = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_7, arg_3_0.lbVip)
		arg_3_0.lbVip:setScale(0.55)

		arg_3_0.lbRank = CCLabelAtlas:create("", "font/rank_num_white.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(var_5_8, arg_3_0.lbRank)
		arg_3_0.lbRank:setScale(0.55)
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

function var_0_0.refresh(arg_9_0, arg_9_1)
	arg_9_0.playerInfo = arg_9_1

	if zbUtil:isValidTable(arg_9_1) == false or zbUtil:isValidTable(arg_9_1.PlayerFormationInfo) == false then
		return
	end

	if arg_9_1.PlayerFormationInfo.PlayerTipsInfo ~= nil then
		arg_9_0.lbName:setString(arg_9_1.PlayerFormationInfo.PlayerTipsInfo.RoleName)
		arg_9_0.lbLevel:setString(arg_9_1.PlayerFormationInfo.PlayerTipsInfo.Level)
		arg_9_0.lbFight:setString(arg_9_1.PlayerFormationInfo.PlayerTipsInfo.FV)
		arg_9_0.lbVip:setString(arg_9_1.PlayerFormationInfo.PlayerTipsInfo.VipLevel)

		if type(arg_9_1.PlayerFormationInfo.PlayerTipsInfo.LegionName) ~= "userdata" then
			arg_9_0.lbDesc:setString(a2u("\xBB\xE1\xB9\xDD:") .. a2u(arg_9_1.PlayerFormationInfo.PlayerTipsInfo.LegionName))
		else
			arg_9_0.lbDesc:setString(a2u("\xBB\xE1\xB9\xDD:\xCE\xDE"))
		end

		arg_9_0.lbRank:setString(arg_9_1.PlayerFormationInfo.PlayerTipsInfo.Rank)

		local var_9_0 = zbIconHelper:getPlayerHeadIconPath(arg_9_1.PlayerFormationInfo.PlayerTipsInfo.HeadId)

		arg_9_0.spriteHead:setTexture(CCTextureCache:sharedTextureCache():addImage(var_9_0))
	end

	for iter_9_0 = 1, 5 do
		arg_9_0.heroItems[iter_9_0]:setVisible(false)
	end

	local var_9_1 = arg_9_1.PlayerFormationInfo.HeroList
	local var_9_2 = 1

	for iter_9_1, iter_9_2 in pairs(var_9_1) do
		if var_9_2 <= 5 then
			arg_9_0.heroItems[var_9_2]:refreshHero(iter_9_2)
			arg_9_0.heroItems[var_9_2]:setVisible(true)
		end

		var_9_2 = var_9_2 + 1
	end
end

function var_0_0.onFight(arg_10_0)
	if g_MainScene.wndArena and g_MainScene.wndArena:canChanllenge() and arg_10_0.playerInfo ~= nil then
		g_MainScene.wndArena:hide()
		arg_10_0:hide()
		g_MainScene:showEmbattleArena(arg_10_0.playerInfo.PlayerFormationInfo)
	end
end

function var_0_0.onTouchTest(arg_11_0)
	local var_11_0 = arg_11_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_11_0.layer, var_11_0.x, var_11_0.y) == false and zbUtil:PointInCtrl(arg_11_0.btnClose, var_11_0.x, var_11_0.y) == false then
		arg_11_0:hide()
	end
end
