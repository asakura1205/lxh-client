require("gamecore.skill.zbBaseSkill")

zbHeixiu2_2 = class("zbHeixiu2_2", zbBaseSkill)
zbHeixiu2_2.__index = zbHeixiu2_2

function zbHeixiu2_2.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbHeixiu2_2.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbHeixiu2_2.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Default
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 1.4
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.hero.heixiu2Skill2 = arg_2_0
end

function zbHeixiu2_2.actionEx(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if zbCombatFormula:isSucceedRate(500) == false then
		return
	end

	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_1()
		g_Audio:playSound("audio/sound/bomb_1.mp3")

		for iter_5_0, iter_5_1 in pairs(arg_3_2) do
			local var_5_0, var_5_1, var_5_2 = g_CombatFormula:calcDamage(arg_3_0.hero, iter_5_1, arg_3_3)

			if var_5_1 > 0 then
				iter_5_1:playBehitAnimation(arg_3_3.skillRecord.hitEffectId, arg_3_3)
			end
		end
	end

	local var_3_2 = arg_3_2[1]:getBeattackPosition(arg_3_0.hero, arg_3_0.skillSeqIndex)

	arg_3_1:addObject(CCMoveTo:create(FIGHT_CHARGE_TIME, var_3_2))
	arg_3_1:addObject(CCCallFuncN:create(var_3_0))
	arg_3_1:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	arg_3_1:addObject(CCCallFuncN:create(var_3_1))
	arg_3_1:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame, 0.1)))
	arg_3_1:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_3_0.hero:getFixPosition()))
end

function zbHeixiu2_2.getDamageRatio(arg_6_0, arg_6_1)
	return 0.4
end
