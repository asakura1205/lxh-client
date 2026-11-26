require("gamecore.skill.zbBaseSkill")

zbQianzhen_1 = class("zbQianzhen_1", zbBaseSkill)
zbQianzhen_1.__index = zbQianzhen_1

function zbQianzhen_1.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbQianzhen_1.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbQianzhen_1.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Default
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.damageSectionCount = 4
	arg_2_0.juqiFrame = 0.8333333333333334
	arg_2_0.eventHitFrame1 = 1.1666666666666667
	arg_2_0.eventHitFrame2 = 1.4
	arg_2_0.eventHitFrame3 = 1.6
	arg_2_0.eventHitFrame4 = 2
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.cheatMpTarget = nil
end

function zbQianzhen_1.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_1()
		g_DarkNode:hideDarkNode(arg_3_0.hero)
		g_CombatSystem:resumeExclude(arg_3_0.hero)
	end

	local function var_3_2()
		g_CombatBubble:setNumOffsetRandomRangeX(25)

		for iter_6_0, iter_6_1 in pairs(arg_3_0.targetList) do
			iter_6_1:resume()

			local var_6_0, var_6_1, var_6_2 = g_CombatFormula:calcDamage(arg_3_0.hero, iter_6_1, arg_3_0)

			if var_6_1 > 0 then
				iter_6_1:playBehitAnimation(arg_3_0.skillRecord.hitEffectId, arg_3_0)

				arg_3_0.cheatMpTarget = iter_6_1
			end
		end

		g_CombatBubble:setNumOffsetRandomRangeX(0)
	end

	local function var_3_3()
		if arg_3_0.cheatMpTarget ~= nil then
			local var_7_0 = math.min(arg_3_0.cheatMpTarget.curMp, 10)

			arg_3_0.hero:addMp(var_7_0)
			g_CombatBubble:showBubble(arg_3_0.hero, ECombatBubble.MpUp, 0, 0, 1)

			if arg_3_0.cheatMpTarget:isDie() == false then
				arg_3_0.cheatMpTarget:addMp(-var_7_0)
				g_CombatBubble:showBubble(arg_3_0.cheatMpTarget, ECombatBubble.MpDown, 0, 0, 1)
			end
		end
	end

	local function var_3_4()
		arg_3_0:enterIdle()
	end

	local function var_3_5()
		arg_3_0.actioning = false
	end

	arg_3_0.cheatMpTarget = nil
	arg_3_0.actioning = true
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.getn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_6 = arg_3_0.targetList[1]:getBeattackPosition(arg_3_0.hero, arg_3_0.skillSeqIndex)

	arg_3_0.hero:setMovingFlag(true)
	arg_3_0.hero:setDesPos(var_3_6.x, var_3_6.y)

	local var_3_7 = CCArray:create()

	arg_3_0:playBigSkillScreenAnim(var_3_7)
	var_3_7:addObject(CCMoveTo:create(FIGHT_CHARGE_TIME, var_3_6))
	var_3_7:addObject(CCCallFuncN:create(var_3_0))
	var_3_7:addObject(CCDelayTime:create(arg_3_0.juqiFrame))

	local var_3_8 = arg_3_0.juqiFrame
	local var_3_9 = arg_3_0.eventHitFrame1 - var_3_8

	var_3_7:addObject(CCDelayTime:create(var_3_9))
	var_3_7:addObject(CCCallFuncN:create(var_3_2))

	local var_3_10 = var_3_8 + var_3_9
	local var_3_11 = arg_3_0.eventHitFrame2 - var_3_10

	var_3_7:addObject(CCDelayTime:create(var_3_11))
	var_3_7:addObject(CCCallFuncN:create(var_3_2))

	local var_3_12 = var_3_10 + var_3_11
	local var_3_13 = arg_3_0.eventHitFrame3 - var_3_12

	var_3_7:addObject(CCDelayTime:create(var_3_13))
	var_3_7:addObject(CCCallFuncN:create(var_3_2))

	local var_3_14 = var_3_12 + var_3_13
	local var_3_15 = arg_3_0.eventHitFrame4 - var_3_14

	var_3_7:addObject(CCDelayTime:create(var_3_15))
	var_3_7:addObject(CCCallFuncN:create(var_3_2))

	local var_3_16 = var_3_14 + var_3_15

	var_3_7:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - var_3_16, 0.1)))
	var_3_7:addObject(CCCallFuncN:create(var_3_1))
	var_3_7:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_3_0.hero:getFixPosition()))
	var_3_7:addObject(CCCallFuncN:create(var_3_3))
	var_3_7:addObject(CCCallFuncN:create(var_3_4))
	var_3_7:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_7:addObject(CCCallFuncN:create(var_3_5))

	local var_3_17 = CCSequence:create(var_3_7)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_17)
end

function zbQianzhen_1.getDamageRatio(arg_10_0, arg_10_1)
	return 2
end
