require("gamecore.skill.zbBaseSkill")

zbHuangshou_1 = class("zbHuangshou_1", zbBaseSkill)
zbHuangshou_1.__index = zbHuangshou_1

function zbHuangshou_1.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbHuangshou_1.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbHuangshou_1.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Default
	arg_2_0.subTargetType = ESubTargetType.Column
	arg_2_0.targetFrame = 1.6333333333333333
	arg_2_0.hitFrame = 2.2
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.skill4Enable = false
end

function zbHuangshou_1.action(arg_3_0)
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
		for iter_6_0, iter_6_1 in pairs(arg_3_0.targetList) do
			g_EffectSystem:createInstantEffect(iter_6_1, arg_3_0.skillRecord.targetEffectId)
		end
	end

	local function var_3_3()
		for iter_7_0, iter_7_1 in pairs(arg_3_0.targetList) do
			iter_7_1:resume()

			local var_7_0, var_7_1, var_7_2 = g_CombatFormula:calcDamage(arg_3_0.hero, iter_7_1, arg_3_0)

			if var_7_1 > 0 then
				iter_7_1:playBehitAnimation(arg_3_0.skillRecord.hitEffectId, arg_3_0)

				if var_7_2 == false and arg_3_0.hero.huangshouSkill3 ~= nil then
					arg_3_0.hero.huangshouSkill3:actionEx(iter_7_1)
				end

				if var_7_2 == false and arg_3_0.skill4Enable then
					arg_3_0.hero.huangshouSkill4:actionEx(iter_7_1)
				end
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
	arg_3_0.skill4Enable = arg_3_0.hero.huangshouSkill4 ~= nil and arg_3_0.hero.huangshouSkill4:isCanTrigger()
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.getn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_6 = getFormationLineFristPos(arg_3_0.hero.forceType, arg_3_0.hero:getFormationIndex())
	local var_3_7 = 0

	if arg_3_0.hero.forceType == ForceType.Left then
		var_3_6.x = var_3_6.x - var_3_7
	else
		var_3_6.x = var_3_6.x + var_3_7
	end

	arg_3_0.hero:setMovingFlag(true)
	arg_3_0.hero:setDesPos(var_3_6.x, var_3_6.y)

	local var_3_8 = CCArray:create()

	arg_3_0:playBigSkillScreenAnim(var_3_8)
	var_3_8:addObject(CCMoveTo:create(FIGHT_CHARGE_TIME, var_3_6))
	var_3_8:addObject(CCCallFuncN:create(var_3_0))
	var_3_8:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	var_3_8:addObject(CCCallFuncN:create(var_3_3))
	var_3_8:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame, 0.1)))
	var_3_8:addObject(CCCallFuncN:create(var_3_1))
	var_3_8:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_3_0.hero:getFixPosition()))
	var_3_8:addObject(CCCallFuncN:create(var_3_4))
	var_3_8:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_8:addObject(CCCallFuncN:create(var_3_5))

	local var_3_9 = CCSequence:create(var_3_8)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_9)
end

function zbHuangshou_1.getDamageRatio(arg_10_0, arg_10_1)
	local var_10_0 = 0.7

	if arg_10_0.skill4Enable then
		var_10_0 = var_10_0 + arg_10_0.hero.huangshouSkill4:getDamageRatio()
	end

	return var_10_0
end

function zbHuangshou_1.getDamageAbs(arg_11_0)
	local var_11_0 = arg_11_0:getDamageAbsBase()

	if arg_11_0.skill4Enable then
		var_11_0 = var_11_0 + arg_11_0.hero.huangshouSkill4:getDamageAbs()
	end

	return var_11_0
end
