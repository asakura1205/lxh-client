require("gamecore.skill.zbBaseSkill")

zbLaojun_4 = class("zbLaojun_4", zbBaseSkill)
zbLaojun_4.__index = zbLaojun_4

function zbLaojun_4.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbLaojun_4.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbLaojun_4.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Random_1
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hero.laojunSkill4 = arg_2_0
	arg_2_0.hitFrame = 0.8333333333333334
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbLaojun_4.actionEx(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_1()
		arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

		for iter_5_0, iter_5_1 in pairs(arg_3_0.targetList) do
			g_EffectSystem:createInstantEffect(iter_5_1, arg_3_0.skillRecord.targetEffectId)

			local var_5_0 = BUFF_TYPE_PROPERTY_DAMAMGE_PHYSICMAGIC
			local var_5_1 = 0.2
			local var_5_2 = arg_3_0:getDamageAbs()
			local var_5_3 = 1

			g_BuffSystem:createBuff(arg_3_0.hero, iter_5_1, var_5_0, var_5_1, var_5_2, var_5_3)
		end
	end

	arg_3_1:addObject(CCCallFuncN:create(var_3_0))
	arg_3_1:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	arg_3_1:addObject(CCCallFuncN:create(var_3_1))
	arg_3_1:addObject(CCDelayTime:create(arg_3_0.skillDurationTime - arg_3_0.hitFrame))
end
