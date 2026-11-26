require("gamecore.zbUIAnimation")

local var_0_0 = class("zbBuildingFarm")

var_0_0.__index = var_0_0

function createBuildingFarm(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local function var_2_0()
		arg_2_0.parentWnd = arg_2_1
		arg_2_0.config = arg_2_3
		arg_2_0.lastLevel = g_Self.kFarmHandler:getLevel()
	end

	local function var_2_1()
		local function var_4_0(arg_5_0)
			local var_5_0 = CCSprite:create("image/main/scene/banner/level_bg.png")
			local var_5_1 = CCLabelTTF:create("", DefaultFontName, 20)

			var_5_1:setPosition(22, 20)
			var_5_1:setAnchorPoint(ccp(0.5, 0.5))
			var_5_0:setPosition(-6, 18)
			var_5_0:setAnchorPoint(ccp(0.5, 0.5))
			var_5_0:setVisible(false)
			var_5_0:addChild(var_5_1)
			arg_5_0:addChild(var_5_0)

			return var_5_0, var_5_1
		end

		function createLevyMoveAction(arg_6_0, arg_6_1)
			arg_6_0:setPosition(arg_6_1)

			local var_6_0 = 1.1
			local var_6_1 = 10
			local var_6_2 = ccp(arg_6_0:getPosition())

			var_6_2.y = var_6_2.y - var_6_1

			local var_6_3 = CCMoveTo:create(var_6_0, var_6_2)

			var_6_2.y = var_6_2.y + var_6_1 * 2

			local var_6_4 = CCMoveTo:create(var_6_0, var_6_2)
			local var_6_5 = CCArray:create()

			var_6_5:addObject(var_6_3)
			var_6_5:addObject(var_6_4)

			local var_6_6 = CCSequence:create(var_6_5)

			arg_6_0:stopAllActions()
			arg_6_0:runAction(CCRepeatForever:create(var_6_6))
		end

		local function var_4_1()
			function createArrowMoveAction(arg_8_0)
				local var_8_0 = 1.1
				local var_8_1 = 10
				local var_8_2 = ccp(arg_8_0:getPosition())

				var_8_2.y = var_8_2.y - 3

				local var_8_3 = CCMoveTo:create(var_8_0, var_8_2)

				var_8_2.y = var_8_2.y + 6

				local var_8_4 = CCMoveTo:create(var_8_0, var_8_2)
				local var_8_5 = CCArray:create()

				var_8_5:addObject(var_8_3)
				var_8_5:addObject(var_8_4)

				local var_8_6 = CCSequence:create(var_8_5)

				arg_8_0:stopAllActions()
				arg_8_0:runAction(CCRepeatForever:create(var_8_6))
			end

			arg_2_0.levelup_tag = CCSprite:create("image/common/arrow_up.png")

			arg_2_0.levelup_tag:setAnchorPoint(ccp(0.5, 0.5))
			arg_2_0.levelup_tag:setPosition(-35, 18)
			arg_2_0.spriteBanner:addChild(arg_2_0.levelup_tag)
			createArrowMoveAction(arg_2_0.levelup_tag)
		end

		arg_2_0.node = tolua.cast(arg_2_2:getChildByTag(arg_2_0.config.buildingType), "CCNode")
		arg_2_0.btnTouch = tolua.cast(arg_2_0.node:getChildByTag(1), "CCControlButton")
		arg_2_0.dummyAnimNode = tolua.cast(arg_2_0.node:getChildByTag(2), "CCNode")
		arg_2_0.spriteBanner = tolua.cast(arg_2_0.node:getChildByTag(3), "CCSprite")

		local var_4_2 = tolua.cast(arg_2_0.spriteBanner:getChildByTag(2), "CCLabelTTF")

		arg_2_0.spriteHighlight = tolua.cast(arg_2_0.node:getChildByTag(4), "CCSprite")
		arg_2_0.levelup = tolua.cast(arg_2_0.node:getChildByTag(100), "CCNode")
		arg_2_0.levy = tolua.cast(arg_2_0.node:getChildByTag(200), "CCNode")
		arg_2_0.fxChuizhi = createUIAnimation()

		arg_2_0.fxChuizhi:refresh("effect/spine/ui_chuizi/chuzi.json", "effect/spine/ui_chuizi/chuzi.atlas")
		arg_2_0.fxChuizhi:setPosition(0, 0)
		arg_2_0.fxChuizhi:setAnchorPoint(ccp(0.5, 0))
		arg_2_0.fxChuizhi:setAnimation("animation", true)
		arg_2_0.fxChuizhi:setVisible(false)
		arg_2_0.dummyAnimNode:addChild(arg_2_0.fxChuizhi)
		arg_2_0.dummyAnimNode:setVisible(true)

		arg_2_0.spriteLevelBg, arg_2_0.lbLevel = var_4_0(arg_2_0.spriteBanner)

		arg_2_0.levelup:setVisible(false)

		arg_2_0.levelup_bg = tolua.cast(arg_2_0.levelup:getChildByTag(1), "CCSprite")
		arg_2_0.levelup_fg = tolua.cast(arg_2_0.levelup:getChildByTag(2), "CCSprite")
		arg_2_0.levelup_time = tolua.cast(arg_2_0.levelup:getChildByTag(3), "CCLabelTTF")
		arg_2_0.levy_btn = tolua.cast(arg_2_0.levy:getChildByTag(0), "CCControlButton")

		arg_2_0.levy_btn:addHandleOfControlEvent(function()
			arg_2_0:onLevy()
		end, CCControlEventTouchUpInside)
		createLevyMoveAction(arg_2_0.levy, ccp(arg_2_0.levy:getPosition()))
		var_4_1()
		arg_2_0.btnTouch:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_2_0.btnTouch:addHandleOfControlEvent(function()
			arg_2_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_2_0.spriteHighlight:setVisible(false)
	end

	var_2_0()
	var_2_1()
	arg_2_0.parentWnd:registerEvent(arg_2_0.parentWnd, function()
		arg_2_0:onLevyAck()
	end, zbGameEvent.Event_FarmLevy_Ack)
end

function var_0_0.onFrameUpdate(arg_12_0, arg_12_1)
	arg_12_0:updateDetailInfo()

	if arg_12_0.lastLevel < g_Self.kFarmHandler:getLevel() then
		arg_12_0.lastLevel = g_Self.kFarmHandler:getLevel()

		arg_12_0:palyLevelUpAnim()
	end
end

function var_0_0.updateDetailInfo(arg_13_0)
	local var_13_0 = g_Self.kFarmHandler:isUpgrading()

	arg_13_0.levelup:setVisible(var_13_0)

	if var_13_0 then
		arg_13_0.levelup_fg:setScaleX(g_Self.kFarmHandler:getUpgradeTimePercent())
		arg_13_0.levelup_time:setString(zbUtil:SprintfHHMMSSNo24(g_Self.kFarmHandler:getNeedTime()))
	end

	if g_Self.kFarmHandler:getCurLevyTime() > 30 + math.min(g_Self.kFarmHandler:getLevel() * 60 * 2, 600) then
		arg_13_0.levy:setVisible(true)
	else
		arg_13_0.levy:setVisible(false)
	end

	arg_13_0.levelup_tag:setVisible(g_Self.kFarmHandler:isCanLevelUp())
	arg_13_0.spriteLevelBg:setVisible(true)
	arg_13_0.lbLevel:setString(g_Self.kFarmHandler:getLevel())
end

function var_0_0.palyLevelUpAnim(arg_14_0)
	local function var_14_0()
		arg_14_0.fxChuizhi:setAnimation("animation", true)
		arg_14_0.fxChuizhi:setVisible(true)
		g_Audio:playSound("audio/sound/ui_building_upgrade.mp3")
	end

	local function var_14_1()
		arg_14_0.fxChuizhi:clearTracks()
		arg_14_0.fxChuizhi:setVisible(false)
	end

	local var_14_2 = CCArray:create()

	var_14_2:addObject(CCCallFuncN:create(var_14_0))
	var_14_2:addObject(CCDelayTime:create(0.9166666666666666))
	var_14_2:addObject(CCCallFuncN:create(var_14_1))
	var_14_2:addObject(CCScaleTo:create(0.25, 1.15))
	var_14_2:addObject(CCScaleTo:create(0.15, 1))

	local var_14_3 = CCSequence:create(var_14_2)

	arg_14_0.dummyAnimNode:stopAllActions()
	arg_14_0.dummyAnimNode:runAction(var_14_3)
	g_MainScene:popupEventComplete(a2u("ũ\xCC\xEF\xC9\xFD\xBC\xB6\xCD\xEA\xB3\xC9"))
end

function var_0_0.onLevy(arg_17_0)
	g_WsMsgHandler:WS_Building_Income_Req()
end

function var_0_0.onLevyAck(arg_18_0)
	g_Audio:playSound("audio/sound/ui_resource_gain.mp3")
end

function var_0_0.onTouch(arg_19_0)
	g_MainScene:showFarmWnd()
end

function var_0_0.touchBegan(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = ui:PointInCtrl(arg_20_0.btnTouch, arg_20_1, arg_20_2, false)

	arg_20_0.spriteHighlight:setVisible(var_20_0)
end

function var_0_0.touchMoved(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = ui:PointInCtrl(arg_21_0.btnTouch, arg_21_1, arg_21_2, false)

	arg_21_0.spriteHighlight:setVisible(var_21_0)
end

function var_0_0.touchEnded(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0.spriteHighlight:setVisible(false)
end
