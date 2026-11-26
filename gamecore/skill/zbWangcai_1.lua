require("gamecore.skill.zbBaseSkill")

zbWangcai_1 = class("zbWangcai_1", zbBaseSkill)
zbWangcai_1.__index = zbWangcai_1

function zbWangcai_1.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbWangcai_1.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbWangcai_1.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Random_1
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.resumeFrame = 0.8
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbWangcai_1.action(arg_3_0)
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
		for iter_8_0, iter_8_1 in pairs(arg_3_0.targetList) do
			local var_8_0, var_8_1, var_8_2 = g_CombatFormula:calcDamage(arg_3_0.hero, iter_8_1, arg_3_0)

			if var_8_1 > 0 then
				iter_8_1:playBehitAnimation(arg_3_0.skillRecord.hitEffectId, arg_3_0)
				g_BuffSystem:createControlBuff(arg_3_0.hero, iter_8_1, BUFF_TYPE_CONTROL_CHAOFENG)
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

	local var_3_7 = arg_3_0.targetList[1]:getBeattackPosition(arg_3_0.hero, arg_3_0.skillSeqIndex)
	local var_3_8 = CCArray:create()

	arg_3_0:playBigSkillScreenAnim(var_3_8)
	var_3_8:addObject(CCCallFuncN:create(var_3_1))
	var_3_8:addObject(CCDelayTime:create(0.7333333333333333))
	var_3_8:addObject(CCMoveTo:create(0.001, var_3_7))
	var_3_8:addObject(CCCallFuncN:create(var_3_0))
	var_3_8:addObject(CCDelayTime:create(0.1))
	var_3_8:addObject(CCCallFuncN:create(var_3_2))
	var_3_8:addObject(CCCallFuncN:create(var_3_4))
	var_3_8:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - 0.8333333333333334, 0.1)))
	var_3_8:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_3_0.hero:getFixPosition()))
	var_3_8:addObject(CCCallFuncN:create(var_3_5))
	var_3_8:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_8:addObject(CCCallFuncN:create(var_3_6))

	local var_3_9 = CCSequence:create(var_3_8)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_9)
end

function zbWangcai_1.getDamageRatio(arg_11_0, arg_11_1)
	return 3
end
