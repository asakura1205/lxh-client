require("gamecore.skill.zbBaseSkill")

zbYingquan_1 = class("zbYingquan_1", zbBaseSkill)
zbYingquan_1.__index = zbYingquan_1

function zbYingquan_1.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbYingquan_1.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbYingquan_1.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Default
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.damageSectionCount = 5
	arg_2_0.hitFrame1 = 1.7
	arg_2_0.hitFrame2 = 2.2333333333333334
	arg_2_0.hitFrame3 = 3.1333333333333333
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.killTarget = false
end

function zbYingquan_1.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_1()
		g_DarkNode:hideDarkNode(arg_3_0.hero)
		g_CombatSystem:resumeExclude(arg_3_0.hero)
	end

	local function var_3_2()
		local var_6_0 = arg_3_0.hero.yingquanSkill4 ~= nil and zbCombatFormula:isSucceedRate(300)

		if var_6_0 then
			arg_3_0.hero.yingquanSkill4:popupSkillBubble()
			arg_3_0.hero:addExtraPhysicDamageRatio(arg_3_0.hero.yingquanSkill4:getDamageRatio())
			arg_3_0.hero:addExtraPhysicDamageAbs(arg_3_0.hero.yingquanSkill4:getDamageAbs())
		end

		for iter_6_0, iter_6_1 in pairs(arg_3_0.targetList) do
			iter_6_1:resume()

			local var_6_1, var_6_2, var_6_3 = g_CombatFormula:calcDamage(arg_3_0.hero, iter_6_1, arg_3_0)

			if var_6_2 > 0 then
				iter_6_1:playBehitAnimation(arg_3_0.skillRecord.hitEffectId, arg_3_0)

				if arg_3_0.killTarget == false then
					arg_3_0.killTarget = var_6_3
				end
			end
		end

		if var_6_0 then
			arg_3_0.hero:addExtraPhysicDamageRatio(-arg_3_0.hero.yingquanSkill4:getDamageRatio())
			arg_3_0.hero:addExtraPhysicDamageAbs(-arg_3_0.hero.yingquanSkill4:getDamageAbs())
		end
	end

	local function var_3_3()
		if arg_3_0.killTarget and arg_3_0.hero.yingquanSkill3 ~= nil then
			arg_3_0.hero.yingquanSkill3:actionKillTarget(arg_3_0)
		end

		arg_3_0:enterIdle()
	end

	local function var_3_4()
		arg_3_0.actioning = false
	end

	arg_3_0.actioning = true
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.getn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_5 = arg_3_0.targetList[1]:getBeattackPosition(arg_3_0.hero, arg_3_0.skillSeqIndex)

	arg_3_0.hero:setMovingFlag(true)
	arg_3_0.hero:setDesPos(var_3_5.x, var_3_5.y)

	local var_3_6 = CCArray:create()

	arg_3_0:playBigSkillScreenAnim(var_3_6)
	var_3_6:addObject(CCMoveTo:create(FIGHT_CHARGE_TIME, var_3_5))
	var_3_6:addObject(CCCallFuncN:create(var_3_0))
	var_3_6:addObject(CCDelayTime:create(arg_3_0.hitFrame1))
	var_3_6:addObject(CCCallFuncN:create(var_3_2))
	var_3_6:addObject(CCDelayTime:create(arg_3_0.hitFrame2 - arg_3_0.hitFrame1))
	var_3_6:addObject(CCCallFuncN:create(var_3_2))
	var_3_6:addObject(CCDelayTime:create(arg_3_0.hitFrame3 - arg_3_0.hitFrame2))
	var_3_6:addObject(CCCallFuncN:create(var_3_2))
	var_3_6:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame3, 0.1)))
	var_3_6:addObject(CCCallFuncN:create(var_3_1))
	var_3_6:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_3_0.hero:getFixPosition()))
	var_3_6:addObject(CCCallFuncN:create(var_3_3))
	var_3_6:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_6:addObject(CCCallFuncN:create(var_3_4))

	local var_3_7 = CCSequence:create(var_3_6)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_7)
end

function zbYingquan_1.getDamageRatio(arg_9_0, arg_9_1)
	return 3
end
