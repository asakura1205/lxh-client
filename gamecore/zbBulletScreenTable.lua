require("gamebase.zbLoadCSV")

local var_0_0 = class("zbTaskRecord")

var_0_0.__index = var_0_0

function createBulletScreenRecord()
	return (var_0_0.new())
end

zbBulletScreenTable = {}
zbBulletScreenTable.records = {}
zbBulletScreenTable.number = 0

function zbBulletScreenTable.load(arg_2_0, arg_2_1)
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
				local var_2_2 = createBulletScreenRecord()
				local var_2_3 = 1

				var_2_2.id = tonumber(iter_2_1[var_2_3])

				local var_2_4 = var_2_3 + 1

				var_2_2.SMsg = iter_2_1[var_2_4]

				local var_2_5 = var_2_4 + 1

				var_2_2.FontColor = EBarrageFontColorType.White
				var_2_2.FontPos = zbUtil:random(1, 2)
				arg_2_0.records[var_2_1] = var_2_2
				arg_2_0.number = arg_2_0.number + 1
			end
		end
	end

	return arg_2_0
end

function zbBulletScreenTable.getRecord(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.records[arg_3_1]

	if var_3_0 == nil then
		var_3_0 = arg_3_0.records[1]
	end

	return var_3_0
end
