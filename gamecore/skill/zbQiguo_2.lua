require("gamecore.skill.zbBaseSkill")

zbQiguo_2 = class("zbQiguo_2", zbBaseSkill)
zbQiguo_2.__index = zbQiguo_2

function zbQiguo_2.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbQiguo_2.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbQiguo_2.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Random_2
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.targetFrame = 0.6666666666666666
	arg_2_0.hitDelayFrame = 0.5333333333333333
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbQiguo_2.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_1()
		for iter_5_0, iter_5_1 in pairs(arg_3_0.targetList) do
			g_EffectSystem:createInstantEffect(iter_5_1, arg_3_0.skillRecord.targetEffectId)
		end
	end

	local function var_3_2()
		for iter_6_0, iter_6_1 in pairs(arg_3_0.targetList) do
			local var_6_0, var_6_1, var_6_2 = g_CombatFormula:calcDamage(arg_3_0.hero, iter_6_1, arg_3_0)

			if var_6_1 > 0 then
				iter_6_1:playBehitAnimation(arg_3_0.skillRecord.hitEffectId, arg_3_0)

				local var_6_3 = BUFF_TYPE_MISC_SUOLIAN
				local var_6_4 = 0
				local var_6_5 = 0
				local var_6_6 = 1

				g_BuffSystem:createBuff(arg_3_0.hero, iter_6_1, var_6_3, var_6_4, var_6_5, var_6_6)

				if arg_3_0.hero.qiguoSkill3 ~= nil then
					arg_3_0.hero.qiguoSkill3:actionEx(iter_6_1)
				end
			end
		end
	end

	local function var_3_3()
		arg_3_0:enterIdle()
	end

	local function var_3_4()
		arg_3_0.actioning = false
	end

	arg_3_0.actioning = true
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.maxn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_5 = CCArray:create()

	var_3_5:addObject(CCCallFuncN:create(var_3_0))
	var_3_5:addObject(CCDelayTime:create(arg_3_0.targetFrame))
	var_3_5:addObject(CCCallFuncN:create(var_3_1))
	var_3_5:addObject(CCDelayTime:create(arg_3_0.hitDelayFrame))
	var_3_5:addObject(CCCallFuncN:create(var_3_2))
	var_3_5:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.targetFrame - arg_3_0.hitDelayFrame, 0.1)))
	var_3_5:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_3_0.hero:getFixPosition()))
	var_3_5:addObject(CCCallFuncN:create(var_3_3))
	var_3_5:addObject(CCDelayTime:create(0.3333333333333333))
	var_3_5:addObject(CCCallFuncN:create(var_3_4))

	local var_3_6 = CCSequence:create(var_3_5)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_6)
end

function zbQiguo_2.getDamageRatio(arg_9_0, arg_9_1)
	return 0.75
end
