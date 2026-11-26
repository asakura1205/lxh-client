require("gamecore.skill.zbBaseSkill")

zbLuoxiaoheiRX_1 = class("zbLuoxiaoheiRX_1", zbBaseSkill)
zbLuoxiaoheiRX_1.__index = zbLuoxiaoheiRX_1

function zbLuoxiaoheiRX_1.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbLuoxiaoheiRX_1.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbLuoxiaoheiRX_1.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Random_1
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.moveFrame1 = 0.9
	arg_2_0.groundFrame = 1.1333333333333333
	arg_2_0.hitFrame1 = 1.6333333333333333
	arg_2_0.moveFrame2 = 1.9
	arg_2_0.hitFrame2 = 2.1666666666666665
	arg_2_0.moveFrame3 = 2.5
	arg_2_0.hitFrame3 = 2.7666666666666666
	arg_2_0.moveFrame4 = 3.033333333333333
	arg_2_0.hitFrame4 = 3.3
	arg_2_0.moveFrame5 = 3.6
	arg_2_0.hitFrame5 = 4.333333333333333
	arg_2_0.curTarget = nil
	arg_2_0.attackEffects = {}
	arg_2_0.hitIndex = 0
end

function zbLuoxiaoheiRX_1.action(arg_3_0)
	local function var_3_0()
		local var_4_0 = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

		arg_3_0.curTarget = var_4_0[1]
	end

	local function var_3_1()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)

		for iter_5_0 = 1, 5 do
			arg_3_0.attackEffects[iter_5_0] = g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId + iter_5_0 - 1)

			arg_3_0.attackEffects[iter_5_0]:retain()
		end
	end

	local function var_3_2()
		g_DarkNode:hideDarkNode(arg_3_0.hero)
		g_CombatSystem:resumeExclude(arg_3_0.hero)
	end

	local function var_3_3()
		local var_7_0 = arg_3_0.curTarget

		if var_7_0 ~= nil then
			local var_7_1 = var_7_0:getBeattackPosition(arg_3_0.hero, arg_3_0.skillSeqIndex)

			arg_3_0.hero:setPosition(var_7_1)
			var_7_0:resume()

			local var_7_2, var_7_3, var_7_4 = g_CombatFormula:calcDamage(arg_3_0.hero, var_7_0, arg_3_0)

			if var_7_3 > 0 then
				var_7_0:playBehitAnimation(arg_3_0.skillRecord.hitEffectId, arg_3_0)
			end
		end
	end

	local function var_3_4()
		local var_8_0 = ccp(arg_3_0.hero:getPosition())
		local var_8_1 = arg_3_0.attackEffects[arg_3_0.hitIndex]

		if var_8_1 ~= nil then
			var_8_1:setPosition(var_8_0)
			var_8_1:release()
		end
	end

	local function var_3_5()
		var_3_0()

		if arg_3_0.curTarget ~= nil then
			local var_9_0 = arg_3_0.curTarget:getBeattackPosition(arg_3_0.hero, arg_3_0.skillSeqIndex)

			arg_3_0.hero:setPosition(var_9_0)
		end

		arg_3_0.hitIndex = arg_3_0.hitIndex + 1

		var_3_4()
	end

	local function var_3_6()
		arg_3_0:enterIdle()
	end

	local function var_3_7()
		arg_3_0.actioning = false
	end

	arg_3_0.actioning = true

	var_3_0()

	if arg_3_0.curTarget == nil then
		arg_3_0.actioning = false

		return
	end

	arg_3_0.skillDurationTime = arg_3_0.hero.anim:getAnimDuration(arg_3_0.sequenceName)
	arg_3_0.hitIndex = 1

	local var_3_8 = arg_3_0.curTarget:getBeattackPosition(arg_3_0.hero, arg_3_0.skillSeqIndex)

	arg_3_0.hero:setMovingFlag(true)

	local var_3_9 = 0
	local var_3_10 = CCArray:create()

	arg_3_0:playBigSkillScreenAnim(var_3_10)
	var_3_10:addObject(CCCallFuncN:create(var_3_1))
	var_3_10:addObject(CCDelayTime:create(arg_3_0.moveFrame1))
	var_3_10:addObject(CCMoveTo:create(arg_3_0.groundFrame - arg_3_0.moveFrame1, var_3_8))
	var_3_10:addObject(CCDelayTime:create(arg_3_0.hitFrame1 - arg_3_0.groundFrame))
	var_3_10:addObject(CCCallFuncN:create(var_3_4))
	var_3_10:addObject(CCCallFuncN:create(var_3_3))
	var_3_10:addObject(CCDelayTime:create(arg_3_0.moveFrame2 - arg_3_0.hitFrame1))
	var_3_10:addObject(CCCallFuncN:create(var_3_5))
	var_3_10:addObject(CCDelayTime:create(arg_3_0.hitFrame2 - arg_3_0.moveFrame2))
	var_3_10:addObject(CCCallFuncN:create(var_3_3))
	var_3_10:addObject(CCDelayTime:create(arg_3_0.moveFrame3 - arg_3_0.hitFrame2))
	var_3_10:addObject(CCCallFuncN:create(var_3_5))
	var_3_10:addObject(CCDelayTime:create(arg_3_0.hitFrame3 - arg_3_0.moveFrame3))
	var_3_10:addObject(CCCallFuncN:create(var_3_3))
	var_3_10:addObject(CCDelayTime:create(arg_3_0.moveFrame4 - arg_3_0.hitFrame3))
	var_3_10:addObject(CCCallFuncN:create(var_3_5))
	var_3_10:addObject(CCDelayTime:create(arg_3_0.hitFrame4 - arg_3_0.moveFrame4))
	var_3_10:addObject(CCCallFuncN:create(var_3_3))
	var_3_10:addObject(CCDelayTime:create(arg_3_0.moveFrame5 - arg_3_0.hitFrame4))
	var_3_10:addObject(CCCallFuncN:create(var_3_5))
	var_3_10:addObject(CCDelayTime:create(arg_3_0.hitFrame5 - arg_3_0.moveFrame5))
	var_3_10:addObject(CCCallFuncN:create(var_3_3))
	var_3_10:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame5, 0.1)))
	var_3_10:addObject(CCCallFuncN:create(var_3_2))
	var_3_10:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_3_0.hero:getFixPosition()))
	var_3_10:addObject(CCCallFuncN:create(var_3_6))
	var_3_10:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_10:addObject(CCCallFuncN:create(var_3_7))

	local var_3_11 = CCSequence:create(var_3_10)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_11)
end

function zbLuoxiaoheiRX_1.getDamageRatio(arg_12_0, arg_12_1)
	return 0.7
end
