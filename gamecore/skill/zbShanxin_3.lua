require("gamecore.skill.zbBaseSkill")

zbShanxin_3 = class("zbShanxin_3", zbBaseSkill)
zbShanxin_3.__index = zbShanxin_3

function zbShanxin_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbShanxin_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbShanxin_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hero.shanxin3Skill = arg_2_0
end

function zbShanxin_3.actionEx(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0:popupSkillBubble()

		local var_4_0 = g_CombatSystem:getHeros(getFlipForceType(arg_3_0.hero.forceType), true)
		local var_4_1 = BUFF_TYPE_PROPERTY_VIOLENT
		local var_4_2 = arg_3_0.hero.baseViolent * 0.1 * table.getn(var_4_0) + arg_3_0:getDamageAbs() * table.getn(var_4_0)
		local var_4_3 = 0
		local var_4_4 = 2

		g_BuffSystem:createBuff(arg_3_0.hero, arg_3_0.hero, var_4_1, var_4_2, var_4_3, var_4_4)
	end

	arg_3_1:addObject(CCCallFuncN:create(var_3_0))
end
