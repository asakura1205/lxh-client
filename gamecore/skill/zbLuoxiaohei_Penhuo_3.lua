require("gamecore.skill.zbBaseSkill")

zbLuoxiaohei_Penhuo_3 = class("zbLuoxiaohei_Penhuo_3", zbBaseSkill)
zbLuoxiaohei_Penhuo_3.__index = zbLuoxiaohei_Penhuo_3

function zbLuoxiaohei_Penhuo_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbLuoxiaohei_Penhuo_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbLuoxiaohei_Penhuo_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hero.luoxiaohei2Skill3 = arg_2_0
end

function zbLuoxiaohei_Penhuo_3.actionEx(arg_3_0)
	arg_3_0:popupSkillBubble()
	arg_3_0.hero:addMp(10)
	g_CombatBubble:showBubble(arg_3_0.hero, ECombatBubble.MpUp, 0, 0, 1)

	local var_3_0 = BUFF_TYPE_PROPERTY_DAMAMGE_MAGIC
	local var_3_1 = 0.2
	local var_3_2 = arg_3_0:getDamageAbs()
	local var_3_3 = 2

	g_BuffSystem:createBuff(arg_3_0.hero, arg_3_0.hero, var_3_0, var_3_1, var_3_2, var_3_3, 0.5)
end
