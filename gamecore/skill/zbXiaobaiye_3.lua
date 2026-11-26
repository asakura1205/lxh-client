require("gamecore.skill.zbBaseSkill")

zbXiaobaiye_3 = class("zbXiaobaiye_3", zbBaseSkill)
zbXiaobaiye_3.__index = zbXiaobaiye_3

function zbXiaobaiye_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbXiaobaiye_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbXiaobaiye_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Condition_MinHpPercent
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 0.6
	arg_2_0.sequenceName = ANIMATION_SEQUENCE_SKILL3
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.hero.xiaobaiyeSkill3 = arg_2_0
end

function zbXiaobaiye_3.actionEx(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_1()
		arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

		for iter_5_0, iter_5_1 in pairs(arg_3_0.targetList) do
			arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
			g_CombatFormulaCure:calcCure(arg_3_0.hero, iter_5_1, arg_3_0)

			if iter_5_1:isSame(arg_3_0.hero) == false then
				g_EffectSystem:createInstantEffect(iter_5_1, 2001)
				g_EffectSystem:createInstantEffect(iter_5_1, 2002)
			end
		end
	end

	if zbCombatFormula:isSucceedRate(300) == false then
		return
	end

	arg_3_1:addObject(CCCallFuncN:create(var_3_0))
	arg_3_1:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	arg_3_1:addObject(CCCallFuncN:create(var_3_1))
	arg_3_1:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame + 0.23333333333333334, 0.1)))
end

function zbXiaobaiye_3.getDamageRatio(arg_6_0, arg_6_1)
	return 0.3
end
