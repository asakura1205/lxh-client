require("gamecore.skill.zbBaseSkill")

zbYumaoqiu_3 = class("zbYumaoqiu_3", zbBaseSkill)
zbYumaoqiu_3.__index = zbYumaoqiu_3

function zbYumaoqiu_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbYumaoqiu_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbYumaoqiu_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Random_1
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hero.ymqSkill3 = arg_2_0
	arg_2_0.hitFrame = 0.3333333333333333
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbYumaoqiu_3.actionEx(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
	end

	local function var_3_1()
		arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

		for iter_5_0, iter_5_1 in pairs(arg_3_0.targetList) do
			local var_5_0 = BUFF_TYPE_PROPERTY_DAMAMGE_DEFEND_PHYSICMAGIC
			local var_5_1 = 0.2
			local var_5_2 = arg_3_0:getDamageAbs()
			local var_5_3 = 2

			g_BuffSystem:createBuff(arg_3_0.hero, iter_5_1, var_5_0, var_5_1, var_5_2, var_5_3)
			g_EffectSystem:createInstantEffect(iter_5_1, arg_3_0.skillRecord.riseEffectId)
			g_EffectSystem:createInstantEffect(iter_5_1, arg_3_0.skillRecord.targetEffectId)
		end
	end

	arg_3_1:addObject(CCCallFuncN:create(var_3_0))
	arg_3_1:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	arg_3_1:addObject(CCCallFuncN:create(var_3_1))
	arg_3_1:addObject(CCDelayTime:create(arg_3_0.skillDurationTime - arg_3_0.hitFrame))
end
