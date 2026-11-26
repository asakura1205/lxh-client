zbCombatTest = class("zbCombatTest")
zbCombatTest.__index = zbCombatTest

function zbCombatTest.create(arg_1_0)
	local var_1_0 = zbCombatTest.new()

	var_1_0:init()

	return var_1_0
end

function zbCombatTest.init(arg_2_0)
	arg_2_0.testData = require("config.test.zbCombatTest_Data")
end

function zbCombatTest.test(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if g_MainScene.wndEmbattle ~= nil then
		g_MainScene.wndEmbattle:hide()
	end

	local var_3_0 = {}

	var_3_0.LevelType = 1
	var_3_0.LevelId = 10001
	var_3_0.ForceId = 1
	var_3_0.BattleInfo = {}
	var_3_0.BattleInfo.SelfBaseInfo = {}
	var_3_0.BattleInfo.SelfGodEquip = nil
	var_3_0.BattleInfo.MaxRound = 20
	var_3_0.BattleInfo.RandomSeed = 123456
	var_3_0.BattleInfo.SelfFormation = {}
	var_3_0.BattleInfo.SelfFormation[1] = {}
	var_3_0.BattleInfo.SelfFormation[1].TechDetail = nil
	var_3_0.BattleInfo.SelfFormation[1].BattleGod = nil
	var_3_0.BattleInfo.SelfFormation[1].HeroList = arg_3_0.testData.LeftHeroList[1].HeroList

	if var_3_0.BattleInfo.SelfFormation[1].HeroList == nil then
		echo("4444444444445555555555555555555555")

		return
	end

	var_3_0.BattleInfo.EnemyBaseInfo = {}
	var_3_0.BattleInfo.EnemyFormation = {}
	var_3_0.BattleInfo.EnemyFormation[1] = {}
	var_3_0.BattleInfo.EnemyFormation[1].TechDetail = nil
	var_3_0.BattleInfo.EnemyFormation[1].BattleGod = nil
	var_3_0.BattleInfo.EnemyFormation[1].HeroList = arg_3_0.testData.RightHeroList[1].HeroList

	if var_3_0.BattleInfo.EnemyFormation[1].HeroList == nil then
		echo("6666666666666666666666667777777777777")

		return
	end

	g_CombatSystem.combatSceneId = arg_3_2
	g_CombatSystem.combatTalkId = arg_3_3

	g_CombatSystem:startCombatTest(var_3_0)
end

function zbCombatTest.play(arg_4_0)
	arg_4_0:test(arg_4_0.testData, 14, 0)
end
