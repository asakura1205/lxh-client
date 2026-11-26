require("gamecore.skill.zbBaseSkill")

zbWuxian_2 = class("zbWuxian_2", zbBaseSkill)
zbWuxian_2.__index = zbWuxian_2

function zbWuxian_2.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbWuxian_2.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbWuxian_2.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Condition_MinHpPercent
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 0.5666666666666667
	arg_2_0.sequenceName = ANIMATION_SEQUENCE_SKILL2
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.damageSectionCount = 4
	arg_2_0.hitFrame1 = 0.5666666666666667
	arg_2_0.hitFrame2 = 0.8333333333333334
	arg_2_0.hitFrame3 = 1.1
	arg_2_0.hitFrame4 = 1.3333333333333333
	arg_2_0.hitFrame5 = 1.8333333333333333
	arg_2_0.accumTime = 0
	arg_2_0.killTargeted = false
	arg_2_0.hitIndex = 0
	arg_2_0.hero.wuxianSkill2 = arg_2_0
end

function zbWuxian_2.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:playAnimationOnce(arg_3_0.sequenceName, arg_3_0.hero:getIdleWeakSequence(), 0.125)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_1()
		arg_3_0.skillRecord.hitEffectId = 1015023

		for iter_5_0, iter_5_1 in pairs(arg_3_0.targetList) do
			g_EffectSystem:createMissileEffect(arg_3_0.hero, iter_5_1, arg_3_0)
		end
	end

	local function var_3_2()
		arg_3_0.skillRecord.hitEffectId = 0

		for iter_6_0, iter_6_1 in pairs(arg_3_0.targetList) do
			g_EffectSystem:createMissileEffect(arg_3_0.hero, iter_6_1, arg_3_0)
		end
	end

	local function var_3_3()
		arg_3_0:enterIdle()
	end

	local function var_3_4()
		return
	end

	arg_3_0.hitIndex = 0
	arg_3_0.accumTime = 0
	arg_3_0.killTargeted = false
	arg_3_0.actioning = true
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.getn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_5 = CCArray:create()

	var_3_5:addObject(CCCallFuncN:create(var_3_0))
	var_3_5:addObject(CCDelayTime:create(arg_3_0.hitFrame1))
	var_3_5:addObject(CCCallFuncN:create(var_3_1))
	var_3_5:addObject(CCDelayTime:create(arg_3_0.hitFrame2 - arg_3_0.hitFrame1))
	var_3_5:addObject(CCCallFuncN:create(var_3_2))
	var_3_5:addObject(CCDelayTime:create(arg_3_0.hitFrame3 - arg_3_0.hitFrame2))
	var_3_5:addObject(CCCallFuncN:create(var_3_2))
	var_3_5:addObject(CCDelayTime:create(arg_3_0.hitFrame4 - arg_3_0.hitFrame3))
	var_3_5:addObject(CCCallFuncN:create(var_3_2))
	var_3_5:addObject(CCDelayTime:create(arg_3_0.hitFrame5 - arg_3_0.hitFrame4))
	var_3_5:addObject(CCCallFuncN:create(var_3_2))
	var_3_5:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame5, 0.5)))
	var_3_5:addObject(CCCallFuncN:create(var_3_3))
	var_3_5:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_5:addObject(CCCallFuncN:create(var_3_4))

	local var_3_6 = CCSequence:create(var_3_5)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_6)
end

function zbWuxian_2.update(arg_9_0, arg_9_1)
	arg_9_0.accumTime = arg_9_0.accumTime + arg_9_1

	if arg_9_0.hitIndex >= arg_9_0.damageSectionCount and arg_9_0.accumTime > 0.6 then
		arg_9_0.actioning = false
	end
end

function zbWuxian_2.hited(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0.hitIndex = arg_10_0.hitIndex + 1

	if arg_10_0.hitIndex >= arg_10_0.damageSectionCount then
		arg_10_0.accumTime = 0

		arg_10_1:addMp(-20)
		g_CombatBubble:showBubble(arg_10_1, ECombatBubble.MpDown, 0, 0, 1)
	end

	if arg_10_2 and arg_10_0.killTargeted == false then
		arg_10_0.killTargeted = arg_10_2

		if arg_10_0.hero.wuxianSkill0 ~= nil then
			arg_10_0.actioning = true

			arg_10_0.hero.wuxianSkill0:actionKillTarget(arg_10_0)
		end
	end
end

function zbWuxian_2.getDamageRatio(arg_11_0, arg_11_1)
	return 1.5
end
