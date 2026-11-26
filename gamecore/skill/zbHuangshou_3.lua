require("gamecore.skill.zbBaseSkill")

zbHuangshou_3 = class("zbHuangshou_3", zbBaseSkill)
zbHuangshou_3.__index = zbHuangshou_3

function zbHuangshou_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbHuangshou_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbHuangshou_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hero.huangshouSkill3 = arg_2_0
end

function zbHuangshou_3.actionEx(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_2 == nil then
		arg_3_2 = 0
	end

	arg_3_0:popupSkillBubble()

	local var_3_0 = BUFF_TYPE_PROPERTY_BLOCK
	local var_3_1 = -(arg_3_0.hero.baseBlock * 0.2 + arg_3_0:getDamageAbs())
	local var_3_2 = 0
	local var_3_3 = 2

	g_BuffSystem:createBuff(arg_3_0.hero, arg_3_1, var_3_0, var_3_1, var_3_2, var_3_3, arg_3_2)
end
