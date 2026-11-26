require("gamecore.skill.zbBaseSkill")

zbHeixiu2_1 = class("zbHeixiu2_1", zbBaseSkill)
zbHeixiu2_1.__index = zbHeixiu2_1

function zbHeixiu2_1.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbHeixiu2_1.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbHeixiu2_1.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Default
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.damageSectionCount = 5
	arg_2_0.hitFrame1 = 1.6666666666666667
	arg_2_0.hitFrame2 = 1.9333333333333333
	arg_2_0.hitFrame3 = 2.1
	arg_2_0.hitFrame4 = 2.3666666666666667
	arg_2_0.hitFrame5 = 2.466666666666667
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbHeixiu2_1.action(arg_3_0)
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
		g_Audio:playSound("audio/sound/attack_dao.mp3")
		g_CombatBubble:setNumOffsetRandomRangeX(25)

		for iter_6_0, iter_6_1 in pairs(arg_3_0.targetList) do
			iter_6_1:resume()

			local var_6_0, var_6_1, var_6_2 = g_CombatFormula:calcDamage(arg_3_0.hero, iter_6_1, arg_3_0)

			if var_6_1 > 0 then
				iter_6_1:playBehitAnimation(arg_3_0.skillRecord.hitEffectId, arg_3_0)
			end
		end

		g_CombatBubble:setNumOffsetRandomRangeX(0)
	end

	local function var_3_3()
		arg_3_0:enterIdle()
	end

	local function var_3_4()
		arg_3_0.actioning = false
	end

	arg_3_0.actioning = true
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())
	arg_3_0.target = arg_3_0.targetList[1]

	if arg_3_0.target == nil then
		arg_3_0.actioning = false

		return
	end

	local var_3_5 = arg_3_0.targetList[1]:getBeattackPosition(arg_3_0.hero, arg_3_0.skillSeqIndex)

	arg_3_0.hero:setMovingFlag(true)
	arg_3_0.hero:setDesPos(var_3_5.x, var_3_5.y)

	local var_3_6 = CCArray:create()

	arg_3_0:playBigSkillScreenAnim(var_3_6)
	var_3_6:addObject(CCMoveTo:create(FIGHT_CHARGE_TIME, var_3_5))
	var_3_6:addObject(CCCallFuncN:create(var_3_0))
	var_3_6:addObject(CCDelayTime:create(arg_3_0.hitFrame1))
	var_3_6:addObject(CCCallFuncN:create(var_3_2))
	var_3_6:addObject(CCDelayTime:create(arg_3_0.hitFrame2 - arg_3_0.hitFrame1))
	var_3_6:addObject(CCCallFuncN:create(var_3_2))
	var_3_6:addObject(CCDelayTime:create(arg_3_0.hitFrame3 - arg_3_0.hitFrame2))
	var_3_6:addObject(CCCallFuncN:create(var_3_2))
	var_3_6:addObject(CCDelayTime:create(arg_3_0.hitFrame4 - arg_3_0.hitFrame3))
	var_3_6:addObject(CCCallFuncN:create(var_3_2))
	var_3_6:addObject(CCDelayTime:create(arg_3_0.hitFrame5 - arg_3_0.hitFrame4))
	var_3_6:addObject(CCCallFuncN:create(var_3_2))
	var_3_6:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame5, 0.1)))
	var_3_6:addObject(CCCallFuncN:create(var_3_1))
	var_3_6:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_3_0.hero:getFixPosition()))
	var_3_6:addObject(CCCallFuncN:create(var_3_3))
	var_3_6:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_6:addObject(CCCallFuncN:create(var_3_4))

	local var_3_7 = CCSequence:create(var_3_6)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_7)
end

function zbHeixiu2_1.getDamageRatio(arg_9_0, arg_9_1)
	return 3
end
