require("gamecore.skill.zbBaseSkill")

zbFuxiansheng_0 = class("zbFuxiansheng_0", zbBaseSkill)
zbFuxiansheng_0.__index = zbFuxiansheng_0

function zbFuxiansheng_0.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbFuxiansheng_0.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbFuxiansheng_0.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Default
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 0.5666666666666667
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbFuxiansheng_0.action(arg_3_0)
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
		local var_6_0 = arg_3_0.targetList[1]:getBeattackPosition(arg_3_0.hero, arg_3_0.skillSeqIndex)

		arg_3_0.hero:setMovingFlag(true)
		arg_3_0.hero:setDesPos(var_6_0.x, var_6_0.y)
	end

	local function var_3_3()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_4()
		for iter_8_0, iter_8_1 in pairs(arg_3_0.targetList) do
			local var_8_0, var_8_1, var_8_2 = g_CombatFormula:calcDamage(arg_3_0.hero, iter_8_1, arg_3_0)

			if var_8_1 > 0 then
				iter_8_1:playBehitAnimation(arg_3_0.skillRecord.hitEffectId, arg_3_0)

				if arg_3_0:isQteRedoing() == false and zbCombatFormula:isSucceedRate(200) then
					g_BuffSystem:createControlBuff(arg_3_0.hero, iter_8_1, BUFF_TYPE_CONTROL_ZHONGSHANG)
				end
			end
		end
	end

	local function var_3_5()
		arg_3_0:enterIdle()
	end

	local function var_3_6()
		arg_3_0.actioning = false
	end

	arg_3_0.actioning = true
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.getn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_7 = arg_3_0.targetList[1]:getBeattackPosition(arg_3_0.hero, arg_3_0.skillSeqIndex)
	local var_3_8 = CCArray:create()

	if arg_3_0:isQteRedoing() == false and var_3_0() then
		var_3_8:addObject(CCCallFuncN:create(var_3_1))
		var_3_8:addObject(CCDelayTime:create(1.1666666666666667))
	end

	var_3_8:addObject(CCMoveTo:create(FIGHT_CHARGE_TIME, var_3_7))
	var_3_8:addObject(CCCallFuncN:create(var_3_2))
	var_3_8:addObject(CCCallFuncN:create(var_3_3))
	var_3_8:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	var_3_8:addObject(CCCallFuncN:create(var_3_4))
	var_3_8:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame, 0.1)))
	var_3_8:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_3_0.hero:getFixPosition()))
	var_3_8:addObject(CCCallFuncN:create(var_3_5))
	var_3_8:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_8:addObject(CCCallFuncN:create(var_3_6))

	local var_3_9 = CCSequence:create(var_3_8)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_9)
end

function zbFuxiansheng_0.getDamageRatio(arg_11_0, arg_11_1)
	return 1
end
