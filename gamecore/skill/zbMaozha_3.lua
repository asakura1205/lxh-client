require("gamecore.skill.zbBaseSkill")

zbMaozha_3 = class("zbMaozha_3", zbBaseSkill)
zbMaozha_3.__index = zbMaozha_3

function zbMaozha_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbMaozha_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbMaozha_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hero.maozhaSkill3 = arg_2_0
end

function zbMaozha_3.action(arg_3_0)
	return
end

function zbMaozha_3.actionEx(arg_4_0, arg_4_1)
	if zbCombatFormula:isSucceedRate(300) == false then
		return
	end

	local var_4_0 = BUFF_TYPE_PROPERTY_DAMAMGE_DEFEND_PHYSIC
	local var_4_1 = -0.5
	local var_4_2 = -arg_4_0:getDamageAbs()
	local var_4_3 = 2

	arg_4_0:popupSkillBubble()
	g_BuffSystem:createBuff(arg_4_0.hero, arg_4_1, var_4_0, var_4_1, var_4_2, var_4_3, 0.25)
end
