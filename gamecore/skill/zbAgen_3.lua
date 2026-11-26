require("gamecore.skill.zbBaseSkill")

zbAgen_3 = class("zbAgen_3", zbBaseSkill)
zbAgen_3.__index = zbAgen_3

function zbAgen_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbAgen_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbAgen_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.passiveTriggerType = EPassiveTriggerType.Beattacked
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbAgen_3.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble(0.25)
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
		arg_3_0.hero:addHp(arg_3_0.hero.maxHp * 0.03 + arg_3_0:getDamageAbs(), false, 1, 0.25)
	end

	local function var_3_1()
		arg_3_0:enterIdle()
	end

	local function var_3_2()
		arg_3_0.actioning = false
	end

	if zbCombatFormula:isSucceedRate(300) == false or arg_3_0.hero:numberOfRunningActions() > 0 then
		arg_3_0.actioning = false

		return
	end

	arg_3_0.actioning = true

	local var_3_3 = CCArray:create()

	var_3_3:addObject(CCCallFuncN:create(var_3_0))
	var_3_3:addObject(CCDelayTime:create(arg_3_0.skillDurationTime))
	var_3_3:addObject(CCCallFuncN:create(var_3_1))
	var_3_3:addObject(CCCallFuncN:create(var_3_2))

	local var_3_4 = CCSequence:create(var_3_3)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_4)
end
