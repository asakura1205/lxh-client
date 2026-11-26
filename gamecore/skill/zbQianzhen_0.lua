require("gamecore.skill.zbBaseSkill")

zbQianzhen_0 = class("zbQianzhen_0", zbBaseSkill)
zbQianzhen_0.__index = zbQianzhen_0

function zbQianzhen_0.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbQianzhen_0.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbQianzhen_0.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Default
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.riseEffectId1 = arg_2_0.skillRecord.riseEffectId
	arg_2_0.riseEffectId2 = arg_2_0.skillRecord.riseEffectId
	arg_2_0.hitFrame1 = 0.5
	arg_2_0.hitFrame2 = 0.5
	arg_2_0.sequenceName1 = ANIMATION_SEQUENCE_PHYATTACK
	arg_2_0.sequenceName2 = ANIMATION_SEQUENCE_PHYATTACK
	arg_2_0.doubleBubbleName = a2u("\xC1\xACն")
	arg_2_0.addDamageValue = 0
end

function zbQianzhen_0.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName1, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.riseEffectId1)
	end

	local function var_3_1()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName2, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.riseEffectId2)
	end

	local function var_3_2()
		for iter_6_0, iter_6_1 in pairs(arg_3_0.targetList) do
			local var_6_0, var_6_1, var_6_2 = g_CombatFormula:calcDamage(arg_3_0.hero, iter_6_1, arg_3_0)

			if var_6_1 > 0 then
				iter_6_1:playBehitAnimation(arg_3_0.skillRecord.hitEffectId, arg_3_0)
			end
		end
	end

	local function var_3_3()
		for iter_7_0, iter_7_1 in pairs(arg_3_0.targetList) do
			local var_7_0, var_7_1, var_7_2 = g_CombatFormula:calcDamage(arg_3_0.hero, iter_7_1, arg_3_0)

			if var_7_1 > 0 then
				iter_7_1:playBehitAnimation(arg_3_0.skillRecord.hitEffectId, arg_3_0)
			end

			arg_3_0.addDamageValue = var_7_1
		end
	end

	local function var_3_4()
		if arg_3_0.doubleBubbleName ~= "" then
			arg_3_0.hero:popupStringBubble(arg_3_0.doubleBubbleName)
		end
	end

	local function var_3_5()
		arg_3_0:enterIdle()

		if arg_3_0.addDamageValue > 0 and arg_3_0.hero.qianzhenSkill3 ~= nil then
			arg_3_0.hero.qianzhenSkill3:actionEx(arg_3_0.addDamageValue)
		end
	end

	local function var_3_6()
		arg_3_0.actioning = false
	end

	arg_3_0.actioning = true
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.getn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_7 = arg_3_0.targetList[1]:getBeattackPosition(arg_3_0.hero, arg_3_0.skillSeqIndex)
	local var_3_8 = arg_3_0.hero.anim:getAnimDuration(arg_3_0.sequenceName1) + 0.3
	local var_3_9 = arg_3_0.hero.anim:getAnimDuration(arg_3_0.sequenceName2) + 0.3

	arg_3_0.hero:setMovingFlag(true)
	arg_3_0.hero:setDesPos(var_3_7.x, var_3_7.y)

	local var_3_10 = zbCombatFormula:isSucceedRate(arg_3_0.hero.doubleAttackRate * 1000)

	if arg_3_0.skillSeqIndex == 0 and arg_3_0:isQteRedoing() then
		var_3_10 = false
	end

	arg_3_0.addDamageValue = 0

	local var_3_11 = CCArray:create()

	if var_3_10 then
		var_3_11:addObject(CCMoveTo:create(FIGHT_CHARGE_TIME, var_3_7))
		var_3_11:addObject(CCCallFuncN:create(var_3_0))
		var_3_11:addObject(CCDelayTime:create(arg_3_0.hitFrame1))
		var_3_11:addObject(CCCallFuncN:create(var_3_2))
		var_3_11:addObject(CCDelayTime:create(math.max(math.min(var_3_8 - arg_3_0.hitFrame1, 0.25), 0.1)))
		var_3_11:addObject(CCCallFuncN:create(var_3_4))
		var_3_11:addObject(CCCallFuncN:create(var_3_1))
		var_3_11:addObject(CCDelayTime:create(arg_3_0.hitFrame2))
		var_3_11:addObject(CCCallFuncN:create(var_3_3))
		var_3_11:addObject(CCDelayTime:create(math.max(var_3_9 - arg_3_0.hitFrame2, 0.1)))
	else
		var_3_11:addObject(CCMoveTo:create(FIGHT_CHARGE_TIME, var_3_7))
		var_3_11:addObject(CCCallFuncN:create(var_3_0))
		var_3_11:addObject(CCDelayTime:create(arg_3_0.hitFrame1))
		var_3_11:addObject(CCCallFuncN:create(var_3_2))
		var_3_11:addObject(CCDelayTime:create(math.max(var_3_8 - arg_3_0.hitFrame1, 0.1)))
	end

	var_3_11:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_3_0.hero:getFixPosition()))
	var_3_11:addObject(CCCallFuncN:create(var_3_5))
	var_3_11:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))

	if var_3_10 then
		var_3_11:addObject(CCDelayTime:create(0.5))
	end

	var_3_11:addObject(CCCallFuncN:create(var_3_6))

	local var_3_12 = CCSequence:create(var_3_11)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_12)
end

function zbQianzhen_0.getDamageRatio(arg_11_0, arg_11_1)
	return 1
end
