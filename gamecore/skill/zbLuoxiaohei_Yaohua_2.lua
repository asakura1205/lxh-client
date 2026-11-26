require("gamecore.skill.zbBaseSkill")

zbLuoxiaohei_Yaohua_2 = class("zbLuoxiaohei_Yaohua_2", zbBaseSkill)
zbLuoxiaohei_Yaohua_2.__index = zbLuoxiaohei_Yaohua_2

function zbLuoxiaohei_Yaohua_2.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbLuoxiaohei_Yaohua_2.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbLuoxiaohei_Yaohua_2.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Default
	arg_2_0.subTargetType = ESubTargetType.Column
	arg_2_0.moveFrame = 0.03333333333333333
	arg_2_0.groundFrame = 0.3
	arg_2_0.hitFrame = 0.6
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbLuoxiaohei_Yaohua_2.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)

		local var_4_0 = g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)

		if var_4_0 then
			var_4_0:setScale(0.75)
		end
	end

	local function var_3_1()
		for iter_5_0, iter_5_1 in pairs(arg_3_0.targetList) do
			local var_5_0, var_5_1, var_5_2 = g_CombatFormula:calcDamage(arg_3_0.hero, iter_5_1, arg_3_0)

			if var_5_1 > 0 then
				iter_5_1:playBehitAnimation(arg_3_0.skillRecord.hitEffectId, arg_3_0)
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
	var_3_5:addObject(CCDelayTime:create(arg_3_0.moveFrame))
	var_3_5:addObject(CCDelayTime:create(arg_3_0.hitFrame - arg_3_0.groundFrame))
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

function zbLuoxiaohei_Yaohua_2.getDamageRatio(arg_8_0, arg_8_1)
	return 1
end
