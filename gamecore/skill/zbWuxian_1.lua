require("gamecore.skill.zbBaseSkill")

zbWuxian_1 = class("zbWuxian_1", zbBaseSkill)
zbWuxian_1.__index = zbWuxian_1

function zbWuxian_1.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbWuxian_1.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbWuxian_1.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Random_5
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.bombFrame1 = 0.6333333333333333
	arg_2_0.bombFrame2 = 1.3333333333333333
	arg_2_0.damageSectionCount = 4
	arg_2_0.hitFrame1 = 0.3
	arg_2_0.hitFrame2 = 0.6333333333333333
	arg_2_0.hitFrame3 = 0.9666666666666667
	arg_2_0.hitFrame4 = 1.3
	arg_2_0.hitDelayTime = 0.4
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.killTargeted = false
	arg_2_0.hero.wuxianSkill1 = arg_2_0
end

function zbWuxian_1.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:playAnimationOnce(arg_3_0.sequenceName, arg_3_0.hero:getIdleWeakSequence(), 0.125)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_1()
		g_DarkNode:hideDarkNode(arg_3_0.hero)
		g_CombatSystem:resumeExclude(arg_3_0.hero)
	end

	local function var_3_2()
		local var_6_0 = arg_3_0.targetList[1].forceType
		local var_6_1 = getCombatHeroPos(var_6_0, 5)

		g_EffectSystem:createBombEffect(arg_3_0.hero, var_6_0, var_6_1, arg_3_0.skillRecord.riseAttackEffectId, 0)
	end

	local function var_3_3()
		local var_7_0 = arg_3_0.targetList[1].forceType
		local var_7_1 = getCombatHeroPos(var_7_0, 5)

		g_EffectSystem:createBombEffect(arg_3_0.hero, var_7_0, var_7_1, arg_3_0.skillRecord.targetEffectId, 0)
	end

	local function var_3_4()
		g_CombatBubble:setNumOffsetRandomRangeX(25)

		for iter_8_0, iter_8_1 in pairs(arg_3_0.targetList) do
			iter_8_1:resume()

			local var_8_0, var_8_1, var_8_2 = g_CombatFormula:calcDamage(arg_3_0.hero, iter_8_1, arg_3_0)

			if var_8_1 > 0 then
				iter_8_1:playBehitAnimation(arg_3_0.skillRecord.hitEffectId, arg_3_0)
			end

			if arg_3_0.killTargeted == false and var_8_2 then
				arg_3_0.killTargeted = var_8_2
			end
		end

		g_CombatBubble:setNumOffsetRandomRangeX(0)
	end

	local function var_3_5()
		if arg_3_0.killTargeted and arg_3_0.hero.wuxianSkill3 ~= nil then
			arg_3_0.hero.wuxianSkill3:actionKillTarget()
		end

		arg_3_0:enterIdle()
	end

	local function var_3_6()
		arg_3_0.actioning = false
	end

	arg_3_0.killTargeted = false
	arg_3_0.actioning = true
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.getn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_7 = CCArray:create()

	arg_3_0:playBigSkillScreenAnim(var_3_7)
	var_3_7:addObject(CCCallFuncN:create(var_3_0))
	var_3_7:addObject(CCDelayTime:create(arg_3_0.bombFrame1))
	var_3_7:addObject(CCCallFuncN:create(var_3_2))
	var_3_7:addObject(CCDelayTime:create(arg_3_0.bombFrame2))
	var_3_7:addObject(CCCallFuncN:create(var_3_3))
	var_3_7:addObject(CCDelayTime:create(arg_3_0.hitFrame1))
	var_3_7:addObject(CCCallFuncN:create(var_3_4))
	var_3_7:addObject(CCDelayTime:create(arg_3_0.hitFrame2 - arg_3_0.hitFrame1))
	var_3_7:addObject(CCCallFuncN:create(var_3_4))
	var_3_7:addObject(CCDelayTime:create(arg_3_0.hitFrame3 - arg_3_0.hitFrame2))
	var_3_7:addObject(CCCallFuncN:create(var_3_4))
	var_3_7:addObject(CCDelayTime:create(arg_3_0.hitFrame4 - arg_3_0.hitFrame3))
	var_3_7:addObject(CCCallFuncN:create(var_3_4))
	var_3_7:addObject(CCCallFuncN:create(var_3_1))
	var_3_7:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.bombFrame1 - arg_3_0.bombFrame2 - arg_3_0.hitFrame4, 0.5)))
	var_3_7:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_3_0.hero:getFixPosition()))
	var_3_7:addObject(CCCallFuncN:create(var_3_5))
	var_3_7:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_7:addObject(CCCallFuncN:create(var_3_6))

	local var_3_8 = CCSequence:create(var_3_7)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_8)
end

function zbWuxian_1.getDamageRatio(arg_11_0, arg_11_1)
	return 1
end
