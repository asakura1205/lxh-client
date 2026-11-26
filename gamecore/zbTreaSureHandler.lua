local var_0_0 = class("zbTreaSureHandler")

var_0_0.__index = var_0_0

function createTreaSureHandler()
	local var_1_0 = var_0_0.new()

	var_1_0:init()

	return var_1_0
end

function var_0_0.init(arg_2_0)
	arg_2_0.treaSurewardList = nil
end

function var_0_0.getTreaSureInfoById(arg_3_0, arg_3_1)
	if g_GameData.TreasureInfo and zbUtil:isValidTable(g_GameData.TreasureInfo.RecordList) then
		for iter_3_0, iter_3_1 in pairs(g_GameData.TreasureInfo.RecordList) do
			if iter_3_1.ForceId == arg_3_1 then
				return iter_3_1
			end
		end
	end

	return nil
end

function var_0_0.hasRedPoint(arg_4_0, arg_4_1)
	local var_4_0 = false
	local var_4_1 = zbTreaSureTable:getRecord(arg_4_1)

	if var_4_1 and g_Self.kWarPathHandler:blevelPassed(arg_4_1, var_4_1.levelId, ELevelType.Normal) then
		local var_4_2 = zbItemTable:getMagnifierInfo()

		if var_4_2 and var_4_2.Count > 0 then
			if g_GameData.TreasureInfo and zbUtil:isValidTable(g_GameData.TreasureInfo.RecordList) then
				for iter_4_0, iter_4_1 in pairs(g_GameData.TreasureInfo.RecordList) do
					if iter_4_1.ForceId == arg_4_1 and (iter_4_1.Box1State ~= -1 or iter_4_1.Box2State ~= -1 or iter_4_1.Box3State ~= -1) then
						var_4_0 = true

						return var_4_0
					end
				end
			end

			return var_4_0
		end

		if g_GameData.TreasureInfo and zbUtil:isValidTable(g_GameData.TreasureInfo.RecordList) then
			for iter_4_2, iter_4_3 in pairs(g_GameData.TreasureInfo.RecordList) do
				if iter_4_3.ForceId == arg_4_1 and (iter_4_3.Box1State == 1 or iter_4_3.Box2State == 1 or iter_4_3.Box3State == 1) then
					var_4_0 = true

					return var_4_0
				end
			end
		end
	end

	return var_4_0
end
