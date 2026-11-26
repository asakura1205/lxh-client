require("gamecore.skill.zbBaseSkill")

zbAbo_1 = class("zbAbo_1", zbBaseSkill)
zbAbo_1.__index = zbAbo_1

function zbAbo_1.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbAbo_1.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbAbo_1.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Default
	arg_2_0.subTargetType = ESubTargetType.Row
	arg_2_0.hitFrame = 1.0666666666666667
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbAbo_1.action(arg_3_0)
	local function var_3_0()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_1()
		g_DarkNode:hideDarkNode(arg_3_0.hero)
		g_CombatSystem:resumeExclude(arg_3_0.hero)
	end

	local function var_3_2()
		local var_6_0 = getFlipForceType(arg_3_0.hero.forceType)
		local var_6_1 = arg_3_0.targetList[1]
		local var_6_2 = getFormationLineCenterPos(var_6_0, var_6_1:getFormationIndex())
		local var_6_3 = ccp(arg_3_0.hero:getPosition())
		local var_6_4 = getFormationLineCenterPos(var_6_0, var_6_1:getFormationIndex())
		local var_6_5, var_6_6 = zbEffectTable:getEffectPosOffset(arg_3_0.skillRecord.flyEffectId, var_6_0)

		var_6_3.x = var_6_3.x + var_6_5
		var_6_3.y = var_6_3.y + var_6_6
		var_6_2.y = var_6_3.y

		g_EffectSystem:createMissileEffectPos(arg_3_0.hero, arg_3_0, EPathType.Line, var_6_3, var_6_2, var_6_4, arg_3_0.skillRecord.flyEffectId, arg_3_0.skillRecord.targetEffectId)
	end

	local function var_3_3()
		arg_3_0:enterIdle()
	end

	local function var_3_4()
		return
	end

	arg_3_0.actioning = true
	arg_3_0.accumTime = 0
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.getn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_5 = CCArray:create()

	arg_3_0:playBigSkillScreenAnim(var_3_5)
	var_3_5:addObject(CCCallFuncN:create(var_3_0))
	var_3_5:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	var_3_5:addObject(CCCallFuncN:create(var_3_2))
	var_3_5:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame, 0.1)))
	var_3_5:addObject(CCCallFuncN:create(var_3_1))
	var_3_5:addObject(CCCallFuncN:create(var_3_3))
	var_3_5:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_3_0.hero:getFixPosition()))
	var_3_5:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_5:addObject(CCCallFuncN:create(var_3_4))

	local var_3_6 = CCSequence:create(var_3_5)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_6)
	arg_3_0:popupSkillBubble()
end

function zbAbo_1.update(arg_9_0, arg_9_1)
	arg_9_0.accumTime = arg_9_0.accumTime + arg_9_1

	if arg_9_0.accumTime > 3 then
		arg_9_0.actioning = false
	end
end

function zbAbo_1.hitTarget(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.targetList) do
		iter_10_1:resume()

		local var_10_0, var_10_1, var_10_2 = g_CombatFormula:calcDamage(arg_10_0.hero, iter_10_1, arg_10_0)

		if var_10_1 > 0 then
			iter_10_1:playBehitAnimation(arg_10_0.skillRecord.hitEffectId, arg_10_0)
		end
	end
end

function zbAbo_1.hitEnd(arg_11_0)
	arg_11_0.actioning = false
end

function zbAbo_1.getDamageRatio(arg_12_0, arg_12_1)
	return 1
end
