require("gamecore.skill.zbBaseSkill")

zbLuoxiaohei_kongjun_3 = class("zbLuoxiaohei_kongjun_3", zbBaseSkill)
zbLuoxiaohei_kongjun_3.__index = zbLuoxiaohei_kongjun_3

function zbLuoxiaohei_kongjun_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbLuoxiaohei_kongjun_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbLuoxiaohei_kongjun_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hero.lxhkjSkill3 = arg_2_0
end

function zbLuoxiaohei_kongjun_3.actionEx(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
	end

	local function var_3_1()
		local var_5_0 = BUFF_TYPE_PROPERTY_DAMAMGE_PHYSIC
		local var_5_1 = 0.1 * arg_3_0.hero.energy.count
		local var_5_2 = arg_3_0:getDamageAbs() * arg_3_0.hero.energy.count
		local var_5_3 = 1

		g_BuffSystem:createBuff(arg_3_0.hero, arg_3_0.hero, var_5_0, var_5_1, var_5_2, var_5_3, 0.5)
	end

	if arg_3_0.hero.energy:getCount() < 1 then
		return
	end

	arg_3_1:addObject(CCCallFuncN:create(var_3_0))
	arg_3_1:addObject(CCCallFuncN:create(var_3_1))
	arg_3_1:addObject(CCDelayTime:create(0.16666666666666666))
end
