require("gamecore.skill.zbBaseSkill")

zbShanxin_1 = class("zbShanxin_1", zbBaseSkill)
zbShanxin_1.__index = zbShanxin_1

function zbShanxin_1.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbShanxin_1.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbShanxin_1.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Random_5
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.targetFrame = 1.6666666666666667
	arg_2_0.hitFrame = 2.8333333333333335
end

function zbShanxin_1.action(arg_3_0)
	local function var_3_0()
		arg_3_0.hero.anim:playAnimationOnce(arg_3_0.sequenceName, arg_3_0.hero:getIdleWeakSequence(), 0.125)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseAttackEffectId)
	end

	local function var_3_1()
		g_DarkNode:hideDarkNode(arg_3_0.hero)
		g_CombatSystem:resumeExclude(arg_3_0.hero)
	end

	local function var_3_2()
		local var_6_0 = arg_3_0.targetList[1].forceType
		local var_6_1 = getCombatHeroPos(var_6_0, 2)
		local var_6_2 = g_EffectSystem:createBombEffect(arg_3_0.hero, var_6_0, var_6_1, arg_3_0.skillRecord.targetEffectId, 0)

		if var_6_2 ~= nil then
			if var_6_0 == ForceType.Left then
				var_6_2:setRotationY(0)
			else
				var_6_2:setRotationY(180)
			end
		end
	end

	local function var_3_3()
		for iter_7_0, iter_7_1 in pairs(arg_3_0.targetList) do
			iter_7_1:resume()

			local var_7_0, var_7_1, var_7_2 = g_CombatFormula:calcDamage(arg_3_0.hero, iter_7_1, arg_3_0)

			if var_7_1 > 0 then
				iter_7_1:playBehitAnimation(arg_3_0.skillRecord.hitEffectId, arg_3_0)
			end
		end
	end

	local function var_3_4()
		arg_3_0:enterIdle()
	end

	local function var_3_5()
		arg_3_0.actioning = false
	end

	arg_3_0.actioning = true
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.getn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	arg_3_0.skillDurationTime = arg_3_0.hero.anim:getAnimDuration(arg_3_0.sequenceName)

	local var_3_6 = CCArray:create()

	arg_3_0:playBigSkillScreenAnim(var_3_6)
	var_3_6:addObject(CCCallFuncN:create(var_3_0))
	var_3_6:addObject(CCDelayTime:create(arg_3_0.targetFrame))
	var_3_6:addObject(CCCallFuncN:create(var_3_2))
	var_3_6:addObject(CCDelayTime:create(arg_3_0.hitFrame - arg_3_0.targetFrame))
	var_3_6:addObject(CCCallFuncN:create(var_3_3))
	var_3_6:addObject(CCDelayTime:create(math.max(1.8333333333333333 - arg_3_0.hitFrame, 0.1)))
	var_3_6:addObject(CCCallFuncN:create(var_3_1))
	var_3_6:addObject(CCCallFuncN:create(var_3_4))
	var_3_6:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_6:addObject(CCCallFuncN:create(var_3_5))

	local var_3_7 = CCSequence:create(var_3_6)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_7)
	arg_3_0:popupSkillBubble()
end

function zbShanxin_1.getDamageRatio(arg_10_0, arg_10_1)
	return 0.7
end
