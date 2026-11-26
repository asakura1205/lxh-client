require("gamecore.skill.zbBaseSkill")

zbHuangshou_0 = class("zbHuangshou_0", zbBaseSkill)
zbHuangshou_0.__index = zbHuangshou_0

function zbHuangshou_0.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbHuangshou_0.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbHuangshou_0.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Condition_MinHpPercent
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 0.36666666666666664
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.skill4Enable = false
end

function zbHuangshou_0.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
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
	arg_3_0.skill4Enable = arg_3_0.hero.huangshouSkill4 ~= nil and arg_3_0.hero.huangshouSkill4:isCanTrigger()
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.getn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_4 = CCArray:create()

	var_3_4:addObject(CCCallFuncN:create(var_3_0))
	var_3_4:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	var_3_4:addObject(CCCallFuncN:create(var_3_1))
	var_3_4:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame, 0.1)))
	var_3_4:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_3_0.hero:getFixPosition()))
	var_3_4:addObject(CCCallFuncN:create(var_3_2))
	var_3_4:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_4:addObject(CCCallFuncN:create(var_3_3))

	local var_3_5 = CCSequence:create(var_3_4)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_5)
end

function zbHuangshou_0.update(arg_8_0, arg_8_1)
	arg_8_0.accumTime = arg_8_0.accumTime + arg_8_1

	if arg_8_0.accumTime > 3 then
		arg_8_0.actioning = false
	end
end

function zbHuangshou_0.hited(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_0.actioning then
		arg_9_0.actioning = false

		if arg_9_0:isQteRedoing() == false then
			if arg_9_2 == false and arg_9_0.hero.huangshouSkill3 ~= nil then
				arg_9_0.hero.huangshouSkill3:actionEx(arg_9_1)
			end

			if arg_9_2 == false and arg_9_0.skill4Enable then
				arg_9_0.hero.huangshouSkill4:actionEx(arg_9_1, 0.8)
			end
		end
	end
end

function zbHuangshou_0.getDamageRatio(arg_10_0, arg_10_1)
	local var_10_0 = 1

	if arg_10_0.skill4Enable then
		var_10_0 = var_10_0 + arg_10_0.hero.huangshouSkill4:getDamageRatio()
	end

	return var_10_0
end

function zbHuangshou_0.getDamageAbs(arg_11_0)
	local var_11_0 = arg_11_0:getDamageAbsBase()

	if arg_11_0.skill4Enable then
		var_11_0 = var_11_0 + arg_11_0.hero.huangshouSkill4:getDamageAbs()
	end

	return var_11_0
end
