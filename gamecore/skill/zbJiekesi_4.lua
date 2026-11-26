require("gamecore.skill.zbBaseSkill")

zbJiekesi_4 = class("zbJiekesi_4", zbBaseSkill)
zbJiekesi_4.__index = zbJiekesi_4

function zbJiekesi_4.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbJiekesi_4.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbJiekesi_4.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Random_5
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 0.43333333333333335
	arg_2_0.attackHitDelayTime = 0.3333333333333333
	arg_2_0.sequenceName = ANIMATION_SEQUENCE_SKILL3
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.hero.jiekesiSkill4 = arg_2_0
	arg_2_0.triggered = false
end

function zbJiekesi_4.action(arg_3_0)
	arg_3_0.triggered = false
end

function zbJiekesi_4.actionEx(arg_4_0, arg_4_1)
	local function var_4_0()
		arg_4_0.hero.anim:setAnimation(arg_4_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_4_0.hero, arg_4_0.skillRecord.riseEffectId)
	end

	local function var_4_1()
		local var_6_0 = arg_4_0.targetList[1].forceType
		local var_6_1 = getCombatHeroPos(var_6_0, 5)
		local var_6_2 = g_EffectSystem:createBombEffect(arg_4_0.hero, var_6_0, var_6_1, arg_4_0.skillRecord.targetEffectId, 0)

		if var_6_2 ~= nil then
			var_6_2:setRotationY(var_6_2:getRotationY() + 180)
			var_6_2:setPositionY(var_6_2:getPositionY() - 30)
		end
	end

	local function var_4_2()
		for iter_7_0, iter_7_1 in pairs(arg_4_0.targetList) do
			local var_7_0, var_7_1, var_7_2 = g_CombatFormula:calcDamage(arg_4_0.hero, iter_7_1, arg_4_0)

			if var_7_1 > 0 then
				iter_7_1:playBehitAnimation(arg_4_0.skillRecord.hitEffectId, arg_4_0)
			end
		end
	end

	arg_4_0.targetList = zbTargetHandler:selectTarget(arg_4_0.hero, arg_4_0, arg_4_0:getSideType(), arg_4_0:getTargetType(), arg_4_0:getSubTargetType())

	if table.maxn(arg_4_0.targetList) == 0 then
		return
	end

	if arg_4_0.triggered then
		return
	end

	arg_4_0.triggered = true
	arg_4_0.actioning = true

	arg_4_1:addObject(CCCallFuncN:create(var_4_0))
	arg_4_1:addObject(CCDelayTime:create(arg_4_0.hitFrame))
	arg_4_1:addObject(CCCallFuncN:create(var_4_1))
	arg_4_1:addObject(CCDelayTime:create(arg_4_0.attackHitDelayTime))
	arg_4_1:addObject(CCCallFuncN:create(var_4_2))
	arg_4_1:addObject(CCDelayTime:create(math.max(arg_4_0.skillDurationTime - arg_4_0.hitFrame - arg_4_0.attackHitDelayTime, 0.1)))
end

function zbJiekesi_4.getDamageRatio(arg_8_0, arg_8_1)
	return 0.35
end
