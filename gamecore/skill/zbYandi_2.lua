require("gamecore.skill.zbBaseNormalAttack")

zbYandi_2 = class("zbYandi_2", zbBaseSkill)
zbYandi_2.__index = zbYandi_2

function zbYandi_2.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbYandi_2.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbYandi_2.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Default
	arg_2_0.subTargetType = ESubTargetType.Row
	arg_2_0.targetFrame = 1.4666666666666666
	arg_2_0.hitFrame = 0.23333333333333334
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.targetEffect = nil
	arg_2_0.hero.yandiSkill2 = arg_2_0
end

function zbYandi_2.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:playAnimationOnce(arg_3_0.sequenceName, arg_3_0.hero:getIdleWeakSequence(), 0.125)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)

		arg_3_0.targetEffect = g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.targetEffectId)

		if arg_3_0.targetEffect ~= nil then
			arg_3_0.targetEffect:setVisible(false)
		end
	end

	local function var_3_1()
		if arg_3_0.targetEffect ~= nil then
			arg_3_0.targetEffect:setVisible(true)
		end
	end

	local function var_3_2()
		for iter_6_0, iter_6_1 in pairs(arg_3_0.targetList) do
			local var_6_0, var_6_1, var_6_2 = g_CombatFormula:calcDamage(arg_3_0.hero, iter_6_1, arg_3_0)

			if var_6_1 > 0 then
				iter_6_1:playBehitAnimation(0, arg_3_0)
				iter_6_1:addMp(-10)
				g_CombatBubble:showBubble(iter_6_1, ECombatBubble.MpDown, 0, 0, 1)
			end
		end
	end

	local function var_3_3()
		arg_3_0:enterIdle()
	end

	local function var_3_4()
		if arg_3_0:isQteRedoing() == false and arg_3_0.hero.yandiSkill4 ~= nil and arg_3_0.hero.yandiYunEnable then
			arg_3_0.hero.yandiSkill4:actionEx()
		else
			arg_3_0.actioning = false
		end
	end

	arg_3_0.targetEffect = nil
	arg_3_0.actioning = true
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.getn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_5 = getFormationRowFrontPos(arg_3_0.hero.forceType, arg_3_0.targetList[1]:getFormationIndex())

	if arg_3_0.hero.forceType == ForceType.Left then
		var_3_5.x = var_3_5.x - 130
	else
		var_3_5.x = var_3_5.x + 130
	end

	local var_3_6 = CCArray:create()

	var_3_6:addObject(CCMoveTo:create(FIGHT_CHARGE_TIME, var_3_5))
	var_3_6:addObject(CCCallFuncN:create(var_3_0))
	var_3_6:addObject(CCDelayTime:create(arg_3_0.targetFrame))
	var_3_6:addObject(CCCallFuncN:create(var_3_1))
	var_3_6:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	var_3_6:addObject(CCCallFuncN:create(var_3_2))
	var_3_6:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame - arg_3_0.targetFrame, 0.1)))
	var_3_6:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_3_0.hero:getFixPosition()))
	var_3_6:addObject(CCCallFuncN:create(var_3_3))
	var_3_6:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME + 0.5))
	var_3_6:addObject(CCCallFuncN:create(var_3_4))

	local var_3_7 = CCSequence:create(var_3_6)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_7)
end

function zbYandi_2.getDamageRatio(arg_9_0, arg_9_1)
	return 0.7
end
