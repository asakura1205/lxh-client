require("gamecore.skill.zbBaseSkill")

zbShanxin_2 = class("zbShanxin_2", zbBaseSkill)
zbShanxin_2.__index = zbShanxin_2

function zbShanxin_2.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbShanxin_2.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbShanxin_2.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Default
	arg_2_0.subTargetType = ESubTargetType.Row
	arg_2_0.bombFrame = 0.26666666666666666
	arg_2_0.targetFrame = 0.8
	arg_2_0.hitFrame = 0.5333333333333333
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.damageSectionCount = 5
end

function zbShanxin_2.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:playAnimationOnce(arg_3_0.sequenceName, arg_3_0.hero:getIdleWeakSequence(), 0.125)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseAttackEffectId)
	end

	local function var_3_1(arg_5_0)
		local var_5_0 = arg_3_0.targetList[1].forceType
		local var_5_1 = getCombatHeroPos(var_5_0, arg_5_0)

		g_EffectSystem:createBombEffect(arg_3_0.hero, var_5_0, var_5_1, arg_3_0.skillRecord.targetEffectId, 0.01, 0.3333333333333333, function()
			arg_3_0:customHitAction()
		end)
	end

	local function var_3_2()
		var_3_1(7)
	end

	local function var_3_3()
		var_3_1(3)
	end

	local function var_3_4()
		var_3_1(9)
	end

	local function var_3_5()
		var_3_1(1)
	end

	local function var_3_6()
		var_3_1(5)
	end

	local function var_3_7()
		arg_3_0:enterIdle()
	end

	local function var_3_8()
		arg_3_0.actioning = false
	end

	arg_3_0.actioning = true
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.getn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_9 = CCArray:create()

	if arg_3_0.hero.shanxin4Skill ~= nil then
		arg_3_0.hero.shanxin4Skill:actionEx(var_3_9)
	end

	var_3_9:addObject(CCCallFuncN:create(var_3_0))
	var_3_9:addObject(CCDelayTime:create(arg_3_0.targetFrame))
	var_3_9:addObject(CCDelayTime:create(arg_3_0.bombFrame))
	var_3_9:addObject(CCCallFuncN:create(var_3_2))
	var_3_9:addObject(CCDelayTime:create(0.3333333333333333))
	var_3_9:addObject(CCCallFuncN:create(var_3_3))
	var_3_9:addObject(CCDelayTime:create(0.3333333333333333))
	var_3_9:addObject(CCCallFuncN:create(var_3_4))
	var_3_9:addObject(CCDelayTime:create(0.3333333333333333))
	var_3_9:addObject(CCCallFuncN:create(var_3_5))
	var_3_9:addObject(CCDelayTime:create(0.3333333333333333))
	var_3_9:addObject(CCCallFuncN:create(var_3_6))
	var_3_9:addObject(CCDelayTime:create(0.3333333333333333))

	if arg_3_0.hero.shanxin3Skill ~= nil then
		arg_3_0.hero.shanxin3Skill:actionEx(var_3_9)
	end

	var_3_9:addObject(CCCallFuncN:create(var_3_7))
	var_3_9:addObject(CCDelayTime:create(0.6666666666666666))
	var_3_9:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_9:addObject(CCCallFuncN:create(var_3_8))

	local var_3_10 = CCSequence:create(var_3_9)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_10)
end

function zbShanxin_2.getDamageRatio(arg_14_0, arg_14_1)
	return 0.75
end

function zbShanxin_2.customHitAction(arg_15_0)
	g_CombatBubble:setNumOffsetRandomRangeX(25)

	for iter_15_0, iter_15_1 in pairs(arg_15_0.targetList) do
		local var_15_0, var_15_1, var_15_2 = g_CombatFormula:calcDamage(arg_15_0.hero, iter_15_1, arg_15_0)

		if var_15_1 > 0 then
			iter_15_1:playBehitAnimation(arg_15_0.skillRecord.hitEffectId, arg_15_0)
		end
	end

	g_CombatBubble:setNumOffsetRandomRangeX(0)
end
