local var_0_0 = class("zbYuanzhengHandler")

var_0_0.__index = var_0_0

function createYuanzhengHandler()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	arg_2_0.formationInfo = nil
end

function var_0_0.openYuanzheng(arg_3_0)
	if zbFunHelper:isLockAndTip(EFuncType.Bgz) then
		return
	end

	g_MainScene:showYuanZhengWnd()
end

function var_0_0.updateYuanzhengInfo(arg_4_0, arg_4_1)
	if zbUtil:isValidTable(arg_4_1) then
		g_GameData.BgzInfo = arg_4_1

		g_Self.kRedPointHandler:refreshBgz()
	end
end

function var_0_0.updateFormationInfo(arg_5_0, arg_5_1)
	if zbUtil:isValidTable(arg_5_1) then
		arg_5_0.formationInfo = arg_5_1
	end
end

function var_0_0.getJiFenNotify(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(zbBgzScoreAwardTable.records) do
		if g_GameData.BgzInfo.TotalScore >= iter_6_1.score then
			local var_6_0 = true

			for iter_6_2, iter_6_3 in pairs(g_GameData.BgzInfo.ScoreAwardList) do
				if iter_6_1.score == iter_6_3.Score then
					var_6_0 = false
				end
			end

			if var_6_0 then
				return true
			end
		else
			return false
		end
	end

	return false
end
