require("gamecore.skill.zbBaseSkill")

zbSatan_1 = class("zbSatan_1", zbBaseSkill)
zbSatan_1.__index = zbSatan_1

function zbSatan_1.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbSatan_1.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbSatan_1.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Random_5
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 1.4333333333333333
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbSatan_1.action(arg_3_0)
	local function var_3_0()
		local var_4_0 = arg_3_0.targetList[1]:getBeattackPosition(arg_3_0.hero, arg_3_0.skillSeqIndex)

		arg_3_0.hero:setMovingFlag(true)
		arg_3_0.hero:setDesPos(var_4_0.x, var_4_0.y)
	end

	local function var_3_1()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_2()
		g_DarkNode:hideDarkNode(arg_3_0.hero)
		g_CombatSystem:resumeExclude(arg_3_0.hero)
	end

	local function var_3_3()
		g_Audio:playSound("audio/sound/bomb_2.mp3")

		for iter_7_0, iter_7_1 in pairs(arg_3_0.targetList) do
			local var_7_0, var_7_1, var_7_2 = g_CombatFormula:calcDamage(arg_3_0.hero, iter_7_1, arg_3_0)

			if var_7_1 > 0 then
				iter_7_1:playBehitAnimation(arg_3_0.skillRecord.hitEffectId, arg_3_0)
			end
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

	if table.getn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_6 = getCombatHeroPos(arg_3_0.targetList[1].forceType, 5)

	if arg_3_0.targetList[1].forceType == ForceType.Left then
		var_3_6.x = var_3_6.x + 180
	else
		var_3_6.x = var_3_6.x - 180
	end

	local var_3_7 = CCArray:create()

	arg_3_0:playBigSkillScreenAnim(var_3_7)
	var_3_7:addObject(CCMoveTo:create(0.001, var_3_6))
	var_3_7:addObject(CCCallFuncN:create(var_3_0))
	var_3_7:addObject(CCCallFuncN:create(var_3_1))
	var_3_7:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	var_3_7:addObject(CCCallFuncN:create(var_3_2))
	var_3_7:addObject(CCCallFuncN:create(var_3_3))
	var_3_7:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame, 0.1)))
	var_3_7:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_3_0.hero:getFixPosition()))
	var_3_7:addObject(CCCallFuncN:create(var_3_4))
	var_3_7:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_7:addObject(CCCallFuncN:create(var_3_5))

	local var_3_8 = CCSequence:create(var_3_7)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_8)
end

function zbSatan_1.getDamageRatio(arg_10_0, arg_10_1)
	return 1
end
