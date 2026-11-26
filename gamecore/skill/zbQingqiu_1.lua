require("gamecore.skill.zbBaseNormalAttack")

zbQingqiu_1 = class("zbQingqiu_1", zbBaseSkill)
zbQingqiu_1.__index = zbQingqiu_1

function zbQingqiu_1.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbQingqiu_1.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbQingqiu_1.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Random_5
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.targetFrame = 0
	arg_2_0.hitFrame = 2.1666666666666665
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.targetIndex = 0
	arg_2_0.attackHitDelayTime = 0.26666666666666666
end

function zbQingqiu_1.action(arg_3_0)
	local function var_3_0()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseAttackEffectId)
	end

	local function var_3_1()
		g_DarkNode:hideDarkNode(arg_3_0.hero)
		g_CombatSystem:resumeExclude(arg_3_0.hero)
	end

	local function var_3_2()
		local var_6_0 = arg_3_0.targetList[1].forceType
		local var_6_1 = getFormationRowCenterPos(var_6_0, 5)

		g_EffectSystem:createBombEffect(arg_3_0.hero, var_6_0, var_6_1, arg_3_0.skillRecord.targetEffectId, 0)
	end

	local function var_3_3()
		local var_7_0 = arg_3_0.targetList[arg_3_0.targetIndex]

		if var_7_0 ~= nil then
			var_7_0:resume()

			local var_7_1, var_7_2, var_7_3 = g_CombatFormula:calcDamage(arg_3_0.hero, var_7_0, arg_3_0)

			if var_7_2 > 0 then
				var_7_0:playBehitAnimation(arg_3_0.skillRecord.hitEffectId, arg_3_0)

				local var_7_4 = BUFF_TYPE_PROPERTY_TOUGH
				local var_7_5 = -var_7_0.baseTough * 0.1
				local var_7_6 = 0
				local var_7_7 = 2

				g_BuffSystem:createBuff(arg_3_0.hero, arg_3_0.hero, var_7_4, var_7_5, var_7_6, var_7_7, 1)
			end
		end

		arg_3_0.targetIndex = arg_3_0.targetIndex + 1
	end

	local function var_3_4()
		arg_3_0:enterIdle()
	end

	local function var_3_5()
		arg_3_0.actioning = false
	end

	arg_3_0.actioning = true
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.maxn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_6 = CCArray:create()

	arg_3_0:playBigSkillScreenAnim(var_3_6)
	var_3_6:addObject(CCCallFuncN:create(var_3_0))
	var_3_6:addObject(CCDelayTime:create(arg_3_0.targetFrame))
	var_3_6:addObject(CCCallFuncN:create(var_3_2))
	var_3_6:addObject(CCDelayTime:create(arg_3_0.hitFrame - arg_3_0.targetFrame))

	arg_3_0.targetIndex = 1

	for iter_3_0, iter_3_1 in pairs(arg_3_0.targetList) do
		var_3_6:addObject(CCCallFuncN:create(var_3_3))
		var_3_6:addObject(CCDelayTime:create(arg_3_0.attackHitDelayTime))
	end

	local var_3_7 = math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame - arg_3_0.attackHitDelayTime * table.getn(arg_3_0.targetList), 0.1)
	local var_3_8 = 3.8333333333333335 - arg_3_0.attackHitDelayTime * table.getn(arg_3_0.targetList)

	var_3_6:addObject(CCDelayTime:create(var_3_7))
	var_3_6:addObject(CCCallFuncN:create(var_3_1))
	var_3_6:addObject(CCCallFuncN:create(var_3_4))
	var_3_6:addObject(CCDelayTime:create(math.max(var_3_8 - var_3_7, 0.1)))
	var_3_6:addObject(CCCallFuncN:create(var_3_5))

	local var_3_9 = CCSequence:create(var_3_6)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_9)
end

function zbQingqiu_1.getDamageRatio(arg_10_0, arg_10_1)
	return 0.7
end
