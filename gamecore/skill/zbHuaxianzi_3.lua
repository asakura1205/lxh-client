require("gamecore.skill.zbBaseSkill")

zbHuaxianzi_3 = class("zbHuaxianzi_3", zbBaseSkill)
zbHuaxianzi_3.__index = zbHuaxianzi_3

function zbHuaxianzi_3.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbHuaxianzi_3.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbHuaxianzi_3.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Random_1
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.sequenceName = ANIMATION_SEQUENCE_SHOW
	arg_2_0.hitFrame = 0.8333333333333334
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.hero.huaxianziSkill3 = arg_2_0
end

function zbHuaxianzi_3.actionEx(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_1()
		arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

		for iter_5_0, iter_5_1 in pairs(arg_3_0.targetList) do
			local var_5_0 = BUFF_TYPE_PROPERTY_DAMAMGE_DEFEND_PHYSIC
			local var_5_1 = 0.2
			local var_5_2 = arg_3_0:getDamageAbs()
			local var_5_3 = 2

			g_BuffSystem:createBuff(arg_3_0.hero, arg_3_0.hero, var_5_0, var_5_1, var_5_2, var_5_3, 0)
		end
	end

	arg_3_1:addObject(CCCallFuncN:create(var_3_0))
	arg_3_1:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	arg_3_1:addObject(CCCallFuncN:create(var_3_1))
	arg_3_1:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame, 0.1)))
end
