require("gamecore.skill.zbBaseSkill")

zbLuoxiaohei_moli_1 = class("zbLuoxiaohei_moli_1", zbBaseSkill)
zbLuoxiaohei_moli_1.__index = zbLuoxiaohei_moli_1

function zbLuoxiaohei_moli_1.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbLuoxiaohei_moli_1.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbLuoxiaohei_moli_1.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Random_5
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 0.9666666666666667
	arg_2_0.attackHitDelayTime = 0.7
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbLuoxiaohei_moli_1.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:playAnimationOnce(arg_3_0.sequenceName, arg_3_0.hero:getIdleWeakSequence(), 0.125)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_1()
		local var_5_0 = arg_3_0.targetList[1].forceType
		local var_5_1 = getCombatHeroPos(var_5_0, 5)

		g_EffectSystem:createBombEffect(arg_3_0.hero, var_5_0, var_5_1, arg_3_0.skillRecord.riseAttackEffectId, 0)
	end

	local function var_3_2()
		g_DarkNode:hideDarkNode(arg_3_0.hero)
		g_CombatSystem:resumeExclude(arg_3_0.hero)
	end

	local function var_3_3()
		local function var_7_0()
			local var_8_0 = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, ESideType.Self, ETargetType.Random_1_Died, ESubTargetType.All)

			for iter_8_0, iter_8_1 in pairs(var_8_0) do
				g_CombatFormulaCure:calcCure(arg_3_0.hero, iter_8_1, arg_3_0)
				g_EffectSystem:createInstantEffect(iter_8_1, arg_3_0.skillRecord.targetEffectId)
				g_BuffSystem:removeHeroAllDebuff(iter_8_1)
			end
		end

		;(function()
			local var_9_0 = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, ESideType.Self, ETargetType.Random_5, ESubTargetType.All)

			for iter_9_0, iter_9_1 in pairs(var_9_0) do
				g_CombatFormulaCure:calcCure(arg_3_0.hero, iter_9_1, arg_3_0, 0, 3)
				g_EffectSystem:createInstantEffect(iter_9_1, arg_3_0.skillRecord.hitEffectId)
				g_BuffSystem:removeHeroAllDebuff(iter_9_1)
			end
		end)()
		var_7_0()
		g_Audio:playSound("audio/sound/cure.mp3")
	end

	local function var_3_4()
		arg_3_0:enterIdle()
	end

	local function var_3_5()
		arg_3_0.actioning = false
	end

	arg_3_0.actioning = true
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.getn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_6 = CCArray:create()

	arg_3_0:playBigSkillScreenAnim(var_3_6)
	var_3_6:addObject(CCCallFuncN:create(var_3_0))
	var_3_6:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	var_3_6:addObject(CCCallFuncN:create(var_3_1))
	var_3_6:addObject(CCDelayTime:create(arg_3_0.attackHitDelayTime))
	var_3_6:addObject(CCCallFuncN:create(var_3_2))
	var_3_6:addObject(CCCallFuncN:create(var_3_3))
	var_3_6:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame - arg_3_0.attackHitDelayTime, 0.1)))
	var_3_6:addObject(CCCallFuncN:create(var_3_4))
	var_3_6:addObject(CCDelayTime:create(1.4333333333333333))
	var_3_6:addObject(CCCallFuncN:create(var_3_5))

	local var_3_7 = CCSequence:create(var_3_6)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_7)
end

function zbLuoxiaohei_moli_1.getDamageRatio(arg_12_0, arg_12_1)
	return 0.5
end
