require("gamecore.skill.zbBaseSkill")

zbLuoxiaohei_1 = class("zbLuoxiaohei_1", zbBaseSkill)
zbLuoxiaohei_1.__index = zbLuoxiaohei_1

function zbLuoxiaohei_1.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbLuoxiaohei_1.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbLuoxiaohei_1.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Random_1
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 1.6666666666666667
	arg_2_0.hitCount = 10
end

function zbLuoxiaohei_1.action(arg_3_0)
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
		g_CombatBubble:setNumOffsetRandomRangeX(25)
		arg_3_0.hero.energy:decCount()

		arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

		for iter_6_0, iter_6_1 in pairs(arg_3_0.targetList) do
			iter_6_1:resume()

			local var_6_0, var_6_1, var_6_2 = g_CombatFormula:calcDamage(arg_3_0.hero, iter_6_1, arg_3_0)

			if var_6_1 > 0 then
				iter_6_1:playBehitAnimation(arg_3_0.skillRecord.hitEffectId, arg_3_0)
			end

			if arg_3_0.hero.lxhSkill4 ~= nil and zbCombatFormula:isSucceedRate(arg_3_0.hero.lxhSkill4Rate * 1000 / arg_3_0.hitCount) then
				local var_6_3 = BUFF_TYPE_PROPERTY_DAMAMGE_DEFEND_PHYSICMAGIC
				local var_6_4 = -0.5
				local var_6_5 = -arg_3_0.hero.lxhSkill4:getDamageAbs()
				local var_6_6 = 2
				local var_6_7 = 0.5

				arg_3_0.hero.lxhSkill4:popupSkillBubble(var_6_7)
				g_BuffSystem:createBuff(arg_3_0.hero, iter_6_1, var_6_3, var_6_4, var_6_5, var_6_6, var_6_7)
			end
		end

		g_CombatBubble:setNumOffsetRandomRangeX(0)
	end

	local function var_3_3()
		arg_3_0.hero.energy:clearCount()
		arg_3_0:enterIdle()
	end

	local function var_3_4()
		arg_3_0.actioning = false
	end

	arg_3_0.actioning = true
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.getn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_5 = getFormationCenterFrontPos(arg_3_0.hero.forceType)

	arg_3_0.hero:setMovingFlag(true)
	arg_3_0.hero:setDesPos(var_3_5.x, var_3_5.y)

	local var_3_6 = CCArray:create()

	arg_3_0:playBigSkillScreenAnim(var_3_6)
	var_3_6:addObject(CCMoveTo:create(FIGHT_CHARGE_TIME, var_3_5))
	var_3_6:addObject(CCCallFuncN:create(var_3_0))
	var_3_6:addObject(CCDelayTime:create(arg_3_0.hitFrame))

	local var_3_7 = 10 + arg_3_0.hero.energy.count

	arg_3_0.hitCount = var_3_7

	for iter_3_0 = 1, var_3_7 do
		var_3_6:addObject(CCCallFuncN:create(var_3_2))
		var_3_6:addObject(CCDelayTime:create(40 / var_3_7 * 1 / 30))
	end

	var_3_6:addObject(CCCallFuncN:create(var_3_1))
	var_3_6:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_3_0.hero:getFixPosition()))
	var_3_6:addObject(CCCallFuncN:create(var_3_3))
	var_3_6:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_6:addObject(CCCallFuncN:create(var_3_4))

	local var_3_8 = CCSequence:create(var_3_6)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_8)
end

function zbLuoxiaohei_1.getDamageRatio(arg_9_0, arg_9_1)
	return 0.25
end
