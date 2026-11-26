require("gamecore.skill.zbBaseSkill")

zbGuagua_1 = class("zbGuagua_1", zbBaseSkill)
zbGuagua_1.__index = zbGuagua_1

function zbGuagua_1.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbGuagua_1.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbGuagua_1.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Default
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.moveFrame = 0.03333333333333333
	arg_2_0.groundFrame = 0.3
	arg_2_0.hitFrame = 1.0666666666666667
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbGuagua_1.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)

		local var_4_0 = g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)

		if var_4_0 ~= nil then
			var_4_0:setPosition(arg_3_0.hero.destPos)
		end
	end

	local function var_3_1()
		g_DarkNode:hideDarkNode(arg_3_0.hero)
		g_CombatSystem:resumeExclude(arg_3_0.hero)
	end

	local function var_3_2()
		for iter_6_0, iter_6_1 in pairs(arg_3_0.targetList) do
			iter_6_1:resume()

			local var_6_0, var_6_1, var_6_2 = g_CombatFormula:calcDamage(arg_3_0.hero, iter_6_1, arg_3_0)

			if var_6_1 > 0 then
				iter_6_1:playBehitAnimation(arg_3_0.skillRecord.hitEffectId, arg_3_0)

				local var_6_3 = BUFF_TYPE_PROPERTY_HP_ZHONGDU
				local var_6_4 = -arg_3_0.hero.physicAttack * 0.25
				local var_6_5 = 0
				local var_6_6 = 2

				g_BuffSystem:createBuff(arg_3_0.hero, iter_6_1, var_6_3, var_6_4, var_6_5, var_6_6)
			end
		end
	end

	local function var_3_3()
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

	local var_3_5 = arg_3_0.targetList[1]:getBeattackPosition(arg_3_0.hero, arg_3_0.skillSeqIndex)

	arg_3_0.hero:setMovingFlag(true)
	arg_3_0.hero:setDesPos(var_3_5.x, var_3_5.y)

	local var_3_6 = CCArray:create()

	arg_3_0:playBigSkillScreenAnim(var_3_6)
	var_3_6:addObject(CCCallFuncN:create(var_3_0))
	var_3_6:addObject(CCDelayTime:create(arg_3_0.moveFrame))
	var_3_6:addObject(CCMoveTo:create(arg_3_0.groundFrame - arg_3_0.moveFrame, var_3_5))
	var_3_6:addObject(CCDelayTime:create(arg_3_0.hitFrame - arg_3_0.groundFrame))
	var_3_6:addObject(CCCallFuncN:create(var_3_2))
	var_3_6:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame, 0.1)))
	var_3_6:addObject(CCCallFuncN:create(var_3_1))
	var_3_6:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_3_0.hero:getFixPosition()))
	var_3_6:addObject(CCCallFuncN:create(var_3_3))
	var_3_6:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_6:addObject(CCCallFuncN:create(var_3_4))

	local var_3_7 = CCSequence:create(var_3_6)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_7)
end

function zbGuagua_1.getDamageRatio(arg_9_0, arg_9_1)
	return 1
end
