require("gamecore.skill.zbBaseSkill")

zbWuxian_0 = class("zbWuxian_0", zbBaseSkill)
zbWuxian_0.__index = zbWuxian_0

function zbWuxian_0.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbWuxian_0.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbWuxian_0.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Default
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 0.5
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.accumTime = 0
	arg_2_0.hitIndex = 0
	arg_2_0.hitCount = 0
	arg_2_0.killRedo = false
	arg_2_0.hero.wuxianSkill0 = arg_2_0
end

function zbWuxian_0.action(arg_3_0)
	arg_3_0.killRedo = false
	arg_3_0.sideType = ESideType.Enemy
	arg_3_0.targetType = ETargetType.Default
	arg_3_0.subTargetType = ESubTargetType.All

	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:playAnimationOnce(arg_3_0.sequenceName, arg_3_0.hero:getIdleWeakSequence(), 0.125)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_1()
		for iter_5_0, iter_5_1 in pairs(arg_3_0.targetList) do
			g_EffectSystem:createMissileEffect(arg_3_0.hero, iter_5_1, arg_3_0)
		end
	end

	local function var_3_2()
		arg_3_0:enterIdle()
	end

	local function var_3_3()
		return
	end

	arg_3_0.actioning = true
	arg_3_0.accumTime = 0
	arg_3_0.hitIndex = 0
	arg_3_0.hitCount = 1
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.getn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_4 = CCArray:create()

	var_3_4:addObject(CCCallFuncN:create(var_3_0))
	var_3_4:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	var_3_4:addObject(CCCallFuncN:create(var_3_1))

	local var_3_5 = 0
	local var_3_6 = 0.3333333333333333

	if arg_3_0:isQteRedoing() == false then
		for iter_3_0 = 1, 4 do
			if zbCombatFormula:isSucceedRate(300) then
				var_3_4:addObject(CCDelayTime:create(var_3_6))
				var_3_4:addObject(CCCallFuncN:create(var_3_1))

				var_3_5 = var_3_5 + var_3_6
				arg_3_0.hitCount = arg_3_0.hitCount + 1
			else
				break
			end
		end
	end

	var_3_4:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame - var_3_5, 0.1)))
	var_3_4:addObject(CCCallFuncN:create(var_3_2))
	var_3_4:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_4:addObject(CCCallFuncN:create(var_3_3))

	local var_3_7 = CCSequence:create(var_3_4)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_7)
end

function zbWuxian_0.actionKillTarget(arg_8_0, arg_8_1)
	arg_8_0.killRedo = true
	arg_8_0.sideType = ESideType.Enemy
	arg_8_0.targetType = ETargetType.Condition_MinHpPercent
	arg_8_0.subTargetType = ESubTargetType.All

	local function var_8_0()
		arg_8_0:popupSkillBubble()
		arg_8_0.hero.anim:playAnimationOnce(arg_8_0.sequenceName, arg_8_0.hero:getIdleWeakSequence(), 0.125)
		g_EffectSystem:createInstantEffect(arg_8_0.hero, arg_8_0.skillRecord.riseEffectId)
	end

	local function var_8_1()
		for iter_10_0, iter_10_1 in pairs(arg_8_0.targetList) do
			g_EffectSystem:createMissileEffect(arg_8_0.hero, iter_10_1, arg_8_0)
		end
	end

	local function var_8_2()
		arg_8_0:enterIdle()
	end

	local function var_8_3()
		return
	end

	arg_8_0.actioning = true
	arg_8_0.accumTime = 0
	arg_8_0.hitIndex = 0
	arg_8_0.hitCount = 1
	arg_8_0.targetList = zbTargetHandler:selectTarget(arg_8_0.hero, arg_8_0, arg_8_0:getSideType(), arg_8_0:getTargetType(), arg_8_0:getSubTargetType())

	if table.getn(arg_8_0.targetList) == 0 then
		arg_8_0.actioning = false

		return
	end

	local var_8_4 = CCArray:create()

	var_8_4:addObject(CCCallFuncN:create(var_8_0))
	var_8_4:addObject(CCDelayTime:create(arg_8_0.hitFrame))
	var_8_4:addObject(CCCallFuncN:create(var_8_1))
	var_8_4:addObject(CCDelayTime:create(math.max(arg_8_0.skillDurationTime - arg_8_0.hitFrame, 0.1)))
	var_8_4:addObject(CCCallFuncN:create(var_8_2))
	var_8_4:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_8_4:addObject(CCCallFuncN:create(var_8_3))

	local var_8_5 = CCSequence:create(var_8_4)

	arg_8_0.hero:stopAllActions()
	arg_8_0.hero:runAction(var_8_5)
end

function zbWuxian_0.update(arg_13_0, arg_13_1)
	arg_13_0.accumTime = arg_13_0.accumTime + arg_13_1

	if arg_13_0.accumTime > 3 then
		arg_13_0.actioning = false
	end
end

function zbWuxian_0.hited(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if arg_14_0.killRedo == false then
		arg_14_0.hitIndex = arg_14_0.hitIndex + 1

		if arg_14_0.hitIndex >= arg_14_0.hitCount then
			arg_14_0.actioning = false
		end

		if arg_14_2 and arg_14_0.hero.wuxianSkill3 ~= nil then
			arg_14_0.hero.wuxianSkill3:actionKillTarget()
		end
	else
		arg_14_0.actioning = false

		if arg_14_0.hero.wuxianSkill3 ~= nil then
			arg_14_0.hero.wuxianSkill3:actionKillTarget()
		end
	end
end

function zbWuxian_0.getDamageRatio(arg_15_0, arg_15_1)
	local var_15_0 = 0.8

	if arg_15_0.hitIndex > 0 then
		var_15_0 = var_15_0 * 0.5
	end

	if arg_15_0.hero.wuxianSkill4 ~= nil then
		var_15_0 = var_15_0 + arg_15_0.hero.wuxianSkill4:getDamageRatio(arg_15_1)
	end

	return var_15_0
end

function zbWuxian_0.getDamageAbs(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:getDamageAbsBase()

	if arg_16_0.hitIndex > 0 then
		var_16_0 = var_16_0 * 0.5
	end

	if arg_16_0.hero.wuxianSkill4 ~= nil then
		var_16_0 = var_16_0 + arg_16_0.hero.wuxianSkill4:getDamageAbs(arg_16_1)
	end

	return var_16_0
end
