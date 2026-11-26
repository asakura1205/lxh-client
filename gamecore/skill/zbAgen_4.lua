require("gamecore.skill.zbBaseSkill")

zbAgen_4 = class("zbAgen_4", zbBaseSkill)
zbAgen_4.__index = zbAgen_4

function zbAgen_4.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbAgen_4.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbAgen_4.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Random_5
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.passiveTriggerType = EPassiveTriggerType.Beattacked
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.triggered = false

	arg_2_0.hero:addPMReduceRate(0.3)
	arg_2_0.hero:addPMReduceRatio(0.3)
	arg_2_0.hero:addPMReduce(arg_2_0:getDamageAbs())

	arg_2_0.hero.pmReduceSkill = arg_2_0
end

function zbAgen_4.action(arg_3_0)
	if zbCombatFormula:isSucceedRate(300) == false then
		return
	end

	arg_3_0.actioning = false

	arg_3_0:popupSkillBubble()

	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	for iter_3_0, iter_3_1 in pairs(arg_3_0.targetList) do
		iter_3_1:addMp(10)
		g_CombatBubble:showBubble(iter_3_1, ECombatBubble.MpUp, 0, 0, 1)
	end

	if arg_3_0.hero:numberOfRunningActions() <= 0 then
		arg_3_0.actioning = true

		local function var_3_0()
			arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
			g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
		end

		local function var_3_1()
			arg_3_0:enterIdle()
		end

		local function var_3_2()
			arg_3_0.actioning = false
		end

		local var_3_3 = CCArray:create()

		var_3_3:addObject(CCCallFuncN:create(var_3_0))
		var_3_3:addObject(CCDelayTime:create(arg_3_0.skillDurationTime))
		var_3_3:addObject(CCCallFuncN:create(var_3_1))
		var_3_3:addObject(CCCallFuncN:create(var_3_2))

		local var_3_4 = CCSequence:create(var_3_3)

		arg_3_0.hero:stopAllActions()
		arg_3_0.hero:runAction(var_3_4)
	else
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end
end
