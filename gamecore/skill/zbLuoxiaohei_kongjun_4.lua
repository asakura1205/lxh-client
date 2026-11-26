require("gamecore.skill.zbBaseSkill")

zbLuoxiaohei_kongjun_4 = class("zbLuoxiaohei_kongjun_4", zbBaseSkill)
zbLuoxiaohei_kongjun_4.__index = zbLuoxiaohei_kongjun_4

function zbLuoxiaohei_kongjun_4.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbLuoxiaohei_kongjun_4.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbLuoxiaohei_kongjun_4.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Enemy
	arg_2_0.targetType = ETargetType.Random_5
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.targetFrame = 0.5
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
	arg_2_0.hitIndex = 0
	arg_2_0.hero.lxhkjSkill4 = arg_2_0
end

function zbLuoxiaohei_kongjun_4.actionEx(arg_3_0, arg_3_1)
	local function var_3_0()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:setAnimation(arg_3_0.sequenceName, false)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_1()
		local var_5_0 = arg_3_0.targetList[1].forceType
		local var_5_1 = getCombatHeroPos(var_5_0, 5)

		g_EffectSystem:createBombEffect(arg_3_0.hero, var_5_0, var_5_1, arg_3_0.skillRecord.targetEffectId, 0)
	end

	local function var_3_2()
		arg_3_0.hero.energy:clearCount()

		arg_3_0.hitIndex = arg_3_0.hitIndex + 1

		local var_6_0 = arg_3_0.targetList[arg_3_0.hitIndex]

		if var_6_0 ~= nil then
			local var_6_1, var_6_2, var_6_3 = g_CombatFormula:calcDamage(arg_3_0.hero, var_6_0, arg_3_0)

			if var_6_2 > 0 then
				var_6_0:playBehitAnimation(arg_3_0.skillRecord.hitEffectId, arg_3_0)
			end
		end
	end

	if arg_3_0.hero.energy:getCount() < 3 then
		return
	end

	arg_3_0.hitIndex = 0
	arg_3_0.actioning = true
	arg_3_0.targetList = zbTargetHandler:selectTarget(arg_3_0.hero, arg_3_0, arg_3_0:getSideType(), arg_3_0:getTargetType(), arg_3_0:getSubTargetType())

	if table.getn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	arg_3_1:addObject(CCCallFuncN:create(var_3_0))
	arg_3_1:addObject(CCDelayTime:create(arg_3_0.targetFrame))
	arg_3_1:addObject(CCCallFuncN:create(var_3_1))
	arg_3_1:addObject(CCDelayTime:create(0.4))

	for iter_3_0, iter_3_1 in pairs(arg_3_0.targetList) do
		arg_3_1:addObject(CCDelayTime:create(0.26666666666666666))
		arg_3_1:addObject(CCCallFuncN:create(var_3_2))
	end

	arg_3_1:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.targetFrame - 0.4 - table.getn(arg_3_0.targetList) * 8 / 30, 0.1)))
end

function zbLuoxiaohei_kongjun_4.getDamageRatio(arg_7_0, arg_7_1)
	return 0.15
end
