require("gamecore.skill.zbBaseSkill")

zbLuoxiaohei_niuzai_4 = class("zbLuoxiaohei_niuzai_4", zbBaseSkill)
zbLuoxiaohei_niuzai_4.__index = zbLuoxiaohei_niuzai_4

function zbLuoxiaohei_niuzai_4.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbLuoxiaohei_niuzai_4.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbLuoxiaohei_niuzai_4.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Default
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.passiveTriggerType = EPassiveTriggerType.LootAttack
	arg_2_0.hitFrame = 0.6333333333333333
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.accumTime = 0
	arg_2_0.totalCount = 0
	arg_2_0.curCount = 0
	arg_2_0.lastRound = 0
	arg_2_0.lastLeftFightIndex = 0
	arg_2_0.lastRightFightIndex = 0
end

function zbLuoxiaohei_niuzai_4.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_1()
		for iter_5_0, iter_5_1 in pairs(arg_3_0.targetList) do
			g_EffectSystem:createMissileEffect(arg_3_0.hero, iter_5_1, arg_3_0)
		end
	end

	local function var_3_2()
		arg_3_0:enterIdle()
	end

	local function var_3_3()
		return
	end

	arg_3_0.actioning = true
	arg_3_0.accumTime = 0
	arg_3_0.totalCount = 1
	arg_3_0.lastRound = g_CombatRound.sequenceRound.curRound
	arg_3_0.lastLeftFightIndex = g_CombatRound.sequenceRound.curSelfFightIndex
	arg_3_0.lastRightFightIndex = g_CombatRound.sequenceRound.curEnemyFightIndex
	arg_3_0.actioning = true

	local var_3_4 = g_CombatRound.sequenceRound:guessNextAttackHero(getFlipForceType(arg_3_0.hero.forceType))

	if var_3_4 ~= nil then
		arg_3_0.targetList = {}

		table.insert(arg_3_0.targetList, var_3_4)
	else
		arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

		echo("warning: can not guess next attackhero.")
	end

	if table.getn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_5 = CCArray:create()

	var_3_5:addObject(CCCallFuncN:create(var_3_0))
	var_3_5:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	var_3_5:addObject(CCCallFuncN:create(var_3_1))
	var_3_5:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame, 0.1)))
	var_3_5:addObject(CCCallFuncN:create(var_3_2))
	var_3_5:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_5:addObject(CCCallFuncN:create(var_3_3))

	local var_3_6 = CCSequence:create(var_3_5)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_6)
end

function zbLuoxiaohei_niuzai_4.update(arg_8_0, arg_8_1)
	arg_8_0.accumTime = arg_8_0.accumTime + arg_8_1

	if arg_8_0.accumTime > 3 then
		arg_8_0.actioning = false
	end
end

function zbLuoxiaohei_niuzai_4.hited(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0.actioning = false
end

function zbLuoxiaohei_niuzai_4.checkTriggerRate(arg_10_0)
	if arg_10_0.lastRound == g_CombatRound.sequenceRound.curRound then
		if arg_10_0.hero.forceType == ForceType.Left and arg_10_0.lastRightFightIndex == g_CombatRound.sequenceRound.curEnemyFightIndex then
			return false
		end

		if arg_10_0.hero.forceType == ForceType.Right and arg_10_0.lastLeftFightIndex == g_CombatRound.sequenceRound.curSelfFightIndex then
			return false
		end
	end

	return zbCombatFormula:isSucceedRate(200 + 0.05 * arg_10_0.hero.energy:getCount())
end

function zbLuoxiaohei_niuzai_4.getDamageRatio(arg_11_0, arg_11_1)
	return 0.2
end
