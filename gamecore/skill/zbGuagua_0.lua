require("gamecore.skill.zbBaseSkill")

zbGuagua_0 = class("zbGuagua_0", zbBaseSkill)
zbGuagua_0.__index = zbGuagua_0

function zbGuagua_0.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbGuagua_0.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbGuagua_0.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Default
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.moveFrame = 0.03333333333333333
	arg_2_0.groundFrame = 0.3
	arg_2_0.hitFrame = 0.8333333333333334
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbGuagua_0.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)

		local var_4_0 = g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)

		if var_4_0 ~= nil then
			var_4_0:setPosition(arg_3_0.hero.destPos)
		end
	end

	local function var_3_1()
		for iter_5_0, iter_5_1 in pairs(arg_3_0.targetList) do
			local var_5_0, var_5_1, var_5_2 = g_CombatFormula:calcDamage(arg_3_0.hero, iter_5_1, arg_3_0)

			if var_5_1 > 0 then
				iter_5_1:playBehitAnimation(arg_3_0.skillRecord.hitEffectId, arg_3_0)

				if arg_3_0:isQteRedoing() == false and zbCombatFormula:isSucceedRate(200) then
					local var_5_3 = BUFF_TYPE_PROPERTY_HP_ZHONGDU
					local var_5_4 = -arg_3_0.hero.physicAttack * 0.25
					local var_5_5 = 0
					local var_5_6 = 2

					g_BuffSystem:createBuff(arg_3_0.hero, iter_5_1, var_5_3, var_5_4, var_5_5, var_5_6)
				end
			end
		end
	end

	local function var_3_2()
		arg_3_0:enterIdle()
	end

	local function var_3_3()
		arg_3_0.actioning = false
	end

	arg_3_0.actioning = true
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.getn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_4 = arg_3_0.targetList[1]:getBeattackPosition(arg_3_0.hero, arg_3_0.skillSeqIndex)

	arg_3_0.hero:setMovingFlag(true)
	arg_3_0.hero:setDesPos(var_3_4.x, var_3_4.y)

	local var_3_5 = CCArray:create()

	if arg_3_0:isQteRedoing() == false and arg_3_0.hero.guaguaSkill4 ~= nil then
		arg_3_0.hero.guaguaSkill4:actionEx(var_3_5)
	end

	var_3_5:addObject(CCCallFuncN:create(var_3_0))
	var_3_5:addObject(CCDelayTime:create(arg_3_0.moveFrame))
	var_3_5:addObject(CCMoveTo:create(arg_3_0.groundFrame - arg_3_0.moveFrame, var_3_4))
	var_3_5:addObject(CCDelayTime:create(arg_3_0.hitFrame - arg_3_0.groundFrame))
	var_3_5:addObject(CCCallFuncN:create(var_3_1))
	var_3_5:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame, 0.1)))
	var_3_5:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_3_0.hero:getFixPosition()))
	var_3_5:addObject(CCCallFuncN:create(var_3_2))
	var_3_5:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_5:addObject(CCCallFuncN:create(var_3_3))

	local var_3_6 = CCSequence:create(var_3_5)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_6)
end

function zbGuagua_0.getDamageRatio(arg_8_0, arg_8_1)
	return 0.8
end
