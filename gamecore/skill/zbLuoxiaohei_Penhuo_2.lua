require("gamecore.skill.zbBaseSkill")

zbLuoxiaohei_Penhuo_2 = class("zbLuoxiaohei_Penhuo_2", zbBaseSkill)
zbLuoxiaohei_Penhuo_2.__index = zbLuoxiaohei_Penhuo_2

function zbLuoxiaohei_Penhuo_2.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbLuoxiaohei_Penhuo_2.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbLuoxiaohei_Penhuo_2.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Default
	arg_2_0.subTargetType = ESubTargetType.Column
	arg_2_0.targetFrame = 0.9
	arg_2_0.hitFrame = 1.0333333333333334
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbLuoxiaohei_Penhuo_2.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_1()
		local function var_5_0(arg_6_0)
			if arg_6_0 == 1 or arg_6_0 == 2 or arg_6_0 == 3 then
				return 1, 2, 3
			elseif arg_6_0 == 4 or arg_6_0 == 5 or arg_6_0 == 6 then
				return 4, 5, 6
			elseif arg_6_0 == 7 or arg_6_0 == 8 or arg_6_0 == 9 then
				return 7, 8, 9
			else
				echo("warning: 111111111111111111122222222:")

				return arg_6_0, arg_6_0, arg_6_0
			end
		end

		local var_5_1 = arg_3_0.targetList[1].forceType
		local var_5_2, var_5_3, var_5_4 = var_5_0(arg_3_0.targetList[1]:getFormationIndex())
		local var_5_5 = getCombatHeroPos(var_5_1, var_5_2)

		g_EffectSystem:createBombEffect(arg_3_0.hero, var_5_1, var_5_5, arg_3_0.skillRecord.targetEffectId, 0)

		local var_5_6 = getCombatHeroPos(var_5_1, var_5_3)

		g_EffectSystem:createBombEffect(arg_3_0.hero, var_5_1, var_5_6, arg_3_0.skillRecord.targetEffectId, 0, 0.1)

		local var_5_7 = getCombatHeroPos(var_5_1, var_5_4)

		g_EffectSystem:createBombEffect(arg_3_0.hero, var_5_1, var_5_7, arg_3_0.skillRecord.targetEffectId, 0, 0.1)
	end

	local function var_3_2()
		for iter_7_0, iter_7_1 in pairs(arg_3_0.targetList) do
			local var_7_0, var_7_1, var_7_2 = g_CombatFormula:calcDamage(arg_3_0.hero, iter_7_1, arg_3_0)

			if var_7_1 > 0 then
				iter_7_1:playBehitAnimation(arg_3_0.skillRecord.hitEffectId, arg_3_0)

				if zbCombatFormula:isSucceedRate(500) then
					local var_7_3 = BUFF_TYPE_PROPERTY_HP_FIRE
					local var_7_4 = -var_7_1 * 0.1
					local var_7_5 = 0
					local var_7_6 = 2

					g_BuffSystem:createBuff(arg_3_0.hero, iter_7_1, var_7_3, var_7_4, var_7_5, var_7_6)
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

	if table.getn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_5 = arg_3_0.targetList[1]:getBeattackPosition(arg_3_0.hero, arg_3_0.skillSeqIndex)

	arg_3_0.hero:setMovingFlag(true)
	arg_3_0.hero:setDesPos(var_3_5.x, var_3_5.y)

	local var_3_6 = CCArray:create()

	var_3_6:addObject(CCMoveTo:create(FIGHT_CHARGE_TIME, var_3_5))
	var_3_6:addObject(CCCallFuncN:create(var_3_0))
	var_3_6:addObject(CCDelayTime:create(arg_3_0.targetFrame))
	var_3_6:addObject(CCCallFuncN:create(var_3_1))
	var_3_6:addObject(CCDelayTime:create(arg_3_0.hitFrame - arg_3_0.targetFrame))
	var_3_6:addObject(CCCallFuncN:create(var_3_2))
	var_3_6:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame, 0.1)))
	var_3_6:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_3_0.hero:getFixPosition()))

	if arg_3_0.hero.luoxiaohei2Skill3 ~= nil then
		arg_3_0.hero.luoxiaohei2Skill3:actionEx()
	end

	var_3_6:addObject(CCCallFuncN:create(var_3_3))
	var_3_6:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_6:addObject(CCCallFuncN:create(var_3_4))

	local var_3_7 = CCSequence:create(var_3_6)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_7)
end

function zbLuoxiaohei_Penhuo_2.getDamageRatio(arg_10_0, arg_10_1)
	return 0.75
end
