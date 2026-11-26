require("gamecore.skill.zbBaseSkill")

zbMaozha_1 = class("zbMaozha_1", zbBaseSkill)
zbMaozha_1.__index = zbMaozha_1

function zbMaozha_1.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbMaozha_1.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbMaozha_1.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Random_5
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.groundFrame = 1.5666666666666667
	arg_2_0.hitFrame1 = 1.7333333333333334
	arg_2_0.hitFrame2 = 2.2
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbMaozha_1.action(arg_3_0)
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
			end
		end
	end

	local function var_3_4()
		for iter_8_0, iter_8_1 in pairs(arg_3_0.targetList) do
			local var_8_0, var_8_1, var_8_2 = g_CombatFormula:calcDamage(arg_3_0.hero, iter_8_1, arg_3_0)

			if var_8_1 > 0 then
				iter_8_1:playBehitAnimation(arg_3_0.skillRecord.hitEffectId, arg_3_0)
				iter_8_1:addMp(-20)
				g_CombatBubble:showBubble(iter_8_1, ECombatBubble.MpDown, 0, 0, 1)
			end
		end
	end

	local function var_3_5()
		arg_3_0:enterIdle()
	end

	local function var_3_6()
		arg_3_0.actioning = false
	end

	arg_3_0.actioning = true
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.getn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_7 = getFormationCenterFrontPos(getFlipForceType(arg_3_0.hero.forceType))
	local var_3_8 = 500

	if arg_3_0.hero.forceType == ForceType.Left then
		var_3_7.x = var_3_7.x - var_3_8
	else
		var_3_7.x = var_3_7.x + var_3_8
	end

	arg_3_0.hero:setMovingFlag(true)
	arg_3_0.hero:setDesPos(var_3_7.x, var_3_7.y)

	local var_3_9 = CCArray:create()

	arg_3_0:playBigSkillScreenAnim(var_3_9)
	var_3_9:addObject(CCCallFuncN:create(var_3_0))
	var_3_9:addObject(CCMoveTo:create(arg_3_0.groundFrame, var_3_7))
	var_3_9:addObject(CCDelayTime:create(arg_3_0.hitFrame1 - arg_3_0.groundFrame))
	var_3_9:addObject(CCCallFuncN:create(var_3_3))
	var_3_9:addObject(CCDelayTime:create(arg_3_0.hitFrame2 - arg_3_0.hitFrame1))
	var_3_9:addObject(CCCallFuncN:create(var_3_4))
	var_3_9:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame2, 0.1)))
	var_3_9:addObject(CCCallFuncN:create(var_3_1))
	var_3_9:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_3_0.hero:getFixPosition()))
	var_3_9:addObject(CCCallFuncN:create(var_3_5))
	var_3_9:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_9:addObject(CCCallFuncN:create(var_3_6))

	local var_3_10 = CCSequence:create(var_3_9)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_10)
	arg_3_0:popupSkillBubble()
end

function zbMaozha_1.getDamageRatio(arg_11_0, arg_11_1)
	return 0.7
end
