require("gamecore.skill.zbBaseSkill")

zbMuluoxianren_0 = class("zbMuluoxianren_0", zbBaseSkill)
zbMuluoxianren_0.__index = zbMuluoxianren_0

function zbMuluoxianren_0.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbMuluoxianren_0.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbMuluoxianren_0.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Default
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.targetFrame = 0.6
	arg_2_0.hitFrame = 0.23333333333333334
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbMuluoxianren_0.action(arg_3_0)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_1()
		for iter_5_0, iter_5_1 in pairs(arg_3_0.targetList) do
			g_EffectSystem:createInstantEffect(iter_5_1, arg_3_0.skillRecord.targetEffectId)
		end
	end

	local function var_3_2()
		for iter_6_0, iter_6_1 in pairs(arg_3_0.targetList) do
			local var_6_0, var_6_1, var_6_2 = g_CombatFormula:calcDamage(arg_3_0.hero, iter_6_1, arg_3_0)

			if var_6_1 > 0 then
				iter_6_1:playBehitAnimation(0, arg_3_0)

				if arg_3_0:isQteRedoing() == false then
					if arg_3_0.hero.muluoSkill4 ~= nil and g_BuffSystem:heroHasZhongziDebuff(iter_6_1) then
						for iter_6_2 = 1, 5 do
							local var_6_3 = false
							local var_6_4 = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), ETargetType.Random_1, arg_3_0:getSubTargetType())

							for iter_6_3, iter_6_4 in pairs(var_6_4) do
								if iter_6_4:isSame(iter_6_1) == false and g_BuffSystem:heroHasZhongziDebuff(iter_6_4) == false then
									local var_6_5, var_6_6, var_6_7 = g_CombatFormula:calcDamage(arg_3_0.hero, iter_6_4, arg_3_0)

									if var_6_6 > 0 then
										iter_6_4:playBehitAnimation(1001, arg_3_0)
									end

									var_6_3 = true

									break
								end
							end

							if var_6_3 then
								break
							end
						end
					end

					if arg_3_0.hero.muluoSkill3 ~= nil then
						g_BuffSystem:createZhongziDebuff(arg_3_0.hero, iter_6_1, arg_3_0.hero.muluoSkill3:getDamageRatio(), arg_3_0.hero.muluoSkill3:getDamageAbs())
					end
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

	arg_3_0.actioning = true
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.getn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	local var_3_5 = CCArray:create()

	if arg_3_0:isQteRedoing() == false and arg_3_0.hero.shanxin4Skill ~= nil then
		arg_3_0.hero.shanxin4Skill:actionEx(var_3_5)
	end

	var_3_5:addObject(CCCallFuncN:create(var_3_0))
	var_3_5:addObject(CCDelayTime:create(arg_3_0.targetFrame))
	var_3_5:addObject(CCCallFuncN:create(var_3_1))
	var_3_5:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	var_3_5:addObject(CCCallFuncN:create(var_3_2))
	var_3_5:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame - arg_3_0.targetFrame, 0.1)))
	var_3_5:addObject(CCCallFuncN:create(var_3_3))
	var_3_5:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_5:addObject(CCCallFuncN:create(var_3_4))

	local var_3_6 = CCSequence:create(var_3_5)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_6)
end

function zbMuluoxianren_0.getDamageRatio(arg_9_0, arg_9_1)
	return 1
end
