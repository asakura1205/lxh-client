require("gamecore.skill.zbBaseSkill")

zbLuoxiaohei_moli_2 = class("zbLuoxiaohei_moli_2", zbBaseSkill)
zbLuoxiaohei_moli_2.__index = zbLuoxiaohei_moli_2

function zbLuoxiaohei_moli_2.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbLuoxiaohei_moli_2.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbLuoxiaohei_moli_2.initMy(arg_2_0)
	arg_2_0.sideType = ESideType.Self
	arg_2_0.targetType = ETargetType.Random_1
	arg_2_0.subTargetType = ESubTargetType.All
	arg_2_0.hitFrame = 0.5
	arg_2_0.skillDurationTime = arg_2_0.hero.anim:getAnimDuration(arg_2_0.sequenceName)
end

function zbLuoxiaohei_moli_2.action(arg_3_0)
	local function var_3_0(arg_4_0)
		local var_4_0 = arg_3_0.hero.forceType

		if arg_3_0.hero:isMeihuo() then
			var_4_0 = getFlipForceType(arg_3_0.hero.forceType)
		end

		local var_4_1
		local var_4_2 = g_CombatSystem:getHeros(var_4_0, true)

		for iter_4_0, iter_4_1 in pairs(var_4_2) do
			local var_4_3 = false

			for iter_4_2, iter_4_3 in pairs(arg_4_0) do
				if iter_4_1:isSame(iter_4_3) then
					var_4_3 = true

					break
				end
			end

			if var_4_3 == false and (var_4_1 == nil or iter_4_1:getHpPercent() < var_4_1:getHpPercent()) then
				var_4_1 = iter_4_1
			end
		end

		if var_4_1 ~= nil then
			table.insert(arg_4_0, var_4_1)
		end
	end

	local function var_3_1()
		arg_3_0:popupSkillBubble()
		arg_3_0.hero.anim:playAnimationOnce(arg_3_0.sequenceName, arg_3_0.hero:getIdleWeakSequence(), 0.125)
		g_EffectSystem:createInstantEffect(arg_3_0.hero, arg_3_0.skillRecord.riseEffectId)
	end

	local function var_3_2()
		for iter_6_0, iter_6_1 in pairs(arg_3_0.targetList) do
			g_CombatFormulaCure:calcCure(arg_3_0.hero, iter_6_1, arg_3_0)
			g_EffectSystem:createInstantEffect(iter_6_1, arg_3_0.skillRecord.targetEffectId)
		end
	end

	local function var_3_3()
		arg_3_0:enterIdle()
	end

	local function var_3_4()
		arg_3_0.actioning = false
	end

	arg_3_0.targetList = {}

	if zbCombatFormula:isSucceedRate(500) then
		var_3_0(arg_3_0.targetList)
		var_3_0(arg_3_0.targetList)
	else
		var_3_0(arg_3_0.targetList)
		var_3_0(arg_3_0.targetList)
		var_3_0(arg_3_0.targetList)
	end

	if table.maxn(arg_3_0.targetList) == 0 then
		arg_3_0.actioning = false

		return
	end

	arg_3_0.actioning = true

	local var_3_5 = CCArray:create()

	if arg_3_0:isQteRedoing() == false and arg_3_0.hero.lxhMoliSkill3 ~= nil then
		arg_3_0.hero.lxhMoliSkill3:actionEx(var_3_5)
	end

	var_3_5:addObject(CCCallFuncN:create(var_3_1))
	var_3_5:addObject(CCDelayTime:create(arg_3_0.hitFrame))
	var_3_5:addObject(CCCallFuncN:create(var_3_2))
	var_3_5:addObject(CCDelayTime:create(math.max(arg_3_0.skillDurationTime - arg_3_0.hitFrame, 0.1)))
	var_3_5:addObject(CCMoveTo:create(FIGHT_RETREAT_TIME, arg_3_0.hero:getFixPosition()))
	var_3_5:addObject(CCCallFuncN:create(var_3_3))
	var_3_5:addObject(CCDelayTime:create(FIGHT_NORMALWAIT_TIME))
	var_3_5:addObject(CCCallFuncN:create(var_3_4))

	local var_3_6 = CCSequence:create(var_3_5)

	arg_3_0.hero:stopAllActions()
	arg_3_0.hero:runAction(var_3_6)
end

function zbLuoxiaohei_moli_2.getDamageRatio(arg_9_0, arg_9_1)
	return 0.5
end
