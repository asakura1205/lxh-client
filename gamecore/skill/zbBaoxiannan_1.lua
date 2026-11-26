require("gamecore.skill.zbBaseSkill")

zbBaoxiannan_1 = class("zbBaoxiannan_1", zbBaseSkill)
zbBaoxiannan_1.__index = zbBaoxiannan_1

function zbBaoxiannan_1.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbBaoxiannan_1.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbBaoxiannan_1.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Random_5
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.missilePathType = EPathType.Bezier
	arg_2_0.hitFrame = 1.1333333333333333
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.accumTime = 0
	arg_2_0.skill4Enable = false
end

function zbBaoxiannan_1.action(arg_3_0)
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
		local var_6_0 = getFlipForceType(arg_3_0.hero.forceType)
		local var_6_1 = getFormationRowCenterPos(var_6_0, 5)
		local var_6_2 = ccp(arg_3_0.hero:getPosition())
		local var_6_3 = ccp(var_6_1.x, var_6_1.y)

		var_6_2.x = var_6_2.x + 30
		var_6_2.y = var_6_2.y + 80

		g_EffectSystem:createMissileEffectPos(arg_3_0.hero, arg_3_0, EPathType.Bezier, var_6_2, var_6_1, var_6_3, arg_3_0.skillRecord.flyEffectId, arg_3_0.skillRecord.targetEffectId)
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
	var_3_5:addObject(CCCallFuncN:create(var_3_1))
	var_3_5:addObject(CCCallFuncN:create(var_3_2))
	var_3_5:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame, 0.1)))
	var_3_5:addObject(CCCallFuncN:create(var_3_3))
	var_3_5:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_5:addObject(CCCallFuncN:create(var_3_4))

	local var_3_6 = CCSequence:create(var_3_5)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_6)

	arg_3_0.skill4Enable = false

	if arg_3_0.hero.bxnHero4 ~= nil and zbCombatFormula:isSucceedRate(300) then
		arg_3_0.skill4Enable = true
	end
end

function zbBaoxiannan_1.update(arg_9_0, arg_9_1)
	arg_9_0.accumTime = arg_9_0.accumTime + arg_9_1

	if arg_9_0.accumTime > 3 then
		arg_9_0.actioning = false
	end
end

function zbBaoxiannan_1.hitTarget(arg_10_0)
	local var_10_0 = false

	for iter_10_0, iter_10_1 in pairs(arg_10_0.targetList) do
		local var_10_1, var_10_2, var_10_3 = g_CombatFormula:calcDamage(arg_10_0.hero, iter_10_1, arg_10_0)

		if var_10_2 > 0 then
			iter_10_1:playBehitAnimation(arg_10_0.skillRecord.hitEffectId, arg_10_0)

			var_10_0 = true
		end
	end

	if arg_10_0.skill4Enable and var_10_0 then
		arg_10_0.hero.bxnHero4:popupSkillBubble()
	end
end

function zbBaoxiannan_1.hitEnd(arg_11_0)
	arg_11_0.actioning = false
end

function zbBaoxiannan_1.getDamageRatio(arg_12_0, arg_12_1)
	local var_12_0 = 1

	if arg_12_0.skill4Enable then
		var_12_0 = var_12_0 + arg_12_0.hero.bxnHero4:getDamageRatio(arg_12_1)
	end

	return var_12_0
end

function zbBaoxiannan_1.getDamageAbs(arg_13_0)
	local var_13_0 = arg_13_0:getDamageAbsBase()

	if arg_13_0.skill4Enable then
		var_13_0 = var_13_0 + arg_13_0.hero.bxnHero4:getDamageAbs()
	end

	return var_13_0
end
