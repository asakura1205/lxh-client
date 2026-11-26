require("gamecore.skill.zbBaseSkill")

zbXiaoji_4 = class("zbXiaoji_4", zbBaseSkill)
zbXiaoji_4.__index = zbXiaoji_4

function zbXiaoji_4.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbXiaoji_4.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbXiaoji_4.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 0.5
	arg_2_0.sequenceName = ANIMATION_SEQUENCE_SHOW
	arg_2_0.skillDurationTime = 1.1333333333333333
	arg_2_0.hero.xiaojiSkill4 = arg_2_0
end

function zbXiaoji_4.actionEx(arg_3_0, arg_3_1)
	local var_3_0 = g_CombatSystem:getHeroDiedCount(arg_3_0.hero.forceType)

	if var_3_0 < 1 then
		return
	end

	local function var_3_1()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_2()
		local var_5_0 = BUFF_TYPE_PROPERTY_DAMAMGE_MAGIC
		local var_5_1 = 0.1 * var_3_0
		local var_5_2 = arg_3_0:getDamageAbs() * var_3_0
		local var_5_3 = 1

		g_BuffSystem:createBuff(arg_3_0.hero, arg_3_0.hero, var_5_0, var_5_1, var_5_2, var_5_3, 0)
	end

	arg_3_1:addObject(CCCallFuncN:create(var_3_1))
	arg_3_1:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	arg_3_1:addObject(CCCallFuncN:create(var_3_2))
	arg_3_1:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame, 0.1)))
end
