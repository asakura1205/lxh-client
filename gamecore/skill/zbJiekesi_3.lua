require("gamecore.skill.zbBaseSkill")

zbJiekesi_3 = class("zbJiekesi_3", zbBaseSkill)
zbJiekesi_3.__index = zbJiekesi_3

function zbJiekesi_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbJiekesi_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbJiekesi_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Random_1
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.passiveTriggerType = EPassiveTriggerType.Revived
	arg_2_0.hitFrame = 0.6666666666666666
	arg_2_0.sequenceName = ANIMATION_SEQUENCE_SKILL2
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.missilePathType = EPathType.Bezier
	arg_2_0.hero.jiekesiSkill3 = arg_2_0

	arg_2_0.hero.energy:addCount()
end

function zbJiekesi_3.action(arg_3_0)
	arg_3_0:popupSkillBubble()
	arg_3_0.hero.energy:addCount()
end

function zbJiekesi_3.actionEx(arg_4_0, arg_4_1)
	local function var_4_0()
		arg_4_0:popupSkillBubble()
		arg_4_0.hero.anim:setAnimation(arg_4_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_4_0.hero, arg_4_0.skillRecord.riseEffectId)
	end

	local function var_4_1()
		arg_4_0.targetList = zbTargetHandler:selectTarget(arg_4_0.hero, arg_4_0, arg_4_0:getSideType(), arg_4_0:getTargetType(), arg_4_0:getSubTargetType())

		for iter_6_0, iter_6_1 in pairs(arg_4_0.targetList) do
			g_EffectSystem:createMissileEffect(arg_4_0.hero, iter_6_1, arg_4_0)
		end
	end

	if zbCombatFormula:isSucceedRate(500) == false then
		return
	end

	arg_4_1:addObject(CCCallFuncN:create(var_4_0))
	arg_4_1:addObject(CCDelayTime:create(arg_4_0.hitFrame))
	arg_4_1:addObject(CCCallFuncN:create(var_4_1))
	arg_4_1:addObject(CCDelayTime:create(math.max(arg_4_0.skillDurationTime - arg_4_0.hitFrame + 0.25, 0.1)))
end

function zbJiekesi_3.hited(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_3 > 0 and zbCombatFormula:isSucceedRate(150) then
		g_BuffSystem:createControlBuff(arg_7_0.hero, arg_7_1, BUFF_TYPE_CONTROL_HUNMI)
	end

	arg_7_0.actioning = false
end

function zbJiekesi_3.getDamageRatio(arg_8_0, arg_8_1)
	return 0.35
end
