require("gamecore.skill.zbBaseSkill")

zbLuoxiaohei_moli_4 = class("zbLuoxiaohei_moli_4", zbBaseSkill)
zbLuoxiaohei_moli_4.__index = zbLuoxiaohei_moli_4

function zbLuoxiaohei_moli_4.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbLuoxiaohei_moli_4.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbLuoxiaohei_moli_4.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.passiveTriggerType = EPassiveTriggerType.InitShow
	arg_2_0.hero.lxhMoliSkill4 = arg_2_0
end

function zbLuoxiaohei_moli_4.action(arg_3_0)
	arg_3_0:popupSkillBubble()
end

function zbLuoxiaohei_moli_4.actionTarget(arg_4_0, arg_4_1)
	if zbCombatFormula:isSucceedRate(200) then
		g_UseLoalong = true

		local var_4_0 = BUFF_TYPE_PROPERTY_DAMAMGE_DEFEND_PHYSICMAGIC
		local var_4_1 = -0.3
		local var_4_2 = 0
		local var_4_3 = 2

		g_BuffSystem:createBuff(arg_4_0.hero, arg_4_1, var_4_0, var_4_1, var_4_2, var_4_3, 0)

		g_UseLoalong = false
	end
end

function zbLuoxiaohei_moli_4.getDamageRatio(arg_5_0, arg_5_1)
	return 0.2
end
