require("gamecore.skill.zbBaseSkill")

zbBobo_3 = class("zbBobo_3", zbBaseSkill)
zbBobo_3.__index = zbBobo_3

function zbBobo_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbBobo_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbBobo_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hero.boboSkill3 = arg_2_0
	arg_2_0.hitFrame = 0.5666666666666667
	arg_2_0.skillDurationTime = 1.2
end

function zbBobo_3.actionEx(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
	end

	local function var_3_1()
		local var_5_0 = g_CombatSystem:getLivedHeroCount(getFlipForceType(arg_3_0.hero.forceType))
		local var_5_1 = g_CombatSystem:getHeros(arg_3_0.hero.forceType, true)

		for iter_5_0, iter_5_1 in pairs(var_5_1) do
			g_EffectSystem:createInstantEffect(iter_5_1, 1093031)
			g_EffectSystem:createInstantEffect(iter_5_1, 1093032)

			local var_5_2 = BUFF_TYPE_PROPERTY_DAMAMGE_DEFEND_PHYSICMAGIC
			local var_5_3 = 0.05 * var_5_0
			local var_5_4 = arg_3_0:getDamageAbs() * var_5_0
			local var_5_5 = 2

			g_BuffSystem:createBuff(arg_3_0.hero, iter_5_1, var_5_2, var_5_3, var_5_4, var_5_5)
		end
	end

	arg_3_1:addObject(CCCallFuncN:create(var_3_0))
	arg_3_1:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	arg_3_1:addObject(CCCallFuncN:create(var_3_1))
	arg_3_1:addObject(CCDelayTime:create(arg_3_0.skillDurationTime - arg_3_0.hitFrame))
end
