require("gamecore.skill.zbBaseSkill")

zbXiaoji_1 = class("zbXiaoji_1", zbBaseSkill)
zbXiaoji_1.__index = zbXiaoji_1

function zbXiaoji_1.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbXiaoji_1.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbXiaoji_1.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Random_1
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 0.3333333333333333
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbXiaoji_1.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_1()
		g_DarkNode:hideDarkNode(arg_3_0.hero)
		g_CombatSystem:resumeExclude(arg_3_0.hero)
	end

	local function var_3_2()
		local function var_6_0()
			local var_7_0 = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, ESideType.Self, ETargetType.Random_1_Died, ESubTargetType.All)

			for iter_7_0, iter_7_1 in pairs(var_7_0) do
				g_CombatFormulaCure:calcCure(arg_3_0.hero, iter_7_1, arg_3_0)
				g_EffectSystem:createInstantEffect(iter_7_1, 1033012)

				local var_7_1 = BUFF_TYPE_PROPERTY_DAMAMGE_PHYSICMAGIC
				local var_7_2 = 0.1
				local var_7_3 = 0
				local var_7_4 = 1

				g_BuffSystem:createBuff(arg_3_0.hero, iter_7_1, var_7_1, var_7_2, var_7_3, var_7_4, 0)
			end
		end

		local function var_6_1()
			local var_8_0 = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, ESideType.Self, ETargetType.Condition_MinHpPercent, ESubTargetType.All)

			for iter_8_0, iter_8_1 in pairs(var_8_0) do
				g_CombatFormulaCure:calcCure(arg_3_0.hero, iter_8_1, arg_3_0)
				g_EffectSystem:createInstantEffect(arg_3_0.hero, 1033022)

				local var_8_1 = BUFF_TYPE_PROPERTY_DAMAMGE_PHYSICMAGIC
				local var_8_2 = 0.1
				local var_8_3 = 0
				local var_8_4 = 1

				g_BuffSystem:createBuff(arg_3_0.hero, iter_8_1, var_8_1, var_8_2, var_8_3, var_8_4, 0)
			end
		end

		local var_6_2 = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, ESideType.Self, ETargetType.Random_1_Died, ESubTargetType.All)

		if table.maxn(var_6_2) > 0 then
			var_6_0()
		else
			var_6_1()
		end
	end

	local function var_3_3()
		arg_3_0:enterIdle()
	end

	local function var_3_4()
		arg_3_0.actioning = false
	end

	arg_3_0.actioning = true

	local var_3_5 = CCArray:create()

	arg_3_0:playBigSkillScreenAnim(var_3_5)
	var_3_5:addObject(CCCallFuncN:create(var_3_0))
	var_3_5:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	var_3_5:addObject(CCCallFuncN:create(var_3_2))
	var_3_5:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame, 0.1)))
	var_3_5:addObject(CCCallFuncN:create(var_3_1))
	var_3_5:addObject(CCCallFuncN:create(var_3_3))
	var_3_5:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_5:addObject(CCCallFuncN:create(var_3_4))

	local var_3_6 = CCSequence:create(var_3_5)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_6)
end

function zbXiaoji_1.getDamageRatio(arg_11_0, arg_11_1)
	return 0.5
end
