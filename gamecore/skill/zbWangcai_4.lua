require("gamecore.skill.zbBaseSkill")

zbWangcai_4 = class("zbWangcai_4", zbBaseSkill)
zbWangcai_4.__index = zbWangcai_4

function zbWangcai_4.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbWangcai_4.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbWangcai_4.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hero.wangcaiSkill4 = arg_2_0
end

function zbWangcai_4.actionEx(arg_3_0)
	arg_3_0:popupSkillBubble()
	arg_3_0.hero.anim:setAnimation(ANIMATION_SEQUENCE_SKILL4, false)
	arg_3_0.hero:addHp(arg_3_0.hero.maxHp * 0.05 + arg_3_0:getDamageAbs(), false, 1)
end

function zbWangcai_4.isCanTrigger(arg_4_0)
	return zbCombatFormula:isSucceedRate(300)
end
