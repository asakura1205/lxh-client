require("gamecore.skill.zbBaseSkill")

zbLaojun_3 = class("zbLaojun_3", zbBaseSkill)
zbLaojun_3.__index = zbLaojun_3

function zbLaojun_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbLaojun_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbLaojun_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Random_2
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.passiveTriggerType = EPassiveTriggerType.Beattacked
	arg_2_0.hitFrame = 0.9
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.lastTriggerRound = 0
	arg_2_0.lastRoundAccumCount = 0
	arg_2_0.hero.laojunSkill3 = arg_2_0
end

function zbLaojun_3.action(arg_3_0)
	if arg_3_0.lastTriggerRound == g_CombatRound:getCurRound() then
		if arg_3_0.lastRoundAccumCount < 3 then
			arg_3_0.lastRoundAccumCount = arg_3_0.lastRoundAccumCount + 1

			arg_3_0.hero.energy:addCount()
			arg_3_0:popupSkillBubble()
		end
	else
		arg_3_0.lastRoundAccumCount = 0
		arg_3_0.lastRoundAccumCount = arg_3_0.lastRoundAccumCount + 1

		arg_3_0.hero.energy:addCount()
		arg_3_0:popupSkillBubble()
	end

	arg_3_0.lastTriggerRound = g_CombatRound:getCurRound()
end

function zbLaojun_3.actionEx(arg_4_0, arg_4_1)
	if arg_4_0.hero.energy:getCount() < 5 then
		return
	end

	local function var_4_0()
		arg_4_0:popupSkillBubble()
		arg_4_0.hero.anim:setAnimation(arg_4_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_4_0.hero, arg_4_0.skillRecord.riseEffectId)
	end

	local function var_4_1()
		arg_4_0.hero.energy:clearCount()

		local var_6_0 = zbTargetHandler:selectTarget(arg_4_0.hero, arg_4_0, arg_4_0:getSideType(), arg_4_0:getTargetType(), arg_4_0:getSubTargetType())

		for iter_6_0, iter_6_1 in pairs(var_6_0) do
			g_EffectSystem:createInstantEffect(iter_6_1, arg_4_0.skillRecord.targetEffectId)
			g_CombatFormulaCure:calcCure(arg_4_0.hero, iter_6_1, arg_4_0)
		end
	end

	arg_4_1:addObject(CCCallFuncN:create(var_4_0))
	arg_4_1:addObject(CCDelayTime:create(arg_4_0.hitFrame))
	arg_4_1:addObject(CCCallFuncN:create(var_4_1))
	arg_4_1:addObject(CCDelayTime:create(math.max(arg_4_0.skillDurationTime - arg_4_0.hitFrame, 0.1)))
end

function zbLaojun_3.getDamageRatio(arg_7_0, arg_7_1)
	return 0.4
end
