require("gamecore.skill.zbBaseSkill")

zbLuoxiaohei_moli_0 = class("zbLuoxiaohei_moli_0", zbBaseSkill)
zbLuoxiaohei_moli_0.__index = zbLuoxiaohei_moli_0

function zbLuoxiaohei_moli_0.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbLuoxiaohei_moli_0.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbLuoxiaohei_moli_0.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Default
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 0.3333333333333333
	arg_2_0.attackDelayTime = 0.2
	arg_2_0.cureDelayTime = 1.5666666666666667
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.damageValue = 0
end

function zbLuoxiaohei_moli_0.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:playAnimationOnce(arg_3_0.sequenceName, arg_3_0.hero:getIdleWeakSequence(), 0.125)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_1()
		for iter_5_0, iter_5_1 in pairs(arg_3_0.targetList) do
			g_EffectSystem:createInstantEffect(iter_5_1, arg_3_0.skillRecord.targetEffectId)
		end
	end

	local function var_3_2()
		for iter_6_0, iter_6_1 in pairs(arg_3_0.targetList) do
			local var_6_0, var_6_1, var_6_2 = g_CombatFormula:calcDamage(arg_3_0.hero, iter_6_1, arg_3_0)

			if var_6_1 > 0 then
				iter_6_1:playBehitAnimation(arg_3_0.skillRecord.hitEffectId, arg_3_0)

				if arg_3_0:isQteRedoing() == false and arg_3_0.hero.lxhMoliSkill4 ~= nil then
					arg_3_0.hero.lxhMoliSkill4:actionTarget(iter_6_1)
				end

				arg_3_0.damageValue = var_6_1
			end
		end
	end

	local function var_3_3()
		local var_7_0 = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, ESideType.Self, ETargetType.Condition_MinHpPercent, ESubTargetType.All)

		for iter_7_0, iter_7_1 in pairs(var_7_0) do
			g_EffectSystem:createInstantEffect(iter_7_1, arg_3_0.skillRecord.riseAttackEffectId)
			iter_7_1:addHp(arg_3_0.damageValue * 0.5, false, 1, delayTime, 0.23333333333333334)
		end

		g_Audio:playSound("audio/sound/cure.mp3")
	end

	local function var_3_4()
		arg_3_0:enterIdle()
	end

	local function var_3_5()
		arg_3_0.actioning = false
	end

	arg_3_0.damageValue = 0
	arg_3_0.actioning = true
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.getn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_6 = CCArray:create()

	if arg_3_0:isQteRedoing() == false and arg_3_0.hero.lxhMoliSkill3 ~= nil then
		arg_3_0.hero.lxhMoliSkill3:actionEx(var_3_6)
	end

	var_3_6:addObject(CCCallFuncN:create(var_3_0))
	var_3_6:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	var_3_6:addObject(CCCallFuncN:create(var_3_1))
	var_3_6:addObject(CCDelayTime:create(arg_3_0.attackDelayTime))
	var_3_6:addObject(CCCallFuncN:create(var_3_2))
	var_3_6:addObject(CCDelayTime:create(arg_3_0.cureDelayTime))
	var_3_6:addObject(CCCallFuncN:create(var_3_3))
	var_3_6:addObject(CCDelayTime:create(1))
	var_3_6:addObject(CCCallFuncN:create(var_3_4))
	var_3_6:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_6:addObject(CCCallFuncN:create(var_3_5))

	local var_3_7 = CCSequence:create(var_3_6)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_7)
end

function zbLuoxiaohei_moli_0.getDamageRatio(arg_10_0, arg_10_1)
	local var_10_0 = 0.8

	if arg_10_0.hero.lxhMoliSkill4 ~= nil then
		var_10_0 = var_10_0 + arg_10_0.hero.lxhMoliSkill4:getDamageRatio(arg_10_1)
	end

	return var_10_0
end

function zbLuoxiaohei_moli_0.getDamageAbs(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getDamageAbsBase()

	if arg_11_0.hero.lxhMoliSkill4 ~= nil then
		var_11_0 = var_11_0 + arg_11_0.hero.lxhMoliSkill4:getDamageAbs(arg_11_1)
	end

	return var_11_0
end
