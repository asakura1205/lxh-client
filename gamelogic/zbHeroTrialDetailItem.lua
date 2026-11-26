require("gamecore.zbAwardHelper")
require("gamelogic.zbItem")

local var_0_0 = class("zbHeroTrialDetailItem", CCNodeExtend)

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

function createHeroTrialDetailItem(arg_2_0, arg_2_1)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0, arg_2_1)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2)
	local function var_3_0()
		arg_3_0.type = 1
		arg_3_0.level = 1
		arg_3_0.trialRecord = nil
		arg_3_0.awardItem = {}
		arg_3_0.parentWnd = arg_3_2
		arg_3_0.leftTimes = 0
	end

	local function var_3_1()
		local var_5_0 = tolua.cast(arg_3_1:getChildByTag(1), "CCNode")

		arg_3_0.layer = var_5_0
		arg_3_0.spriteBg = tolua.cast(var_5_0:getChildByTag(1), "CCSprite")

		for iter_5_0 = 1, 3 do
			local var_5_1 = tolua.cast(arg_3_0.layer:getChildByTag(12 + iter_5_0), "CCLayerColor")
			local var_5_2 = createItem()
			local var_5_3 = ccp(var_5_1:getPosition())

			var_5_2:setPosition(var_5_3.x + 20, var_5_3.y + 20)
			var_5_2:setScale(0.6)
			var_5_2:setSwallowsTouches(false)
			arg_3_0.layer:addChild(var_5_2)

			arg_3_0.awardItem[iter_5_0] = var_5_2

			var_5_1:removeFromParentAndCleanup(true)
		end

		arg_3_0.centerPositionX = arg_3_0.awardItem[2]:getPositionX()
		arg_3_0.btnSweep = tolua.cast(var_5_0:getChildByTag(4), "CCControlButton")
		arg_3_0.btnFight = tolua.cast(var_5_0:getChildByTag(5), "CCControlButton")
		arg_3_0.lblneedlevel = tolua.cast(var_5_0:getChildByTag(6), "CCLabelTTF")
		arg_3_0.btnFightbig = tolua.cast(var_5_0:getChildByTag(7), "CCControlButton")

		arg_3_0.btnSweep:addHandleOfControlEvent(function()
			arg_3_0:onSaodang()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnFight:addHandleOfControlEvent(function()
			arg_3_0:onFight()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnFightbig:addHandleOfControlEvent(function()
			arg_3_0:onFight()
		end, CCControlEventTouchUpInside)
		arg_3_0.btnFight:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnSweep:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0.btnFightbig:setToucheMoveDelta(MOVE_TEST_DELTA)
		arg_3_0:addChild(arg_3_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.type = arg_9_1
	arg_9_0.level = arg_9_2
	arg_9_0.trialRecord = zbHeroTrialDegreeTable:getRecord(arg_9_1, arg_9_2)
	arg_9_0.spriteframeCache = CCSpriteFrameCache:sharedSpriteFrameCache()

	arg_9_0.spriteframeCache:addSpriteFramesWithFile("ui/image/plist/herotrial.plist")

	local var_9_0 = arg_9_0.spriteframeCache:spriteFrameByName("herotrial_dif" .. arg_9_2 .. ".png")

	if var_9_0 then
		arg_9_0.spriteBg:initWithSpriteFrame(var_9_0)
	end

	for iter_9_0 = 1, 3 do
		arg_9_0.awardItem[iter_9_0]:setVisible(false)
	end

	local var_9_1 = 1

	for iter_9_1, iter_9_2 in pairs(arg_9_0.trialRecord.awardList) do
		arg_9_0.awardItem[var_9_1]:refreshAward(iter_9_2.awardType, iter_9_2.awardId, iter_9_2.awardCount, false)
		arg_9_0.awardItem[var_9_1]:setVisible(true)

		var_9_1 = var_9_1 + 1
	end

	zbUIEffect:centerStar(arg_9_0.awardItem, arg_9_0.centerPositionX)

	local var_9_2 = g_Self.kHeroTrialHandler:getTrialStars(arg_9_0.type, arg_9_2)
	local var_9_3 = arg_9_0.trialRecord.openLevel
	local var_9_4 = false

	if var_9_3 > g_Self:getLevel() then
		arg_9_0.lblneedlevel:setString(a2u("(") .. var_9_3 .. a2u("\xBC\xB6\xBF\xAA\xB7ţ\xA9"))
		arg_9_0.layer:setGray(true)
		arg_9_0.lblneedlevel:setVisible(true)
	else
		local var_9_5 = g_Self.kHeroTrialHandler:getTrialStars(arg_9_0.type, arg_9_0.level - 1)

		if arg_9_0.level > 1 and var_9_5 < 3 then
			arg_9_0.lblneedlevel:setString(a2u("ǰ\xD6\xC33\xD0ǿ\xC9\xCC\xF4ս\xB1\xBE\xC4Ѷ\xC8"))
			arg_9_0.layer:setGray(true)
			arg_9_0.lblneedlevel:setVisible(true)
		else
			var_9_4 = true

			arg_9_0.layer:setGray(false)
			arg_9_0.lblneedlevel:setVisible(false)
		end
	end

	if var_9_4 then
		arg_9_0.btnFightbig:setVisible(var_9_2 < 3)
		arg_9_0.btnSweep:setVisible(var_9_2 >= 3)
		arg_9_0.btnFight:setVisible(var_9_2 >= 3)
	else
		arg_9_0.btnSweep:setVisible(false)
		arg_9_0.btnFight:setVisible(false)
		arg_9_0.btnFightbig:setVisible(false)
	end

	for iter_9_3 = 1, 3 do
		tolua.cast(arg_9_0.layer:getChildByTag(iter_9_3 + 9), "CCSprite"):setGray(true)
	end

	for iter_9_4 = 1, var_9_2 do
		tolua.cast(arg_9_0.layer:getChildByTag(iter_9_4 + 9), "CCSprite"):setGray(false)
	end

	arg_9_0.leftTimes = g_Self.kHeroTrialHandler:getLeftTrialNumByType(arg_9_0.type)
end

function var_0_0.onSaodang(arg_10_0)
	local var_10_0 = zbVipTable:getRecord(g_Self:getVipLevel())

	if var_10_0 and not var_10_0.heroTrialSweepbOpen then
		g_Bubble:bubbleInfo(a2u("ɨ\xB5\xB4vip") .. zbVipTable.minheroTrialSweepOpenlv .. a2u("\xBF\xAA\xC6\xF4"))

		return
	end

	if arg_10_0.leftTimes <= 0 then
		g_Bubble:bubbleInfo(a2u("\xBD\xF1\xC8մ\xCE\xCA\xFD\xD2\xD1\xD3\xC3\xCD\xEA"))

		return
	end

	g_WsMsgHandler:WS_Trial_SaoDang_Req(arg_10_0.type, arg_10_0.level)
end

function var_0_0.onFight(arg_11_0)
	local var_11_0 = g_Self.kFormation:getWorkingHero()

	if table.getn(var_11_0) <= 0 then
		g_MainScene:showFormationWnd():setPrevWnd(arg_11_0.parentWnd)

		return
	end

	if arg_11_0.leftTimes <= 0 then
		g_Bubble:bubbleInfo(a2u("\xBD\xF1\xC8մ\xCE\xCA\xFD\xD2\xD1\xD3\xC3\xCD\xEA"))

		return
	end

	g_MainScene:showEmbattleTrial(arg_11_0.type, arg_11_0.level)
end
