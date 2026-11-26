require("gamecore.skill.zbBaseSkill")

zbLuoxiaoheiRX_4 = class("zbLuoxiaoheiRX_4", zbBaseSkill)
zbLuoxiaoheiRX_4.__index = zbLuoxiaoheiRX_4

function zbLuoxiaoheiRX_4.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbLuoxiaoheiRX_4.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbLuoxiaoheiRX_4.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.sequenceName = ANIMATION_SEQUENCE_SKILL4
	arg_2_0.hitFrame = 0.6333333333333333
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.lastDiedCount = 0
	arg_2_0.hero.lxhrxSkill4 = arg_2_0
end

function zbLuoxiaoheiRX_4.actionEx(arg_3_0, arg_3_1)
	if g_FirstCombat:isActive() then
		return
	end

	if arg_3_0.lastDiedCount >= 4 then
		return
	end

	local var_3_0 = math.min(g_CombatSystem:getHeroDiedCount(arg_3_0.hero.forceType), 4)
	local var_3_1 = 0

	if var_3_0 > arg_3_0.lastDiedCount then
		arg_3_0.lastDiedCount = var_3_0
		var_3_1 = var_3_0 - arg_3_0.lastDiedCount
	end

	if var_3_1 <= 0 then
		return
	end

	local function var_3_2()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
		arg_3_0.hero:addExtraPhysicDamageRatio(0.1 * var_3_1)
		arg_3_0.hero:addExtraPhysicDamageRatio(arg_3_0:getDamageAbs() * var_3_1)
		g_CombatBubble:showBubble(arg_3_0.hero, ECombatBubble.PhysicAttackUp, 0, 0, 0.8)
	end

	arg_3_1:addObject(CCCallFuncN:create(var_3_2))
	arg_3_1:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	arg_3_1:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame, 0.1)))
end
