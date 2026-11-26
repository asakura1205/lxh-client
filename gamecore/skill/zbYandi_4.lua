require("gamecore.skill.zbBaseNormalAttack")

zbYandi_4 = class("zbYandi_4", zbBaseSkill)
zbYandi_4.__index = zbYandi_4

function zbYandi_4.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbYandi_4.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbYandi_4.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Random_5
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.passiveTriggerType = EPassiveTriggerType.InitShow
	arg_2_0.hitFrame = 1.2333333333333334
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.hero.yandiSkill4 = arg_2_0
end

function zbYandi_4.action(arg_3_0)
	if zbCombatFormula:isSucceedRate(300) == false then
		return
	end

	local var_3_0 = BUFF_TYPE_MISC_YANDIYUN
	local var_3_1 = 0
	local var_3_2 = 0
	local var_3_3 = 2

	g_BuffSystem:createBuff(arg_3_0.hero, arg_3_0.hero, var_3_0, var_3_1, var_3_2, var_3_3)
end

function zbYandi_4.actionEx(arg_4_0)
	local function var_4_0()
		arg_4_0:popupSkillBubble()
		arg_4_0.hero.anim:playAnimationOnce(arg_4_0.sequenceName, arg_4_0.hero:getIdleWeakSequence(), 0.125)
		g_EffectSystem:createInstantEffect(arg_4_0.hero, arg_4_0.skillRecord.riseEffectId)
	end

	local function var_4_1()
		local var_6_0 = getCombatHeroPos(getFlipForceType(arg_4_0.hero.forceType), 5)
		local var_6_1 = ccp(var_6_0.x, var_6_0.y + 500)
		local var_6_2 = ccp(var_6_0.x, var_6_0.y)
		local var_6_3 = g_EffectSystem:createMissileEffectPos(arg_4_0.hero, arg_4_0, EPathType.Line, var_6_1, var_6_0, var_6_2, arg_4_0.skillRecord.flyEffectId, arg_4_0.skillRecord.targetEffectId)
	end

	local function var_4_2()
		arg_4_0:enterIdle()
	end

	local function var_4_3()
		return
	end

	if arg_4_0.hero.yandiYunEnable == false then
		return
	end

	arg_4_0.actioning = true
	arg_4_0.targetList = zbTargetHandler:selectTarget(arg_4_0.hero, arg_4_0, arg_4_0:getSideType(), arg_4_0:getTargetType(), arg_4_0:getSubTargetType())

	if table.getn(arg_4_0.targetList) == 0 then
		arg_4_0.actioning = false

		return
	end

	local var_4_4 = CCArray:create()

	var_4_4:addObject(CCCallFuncN:create(var_4_0))
	var_4_4:addObject(CCDelayTime:create(arg_4_0.hitFrame))
	var_4_4:addObject(CCCallFuncN:create(var_4_1))
	var_4_4:addObject(CCDelayTime:create(math.max(arg_4_0.skillDurationTime - arg_4_0.hitFrame, 0.1)))
	var_4_4:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_4_0.hero:getFixPosition()))
	var_4_4:addObject(CCCallFuncN:create(var_4_2))
	var_4_4:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_4_4:addObject(CCCallFuncN:create(var_4_3))

	local var_4_5 = CCSequence:create(var_4_4)

	arg_4_0.hero:stopAllActions()
	arg_4_0.hero:runAction(var_4_5)
end

function zbYandi_4.hitTarget(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.targetList) do
		local var_9_0, var_9_1, var_9_2 = g_CombatFormula:calcDamage(arg_9_0.hero, iter_9_1, arg_9_0)

		if var_9_1 > 0 then
			iter_9_1:playBehitAnimation(arg_9_0.skillRecord.hitEffectId, arg_9_0)
		end
	end
end

function zbYandi_4.hitEnd(arg_10_0)
	arg_10_0.actioning = false
	arg_10_0.hero.yandiSkill0.actioning = false
	arg_10_0.hero.yandiSkill2.actioning = false
end

function zbYandi_4.getDamageRatio(arg_11_0, arg_11_1)
	return 0.2
end
