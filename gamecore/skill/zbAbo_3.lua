require("gamecore.skill.zbBaseSkill")

zbAbo_3 = class("zbAbo_3", zbBaseSkill)
zbAbo_3.__index = zbAbo_3

function zbAbo_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbAbo_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbAbo_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 0.3333333333333333
	arg_2_0.sequenceName = ANIMATION_SEQUENCE_SHOW
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.hero.aboSkill3 = arg_2_0
end

function zbAbo_3.actionEx(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_1()
		arg_3_0.hero:addHp(arg_3_0.hero.maxHp * 0.05 + arg_3_0:getDamageAbs(), false, 1)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, 2001)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, 2002)
	end

	if zbCombatFormula:isSucceedRate(300) == false then
		return
	end

	arg_3_1:addObject(CCCallFuncN:create(var_3_0))
	arg_3_1:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	arg_3_1:addObject(CCCallFuncN:create(var_3_1))
	arg_3_1:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame, 0.1)))
end
