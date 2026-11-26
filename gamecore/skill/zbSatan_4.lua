require("gamecore.skill.zbBaseSkill")

zbSatan_4 = class("zbSatan_4", zbBaseSkill)
zbSatan_4.__index = zbSatan_4

function zbSatan_4.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbSatan_4.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbSatan_4.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hero.satanSkill4 = arg_2_0
end

function zbSatan_4.actionEx(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero:addHp(arg_3_0.hero.maxHp * 0.05 + arg_3_0:getDamageAbs(), false, 1)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, 2001)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, 2002)
	end

	local function var_3_1()
		return
	end

	if zbCombatFormula:isSucceedRate(300) == false then
		return
	end

	arg_3_1:addObject(CCCallFuncN:create(var_3_0))
	arg_3_1:addObject(CCDelayTime:create(0.3333333333333333))
	arg_3_1:addObject(CCCallFuncN:create(var_3_1))
end
