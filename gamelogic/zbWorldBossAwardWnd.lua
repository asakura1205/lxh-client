require("gamelogic.zbBaseWnd")
require("gamelogic.zbItem")

local var_0_0 = class("zbWorldBossAwardWnd", zbBaseWnd)

var_0_0.__index = var_0_0

function createWorldBossAwardWnd()
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
		arg_3_0.worldBossSelfInfo = nil
		arg_3_0.rankAwards = {}
		arg_3_0.fightAwards = {}
	end

	local function var_3_1()
		local var_5_0 = CCBProxy:create()
		local var_5_1 = CCBReaderLoad("ccbi/world_boss_award.ccbi", var_5_0, true, "HelloCocosBuilderLayerOwner")
		local var_5_2 = tolua.cast(var_5_1:getChildByTag(1), "CCNode")

		arg_3_0.btnTouchTest = tolua.cast(var_5_1:getChildByTag(0), "CCControlButton")

		arg_3_0.btnTouchTest:addHandleOfControlEvent(function()
			arg_3_0:onTouchTest()
		end, CCControlEventTouchUpInside)

		arg_3_0.layer = var_5_2

		local var_5_3 = tolua.cast(var_5_2:getChildByTag(1), "CCNode")
		local var_5_4 = tolua.cast(var_5_2:getChildByTag(2), "CCNode")

		arg_3_0.nodeFightAward = tolua.cast(var_5_2:getChildByTag(3), "CCNode")
		arg_3_0.lbRank = tolua.cast(var_5_3:getChildByTag(1), "CCLabelTTF")
		arg_3_0.lbDamage = tolua.cast(var_5_3:getChildByTag(2), "CCLabelTTF")

		for iter_5_0 = 1, 5 do
			local var_5_5 = tolua.cast(var_5_4:getChildByTag(iter_5_0), "CCLayerColor")
			local var_5_6 = createItem()

			var_5_6:setPosition(var_5_5:getPosition())
			var_5_6:setScale(0.8)
			var_5_4:addChild(var_5_6)

			arg_3_0.rankAwards[iter_5_0] = var_5_6

			var_5_5:removeFromParentAndCleanup(true)
		end

		for iter_5_1 = 1, 5 do
			local var_5_7 = tolua.cast(arg_3_0.nodeFightAward:getChildByTag(iter_5_1), "CCLayerColor")
			local var_5_8 = createItem()

			var_5_8:setPosition(var_5_7:getPosition())
			var_5_8:setScale(0.8)
			arg_3_0.nodeFightAward:addChild(var_5_8)

			arg_3_0.fightAwards[iter_5_1] = var_5_8

			var_5_7:removeFromParentAndCleanup(true)
		end

		arg_3_0.btnAward = tolua.cast(var_5_2:getChildByTag(4), "CCControlButton")

		arg_3_0.btnAward:addHandleOfControlEvent(function()
			arg_3_0:onAward()
		end, CCControlEventTouchUpInside)
		arg_3_0:setWinType(EWinType.Pop_OnlyDark)
		arg_3_0:addChild(var_5_1)
	end

	var_3_0()
	var_3_1()
end

function var_0_0.refresh(arg_8_0)
	local var_8_0 = g_Self.kWorldHandler.worldBossSelfInfo

	if var_8_0.Rank then
		arg_8_0.lbRank:setString(var_8_0.Rank)
	else
		arg_8_0.lbRank:setString(a2u("δ\xC9ϰ\xF1"))
	end

	if var_8_0.HurtHp then
		arg_8_0.lbDamage:setString(var_8_0.HurtHp)
	else
		arg_8_0.lbDamage:setString(a2u("δ\xD4\xEC\xB3\xC9\xC9˺\xA6"))
	end

	local var_8_1 = zbWorldBossRankAwardTable:getRankAward(var_8_0.Rank)

	for iter_8_0, iter_8_1 in pairs(arg_8_0.rankAwards) do
		iter_8_1:setVisible(false)
	end

	local var_8_2 = 1

	for iter_8_2, iter_8_3 in pairs(var_8_1) do
		local var_8_3 = arg_8_0.rankAwards[var_8_2]

		if var_8_3 then
			var_8_3:refreshAward(iter_8_3.Type, iter_8_3.Id, iter_8_3.Count, false)
			var_8_3:setVisible(true)
		end

		var_8_2 = var_8_2 + 1
	end

	if var_8_0.AwardState == EWorldBossAwardState.DeadAndPartInAward then
		arg_8_0.nodeFightAward:setVisible(true)

		for iter_8_4, iter_8_5 in pairs(arg_8_0.fightAwards) do
			iter_8_5:setVisible(false)
		end

		local var_8_4 = 1

		for iter_8_6, iter_8_7 in pairs(g_DataConfig.m_kWorldBossCfg.awardList.killBossAward.award) do
			local var_8_5 = arg_8_0.fightAwards[var_8_4]

			if var_8_5 then
				var_8_5:refreshAward(iter_8_7[1], iter_8_7[2], iter_8_7[3], false)
				var_8_5:setVisible(true)
			end

			var_8_4 = var_8_4 + 1
		end
	else
		arg_8_0.nodeFightAward:setVisible(false)
	end
end

function var_0_0.onAward(arg_9_0)
	g_WsMsgHandler:WS_WorldBoss_GetAward_Req()
end

function var_0_0.onTouchTest(arg_10_0)
	local var_10_0 = arg_10_0.btnTouchTest:getTouch():getLocation()

	if zbUtil:PointInCtrl(arg_10_0.layer, var_10_0.x, var_10_0.y) == false then
		arg_10_0:hide()
	end
end
