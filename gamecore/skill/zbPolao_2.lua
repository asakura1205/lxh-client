require("gamecore.skill.zbBaseNormalAttack")

zbPolao_2 = class("zbPolao_2", zbBaseNormalAttack)
zbPolao_2.__index = zbPolao_2

function zbPolao_2.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbPolao_2.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbPolao_2.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Default
	arg_2_0.subTargetType = ESubTargetType.Row
	arg_2_0.damageSectionCount = 2
	arg_2_0.hitFrame1 = 0.7666666666666667
	arg_2_0.hitFrame2 = 1.1
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbPolao_2.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseAttackEffectId)
	end

	local function var_3_1()
		g_CombatBubble:setNumOffsetRandomRangeX(25)

		for iter_5_0, iter_5_1 in pairs(arg_3_0.targetList) do
			local var_5_0, var_5_1, var_5_2 = g_CombatFormula:calcDamage(arg_3_0.hero, iter_5_1, arg_3_0)

			if var_5_1 > 0 then
				iter_5_1:playBehitAnimation(arg_3_0.skillRecord.hitEffectId, arg_3_0)
			end
		end

		g_CombatBubble:setNumOffsetRandomRangeX(0)
	end

	local function var_3_2()
		g_CombatBubble:setNumOffsetRandomRangeX(25)

		for iter_6_0, iter_6_1 in pairs(arg_3_0.targetList) do
			local var_6_0, var_6_1, var_6_2 = g_CombatFormula:calcDamage(arg_3_0.hero, iter_6_1, arg_3_0)

			if var_6_1 > 0 then
				iter_6_1:playBehitAnimation(arg_3_0.skillRecord.hitEffectId, arg_3_0)

				if arg_3_0.hero.polaoSkill3 ~= nil then
					arg_3_0.hero.polaoSkill3:actionEx(iter_6_1)
				end
			end
		end

		g_CombatBubble:setNumOffsetRandomRangeX(0)
	end

	local function var_3_3()
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

	local var_3_5 = getFormationRowFrontPos(arg_3_0.hero.forceType, arg_3_0.targetList[1]:getFormationIndex())

	arg_3_0.hero:setMovingFlag(true)
	arg_3_0.hero:setDesPos(var_3_5.x, var_3_5.y)

	local var_3_6 = CCArray:create()

	if arg_3_0.hero.polaoSkill4 ~= nil then
		arg_3_0.hero.polaoSkill4:actionEx(var_3_6)
	end

	var_3_6:addObject(CCMoveTo:create(FIGHT_CHARGE_TIME, var_3_5))
	var_3_6:addObject(CCCallFuncN:create(var_3_0))
	var_3_6:addObject(CCDelayTime:create(arg_3_0.hitFrame1))
	var_3_6:addObject(CCCallFuncN:create(var_3_1))
	var_3_6:addObject(CCDelayTime:create(arg_3_0.hitFrame2 - arg_3_0.hitFrame1))
	var_3_6:addObject(CCCallFuncN:create(var_3_2))
	var_3_6:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame2, 0.1)))
	var_3_6:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_3_0.hero:getFixPosition()))
	var_3_6:addObject(CCCallFuncN:create(var_3_3))
	var_3_6:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_6:addObject(CCCallFuncN:create(var_3_4))

	local var_3_7 = CCSequence:create(var_3_6)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_7)
end

function zbPolao_2.getDamageRatio(arg_9_0, arg_9_1)
	local var_9_0 = 1

	if arg_9_1:isZhongshang() then
		var_9_0 = var_9_0 + 0.2
	end

	return var_9_0
end
