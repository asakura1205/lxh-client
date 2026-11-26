require("gamecore.skill.zbBaseSkill")

zbKali_2 = class("zbKali_2", zbBaseSkill)
zbKali_2.__index = zbKali_2

function zbKali_2.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbKali_2.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbKali_2.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Condition_MinHpPercent
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.targetFrame = 0.43333333333333335
	arg_2_0.hitFrame = 0.5
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.killTargeted = false
	arg_2_0.cureValue = 0
end

function zbKali_2.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:playAnimationOnce(arg_3_0.sequenceName, arg_3_0.hero:getIdleWeakSequence(), 0.125)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseAttackEffectId)
	end

	local function var_3_1()
		for iter_5_0, iter_5_1 in pairs(arg_3_0.targetList) do
			g_EffectSystem:createInstantEffect(iter_5_1, arg_3_0.skillRecord.targetEffectId)
		end
	end

	local function var_3_2()
		for iter_6_0, iter_6_1 in pairs(arg_3_0.targetList) do
			local var_6_0, var_6_1, var_6_2 = g_CombatFormula:calcDamage(arg_3_0.hero, iter_6_1, arg_3_0)

			if var_6_1 > 0 then
				iter_6_1:playBehitAnimation(arg_3_0.skillRecord.hitEffectId, arg_3_0)

				if var_6_2 then
					arg_3_0.killTargeted = true
					arg_3_0.cureValue = var_6_1 * 0.5
				end
			end
		end
	end

	local function var_3_3()
		arg_3_0:enterIdle()

		if arg_3_0.killTargeted then
			local var_7_0 = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, ESideType.Self, ETargetType.Condition_MinHpPercent, ESubTargetType.All)

			for iter_7_0, iter_7_1 in pairs(var_7_0) do
				iter_7_1:addHp(arg_3_0.cureValue, false, 1)
				g_EffectSystem:createInstantEffect(iter_7_1, 2001)
				g_EffectSystem:createInstantEffect(iter_7_1, 2002)
			end
		end
	end

	local function var_3_4()
		arg_3_0.actioning = false
	end

	arg_3_0.killTargeted = false
	arg_3_0.actioning = true
	arg_3_0.cureValue = 0
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.getn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_5 = CCArray:create()

	if arg_3_0.hero.kaliSkill4 ~= nil then
		arg_3_0.hero.kaliSkill4:actionEx(var_3_5)
	end

	var_3_5:addObject(CCCallFuncN:create(var_3_0))
	var_3_5:addObject(CCDelayTime:create(arg_3_0.targetFrame))
	var_3_5:addObject(CCCallFuncN:create(var_3_1))
	var_3_5:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	var_3_5:addObject(CCCallFuncN:create(var_3_2))
	var_3_5:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame - arg_3_0.targetFrame, 0.1)))
	var_3_5:addObject(CCCallFuncN:create(var_3_3))
	var_3_5:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_5:addObject(CCCallFuncN:create(var_3_4))

	local var_3_6 = CCSequence:create(var_3_5)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_6)
end

function zbKali_2.getDamageRatio(arg_9_0, arg_9_1)
	return 1.5
end
