require("gamecore.skill.zbBaseSkill")

zbLuoxiaohei_bangqiu_4 = class("zbLuoxiaohei_bangqiu_4", zbBaseSkill)
zbLuoxiaohei_bangqiu_4.__index = zbLuoxiaohei_bangqiu_4

function zbLuoxiaohei_bangqiu_4.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbLuoxiaohei_bangqiu_4.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbLuoxiaohei_bangqiu_4.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 0.3333333333333333
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.hero.lxhbqSkill4 = arg_2_0
end

function zbLuoxiaohei_bangqiu_4.actionEx(arg_3_0, arg_3_1)
	if arg_3_0.hero.energy:getCount() >= 5 then
		return
	end

	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_1()
		if arg_3_0.hero.energy:getCount() < 5 then
			arg_3_0.hero.energy:addCount()
			arg_3_0.hero:addExtraPhysicDamageDefendRatio(0.1)
			arg_3_0.hero:addExtraPhysicDamageDefendAbs(arg_3_0:getDamageAbs())
			g_CombatBubble:showBubble(arg_3_0.hero, ECombatBubble.PhysicDefendUp, 0, 0, 1)
		end
	end

	arg_3_1:addObject(CCCallFuncN:create(var_3_0))
	arg_3_1:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	arg_3_1:addObject(CCCallFuncN:create(var_3_1))
	arg_3_1:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame, 0.1)))
end
