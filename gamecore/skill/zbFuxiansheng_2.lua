require("gamecore.skill.zbBaseSkill")

zbFuxiansheng_2 = class("zbFuxiansheng_2", zbBaseSkill)
zbFuxiansheng_2.__index = zbFuxiansheng_2

function zbFuxiansheng_2.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbFuxiansheng_2.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbFuxiansheng_2.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Random_5
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 1.4
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbFuxiansheng_2.action(arg_3_0)
	local function var_3_0()
		if arg_3_0.hero.fxsSkill3 == nil then
			return false
		end

		local var_4_0 = g_CombatSystem:getHeros(getFlipForceType(arg_3_0.hero.forceType), true)

		for iter_4_0, iter_4_1 in pairs(var_4_0) do
			if iter_4_1:isZhongshang() then
				return true
			end
		end

		return false
	end

	local function var_3_1()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(ANIMATION_SEQUENCE_WIN, false)
		arg_3_0.hero.fxsSkill3:popupSkillBubble()

		local var_5_0 = g_CombatSystem:getHeros(getFlipForceType(arg_3_0.hero.forceType), true)

		for iter_5_0, iter_5_1 in pairs(var_5_0) do
			if iter_5_1:isZhongshang() then
				g_BuffSystem:createControlBuff(arg_3_0.hero, iter_5_1, BUFF_TYPE_CONTROL_CHAOFENG)
			end
		end
	end

	local function var_3_2()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_3()
		local var_7_0 = getFlipForceType(arg_3_0.hero.forceType)
		local var_7_1 = getFormationRowCenterPos(var_7_0, 5)
		local var_7_2 = ccp(arg_3_0.hero:getPosition())
		local var_7_3 = ccp(var_7_1.x, var_7_1.y)
		local var_7_4, var_7_5 = zbEffectTable:getEffectPosOffset(arg_3_0.skillRecord.flyEffectId, var_7_0)

		var_7_2.x = var_7_2.x + var_7_4
		var_7_2.y = var_7_2.y + var_7_5
		var_7_1.y = var_7_2.y

		g_EffectSystem:createMissileEffectPos(arg_3_0.hero, arg_3_0, EPathType.Line, var_7_2, var_7_1, var_7_3, arg_3_0.skillRecord.flyEffectId, arg_3_0.skillRecord.targetEffectId)
	end

	local function var_3_4()
		arg_3_0:enterIdle()
	end

	local function var_3_5()
		return
	end

	arg_3_0.actioning = true
	arg_3_0.accumTime = 0
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.getn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_6 = CCArray:create()

	if var_3_0() then
		var_3_6:addObject(CCCallFuncN:create(var_3_1))
		var_3_6:addObject(CCDelayTime:create(1.1666666666666667))
	end

	var_3_6:addObject(CCCallFuncN:create(var_3_2))
	var_3_6:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	var_3_6:addObject(CCCallFuncN:create(var_3_3))
	var_3_6:addObject(CCDelayTime:create(math.max(arg_3_0.hero.anim:getAnimDuration(arg_3_0.sequenceName) - arg_3_0.hitFrame, 0.1)))
	var_3_6:addObject(CCCallFuncN:create(var_3_4))
	var_3_6:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_3_0.hero:getFixPosition()))
	var_3_6:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_6:addObject(CCCallFuncN:create(var_3_5))

	local var_3_7 = CCSequence:create(var_3_6)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_7)
end

function zbFuxiansheng_2.update(arg_10_0, arg_10_1)
	arg_10_0.accumTime = arg_10_0.accumTime + arg_10_1

	if arg_10_0.accumTime > 3 then
		arg_10_0.actioning = false
	end
end

function zbFuxiansheng_2.hitTarget(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.targetList) do
		local var_11_0, var_11_1, var_11_2 = g_CombatFormula:calcDamage(arg_11_0.hero, iter_11_1, arg_11_0)

		if var_11_1 > 0 then
			iter_11_1:playBehitAnimation(arg_11_0.skillRecord.hitEffectId, arg_11_0)

			if zbCombatFormula:isSucceedRate(200) then
				g_BuffSystem:createControlBuff(arg_11_0.hero, iter_11_1, BUFF_TYPE_CONTROL_ZHONGSHANG)
			end
		end
	end
end

function zbFuxiansheng_2.hitEnd(arg_12_0)
	arg_12_0.actioning = false
end

function zbFuxiansheng_2.getDamageRatio(arg_13_0, arg_13_1)
	return 0.5
end
