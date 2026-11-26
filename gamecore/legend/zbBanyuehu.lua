require("gamecore.legend.zbBaseLegendSkill")

zbBanyuehu = class("zbBanyuehu", zbBaseLegendSkill)
zbBanyuehu.__index = zbBanyuehu

function zbBanyuehu.create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = zbBanyuehu.new()

	var_1_0:initBase(arg_1_1, arg_1_2)
	var_1_0:initMy()

	return var_1_0
end

function zbBanyuehu.initMy(arg_2_0)
	arg_2_0.hitIndex = 0
end

function zbBanyuehu.action1(arg_3_0)
	local function var_3_0()
		local var_4_0 = g_CombatSystem:getHeros(arg_3_0.forceType)

		for iter_4_0, iter_4_1 in pairs(var_4_0) do
			return iter_4_1
		end

		return nil
	end

	local function var_3_1()
		g_LegendSkillSystem.legendDarkNode:showDarkNode()
		g_CombatSystem.combatData.leftPlayer:pause()
		g_CombatSystem.combatData.rightPlayer:pause()

		local var_5_0 = var_3_0()
		local var_5_1 = var_5_0.forceType
		local var_5_2 = ccp(568, 320)

		if var_5_1 == ForceType.Left then
			local var_5_3 = g_EffectSystem:createBombEffect(var_5_0, var_5_1, var_5_2, 6630100, 0)

			if var_5_3 ~= nil then
				var_5_3:setRotationY(0)
			end
		else
			local var_5_4 = g_EffectSystem:createBombEffect(var_5_0, var_5_1, var_5_2, 6630101, 0)

			if var_5_4 ~= nil then
				var_5_4:setRotationY(180)
			end
		end

		g_Audio:playSound("audio/sound/legend_jinguangxuanmu.mp3")
	end

	local function var_3_2()
		local var_6_0 = var_3_0()
		local var_6_1 = var_6_0.forceType
		local var_6_2 = getCombatHeroPos(var_6_1, 5)

		g_EffectSystem:createBombEffect(var_6_0, var_6_1, var_6_2, 6630102, 0)
		g_Audio:playSound("audio/sound/legend_jinguangxuanmu.mp3")
	end

	local function var_3_3()
		g_LegendSkillSystem.legendDarkNode:hideDarkNode()
		g_CombatSystem.combatData.leftPlayer:resume()
		g_CombatSystem.combatData.rightPlayer:resume()
	end

	local function var_3_4()
		return
	end

	local function var_3_5()
		arg_3_0.hitIndex = arg_3_0.hitIndex + 1

		local var_9_0 = arg_3_0.targetList[arg_3_0.hitIndex]

		if var_9_0 ~= nil then
			local var_9_1, var_9_2, var_9_3 = arg_3_0:getSkillValue(1)
			local var_9_4 = var_9_2 * zbCombatFormula:randomRange(0.95, 1.05)

			g_EffectSystem:createInstantEffect(var_9_0, 6630103)
			var_9_0:addHp(var_9_4, false, 1)
			var_9_0:addMp(var_9_3)
			g_CombatBubble:showBubble(var_9_0, ECombatBubble.MpUp, 0, 0, 1)
		end

		g_Audio:playSound("audio/sound/cure.mp3")
	end

	local function var_3_6()
		arg_3_0.actioning = false

		if g_FirstCombat:isActive() then
			g_FirstCombat:onLegendSkillOver()
		end
	end

	arg_3_0.actioning = true
	arg_3_0.hitIndex = 0
	arg_3_0.targetList = g_CombatSystem:getHeros(arg_3_0.forceType, true)

	if table.maxn(arg_3_0.targetList) <= 0 then
		return
	end

	local var_3_7 = CCArray:create()

	var_3_7:addObject(CCCallFuncN:create(var_3_1))
	var_3_7:addObject(CCDelayTime:create(2.2666666666666666))
	var_3_7:addObject(CCCallFuncN:create(var_3_2))
	var_3_7:addObject(CCDelayTime:create(2.566666666666667))
	var_3_7:addObject(CCCallFuncN:create(var_3_4))
	var_3_7:addObject(CCDelayTime:create(0.16666666666666666))

	local var_3_8 = 0

	for iter_3_0, iter_3_1 in pairs(arg_3_0.targetList) do
		var_3_7:addObject(CCCallFuncN:create(var_3_5))
		var_3_7:addObject(CCDelayTime:create(0.3333333333333333))

		var_3_8 = var_3_8 + 0.3333333333333333
	end

	var_3_7:addObject(CCDelayTime:create(math.max(1.6 - var_3_8, 0.1)))
	var_3_7:addObject(CCCallFuncN:create(var_3_3))
	var_3_7:addObject(CCDelayTime:create(0.6666666666666666))
	var_3_7:addObject(CCCallFuncN:create(var_3_6))

	local var_3_9 = CCSequence:create(var_3_7)

	arg_3_0.legend.nodeAction:stopAllActions()
	arg_3_0.legend.nodeAction:runAction(var_3_9)
end

function zbBanyuehu.action2(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_0:isFriend(arg_11_1) then
		arg_11_1:addMagicDefend(arg_11_2)
		arg_11_1:addDodge(arg_11_3 * 10)
	end
end

function zbBanyuehu.action3(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_0:isFriend(arg_12_1) then
		arg_12_1:addPierceDamage(arg_12_3 * 10)
	else
		arg_12_1:addMagicDefend(-arg_12_2)
	end
end

function zbBanyuehu.action4(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if arg_13_0:isFriend(arg_13_1) then
		arg_13_1:addMagicAttack(arg_13_2)
		arg_13_1:addViolent(arg_13_3 * 10)
	end
end

function zbBanyuehu.action5(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if arg_14_0:isFriend(arg_14_1) then
		arg_14_1:addDodge(arg_14_3 * 10)
	else
		arg_14_1:addMagicAttack(-arg_14_2)
	end
end

function zbBanyuehu.action6(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	if arg_15_0:isFriend(arg_15_1) then
		arg_15_1:addBlock(arg_15_3 * 10)
	else
		arg_15_1:reduceBuffMaxHpPoint(arg_15_2)
	end
end

function zbBanyuehu.action7(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if arg_16_0:isFriend(arg_16_1) then
		arg_16_1:addBuffRoundHp(arg_16_2)
		arg_16_1:addTough(arg_16_3 * 10)
	end
end

function zbBanyuehu.action8(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if arg_17_0:isFriend(arg_17_1) then
		arg_17_1:addPhysicDefend(arg_17_2)
	end
end

function zbBanyuehu.action9(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if arg_18_0:isFriend(arg_18_1) == false then
		arg_18_1:addBuffRoundHp(-arg_18_2)
	end
end
