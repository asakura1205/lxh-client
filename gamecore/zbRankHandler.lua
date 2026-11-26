local var_0_0 = class("zbRankHandler")

var_0_0.__index = var_0_0

function createRankHandler()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	arg_2_0.ArenaRankList = {}
	arg_2_0.LegionRankList = {}
	arg_2_0.HeroRankList = {}
	arg_2_0.FVRankData = {}
	arg_2_0.BgzRankData = {}
	arg_2_0.PataRankData = {}
	arg_2_0.HeroSoulRankData = {}
end

function var_0_0.updateArenaRankData(arg_3_0, arg_3_1)
	if zbUtil:isValidTable(arg_3_1) == false then
		echo("warning: invalid rankList")

		return
	end

	arg_3_0.ArenaRankList = arg_3_1
end

function var_0_0.updateLegionRankData(arg_4_0, arg_4_1)
	if zbUtil:isValidTable(arg_4_1) == false then
		echo("warning: invalid rankList")

		return
	end

	arg_4_0.LegionRankList = arg_4_1
end

function var_0_0.updateHeroRankData(arg_5_0, arg_5_1)
	if zbUtil:isValidTable(arg_5_1) == false then
		echo("warning: invalid rankList")

		return
	end

	arg_5_0.HeroRankList = arg_5_1
end

function var_0_0.updateCommRankData(arg_6_0, arg_6_1, arg_6_2)
	if zbUtil:isValidTable(arg_6_1) == false then
		echo("warning: invalid commRankData")

		return
	end

	if arg_6_2 == ERankType.FV then
		arg_6_0.FVRankData = arg_6_1
	elseif arg_6_2 == ERankType.Bgz then
		arg_6_0.BgzRankData = arg_6_1
	elseif arg_6_2 == ERankType.Pata then
		arg_6_0.PataRankData = arg_6_1
	elseif arg_6_2 == ERankType.HeroSoul then
		arg_6_0.HeroSoulRankData = arg_6_1

		g_MainScene:showHeroSoulRank()
	end
end
