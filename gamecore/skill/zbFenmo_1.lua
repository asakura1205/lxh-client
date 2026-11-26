require("gamecore.skill.zbBaseSkill")

zbFenmo_1 = class("zbFenmo_1", zbBaseSkill)
zbFenmo_1.__index = zbFenmo_1

function zbFenmo_1.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbFenmo_1.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbFenmo_1.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Random_5
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.damageSectionCount = 3
	arg_2_0.hitDelayFrame = 0.3333333333333333
	arg_2_0.hitFrame = 2.033333333333333
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbFenmo_1.action(arg_3_0)
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
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.targetEffectId)
	end

	local function var_3_3()
		for iter_7_0, iter_7_1 in pairs(arg_3_0.targetList) do
			iter_7_1:resume()

			local var_7_0, var_7_1, var_7_2 = g_CombatFormula:calcDamage(arg_3_0.hero, iter_7_1, arg_3_0)

			if var_7_1 > 0 then
				iter_7_1:playBehitAnimation(arg_3_0.skillRecord.hitEffectId, arg_3_0)
				iter_7_1:addMp(-20)
				g_CombatBubble:showBubble(iter_7_1, ECombatBubble.MpDown, 0, 0, 1)
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
	arg_3_0.skillDurationTime = arg_3_0.hero.anim:getAnimDuration(arg_3_0.sequenceName)
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.maxn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_6 = CCArray:create()

	arg_3_0:playBigSkillScreenAnim(var_3_6)
	var_3_6:addObject(CCCallFuncN:create(var_3_0))
	var_3_6:addObject(CCCallFuncN:create(var_3_2))
	var_3_6:addObject(CCDelayTime:create(arg_3_0.hitFrame))

	for iter_3_0 = 1, arg_3_0.damageSectionCount do
		var_3_6:addObject(CCCallFuncN:create(var_3_3))
		var_3_6:addObject(CCDelayTime:create(arg_3_0.hitDelayFrame))
	end

	var_3_6:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame - arg_3_0.hitDelayFrame * arg_3_0.damageSectionCount, 0.1)))
	var_3_6:addObject(CCCallFuncN:create(var_3_1))
	var_3_6:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_3_0.hero:getFixPosition()))
	var_3_6:addObject(CCCallFuncN:create(var_3_4))
	var_3_6:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_6:addObject(CCCallFuncN:create(var_3_5))

	local var_3_7 = CCSequence:create(var_3_6)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_7)
end

function zbFenmo_1.getDamageRatio(arg_10_0, arg_10_1)
	return 0.7
end
