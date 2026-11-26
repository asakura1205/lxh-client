require("gamecore.skill.zbBaseSkill")

zbLaojun_1 = class("zbLaojun_1", zbBaseSkill)
zbLaojun_1.__index = zbLaojun_1

function zbLaojun_1.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbLaojun_1.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbLaojun_1.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Random_5
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.bombFrame = 0.26666666666666666
	arg_2_0.hitFrame = 1.1333333333333333
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbLaojun_1.action(arg_3_0)
	local function var_3_0()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_1()
		local var_5_0 = arg_3_0.targetList[1].forceType
		local var_5_1 = getCombatHeroPos(var_5_0, 5)

		if g_EffectSystem:createBombEffect(arg_3_0.hero, var_5_0, var_5_1, arg_3_0.skillRecord.targetEffectId, 0) ~= nil then
			-- block empty
		end
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
				g_EffectSystem:createInstantEffect(iter_8_1, 1014014)
				g_EffectSystem:createInstantEffect(iter_8_1, 1014015)
				g_EffectSystem:createInstantEffect(iter_8_1, 1014016)
			end

			g_Audio:playSound("audio/sound/cure.mp3")
		end

		local function var_7_1()
			local var_9_0 = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, ESideType.Self, ETargetType.Random_5, ESubTargetType.All)

			for iter_9_0, iter_9_1 in pairs(var_9_0) do
				g_CombatFormulaCure:calcCure(arg_3_0.hero, iter_9_1, arg_3_0)
				g_EffectSystem:createInstantEffect(iter_9_1, 1014014)
				g_EffectSystem:createInstantEffect(iter_9_1, 1014015)
			end

			g_Audio:playSound("audio/sound/cure.mp3")
		end

		local function var_7_2()
			local var_10_0 = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, ESideType.Self, ETargetType.Condition_MinHpPercent, ESubTargetType.All)

			for iter_10_0, iter_10_1 in pairs(var_10_0) do
				g_CombatFormulaCure:calcCure(arg_3_0.hero, iter_10_1, arg_3_0)
				g_EffectSystem:createInstantEffect(iter_10_1, 1014014)
				g_EffectSystem:createInstantEffect(iter_10_1, 1014015)
			end

			g_Audio:playSound("audio/sound/cure.mp3")
		end

		var_7_1()

		local var_7_3 = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, ESideType.Self, ETargetType.Random_1_Died, ESubTargetType.All)

		if table.maxn(var_7_3) > 0 then
			var_7_0()
		else
			var_7_2()
		end
	end

	local function var_3_4()
		arg_3_0:enterIdle()
	end

	local function var_3_5()
		arg_3_0.actioning = false
	end

	arg_3_0.actioning = true
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.maxn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_6 = CCArray:create()

	arg_3_0:playBigSkillScreenAnim(var_3_6)
	var_3_6:addObject(CCCallFuncN:create(var_3_0))
	var_3_6:addObject(CCDelayTime:create(arg_3_0.bombFrame))
	var_3_6:addObject(CCCallFuncN:create(var_3_1))
	var_3_6:addObject(CCDelayTime:create(arg_3_0.hitFrame - arg_3_0.bombFrame))
	var_3_6:addObject(CCCallFuncN:create(var_3_3))
	var_3_6:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame, 0.1)))
	var_3_6:addObject(CCCallFuncN:create(var_3_2))
	var_3_6:addObject(CCCallFuncN:create(var_3_4))
	var_3_6:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_6:addObject(CCCallFuncN:create(var_3_5))

	local var_3_7 = CCSequence:create(var_3_6)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_7)
end

function zbLaojun_1.getDamageRatio(arg_13_0)
	return 0.5
end
