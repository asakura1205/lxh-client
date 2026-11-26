require("gamecore.skill.zbBaseSkill")

zbDaji_3 = class("zbDaji_3", zbBaseSkill)
zbDaji_3.__index = zbDaji_3

function zbDaji_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbDaji_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbDaji_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hero.dajiSkill3 = arg_2_0
end

function zbDaji_3.actionEx(arg_3_0, arg_3_1, arg_3_2)
	if zbCombatFormula:isSucceedRate(500) == false then
		return
	end

	if arg_3_2 == nil then
		arg_3_2 = 0
	end

	local var_3_0 = BUFF_TYPE_PROPERTY_DAMAMGE_DEFEND_PHYSICMAGIC
	local var_3_1 = -0.4
	local var_3_2 = -arg_3_0:getDamageAbs()
	local var_3_3 = 2

	arg_3_0:popupSkillBubble(arg_3_2)
	g_BuffSystem:createBuff(arg_3_0.hero, arg_3_1, var_3_0, var_3_1, var_3_2, var_3_3, arg_3_2)
end
