require("gamecore.legend.zbBaseLegendSkill")

zbRuyijie = class("zbRuyijie", zbBaseLegendSkill)
zbRuyijie.__index = zbRuyijie

function zbRuyijie.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbRuyijie.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbRuyijie.initMy(arg_2_0)
	arg_2_0.hitIndex = 0
end

function zbRuyijie.newRound(arg_3_0)
	return
end

function zbRuyijie.action1(arg_4_0)
	local function var_4_0()
		local var_5_0 = g_CombatSystem:getHeros(arg_4_0.forceType)

		for iter_5_0, iter_5_1 in pairs(var_5_0) do
			return iter_5_1
		end

		return nil
	end

	local function var_4_1()
		g_LegendSkillSystem.legendDarkNode:showDarkNode()
		g_CombatSystem.combatData.leftPlayer:pause()
		g_CombatSystem.combatData.rightPlayer:pause()

		local var_6_0 = var_4_0()
		local var_6_1 = var_6_0.forceType
		local var_6_2 = ccp(568, 320)

		if var_6_1 == ForceType.Left then
			local var_6_3 = g_EffectSystem:createBombEffect(var_6_0, var_6_1, var_6_2, 6650100, 0)

			if var_6_3 ~= nil then
				var_6_3:setRotationY(0)
			end
		else
			local var_6_4 = g_EffectSystem:createBombEffect(var_6_0, var_6_1, var_6_2, 6650101, 0)

			if var_6_4 ~= nil then
				var_6_4:setRotationY(180)
			end
		end

		g_Audio:playSound("audio/sound/legend_jinguangxuanmu.mp3")
	end

	local function var_4_2()
		local var_7_0 = var_4_0()
		local var_7_1 = var_7_0.forceType
		local var_7_2 = getCombatHeroPos(getFlipForceType(var_7_1), 5)

		g_EffectSystem:createBombEffect(var_7_0, var_7_1, var_7_2, 6650102, 0)
		g_Audio:playSound("audio/sound/legend_jinguangxuanmu.mp3")
	end

	local function var_4_3()
		g_LegendSkillSystem.legendDarkNode:hideDarkNode()
		g_CombatSystem.combatData.leftPlayer:resume()
		g_CombatSystem.combatData.rightPlayer:resume()
	end

	local function var_4_4()
		g_Audio:playSound("audio/sound/skill_fire_attack.mp3")
	end

	local function var_4_5()
		return
	end

	local function var_4_6()
		local var_11_0 = var_4_0()

		arg_4_0.randomIndex = arg_4_0.randomIndex + 1

		local var_11_1 = arg_4_0.randomList[arg_4_0.randomIndex]
		local var_11_2 = getFlipForceType(arg_4_0.forceType)
		local var_11_3 = getCombatHeroPos(var_11_2, var_11_1)

		g_EffectSystem:createBombEffect(var_11_0, var_11_2, var_11_3, 6650103, 0)
		g_Audio:playSound("audio/sound/bomb_1.mp3")

		local var_11_4

		for iter_11_0, iter_11_1 in pairs(arg_4_0.targetList) do
			if iter_11_1:getFormationIndex() == var_11_1 then
				var_11_4 = iter_11_1
			end
		end

		if var_11_4 ~= nil then
			local var_11_5, var_11_6, var_11_7 = arg_4_0:getSkillValue(1)
			local var_11_8 = var_11_6

			g_CombatFormulaLegend:calcLegendDamage(var_11_4, EAttackType.Magic, var_11_8)
			var_11_4:playBehitAnimation(1001, nil, true)
			g_Audio:playSound("audio/sound/attack_quantou.mp3")
		end
	end

	local function var_4_7()
		arg_4_0.actioning = false

		if g_FirstCombat:isActive() then
			g_FirstCombat:onLegendSkillOver()
		end
	end

	arg_4_0.actioning = true
	arg_4_0.hitIndex = 0
	arg_4_0.targetList = g_CombatSystem:getHeros(getFlipForceType(arg_4_0.forceType), true)

	if table.maxn(arg_4_0.targetList) <= 0 then
		return
	end

	local var_4_8 = {
		1,
		2,
		3,
		4,
		5,
		6,
		7,
		8,
		9
	}

	arg_4_0.randomList = zbUtil.getRandomIndex(9, 9)
	arg_4_0.randomIndex = 0

	local var_4_9 = CCArray:create()

	var_4_9:addObject(CCCallFuncN:create(var_4_1))
	var_4_9:addObject(CCDelayTime:create(2.2666666666666666))
	var_4_9:addObject(CCCallFuncN:create(var_4_2))
	var_4_9:addObject(CCDelayTime:create(2.566666666666667))
	var_4_9:addObject(CCCallFuncN:create(var_4_5))
	var_4_9:addObject(CCDelayTime:create(0.16666666666666666))

	local var_4_10 = 0

	for iter_4_0 = 1, 9 do
		local var_4_11 = 0.065 + zbCombatFormula:randomRange(0, 0.095)

		var_4_9:addObject(CCDelayTime:create(var_4_11))
		var_4_9:addObject(CCCallFuncN:create(var_4_6))

		var_4_10 = var_4_10 + var_4_11
	end

	var_4_9:addObject(CCCallFuncN:create(var_4_3))
	var_4_9:addObject(CCDelayTime:create(math.max(1.6 - var_4_10, 0.1)))
	var_4_9:addObject(CCCallFuncN:create(var_4_7))

	local var_4_12 = CCSequence:create(var_4_9)

	arg_4_0.legend.nodeAction:stopAllActions()
	arg_4_0.legend.nodeAction:runAction(var_4_12)
end

function zbRuyijie.action2(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if arg_13_0:isFriend(arg_13_1) then
		arg_13_1:addPierceDamage(arg_13_3 * 10)
	else
		arg_13_1:addMagicDefend(-arg_13_2)
	end
end

function zbRuyijie.action3(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if arg_14_0:isFriend(arg_14_1) then
		arg_14_1:addHit(arg_14_3 * 10)
	else
		arg_14_1:addPhysicDefend(-arg_14_2)
	end
end

function zbRuyijie.action4(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	if arg_15_0:isFriend(arg_15_1) then
		-- block empty
	else
		arg_15_1:reduceBuffMaxHpPoint(-arg_15_2)
		arg_15_1:addBlock(-arg_15_3 * 10)
	end
end

function zbRuyijie.action5(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if arg_16_0:isFriend(arg_16_1) then
		arg_16_1:addMagicAttack(arg_16_2)
	else
		arg_16_1:addDodge(-arg_16_3 * 10)
	end
end

function zbRuyijie.action6(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if arg_17_0:isFriend(arg_17_1) then
		arg_17_1:addPhysicAttack(arg_17_2)
		arg_17_1:addViolent(arg_17_3 * 10)
	end
end

function zbRuyijie.action7(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if arg_18_0:isFriend(arg_18_1) then
		-- block empty
	else
		arg_18_1:addBuffRoundHp(-arg_18_2)
		arg_18_1:addTough(-arg_18_3 * 10)
	end
end

function zbRuyijie.action8(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	if arg_19_0:isFriend(arg_19_1) then
		arg_19_1:addMagicAttack(arg_19_2)
	end
end

function zbRuyijie.action9(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_0:isFriend(arg_20_1) then
		arg_20_1:addPhysicAttack(arg_20_2)
	end
end
