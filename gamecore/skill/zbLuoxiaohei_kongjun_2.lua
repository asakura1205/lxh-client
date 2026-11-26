require("gamecore.skill.zbBaseSkill")

zbLuoxiaohei_kongjun_2 = class("zbLuoxiaohei_kongjun_2", zbBaseSkill)
zbLuoxiaohei_kongjun_2.__index = zbLuoxiaohei_kongjun_2

function zbLuoxiaohei_kongjun_2.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbLuoxiaohei_kongjun_2.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbLuoxiaohei_kongjun_2.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Random_5
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.soundFrame = 0.5
	arg_2_0.hitFrame = 0.6666666666666666
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.hitIndex = 0
end

function zbLuoxiaohei_kongjun_2.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_1()
		g_Audio:playSound("audio/sound/rise_jiguanqian.mp3")
	end

	local function var_3_2()
		arg_3_0.hitIndex = arg_3_0.hitIndex + 1

		local var_6_0 = arg_3_0.targetList[arg_3_0.hitIndex]

		if var_6_0 ~= nil then
			local var_6_1, var_6_2, var_6_3 = g_CombatFormula:calcDamage(arg_3_0.hero, var_6_0, arg_3_0)

			if var_6_2 > 0 then
				var_6_0:playBehitAnimation(arg_3_0.skillRecord.hitEffectId, arg_3_0)

				if zbCombatFormula:isSucceedRate(200) then
					g_BuffSystem:createControlBuff(arg_3_0.hero, var_6_0, BUFF_TYPE_CONTROL_CHENMO)
					arg_3_0.hero.energy:addCount()
				end
			end
		end
	end

	local function var_3_3()
		arg_3_0:enterIdle()
	end

	local function var_3_4()
		arg_3_0.actioning = false
	end

	arg_3_0.hitIndex = 0
	arg_3_0.actioning = true
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.getn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_5 = getCombatHeroPos(arg_3_0.targetList[1].forceType, 5)
	local var_3_6 = ccp(arg_3_0.hero:getPositionX(), var_3_5.y)

	if arg_3_0.hero.forceType == ForceType.Left then
		var_3_6.x = var_3_5.x - var_3_6.x - 400
	else
		var_3_6.x = -(var_3_5.x - var_3_6.x - 400)
	end

	arg_3_0.hero:setMovingFlag(true)
	arg_3_0.hero:setDesPos(var_3_6.x, var_3_6.y)

	local var_3_7 = CCArray:create()

	if arg_3_0.hero.lxhkjSkill3 ~= nil then
		arg_3_0.hero.lxhkjSkill3:actionEx(var_3_7)
	end

	if arg_3_0.hero.lxhkjSkill4 ~= nil then
		arg_3_0.hero.lxhkjSkill4:actionEx(var_3_7)
	end

	var_3_7:addObject(CCMoveTo:create(FIGHT_CHARGE_TIME, var_3_6))
	var_3_7:addObject(CCCallFuncN:create(var_3_0))
	var_3_7:addObject(CCDelayTime:create(arg_3_0.soundFrame))
	var_3_7:addObject(CCCallFuncN:create(var_3_1))
	var_3_7:addObject(CCDelayTime:create(arg_3_0.hitFrame - arg_3_0.soundFrame))

	for iter_3_0, iter_3_1 in pairs(arg_3_0.targetList) do
		var_3_7:addObject(CCCallFuncN:create(var_3_2))
		var_3_7:addObject(CCDelayTime:create(0.26666666666666666))
	end

	var_3_7:addObject(CCCallFuncN:create(var_3_2))
	var_3_7:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame - 0.26666666666666666 * table.getn(arg_3_0.targetList), 0.1)))
	var_3_7:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_3_0.hero:getFixPosition()))
	var_3_7:addObject(CCCallFuncN:create(var_3_3))
	var_3_7:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_7:addObject(CCCallFuncN:create(var_3_4))

	local var_3_8 = CCSequence:create(var_3_7)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_8)
end

function zbLuoxiaohei_kongjun_2.getDamageRatio(arg_9_0, arg_9_1)
	return 0.5
end
