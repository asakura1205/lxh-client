require("gamecore.skill.zbBaseSkill")

zbDiting_1 = class("zbDiting_1", zbBaseSkill)
zbDiting_1.__index = zbDiting_1

function zbDiting_1.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbDiting_1.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbDiting_1.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Random_5
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 1.2333333333333334
	arg_2_0.bombFrame = 3.066666666666667
	arg_2_0.damageSectionCount = 8
	arg_2_0.mpTargetList = {}
end

function zbDiting_1.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseAttackEffectId)
	end

	local function var_3_1()
		g_DarkNode:hideDarkNode(arg_3_0.hero)
		g_CombatSystem:resumeExclude(arg_3_0.hero)
	end

	local function var_3_2()
		g_CombatBubble:setNumOffsetRandomRangeX(25)

		arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

		for iter_6_0, iter_6_1 in pairs(arg_3_0.targetList) do
			iter_6_1:resume()

			local var_6_0, var_6_1, var_6_2 = g_CombatFormula:calcDamage(arg_3_0.hero, iter_6_1, arg_3_0)

			if var_6_1 > 0 then
				iter_6_1:playBehitAnimation(arg_3_0.skillRecord.hitEffectId, arg_3_0)

				local var_6_3 = true

				for iter_6_2, iter_6_3 in pairs(arg_3_0.mpTargetList) do
					if iter_6_3:isSame(iter_6_1) then
						var_6_3 = false

						break
					end
				end

				if var_6_3 then
					table.insert(arg_3_0.mpTargetList, iter_6_1)
				end
			end
		end

		g_CombatBubble:setNumOffsetRandomRangeX(0)
	end

	local function var_3_3()
		for iter_7_0, iter_7_1 in pairs(arg_3_0.mpTargetList) do
			iter_7_1:addMp(-20)
			g_CombatBubble:showBubble(iter_7_1, ECombatBubble.MpDown, 0, 0.3333333333333333, 1)
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

	local var_3_6 = getFormationCenterFrontPos(arg_3_0.hero.forceType)

	arg_3_0.hero:setMovingFlag(true)
	arg_3_0.hero:setDesPos(var_3_6.x, var_3_6.y)

	arg_3_0.mpTargetList = {}

	local var_3_7 = CCArray:create()

	arg_3_0:playBigSkillScreenAnim(var_3_7)
	var_3_7:addObject(CCMoveTo:create(FIGHT_CHARGE_TIME, var_3_6))
	var_3_7:addObject(CCCallFuncN:create(var_3_0))
	var_3_7:addObject(CCDelayTime:create(arg_3_0.hitFrame))

	local var_3_8 = arg_3_0.damageSectionCount - 1
	local var_3_9 = arg_3_0.hitFrame

	for iter_3_0 = 1, var_3_8 do
		local var_3_10 = 40 / var_3_8 * 1 / 30

		var_3_9 = var_3_9 + var_3_10

		var_3_7:addObject(CCCallFuncN:create(var_3_2))
		var_3_7:addObject(CCDelayTime:create(var_3_10))
	end

	var_3_7:addObject(CCDelayTime:create(math.max(arg_3_0.bombFrame - var_3_9, 0.1)))
	var_3_7:addObject(CCCallFuncN:create(var_3_2))
	var_3_7:addObject(CCCallFuncN:create(var_3_3))
	var_3_7:addObject(CCDelayTime:create(math.max(3.8333333333333335 - arg_3_0.bombFrame, 0.1)))
	var_3_7:addObject(CCCallFuncN:create(var_3_1))
	var_3_7:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_3_0.hero:getFixPosition()))
	var_3_7:addObject(CCCallFuncN:create(var_3_4))
	var_3_7:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_7:addObject(CCCallFuncN:create(var_3_5))

	local var_3_11 = CCSequence:create(var_3_7)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_11)
end

function zbDiting_1.getDamageRatio(arg_10_0, arg_10_1)
	return 0.7
end
