require("gamecore.skill.zbBaseSkill")

zbLuoxiaobai_0 = class("zbLuoxiaobai_0", zbBaseSkill)
zbLuoxiaobai_0.__index = zbLuoxiaobai_0

function zbLuoxiaobai_0.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbLuoxiaobai_0.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbLuoxiaobai_0.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Default
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.damageSectionCount = 3
	arg_2_0.hitFrame1 = 0.7666666666666667
	arg_2_0.hitFrame2 = 1.1
	arg_2_0.hitFrame3 = 1.4333333333333333
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbLuoxiaobai_0.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_1()
		g_CombatBubble:setNumOffsetRandomRangeX(25)

		for iter_5_0, iter_5_1 in pairs(arg_3_0.targetList) do
			local var_5_0, var_5_1, var_5_2 = g_CombatFormula:calcDamage(arg_3_0.hero, iter_5_1, arg_3_0)

			if var_5_1 > 0 then
				iter_5_1:playBehitAnimation(arg_3_0.skillRecord.hitEffectId, arg_3_0)

				if arg_3_0:isQteRedoing() == false and arg_3_0.hero.luoxiaobaiSkill3 ~= nil then
					arg_3_0.hero.luoxiaobaiSkill3:actionEx(iter_5_1, var_5_1)
				end
			end
		end

		g_CombatBubble:setNumOffsetRandomRangeX(0)
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

	local var_3_6 = 0
	local var_3_7 = arg_3_0.hitFrame1 - var_3_6

	var_3_5:addObject(CCDelayTime:create(var_3_7))
	var_3_5:addObject(CCCallFuncN:create(var_3_1))

	local var_3_8 = var_3_6 + var_3_7
	local var_3_9 = arg_3_0.hitFrame2 - var_3_8

	var_3_5:addObject(CCDelayTime:create(var_3_9))
	var_3_5:addObject(CCCallFuncN:create(var_3_1))

	local var_3_10 = var_3_8 + var_3_9
	local var_3_11 = arg_3_0.hitFrame3 - var_3_10

	var_3_5:addObject(CCDelayTime:create(var_3_11))
	var_3_5:addObject(CCCallFuncN:create(var_3_1))

	local var_3_12 = var_3_10 + var_3_11

	var_3_5:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - var_3_12, 0.1)))
	var_3_5:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_3_0.hero:getFixPosition()))
	var_3_5:addObject(CCCallFuncN:create(var_3_2))
	var_3_5:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_5:addObject(CCCallFuncN:create(var_3_3))

	local var_3_13 = CCSequence:create(var_3_5)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_13)
end

function zbLuoxiaobai_0.getDamageRatio(arg_8_0, arg_8_1)
	return 1
end
