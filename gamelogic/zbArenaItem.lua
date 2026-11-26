local var_0_0 = class("zbArenaItem", CCNodeExtend)

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

function createArenaItem(arg_2_0)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.playerInfo = nil
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCLayer")

		arg_3_0.lbRankDummy = tolua.cast(var_5_0:getChildByTag(1001), "CCLabelTTF")
		arg_3_0.spriteIcon = tolua.cast(var_5_0:getChildByTag(2), "CCSprite")
		arg_3_0.lbName = tolua.cast(var_5_0:getChildByTag(3), "CCLabelTTF")
		arg_3_0.lbLelelDummy = tolua.cast(var_5_0:getChildByTag(1004), "CCLabelTTF")
		arg_3_0.lbFightDummy = tolua.cast(var_5_0:getChildByTag(1005), "CCLabelTTF")
		arg_3_0.btnFight = tolua.cast(var_5_0:getChildByTag(6), "CCControlButton")
		arg_3_0.spriteDeclare = tolua.cast(var_5_0:getChildByTag(7), "CCSprite")
		arg_3_0.lbDeclare = tolua.cast(arg_3_0.spriteDeclare:getChildByTag(1000), "CCLabelTTF")

		arg_3_0.spriteDeclare:setZOrder(ZORDER_TOP)
		arg_3_0.spriteDeclare:setVisible(false)

		arg_3_0.lbRank = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbRankDummy, arg_3_0.lbRank)
		arg_3_0.lbRank:setScale(0.5)

		arg_3_0.lbLevel = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbLelelDummy, arg_3_0.lbLevel)
		arg_3_0.lbLevel:setScale(0.45)

		arg_3_0.lbFight = CCLabelAtlas:create("", "font/rank_num_yellow.png", 26, 42, string.byte("+"))

		require("gamebase.zbUI"):replaceCtrl(arg_3_0.lbFightDummy, arg_3_0.lbFight)
		arg_3_0.lbFight:setScale(0.5)
		arg_3_0.btnFight:setZoomChildNode(var_5_0)
		arg_3_0.btnFight:setZoomOnTouchDown(true)
		arg_3_0.btnFight:setZoomScaleOuterFactor(1.03)
		arg_3_0.btnFight:addHandleOfControlEvent(function()
			arg_3_0:onFight()
		end, CCControlEventTouchUpInside)
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_7_0, arg_7_1)
	arg_7_0.playerInfo = arg_7_1

	if arg_7_1 == nil then
		return
	end

	if arg_7_1.PlayerFormationInfo and arg_7_1.PlayerFormationInfo.PlayerTipsInfo ~= nil then
		arg_7_0.lbRank:setString(arg_7_1.PlayerFormationInfo.PlayerTipsInfo.Rank)
		arg_7_0.lbLevel:setString(arg_7_1.PlayerFormationInfo.PlayerTipsInfo.Level)
		arg_7_0.lbName:setString(arg_7_1.PlayerFormationInfo.PlayerTipsInfo.RoleName)
		arg_7_0.lbFight:setString(arg_7_1.PlayerFormationInfo.PlayerTipsInfo.FV)

		local var_7_0 = zbIconHelper:getPlayerHeadIconPath(arg_7_1.PlayerFormationInfo.PlayerTipsInfo.HeadId)

		arg_7_0.spriteIcon:setTexture(CCTextureCache:sharedTextureCache():addImage(var_7_0))
	end

	if arg_7_1.Signature == "" then
		arg_7_0.lbDeclare:setString(a2u("һȺս\xCE\xE5\xD4\xFC\xA3\xA1\xB2\xBB\xB7\xFE\xC0\xB4ս"))
	else
		arg_7_0.lbDeclare:setString(arg_7_1.Signature)
	end
end

function var_0_0.onFight(arg_8_0)
	if g_MainScene.wndArena then
		g_MainScene:showArenaPlayerWnd(arg_8_0.playerInfo)
	end
end

function var_0_0.setDeclareVisible(arg_9_0)
	local function var_9_0(arg_10_0)
		arg_9_0.spriteDeclare:setVisible(false)
	end

	local var_9_1 = CCArray:create()

	var_9_1:addObject(CCDelayTime:create(5))
	var_9_1:addObject(CCCallFuncN:create(var_9_0))
	arg_9_0.spriteDeclare:setVisible(true)
	arg_9_0.spriteDeclare:stopAllActions()
	arg_9_0.spriteDeclare:runAction(CCSequence:create(var_9_1))
end
