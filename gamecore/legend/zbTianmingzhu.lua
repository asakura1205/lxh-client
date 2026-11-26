require("gamecore.legend.zbBaseLegendSkill")

zbTianmingzhu = class("zbTianmingzhu", zbBaseLegendSkill)
zbTianmingzhu.__index = zbTianmingzhu

function zbTianmingzhu.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbTianmingzhu.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbTianmingzhu.initMy(arg_2_0)
	return
end

function zbTianmingzhu.newRound(arg_3_0)
	return
end

function zbTianmingzhu.action1(arg_4_0)
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
			local var_6_3 = g_EffectSystem:createBombEffect(var_6_0, var_6_1, var_6_2, 6610100, 0)

			if var_6_3 ~= nil then
				var_6_3:setRotationY(0)
			end
		else
			local var_6_4 = g_EffectSystem:createBombEffect(var_6_0, var_6_1, var_6_2, 6610101, 0)

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

		g_EffectSystem:createBombEffect(var_7_0, var_7_1, var_7_2, 6610102, 0)
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
		g_Audio:playSound("audio/sound/bomb_2.mp3")
	end

	local function var_4_6()
		local var_11_0, var_11_1, var_11_2 = arg_4_0:getSkillValue(1)

		arg_4_0.targetList = g_CombatSystem:getHeros(getFlipForceType(arg_4_0.forceType), true)

		for iter_11_0, iter_11_1 in pairs(arg_4_0.targetList) do
			g_Audio:playSound("sound/bomb_2.mp3")

			local var_11_3 = var_11_1

			g_CombatFormulaLegend:calcLegendDamage(iter_11_1, EAttackType.Magic, var_11_3)

			if var_11_3 > 0 then
				iter_11_1:playBehitAnimation(1002, nil, true)
				g_Audio:playSound("audio/sound/bomb_1.mp3")

				if g_FirstCombat:isActive() == false and zbCombatFormula:isSucceedRate(var_11_2 * 10) then
					g_BuffSystem:createControlBuff(iter_11_1, iter_11_1, BUFF_TYPE_CONTROL_HUNMI)
				end
			end
		end
	end

	local function var_4_7()
		arg_4_0.actioning = false

		if g_FirstCombat:isActive() then
			g_FirstCombat:onLegendSkillOver()
		end
	end

	arg_4_0.actioning = true
	arg_4_0.targetList = g_CombatSystem:getHeros(getFlipForceType(arg_4_0.forceType), true)

	if table.maxn(arg_4_0.targetList) <= 0 then
		return
	end

	local var_4_8 = CCArray:create()

	var_4_8:addObject(CCCallFuncN:create(var_4_1))
	var_4_8:addObject(CCDelayTime:create(2.2666666666666666))
	var_4_8:addObject(CCCallFuncN:create(var_4_2))
	var_4_8:addObject(CCDelayTime:create(2.566666666666667))
	var_4_8:addObject(CCCallFuncN:create(var_4_5))
	var_4_8:addObject(CCDelayTime:create(0.16666666666666666))
	var_4_8:addObject(CCCallFuncN:create(var_4_3))
	var_4_8:addObject(CCCallFuncN:create(var_4_6))
	var_4_8:addObject(CCDelayTime:create(1.7666666666666666))
	var_4_8:addObject(CCCallFuncN:create(var_4_7))

	local var_4_9 = CCSequence:create(var_4_8)

	arg_4_0.legend.nodeAction:stopAllActions()
	arg_4_0.legend.nodeAction:runAction(var_4_9)
end

function zbTianmingzhu.action2(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if arg_13_0:isFriend(arg_13_1) then
		arg_13_1:addMagicAttack(arg_13_2)
		arg_13_1:addHit(arg_13_3 * 10)
	end
end

function zbTianmingzhu.action3(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if arg_14_0:isFriend(arg_14_1) then
		arg_14_1:addBlock(arg_14_3 * 10)
	else
		arg_14_1:addMagicAttack(-arg_14_2)
	end
end

function zbTianmingzhu.action4(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	if arg_15_0:isFriend(arg_15_1) then
		arg_15_1:addMagicDefend(arg_15_2)
		arg_15_1:addTough(arg_15_3 * 10)
	end
end

function zbTianmingzhu.action5(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if arg_16_0:isFriend(arg_16_1) then
		arg_16_1:addHit(arg_16_3 * 10)
	else
		arg_16_1:addMagicDefend(-arg_16_2)
	end
end

function zbTianmingzhu.action6(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if arg_17_0:isFriend(arg_17_1) then
		arg_17_1:addPierceDamage(arg_17_3 * 10)
	else
		arg_17_1:reduceBuffMaxHpPoint(arg_17_2)
	end
end

function zbTianmingzhu.action7(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if arg_18_0:isFriend(arg_18_1) then
		arg_18_1:addViolent(arg_18_3 * 10)
	else
		arg_18_1:addBuffRoundHp(-arg_18_2)
	end
end

function zbTianmingzhu.action8(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	if arg_19_0:isFriend(arg_19_1) then
		arg_19_1:addMagicAttack(arg_19_2)
	end
end

function zbTianmingzhu.action9(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_0:isFriend(arg_20_1) then
		arg_20_1:addPierceDamage(arg_20_2)
	end
end
