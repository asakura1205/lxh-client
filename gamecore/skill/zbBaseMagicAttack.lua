require("gamecore.skill.zbBaseSkill")

zbBaseMagicAttack = class("zbBaseMagicAttack", zbBaseSkill)
zbBaseMagicAttack.__index = zbBaseMagicAttack

function zbBaseMagicAttack.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:initBase(arg_1_1, arg_1_2)

	arg_1_0.sideType = ESideType.Enemy
	arg_1_0.targetType = ETargetType.Default
	arg_1_0.subTargetType = ESubTargetType.All
	arg_1_0.hitFrame = 0.25
	arg_1_0.skillDurationTime = arg_1_0.hero.anim:getAnimDuration(arg_1_0.sequenceName)
	arg_1_0.hitExtraAction = nil
	arg_1_0.attackHitDelayTime = 0.16666666666666666
end

function zbBaseMagicAttack.action(arg_2_0)
	local function var_2_0()
		arg_2_0:popupSkillBubble()
		arg_2_0.hero.anim:setAnimation(arg_2_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_2_0.hero, arg_2_0.skillRecord.riseEffectId)
	end

	local function var_2_1()
		for iter_4_0, iter_4_1 in pairs(arg_2_0.targetList) do
			g_EffectSystem:createInstantEffect(iter_4_1, arg_2_0.skillRecord.targetEffectId)
		end
	end

	local function var_2_2()
		for iter_5_0, iter_5_1 in pairs(arg_2_0.targetList) do
			local var_5_0, var_5_1, var_5_2 = g_CombatFormula:calcDamage(arg_2_0.hero, iter_5_1, arg_2_0)

			if var_5_1 > 0 then
				iter_5_1:playBehitAnimation(arg_2_0.skillRecord.hitEffectId, arg_2_0)

				if arg_2_0.hitExtraAction ~= nil then
					arg_2_0.hitExtraAction(iter_5_1)
				end
			end
		end
	end

	local function var_2_3()
		arg_2_0:enterIdle()
	end

	local function var_2_4()
		arg_2_0.actioning = false
	end

	arg_2_0.actioning = true
	arg_2_0.targetList = zbTargetHandler:selectTarget(arg_2_0.hero, arg_2_0, arg_2_0:getSideType(), arg_2_0:getTargetType(), arg_2_0:getSubTargetType())

	if table.getn(arg_2_0.targetList) == 0 then
		arg_2_0.actioning = false

		return
	end

	local var_2_5 = CCArray:create()

	var_2_5:addObject(CCCallFuncN:create(var_2_0))
	var_2_5:addObject(CCDelayTime:create(arg_2_0.hitFrame))
	var_2_5:addObject(CCCallFuncN:create(var_2_1))
	var_2_5:addObject(CCDelayTime:create(arg_2_0.attackHitDelayTime))
	var_2_5:addObject(CCCallFuncN:create(var_2_2))
	var_2_5:addObject(CCDelayTime:create(math.max(arg_2_0.skillDurationTime - arg_2_0.hitFrame - arg_2_0.attackHitDelayTime, 0.1)))
	var_2_5:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_2_0.hero:getFixPosition()))
	var_2_5:addObject(CCCallFuncN:create(var_2_3))
	var_2_5:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_2_5:addObject(CCCallFuncN:create(var_2_4))

	local var_2_6 = CCSequence:create(var_2_5)

	arg_2_0.hero:stopAllActions()
	arg_2_0.hero:runAction(var_2_6)
end

function zbBaseMagicAttack.setHitExtraAction(arg_8_0, arg_8_1)
	arg_8_0.hitExtraAction = arg_8_1
end
