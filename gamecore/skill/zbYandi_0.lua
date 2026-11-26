require("gamecore.skill.zbBaseNormalAttack")

zbYandi_0 = class("zbYandi_0", zbBaseSkill)
zbYandi_0.__index = zbYandi_0

function zbYandi_0.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbYandi_0.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbYandi_0.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Default
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 0.7
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.hitDelayTime = 0.6
	arg_2_0.hero.yandiSkill0 = arg_2_0
end

function zbYandi_0.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:playAnimationOnce(arg_3_0.sequenceName, arg_3_0.hero:getIdleWeakSequence(), 0.125)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_1()
		local var_5_0 = ccp(arg_3_0.hero:getPosition())
		local var_5_1 = ccp(var_5_0.x, var_5_0.y + 600)

		g_EffectSystem:createMissileEffectPos2(arg_3_0.hero, arg_3_0, EPathType.Line, var_5_0, var_5_1, arg_3_0.skillRecord.flyEffectId)
	end

	local function var_3_2()
		local var_6_0 = ccp(arg_3_0.targetList[1]:getPositionX(), arg_3_0.targetList[1]:getPositionY() + 500)
		local var_6_1 = ccp(arg_3_0.targetList[1]:getPositionX(), arg_3_0.targetList[1]:getPositionY())
		local var_6_2 = ccp(var_6_1.x, var_6_1.y)
		local var_6_3 = g_EffectSystem:createMissileEffectPos(arg_3_0.hero, arg_3_0, EPathType.Line, var_6_0, var_6_1, var_6_2, arg_3_0.skillRecord.flyEffectId, arg_3_0.skillRecord.targetEffectId)

		if var_6_3 ~= nil then
			var_6_3:setRotationX(180)
		end
	end

	local function var_3_3()
		arg_3_0:enterIdle()
	end

	local function var_3_4()
		return
	end

	arg_3_0.actioning = true
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.getn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_5 = CCArray:create()

	var_3_5:addObject(CCCallFuncN:create(var_3_0))
	var_3_5:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	var_3_5:addObject(CCCallFuncN:create(var_3_1))
	var_3_5:addObject(CCDelayTime:create(arg_3_0.hitDelayTime))
	var_3_5:addObject(CCCallFuncN:create(var_3_2))
	var_3_5:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame - arg_3_0.hitDelayTime, 0.1)))
	var_3_5:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_3_0.hero:getFixPosition()))
	var_3_5:addObject(CCCallFuncN:create(var_3_3))
	var_3_5:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_5:addObject(CCCallFuncN:create(var_3_4))

	local var_3_6 = CCSequence:create(var_3_5)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_6)
end

function zbYandi_0.hitTarget(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.targetList) do
		local var_9_0, var_9_1, var_9_2 = g_CombatFormula:calcDamage(arg_9_0.hero, iter_9_1, arg_9_0)

		if var_9_1 > 0 then
			iter_9_1:playBehitAnimation(arg_9_0.skillRecord.hitEffectId, arg_9_0)

			if zbCombatFormula:isSucceedRate(300) then
				g_BuffSystem:createControlBuff(arg_9_0.hero, iter_9_1, BUFF_TYPE_CONTROL_CHENMO)
			end
		end
	end
end

function zbYandi_0.hitEnd(arg_10_0)
	if arg_10_0:isQteRedoing() == false and arg_10_0.hero.yandiSkill4 ~= nil and arg_10_0.hero.yandiYunEnable then
		arg_10_0.hero.yandiSkill4:actionEx()
	else
		arg_10_0.actioning = false
	end
end

function zbYandi_0.getDamageRatio(arg_11_0, arg_11_1)
	return 0.8
end
