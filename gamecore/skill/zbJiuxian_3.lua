require("gamecore.skill.zbBaseSkill")

zbJiuxian_3 = class("zbJiuxian_3", zbBaseSkill)
zbJiuxian_3.__index = zbJiuxian_3

function zbJiuxian_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbJiuxian_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbJiuxian_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 0.6333333333333333
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.hero.jiuxianSkill3 = arg_2_0
end

function zbJiuxian_3.actionEx(arg_3_0, arg_3_1)
	if zbCombatFormula:isSucceedRate(300) == false then
		return
	end

	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_1()
		local var_5_0 = BUFF_TYPE_PROPERTY_DAMAMGE_PHYSICMAGIC
		local var_5_1 = 0.7
		local var_5_2 = arg_3_0:getDamageAbs()
		local var_5_3 = 2

		g_BuffSystem:createBuff(arg_3_0.hero, arg_3_0.hero, var_5_0, var_5_1, var_5_2, var_5_3)
	end

	arg_3_1:addObject(CCCallFuncN:create(var_3_0))
	arg_3_1:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	arg_3_1:addObject(CCCallFuncN:create(var_3_1))
	arg_3_1:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame, 0.1)))
end
