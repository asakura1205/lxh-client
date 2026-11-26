require("gamecore.skill.zbBaseSkill")

zbXiaobaishu_3 = class("zbXiaobaishu_3", zbBaseSkill)
zbXiaobaishu_3.__index = zbXiaobaishu_3

function zbXiaobaishu_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbXiaobaishu_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbXiaobaishu_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.passiveTriggerType = EPassiveTriggerType.Beattacked
	arg_2_0.hitFrame = 0.3333333333333333
	arg_2_0.sequenceName = ANIMATION_SEQUENCE_SKILL4
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbXiaobaishu_3.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble(0.25)
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
	end

	local function var_3_1()
		arg_3_0.hero:addHp(arg_3_0.hero.maxHp * 0.05 + arg_3_0:getDamageAbs(), false, 1, 0.25)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, 2001)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, 2002)
	end

	local function var_3_2()
		arg_3_0:enterIdle()
	end

	local function var_3_3()
		arg_3_0.actioning = false
	end

	if zbCombatFormula:isSucceedRate(300) == false or arg_3_0.hero:numberOfRunningActions() > 0 then
		arg_3_0.actioning = false

		return
	end

	arg_3_0.actioning = true

	local var_3_4 = CCArray:create()

	var_3_4:addObject(CCCallFuncN:create(var_3_0))
	var_3_4:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	var_3_4:addObject(CCCallFuncN:create(var_3_1))
	var_3_4:addObject(CCDelayTime:create(arg_3_0.skillDurationTime - arg_3_0.hitFrame))
	var_3_4:addObject(CCCallFuncN:create(var_3_2))
	var_3_4:addObject(CCCallFuncN:create(var_3_3))

	local var_3_5 = CCSequence:create(var_3_4)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_5)
end
