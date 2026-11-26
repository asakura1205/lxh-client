local var_0_0 = class("zbPataHandler")

var_0_0.__index = var_0_0

function createPataHandler()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	arg_2_0.PataInfo = nil
end

function var_0_0.openPata(arg_3_0)
	if zbFunHelper:isLockAndTip(EFuncType.Pata) then
		return
	end

	g_MainScene:showPataWnd()
end

function var_0_0.updatePataInfo(arg_4_0, arg_4_1)
	if zbUtil:isValidTable(arg_4_1) then
		g_GameData.PataInfo = arg_4_1

		g_Self.kRedPointHandler:refreshBgz()
	end
end

function var_0_0.updateBaseInfo(arg_5_0, arg_5_1)
	if zbUtil:isValidTable(arg_5_1) then
		g_GameData.PataInfo.BaseInfo = arg_5_1

		g_Self.kRedPointHandler:refreshBgz()
	end
end

function var_0_0.updateFightLayerInfo(arg_6_0, arg_6_1)
	if zbUtil:isValidTable(arg_6_1) then
		g_GameData.PataInfo.FightLayerInfo = arg_6_1

		g_Self.kRedPointHandler:refreshBgz()
	end
end

function var_0_0.updateAwardLayerInfo(arg_7_0, arg_7_1)
	if zbUtil:isValidTable(arg_7_1) then
		g_GameData.PataInfo.AwardLayerInfo = arg_7_1

		g_Self.kRedPointHandler:refreshBgz()
	end
end

function var_0_0.updateBuffLayerInfo(arg_8_0, arg_8_1)
	if zbUtil:isValidTable(arg_8_1) then
		g_GameData.PataInfo.BuffLayerInfo = arg_8_1

		g_Self.kRedPointHandler:refreshBgz()
	end
end

function var_0_0.updateScoreAwardInfo(arg_9_0, arg_9_1)
	if zbUtil:isValidTable(arg_9_1) then
		g_GameData.PataInfo.ScoreAwardInfo = arg_9_1

		g_Self.kRedPointHandler:refreshBgz()
	end
end

function var_0_0.updateSaoDangInfo(arg_10_0, arg_10_1)
	if zbUtil:isValidTable(arg_10_1) then
		g_GameData.PataInfo.SaoDangInfo = arg_10_1

		g_Self.kRedPointHandler:refreshBgz()
	end
end

function var_0_0.getLayerType(arg_11_0, arg_11_1)
	local var_11_0 = zbPataLayerBaseTable:getRecord(arg_11_1)

	if var_11_0 ~= nil then
		return var_11_0.layerType
	end

	return EPataLayerType.Fight
end

function var_0_0.canReceive(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in pairs(g_GameData.PataInfo.ScoreAwardInfo.IndexList) do
		-- block empty
	end
end

function var_0_0.getJiFenNotify(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(zbPataScoreAwardTable.records) do
		if g_GameData.PataInfo.BaseInfo.TotalScore >= iter_13_1.score then
			local var_13_0 = true

			for iter_13_2, iter_13_3 in pairs(g_GameData.PataInfo.ScoreAwardInfo.IndexList) do
				if iter_13_1.score == iter_13_3.Score then
					var_13_0 = false
				end
			end

			if var_13_0 then
				return true
			end
		else
			return false
		end
	end

	return false
end
