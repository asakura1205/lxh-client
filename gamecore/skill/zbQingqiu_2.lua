require("gamecore.skill.zbBaseSkill")

zbQingqiu_2 = class("zbQingqiu_2", zbBaseSkill)
zbQingqiu_2.__index = zbQingqiu_2

function zbQingqiu_2.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbQingqiu_2.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbQingqiu_2.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Default
	arg_2_0.subTargetType = ESubTargetType.Ten
	arg_2_0.targetFrame = 0.16666666666666666
	arg_2_0.hitFrame1 = arg_2_0.targetFrame + 0.6666666666666666
	arg_2_0.hitFrame2 = arg_2_0.targetFrame + 0.8666666666666667
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbQingqiu_2.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseAttackEffectId)
	end

	local function var_3_1()
		for iter_5_0, iter_5_1 in pairs(arg_3_0.targetList) do
			g_EffectSystem:createInstantEffect(iter_5_1, arg_3_0.skillRecord.targetEffectId)
		end
	end

	local function var_3_2()
		local var_6_0 = arg_3_0.targetList[1]

		if var_6_0 ~= nil then
			local var_6_1, var_6_2, var_6_3 = g_CombatFormula:calcDamage(arg_3_0.hero, var_6_0, arg_3_0)

			if var_6_2 > 0 then
				var_6_0:playBehitAnimation(arg_3_0.skillRecord.hitEffectId, arg_3_0)
			end
		end
	end

	local function var_3_3()
		local var_7_0 = arg_3_0.targetList[1]

		for iter_7_0, iter_7_1 in pairs(arg_3_0.targetList) do
			if iter_7_1:isSame(var_7_0) == false then
				local var_7_1, var_7_2, var_7_3 = g_CombatFormula:calcDamage(arg_3_0.hero, iter_7_1, arg_3_0)

				if var_7_2 > 0 then
					iter_7_1:playBehitAnimation(arg_3_0.skillRecord.hitEffectId, arg_3_0)

					if var_7_0 ~= nil and var_7_0:isZhongshang() then
						g_BuffSystem:createControlBuff(arg_3_0.hero, iter_7_1, BUFF_TYPE_CONTROL_ZHONGSHANG)
					end
				end
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

	local var_3_6 = CCArray:create()

	if arg_3_0.hero.qingqiuSkill3 ~= nil then
		arg_3_0.hero.qingqiuSkill3:actionEx(var_3_6)
	end

	var_3_6:addObject(CCCallFuncN:create(var_3_0))
	var_3_6:addObject(CCDelayTime:create(arg_3_0.targetFrame))
	var_3_6:addObject(CCCallFuncN:create(var_3_1))
	var_3_6:addObject(CCDelayTime:create(arg_3_0.hitFrame1 - arg_3_0.targetFrame))
	var_3_6:addObject(CCCallFuncN:create(var_3_2))
	var_3_6:addObject(CCDelayTime:create(arg_3_0.hitFrame2 - arg_3_0.hitFrame1))
	var_3_6:addObject(CCCallFuncN:create(var_3_3))
	var_3_6:addObject(CCCallFuncN:create(var_3_4))

	local var_3_7 = math.max(1.8333333333333333 - arg_3_0.hitFrame2 + arg_3_0.targetFrame, 0.1)

	var_3_6:addObject(CCDelayTime:create(var_3_7))
	var_3_6:addObject(CCCallFuncN:create(var_3_5))

	local var_3_8 = CCSequence:create(var_3_6)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_8)
end

function zbQingqiu_2.getDamageRatio(arg_10_0, arg_10_1)
	return 1
end
