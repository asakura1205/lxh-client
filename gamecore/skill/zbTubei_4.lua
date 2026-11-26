require("gamecore.skill.zbBaseNormalAttack")

zbTubei_4 = class("zbTubei_4", zbBaseSkill)
zbTubei_4.__index = zbTubei_4

function zbTubei_4.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbTubei_4.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbTubei_4.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 0.6
	arg_2_0.sequenceName = ANIMATION_SEQUENCE_WIN
	arg_2_0.skillDurationTime = 1.3333333333333333
	arg_2_0.hero.tubeiSkill4 = arg_2_0
end

function zbTubei_4.actionEx(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_1()
		local var_5_0 = BUFF_TYPE_PROPERTY_DAMAMGE_DEFEND_PHYSIC

		if zbCombatFormula:isSucceedRate(500) then
			var_5_0 = BUFF_TYPE_PROPERTY_DAMAMGE_DEFEND_MAGIC
		end

		local var_5_1 = 0.5
		local var_5_2 = arg_3_0:getDamageAbs()
		local var_5_3 = 2

		g_BuffSystem:createBuff(arg_3_0.hero, arg_3_0.hero, var_5_0, var_5_1, var_5_2, var_5_3)
	end

	arg_3_1:addObject(CCCallFuncN:create(var_3_0))
	arg_3_1:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	arg_3_1:addObject(CCCallFuncN:create(var_3_1))
	arg_3_1:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame, 0.1)))
end

function zbTubei_4.getDamageRatio(arg_6_0, arg_6_1)
	return 0.2
end
