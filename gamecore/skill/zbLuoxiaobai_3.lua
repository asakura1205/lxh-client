require("gamecore.skill.zbBaseSkill")

zbLuoxiaobai_3 = class("zbLuoxiaobai_3", zbBaseSkill)
zbLuoxiaobai_3.__index = zbLuoxiaobai_3

function zbLuoxiaobai_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbLuoxiaobai_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbLuoxiaobai_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hero.luoxiaobaiSkill3 = arg_2_0
end

function zbLuoxiaobai_3.actionEx(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:popupSkillBubble()
	arg_3_0.hero:addMp(10)
	arg_3_0.hero:addHp(arg_3_2 * 0.2 + arg_3_0:getDamageAbs(), false, 1)
	g_CombatBubble:showBubble(arg_3_0.hero, ECombatBubble.MpUp, 0, 0, 1)
end
