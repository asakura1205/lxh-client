require("gamecore.skill.zbBaseSkill")

zbQiguo_0 = class("zbQiguo_0", zbBaseSkill)
zbQiguo_0.__index = zbQiguo_0

function zbQiguo_0.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbQiguo_0.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbQiguo_0.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Default
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 1.1
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbQiguo_0.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_1()
		for iter_5_0, iter_5_1 in pairs(arg_3_0.targetList) do
			local var_5_0, var_5_1, var_5_2 = g_CombatFormula:calcDamage(arg_3_0.hero, iter_5_1, arg_3_0)

			if var_5_1 > 0 then
				iter_5_1:playBehitAnimation(arg_3_0.skillRecord.hitEffectId, arg_3_0)

				if arg_3_0:isQteRedoing() == false then
					if arg_3_0.hero.qiguoSkill3 ~= nil then
						arg_3_0.hero.qiguoSkill3:actionEx(iter_5_1)
					end

					if arg_3_0.hero.qiguoSkill4 ~= nil and zbCombatFormula:isSucceedRate(300) then
						g_BuffSystem:createControlBuff(arg_3_0.hero, iter_5_1, BUFF_TYPE_CONTROL_CHENMO)
					end
				end
			end
		end
	end

	local function var_3_2()
		arg_3_0:enterIdle()
	end

	local function var_3_3()
		arg_3_0.actioning = false
	end

	arg_3_0.actioning = true
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.getn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_4 = arg_3_0.targetList[1]:getBeattackPosition(arg_3_0.hero, arg_3_0.skillSeqIndex)

	arg_3_0.hero:setMovingFlag(true)
	arg_3_0.hero:setDesPos(var_3_4.x, var_3_4.y)

	local var_3_5 = CCArray:create()

	var_3_5:addObject(CCMoveTo:create(FIGHT_CHARGE_TIME, var_3_4))
	var_3_5:addObject(CCCallFuncN:create(var_3_0))
	var_3_5:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	var_3_5:addObject(CCCallFuncN:create(var_3_1))
	var_3_5:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame, 0.1)))
	var_3_5:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_3_0.hero:getFixPosition()))
	var_3_5:addObject(CCCallFuncN:create(var_3_2))
	var_3_5:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_5:addObject(CCCallFuncN:create(var_3_3))

	local var_3_6 = CCSequence:create(var_3_5)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_6)
end

function zbQiguo_0.getDamageRatio(arg_8_0, arg_8_1)
	local var_8_0 = 1

	if arg_8_0.hero.qiguoSkill4 ~= nil then
		var_8_0 = var_8_0 + arg_8_0.hero.qiguoSkill4:getDamageRatio()
	end

	return var_8_0
end

function zbQiguo_0.getDamageAbs(arg_9_0)
	local var_9_0 = arg_9_0:getDamageAbsBase()

	if arg_9_0.hero.qiguoSkill4 ~= nil then
		var_9_0 = var_9_0 + arg_9_0.hero.qiguoSkill4:getDamageAbs()
	end

	return var_9_0
end
