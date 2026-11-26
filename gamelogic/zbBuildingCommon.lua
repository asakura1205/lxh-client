require("gamecore.zbUIAnimation")

local var_0_0 = class("zbBuildingCommon")

var_0_0.__index = var_0_0

function createBuildingCommon(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_0.new()

	var_1_0:init(arg_1_0, arg_1_1, arg_1_2)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local function var_2_0()
		arg_2_0.parentWnd = arg_2_1
		arg_2_0.config = arg_2_3
	end

	local function var_2_1()
		local function var_4_0(arg_5_0)
			local var_5_0 = CCSprite:create(NOTIFY_TAG_PATH)

			var_5_0:setPosition(100, 25)
			var_5_0:setVisible(false)
			arg_5_0:addChild(var_5_0)
			zbUIEffect:createNotifyTagScaleAction(var_5_0)

			return var_5_0
		end

		local function var_4_1(arg_6_0)
			local var_6_0 = CCSprite:create("image/hero/hero_new.png")

			var_6_0:setAnchorPoint(ccp(0.5, 0.5))
			var_6_0:setPosition(arg_6_0:getContentSize().width - 20, arg_6_0:getContentSize().height / 2 + 20)
			var_6_0:setVisible(false)
			arg_6_0:addChild(var_6_0)
			zbUIEffect:createNotifyTagScaleAction(var_6_0)

			return var_6_0
		end

		arg_2_0.node = tolua.cast(arg_2_2:getChildByTag(arg_2_0.config.buildingType), "CCNode")
		arg_2_0.btnTouch = tolua.cast(arg_2_0.node:getChildByTag(1), "CCControlButton")
		arg_2_0.spriteBanner = tolua.cast(arg_2_0.node:getChildByTag(3), "CCSprite")

		local var_4_2 = tolua.cast(arg_2_0.spriteBanner:getChildByTag(2), "CCLabelTTF")

		arg_2_0.spriteLock = tolua.cast(arg_2_0.spriteBanner:getChildByTag(4), "CCSprite")
		arg_2_0.spriteHighlight = tolua.cast(arg_2_0.node:getChildByTag(4), "CCSprite")

		if arg_2_0.config.buildingType == EBuildingType.Bgz or arg_2_0.config.buildingType == EBuildingType.Trial then
			arg_2_0.spriteDouble = tolua.cast(arg_2_0.node:getChildByTag(5), "CCSprite")
		end

		for iter_4_0, iter_4_1 in pairs(EBuildingHint) do
			if iter_4_1.buildingType == arg_2_0.config.buildingType then
				arg_2_0.spiteHitMe = CCSprite:create("image/main/main_hitme.png")
				arg_2_0.costValue = CCLabelTTF:create(a2u(iter_4_1.hintLog), DefaultFontName, 20)

				arg_2_0.spiteHitMe:setPosition(-50, 85)
				arg_2_0.spiteHitMe:setScaleX(iter_4_1.scaleX)
				arg_2_0.costValue:setPosition(-25, 106)

				if arg_2_0.config.buildingType == EBuildingType.Legion then
					arg_2_0.spiteHitMe:setFlipX(true)
					arg_2_0.costValue:setPosition(-185, 106)
					arg_2_0.spiteHitMe:setPosition(-210, 85)
				end

				arg_2_0.spiteHitMe:setAnchorPoint(ccp(0, 0))
				arg_2_0.costValue:setAnchorPoint(ccp(0, 0))
				arg_2_0.costValue:setColor(FONT_COLOR_BLACK)
				arg_2_0.node:addChild(arg_2_0.spiteHitMe)
				arg_2_0.node:addChild(arg_2_0.costValue)
				zbUIEffect:createArrowMoveAction(arg_2_0.spiteHitMe, 5, 2)
				zbUIEffect:createArrowMoveAction(arg_2_0.costValue, 5, 2)
			end
		end

		if arg_2_0.config.buildingType == EBuildingType.Legion or arg_2_0.config.buildingType == EBuildingType.Shop or arg_2_0.config.buildingType == EBuildingType.Rank or arg_2_0.config.buildingType == EBuildingType.Smithy then
			arg_2_0.strBuildGuide = "BuildIngGuide" .. g_GameData.BaseInfo.PlayerId .. "_" .. arg_2_0.config.buildingType

			if zbGameCore:Instance():getConfigValue(arg_2_0.strBuildGuide) ~= 1 then
				arg_2_0.newOpen = var_4_1(arg_2_0.spriteBanner)
			end
		end

		var_4_2:setString(a2u(arg_2_3.name))

		arg_2_0.spriteNotify = var_4_0(arg_2_0.spriteBanner)

		arg_2_0.btnTouch:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_2_0.btnTouch:addHandleOfControlEvent(function()
			arg_2_0:onTouch()
		end, CCControlEventTouchUpInside)
		arg_2_0.spriteHighlight:setVisible(false)
	end

	var_2_0()
	var_2_1()

	if arg_2_0.spriteDouble then
		arg_2_0.spriteDouble:setVisible(false)
	end
end

function var_0_0.onFrameUpdate(arg_8_0, arg_8_1)
	if arg_8_0.spriteLock then
		arg_8_0.spriteLock:setVisible(zbFunHelper:isBuildingLockNoTip(arg_8_0.config.buildingType))
	end

	if arg_8_0.spriteDouble and g_GameStateMachine:isOneSecondPassed() then
		local var_8_0

		if arg_8_0.config.buildingType == EBuildingType.Bgz then
			var_8_0 = g_Self.kGmActivityHandler:getGmActivityDoubleDrop(EActDoubleDropType.Pata) or g_Self.kGmActivityHandler:getGmActivityDoubleDrop(EActDoubleDropType.Bgz)
		elseif arg_8_0.config.buildingType == EBuildingType.Trial then
			var_8_0 = g_Self.kGmActivityHandler:getGmActivityDoubleDrop(EActDoubleDropType.HeroTrial)
		end

		arg_8_0.spriteDouble:setVisible(var_8_0 ~= nil)
	end

	if arg_8_0.newOpen then
		local var_8_1 = zbGameCore:Instance():getConfigValue(arg_8_0.strBuildGuide)

		arg_8_0.newOpen:setVisible(not zbFunHelper:isBuildingLockNoTip(arg_8_0.config.buildingType) and var_8_1 ~= "1")
	end

	arg_8_0:updateNotify()
end

function var_0_0.showHint(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0.spiteHitMe ~= nil then
		if arg_9_1 == arg_9_0.config.buildingType or arg_9_2 == arg_9_0.config.buildingType then
			arg_9_0.spiteHitMe:setVisible(true)
			arg_9_0.costValue:setVisible(true)
		else
			arg_9_0.spiteHitMe:setVisible(false)
			arg_9_0.costValue:setVisible(false)
		end
	end
end

function var_0_0.updateNotify(arg_10_0)
	if arg_10_0.config.buildingType == EBuildingType.Pub then
		arg_10_0.spriteNotify:setVisible(g_Self.kRedPointHandler:hasRedPoint(ERedPointType.Pub))
	elseif arg_10_0.config.buildingType == EBuildingType.Smithy then
		-- block empty
	elseif arg_10_0.config.buildingType == EBuildingType.Tech then
		arg_10_0.spriteNotify:setVisible(g_Self.kRedPointHandler:hasRedPoint(ERedPointType.Tech) or g_Self.kHeroSoulHallHandler:hasHeroSoulHall())
	elseif arg_10_0.config.buildingType == EBuildingType.Arena then
		arg_10_0.spriteNotify:setVisible(g_Self.kRedPointHandler:hasRedPoint(ERedPointType.Arena))
	elseif arg_10_0.config.buildingType == EBuildingType.Trial then
		arg_10_0.spriteNotify:setVisible(g_Self.kRedPointHandler:hasRedPoint(ERedPointType.HeroTrial))
	elseif arg_10_0.config.buildingType == EBuildingType.World then
		arg_10_0.spriteNotify:setVisible(g_Self.kRedPointHandler:hasRedPoint(ERedPointType.World))
	elseif arg_10_0.config.buildingType == EBuildingType.God then
		arg_10_0.spriteNotify:setVisible(g_Self.kRedPointHandler:hasRedPoint(ERedPointType.GodLevelUp) or g_Self.kRedPointHandler:hasRedPoint(ERedPointType.GodStarUp) or g_Self.kRedPointHandler:hasRedPoint(ERedPointType.GodSkillUp))
	elseif arg_10_0.config.buildingType == EBuildingType.Bgz then
		arg_10_0.spriteNotify:setVisible(g_Self.kRedPointHandler:hasRedPoint(ERedPointType.Bgz))
	elseif arg_10_0.config.buildingType == EBuildingType.Legion then
		arg_10_0.spriteNotify:setVisible(g_Self.kRedPointHandler:hasRedPoint(ERedPointType.Legion))
	end
end

function var_0_0.onTouch(arg_11_0)
	local var_11_0 = arg_11_0.config.buildingType

	if zbFunHelper:isBuildingLockAndTip(var_11_0) then
		return
	end

	if var_11_0 == EBuildingType.Pub then
		g_MainScene:showPubWnd()
	elseif var_11_0 == EBuildingType.Smithy then
		g_MainScene:showDecomposeList()

		if arg_11_0.newOpen ~= nil then
			arg_11_0.newOpen:setVisible(false)
			zbGameCore:Instance():setConfigValue(arg_11_0.strBuildGuide, 1)
		end
	elseif var_11_0 == EBuildingType.Tech then
		g_MainScene:showTechListWnd()
	elseif var_11_0 == EBuildingType.Shop then
		g_MainScene:showShopWnd()

		if arg_11_0.newOpen ~= nil then
			arg_11_0.newOpen:setVisible(false)
			zbGameCore:Instance():setConfigValue(arg_11_0.strBuildGuide, 1)
		end
	elseif var_11_0 == EBuildingType.Arena then
		g_MainScene:showArenaWnd()
	elseif var_11_0 == EBuildingType.Trial then
		g_Self.kHeroTrialHandler:openHeroTrial()
	elseif var_11_0 == EBuildingType.Legion then
		if g_GameData.LegionInfo and g_GameData.LegionInfo.LegionId > 0 then
			g_MainScene:showLegionSceneWnd()
		else
			g_MainScene:showLegionNoWnd()
		end

		if arg_11_0.newOpen ~= nil then
			arg_11_0.newOpen:setVisible(false)
			zbGameCore:Instance():setConfigValue(arg_11_0.strBuildGuide, 1)
		end
	elseif var_11_0 == EBuildingType.God then
		g_MainScene:showGodWnd()
	elseif var_11_0 == EBuildingType.World then
		g_MainScene:showWorld()
	elseif var_11_0 == EBuildingType.Bgz then
		g_MainScene:showShenShanListWnd()
	elseif var_11_0 == EBuildingType.Kuafu then
		g_Bubble:bubbleInfo(a2u("\xA1\xBE\xBF\xE7\xB7\xFEս\xA1\xBF\xD4\xDDδ\xBF\xAA\xB7\xC5"))
	elseif arg_11_0.config.buildingType == EBuildingType.Rank then
		g_WsMsgHandler:WS_Rank_Arena_Req()

		if arg_11_0.newOpen ~= nil then
			arg_11_0.newOpen:setVisible(false)
			zbGameCore:Instance():setConfigValue(arg_11_0.strBuildGuide, 1)
		end
	end
end

function var_0_0.touchBegan(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = ui:PointInCtrl(arg_12_0.btnTouch, arg_12_1, arg_12_2, false)

	arg_12_0.spriteHighlight:setVisible(var_12_0)
end

function var_0_0.touchMoved(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = ui:PointInCtrl(arg_13_0.btnTouch, arg_13_1, arg_13_2, false)

	arg_13_0.spriteHighlight:setVisible(var_13_0)
end

function var_0_0.touchEnded(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0.spriteHighlight:setVisible(false)
end
