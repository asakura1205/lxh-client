require("gamecore.skill.zbBaseSkill")

zbQianzhen_2 = class("zbQianzhen_2", zbBaseSkill)
zbQianzhen_2.__index = zbQianzhen_2

function zbQianzhen_2.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbQianzhen_2.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbQianzhen_2.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Default
	arg_2_0.subTargetType = ESubTargetType.Row
	arg_2_0.riseEffectId1 = arg_2_0.skillRecord.riseEffectId
	arg_2_0.riseEffectId2 = 1043001
	arg_2_0.hitFrame1 = 0.7333333333333333
	arg_2_0.hitFrame2 = 0.5
	arg_2_0.sequenceName1 = ANIMATION_SEQUENCE_SKILL2
	arg_2_0.sequenceName2 = ANIMATION_SEQUENCE_PHYATTACK
	arg_2_0.doubleBubbleName = a2u("\xC1\xACն")
	arg_2_0.addDamageValue = 0
	arg_2_0.damageStepIndex = 1
end

function zbQianzhen_2.getDamageRatio(arg_3_0, arg_3_1)
	if arg_3_0.damageStepIndex == 1 then
		return 0.75
	else
		return 1
	end
end

function zbQianzhen_2.action(arg_4_0)
	local function var_4_0()
		arg_4_0:popupSkillBubble()
		arg_4_0.hero.anim:setAnimation(arg_4_0.sequenceName1, false)
		g_EffectSystem:createInstantEffect(arg_4_0.hero, arg_4_0.riseEffectId1)
	end

	local function var_4_1()
		arg_4_0.hero.anim:setAnimation(arg_4_0.sequenceName2, false)
		g_EffectSystem:createInstantEffect(arg_4_0.hero, arg_4_0.riseEffectId2)
	end

	local function var_4_2()
		arg_4_0.damageStepIndex = 1

		for iter_7_0, iter_7_1 in pairs(arg_4_0.targetList) do
			local var_7_0, var_7_1, var_7_2 = g_CombatFormula:calcDamage(arg_4_0.hero, iter_7_1, arg_4_0)

			if var_7_1 > 0 then
				iter_7_1:playBehitAnimation(arg_4_0.skillRecord.hitEffectId, arg_4_0)
			end
		end
	end

	local function var_4_3()
		arg_4_0.damageStepIndex = 2

		for iter_8_0, iter_8_1 in pairs(arg_4_0.targetList) do
			local var_8_0, var_8_1, var_8_2 = g_CombatFormula:calcDamage(arg_4_0.hero, iter_8_1, arg_4_0)

			if var_8_1 > 0 then
				iter_8_1:playBehitAnimation(arg_4_0.skillRecord.hitEffectId, arg_4_0)
			end

			arg_4_0.addDamageValue = var_8_1

			break
		end
	end

	local function var_4_4()
		if arg_4_0.doubleBubbleName ~= "" then
			arg_4_0.hero:popupStringBubble(arg_4_0.doubleBubbleName)
		end
	end

	local function var_4_5()
		arg_4_0:enterIdle()

		if arg_4_0.addDamageValue > 0 and arg_4_0.hero.qianzhenSkill3 ~= nil then
			arg_4_0.hero.qianzhenSkill3:actionEx(arg_4_0.addDamageValue)
		end
	end

	local function var_4_6()
		arg_4_0.actioning = false
	end

	arg_4_0.actioning = true
	arg_4_0.targetList = zbTargetHandler:selectTarget(arg_4_0.hero, arg_4_0, arg_4_0:getSideType(), arg_4_0:getTargetType(), arg_4_0:getSubTargetType())

	if table.getn(arg_4_0.targetList) == 0 then
		arg_4_0.actioning = false

		return
	end

	local var_4_7 = arg_4_0.targetList[1]:getBeattackPosition(arg_4_0.hero, arg_4_0.skillSeqIndex)
	local var_4_8 = arg_4_0.hero.anim:getAnimDuration(arg_4_0.sequenceName1) + 0.3
	local var_4_9 = arg_4_0.hero.anim:getAnimDuration(arg_4_0.sequenceName2) + 0.3

	arg_4_0.hero:setMovingFlag(true)
	arg_4_0.hero:setDesPos(var_4_7.x, var_4_7.y)

	local var_4_10 = zbCombatFormula:isSucceedRate(arg_4_0.hero.doubleAttackRate * 1000)

	if arg_4_0.skillSeqIndex == 0 then
		var_4_10 = false
	end

	arg_4_0.addDamageValue = 0

	local var_4_11 = CCArray:create()

	if var_4_10 then
		var_4_11:addObject(CCMoveTo:create(FIGHT_CHARGE_TIME, var_4_7))
		var_4_11:addObject(CCCallFuncN:create(var_4_0))
		var_4_11:addObject(CCDelayTime:create(arg_4_0.hitFrame1))
		var_4_11:addObject(CCCallFuncN:create(var_4_2))
		var_4_11:addObject(CCDelayTime:create(math.max(math.min(var_4_8 - arg_4_0.hitFrame1, 0.25), 0.1)))
		var_4_11:addObject(CCCallFuncN:create(var_4_4))
		var_4_11:addObject(CCCallFuncN:create(var_4_1))
		var_4_11:addObject(CCDelayTime:create(arg_4_0.hitFrame2))
		var_4_11:addObject(CCCallFuncN:create(var_4_3))
		var_4_11:addObject(CCDelayTime:create(math.max(var_4_9 - arg_4_0.hitFrame2, 0.1)))
	else
		var_4_11:addObject(CCMoveTo:create(FIGHT_CHARGE_TIME, var_4_7))
		var_4_11:addObject(CCCallFuncN:create(var_4_0))
		var_4_11:addObject(CCDelayTime:create(arg_4_0.hitFrame1))
		var_4_11:addObject(CCCallFuncN:create(var_4_2))
		var_4_11:addObject(CCDelayTime:create(math.max(var_4_8 - arg_4_0.hitFrame1, 0.1)))
	end

	var_4_11:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_4_0.hero:getFixPosition()))
	var_4_11:addObject(CCCallFuncN:create(var_4_5))
	var_4_11:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))

	if var_4_10 then
		var_4_11:addObject(CCDelayTime:create(0.5))
	end

	var_4_11:addObject(CCCallFuncN:create(var_4_6))

	local var_4_12 = CCSequence:create(var_4_11)

	arg_4_0.hero:stopAllActions()
	arg_4_0.hero:runAction(var_4_12)
end
