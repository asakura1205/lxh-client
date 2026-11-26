require("gamecore.skill.zbBaseSkill")

zbHuaxianzi_4 = class("zbHuaxianzi_4", zbBaseSkill)
zbHuaxianzi_4.__index = zbHuaxianzi_4

function zbHuaxianzi_4.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbHuaxianzi_4.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbHuaxianzi_4.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Self
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.passiveTriggerType = EPassiveTriggerType.InitShow
	arg_2_0.sequenceName = ANIMATION_SEQUENCE_SHOW
	arg_2_0.hitFrame = 0.8333333333333334
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.hero.huaxianziSkill4 = arg_2_0
	arg_2_0.initLiveCount = 0
	arg_2_0.lastLiveCount = arg_2_0.initLiveCount
end

function zbHuaxianzi_4.action(arg_3_0)
	arg_3_0.initLiveCount = g_CombatSystem:getLivedHeroCount(arg_3_0.hero.forceType)
	arg_3_0.lastLiveCount = arg_3_0.initLiveCount
end

function zbHuaxianzi_4.actionEx(arg_4_0, arg_4_1)
	local var_4_0 = g_CombatSystem:getLivedHeroCount(arg_4_0.hero.forceType)

	if arg_4_0.lastLiveCount == var_4_0 then
		return
	end

	arg_4_0.lastLiveCount = var_4_0

	if arg_4_0.initLiveCount - var_4_0 > 0 then
		return
	end

	local function var_4_1()
		arg_4_0:popupSkillBubble()
		arg_4_0.hero.anim:setAnimation(arg_4_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_4_0.hero, arg_4_0.skillRecord.riseEffectId)
	end

	local function var_4_2()
		local var_6_0 = BUFF_TYPE_PROPERTY_DAMAMGE_DEFEND_PHYSICMAGIC
		local var_6_1 = 0.1 * (arg_4_0.initLiveCount - var_4_0)
		local var_6_2 = arg_4_0:getDamageAbs() * (arg_4_0.initLiveCount - var_4_0)
		local var_6_3 = 2

		g_BuffSystem:createBuff(arg_4_0.hero, arg_4_0.hero, var_6_0, var_6_1, var_6_2, var_6_3, 0)
	end

	arg_4_1:addObject(CCCallFuncN:create(var_4_1))
	arg_4_1:addObject(CCDelayTime:create(arg_4_0.hitFrame))
	arg_4_1:addObject(CCCallFuncN:create(var_4_2))
	arg_4_1:addObject(CCDelayTime:create(math.max(arg_4_0.skillDurationTime - arg_4_0.hitFrame, 0.1)))
end
