require("gamebase.zbLoadCSV")

local var_0_0 = class("zbMainTaskRecord")

var_0_0.__index = var_0_0

function createMainTaskRecord()
	return (var_0_0.new())
end

zbMainTaskTable = {}
zbMainTaskTable.records = {}

function zbMainTaskTable.load(arg_2_0, arg_2_1)
	local var_2_0 = require(arg_2_1)

	if var_2_0 == nil then
		return
	end

	if type(var_2_0) == "table" then
		for iter_2_0, iter_2_1 in pairs(var_2_0) do
			if iter_2_0 == 1 or iter_2_0 == 2 or iter_2_1[1] == "" then
				-- block empty
			else
				local var_2_1 = tonumber(iter_2_1[1])
				local var_2_2 = createMainTaskRecord()
				local var_2_3 = 1

				var_2_2.id = tonumber(iter_2_1[var_2_3])

				local var_2_4 = var_2_3 + 1

				var_2_2.preId = tonumber(iter_2_1[var_2_4])

				local var_2_5 = var_2_4 + 1

				var_2_2.type = tonumber(iter_2_1[var_2_5])

				local var_2_6 = var_2_5 + 1

				var_2_2.param1 = tonumber(iter_2_1[var_2_6])

				local var_2_7 = var_2_6 + 1

				var_2_2.param2 = tonumber(iter_2_1[var_2_7])

				local var_2_8 = var_2_7 + 1

				var_2_2.param3 = tonumber(iter_2_1[var_2_8])

				local var_2_9 = var_2_8 + 1

				var_2_2.award = iter_2_1[var_2_9]

				local var_2_10 = var_2_9 + 1

				var_2_2.linkUrl = iter_2_1[var_2_10]

				local var_2_11 = var_2_10 + 1

				arg_2_0.records[var_2_1] = var_2_2
			end
		end
	end

	return arg_2_0
end

function zbMainTaskTable.getRecord(arg_3_0, arg_3_1)
	return arg_3_0.records[arg_3_1]
end

function zbMainTaskTable.getTitleAndDesc(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:getRecord(arg_4_1)
	local var_4_1 = ""
	local var_4_2 = ""

	if var_4_0 ~= nil then
		if var_4_0.type == EMainTaskType.BuildingUpgrade then
			var_4_1 = "\xC3\xF1\xD2\xD4ʳΪ\xCC\xEC"
			var_4_2 = a2u(string.format("\xC7\xEB\xCC\xE1\xC9\xFDũ\xCC\xEF\xB5ȼ\xB6\xB5\xBD%d\xBC\xB6\xA1\xA3", var_4_0.param2))
		elseif var_4_0.type == EMainTaskType.GameLevelNormal then
			var_4_1 = "\xC6\xD5ͨ\xB9ؿ\xA8"
			var_4_2 = a2u("\xCD\xEA\xB3\xC9") .. zbForceTable:getRecordName(var_4_0.param1) .. a2u(string.format("\xB5\xDA%d\xB9\xD8\xCCַ\xA5\xA1\xA3", string.sub(var_4_0.param2, -2)))
		elseif var_4_0.type == EMainTaskType.GameLevelElite then
			var_4_1 = "\xBE\xABӢ\xCC\xF4ս"
			var_4_2 = a2u("\xCD\xEA\xB3\xC9") .. zbForceTable:getRecordName(var_4_0.param1) .. a2u(string.format("\xB5\xDA%d\xB3\xA1\xBE\xABӢ\xCC\xF4ս\xA1\xA3", string.sub(var_4_0.param2, -2) / 3))
		elseif var_4_0.type == EMainTaskType.RoleLevel then
			var_4_1 = "\xC9\xFD\xBC\xB6\xBF\xF1\xC8\xCB"
			var_4_2 = a2u(string.format("\xCD\xE6\xBC\xD2\xC9\xFD\xB5\xBD%d\xBC\xB6\xA1\xA3", var_4_0.param1))
		elseif var_4_0.type == EMainTaskType.FightValue then
			var_4_1 = "\xB8\xDFսţ\xC8\xCB"
			var_4_2 = a2u(string.format("\xB6\xD3\xCE\xE9ս\xB6\xB7\xC1\xA6\xB4ﵽ%d\xA1\xA3", var_4_0.param1))
		end
	end

	return a2u(var_4_1), var_4_2
end
