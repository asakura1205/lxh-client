require("gamecore.skill.zbBaseSkill")

zbMaozha_4 = class("zbMaozha_4", zbBaseSkill)
zbMaozha_4.__index = zbMaozha_4

function zbMaozha_4.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbMaozha_4.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbMaozha_4.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Random_1
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hero.maozha4Skill = arg_2_0
end

function zbMaozha_4.actionEx(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0.hero.anim:setAnimation(ANIMATION_SEQUENCE_MOVE, false)
		arg_3_0:popupSkillBubble()

		arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

		for iter_4_0, iter_4_1 in pairs(arg_3_0.targetList) do
			local var_4_0 = BUFF_TYPE_PROPERTY_DAMAMGE_PHYSIC
			local var_4_1 = 0.2
			local var_4_2 = arg_3_0:getDamageAbs()
			local var_4_3 = 1

			g_BuffSystem:createBuff(arg_3_0.hero, iter_4_1, var_4_0, var_4_1, var_4_2, var_4_3)
		end
	end

	arg_3_1:addObject(CCCallFuncN:create(var_3_0))
	arg_3_1:addObject(CCDelayTime:create(0.43333333333333335))
end
