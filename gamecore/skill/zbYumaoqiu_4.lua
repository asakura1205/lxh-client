require("gamecore.skill.zbBaseSkill")

zbYumaoqiu_4 = class("zbYumaoqiu_4", zbBaseSkill)
zbYumaoqiu_4.__index = zbYumaoqiu_4

function zbYumaoqiu_4.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbYumaoqiu_4.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbYumaoqiu_4.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hero.ymqSkill4 = arg_2_0
end

function zbYumaoqiu_4.action(arg_3_0)
	return
end

function zbYumaoqiu_4.actionEx(arg_4_0, arg_4_1)
	local var_4_0 = BUFF_TYPE_PROPERTY_DAMAMGE_DEFEND_PHYSICMAGIC
	local var_4_1 = -0.2
	local var_4_2 = -arg_4_0:getDamageAbs()
	local var_4_3 = 2

	arg_4_0:popupSkillBubble()
	g_BuffSystem:createBuff(arg_4_0.hero, arg_4_1, var_4_0, var_4_1, var_4_2, var_4_3, 0.25)
end
