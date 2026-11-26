require("gamecore.skill.zbBaseSkill")

zbQiguo_3 = class("zbQiguo_3", zbBaseSkill)
zbQiguo_3.__index = zbQiguo_3

function zbQiguo_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbQiguo_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbQiguo_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 0.6333333333333333
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.hero.qiguoSkill3 = arg_2_0
end

function zbQiguo_3.actionEx(arg_3_0, arg_3_1)
	local var_3_0 = BUFF_TYPE_PROPERTY_DAMAMGE_DEFEND_PHYSICMAGIC
	local var_3_1 = -0.2
	local var_3_2 = -arg_3_0:getDamageAbs()
	local var_3_3 = 2

	g_BuffSystem:createBuff(arg_3_0.hero, arg_3_1, var_3_0, var_3_1, var_3_2, var_3_3, 0)
end
