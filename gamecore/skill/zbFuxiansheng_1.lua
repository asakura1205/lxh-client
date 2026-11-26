require("gamecore.skill.zbBaseSkill")

zbFuxiansheng_1 = class("zbFuxiansheng_1", zbBaseSkill)
zbFuxiansheng_1.__index = zbFuxiansheng_1

function zbFuxiansheng_1.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbFuxiansheng_1.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbFuxiansheng_1.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Default
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.damageSectionCount = 3
	arg_2_0.hitFrame1 = 1.6666666666666667
	arg_2_0.hitFrame2 = 1.8666666666666667
	arg_2_0.hitFrame3 = 2.4
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbFuxiansheng_1.action(arg_3_0)
	local function var_3_0()
		local var_4_0 = arg_3_0.targetList[1]:getBeattackPosition(arg_3_0.hero, arg_3_0.skillSeqIndex)

		arg_3_0.hero:setMovingFlag(true)
		arg_3_0.hero:setDesPos(var_4_0.x, var_4_0.y)
	end

	local function var_3_1()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_2()
		g_DarkNode:hideDarkNode(arg_3_0.hero)
		g_CombatSystem:resumeExclude(arg_3_0.hero)
	end

	local function var_3_3()
		for iter_7_0, iter_7_1 in pairs(arg_3_0.targetList) do
			g_EffectSystem:createInstantEffect(iter_7_1, arg_3_0.skillRecord.targetEffectId)
		end
	end

	local function var_3_4()
		g_CombatBubble:setNumOffsetRandomRangeX(25)

		for iter_8_0, iter_8_1 in pairs(arg_3_0.targetList) do
			iter_8_1:resume()

			local var_8_0, var_8_1, var_8_2 = g_CombatFormula:calcDamage(arg_3_0.hero, iter_8_1, arg_3_0)

			if var_8_1 > 0 then
				iter_8_1:playBehitAnimation(arg_3_0.skillRecord.hitEffectId, arg_3_0)
			end
		end

		g_CombatBubble:setNumOffsetRandomRangeX(0)
	end

	local function var_3_5()
		g_CombatBubble:setNumOffsetRandomRangeX(25)

		for iter_9_0, iter_9_1 in pairs(arg_3_0.targetList) do
			iter_9_1:resume()

			local var_9_0, var_9_1, var_9_2 = g_CombatFormula:calcDamage(arg_3_0.hero, iter_9_1, arg_3_0)

			if var_9_1 > 0 then
				iter_9_1:playBehitAnimation(arg_3_0.skillRecord.hitEffectId, arg_3_0)
				g_BuffSystem:createControlBuff(arg_3_0.hero, iter_9_1, BUFF_TYPE_CONTROL_ZHONGSHANG)
			end
		end

		g_CombatBubble:setNumOffsetRandomRangeX(0)
	end

	local function var_3_6()
		arg_3_0:enterIdle()
	end

	local function var_3_7()
		arg_3_0.actioning = false
	end

	arg_3_0.actioning = true
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.getn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_8 = arg_3_0.targetList[1]:getBeattackPosition(arg_3_0.hero, arg_3_0.skillSeqIndex)
	local var_3_9 = 0
	local var_3_10 = 0
	local var_3_11 = CCArray:create()

	arg_3_0:playBigSkillScreenAnim(var_3_11)
	var_3_11:addObject(CCMoveTo:create(FIGHT_CHARGE_TIME, var_3_8))
	var_3_11:addObject(CCCallFuncN:create(var_3_0))
	var_3_11:addObject(CCCallFuncN:create(var_3_1))
	var_3_11:addObject(CCDelayTime:create(arg_3_0.hitFrame1))
	var_3_11:addObject(CCCallFuncN:create(var_3_4))
	var_3_11:addObject(CCDelayTime:create(arg_3_0.hitFrame2 - arg_3_0.hitFrame1))
	var_3_11:addObject(CCCallFuncN:create(var_3_4))
	var_3_11:addObject(CCDelayTime:create(arg_3_0.hitFrame3 - arg_3_0.hitFrame2))
	var_3_11:addObject(CCCallFuncN:create(var_3_3))
	var_3_11:addObject(CCDelayTime:create(0.1))
	var_3_11:addObject(CCCallFuncN:create(var_3_5))
	var_3_11:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame3 - 0.1, 0.1)))
	var_3_11:addObject(CCCallFuncN:create(var_3_2))
	var_3_11:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_3_0.hero:getFixPosition()))
	var_3_11:addObject(CCCallFuncN:create(var_3_6))
	var_3_11:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_11:addObject(CCCallFuncN:create(var_3_7))

	local var_3_12 = CCSequence:create(var_3_11)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_12)
end

function zbFuxiansheng_1.getDamageRatio(arg_12_0, arg_12_1)
	return 2
end
