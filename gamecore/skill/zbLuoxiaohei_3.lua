require("gamecore.skill.zbBaseSkill")

zbLuoxiaohei_3 = class("zbLuoxiaohei_3", zbBaseSkill)
zbLuoxiaohei_3.__index = zbLuoxiaohei_3

function zbLuoxiaohei_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbLuoxiaohei_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbLuoxiaohei_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Default
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.passiveTriggerType = EPassiveTriggerType.LootAttack
	arg_2_0.hitFrame = 1.0666666666666667
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.lastRound = 0
	arg_2_0.lastLeftFightIndex = 0
	arg_2_0.lastRightFightIndex = 0
end

function zbLuoxiaohei_3.action(arg_3_0)
	local function var_3_0()
		arg_3_0.hero:setPosition(arg_3_0.hero.destPos)
	end

	local function var_3_1()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)

		local var_5_0 = g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)

		if var_5_0 ~= nil then
			var_5_0:setPosition(arg_3_0.hero.destPos)
		end
	end

	local function var_3_2()
		for iter_6_0, iter_6_1 in pairs(arg_3_0.targetList) do
			local var_6_0, var_6_1, var_6_2 = g_CombatFormula:calcDamage(arg_3_0.hero, iter_6_1, arg_3_0)

			if var_6_1 > 0 then
				iter_6_1:playBehitAnimation(arg_3_0.skillRecord.hitEffectId, arg_3_0)

				if arg_3_0.hero.lxhSkill4 ~= nil and zbCombatFormula:isSucceedRate(arg_3_0.hero.lxhSkill4Rate * 1000) then
					local var_6_3 = BUFF_TYPE_PROPERTY_DAMAMGE_DEFEND_PHYSICMAGIC
					local var_6_4 = -0.5
					local var_6_5 = -arg_3_0.hero.lxhSkill4:getDamageAbs()
					local var_6_6 = 2
					local var_6_7 = 0.5

					arg_3_0.hero.lxhSkill4:popupSkillBubble(var_6_7)
					g_BuffSystem:createBuff(arg_3_0.hero, iter_6_1, var_6_3, var_6_4, var_6_5, var_6_6, var_6_7)
				end
			end
		end
	end

	local function var_3_3()
		arg_3_0:enterIdle()
	end

	local function var_3_4()
		arg_3_0.actioning = false
	end

	arg_3_0.lastRound = g_CombatRound.sequenceRound.curRound
	arg_3_0.lastLeftFightIndex = g_CombatRound.sequenceRound.curSelfFightIndex
	arg_3_0.lastRightFightIndex = g_CombatRound.sequenceRound.curEnemyFightIndex
	arg_3_0.actioning = true

	local var_3_5 = g_CombatRound.sequenceRound:guessNextAttackHero(getFlipForceType(arg_3_0.hero.forceType))

	if var_3_5 ~= nil then
		arg_3_0.targetList = {}

		table.insert(arg_3_0.targetList, var_3_5)
	else
		arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

		echo("warning: can not guess next attackhero.")
	end

	if table.getn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_6 = arg_3_0.targetList[1]:getBeattackPosition(arg_3_0.hero, arg_3_0.skillSeqIndex)

	arg_3_0.hero:setMovingFlag(true)
	arg_3_0.hero:setDesPos(var_3_6.x, var_3_6.y)

	local var_3_7 = CCArray:create()

	var_3_7:addObject(CCCallFuncN:create(var_3_1))
	var_3_7:addObject(CCDelayTime:create(0.43333333333333335))
	var_3_7:addObject(CCCallFuncN:create(var_3_0))
	var_3_7:addObject(CCDelayTime:create(arg_3_0.hitFrame - 0.43333333333333335))
	var_3_7:addObject(CCCallFuncN:create(var_3_2))
	var_3_7:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame, 0.1)))
	var_3_7:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_3_0.hero:getFixPosition()))
	var_3_7:addObject(CCCallFuncN:create(var_3_3))
	var_3_7:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_7:addObject(CCCallFuncN:create(var_3_4))

	local var_3_8 = CCSequence:create(var_3_7)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_8)
end

function zbLuoxiaohei_3.checkTriggerRate(arg_9_0)
	if arg_9_0.lastRound == g_CombatRound.sequenceRound.curRound then
		if arg_9_0.hero.forceType == ForceType.Left and arg_9_0.lastRightFightIndex == g_CombatRound.sequenceRound.curEnemyFightIndex then
			return false
		end

		if arg_9_0.hero.forceType == ForceType.Right and arg_9_0.lastLeftFightIndex == g_CombatRound.sequenceRound.curSelfFightIndex then
			return false
		end
	end

	return zbCombatFormula:isSucceedRate(300)
end

function zbLuoxiaohei_3.getDamageRatio(arg_10_0, arg_10_1)
	return 0.7
end
