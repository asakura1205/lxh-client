require("gamecore.skill.zbBaseSkill")

zbFenmo_3 = class("zbFenmo_3", zbBaseSkill)
zbFenmo_3.__index = zbFenmo_3

function zbFenmo_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbFenmo_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbFenmo_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.passiveTriggerType = EPassiveTriggerType.Beattacked
	arg_2_0.hitFrame = 0.5666666666666667
	arg_2_0.sequenceName = ANIMATION_SEQUENCE_SHOW
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbFenmo_3.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_1()
		if arg_3_0.hero.lastAttacker ~= nil then
			g_BuffSystem:createFaliShield(arg_3_0.hero, arg_3_0.hero, arg_3_0.hero.physicAttack * 0.27 + arg_3_0:getDamageAbs(), EShieldEffectType.Lxh)
			g_BuffSystem:createControlBuff(arg_3_0.hero, arg_3_0.hero.lastAttacker, BUFF_TYPE_CONTROL_CHENMO)
		end
	end

	local function var_3_2()
		arg_3_0:enterIdle()
	end

	local function var_3_3()
		arg_3_0.actioning = false
	end

	if arg_3_0.hero.lastAttacker == nil or arg_3_0.hero:numberOfRunningActions() > 0 or zbCombatFormula:isSucceedRate(300) == false then
		arg_3_0.actioning = false

		return
	end

	arg_3_0.actioning = true

	local var_3_4 = CCArray:create()

	var_3_4:addObject(CCCallFuncN:create(var_3_0))
	var_3_4:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	var_3_4:addObject(CCCallFuncN:create(var_3_1))
	var_3_4:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame, 0.1)))
	var_3_4:addObject(CCCallFuncN:create(var_3_2))
	var_3_4:addObject(CCCallFuncN:create(var_3_3))

	local var_3_5 = CCSequence:create(var_3_4)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_5)
end
