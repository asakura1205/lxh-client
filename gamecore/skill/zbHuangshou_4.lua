require("gamecore.skill.zbBaseSkill")

zbHuangshou_4 = class("zbHuangshou_4", zbBaseSkill)
zbHuangshou_4.__index = zbHuangshou_4

function zbHuangshou_4.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbHuangshou_4.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbHuangshou_4.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hero.huangshouSkill4 = arg_2_0
end

function zbHuangshou_4.actionEx(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_2 == nil then
		arg_3_2 = 0
	end

	arg_3_0:popupSkillBubble(arg_3_2)
	g_BuffSystem:createControlBuff(arg_3_0.hero, arg_3_1, BUFF_TYPE_CONTROL_MEIHUO, arg_3_2)
end

function zbHuangshou_4.isCanTrigger(arg_4_0)
	return zbCombatFormula:isSucceedRate(300)
end
