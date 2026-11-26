require("gamecore.zbCombatGlobal")
require("gamecore.zbCombatDefine")
require("gamecore.zbHero")

local var_0_0 = class("zbCombatPlayer", CCNodeExtend)

var_0_0.__index = var_0_0

function var_0_0.extend(arg_1_0)
	local var_1_0 = tolua.getpeer(arg_1_0)

	if not var_1_0 then
		var_1_0 = {}

		tolua.setpeer(arg_1_0, var_1_0)
	end

	setmetatable(var_1_0, var_0_0)

	return arg_1_0
end

function createCombatPlayer(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = var_0_0.extend(CCNodeExtend.extend(CCNode:create()))

	var_2_0:init(arg_2_0, arg_2_1, arg_2_2)

	return var_2_0
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.forceType = arg_3_1
	arg_3_0.playerBaseInfo = arg_3_2
	arg_3_0.battleFormation = arg_3_3
	arg_3_0.heros = {}
	arg_3_0.combatScene = nil
	arg_3_0.curSection = 1
	arg_3_0.maxSection = table.getn(arg_3_0.battleFormation)

	arg_3_0:initLegend()
	arg_3_0:initHeros(1)
	arg_3_0:retain()
end

function var_0_0.free(arg_4_0)
	arg_4_0.legend:free()
	arg_4_0:clearHeros()
	arg_4_0:removeAllChildrenWithCleanup(true)
	arg_4_0:release()
end

function var_0_0.update(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.heros) do
		iter_5_1:update(arg_5_1)
	end

	arg_5_0.legend:update(arg_5_1)
end

function var_0_0.clearHeros(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.heros) do
		iter_6_1:free()
	end

	arg_6_0.heros = {}
end

function var_0_0.initLegend(arg_7_0)
	arg_7_0.legend = createCombatLegend(arg_7_0.forceType, arg_7_0.battleFormation[1].BattleGod)
end

function var_0_0.initHeros(arg_8_0, arg_8_1)
	local function var_8_0(arg_9_0, arg_9_1)
		if zbUtil:isValidTable(arg_9_1) == false then
			return
		end

		for iter_9_0, iter_9_1 in pairs(arg_9_1) do
			local var_9_0 = zbBuffTable:getRecord(iter_9_1)

			if var_9_0 ~= nil then
				g_BuffSystem:createBuff(arg_9_0, arg_9_0, var_9_0.id, var_9_0.param1, var_9_0.param2, var_9_0.round)
			else
				echo("warning: invalid buffId")
			end
		end
	end

	local var_8_1 = 1

	arg_8_0:clearHeros()

	if arg_8_0.battleFormation[arg_8_1] ~= nil then
		local var_8_2 = arg_8_0.battleFormation[arg_8_1].HeroList
		local var_8_3 = arg_8_0.battleFormation[arg_8_1].BuffList

		for iter_8_0, iter_8_1 in pairs(var_8_2) do
			if iter_8_1.HeroBaseInfo.Index <= 9 then
				if var_8_1 <= 5 then
					local var_8_4 = zbHero:create(arg_8_0.forceType, iter_8_1)

					if zbUtil:isValidTable(arg_8_0.playerBaseInfo) then
						var_8_4.fv = arg_8_0.playerBaseInfo.FV
					end

					table.insert(arg_8_0.heros, var_8_4)

					if var_8_3 ~= nil then
						var_8_0(var_8_4, var_8_3)
					end
				else
					echo("------warning--------- zbCombatPlayer:initHeros:" .. var_8_1)
				end

				var_8_1 = var_8_1 + 1
			end
		end

		arg_8_0:sortHeros()

		arg_8_0.curSection = arg_8_1
	end
end

function var_0_0.sortHeros(arg_10_0)
	table.sort(arg_10_0.heros, function(arg_11_0, arg_11_1)
		return arg_11_0:getFormationIndex() < arg_11_1:getFormationIndex()
	end)
end

function var_0_0.attachHeros(arg_12_0, arg_12_1)
	arg_12_0.combatScene = arg_12_1

	local function var_12_0(arg_13_0, arg_13_1)
		for iter_13_0, iter_13_1 in pairs(arg_12_0.heros) do
			if iter_13_1:getFormationIndex() == arg_13_0 then
				arg_12_1:addHero(iter_13_1, arg_13_1)

				break
			end
		end
	end

	var_12_0(1, 1)
	var_12_0(4, 2)
	var_12_0(7, 3)
	var_12_0(2, 11)
	var_12_0(5, 12)
	var_12_0(8, 13)
	var_12_0(3, 21)
	var_12_0(6, 22)
	var_12_0(9, 23)
end

function var_0_0.getMaxTotalHp(arg_14_0)
	local var_14_0 = 0

	for iter_14_0, iter_14_1 in pairs(arg_14_0.heros) do
		var_14_0 = var_14_0 + iter_14_1.maxHp
	end

	return var_14_0
end

function var_0_0.getCurTotalHp(arg_15_0)
	local var_15_0 = 0

	for iter_15_0, iter_15_1 in pairs(arg_15_0.heros) do
		var_15_0 = var_15_0 + iter_15_1.curHp
	end

	return var_15_0
end

function var_0_0.getHeroDiedCount(arg_16_0)
	local var_16_0 = 0

	for iter_16_0, iter_16_1 in pairs(arg_16_0.heros) do
		if iter_16_1:isDie() then
			var_16_0 = var_16_0 + 1
		end
	end

	return var_16_0
end

function var_0_0.isAllDied(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0.heros) do
		if iter_17_1:isDie() == false then
			return false
		end
	end

	return true
end

function var_0_0.isAllRealDied(arg_18_0)
	for iter_18_0, iter_18_1 in pairs(arg_18_0.heros) do
		if iter_18_1.isRealDied == false then
			return false
		end
	end

	return true
end

function var_0_0.isAllActionStoped(arg_19_0)
	for iter_19_0, iter_19_1 in pairs(arg_19_0.heros) do
		if iter_19_1:hasSkillExecing() then
			return false
		end
	end

	return true
end

function var_0_0.isLegendActionStoped(arg_20_0)
	if arg_20_0.legend ~= nil then
		return arg_20_0.legend:isExecBigSkilling() == false
	end

	return true
end

function var_0_0.getTotalDamageOut(arg_21_0)
	local var_21_0 = 0

	for iter_21_0, iter_21_1 in pairs(arg_21_0.heros) do
		var_21_0 = var_21_0 + iter_21_1:getDamageStat()
	end

	return var_21_0
end

function var_0_0.pause(arg_22_0)
	for iter_22_0, iter_22_1 in pairs(arg_22_0.heros) do
		iter_22_1:pause()
	end
end

function var_0_0.resume(arg_23_0)
	for iter_23_0, iter_23_1 in pairs(arg_23_0.heros) do
		iter_23_1:resume()
	end
end

function var_0_0.pauseExclude(arg_24_0, arg_24_1)
	if arg_24_1 ~= nil then
		arg_24_1:resume()
	end

	for iter_24_0, iter_24_1 in pairs(arg_24_0.heros) do
		if iter_24_1.isSame(arg_24_1) == false and iter_24_1:isExecBigSkilling() == false then
			iter_24_1:pause()
		end
	end
end

function var_0_0.resumeExclude(arg_25_0, arg_25_1)
	for iter_25_0, iter_25_1 in pairs(arg_25_0.heros) do
		if iter_25_1.isSame(arg_25_1) == false then
			iter_25_1:resume()
		end
	end
end

function var_0_0.getLivedHeroCount(arg_26_0)
	local var_26_0 = 0

	for iter_26_0, iter_26_1 in pairs(arg_26_0.heros) do
		if iter_26_1.curHp > 0 then
			var_26_0 = var_26_0 + 1
		end
	end

	return var_26_0
end

function var_0_0.getTotalHeroCount(arg_27_0)
	return table.getn(arg_27_0.heros)
end

function var_0_0.needNextSection(arg_28_0)
	return arg_28_0:isLastSection() == false and arg_28_0:curSectionIsOver()
end

function var_0_0.gotoNextSection(arg_29_0)
	g_CombatSystem.combatData.combatFocus:clearTarget()

	if arg_29_0.forceType == ForceType.Right and g_CombatSystem.combatData:getTrialType() == ETrialType.LimitRoundSurvival and arg_29_0.curSection >= arg_29_0.maxSection then
		arg_29_0.curSection = 0
	end

	if arg_29_0.curSection > arg_29_0.maxSection then
		return
	end

	arg_29_0:initHeros(arg_29_0.curSection + 1)
	arg_29_0:attachHeros(g_MainScene.wndCombat.layerScene)
	g_CombatSystem.combatData:execInitPassiveSkill(arg_29_0.heros)
end

function var_0_0.isLastSection(arg_30_0)
	if arg_30_0.forceType == ForceType.Right and g_CombatSystem.combatData:getTrialType() == ETrialType.LimitRoundSurvival then
		return false
	end

	return arg_30_0.curSection >= arg_30_0.maxSection
end

function var_0_0.getLiveSectionCount(arg_31_0)
	return arg_31_0.maxSection - arg_31_0.curSection + 1
end

function var_0_0.curSectionIsOver(arg_32_0)
	return arg_32_0:isAllRealDied() and g_CombatSystem.combatData.leftPlayer:isAllActionStoped() and g_CombatSystem.combatData.rightPlayer:isAllActionStoped() and arg_32_0:isLegendActionStoped()
end

function var_0_0.isOver(arg_33_0)
	if arg_33_0:isLastSection() == false then
		return false
	end

	return arg_33_0:curSectionIsOver()
end

function var_0_0.getFormationLevel(arg_34_0)
	local var_34_0 = arg_34_0.battleFormation[arg_34_0.curSection]

	if zbUtil:isValidTable(var_34_0) and zbUtil:isValidTable(var_34_0.TechDetail) then
		return var_34_0.TechDetail.Level
	end

	return 0
end

function var_0_0.clearHeroAddedProperty(arg_35_0)
	for iter_35_0, iter_35_1 in pairs(arg_35_0.heros) do
		iter_35_1:clearHeroAddedProperty()
	end
end

function var_0_0.getBigBossHitHpStat(arg_36_0)
	local var_36_0 = 0

	for iter_36_0, iter_36_1 in pairs(arg_36_0.heros) do
		var_36_0 = var_36_0 + iter_36_1.damageStat
	end

	return (math.ceil(var_36_0))
end

function var_0_0.getBigBossCurrHpPercent(arg_37_0)
	local var_37_0 = 0

	for iter_37_0, iter_37_1 in pairs(arg_37_0.heros) do
		if iter_37_1:isBigBoss() then
			var_37_0 = iter_37_1:getBigBossDamagePercent()

			break
		end
	end

	return var_37_0
end

function var_0_0.getCurrHpPercent(arg_38_0)
	return (math.round(arg_38_0:getCurTotalHp() / arg_38_0:getMaxTotalHp() * 100))
end

function var_0_0.getBuffList(arg_39_0)
	return arg_39_0.battleFormation[1].BuffList
end
